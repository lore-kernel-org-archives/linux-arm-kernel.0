From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Fri, 21 Mar 2014 13:14:13 +0100
Subject: [PATCH 16/20] ARM: ux500: Remove redundant board file for mmci
 platform data
In-Reply-To: <1395404057-27835-1-git-send-email-ulf.hansson@linaro.org>
References: <1395404057-27835-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1395404057-27835-17-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since all platform data has been transfered to DT, we don't need the
container for the mmci platform data anymore. Remove the file and the
corresponding references to it's data.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 arch/arm/mach-ux500/Makefile           |    3 +-
 arch/arm/mach-ux500/board-mop500-sdi.c |  166 --------------------------------
 arch/arm/mach-ux500/board-mop500.h     |    5 -
 arch/arm/mach-ux500/cpu-db8500.c       |    4 -
 4 files changed, 1 insertion(+), 177 deletions(-)
 delete mode 100644 arch/arm/mach-ux500/board-mop500-sdi.c

diff --git a/arch/arm/mach-ux500/Makefile b/arch/arm/mach-ux500/Makefile
index de544aa..9741de95 100644
--- a/arch/arm/mach-ux500/Makefile
+++ b/arch/arm/mach-ux500/Makefile
@@ -5,8 +5,7 @@
 obj-y				:= cpu.o id.o timer.o pm.o
 obj-$(CONFIG_CACHE_L2X0)	+= cache-l2x0.o
 obj-$(CONFIG_UX500_SOC_DB8500)	+= cpu-db8500.o
-obj-$(CONFIG_MACH_MOP500)	+= board-mop500-sdi.o \
-				board-mop500-regulators.o \
+obj-$(CONFIG_MACH_MOP500)	+= board-mop500-regulators.o \
 				board-mop500-audio.o
 obj-$(CONFIG_SMP)		+= platsmp.o headsmp.o
 obj-$(CONFIG_HOTPLUG_CPU)	+= hotplug.o
