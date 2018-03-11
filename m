From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 11 Mar 2018 14:52:59 +0100
Subject: [PATCH 02/10] ARM: dts: Augment VGA connector bridge on PB1176
In-Reply-To: <20180311135307.6271-1-linus.walleij@linaro.org>
References: <20180311135307.6271-1-linus.walleij@linaro.org>
Message-ID: <20180311135307.6271-3-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PL111 in the ARM reference platforms are connected to
"panels" that are actually dumb VGA DAC connector bridges.
Now that we can support the proper bridges in the DRM driver,
fix this up.

Cc: Liviu Dudau <liviu.dudau@arm.com>
Cc: Mali DP Maintainers <malidp@foss.arm.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/arm-realview-pb1176.dts | 66 +++++++++++++++++++------------
 1 file changed, 40 insertions(+), 26 deletions(-)

diff --git a/arch/arm/boot/dts/arm-realview-pb1176.dts b/arch/arm/boot/dts/arm-realview-pb1176.dts
index c789564f2803..f935b72d3d96 100644
--- a/arch/arm/boot/dts/arm-realview-pb1176.dts
+++ b/arch/arm/boot/dts/arm-realview-pb1176.dts
@@ -161,6 +161,43 @@
 		port1-otg;
 	};
 
+	bridge {
+		compatible = "ti,ths8134a", "ti,ths8134";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port at 0 {
+				reg = <0>;
+
+				vga_bridge_in: endpoint {
+					remote-endpoint = <&clcd_pads>;
+				};
+			};
+
+			port at 1 {
+				reg = <1>;
+
+				vga_bridge_out: endpoint {
+					remote-endpoint = <&vga_con_in>;
+				};
+			};
+		};
+	};
+
+	vga {
+		compatible = "vga-connector";
+
+		port {
+			vga_con_in: endpoint {
+				remote-endpoint = <&vga_bridge_out>;
+			};
+		};
+	};
+
 	soc {
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -403,36 +440,15 @@
 			interrupts = <0 47 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&oscclk0>, <&pclk>;
 			clock-names = "clcdclk", "apb_pclk";
+			/* 1024x768 16bpp @65MHz works fine */
+			max-memory-bandwidth = <95000000>;
 
 			port {
 				clcd_pads: endpoint {
-					remote-endpoint = <&clcd_panel>;
+					remote-endpoint = <&vga_bridge_in>;
 					arm,pl11x,tft-r0g0b0-pads = <0 8 16>;
 				};
 			};
-
-			panel {
-				compatible = "panel-dpi";
-
-				port {
-					clcd_panel: endpoint {
-						remote-endpoint = <&clcd_pads>;
-					};
-				};
-
-				/* Standard 640x480 VGA timings */
-				panel-timing {
-					clock-frequency = <25175000>;
-					hactive = <640>;
-					hback-porch = <48>;
-					hfront-porch = <16>;
-					hsync-len = <96>;
-					vactive = <480>;
-					vback-porch = <33>;
-					vfront-porch = <10>;
-					vsync-len = <2>;
-				};
-			};
 		};
 	};
 
@@ -564,7 +580,5 @@
 			clocks = <&pclk>;
 			clock-names = "apb_pclk";
 		};
-
-
 	};
 };
-- 
2.14.3
