From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Fri, 4 Dec 2015 15:53:27 +0200
Subject: [PATCH 3/6] ARM: DTS: da850: Enable eDMA1
In-Reply-To: <1449237210-16381-1-git-send-email-peter.ujfalusi@ti.com>
References: <1449237210-16381-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1449237210-16381-4-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The eDMA1 in da850 has only one TPTC and for example MMC1 is HW events are
handled by it.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/da850-enbw-cmc.dts |  4 ++++
 arch/arm/boot/dts/da850-evm.dts      |  4 ++++
 arch/arm/boot/dts/da850.dtsi         | 17 +++++++++++++++++
 3 files changed, 25 insertions(+)

diff --git a/arch/arm/boot/dts/da850-enbw-cmc.dts b/arch/arm/boot/dts/da850-enbw-cmc.dts
index ca9117624cf9..44f0dd1866f9 100644
--- a/arch/arm/boot/dts/da850-enbw-cmc.dts
+++ b/arch/arm/boot/dts/da850-enbw-cmc.dts
@@ -33,3 +33,7 @@
 	ti,edma-reserved-slot-ranges = /bits/ 16 <32 50>;
 	ti,edma-memcpy-channels = /bits/ 16 <20 21>;
 };
+
+&edma1 {
+	ti,edma-reserved-slot-ranges = /bits/ 16 <32 90>;
+};
diff --git a/arch/arm/boot/dts/da850-evm.dts b/arch/arm/boot/dts/da850-evm.dts
index 33467feb272a..70ef9c642ac9 100644
--- a/arch/arm/boot/dts/da850-evm.dts
+++ b/arch/arm/boot/dts/da850-evm.dts
@@ -248,3 +248,7 @@
 	ti,edma-reserved-slot-ranges = /bits/ 16 <32 50>;
 	ti,edma-memcpy-channels = /bits/ 16 <20 21>;
 };
+
+&edma1 {
+	ti,edma-reserved-slot-ranges = /bits/ 16 <32 90>;
+};
diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
index 9e46eb51a8da..e311d73a5265 100644
--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -174,6 +174,23 @@
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
2.6.3
