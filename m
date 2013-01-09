From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Wed,  9 Jan 2013 21:43:12 +0100
Subject: [PATCH 12/14] ARM: tegra: tec: Add PCIe support
In-Reply-To: <1357764194-12677-1-git-send-email-thierry.reding@avionic-design.de>
References: <1357764194-12677-1-git-send-email-thierry.reding@avionic-design.de>
Message-ID: <1357764194-12677-13-git-send-email-thierry.reding@avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the first PCIe root port which is connected to an FPGA on the
Tamonten Evaluation Carrier and add device nodes for each of the PCI
endpoints available in the standard configuration.

Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
---
 arch/arm/boot/dts/tegra20-tec.dts | 198 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 198 insertions(+)

diff --git a/arch/arm/boot/dts/tegra20-tec.dts b/arch/arm/boot/dts/tegra20-tec.dts
index 25f70ee..b75f979 100644
--- a/arch/arm/boot/dts/tegra20-tec.dts
+++ b/arch/arm/boot/dts/tegra20-tec.dts
@@ -60,6 +60,204 @@
 		};
 	};
 
+	pcie-controller {
+		vdd-supply = <&pci_vdd_reg>;
+		pex-clk-supply = <&pci_clk_reg>;
+		status = "okay";
+
+		pci at 1,0 {
+			bus-range = <0x01 0x0a>;
+			status = "okay";
+
+			pci at 0,0 {
+				reg = <0x010000 0 0 0 0>;
+				bus-range = <0x02 0x0a>;
+
+				compatible = "plda,pcie";
+				device_type = "pci";
+
+				#address-cells = <3>;
+				#size-cells = <2>;
+
+				pci at 0,0 {
+					reg = <0x020000 0 0 0 0>;
+					bus-range = <0x03 0x03>;
+
+					compatible = "ad,pcie";
+					device_type = "pci";
+
+					#address-cells = <3>;
+					#size-cells = <2>;
+
+					pci-test-ep at 0,0 {
+						compatible = "ad,pcietest";
+						reg = <0x030000 0 0 0 0>;
+					};
+				};
+
+				pci at 1,0 {
+					reg = <0x020800 0 0 0 0>;
+					bus-range = <0x04 0x04>;
+
+					compatible = "ad,pcie";
+					device_type = "pci";
+
+					#address-cells = <3>;
+					#size-cells = <2>;
+
+					pci at 0,0 {
+						compatible = "opencores,spi";
+						reg = <0x040000 0 0 0 0>;
+
+						#address-cells = <1>;
+						#size-cells = <0>;
+
+						clock-frequency = <66000000>;
+
+						m25p80 at 0 {
+							compatible = "m25p80";
+							reg = <0>;
+
+							spi-max-frequency = <25000000>;
+
+							#address-cells = <1>;
+							#size-cells = <1>;
+
+							partition at 0 {
+								reg = <0x00000000 0x00400000>;
+								label = "FPGA";
+							};
+
+							partition at 400000 {
+								reg = <0x00400000 0x00400000>;
+								label = "FPGA (gold)";
+								read-only;
+							};
+						};
+					};
+				};
+
+				pci at 2,0 {
+					reg = <0x021000 0 0 0 0>;
+					bus-range = <0x05 0x05>;
+
+					compatible = "ad,pcie";
+					device_type = "pci";
+
+					#address-cells = <3>;
+					#size-cells = <2>;
+
+					pci-i2c-ep at 0,0 {
+						compatible = "opencores,i2c";
+						reg = <0x050000 0 0 0 0>;
+
+						clock-frequency = <66000000>;
+						reg-io-width = <4>;
+						reg-shift = <3>;
+					};
+				};
+
+				pci at 3,0 {
+					reg = <0x021800 0 0 0 0>;
+					bus-range = <0x06 0x06>;
+
+					compatible = "ad,pcie";
+					device_type = "pci";
+
+					#address-cells = <3>;
+					#size-cells = <2>;
+
+					pci at 0,0 {
+						compatible = "ad,gpio-ad64p";
+						reg = <0x060000 0 0 0 0>;
+
+						gpio-controller;
+						#gpio-cells = <2>;
+
+						interrupt-controller;
+						#interrupt-cells = <2>;
+					};
+				};
+
+				pci at 4,0 {
+					reg = <0x022000 0 0 0 0>;
+					bus-range = <0x07 0x07>;
+
+					compatible = "ad,pcie";
+					device_type = "pci";
+
+					#address-cells = <3>;
+					#size-cells = <2>;
+
+					pci at 0,0 {
+						compatible = "opencores,uart";
+						reg = <0x070000 0 0 0 0>;
+					};
+				};
+
+				pci at 5,0 {
+					reg = <0x022800 0 0 0 0>;
+					bus-range = <0x08 0x08>;
+
+					compatible = "ad,pcie";
+					device_type = "pci";
+
+					#address-cells = <3>;
+					#size-cells = <2>;
+
+					pci at 0,0 {
+						compatible = "opencores,ethmac";
+						reg = <0x080000 0 0 0 0>;
+					};
+				};
+
+				pci at 6,0 {
+					reg = <0x023000 0 0 0 0>;
+					bus-range = <0x09 0x09>;
+
+					compatible = "ad,pcie";
+					device_type = "pci";
+
+					#address-cells = <3>;
+					#size-cells = <2>;
+
+					pci at 0,0 {
+						compatible = "opencores,can";
+						reg = <0x090000 0 0 0 0>;
+					};
+				};
+
+				pci at 7,0 {
+					reg = <0x023800 0 0 0 0>;
+					bus-range = <0x0a 0x0a>;
+
+					compatible = "ad,pcie";
+					device_type = "pci";
+
+					#address-cells = <3>;
+					#size-cells = <2>;
+
+					pci at 0,0 {
+						compatible = "opencores,can";
+						reg = <0x0a0000 0 0 0 0>;
+					};
+				};
+			};
+		};
+	};
+
+	regulators {
+		pci_vdd_reg: regulator at 1 {
+			compatible = "regulator-fixed";
+			reg = <1>;
+			regulator-name = "vdd_1v05";
+			regulator-min-microvolt = <1050000>;
+			regulator-max-microvolt = <1050000>;
+			gpio = <&pmic 2 0>;
+			enable-active-high;
+		};
+	};
+
 	sound {
 		compatible = "ad,tegra-audio-wm8903-tec",
 			     "nvidia,tegra-audio-wm8903";
-- 
1.8.1
