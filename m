From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Wed,  5 Oct 2016 15:05:32 +0200
Subject: [PATCH 2/2] ARM: dts: da850: add a node for the LCD controller
In-Reply-To: <1475672732-17111-1-git-send-email-bgolaszewski@baylibre.com>
References: <1475672732-17111-1-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <1475672732-17111-3-git-send-email-bgolaszewski@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Karl Beldan <kbeldan@baylibre.com>

Add pins used by the LCD controller and a disabled LCDC node to be
reused in device trees including da850.dtsi.

Signed-off-by: Karl Beldan <kbeldan@baylibre.com>
[Bartosz:
  - added the commit description
  - changed the dt node name to a generic one
  - added a da850-specific compatible string
  - removed the tilcdc,panel node
  - moved the pins definitions to da850.dtsi as suggested by
    Sekhar Nori (was in: da850-lcdk.dts)]
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/boot/dts/da850.dtsi | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
index f79e1b9..32908ae 100644
--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -186,6 +186,27 @@
 					0xc 0x88888888 0xffffffff
 				>;
 			};
+			lcd_pins: pinmux_lcd_pins {
+				pinctrl-single,bits = <
+					/*
+					 * LCD_D[2], LCD_D[3], LCD_D[4], LCD_D[5],
+					 * LCD_D[6], LCD_D[7]
+					 */
+					0x40 0x22222200 0xffffff00
+					/*
+					 * LCD_D[10], LCD_D[11], LCD_D[12], LCD_D[13],
+					 * LCD_D[14], LCD_D[15], LCD_D[0], LCD_D[1]
+					 */
+					0x44 0x22222222 0xffffffff
+					/* LCD_D[8], LCD_D[9] */
+					0x48 0x00000022 0x000000ff
+
+					/* LCD_PCLK */
+					0x48 0x02000000 0x0f000000
+					/* LCD_AC_ENB_CS, LCD_VSYNC, LCD_HSYNC */
+					0x4c 0x02000022 0x0f0000ff
+				>;
+			};
 
 		};
 		edma0: edma at 0 {
@@ -399,6 +420,14 @@
 				<&edma0 0 1>;
 			dma-names = "tx", "rx";
 		};
+
+		display: display at 213000 {
+			compatible = "ti,am33xx-tilcdc", "ti,da850-tilcdc";
+			reg = <0x213000 0x1000>;
+			interrupt-parent = <&intc>;
+			interrupts = <52>;
+			status = "disabled";
+		};
 	};
 	aemif: aemif at 68000000 {
 		compatible = "ti,da850-aemif";
-- 
2.9.3
