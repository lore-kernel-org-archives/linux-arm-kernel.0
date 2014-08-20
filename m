From: kiran.padwal@smartplayin.com (Kiran Padwal)
Date: Wed, 20 Aug 2014 17:32:13 +0530
Subject: [PATCH v2] ARM: apq8064: Add pinmux and i2c pinctrl nodes
Message-ID: <1408536133-13824-1-git-send-email-kiran.padwal@smartplayin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds pinmux and i2c pinctrl DT node for IFC6410 board.
It also adds necessary DT support for i2c eeprom which is present on
IFC6410.

Tested on IFC6410 board.

Signed-off-by: Kiran Padwal <kiran.padwal@smartplayin.com>
---
Chages since v1:
	- Renamed pinmux phandle "qcom_pinmux" to "tlmm_pinmux".
	- Updated pinmux interrupt.

 arch/arm/boot/dts/qcom-apq8064-ifc6410.dts |   29 ++++++++++++++
 arch/arm/boot/dts/qcom-apq8064.dtsi        |   59 ++++++++++++++++++++++++++++
 2 files changed, 88 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts b/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
index 7c2441d..d52ac3c 100644
--- a/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
+++ b/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
@@ -5,6 +5,15 @@
 	compatible = "qcom,apq8064-ifc6410", "qcom,apq8064";
 
 	soc {
+		pinmux at 800000 {
+			i2c1_pins: i2c1_pinmux {
+				mux {
+					pins = "gpio20", "gpio21";
+					function = "gsbi1";
+				};
+			};
+		};
+
 		gsbi at 16600000 {
 			status = "ok";
 			qcom,mode = <GSBI_PROT_I2C_UART>;
@@ -12,5 +21,25 @@
 				status = "ok";
 			};
 		};
+
+		gsbi1: gsbi at 12440000 {
+			qcom,mode = <GSBI_PROT_I2C>;
+			status = "ok";
+
+			i2c1: i2c at 12460000 {
+				status = "ok";
+
+				clock-frequency = <200000>;
+
+				pinctrl-0 = <&i2c1_pins>;
+				pinctrl-names = "default";
+
+				eeprom: eeprom at 52 {
+					compatible = "atmel,24c128";
+					reg = <0x52>;
+					pagesize = <32>;
+				};
+			};
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
index 92bf793..bb2ccde 100644
--- a/arch/arm/boot/dts/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
@@ -70,6 +70,17 @@
 		ranges;
 		compatible = "simple-bus";
 
+		tlmm_pinmux: pinmux at 800000 {
+			compatible = "qcom,apq8064-pinctrl";
+			reg = <0x800000 0x4000>;
+
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			interrupts = <0 16 0x4>;
+		};
+
 		intc: interrupt-controller at 2000000 {
 			compatible = "qcom,msm-qgic2";
 			interrupt-controller;
@@ -133,6 +144,54 @@
 			regulator;
 		};
 
+		gsbi1: gsbi at 12440000 {
+			compatible = "qcom,gsbi-v1.0.0";
+			reg = <0x12440000 0x100>;
+			clocks = <&gcc GSBI1_H_CLK>;
+			clock-names = "iface";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+			status = "disabled";
+
+			i2c at 12460000 {
+				compatible = "qcom,i2c-qup-v1.1.1";
+				reg = <0x12460000 0x1000>;
+				interrupts = <0 194 0>;
+
+				clocks = <&gcc GSBI1_QUP_CLK>, <&gcc GSBI1_H_CLK>;
+				clock-names = "core", "iface";
+				status = "disabled";
+
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+		};
+
+		gsbi2: gsbi at 12480000 {
+			compatible = "qcom,gsbi-v1.0.0";
+			reg = <0x12480000 0x100>;
+			clocks = <&gcc GSBI2_H_CLK>;
+			clock-names = "iface";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+			status = "disabled";
+
+			i2c at 124a0000 {
+				compatible = "qcom,i2c-qup-v1.1.1";
+				reg = <0x124a0000 0x1000>;
+				interrupts = <0 196 0>;
+
+				clocks = <&gcc GSBI2_QUP_CLK>, <&gcc GSBI2_H_CLK>;
+				clock-names = "core", "iface";
+				status = "disabled";
+
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+		};
+
 		gsbi7: gsbi at 16600000 {
 			status = "disabled";
 			compatible = "qcom,gsbi-v1.0.0";
-- 
1.7.9.5
