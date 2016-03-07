From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Mon, 7 Mar 2016 17:17:30 +0200
Subject: [PATCH v2 03/10] ARM: DTS: dra7: Use eDMA and add DAT port address
 for McASP3
In-Reply-To: <1457363857-20797-1-git-send-email-peter.ujfalusi@ti.com>
References: <1457363857-20797-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1457363857-20797-4-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Misael Lopez Cruz <misael.lopez@ti.com>

McASP3 does not support constant addressing mode on the DAT
port, so increment transfers must be used instead.  This
restriction is also applicable for McASP1 and McASP2.

This DMA addressing constraint poses a major problem for sDMA
where constant addressing mode is used on the peripheral side.
Unfortunately, using increment transfers in sDMA comes with
important side effects.

The addressing mode used in eDMA is INC, so the silicon limitation
described above has no impact and the McASP3 DAT port can be
safely added by switching to eDMA instead of sDMA.

Signed-off-by: Misael Lopez Cruz <misael.lopez@ti.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index b99f51288e71..4c192ea8ae29 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -1469,12 +1469,13 @@
 		mcasp3: mcasp at 48468000 {
 			compatible = "ti,dra7-mcasp-audio";
 			ti,hwmods = "mcasp3";
-			reg = <0x48468000 0x2000>;
-			reg-names = "mpu";
+			reg = <0x48468000 0x2000>,
+			      <0x46000000 0x1000>;
+			reg-names = "mpu","dat";
 			interrupts = <GIC_SPI 151 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "tx", "rx";
-			dmas = <&sdma_xbar 133>, <&sdma_xbar 132>;
+			dmas = <&edma_xbar 133 1>, <&edma_xbar 132 1>;
 			dma-names = "tx", "rx";
 			clocks = <&mcasp3_aux_gfclk_mux>, <&mcasp3_ahclkx_mux>;
 			clock-names = "fck", "ahclkx";
-- 
2.7.2
