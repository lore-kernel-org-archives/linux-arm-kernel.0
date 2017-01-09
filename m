From: khilman@baylibre.com (Kevin Hilman)
Date: Mon,  9 Jan 2017 12:55:26 -0800
Subject: [PATCH v2 1/6] ARM: dts: davinci: da850: VPIF: add node and muxing
In-Reply-To: <20170109205531.3435-1-khilman@baylibre.com>
References: <20170109205531.3435-1-khilman@baylibre.com>
Message-ID: <20170109205531.3435-2-khilman@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add VPIF node an pins to da850 SoC.  VPIF has two input channels which
can be described using the standard DT ports and enpoints.

Signed-off-by: Kevin Hilman <khilman@baylibre.com>
---
 arch/arm/boot/dts/da850.dtsi | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
index 104155d12c2f..edab8bb92ec5 100644
--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -208,7 +208,18 @@
 					0x4c 0x02000022 0x0f0000ff
 				>;
 			};
-
+			vpif_capture_pins: vpif_capture_pins {
+				pinctrl-single,bits = <
+					/* VP_DIN[2..7], VP_CLKIN1, VP_CLKIN0 */
+					0x38 0x11111111 0xffffffff
+					/* VP_DIN[10..15,0..1] */
+					0x3c 0x11111111 0xffffffff
+					/* VP_DIN[8..9] */
+					0x40 0x00000011 0x000000ff
+					/* VP_CLKIN3, VP_CLKIN2 */
+					0x4c 0x00010100 0x000f0f00
+				>;
+			};
 		};
 		prictrl: priority-controller at 14110 {
 			compatible = "ti,da850-mstpri";
@@ -324,6 +335,18 @@
 			dma-names = "rx", "tx";
 			status = "disabled";
 		};
+		vpif: video at 217000 {
+			compatible = "ti,da850-vpif";
+			reg = <0x217000 0x1000>;
+			interrupts = <92>;
+			status = "disabled";
+
+			/* VPIF capture port */
+			port {
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+		};
 		mmc1: mmc at 21b000 {
 			compatible = "ti,da830-mmc";
 			reg = <0x21b000 0x1000>;
@@ -465,6 +488,7 @@
 			status = "disabled";
 		};
 	};
+
 	aemif: aemif at 68000000 {
 		compatible = "ti,da850-aemif";
 		#address-cells = <2>;
-- 
2.9.3