diff --git a/arch/arm/mach-ux500/board-mop500-sdi.c b/arch/arm/mach-ux500/board-mop500-sdi.c
deleted file mode 100644
index fcbf3a1..0000000
--- a/arch/arm/mach-ux500/board-mop500-sdi.c
+++ /dev/null
@@ -1,166 +0,0 @@
-/*
- * Copyright (C) ST-Ericsson SA 2010
- *
- * Author: Hanumath Prasad <hanumath.prasad@stericsson.com>
- * License terms: GNU General Public License (GPL) version 2
- */
-
-#include <linux/kernel.h>
-#include <linux/gpio.h>
-#include <linux/amba/bus.h>
-#include <linux/amba/mmci.h>
-#include <linux/mmc/host.h>
-#include <linux/platform_device.h>
-#include <linux/platform_data/dma-ste-dma40.h>
-
-#include <asm/mach-types.h>
-
-#include "db8500-regs.h"
-#include "board-mop500.h"
-#include "ste-dma40-db8500.h"
-
-/*
- * v2 has a new version of this block that need to be forced, the number found
- * in hardware is incorrect
- */
-#define U8500_SDI_V2_PERIPHID 0x10480180
-
-/*
- * SDI 0 (MicroSD slot)
- */
-
-#ifdef CONFIG_STE_DMA40
-struct stedma40_chan_cfg mop500_sdi0_dma_cfg_rx = {
-	.mode = STEDMA40_MODE_LOGICAL,
-	.dir = DMA_DEV_TO_MEM,
-	.dev_type = DB8500_DMA_DEV29_SD_MM0,
-};
-
-static struct stedma40_chan_cfg mop500_sdi0_dma_cfg_tx = {
-	.mode = STEDMA40_MODE_LOGICAL,
-	.dir = DMA_MEM_TO_DEV,
-	.dev_type = DB8500_DMA_DEV29_SD_MM0,
-};
-#endif
-
-struct mmci_platform_data mop500_sdi0_data = {
-	.f_max		= 100000000,
-	.capabilities	= MMC_CAP_4_BIT_DATA |
-				MMC_CAP_SD_HIGHSPEED |
-				MMC_CAP_MMC_HIGHSPEED |
-				MMC_CAP_ERASE |
-				MMC_CAP_UHS_SDR12 |
-				MMC_CAP_UHS_SDR25,
-	.gpio_wp	= -1,
-	.sigdir		= MCI_ST_FBCLKEN |
-				MCI_ST_CMDDIREN |
-				MCI_ST_DATA0DIREN |
-				MCI_ST_DATA2DIREN,
-#ifdef CONFIG_STE_DMA40
-	.dma_filter	= stedma40_filter,
-	.dma_rx_param	= &mop500_sdi0_dma_cfg_rx,
-	.dma_tx_param	= &mop500_sdi0_dma_cfg_tx,
-#endif
-};
-
-/*
- * SDI1 (SDIO WLAN)
- */
-#ifdef CONFIG_STE_DMA40
-static struct stedma40_chan_cfg sdi1_dma_cfg_rx = {
-	.mode = STEDMA40_MODE_LOGICAL,
-	.dir = DMA_DEV_TO_MEM,
-	.dev_type = DB8500_DMA_DEV32_SD_MM1,
-};
-
-static struct stedma40_chan_cfg sdi1_dma_cfg_tx = {
-	.mode = STEDMA40_MODE_LOGICAL,
-	.dir = DMA_MEM_TO_DEV,
-	.dev_type = DB8500_DMA_DEV32_SD_MM1,
-};
-#endif
-
-struct mmci_platform_data mop500_sdi1_data = {
-	.ocr_mask	= MMC_VDD_29_30,
-	.f_max		= 100000000,
-	.capabilities	= MMC_CAP_4_BIT_DATA |
-				MMC_CAP_NONREMOVABLE,
-	.gpio_cd	= -1,
-	.gpio_wp	= -1,
-#ifdef CONFIG_STE_DMA40
-	.dma_filter	= stedma40_filter,
-	.dma_rx_param	= &sdi1_dma_cfg_rx,
-	.dma_tx_param	= &sdi1_dma_cfg_tx,
-#endif
-};
-
-/*
- * SDI 2 (POP eMMC, not on DB8500ed)
- */
-
-#ifdef CONFIG_STE_DMA40
-struct stedma40_chan_cfg mop500_sdi2_dma_cfg_rx = {
-	.mode = STEDMA40_MODE_LOGICAL,
-	.dir = DMA_DEV_TO_MEM,
-	.dev_type =  DB8500_DMA_DEV28_SD_MM2,
-};
-
-static struct stedma40_chan_cfg mop500_sdi2_dma_cfg_tx = {
-	.mode = STEDMA40_MODE_LOGICAL,
-	.dir = DMA_MEM_TO_DEV,
-	.dev_type = DB8500_DMA_DEV28_SD_MM2,
-};
-#endif
-
-struct mmci_platform_data mop500_sdi2_data = {
-	.ocr_mask	= MMC_VDD_165_195,
-	.f_max		= 100000000,
-	.capabilities	= MMC_CAP_4_BIT_DATA |
-				MMC_CAP_8_BIT_DATA |
-				MMC_CAP_NONREMOVABLE |
-				MMC_CAP_MMC_HIGHSPEED |
-				MMC_CAP_ERASE |
-				MMC_CAP_CMD23,
-	.gpio_cd	= -1,
-	.gpio_wp	= -1,
-#ifdef CONFIG_STE_DMA40
-	.dma_filter	= stedma40_filter,
-	.dma_rx_param	= &mop500_sdi2_dma_cfg_rx,
-	.dma_tx_param	= &mop500_sdi2_dma_cfg_tx,
-#endif
-};
-
-/*
- * SDI 4 (on-board eMMC)
- */
-
-#ifdef CONFIG_STE_DMA40
-struct stedma40_chan_cfg mop500_sdi4_dma_cfg_rx = {
-	.mode = STEDMA40_MODE_LOGICAL,
-	.dir = DMA_DEV_TO_MEM,
-	.dev_type =  DB8500_DMA_DEV42_SD_MM4,
-};
-
-static struct stedma40_chan_cfg mop500_sdi4_dma_cfg_tx = {
-	.mode = STEDMA40_MODE_LOGICAL,
-	.dir = DMA_MEM_TO_DEV,
-	.dev_type = DB8500_DMA_DEV42_SD_MM4,
-};
-#endif
-
-struct mmci_platform_data mop500_sdi4_data = {
-	.f_max		= 100000000,
-	.capabilities	= MMC_CAP_4_BIT_DATA |
-				MMC_CAP_8_BIT_DATA |
-				MMC_CAP_NONREMOVABLE |
-				MMC_CAP_MMC_HIGHSPEED |
-				MMC_CAP_ERASE |
-				MMC_CAP_CMD23,
-	.gpio_cd	= -1,
-	.gpio_wp	= -1,
-#ifdef CONFIG_STE_DMA40
-	.dma_filter	= stedma40_filter,
-	.dma_rx_param	= &mop500_sdi4_dma_cfg_rx,
-	.dma_tx_param	= &mop500_sdi4_dma_cfg_tx,
-#endif
-};
diff --git a/arch/arm/mach-ux500/board-mop500.h b/arch/arm/mach-ux500/board-mop500.h
index 32cc0d8..7c7b0ad 100644
--- a/arch/arm/mach-ux500/board-mop500.h
+++ b/arch/arm/mach-ux500/board-mop500.h
@@ -8,12 +8,7 @@
 #define __BOARD_MOP500_H
 
 #include <linux/platform_data/asoc-ux500-msp.h>
