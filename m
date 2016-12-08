From: khilman@baylibre.com (Kevin Hilman)
Date: Wed,  7 Dec 2016 16:14:18 -0800
Subject: [PATCH v2.1 1/4] ARM: dts: davinci: da850: VPIF: add node and muxing
In-Reply-To: <20161207193137.27947-2-khilman@baylibre.com>
References: <20161207193137.27947-2-khilman@baylibre.com>
Message-ID: <20161208001418.4469-1-khilman@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add VPIF node an pins to da850 and enable on boards.  VPIF has two input
channels described using the standard DT ports and enpoints.

Signed-off-by: Kevin Hilman <khilman@baylibre.com>
---
v2 -> v2.1: moved ports from SoC .dtsi to board .dts files.

 arch/arm/boot/dts/da850-evm.dts  | 20 ++++++++++++++++++++
 arch/arm/boot/dts/da850-lcdk.dts | 13 +++++++++++++
 arch/arm/boot/dts/da850.dtsi     | 27 ++++++++++++++++++++++++++-
 3 files changed, 59 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/da850-evm.dts b/arch/arm/boot/dts/da850-evm.dts
index 41de15fe15a2..cea36ee6fd07 100644
--- a/arch/arm/boot/dts/da850-evm.dts
+++ b/arch/arm/boot/dts/da850-evm.dts
@@ -289,3 +289,23 @@
 		};
 	};
 };
+
+&vpif {
+	pinctrl-names = "default";
+	pinctrl-0 = <&vpif_capture_pins>;
+	status = "okay";
+
+	/* VPIF capture port */
+	port {
+		vpif_ch0: endpoint at 0 {
+			  reg = <0>;
+			  bus-width = <8>;
+		};
+
+		vpif_ch1: endpoint at 1 {
+			  reg = <1>;
+			  bus-width = <8>;
+			  data-shift = <8>;
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/da850-lcdk.dts b/arch/arm/boot/dts/da850-lcdk.dts
index 7b8ab21fed6c..5fc21528e0ba 100644
--- a/arch/arm/boot/dts/da850-lcdk.dts
+++ b/arch/arm/boot/dts/da850-lcdk.dts
@@ -219,3 +219,16 @@
 		};
 	};
 };
+
+&vpif {
+	pinctrl-names = "default";
+	pinctrl-0 = <&vpif_capture_pins>;
+	status = "okay";
+
+	/* VPIF capture port */
+	port {
+		vpif_ch0: endpoint {
+			  bus-width = <8>;
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
index f79e1b91c680..5f0b40510b2b 100644
--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -186,7 +186,18 @@
 					0xc 0x88888888 0xffffffff
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
 		edma0: edma at 0 {
 			compatible = "ti,edma3-tpcc";
@@ -399,7 +410,21 @@
 				<&edma0 0 1>;
 			dma-names = "tx", "rx";
 		};
+
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
 	};
+
 	aemif: aemif at 68000000 {
 		compatible = "ti,da850-aemif";
 		#address-cells = <2>;
-- 
2.9.3
