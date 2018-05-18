From: aford173@gmail.com (Adam Ford)
Date: Fri, 18 May 2018 15:33:35 -0500
Subject: [PATCH V7] ARM: dts: da850-evm: Enable LCD and Backlight
Message-ID: <20180518203335.13878-1-aford173@gmail.com>
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
V7:  Missed one reference to backlight_reg->backlight_lcd

V6:  Fix some whitespace and comment formatting.  Rename backlight_reg to
     backlight_lcd

V5:  Resync against v4.18/dt

V4:  Move the backlight to PWM, so the driver can control the regulator allowing the 
     regulator to power down and enabling the ability to change the brightness of the
     backlight

V3:  Fix errant GPIO, label GPIO pins, and rename the regulator to be more explict to
     backlight which better matches the schematic.  Updated the description to explain
     that it cannot be used at the same time as the vpif driver.

V2:  Add regulator and GPIO enable pins. Remove PWM backlight and replace with GPIO  

diff --git a/arch/arm/boot/dts/da850-evm.dts b/arch/arm/boot/dts/da850-evm.dts
index 0e82bb988fde..a76c2ddfd23e 100644
--- a/arch/arm/boot/dts/da850-evm.dts
+++ b/arch/arm/boot/dts/da850-evm.dts
@@ -27,6 +27,60 @@
 		spi0 = &spi1;
 	};
 
+	backlight: backlight-pwm {
+		pinctrl-names = "default";
+		pinctrl-0 = <&ecap2_pins>;
+		power-supply = <&backlight_lcd>;
+		compatible = "pwm-backlight";
+		pwms = <&ecap2 0 50000 0>;
+		brightness-levels = <0 10 20 30 40 50 60 70 80 90 99>;
+		default-brightness-level = <7>;
+	};
+
+	panel {
+		compatible = "ti,tilcdc,panel";
+		pinctrl-names = "default";
+		pinctrl-0 = <&lcd_pins>;
+		/*
+		 * The vpif and the LCD are mutually exclusive.
+		 * To enable VPIF, change the status below to 'disabled' then
+		 * then change the status of the vpif below to 'okay'
+		*/
+		status = "okay";
+		enable-gpios = <&gpio 40 GPIO_ACTIVE_HIGH>; /* lcd_panel_pwr */
+
+		panel-info {
+			ac-bias		= <255>;
+			ac-bias-intrpt	= <0>;
+			dma-burst-sz	= <16>;
+			bpp		= <16>;
+			fdd		= <0x80>;
+			sync-edge	= <0>;
+			sync-ctrl	= <1>;
+			raster-order	= <0>;
+			fifo-th		= <0>;
+		};
+
+		display-timings {
+			native-mode = <&timing0>;
+			timing0: 480x272 {
+				clock-frequency = <9000000>;
+				hactive = <480>;
+				vactive = <272>;
+				hfront-porch = <3>;
+				hback-porch = <2>;
+				hsync-len = <42>;
+				vback-porch = <3>;
+				vfront-porch = <4>;
+				vsync-len = <11>;
+				hsync-active = <0>;
+				vsync-active = <0>;
+				de-active = <1>;
+				pixelclk-active = <1>;
+			};
+		};
+	};
+
 	vbat: fixedregulator0 {
 		compatible = "regulator-fixed";
 		regulator-name = "vbat";
@@ -35,6 +89,15 @@
 		regulator-boot-on;
 	};
 
+	backlight_lcd: backlight-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "lcd_backlight_pwr";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio 47 GPIO_ACTIVE_HIGH>; /* lcd_backlight_pwr */
+		enable-active-high;
+	};
+
 	sound {
 		compatible = "simple-audio-card";
 		simple-audio-card,name = "DA850/OMAP-L138 EVM";
@@ -63,6 +126,10 @@
 	};
 };
 
+&ecap2 {
+	status = "okay";
+};
+
 &pmx_core {
 	status = "okay";
 
@@ -109,6 +176,10 @@
 	status = "okay";
 };
 
+&lcdc {
+	status = "okay";
+};
+
 &i2c0 {
 	status = "okay";
 	clock-frequency = <100000>;
@@ -336,5 +407,10 @@
 &vpif {
 	pinctrl-names = "default";
 	pinctrl-0 = <&vpif_capture_pins>, <&vpif_display_pins>;
-	status = "okay";
+	/*
+	 * The vpif and the LCD are mutually exclusive.
+	 * To enable VPIF, disable the ti,tilcdc,panel then
+	 * changed the status below to 'okay'
+	*/
+	status = "disabled";
 };
-- 
2.17.0