-#include <linux/amba/mmci.h>
 
-extern struct mmci_platform_data mop500_sdi0_data;
-extern struct mmci_platform_data mop500_sdi1_data;
-extern struct mmci_platform_data mop500_sdi2_data;
-extern struct mmci_platform_data mop500_sdi4_data;
 extern struct msp_i2s_platform_data msp0_platform_data;
 extern struct msp_i2s_platform_data msp1_platform_data;
 extern struct msp_i2s_platform_data msp2_platform_data;
diff --git a/arch/arm/mach-ux500/cpu-db8500.c b/arch/arm/mach-ux500/cpu-db8500.c
index 8820f60..fa308f0 100644
--- a/arch/arm/mach-ux500/cpu-db8500.c
+++ b/arch/arm/mach-ux500/cpu-db8500.c
@@ -146,10 +146,6 @@ static struct of_dev_auxdata u8500_auxdata_lookup[] __initdata = {
 	/* Requires call-back bindings. */
 	OF_DEV_AUXDATA("arm,cortex-a9-pmu", 0, "arm-pmu", &db8500_pmu_platdata),
 	/* Requires DMA bindings. */
-	OF_DEV_AUXDATA("arm,pl18x", 0x80126000, "sdi0",  &mop500_sdi0_data),
-	OF_DEV_AUXDATA("arm,pl18x", 0x80118000, "sdi1",  &mop500_sdi1_data),
-	OF_DEV_AUXDATA("arm,pl18x", 0x80005000, "sdi2",  &mop500_sdi2_data),
-	OF_DEV_AUXDATA("arm,pl18x", 0x80114000, "sdi4",  &mop500_sdi4_data),
 	OF_DEV_AUXDATA("stericsson,ux500-msp-i2s", 0x80123000,
 		       "ux500-msp-i2s.0", &msp0_platform_data),
 	OF_DEV_AUXDATA("stericsson,ux500-msp-i2s", 0x80124000,
-- 
1.7.9.5
