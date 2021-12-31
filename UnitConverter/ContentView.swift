//
//  ContentView.swift
//  UnitConverter
//
//  Created by Tamara Snyder on 12/30/21.
//
import SwiftUI

struct ContentView: View {
	private let volumeUnits = ["mL", "Liters", "Cups", "Pints", "Gallons"]
	
	@State private var inputVolume = 0.0
	@State private var inputVolumeUnit = "mL"
	@State private var outputVolumeUnit = "mL"
	@FocusState private var inputIsFocused: Bool
	
	var outputVolume: Double {
		switch outputVolumeUnit {
		case "mL":
			return toMilliliters()
		case "Liters":
			return toLiters()
		case "Cups":
			return toCups()
		case "Pints":
			return toPints()
		case "Gallons":
			return toGallons()
		default:
			return toMilliliters()
		}
	}
	
	func toMilliliters() -> Double {
		switch inputVolumeUnit {
		case "mL":
			return inputVolume
		case "Liters":
			return inputVolume * 1000
		case "Cups":
			return inputVolume * 236.588
		case "Pints":
			return inputVolume * 473.176
		case "Gallons":
			return inputVolume * 3785.41
		default:
			return inputVolume
		}
	}
	
	func toLiters() -> Double {
		return toMilliliters() / 1000
	}
	
	func toCups() -> Double {
		return toMilliliters()	/ 236.588
	}
	
	func toPints() -> Double {
		return toMilliliters()	/ 473.176
	}
	
	func toGallons() -> Double {
		return toMilliliters()	/ 3785.41
	}
	
	var body: some View {
		NavigationView {
			Form {
				Section(header: Text("Input volume")) {
					TextField("Volume", value: $inputVolume, format: .number)
						.keyboardType(.decimalPad)
						.focused($inputIsFocused)
				}
				
				Section(header: Text("Input unit")) {
					Picker("Volume unit: ", selection: $inputVolumeUnit) {
						ForEach(volumeUnits, id: \.self) {
							Text($0)
						}
					}
					.pickerStyle(.segmented)
				}

				Divider()
				
				Section(header: Text("Output unit")) {
					Picker("Volume unit: ", selection: $outputVolumeUnit) {
						ForEach(volumeUnits, id: \.self) {
							Text($0)
						}
					}
					.pickerStyle(.segmented)
				}
				
				Section(header: Text("Output volume")) {
					Text(outputVolume, format: .number)
				}
			}
		}
		.navigationTitle("Volume Converter")
		.toolbar {
			ToolbarItemGroup(placement: .keyboard) {
				Button("Done") {
					inputIsFocused = false
				}
			}
		}
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
