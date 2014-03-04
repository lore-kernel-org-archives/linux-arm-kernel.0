From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Tue,  4 Mar 2014 08:42:29 -0800
Subject: [PATCH v2 2/2] ARM: zynq: dt: Add I2C nodes to Zynq device tree
In-Reply-To: <1393951349-24548-1-git-send-email-soren.brinkmann@xilinx.com>
References: <1393951349-24548-1-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <1393951349-24548-2-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
---
v2:
 - replace 'pmbus' with 'ti' in compatibility strings of UCD devices
---
 arch/arm/boot/dts/zynq-7000.dtsi | 22 ++++++++++++
 arch/arm/boot/dts/zynq-zc702.dts | 76 ++++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/zynq-zc706.dts | 68 +++++++++++++++++++++++++++++++++++
 3 files changed, 166 insertions(+)

diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/zynq-7000.dtsi
index 8b67b19392ec..fb1e1e7cae8f 100644
--- a/arch/arm/boot/dts/zynq-7000.dtsi
+++ b/arch/arm/boot/dts/zynq-7000.dtsi
@@ -48,6 +48,28 @@
 		interrupt-parent = <&intc>;
 		ranges;
 
+		i2c0: zynq-i2c at e0004000 {
+			compatible = "cdns,i2c-r1p10";
+			status = "disabled";
+			clocks = <&clkc 38>;
+			interrupt-parent = <&intc>;
+			interrupts = <0 25 4>;
+			reg = <0xE0004000 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c1: zynq-i2c at e0005000 {
+			compatible = "cdns,i2c-r1p10";
+			status = "disabled";
+			clocks = <&clkc 39>;
+			interrupt-parent = <&intc>;
+			interrupts = <0 48 4>;
+			reg = <0xE0005000 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
 		intc: interrupt-controller at f8f01000 {
 			compatible = "arm,cortex-a9-gic";
 			#interrupt-cells = <3>;
diff --git a/arch/arm/boot/dts/zynq-zc702.dts b/arch/arm/boot/dts/zynq-zc702.dts
index c913f77a21eb..5e09cee33d42 100644
--- a/arch/arm/boot/dts/zynq-zc702.dts
+++ b/arch/arm/boot/dts/zynq-zc702.dts
@@ -34,6 +34,82 @@
 	phy-mode = "rgmii";
 };
 
+&i2c0 {
+	status = "okay";
+	clock-frequency = <400000>;
+
+	i2cswitch at 74 {
+		compatible = "nxp,pca9548";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x74>;
+
+		i2c at 0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+			si570: clock-generator at 5d {
+				#clock-cells = <0>;
+				compatible = "silabs,si570";
+				temperature-stability = <50>;
+				reg = <0x5d>;
+				factory-fout = <156250000>;
+				clock-frequency = <148500000>;
+			};
+		};
+
+		i2c at 2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+			eeprom at 54 {
+				compatible = "at,24c08";
+				reg = <0x54>;
+			};
+		};
+
+		i2c at 3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+			gpio at 21 {
+				compatible = "ti,tca6416";
+				reg = <0x21>;
+				gpio-controller;
+				#gpio-cells = <2>;
+			};
+		};
+
+		i2c at 4 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <4>;
+			rtc at 51 {
+				compatible = "nxp,pcf8563";
+				reg = <0x51>;
+			};
+		};
+
+		i2c at 7 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <7>;
+			hwmon at 52 {
+				compatible = "ti,ucd9248";
+				reg = <52>;
+			};
+			hwmon at 53 {
+				compatible = "ti,ucd9248";
+				reg = <53>;
+			};
+			hwmon at 54 {
+				compatible = "ti,ucd9248";
+				reg = <54>;
+			};
+		};
+	};
+};
+
 &sdhci0 {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/zynq-zc706.dts b/arch/arm/boot/dts/zynq-zc706.dts
index 88f62c50382e..4cc9913078cd 100644
--- a/arch/arm/boot/dts/zynq-zc706.dts
+++ b/arch/arm/boot/dts/zynq-zc706.dts
@@ -35,6 +35,74 @@
 	phy-mode = "rgmii";
 };
 
+&i2c0 {
+	status = "okay";
+	clock-frequency = <400000>;
+
+	i2cswitch at 74 {
+		compatible = "nxp,pca9548";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x74>;
+
+		i2c at 0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+			si570: clock-generator at 5d {
+				#clock-cells = <0>;
+				compatible = "silabs,si570";
+				temperature-stability = <50>;
+				reg = <0x5d>;
+				factory-fout = <156250000>;
+				clock-frequency = <148500000>;
+			};
+		};
+
+		i2c at 2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+			eeprom at 54 {
+				compatible = "at,24c08";
+				reg = <0x54>;
+			};
+		};
+
+		i2c at 3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+			gpio at 21 {
+				compatible = "ti,tca6416";
+				reg = <0x21>;
+				gpio-controller;
+				#gpio-cells = <2>;
+			};
+		};
+
+		i2c at 4 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <4>;
+			rtc at 51 {
+				compatible = "nxp,pcf8563";
+				reg = <0x51>;
+			};
+		};
+
+		i2c at 7 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <7>;
+			ucd90120 at 65 {
+				compatible = "ti,ucd90120";
+				reg = <0x65>;
+			};
+		};
+	};
+};
+
 &sdhci0 {
 	status = "okay";
 };
-- 
1.9.0.1.g4196000
