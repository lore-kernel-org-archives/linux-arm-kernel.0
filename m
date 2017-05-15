From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 15 May 2017 09:50:34 +0200
Subject: [PATCH 2/2] ARM: dts: add core I2C devices to the APQ8060 Dragonboard
Message-ID: <20170515075034.3753-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The APQ8060 Dragonboard has an Atmel AT24c128 EEPROM and a
Wolfson Micro WM8903 codec connected to its GSBI8 I2C bus.
Add entries for these to the device tree. The interrupt line
from the WM8903 chip is not routed anywhere on this design
so it can not be used.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/qcom-apq8060-dragonboard.dts | 49 ++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8060-dragonboard.dts b/arch/arm/boot/dts/qcom-apq8060-dragonboard.dts
index 2da1413f5720..32730c4742f6 100644
--- a/arch/arm/boot/dts/qcom-apq8060-dragonboard.dts
+++ b/arch/arm/boot/dts/qcom-apq8060-dragonboard.dts
@@ -160,6 +160,19 @@
 				};
 			};
 
+			dragon_gsbi8_i2c_pins: gsbi8_i2c {
+				mux {
+					pins = "gpio64", "gpio65";
+					function = "gsbi8";
+				};
+				pinconf {
+					pins = "gpio64", "gpio65";
+					drive-strength = <16>;
+					/* These have external pull-up 2.2kOhm to 1.8V */
+					bias-disable;
+				};
+			};
+
 			dragon_gsbi12_i2c_pins: gsbi12_i2c {
 				mux {
 					pins = "gpio115", "gpio116";
@@ -368,6 +381,42 @@
 			};
 		};
 
+		gsbi at 19800000 {
+			status = "ok";
+			qcom,mode = <GSBI_PROT_I2C>;
+
+			i2c at 19880000 {
+				status = "ok";
+				pinctrl-names = "default";
+				pinctrl-0 = <&dragon_gsbi8_i2c_pins>;
+
+				eeprom at 52 {
+					/* A 16KiB Platform ID EEPROM on the CPU carrier board */
+					compatible = "atmel,24c128";
+					reg = <0x52>;
+					vcc-supply = <&pm8058_s3>;
+					pagesize = <64>;
+				};
+				wm8903: wm8903 at 1a {
+					/* This Woolfson Micro device has an unrouted interrupt line */
+					compatible = "wlf,wm8903";
+					reg = <0x1a>;
+
+					AVDD-supply = <&pm8058_l16>;
+					CPVDD-supply = <&pm8058_l16>;
+					DBVDD-supply = <&pm8058_s3>;
+					DCVDD-supply = <&pm8058_l0>;
+
+					gpio-controller;
+					#gpio-cells = <2>;
+
+					micdet-cfg = <0>;
+					micdet-delay = <100>;
+					gpio-cfg = <0xffffffff 0xffffffff 0 0xffffffff 0xffffffff>;
+				};
+			};
+		};
+
 		gsbi at 19c00000 {
 			status = "ok";
 			qcom,mode = <GSBI_PROT_I2C_UART>;
-- 
2.9.3
