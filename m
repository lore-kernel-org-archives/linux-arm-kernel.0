From: plaes@plaes.org (Priit Laes)
Date: Sat, 11 Feb 2017 19:44:05 +0200
Subject: [PATCH 8/8] ARM: dts: sun4i: gemei-g9: Add LVDS display support
In-Reply-To: <20170211174405.28395-1-plaes@plaes.org>
References: <20170211174405.28395-1-plaes@plaes.org>
Message-ID: <20170211174405.28395-9-plaes@plaes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Priit Laes <plaes@plaes.org>
---
 arch/arm/boot/dts/sun4i-a10-gemei-g9.dts | 95 +++++++++++++++++++++++++++++---
 1 file changed, 86 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/sun4i-a10-gemei-g9.dts b/arch/arm/boot/dts/sun4i-a10-gemei-g9.dts
index 9616cde..c19f906 100644
--- a/arch/arm/boot/dts/sun4i-a10-gemei-g9.dts
+++ b/arch/arm/boot/dts/sun4i-a10-gemei-g9.dts
@@ -1,5 +1,5 @@
 /*
- * Copyright 2015 Priit Laes
+ * Copyright 2015-2017 Priit Laes
  *
  * Priit Laes <plaes@plaes.org>
  *
@@ -48,28 +48,69 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/pwm/pwm.h>
 
 / {
 	model = "Gemei G9 Tablet";
 	compatible = "gemei,g9", "allwinner,sun4i-a10";
 
+	/*
+	 * TODO:
+	 *   2x cameras via CSI
+	 *   AXP battery management
+	 *   NAND
+	 *   OTG
+	 *   Touchscreen - gt801_2plus1 @ i2c adapter 2 @ 0x48
+	 *   HDMI output
+	 */
+
 	aliases {
 		serial0 = &uart0;
 	};
 
+	backlight: backlight {
+		compatible = "pwm-backlight";
+		pinctrl-names = "default";
+		pinctrl-0 = <&lcd_backlight_pin>;
+		/* TODO: Figure out proper parameters */
+		pwms = <&pwm 0 50000 PWM_POLARITY_INVERTED>;
+		brightness-levels = <0 10 20 30 40 50 60 70 80 90 100>;
+		enable-gpios = <&pio 7 7 GPIO_ACTIVE_HIGH>; /* PH7 */
+		default-brightness-level = <8>;
+	};
+
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
+
+	panel: panel {
+		compatible = "lg,lp097x02-slq2";
+		pinctrl-names = "default";
+		pinctrl-0 = <&lcd_enable_pin &lcd_lvds0_pins>;
+		enable-gpios = <&pio 7 8 GPIO_ACTIVE_HIGH>; /* PH8 */
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		port {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			panel_input: endpoint {
+				remote-endpoint = <&tcon0_out_panel>;
+			};
+		};
+	};
+
+	display-engine {
+		compatible = "allwinner,sun5i-a13-display-engine";
+		allwinner,pipelines = <&fe0>;
+	};
+};
+
+&be0 {
+	status = "okay";
 };
 
-/*
- * TODO:
- *   2x cameras via CSI
- *   AXP battery management
- *   NAND
- *   OTG
- *   Touchscreen - gt801_2plus1 @ i2c adapter 2 @ 0x48
- */
 &codec {
 	/* PH15 controls power to external amplifier (ft2012q) */
 	pinctrl-names = "default";
@@ -90,6 +131,10 @@
 	status = "okay";
 };
 
+&fe0 {
+	status = "okay";
+};
+
 &i2c0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c0_pins_a>;
@@ -159,6 +204,27 @@
 		pins = "PH15";
 		function = "gpio_out";
 	};
+
+	lcd_backlight_pin: lcd_backlight_pin at 0 {
+		pins = "PH7";
+		function = "gpio_out";
+	};
+
+	lcd_enable_pin: lcd_enable_pin at 0 {
+		pins = "PH8";
+		function = "gpio_out";
+	};
+
+	lcd_lvds0_pins: lcd_lvds0_pins at 0 {
+		pins =  "PD0", "PD1", "PD2", "PD3", "PD4", "PD5", "PD6", "PD7", "PD8", "PD9";
+		function = "lvds0";
+	};
+};
+
+&pwm {
+        pinctrl-names = "default";
+        pinctrl-0 = <&pwm0_pins_a>;
+        status = "okay";
 };
 
 &reg_dcdc2 {
@@ -194,6 +260,17 @@
 	status = "okay";
 };
 
+&tcon0 {
+	mode = "lvds";
+	status = "okay";
+};
+
+&tcon0_out {
+	tcon0_out_panel: endpoint at 1 {
+		reg = <0>;
+		remote-endpoint = <&panel_input>;
+	};
+};
 
 &uart0  {
 	pinctrl-names = "default";
-- 
2.9.3
