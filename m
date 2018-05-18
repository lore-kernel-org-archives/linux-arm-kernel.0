From: aford173@gmail.com (Adam Ford)
Date: Thu, 17 May 2018 19:49:10 -0500
Subject: [PATCH V4] ARM: dts: da850-evm: Enable LCD and Backlight
Message-ID: <20180518004910.28335-1-aford173@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When using the board files the LCD works, but not with the DT.
This adds enables the original da850-evm to work with the same
LCD in device tree mode.

The EVM has a gpio for the regulator and a PWM for dimming the
backlight.  The LCD and the vpif display pins are mutually
exclusive, so if using the LCD, do not load the vpif driver.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
V4:  Move the backlight to PWM, so the driver can control the regulator allowing the 
     regulator to power down and enabling the ability to change the brightness of the
     backlight

V3:  Fix errant GPIO, label GPIO pins, and rename the regulator to be more explict to
     backlight which better matches the schematic.  Updated the description to explain
     that it cannot be used at the same time as the vpif driver.

V2:  Add regulator and GPIO enable pins. Remove PWM backlight and replace with GPIO  

diff --git a/arch/arm/boot/dts/da850-evm.dts b/arch/arm/boot/dts/da850-evm.dts
index f6a5497d9c97..7be31372bbc2 100644
--- a/arch/arm/boot/dts/da850-evm.dts
+++ b/arch/arm/boot/dts/da850-evm.dts
@@ -27,9 +27,14 @@
 		spi0 = &spi1;
 	};
 
-	backlight {
-		compatible = "gpio-backlight";
-		gpios = <&gpio 7 GPIO_ACTIVE_HIGH>; /* lcd_pwm0 */
+	backlight:backlight-pwm {
+		pinctrl-names = "default";
+		pinctrl-0 = <&ecap2_pins>;
+		power-supply = <&backlight_reg>;
+		compatible = "pwm-backlight";
+		pwms = <&ecap2 0 50000 0>;
+		brightness-levels = <0 10 20 30 40 50 60 70 80 90 99>;
+		default-brightness-level = <7>;
 	};
 
 	panel {
@@ -88,7 +93,6 @@
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
 		gpio = <&gpio 47 GPIO_ACTIVE_HIGH>; /* lcd_backlight_pwr */
-		regulator-always-on;
 		enable-active-high;
 	};
 
@@ -120,6 +124,10 @@
 	};
 };
 
+&ecap2 {
+	status = "okay";
+};
+
 &pmx_core {
 	status = "okay";
 
-- 
2.17.0
