From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 13 Jan 2017 14:16:48 +0100
Subject: [PATCH] ARM: ux500: cut some platform data
Message-ID: <20170113131648.24889-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This platform data is revoked: the drivers are getting the DMA
configuration from the device tree, it has been done like that
since the DMA support was merged and this data has not been used
since. The remaining auxdata is also unused.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-ux500/board-mop500-audio.c | 77 -----------------------------
 arch/arm/mach-ux500/board-mop500.h       | 17 -------
 arch/arm/mach-ux500/cpu-db8500.c         | 16 ------
 arch/arm/mach-ux500/ste-dma40-db8500.h   | 85 --------------------------------
 4 files changed, 195 deletions(-)
 delete mode 100644 arch/arm/mach-ux500/board-mop500-audio.c
 delete mode 100644 arch/arm/mach-ux500/board-mop500.h
 delete mode 100644 arch/arm/mach-ux500/ste-dma40-db8500.h

diff --git a/arch/arm/mach-ux500/board-mop500-audio.c b/arch/arm/mach-ux500/board-mop500-audio.c
deleted file mode 100644
index b2a0899e7453..000000000000
--- a/arch/arm/mach-ux500/board-mop500-audio.c
+++ /dev/null
@@ -1,77 +0,0 @@
-/*
- * Copyright (C) ST-Ericsson SA 2010
- *
- * License terms: GNU General Public License (GPL), version 2
- */
-
-#include <linux/platform_device.h>
-#include <linux/init.h>
-#include <linux/gpio.h>
-#include <linux/platform_data/dma-ste-dma40.h>
-
-#include <linux/platform_data/asoc-ux500-msp.h>
-
-#include "ste-dma40-db8500.h"
-#include "board-mop500.h"
-
-static struct stedma40_chan_cfg msp0_dma_rx = {
-	.high_priority = true,
-	.dir = DMA_DEV_TO_MEM,
-	.dev_type = DB8500_DMA_DEV31_MSP0_SLIM0_CH0,
-};
-
-static struct stedma40_chan_cfg msp0_dma_tx = {
-	.high_priority = true,
-	.dir = DMA_MEM_TO_DEV,
-	.dev_type = DB8500_DMA_DEV31_MSP0_SLIM0_CH0,
-};
-
-struct msp_i2s_platform_data msp0_platform_data = {
-	.id = 0,
-	.msp_i2s_dma_rx = &msp0_dma_rx,
-	.msp_i2s_dma_tx = &msp0_dma_tx,
-};
-
-static struct stedma40_chan_cfg msp1_dma_rx = {
-	.high_priority = true,
-	.dir = DMA_DEV_TO_MEM,
-	.dev_type = DB8500_DMA_DEV30_MSP3,
-};
-
-static struct stedma40_chan_cfg msp1_dma_tx = {
-	.high_priority = true,
-	.dir = DMA_MEM_TO_DEV,
-	.dev_type = DB8500_DMA_DEV30_MSP1,
-};
-
-struct msp_i2s_platform_data msp1_platform_data = {
-	.id = 1,
-	.msp_i2s_dma_rx = NULL,
-	.msp_i2s_dma_tx = &msp1_dma_tx,
-};
-
-static struct stedma40_chan_cfg msp2_dma_rx = {
-	.high_priority = true,
-	.dir = DMA_DEV_TO_MEM,
-	.dev_type = DB8500_DMA_DEV14_MSP2,
-};
-
-static struct stedma40_chan_cfg msp2_dma_tx = {
-	.high_priority = true,
-	.dir = DMA_MEM_TO_DEV,
-	.dev_type = DB8500_DMA_DEV14_MSP2,
-	.use_fixed_channel = true,
-	.phy_channel = 1,
-};
-
-struct msp_i2s_platform_data msp2_platform_data = {
-	.id = 2,
-	.msp_i2s_dma_rx = &msp2_dma_rx,
-	.msp_i2s_dma_tx = &msp2_dma_tx,
-};
-
-struct msp_i2s_platform_data msp3_platform_data = {
-	.id		= 3,
-	.msp_i2s_dma_rx	= &msp1_dma_rx,
-	.msp_i2s_dma_tx	= NULL,
-};
diff --git a/arch/arm/mach-ux500/board-mop500.h b/arch/arm/mach-ux500/board-mop500.h
deleted file mode 100644
index 7c7b0adca582..000000000000
--- a/arch/arm/mach-ux500/board-mop500.h
+++ /dev/null
@@ -1,17 +0,0 @@
-/*
- * Copyright (C) ST-Ericsson SA 2010
- *
- * License terms: GNU General Public License (GPL) version 2
- */
-
-#ifndef __BOARD_MOP500_H
-#define __BOARD_MOP500_H
-
-#include <linux/platform_data/asoc-ux500-msp.h>
-
-extern struct msp_i2s_platform_data msp0_platform_data;
-extern struct msp_i2s_platform_data msp1_platform_data;
-extern struct msp_i2s_platform_data msp2_platform_data;
-extern struct msp_i2s_platform_data msp3_platform_data;
-
-#endif
diff --git a/arch/arm/mach-ux500/cpu-db8500.c b/arch/arm/mach-ux500/cpu-db8500.c
index 46b1da1bf5d2..4d2ed9199641 100644
--- a/arch/arm/mach-ux500/cpu-db8500.c
+++ b/arch/arm/mach-ux500/cpu-db8500.c
@@ -34,7 +34,6 @@
 
 #include "setup.h"
 
