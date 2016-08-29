From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 29 Aug 2016 11:33:04 +0200
Subject: [PATCH] ARM: integrator: move CP CLCD display to DTS
Message-ID: <1472463184-9272-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Integrator/CP CLCD VGA display can now be registered
fully from the device tree. Delete the board file code and
add the display definition to the DTS.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/integratorcp.dts | 37 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/integratorcp.dts b/arch/arm/boot/dts/integratorcp.dts
index 371173ec63fd..915203b4083f 100644
--- a/arch/arm/boot/dts/integratorcp.dts
+++ b/arch/arm/boot/dts/integratorcp.dts
@@ -249,7 +249,42 @@
 			reg = <0xC0000000 0x1000>;
 			interrupts = <22>;
 			clocks = <&auxosc>, <&pclk>;
-			clock-names = "clcd", "apb_pclk";
+			clock-names = "clcdclk", "apb_pclk";
+
+			port {
+				/*
+				 * The VGA connected is implemented with a
+				 * THS8134A triple DAC that can be run in 24bit
+				 * or 16bit RGB mode.
+				 */
+				clcd_pads: endpoint {
+					remote-endpoint = <&clcd_panel>;
+					arm,pl11x,tft-r0g0b0-pads = <1 7 13>;
+				};
+			};
+
+			panel {
+				compatible = "panel-dpi";
+
+				port {
+					clcd_panel: endpoint {
+						remote-endpoint = <&clcd_pads>;
+					};
+				};
+
+				/* Standard 640x480 VGA timings */
+				panel-timing {
+					clock-frequency = <25175000>;
+					hactive = <640>;
+					hback-porch = <48>;
+					hfront-porch = <16>;
+					hsync-len = <96>;
+					vactive = <480>;
+					vback-porch = <33>;
+					vfront-porch = <10>;
+					vsync-len = <2>;
+				};
+			};
 		};
 	};
 };
-- 
2.7.4
