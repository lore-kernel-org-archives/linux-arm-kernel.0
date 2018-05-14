From: aford173@gmail.com (Adam Ford)
Date: Mon, 14 May 2018 06:19:28 -0500
Subject: [PATCH V4] ARM: dts: da850-evm: Enable LCD and Backlight
Message-ID: <20180514111928.28172-1-aford173@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When using the board files the LCD works, but not with the DT.
This adds enables the original da850-evm to work with the same
LCD in device tree mode.

The EVM has a gpios for the lcd_panel_pwr, lcd_backlight_pwr,
and lcd_pwm0.  Both lcd_backlight_pwr and lcd_pwm0 must be driven
to enable the backlight, so a gpio-regulator is used to drive
lcd_backlight_prw.

The LCD and the vpif display pins are mutually exclusive, so if
using the LCD, disable the vpif.  If using the vpif, disable panel.
Extra code comments are inserted to further explain this

Signed-off-by: Adam Ford <aford173@gmail.com>
---
V4:  Add comments into the code explaining the LCD and VPIF are mutually
     exclusive with instructions on how to enable/disable each.  Rename 
     GPIO pins based on schematic net name. Fix gpio enable in backlight

V3:  Fix errant GPIO, label GPIO pins, and rename the regulator to be 
     more explict to backlight which better matches the schematic.
     Updated the description to explain that it cannot be used at the 
     same time as the vpif driver.

V2:  Add regulator and GPIO enable pins. Remove PWM backlight and 
     replace with GPIO  

diff --git a/arch/arm/boot/dts/da850-evm.dts b/arch/arm/boot/dts/da850-evm.dts
index 2e817da37fdb..f6a5497d9c97 100644
--- a/arch/arm/boot/dts/da850-evm.dts
+++ b/arch/arm/boot/dts/da850-evm.dts
@@ -27,6 +27,53 @@
 		spi0 = &spi1;
 	};
 
+	backlight {
+		compatible = "gpio-backlight";
+		gpios = <&gpio 7 GPIO_ACTIVE_HIGH>; /* lcd_pwm0 */
+	};
+
+	panel {
+		compatible = "ti,tilcdc,panel";
+		pinctrl-names = "default";
+		pinctrl-0 = <&lcd_pins>;
+		/* The vpif and the LCD are mutually exclusive.
+		 * To enable VPIF, change the status below to 'disabled' then
+		 * then change the status of the vpif below to 'okay' */
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
@@ -35,6 +82,16 @@
 		regulator-boot-on;
 	};
 
+	backlight_reg: backlight-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "lcd_backlight_pwr";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio 47 GPIO_ACTIVE_HIGH>; /* lcd_backlight_pwr */
+		regulator-always-on;
+		enable-active-high;
+	};
+
 	sound {
 		compatible = "simple-audio-card";
 		simple-audio-card,name = "DA850/OMAP-L138 EVM";
@@ -109,6 +166,10 @@
 	status = "okay";
 };
 
+&lcdc {
+	status = "okay";
+};
+
 &i2c0 {
 	status = "okay";
 	clock-frequency = <100000>;
@@ -339,5 +400,8 @@
 &vpif {
 	pinctrl-names = "default";
 	pinctrl-0 = <&vpif_capture_pins>, <&vpif_display_pins>;
-	status = "okay";
+	/* The vpif and the LCD are mutually exclusive.
+	 * To enable VPIF, disable the ti,tilcdc,panel then
+	 * changed the status below to 'okay' */
+	status = "disabled";
 };
-- 
2.17.0