-#include "board-mop500.h"
 #include "db8500-regs.h"
 
 static int __init ux500_l2x0_unlock(void)
@@ -142,21 +141,6 @@ static struct arm_pmu_platdata db8500_pmu_platdata = {
 static struct of_dev_auxdata u8500_auxdata_lookup[] __initdata = {
 	/* Requires call-back bindings. */
 	OF_DEV_AUXDATA("arm,cortex-a9-pmu", 0, "arm-pmu", &db8500_pmu_platdata),
-	/* Requires DMA bindings. */
-	OF_DEV_AUXDATA("stericsson,ux500-msp-i2s", 0x80123000,
-		       "ux500-msp-i2s.0", &msp0_platform_data),
-	OF_DEV_AUXDATA("stericsson,ux500-msp-i2s", 0x80124000,
-		       "ux500-msp-i2s.1", &msp1_platform_data),
-	OF_DEV_AUXDATA("stericsson,ux500-msp-i2s", 0x80117000,
-		       "ux500-msp-i2s.2", &msp2_platform_data),
-	OF_DEV_AUXDATA("stericsson,ux500-msp-i2s", 0x80125000,
-		       "ux500-msp-i2s.3", &msp3_platform_data),
-	/* Requires non-DT:able platform data. */
-	OF_DEV_AUXDATA("stericsson,db8500-prcmu", 0x80157000, "db8500-prcmu", NULL),
-	OF_DEV_AUXDATA("stericsson,ux500-cryp", 0xa03cb000, "cryp1", NULL),
-	OF_DEV_AUXDATA("stericsson,ux500-hash", 0xa03c2000, "hash1", NULL),
-	OF_DEV_AUXDATA("stericsson,snd-soc-mop500", 0, "snd-soc-mop500.0",
-			NULL),
 	{},
 };
 
diff --git a/arch/arm/mach-ux500/ste-dma40-db8500.h b/arch/arm/mach-ux500/ste-dma40-db8500.h
deleted file mode 100644
index 0296ae5b0fd9..000000000000
--- a/arch/arm/mach-ux500/ste-dma40-db8500.h
+++ /dev/null
@@ -1,85 +0,0 @@
-/*
- * arch/arm/mach-ux500/ste_dma40_db8500.h
- * DB8500-SoC-specific configuration for DMA40
- *
- * Copyright (C) ST-Ericsson 2007-2010
- * License terms: GNU General Public License (GPL) version 2
- * Author: Per Friden <per.friden@stericsson.com>
- * Author: Jonas Aaberg <jonas.aberg@stericsson.com>
- */
-#ifndef STE_DMA40_DB8500_H
-#define STE_DMA40_DB8500_H
-
-#define DB8500_DMA_NR_DEV 64
-
-/*
- * Unless otherwise specified, all channels numbers are used for
- * TX & RX, and can be used for either source or destination
- * channels.
- */
-enum dma_dev_type {
-	DB8500_DMA_DEV0_SPI0 = 0,
-	DB8500_DMA_DEV1_SD_MMC0 = 1,
-	DB8500_DMA_DEV2_SD_MMC1 = 2,
-	DB8500_DMA_DEV3_SD_MMC2 = 3,
-	DB8500_DMA_DEV4_I2C1 = 4,
-	DB8500_DMA_DEV5_I2C3 = 5,
-	DB8500_DMA_DEV6_I2C2 = 6,
-	DB8500_DMA_DEV7_I2C4 = 7,			/* Only on V1 and later */
-	DB8500_DMA_DEV8_SSP0 = 8,
-	DB8500_DMA_DEV9_SSP1 = 9,
-	DB8500_DMA_DEV10_MCDE_RX = 10,			/* RX only */
-	DB8500_DMA_DEV11_UART2 = 11,
-	DB8500_DMA_DEV12_UART1 = 12,
-	DB8500_DMA_DEV13_UART0 = 13,
-	DB8500_DMA_DEV14_MSP2 = 14,
-	DB8500_DMA_DEV15_I2C0 = 15,
-	DB8500_DMA_DEV16_USB_OTG_IEP_AND_OEP_7_15 = 16,
-	DB8500_DMA_DEV17_USB_OTG_IEP_AND_OEP_6_14 = 17,
-	DB8500_DMA_DEV18_USB_OTG_IEP_AND_OEP_5_13 = 18,
-	DB8500_DMA_DEV19_USB_OTG_IEP_AND_OEP_4_12 = 19,
-	DB8500_DMA_DEV20_SLIM0_CH0_HSI_CH0 = 20,
-	DB8500_DMA_DEV21_SLIM0_CH1_HSI_CH1 = 21,
-	DB8500_DMA_DEV22_SLIM0_CH2_HSI_CH2 = 22,
-	DB8500_DMA_DEV23_SLIM0_CH3_HSI_CH3 = 23,
-	DB8500_DMA_DEV24_SXA0 = 24,
-	DB8500_DMA_DEV25_SXA1 = 25,
-	DB8500_DMA_DEV26_SXA2 = 26,
-	DB8500_DMA_DEV27_SXA3 = 27,
-	DB8500_DMA_DEV28_SD_MM2 = 28,
-	DB8500_DMA_DEV29_SD_MM0 = 29,
-	DB8500_DMA_DEV30_MSP1 = 30,
-	/* On DB8500v2, MSP3 RX replaces MSP1 RX */
-	DB8500_DMA_DEV30_MSP3 = 30,
-	DB8500_DMA_DEV31_MSP0_SLIM0_CH0 = 31,
-	DB8500_DMA_DEV32_SD_MM1 = 32,
-	DB8500_DMA_DEV33_SPI2 = 33,
-	DB8500_DMA_DEV34_I2C3_RX2_TX2 = 34,
-	DB8500_DMA_DEV35_SPI1 = 35,
-	DB8500_DMA_DEV36_USB_OTG_IEP_AND_OEP_3_11 = 36,
-	DB8500_DMA_DEV37_USB_OTG_IEP_AND_OEP_2_10 = 37,
-	DB8500_DMA_DEV38_USB_OTG_IEP_AND_OEP_1_9 = 38,
-	DB8500_DMA_DEV39_USB_OTG_IEP_AND_OEP_8 = 39,
-	DB8500_DMA_DEV40_SPI3 = 40,
-	DB8500_DMA_DEV41_SD_MM3 = 41,
-	DB8500_DMA_DEV42_SD_MM4 = 42,
-	DB8500_DMA_DEV43_SD_MM5 = 43,
-	DB8500_DMA_DEV44_SXA4 = 44,
-	DB8500_DMA_DEV45_SXA5 = 45,
-	DB8500_DMA_DEV46_SLIM0_CH8_SRC_SXA6 = 46,
-	DB8500_DMA_DEV47_SLIM0_CH9_SRC_SXA7 = 47,
-	DB8500_DMA_DEV48_CAC1 = 48,
-	DB8500_DMA_DEV49_CAC1_TX_HAC1_TX = 49,		/* TX only */
-	DB8500_DMA_DEV50_HAC1_TX = 50,			/* TX only */
-	DB8500_DMA_MEMCPY_TX_0 = 51,			/* TX only */
-	DB8500_DMA_DEV52_SLIM0_CH4_HSI_CH4 = 52,
-	DB8500_DMA_DEV53_SLIM0_CH5_HSI_CH5 = 53,
-	DB8500_DMA_DEV54_SLIM0_CH6_HSI_CH6 = 54,
-	DB8500_DMA_DEV55_SLIM0_CH7_HSI_CH7 = 55,
-	/* 56 -> 60 are channels reserved for memcpy only */
-	DB8500_DMA_DEV61_CAC0 = 61,
-	DB8500_DMA_DEV62_CAC0_TX_HAC0_TX = 62,		/* TX only */
-	DB8500_DMA_DEV63_HAC0_TX = 63,			/* TX only */
-};
-
-#endif
-- 
2.9.3
