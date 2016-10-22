From: mhei@heimpold.de (Michael Heimpold)
Date: Sat, 22 Oct 2016 21:22:28 +0200
Subject: [PATCH 5/7] ARM: dts: duckbill: simplify DT and use common definitions
In-Reply-To: <1477164150-13553-1-git-send-email-mhei@heimpold.de>
References: <1477164150-13553-1-git-send-email-mhei@heimpold.de>
Message-ID: <1477164150-13553-6-git-send-email-mhei@heimpold.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Michael Heimpold <mhei@heimpold.de>
---
 arch/arm/boot/dts/imx28-duckbill.dts | 99 ++++--------------------------------
 1 file changed, 11 insertions(+), 88 deletions(-)

diff --git a/arch/arm/boot/dts/imx28-duckbill.dts b/arch/arm/boot/dts/imx28-duckbill.dts
index ce1a7ef..c3d1ce1 100644
--- a/arch/arm/boot/dts/imx28-duckbill.dts
+++ b/arch/arm/boot/dts/imx28-duckbill.dts
@@ -1,5 +1,6 @@
 /*
- * Copyright (C) 2013 Michael Heimpold <mhei@heimpold.de>
+ * Copyright (C) 2013-2014,2016 Michael Heimpold <mhei@heimpold.de>
+ * Copyright (C) 2015 I2SE GmbH <info@i2se.com>
  *
  * The code contained herein is licensed under the GNU General Public
  * License. You may obtain a copy of the GNU General Public License
@@ -10,112 +11,34 @@
  */
 
 /dts-v1/;
-#include "imx28.dtsi"
+#include "imx28-duckbill-common.dtsi"
 
 / {
 	model = "I2SE Duckbill";
 	compatible = "i2se,duckbill", "fsl,imx28";
 
-	memory {
-		reg = <0x40000000 0x08000000>;
-	};
-
 	apb at 80000000 {
 		apbh at 80000000 {
-			ssp0: ssp at 80010000 {
-				compatible = "fsl,imx28-mmc";
+			ssp2: ssp at 80014000 {
+				compatible = "fsl,imx28-spi";
 				pinctrl-names = "default";
-				pinctrl-0 = <&mmc0_4bit_pins_a
-					&mmc0_cd_cfg &mmc0_sck_cfg>;
-				bus-width = <4>;
-				vmmc-supply = <&reg_3p3v>;
+				pinctrl-0 = <&spi2_pins_a>;
 				status = "okay";
 			};
-
-			pinctrl at 80018000 {
-				pinctrl-names = "default";
-				pinctrl-0 = <&hog_pins_a>;
-
-				hog_pins_a: hog at 0 {
-					reg = <0>;
-					fsl,pinmux-ids = <
-						MX28_PAD_SSP0_DATA7__GPIO_2_7 /* PHY Reset */
-					>;
-					fsl,drive-strength = <MXS_DRIVE_4mA>;
-					fsl,voltage = <MXS_VOLTAGE_HIGH>;
-					fsl,pull-up = <MXS_PULL_DISABLE>;
-				};
-
-				led_pins_a: led_gpio at 0 {
-					reg = <0>;
-					fsl,pinmux-ids = <
-						MX28_PAD_AUART1_RX__GPIO_3_4
-						MX28_PAD_AUART1_TX__GPIO_3_5
-					>;
-					fsl,drive-strength = <MXS_DRIVE_4mA>;
-					fsl,voltage = <MXS_VOLTAGE_HIGH>;
-					fsl,pull-up = <MXS_PULL_DISABLE>;
-				};
-			};
 		};
 
 		apbx at 80040000 {
-			duart: serial at 80074000 {
+			i2c0: i2c at 80058000 {
 				pinctrl-names = "default";
-				pinctrl-0 = <&duart_pins_a>;
+				pinctrl-0 = <&i2c0_pins_a>;
 				status = "okay";
 			};
 
-			usbphy0: usbphy at 8007c000 {
+			auart0: serial at 8006a000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&auart0_2pins_a>;
 				status = "okay";
 			};
 		};
 	};
-
-	ahb at 80080000 {
-		usb0: usb at 80080000 {
-			status = "okay";
-		};
-
-		mac0: ethernet at 800f0000 {
-			phy-mode = "rmii";
-			pinctrl-names = "default";
-			pinctrl-0 = <&mac0_pins_a>;
-			phy-supply = <&reg_3p3v>;
-			phy-reset-gpios = <&gpio2 7 GPIO_ACTIVE_LOW>;
-			phy-reset-duration = <100>;
-			status = "okay";
-		};
-	};
-
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
-	};
-
-	leds {
-		compatible = "gpio-leds";
-		pinctrl-names = "default";
-		pinctrl-0 = <&led_pins_a>;
-
-		status {
-			label = "duckbill:green:status";
-			gpios = <&gpio3 5 GPIO_ACTIVE_HIGH>;
-		};
-
-		failure {
-			label = "duckbill:red:status";
-			gpios = <&gpio3 4 GPIO_ACTIVE_HIGH>;
-		};
-	};
 };
-- 
2.7.4
