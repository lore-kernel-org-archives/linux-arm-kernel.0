From: aford173@gmail.com (Adam Ford)
Date: Thu, 26 Apr 2018 21:18:54 -0500
Subject: [PATCH V2] DTS: davinci: da850evm: Enable LCD and Backlight
Message-ID: <20180427021854.12850-1-aford173@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When using the board files the LCD works, but not with the DT.
This adds enables the original da850-evm to work with the same
LCD in device tree mode.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
V2:  Add regulator and GPIO enable pins. Remove PWM backlight and replace with GPIO  
 arch/arm/boot/dts/da850-evm.dts | 63 +++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/arch/arm/boot/dts/da850-evm.dts b/arch/arm/boot/dts/da850-evm.dts
index 11cf3765214f..4c59dab3362e 100644
--- a/arch/arm/boot/dts/da850-evm.dts
+++ b/arch/arm/boot/dts/da850-evm.dts
@@ -164,6 +164,51 @@
 			status = "okay";
 		};
 	};
+
+	backlight {
+		compatible = "gpio-backlight";
+		enable-gpios = <&gpio 48 GPIO_ACTIVE_HIGH>;
+		default-on;
+	};
+
+	panel {
+		compatible = "ti,tilcdc,panel";
+		pinctrl-names = "default";
+		pinctrl-0 = <&lcd_pins>;
+		status = "okay";
+		enable-gpios = <&gpio 47 GPIO_ACTIVE_HIGH>;
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
+			480x272 {
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
@@ -172,6 +217,16 @@
 		regulator-boot-on;
 	};
 
+	lcd_reg: lcdregulator {
+		compatible = "regulator-fixed";
+		regulator-name = "m_lcd_panel_pwr";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio 40 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		regulator-always-on;
+	};
+
 	sound {
 		compatible = "simple-audio-card";
 		simple-audio-card,name = "DA850/OMAP-L138 EVM";
@@ -255,6 +310,14 @@
 	};
 };
 
+&gpio {
+	status = "okay";
+};
+
+&lcdc {
+	status = "okay";
+};
+
 &mcasp0 {
 	#sound-dai-cells = <0>;
 	status = "okay";
-- 
2.17.0
