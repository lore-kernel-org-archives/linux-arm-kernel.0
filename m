From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Thu, 17 Dec 2015 15:27:49 +0200
Subject: [PATCH v02 3/6] ARM: DTS: da850: Enable eDMA1
In-Reply-To: <1450358872-2951-1-git-send-email-peter.ujfalusi@ti.com>
References: <1450358872-2951-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1450358872-2951-4-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The eDMA1 in da850 has only one TPTC and for example MMC1 is HW events are
handled by it.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Tested-by: Sushaanth Srirangapathi <sushaanth.s@ti.com>
---
 arch/arm/boot/dts/da850-enbw-cmc.dts |  4 ++++
 arch/arm/boot/dts/da850-evm.dts      |  4 ++++
 arch/arm/boot/dts/da850.dtsi         | 17 +++++++++++++++++
 3 files changed, 25 insertions(+)

diff --git a/arch/arm/boot/dts/da850-enbw-cmc.dts b/arch/arm/boot/dts/da850-enbw-cmc.dts
index 1811f8275559..645549e14237 100644
--- a/arch/arm/boot/dts/da850-enbw-cmc.dts
+++ b/arch/arm/boot/dts/da850-enbw-cmc.dts
@@ -32,3 +32,7 @@
 &edma0 {
 	ti,edma-reserved-slot-ranges = <32 50>;
 };
+
+&edma1 {
+	ti,edma-reserved-slot-ranges = <32 90>;
+};
diff --git a/arch/arm/boot/dts/da850-evm.dts b/arch/arm/boot/dts/da850-evm.dts
index 94cf9a9b1302..30e2def402ad 100644
--- a/arch/arm/boot/dts/da850-evm.dts
+++ b/arch/arm/boot/dts/da850-evm.dts
@@ -247,3 +247,7 @@
 &edma0 {
 	ti,edma-reserved-slot-ranges = <32 50>;
 };
+
+&edma1 {
+	ti,edma-reserved-slot-ranges = <32 90>;
+};
diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
index 6e39f9b06524..c08b6c04fcf1 100644
--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -173,6 +173,23 @@
 			interrupts = <32>;
 			interrupt-names = "edm3_tcerrint";
 		};
+		edma1: edma at 01e30000 {
+			compatible = "ti,edma3-tpcc";
+			/* eDMA3 CC1: 0x01e3 0000 - 0x01e3 7fff */
+			reg =	<0x230000 0x8000>;
+			reg-names = "edma3_cc";
+			interrupts = <93 94>;
+			interrupt-names = "edma3_ccint", "edma3_ccerrint";
+			#dma-cells = <2>;
+
+			ti,tptcs = <&edma1_tptc0 7>;
+		};
+		edma1_tptc0: tptc at 01e38000 {
+			compatible = "ti,edma3-tptc";
+			reg =	<0x238000 0x400>;
+			interrupts = <95>;
+			interrupt-names = "edm3_tcerrint";
+		};
 		serial0: serial at 1c42000 {
 			compatible = "ns16550a";
 			reg = <0x42000 0x100>;
-- 
2.6.4
