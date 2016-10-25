From: khilman@baylibre.com (Kevin Hilman)
Date: Tue, 25 Oct 2016 16:55:33 -0700
Subject: [RFC PATCH 3/6] ARM: dts: davinci: da850: add VPIF
In-Reply-To: <20161025235536.7342-1-khilman@baylibre.com>
References: <20161025235536.7342-1-khilman@baylibre.com>
Message-ID: <20161025235536.7342-4-khilman@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add VPIF and VPIF capture nodes to da850.

Note that these are separate nodes because the current media drivers
have two separate drivers for vpif and vpif_capture.

Signed-off-by: Kevin Hilman <khilman@baylibre.com>
---
 arch/arm/boot/dts/da850.dtsi | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
index f79e1b91c680..62c5b3e65071 100644
--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -399,7 +399,35 @@
 				<&edma0 0 1>;
 			dma-names = "tx", "rx";
 		};
+
+		vpif: video at 0x00217000 {
+			compatible = "ti,vpif";
+			reg = <0x00217000 0x1000>;
+			status = "disabled";
+		};
+
+		vpif_capture: video-capture at 0x00217000 {
+			compatible = "ti,vpif-capture";
+			reg = <0x00217000 0x1000>;
+			interrupts = <92>;
+			status = "disabled";
+
+			/* VPIF capture: input channels */
+			port {
+				vpif_ch0: endpoint at 0 {
+					  reg = <0>;
+					  bus-width = <8>;
+				};
+
+				vpif_ch1: endpoint at 1 {
+					  reg = <1>;
+					  bus-width = <8>;
+					  data-shift = <8>;
+				};
+			};
+		};
 	};
+
 	aemif: aemif at 68000000 {
 		compatible = "ti,da850-aemif";
 		#address-cells = <2>;
-- 
2.9.3
