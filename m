From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 28 Jan 2013 21:58:20 +0000
Subject: [PATCH 5/5] ARM: SPEAr13xx: Pass generic DW DMAC platform data from DT
In-Reply-To: <1359410300-26113-1-git-send-email-arnd@arndb.de>
References: <1359395857-1235-1-git-send-email-arnd@arndb.de>
 <1359410300-26113-1-git-send-email-arnd@arndb.de>
Message-ID: <1359410300-26113-6-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This replaces an earlier patch from Viresh Kumar to move
the spear platform over to the generic DMA binding. This
version is now based on the merged multiplatform capable
spear platform, rather than the separate spear13xx/3xx/6xx
directories.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Vinod Koul <vinod.koul@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: devicetree-discuss at lists.ozlabs.org
---
 arch/arm/boot/dts/spear1340.dtsi         |   3 +
 arch/arm/boot/dts/spear13xx.dtsi         |  25 +++++-
 arch/arm/mach-spear/generic.h            |   6 --
 arch/arm/mach-spear/include/mach/spear.h |   2 -
 arch/arm/mach-spear/spear1310.c          |  30 +-------
 arch/arm/mach-spear/spear1340.c          |  32 +-------
 arch/arm/mach-spear/spear13xx-dma.h      | 128 -------------------------------
 arch/arm/mach-spear/spear13xx.c          |  58 --------------
 8 files changed, 29 insertions(+), 255 deletions(-)
 delete mode 100644 arch/arm/mach-spear/spear13xx-dma.h

diff --git a/arch/arm/boot/dts/spear1340.dtsi b/arch/arm/boot/dts/spear1340.dtsi
index 34da11a..e1786a0 100644
--- a/arch/arm/boot/dts/spear1340.dtsi
+++ b/arch/arm/boot/dts/spear1340.dtsi
@@ -113,6 +113,9 @@
 				reg = <0xb4100000 0x1000>;
 				interrupts = <0 105 0x4>;
 				status = "disabled";
+				dmas = <&dwdma0 0x600 0 0 1>, /* 0xC << 11 */
+					<&dwdma0 0x680 0 1 0>; /* 0xD << 7 */
+				dma-names = "tx", "rx";
 			};
 
 			thermal@e07008c4 {
diff --git a/arch/arm/boot/dts/spear13xx.dtsi b/arch/arm/boot/dts/spear13xx.dtsi
index b4ca60f..45597fd 100644
--- a/arch/arm/boot/dts/spear13xx.dtsi
+++ b/arch/arm/boot/dts/spear13xx.dtsi
@@ -98,13 +98,24 @@
 			reg = <0xb2800000 0x1000>;
 			interrupts = <0 29 0x4>;
 			status = "disabled";
+			dmas = <&dwdma0 0 0 0 0>;
+			dma-names = "data";
 		};
 
