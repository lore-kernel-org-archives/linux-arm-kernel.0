From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Thu, 17 Dec 2015 15:27:48 +0200
Subject: [PATCH v02 2/6] ARM: DTS: da850: Use the new DT bindings for the eDMA3
In-Reply-To: <1450358872-2951-1-git-send-email-peter.ujfalusi@ti.com>
References: <1450358872-2951-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1450358872-2951-3-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Switch to use the ti,edma3-tpcc and ti,edma3-tptc binding for the eDMA3.
With the new bindings boards can customize and tweak the DMA channel
priority to match their needs. With the new binding the memcpy is safe
to be used since with the old binding it was not possible for a driver
to know which channel is allowed to be used as non HW triggered channel.
Using the new binding will allow us to reserve PaRAM slots to be used by
the DSP which was not possible before and prevented the da850 boards to be
moved to DT only.

Note that the DMA memcpy is disabled, it can be enabled by reserving
channels for memcpy by adding the following property to the edma node:
ti,edma-memcpy-channels = <20 21>; /* Reserving channel 20 and 21 for memcpy */

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Tested-by: Sushaanth Srirangapathi <sushaanth.s@ti.com>
---
 arch/arm/boot/dts/da850-enbw-cmc.dts |  4 ++++
 arch/arm/boot/dts/da850-evm.dts      |  4 ++++
 arch/arm/boot/dts/da850.dtsi         | 26 +++++++++++++++++++++-----
 3 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/da850-enbw-cmc.dts b/arch/arm/boot/dts/da850-enbw-cmc.dts
index e750ab9086d5..1811f8275559 100644
--- a/arch/arm/boot/dts/da850-enbw-cmc.dts
+++ b/arch/arm/boot/dts/da850-enbw-cmc.dts
@@ -28,3 +28,7 @@
 		};
 	};
 };
+
+&edma0 {
+	ti,edma-reserved-slot-ranges = <32 50>;
+};
diff --git a/arch/arm/boot/dts/da850-evm.dts b/arch/arm/boot/dts/da850-evm.dts
index d807285a61cd..94cf9a9b1302 100644
--- a/arch/arm/boot/dts/da850-evm.dts
+++ b/arch/arm/boot/dts/da850-evm.dts
@@ -243,3 +243,7 @@
 	tx-num-evt = <32>;
 	rx-num-evt = <32>;
 };
+
+&edma0 {
+	ti,edma-reserved-slot-ranges = <32 50>;
+};
diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
index e73f5efb3aa3..6e39f9b06524 100644
--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -151,11 +151,27 @@
 
 		};
 		edma0: edma at 01c00000 {
-			compatible = "ti,edma3";
+			compatible = "ti,edma3-tpcc";
 			/* eDMA3 CC0: 0x01c0 0000 - 0x01c0 7fff */
 			reg =	<0x0 0x8000>;
-			interrupts = <11 13 12>;
-			#dma-cells = <1>;
+			reg-names = "edma3_cc";
+			interrupts = <11 12>;
+			interrupt-names = "edma3_ccint", "edma3_ccerrint";
+			#dma-cells = <2>;
+
+			ti,tptcs = <&edma0_tptc0 7>, <&edma0_tptc1 0>;
+		};
+		edma0_tptc0: tptc at 01c08000 {
+			compatible = "ti,edma3-tptc";
+			reg =	<0x8000 0x400>;
+			interrupts = <13>;
+			interrupt-names = "edm3_tcerrint";
+		};
+		edma0_tptc1: tptc at 01c08400 {
+			compatible = "ti,edma3-tptc";
+			reg =	<0x8400 0x400>;
+			interrupts = <32>;
+			interrupt-names = "edm3_tcerrint";
 		};
 		serial0: serial at 1c42000 {
 			compatible = "ns16550a";
@@ -286,8 +302,8 @@
 			interrupts = <54>;
 			interrupt-names = "common";
 			status = "disabled";
-			dmas = <&edma0 1>,
-				<&edma0 0>;
+			dmas = <&edma0 1 1>,
+				<&edma0 0 1>;
 			dma-names = "tx", "rx";
 		};
 	};
-- 
2.6.4
