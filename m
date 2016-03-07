From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Mon, 7 Mar 2016 17:17:29 +0200
Subject: [PATCH v2 02/10] ARM: DTS: dra7: Enable eDMA
In-Reply-To: <1457363857-20797-1-git-send-email-peter.ujfalusi@ti.com>
References: <1457363857-20797-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1457363857-20797-3-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DRA7 family has eDMA available along with the sDMA and in some cases it is
better suited for servicing peripherals.

Add the needed nodes for eDMA to be usable:
edma-tpcc, edma-tptc0/1 and the edma-xbar.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi | 48 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index db7fda97a4fa..b99f51288e71 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -170,6 +170,15 @@
 					ti,dma-safe-map = <0>;
 					dma-masters = <&sdma>;
 				};
+
+				edma_xbar: dma-router at c78 {
+					compatible = "ti,dra7-dma-crossbar";
+					reg = <0xc78 0x7c>;
+					#dma-cells = <2>;
+					dma-requests = <204>;
+					ti,dma-safe-map = <0>;
+					dma-masters = <&edma>;
+				};
 			};
 
 			cm_core_aon: cm_core_aon at 5000 {
@@ -324,6 +333,45 @@
 			dma-requests = <127>;
 		};
 
+		edma: edma at 43300000 {
+			compatible = "ti,edma3-tpcc";
+			ti,hwmods = "tpcc";
+			reg = <0x43300000 0x100000>;
+			reg-names = "edma3_cc";
+			interrupts = <GIC_SPI 361 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 360 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 359 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "edma3_ccint", "emda3_mperr",
+					  "edma3_ccerrint";
+			dma-requests = <64>;
+			#dma-cells = <2>;
+
+			ti,tptcs = <&edma_tptc0 7>, <&edma_tptc1 0>;
+
+			/*
+			 * memcpy is disabled, can be enabled with:
+			 * ti,edma-memcpy-channels = <20 21>;
+			 * for example. Note that these channels need to be
+			 * masked in the xbar as well.
+			 */
+		};
+
+		edma_tptc0: tptc at 43400000 {
+			compatible = "ti,edma3-tptc";
+			ti,hwmods = "tptc0";
+			reg =	<0x43400000 0x100000>;
+			interrupts = <GIC_SPI 370 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "edma3_tcerrint";
+		};
+
+		edma_tptc1: tptc at 43500000 {
+			compatible = "ti,edma3-tptc";
+			ti,hwmods = "tptc1";
+			reg =	<0x43500000 0x100000>;
+			interrupts = <GIC_SPI 371 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "edma3_tcerrint";
+		};
+
 		gpio1: gpio at 4ae10000 {
 			compatible = "ti,omap4-gpio";
 			reg = <0x4ae10000 0x200>;
-- 
2.7.2