-		dma at ea800000 {
+		dwdma0: dma at ea800000 {
 			compatible = "snps,dma-spear1340";
 			reg = <0xea800000 0x1000>;
 			interrupts = <0 19 0x4>;
 			status = "disabled";
+
+			dma-channels = <8>;
+			#dma-cells = <3>;
+			dma-requests = <32>;
+			chan_allocation_order = <1>;
+			chan_priority = <1>;
+			block_size = <0xfff>;
+			dma-masters = <2>;
+			data_width = <3 3 0 0>;
 		};
 
 		dma at eb000000 {
@@ -112,6 +123,15 @@
 			reg = <0xeb000000 0x1000>;
 			interrupts = <0 59 0x4>;
 			status = "disabled";
+
+			dma-requests = <32>;
+			dma-channels = <8>;
+			dma-masters = <2>;
+			#dma-cells = <3>;
+			chan_allocation_order = <1>;
+			chan_priority = <1>;
+			block_size = <0xfff>;
+			data_width = <3 3 0 0>;
 		};
 
 		fsmc: flash at b0000000 {
@@ -261,6 +281,9 @@
 				#size-cells = <0>;
 				interrupts = <0 31 0x4>;
 				status = "disabled";
+				dmas = <&dwdma0 0x2000 0 0 0>, /* 0x4 << 11 */
+					<&dwdma0 0x0280 0 0 0>;  /* 0x5 << 7 */
+				dma-names = "tx", "rx";
 			};
 
 			rtc@e0580000 {
diff --git a/arch/arm/mach-spear/generic.h b/arch/arm/mach-spear/generic.h
index 32b7d00..01c6ca3 100644
--- a/arch/arm/mach-spear/generic.h
+++ b/arch/arm/mach-spear/generic.h
@@ -20,13 +20,7 @@
 
 extern struct sys_timer spear13xx_timer;
 extern struct sys_timer spear3xx_timer;
-extern struct pl022_ssp_controller pl022_plat_data;
 extern struct pl08x_platform_data pl080_plat_data;
-extern struct dw_dma_platform_data dmac_plat_data;
-extern struct dw_dma_slave cf_dma_priv;
-extern struct dw_dma_slave nand_read_dma_priv;
-extern struct dw_dma_slave nand_write_dma_priv;
-bool dw_dma_filter(struct dma_chan *chan, void *slave);
 
 void __init spear_setup_of_timer(void);
 void __init spear3xx_clk_init(void __iomem *misc_base,
diff --git a/arch/arm/mach-spear/include/mach/spear.h b/arch/arm/mach-spear/include/mach/spear.h
index 374ddc3..cf3a536 100644
--- a/arch/arm/mach-spear/include/mach/spear.h
+++ b/arch/arm/mach-spear/include/mach/spear.h
@@ -82,8 +82,6 @@
 #define VA_L2CC_BASE				IOMEM(UL(0xFB000000))
 
 /* others */
-#define DMAC0_BASE				UL(0xEA800000)
-#define DMAC1_BASE				UL(0xEB000000)
 #define MCIF_CF_BASE				UL(0xB2800000)
 
 /* Debug uart for linux, will be used for debug and uncompress messages */
diff --git a/arch/arm/mach-spear/spear1310.c b/arch/arm/mach-spear/spear1310.c
index 7c4ed3c..2622b1e 100644
--- a/arch/arm/mach-spear/spear1310.c
+++ b/arch/arm/mach-spear/spear1310.c
@@ -23,40 +23,12 @@
 #include <mach/spear.h>
 
 /* Base addresses */
-#define SPEAR1310_SSP1_BASE			UL(0x5D400000)
-#define SPEAR1310_SATA0_BASE			UL(0xB1000000)
-#define SPEAR1310_SATA1_BASE			UL(0xB1800000)
-#define SPEAR1310_SATA2_BASE			UL(0xB4000000)
-
 #define SPEAR1310_RAS_GRP1_BASE			UL(0xD8000000)
 #define VA_SPEAR1310_RAS_GRP1_BASE		UL(0xFA000000)
 
-static struct arasan_cf_pdata cf_pdata = {
-	.cf_if_clk = CF_IF_CLK_166M,
-	.quirk = CF_BROKEN_UDMA,
-	.dma_priv = &cf_dma_priv,
-};
-
-/* ssp device registration */
-static struct pl022_ssp_controller ssp1_plat_data = {
-	.enable_dma = 0,
-};
-
-/* Add SPEAr1310 auxdata to pass platform data */
-static struct of_dev_auxdata spear1310_auxdata_lookup[] __initdata = {
-	OF_DEV_AUXDATA("arasan,cf-spear1340", MCIF_CF_BASE, NULL, &cf_pdata),
-	OF_DEV_AUXDATA("snps,dma-spear1340", DMAC0_BASE, NULL, &dmac_plat_data),
-	OF_DEV_AUXDATA("snps,dma-spear1340", DMAC1_BASE, NULL, &dmac_plat_data),
-	OF_DEV_AUXDATA("arm,pl022", SSP_BASE, NULL, &pl022_plat_data),
-
-	OF_DEV_AUXDATA("arm,pl022", SPEAR1310_SSP1_BASE, NULL, &ssp1_plat_data),
-	{}
-};
-
 static void __init spear1310_dt_init(void)
 {
-	of_platform_populate(NULL, of_default_bus_match_table,
-			spear1310_auxdata_lookup, NULL);
+	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
 
 static const char * const spear1310_dt_board_compat[] = {
diff --git a/arch/arm/mach-spear/spear1340.c b/arch/arm/mach-spear/spear1340.c
index 98d509c..3fb3fdf 100644
--- a/arch/arm/mach-spear/spear1340.c
+++ b/arch/arm/mach-spear/spear1340.c
@@ -16,7 +16,6 @@
 #include <linux/ahci_platform.h>
 #include <linux/amba/serial.h>
 #include <linux/delay.h>
-#include <linux/dw_dmac.h>
 #include <linux/of_platform.h>
 #include <linux/pata_arasan_cf_data.h>
 #include <linux/irqchip.h>
@@ -24,11 +23,10 @@
 #include "generic.h"
 #include <mach/spear.h>
 
-#include "spear13xx-dma.h"
+/* FIXME: Move SATA PHY code into a standalone driver */
 
 /* Base addresses */
 #define SPEAR1340_SATA_BASE			UL(0xB1000000)
-#define SPEAR1340_UART1_BASE			UL(0xB4100000)
 
 /* Power Management Registers */
 #define SPEAR1340_PCM_CFG			(VA_MISC_BASE + 0x100)
@@ -80,28 +78,6 @@
 			(SPEAR1340_MIPHY_OSC_BYPASS_EXT | \
 			SPEAR1340_MIPHY_PLL_RATIO_TOP(25))
 
-static struct dw_dma_slave uart1_dma_param[] = {
-	{
-		/* Tx */
-		.cfg_hi = DWC_CFGH_DST_PER(SPEAR1340_DMA_REQ_UART1_TX),
-		.cfg_lo = 0,
-		.src_master = DMA_MASTER_MEMORY,
-		.dst_master = SPEAR1340_DMA_MASTER_UART1,
-	}, {
-		/* Rx */
-		.cfg_hi = DWC_CFGH_SRC_PER(SPEAR1340_DMA_REQ_UART1_RX),
-		.cfg_lo = 0,
-		.src_master = SPEAR1340_DMA_MASTER_UART1,
-		.dst_master = DMA_MASTER_MEMORY,
-	}
-};
-
-static struct amba_pl011_data uart1_data = {
-	.dma_filter = dw_dma_filter,
-	.dma_tx_param = &uart1_dma_param[0],
-	.dma_rx_param = &uart1_dma_param[1],
-};
-
 /* SATA device registration */
 static int sata_miphy_init(struct device *dev, void __iomem *addr)
 {
@@ -160,14 +136,8 @@ static struct ahci_platform_data sata_pdata = {
 
 /* Add SPEAr1340 auxdata to pass platform data */
 static struct of_dev_auxdata spear1340_auxdata_lookup[] __initdata = {
-	OF_DEV_AUXDATA("arasan,cf-spear1340", MCIF_CF_BASE, NULL, &cf_dma_priv),
-	OF_DEV_AUXDATA("snps,dma-spear1340", DMAC0_BASE, NULL, &dmac_plat_data),
-	OF_DEV_AUXDATA("snps,dma-spear1340", DMAC1_BASE, NULL, &dmac_plat_data),
-	OF_DEV_AUXDATA("arm,pl022", SSP_BASE, NULL, &pl022_plat_data),
-
 	OF_DEV_AUXDATA("snps,spear-ahci", SPEAR1340_SATA_BASE, NULL,
 			&sata_pdata),
-	OF_DEV_AUXDATA("arm,pl011", SPEAR1340_UART1_BASE, NULL, &uart1_data),
 	{}
 };
 
diff --git a/arch/arm/mach-spear/spear13xx-dma.h b/arch/arm/mach-spear/spear13xx-dma.h
deleted file mode 100644
index d50bdb6..0000000
--- a/arch/arm/mach-spear/spear13xx-dma.h
+++ /dev/null
@@ -1,128 +0,0 @@
-/*
- * arch/arm/mach-spear13xx/include/mach/dma.h
- *
- * DMA information for SPEAr13xx machine family
- *
- * Copyright (C) 2012 ST Microelectronics
- * Viresh Kumar <viresh.linux@gmail.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#ifndef __MACH_DMA_H
-#define __MACH_DMA_H
-
-/* request id of all the peripherals */
-enum dma_master_info {
-	/* Accessible from only one master */
-	DMA_MASTER_MCIF = 0,
-	DMA_MASTER_FSMC = 1,
-	/* Accessible from both 0 & 1 */
-	DMA_MASTER_MEMORY = 0,
-	DMA_MASTER_ADC = 0,
-	DMA_MASTER_UART0 = 0,
-	DMA_MASTER_SSP0 = 0,
-	DMA_MASTER_I2C0 = 0,
-
-#ifdef CONFIG_MACH_SPEAR1310
-	/* Accessible from only one master */
-	SPEAR1310_DMA_MASTER_JPEG = 1,
-
-	/* Accessible from both 0 & 1 */
-	SPEAR1310_DMA_MASTER_I2S = 0,
-	SPEAR1310_DMA_MASTER_UART1 = 0,
-	SPEAR1310_DMA_MASTER_UART2 = 0,
-	SPEAR1310_DMA_MASTER_UART3 = 0,
-	SPEAR1310_DMA_MASTER_UART4 = 0,
-	SPEAR1310_DMA_MASTER_UART5 = 0,
-	SPEAR1310_DMA_MASTER_I2C1 = 0,
-	SPEAR1310_DMA_MASTER_I2C2 = 0,
-	SPEAR1310_DMA_MASTER_I2C3 = 0,
-	SPEAR1310_DMA_MASTER_I2C4 = 0,
-	SPEAR1310_DMA_MASTER_I2C5 = 0,
-	SPEAR1310_DMA_MASTER_I2C6 = 0,
-	SPEAR1310_DMA_MASTER_I2C7 = 0,
-	SPEAR1310_DMA_MASTER_SSP1 = 0,
-#endif
-
-#ifdef CONFIG_MACH_SPEAR1340
-	/* Accessible from only one master */
-	SPEAR1340_DMA_MASTER_I2S_PLAY = 1,
-	SPEAR1340_DMA_MASTER_I2S_REC = 1,
-	SPEAR1340_DMA_MASTER_I2C1 = 1,
-	SPEAR1340_DMA_MASTER_UART1 = 1,
-
-	/* following are accessible from both master 0 & 1 */
-	SPEAR1340_DMA_MASTER_SPDIF = 0,
-	SPEAR1340_DMA_MASTER_CAM = 1,
-	SPEAR1340_DMA_MASTER_VIDEO_IN = 0,
-	SPEAR1340_DMA_MASTER_MALI = 0,
-#endif
-};
-
-enum request_id {
-	DMA_REQ_ADC = 0,
-	DMA_REQ_SSP0_TX = 4,
-	DMA_REQ_SSP0_RX = 5,
-	DMA_REQ_UART0_TX = 6,
-	DMA_REQ_UART0_RX = 7,
-	DMA_REQ_I2C0_TX = 8,
-	DMA_REQ_I2C0_RX = 9,
-
-#ifdef CONFIG_MACH_SPEAR1310
-	SPEAR1310_DMA_REQ_FROM_JPEG = 2,
-	SPEAR1310_DMA_REQ_TO_JPEG = 3,
-	SPEAR1310_DMA_REQ_I2S_TX = 10,
-	SPEAR1310_DMA_REQ_I2S_RX = 11,
-
-	SPEAR1310_DMA_REQ_I2C1_RX = 0,
-	SPEAR1310_DMA_REQ_I2C1_TX = 1,
-	SPEAR1310_DMA_REQ_I2C2_RX = 2,
-	SPEAR1310_DMA_REQ_I2C2_TX = 3,
-	SPEAR1310_DMA_REQ_I2C3_RX = 4,
-	SPEAR1310_DMA_REQ_I2C3_TX = 5,
-	SPEAR1310_DMA_REQ_I2C4_RX = 6,
-	SPEAR1310_DMA_REQ_I2C4_TX = 7,
-	SPEAR1310_DMA_REQ_I2C5_RX = 8,
-	SPEAR1310_DMA_REQ_I2C5_TX = 9,
-	SPEAR1310_DMA_REQ_I2C6_RX = 10,
-	SPEAR1310_DMA_REQ_I2C6_TX = 11,
-	SPEAR1310_DMA_REQ_UART1_RX = 12,
-	SPEAR1310_DMA_REQ_UART1_TX = 13,
-	SPEAR1310_DMA_REQ_UART2_RX = 14,
-	SPEAR1310_DMA_REQ_UART2_TX = 15,
-	SPEAR1310_DMA_REQ_UART5_RX = 16,
-	SPEAR1310_DMA_REQ_UART5_TX = 17,
-	SPEAR1310_DMA_REQ_SSP1_RX = 18,
-	SPEAR1310_DMA_REQ_SSP1_TX = 19,
-	SPEAR1310_DMA_REQ_I2C7_RX = 20,
-	SPEAR1310_DMA_REQ_I2C7_TX = 21,
-	SPEAR1310_DMA_REQ_UART3_RX = 28,
-	SPEAR1310_DMA_REQ_UART3_TX = 29,
-	SPEAR1310_DMA_REQ_UART4_RX = 30,
-	SPEAR1310_DMA_REQ_UART4_TX = 31,
-#endif
-
-#ifdef CONFIG_MACH_SPEAR1340
-	SPEAR1340_DMA_REQ_SPDIF_TX = 2,
-	SPEAR1340_DMA_REQ_SPDIF_RX = 3,
-	SPEAR1340_DMA_REQ_I2S_TX = 10,
-	SPEAR1340_DMA_REQ_I2S_RX = 11,
-	SPEAR1340_DMA_REQ_UART1_TX = 12,
-	SPEAR1340_DMA_REQ_UART1_RX = 13,
-	SPEAR1340_DMA_REQ_I2C1_TX = 14,
-	SPEAR1340_DMA_REQ_I2C1_RX = 15,
-	SPEAR1340_DMA_REQ_CAM0_EVEN = 0,
-	SPEAR1340_DMA_REQ_CAM0_ODD = 1,
-	SPEAR1340_DMA_REQ_CAM1_EVEN = 2,
-	SPEAR1340_DMA_REQ_CAM1_ODD = 3,
-	SPEAR1340_DMA_REQ_CAM2_EVEN = 4,
-	SPEAR1340_DMA_REQ_CAM2_ODD = 5,
-	SPEAR1340_DMA_REQ_CAM3_EVEN = 6,
-	SPEAR1340_DMA_REQ_CAM3_ODD = 7,
-#endif
-};
-
-#endif /* __MACH_DMA_H */
diff --git a/arch/arm/mach-spear/spear13xx.c b/arch/arm/mach-spear/spear13xx.c
index c1af386..371fc10 100644
--- a/arch/arm/mach-spear/spear13xx.c
+++ b/arch/arm/mach-spear/spear13xx.c
@@ -15,7 +15,6 @@
 
 #include <linux/amba/pl022.h>
 #include <linux/clk.h>
-#include <linux/dw_dmac.h>
 #include <linux/err.h>
 #include <linux/of.h>
 #include <asm/hardware/cache-l2x0.h>
@@ -24,63 +23,6 @@
 #include "generic.h"
 #include <mach/spear.h>
 
-#include "spear13xx-dma.h"
-
-/* common dw_dma filter routine to be used by peripherals */
-bool dw_dma_filter(struct dma_chan *chan, void *slave)
-{
-	struct dw_dma_slave *dws = (struct dw_dma_slave *)slave;
-
-	if (chan->device->dev == dws->dma_dev) {
-		chan->private = slave;
-		return true;
-	} else {
-		return false;
-	}
-}
-
-/* ssp device registration */
-static struct dw_dma_slave ssp_dma_param[] = {
-	{
-		/* Tx */
-		.cfg_hi = DWC_CFGH_DST_PER(DMA_REQ_SSP0_TX),
-		.cfg_lo = 0,
-		.src_master = DMA_MASTER_MEMORY,
-		.dst_master = DMA_MASTER_SSP0,
-	}, {
-		/* Rx */
-		.cfg_hi = DWC_CFGH_SRC_PER(DMA_REQ_SSP0_RX),
-		.cfg_lo = 0,
-		.src_master = DMA_MASTER_SSP0,
-		.dst_master = DMA_MASTER_MEMORY,
-	}
-};
-
-struct pl022_ssp_controller pl022_plat_data = {
-	.enable_dma = 1,
-	.dma_filter = dw_dma_filter,
-	.dma_rx_param = &ssp_dma_param[1],
-	.dma_tx_param = &ssp_dma_param[0],
-};
-
-/* CF device registration */
-struct dw_dma_slave cf_dma_priv = {
-	.cfg_hi = 0,
-	.cfg_lo = 0,
-	.src_master = 0,
-	.dst_master = 0,
-};
-
-/* dmac device registeration */
-struct dw_dma_platform_data dmac_plat_data = {
-	.nr_channels = 8,
-	.chan_allocation_order = CHAN_ALLOCATION_DESCENDING,
-	.chan_priority = CHAN_PRIORITY_DESCENDING,
-	.block_size = 4095U,
-	.nr_masters = 2,
-	.data_width = { 3, 3, 0, 0 },
-};
-
 void __init spear13xx_l2x0_init(void)
 {
 	/*
-- 
1.8.0
