From: mhei@heimpold.de (Michael Heimpold)
Date: Sun, 22 Jan 2017 23:22:39 +0100
Subject: [PATCH v2 4/9] ARM: dts: imx28-duckbill: enable spi, i2c and uart pins
In-Reply-To: <1485123764-14754-1-git-send-email-mhei@heimpold.de>
References: <1485123764-14754-1-git-send-email-mhei@heimpold.de>
Message-ID: <1485123764-14754-5-git-send-email-mhei@heimpold.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While at tweak some more settings for the default product:
- enable lradc
- adjust USB dr mode
- add default triggers for LEDs
- get rid of regulators simple-bus container
- adjust phy reset duration

Signed-off-by: Michael Heimpold <mhei@heimpold.de>
---
 arch/arm/boot/dts/imx28-duckbill.dts | 81 +++++++++++++++++++++++++-----------
 1 file changed, 56 insertions(+), 25 deletions(-)

diff --git a/arch/arm/boot/dts/imx28-duckbill.dts b/arch/arm/boot/dts/imx28-duckbill.dts
index ce1a7ef..3e4385d 100644
--- a/arch/arm/boot/dts/imx28-duckbill.dts
+++ b/arch/arm/boot/dts/imx28-duckbill.dts
@@ -1,5 +1,6 @@
 /*
- * Copyright (C) 2013 Michael Heimpold <mhei@heimpold.de>
+ * Copyright (C) 2013-2014,2016 Michael Heimpold <mhei@heimpold.de>
+ * Copyright (C) 2015-2017 I2SE GmbH <info@i2se.com>
  *
  * The code contained herein is licensed under the GNU General Public
  * License. You may obtain a copy of the GNU General Public License
@@ -10,6 +11,7 @@
  */
 
 /dts-v1/;
+#include <dt-bindings/gpio/gpio.h>
 #include "imx28.dtsi"
 
 / {
@@ -32,6 +34,13 @@
 				status = "okay";
 			};
 
+			ssp2: ssp at 80014000 {
+				compatible = "fsl,imx28-spi";
+				pinctrl-names = "default";
+				pinctrl-0 = <&spi2_pins_a>;
+				status = "okay";
+			};
+
 			pinctrl at 80018000 {
 				pinctrl-names = "default";
 				pinctrl-0 = <&hog_pins_a>;
@@ -39,14 +48,24 @@
 				hog_pins_a: hog at 0 {
 					reg = <0>;
 					fsl,pinmux-ids = <
-						MX28_PAD_SSP0_DATA7__GPIO_2_7 /* PHY Reset */
+						MX28_PAD_LCD_D17__GPIO_1_17    /* Revision detection */
+					>;
+					fsl,drive-strength = <MXS_DRIVE_4mA>;
+					fsl,voltage = <MXS_VOLTAGE_HIGH>;
+					fsl,pull-up = <MXS_PULL_DISABLE>;
+				};
+
+				mac0_phy_reset_pin: mac0-phy-reset at 0 {
+					reg = <0>;
+					fsl,pinmux-ids = <
+						MX28_PAD_SSP0_DATA7__GPIO_2_7    /* PHY Reset */
 					>;
 					fsl,drive-strength = <MXS_DRIVE_4mA>;
 					fsl,voltage = <MXS_VOLTAGE_HIGH>;
 					fsl,pull-up = <MXS_PULL_DISABLE>;
 				};
 
-				led_pins_a: led_gpio at 0 {
+				led_pins: leds at 0 {
 					reg = <0>;
 					fsl,pinmux-ids = <
 						MX28_PAD_AUART1_RX__GPIO_3_4
@@ -60,6 +79,22 @@
 		};
 
 		apbx at 80040000 {
+			lradc at 80050000 {
+				status = "okay";
+			};
+
+			i2c0: i2c@80058000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&i2c0_pins_a>;
+				status = "okay";
+			};
+
+			auart0: serial at 8006a000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&auart0_2pins_a>;
+				status = "okay";
+			};
+
 			duart: serial at 80074000 {
 				pinctrl-names = "default";
 				pinctrl-0 = <&duart_pins_a>;
@@ -75,47 +110,43 @@
 	ahb at 80080000 {
 		usb0: usb at 80080000 {
 			status = "okay";
+			dr_mode = "peripheral";
 		};
 
 		mac0: ethernet at 800f0000 {
 			phy-mode = "rmii";
 			pinctrl-names = "default";
-			pinctrl-0 = <&mac0_pins_a>;
+			pinctrl-0 = <&mac0_pins_a>, <&mac0_phy_reset_pin>;
 			phy-supply = <&reg_3p3v>;
 			phy-reset-gpios = <&gpio2 7 GPIO_ACTIVE_LOW>;
-			phy-reset-duration = <100>;
+			phy-reset-duration = <25>;
 			status = "okay";
 		};
 	};
 
-	regulators {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		reg_3p3v: regulator at 0 {
-			compatible = "regulator-fixed";
-			reg = <0>;
-			regulator-name = "3P3V";
-			regulator-min-microvolt = <3300000>;
-			regulator-max-microvolt = <3300000>;
-			regulator-always-on;
-		};
+	reg_3p3v: regulator-3p3v {
+		compatible = "regulator-fixed";
+		regulator-name = "3P3V";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
 	};
 
 	leds {
 		compatible = "gpio-leds";
 		pinctrl-names = "default";
-		pinctrl-0 = <&led_pins_a>;
+		pinctrl-0 = <&led_pins>;
 
-		status {
-			label = "duckbill:green:status";
-			gpios = <&gpio3 5 GPIO_ACTIVE_HIGH>;
-		};
-
-		failure {
+		status-red {
 			label = "duckbill:red:status";
 			gpios = <&gpio3 4 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "default-on";
+		};
+
+		status-green {
+			label = "duckbill:green:status";
+			gpios = <&gpio3 5 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
 		};
 	};
 };
-- 
2.7.4
