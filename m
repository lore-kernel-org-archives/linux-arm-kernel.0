From: aford173@gmail.com (Adam Ford)
Date: Fri,  8 Sep 2017 23:58:55 -0500
Subject: [RFC 2/2] DTS: davinci: da850evm: Enable LCD and Backlight
In-Reply-To: <1504933135-29747-1-git-send-email-aford173@gmail.com>
References: <1504933135-29747-1-git-send-email-aford173@gmail.com>
Message-ID: <1504933135-29747-2-git-send-email-aford173@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When using the board files the LCD works, but not with the DT.
This adds enables the original da850-evm to work with the same
LCD in device tree mode.

RFC:  Currently, I cannot get the backlight to do anything other
than 100%. I don't get the userspace files to write the brightness.
Any suggestions on what I am dowing wrong?

RFC:  The board-file version enables the LCD, but the only way
I can enable the LCD is the disable the VPIF display.  Should
I use a new name for the this DTS file to maintain compatibility,
or is there a better way to enable the LCD without losing VPIF

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm/boot/dts/da850-evm.dts b/arch/arm/boot/dts/da850-evm.dts
index 67e72bc..10df630 100644
--- a/arch/arm/boot/dts/da850-evm.dts
+++ b/arch/arm/boot/dts/da850-evm.dts
@@ -10,6 +10,7 @@
 /dts-v1/;
 #include "da850.dtsi"
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/pwm/pwm.h>
 
 / {
 	compatible = "ti,da850-evm", "ti,da850";
@@ -30,6 +31,7 @@
 					0x04 0x00011000 0x000ff000
 				>;
 			};
+
 			nand_pins: nand_pins {
 				pinctrl-single,bits = <
 					/* EMA_WAIT[0], EMA_OE, EMA_WE, EMA_CS[4], EMA_CS[3] */
@@ -152,6 +154,50 @@
 			status = "okay";
 		};
 	};
+
+	backlight {
+		compatible = "pwm-backlight";
+		pwms = <&ecap2 0 50000 PWM_POLARITY_INVERTED>;
+		brightness-levels = <0 58 61 66 75 90 125 170 255>;
+		default-brightness-level = <8>;
+	};
+
+	panel {
+		compatible = "ti,tilcdc,panel";
+		pinctrl-names = "default";
+		pinctrl-0 = <&lcd_pins>;
+		status = "okay";
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
@@ -240,6 +286,16 @@
 	};
 };
 
+&ecap2 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&ecap2_pins>;
+};
+
+&lcdc {
+	status = "okay";
+};
+
 &mcasp0 {
 	#sound-dai-cells = <0>;
 	status = "okay";
@@ -299,6 +355,6 @@
 
 &vpif {
 	pinctrl-names = "default";
-	pinctrl-0 = <&vpif_capture_pins>, <&vpif_display_pins>;
+	pinctrl-0 = <&vpif_capture_pins>/*, <&vpif_display_pins>*/;
 	status = "okay";
 };
-- 
2.7.4
