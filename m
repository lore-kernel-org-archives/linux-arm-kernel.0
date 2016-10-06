From: wens@csie.org (Chen-Yu Tsai)
Date: Fri,  7 Oct 2016 00:06:29 +0800
Subject: [PATCH 9/9] [DO NOT MERGE] ARM: dts: sun6i: Enable 7" LCD panel on
 Sinlinx SinA31s
In-Reply-To: <20161006160629.11198-1-wens@csie.org>
References: <20161006160629.11198-1-wens@csie.org>
Message-ID: <20161006160629.11198-10-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sinlinx SinA31s comes with an optional 7" 1024x600 LCD panel with
capacitive touch panel that bolts on to the board.

Enable the display using a panel with close timings. This patch is more
of a proof of concept. The LCD panel has no markings whatsoever, and
the timings are not exactly the same, and as a result the display produces
glitch lines sometimes.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun6i-a31s-sina31s.dts | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/boot/dts/sun6i-a31s-sina31s.dts b/arch/arm/boot/dts/sun6i-a31s-sina31s.dts
index 6ead2f5c847a..2d5cf8c9a12f 100644
--- a/arch/arm/boot/dts/sun6i-a31s-sina31s.dts
+++ b/arch/arm/boot/dts/sun6i-a31s-sina31s.dts
@@ -63,6 +63,23 @@
 			gpios = <&pio 7 13 GPIO_ACTIVE_HIGH>; /* PH13 */
 		};
 	};
+
+	panel: panel {
+		compatible = "avic,tm070ddh03", "simple-panel";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		port at 0 {
+			reg = <0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			panel_input: endpoint at 0 {
+				reg = <0>;
+				remote-endpoint = <&tcon0_out_lcd>;
+			};
+		};
+	};
 };
 
 &ehci0 {
@@ -148,6 +165,19 @@
 	regulator-name = "vcc-gmac-phy";
 };
 
+&tcon0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&lcd0_rgb888_pins>;
+	status = "okay";
+};
+
+&tcon0_out {
+	tcon0_out_lcd: endpoint at 0 {
+		reg = <0>;
+		remote-endpoint = <&panel_input>;
+	};
+};
+
 &usbphy {
 	status = "okay";
 };
-- 
2.9.3
