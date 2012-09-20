From: mporter@ti.com (Matt Porter)
Date: Thu, 20 Sep 2012 10:43:45 -0400
Subject: [RFC PATCH 12/13] ARM: dts: add am33xx EDMA support
In-Reply-To: <1348152226-13588-1-git-send-email-mporter@ti.com>
References: <1348152226-13588-1-git-send-email-mporter@ti.com>
Message-ID: <1348152226-13588-13-git-send-email-mporter@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds support for the defined EDMA, generic DMA controller, and
DMA request bindings for mmc and spi.

Signed-off-by: Matt Porter <mporter@ti.com>
---
 arch/arm/boot/dts/am33xx.dtsi |   46 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index e8033eb..c14a61d 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -86,6 +86,36 @@
 			reg = <0x48200000 0x1000>;
 		};
 
+		edma: edma at 49000000 {
+			compatible = "ti,edma3";
+			ti,hwmods = "tpcc", "tptc0", "tptc1", "tptc2";
+			reg = <0x49000000 0x10000>;
+			interrupt-parent = <&intc>;
+			interrupts = <12 13 14>;
+			#dma-cells = <1>;
+			dma-channels = <64>;
+			ti,edma-regions = <4>;
+			ti,edma-slots = <256>;
+			ti,edma-reserved-channels = <0  2
+					     14 2
+					     26 6
+					     48 4
+					     56 8>;
+			ti,edma-reserved-slots = <0  2
+					  14 2
+					  26 6
+					  48 4
+					  56 8
+					  64 127>;
+			ti,edma-queue-tc-map = <0 0
+					1 1
+					2 2>;
+			ti,edma-queue-priority-map = <0 0
+					      1 1
+					      2 2>;
+			ti,edma-default-queue = <0>;
+		};
+
 		gpio0: gpio at 44e07000 {
 			compatible = "ti,omap4-gpio";
 			ti,hwmods = "gpio1";
@@ -290,6 +320,9 @@
 			ti,hwmods = "mmc1";
 			ti,dual-volt;
 			ti,needs-special-reset;
+			dmas = <&edma 24
+				&edma 25>;
+			dma-names = "tx", "rx";
 		};
 
 		mmc2: mmc at 481D8000 {
@@ -297,6 +330,9 @@
 			ti,hwmods = "mmc2";
 			ti,needs-special-reset;
 			status = "disabled";
+			dmas = <&edma 2
+				&edma 3>;
+			dma-names = "tx", "rx";
 		};
 
 		mmc3: mmc at 47810000 {
@@ -339,6 +375,11 @@
 			reg = <0x48030000 0x400>;
 			interrupt-parent = <&intc>;
 			interrupt = <65>;
+			dmas = <&edma 16
+				&edma 17
+				&edma 18
+				&edma 19>;
+			dma-names = "tx0", "rx0", "tx1", "rx1";
 			ti,spi-num-cs = <2>;
 			ti,hwmods = "spi0";
 			status = "disabled";
@@ -351,6 +392,11 @@
 			reg = <0x481a0000 0x400>;
 			interrupt-parent = <&intc>;
 			interrupt = <125>;
+			dmas = <&edma 42
+				&edma 43
+				&edma 44
+				&edma 45>;
+			dma-names = "tx0", "rx0", "tx1", "rx1";
 			ti,spi-num-cs = <2>;
 			ti,hwmods = "spi1";
 			status = "disabled";
-- 
1.7.9.5
