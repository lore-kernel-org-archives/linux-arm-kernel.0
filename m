From: fcooper@ti.com (Franklin S Cooper Jr)
Date: Tue, 25 Jul 2017 21:15:52 -0500
Subject: [PATCH 3/3] ARM: dts: dra7xx: Enable NAND dma prefetch by default
In-Reply-To: <20170726021552.19880-1-fcooper@ti.com>
References: <20170726021552.19880-1-fcooper@ti.com>
Message-ID: <20170726021552.19880-4-fcooper@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently the default method of prefetch polled shows the highest
possible read and write speed when minimal non NAND background
activity is being done. But it is also very CPU intensive to reach
these high speeds (CPU load of 99% via mtd performance tests). While
DMA prefetch only uses 50% of the CPU to achieve around 23% less in
top read and write performance.

However, as the non NAND CPU load increases the read and write
performance takes a large hit when using polled prefetch. Therefore,
prefetch dma mode ends up outperforming prefetch polled in general
"system level" test. So switch to using dma prefetch by default since
it is likely what most users would prefer.

Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
---
 arch/arm/boot/dts/dra7-evm.dts          | 1 +
 arch/arm/boot/dts/dra72-evm-common.dtsi | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-evm.dts
index f47fc4d..7d55af9 100644
--- a/arch/arm/boot/dts/dra7-evm.dts
+++ b/arch/arm/boot/dts/dra7-evm.dts
@@ -556,6 +556,7 @@
 		interrupts = <0 IRQ_TYPE_NONE>, /* fifoevent */
 			     <1 IRQ_TYPE_NONE>; /* termcount */
 		rb-gpios = <&gpmc 0 GPIO_ACTIVE_HIGH>; /* gpmc_wait0 pin */
+		ti,nand-xfer-type = "prefetch-dma";
 		ti,nand-ecc-opt = "bch8";
 		ti,elm-id = <&elm>;
 		nand-bus-width = <16>;
diff --git a/arch/arm/boot/dts/dra72-evm-common.dtsi b/arch/arm/boot/dts/dra72-evm-common.dtsi
index 8578054..1830483 100644
--- a/arch/arm/boot/dts/dra72-evm-common.dtsi
+++ b/arch/arm/boot/dts/dra72-evm-common.dtsi
@@ -311,6 +311,7 @@
 		interrupts = <0 IRQ_TYPE_NONE>, /* fifoevent */
 			     <1 IRQ_TYPE_NONE>;	/* termcount */
 		rb-gpios = <&gpmc 0 GPIO_ACTIVE_HIGH>; /* gpmc_wait0 pin */
+		ti,nand-xfer-type = "prefetch-dma";
 		ti,nand-ecc-opt = "bch8";
 		ti,elm-id = <&elm>;
 		nand-bus-width = <16>;
-- 
2.10.0
