From: aford173@gmail.com (Adam Ford)
Date: Sun, 13 May 2018 18:20:33 -0500
Subject: [PATCH V3] ARM: dts: da850-evm: Enable LCD and Backlight
Message-ID: <20180513232033.22571-1-aford173@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When using the board files the LCD works, but not with the DT.
This adds enables the original da850-evm to work with the same
LCD in device tree mode.

The EVM has a gpio for the regulator and a gpio enable.  The LCD and
the vpif display pins are mutually exclusive, so if using the LCD,
do not load the vpif driver.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
V3:  Fix errant GPIO, label GPIO pins, and rename the regulator to be more explict to
     backlight which better matches the schematic.  Updated the description to explain
     that it cannot be used at the same time as the vpif driver.

V2:  Add regulator and GPIO enable pins. Remove PWM backlight and replace with GPIO  

diff --git a/arch/arm/boot/dts/da850-evm.dts b/arch/arm/boot/dts/da850-evm.dts
index 2e817da37fdb..3f1c8be07efe 100644
--- a/arch/arm/boot/dts/da850-evm.dts
+++ b/arch/arm/boot/dts/da850-evm.dts
@@ -27,6 +27,50 @@
 		spi0 = &spi1;
 	};
 
+	backlight {
+		compatible = "gpio-backlight";
+		enable-gpios = <&gpio 7 GPIO_ACTIVE_HIGH>; /* GP0[7] */
+	};
+
+	panel {
+		compatible = "ti,tilcdc,panel";
+		pinctrl-names = "default";
+		pinctrl-0 = <&lcd_pins>;
+		status = "okay";
+		enable-gpios = <&gpio 40 GPIO_ACTIVE_HIGH>; /* GP2[8] */
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
@@ -35,6 +79,16 @@
 		regulator-boot-on;
 	};
 
+	backlight_reg: backlight-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "lcd_backlight_pwr";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio 47 GPIO_ACTIVE_HIGH>; /* GP2[15] */
+		regulator-always-on;
+		enable-active-high;
+	};
+
 	sound {
 		compatible = "simple-audio-card";
 		simple-audio-card,name = "DA850/OMAP-L138 EVM";
@@ -109,6 +163,10 @@
 	status = "okay";
 };
 
+&lcdc {
+	status = "okay";
+};
+
 &i2c0 {
 	status = "okay";
 	clock-frequency = <100000>;
-- 
2.17.0
