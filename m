From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Thu, 29 Sep 2016 18:31:52 +0200
Subject: [PATCH 3/6] ARM: dts: da850-lcdk: enable the LCD controller
In-Reply-To: <1475166715-7857-1-git-send-email-bgolaszewski@baylibre.com>
References: <1475166715-7857-1-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <1475166715-7857-4-git-send-email-bgolaszewski@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Karl Beldan <kbeldan@baylibre.com>

This adds the pins used by the LCD controller, and uses 'tilcdc,panel'
with some default timings for 800x600.

Tested on an LCDK connected on the VGA port (the LCDC is connected to
this port via a THS8135).

Signed-off-by: Karl Beldan <kbeldan@baylibre.com>
[Bartosz:
  - fixed whitespace errors
  - tweaked the description
  - fixed the incorrect hback-porch value
  - other minor tweaks]
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/boot/dts/da850-lcdk.dts | 60 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/arch/arm/boot/dts/da850-lcdk.dts b/arch/arm/boot/dts/da850-lcdk.dts
index 7b8ab21..6ca5d48 100644
--- a/arch/arm/boot/dts/da850-lcdk.dts
+++ b/arch/arm/boot/dts/da850-lcdk.dts
@@ -50,6 +50,40 @@
 			system-clock-frequency = <24576000>;
 		};
 	};
+
+	panel {
+		compatible = "ti,tilcdc,panel";
+		pinctrl-names = "default";
+		pinctrl-0 = <&lcd_pins>;
+		status = "okay";
+
+		panel-info {
+			ac-bias           = <0>;
+			ac-bias-intrpt    = <0>;
+			dma-burst-sz      = <16>;
+			bpp               = <16>;
+			fdd               = <255>;
+			sync-edge         = <0>;
+			sync-ctrl         = <0>;
+			raster-order      = <0>;
+			fifo-th           = <5>;
+		};
+
+		display-timings {
+			native-mode = <&svga_timings>;
+			svga_timings: 800x600 {
+				clock-frequency = <37500000>;
+				hactive = <800>;
+				hback-porch = <140>;
+				hfront-porch = <40>;
+				hsync-len = <128>;
+				vactive = <600>;
+				vback-porch = <23>;
+				vfront-porch = <1>;
+				vsync-len = <4>;
+			};
+		};
+	};
 };
 
 &pmx_core {
@@ -84,6 +118,28 @@
 			0x30 0x01100000  0x0ff00000
 		>;
 	};
+
+	lcd_pins: pinmux_lcd_pins {
+		pinctrl-single,bits = <
+			/*
+			 * LCD_D[2], LCD_D[3], LCD_D[4], LCD_D[5],
+			 * LCD_D[6], LCD_D[7]
+			 */
+			0x40 0x22222200 0xffffff00
+			/*
+			 * LCD_D[10], LCD_D[11], LCD_D[12], LCD_D[13],
+			 * LCD_D[14], LCD_D[15], LCD_D[0], LCD_D[1]
+			 */
+			0x44 0x22222222 0xffffffff
+			/* LCD_D[8], LCD_D[9] */
+			0x48 0x00000022 0x000000ff
+
+			/* LCD_PCLK */
+			0x48 0x02000000 0x0f000000
+			/* LCD_AC_ENB_CS, LCD_VSYNC, LCD_HSYNC */
+			0x4c 0x02000022 0x0f0000ff
+		>;
+	};
 };
 
 &serial2 {
@@ -219,3 +275,7 @@
 		};
 	};
 };
+
+&lcdc {
+	status = "okay";
+};
-- 
2.7.4
