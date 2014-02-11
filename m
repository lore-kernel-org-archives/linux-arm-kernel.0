From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 11 Feb 2014 13:11:27 +0100
Subject: [PATCH] ARM: ux500: drop DMA channel platform data for storage
Message-ID: <1392120687-12572-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The MMC/SD interface driver (MMCI) already supports picking its
DMA channels out of the device tree, so there is no point in
overriding them with identical platform data as well.

Cc: Lee Jones <lee.jones@linaro.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-ux500/board-mop500-sdi.c | 79 ----------------------------------
 1 file changed, 79 deletions(-)

diff --git a/arch/arm/mach-ux500/board-mop500-sdi.c b/arch/arm/mach-ux500/board-mop500-sdi.c
index fcbf3a13a539..0addb1815fa6 100644
--- a/arch/arm/mach-ux500/board-mop500-sdi.c
+++ b/arch/arm/mach-ux500/board-mop500-sdi.c
@@ -11,13 +11,11 @@
 #include <linux/amba/mmci.h>
 #include <linux/mmc/host.h>
 #include <linux/platform_device.h>
-#include <linux/platform_data/dma-ste-dma40.h>
 
 #include <asm/mach-types.h>
 
 #include "db8500-regs.h"
 #include "board-mop500.h"
-#include "ste-dma40-db8500.h"
 
 /*
  * v2 has a new version of this block that need to be forced, the number found
@@ -29,20 +27,6 @@
  * SDI 0 (MicroSD slot)
  */
 
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
 struct mmci_platform_data mop500_sdi0_data = {
 	.f_max		= 100000000,
 	.capabilities	= MMC_CAP_4_BIT_DATA |
@@ -56,30 +40,11 @@ struct mmci_platform_data mop500_sdi0_data = {
 				MCI_ST_CMDDIREN |
 				MCI_ST_DATA0DIREN |
 				MCI_ST_DATA2DIREN,
-#ifdef CONFIG_STE_DMA40
-	.dma_filter	= stedma40_filter,
-	.dma_rx_param	= &mop500_sdi0_dma_cfg_rx,
-	.dma_tx_param	= &mop500_sdi0_dma_cfg_tx,
-#endif
 };
 
 /*
  * SDI1 (SDIO WLAN)
  */
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
 struct mmci_platform_data mop500_sdi1_data = {
 	.ocr_mask	= MMC_VDD_29_30,
 	.f_max		= 100000000,
@@ -87,31 +52,12 @@ struct mmci_platform_data mop500_sdi1_data = {
 				MMC_CAP_NONREMOVABLE,
 	.gpio_cd	= -1,
 	.gpio_wp	= -1,
-#ifdef CONFIG_STE_DMA40
-	.dma_filter	= stedma40_filter,
-	.dma_rx_param	= &sdi1_dma_cfg_rx,
-	.dma_tx_param	= &sdi1_dma_cfg_tx,
-#endif
 };
 
 /*
  * SDI 2 (POP eMMC, not on DB8500ed)
  */
 
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
 struct mmci_platform_data mop500_sdi2_data = {
 	.ocr_mask	= MMC_VDD_165_195,
 	.f_max		= 100000000,
@@ -123,31 +69,11 @@ struct mmci_platform_data mop500_sdi2_data = {
 				MMC_CAP_CMD23,
 	.gpio_cd	= -1,
 	.gpio_wp	= -1,
-#ifdef CONFIG_STE_DMA40
-	.dma_filter	= stedma40_filter,
-	.dma_rx_param	= &mop500_sdi2_dma_cfg_rx,
-	.dma_tx_param	= &mop500_sdi2_dma_cfg_tx,
-#endif
 };
 
 /*
  * SDI 4 (on-board eMMC)
  */
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
 struct mmci_platform_data mop500_sdi4_data = {
 	.f_max		= 100000000,
 	.capabilities	= MMC_CAP_4_BIT_DATA |
@@ -158,9 +84,4 @@ struct mmci_platform_data mop500_sdi4_data = {
 				MMC_CAP_CMD23,
 	.gpio_cd	= -1,
 	.gpio_wp	= -1,
-#ifdef CONFIG_STE_DMA40
-	.dma_filter	= stedma40_filter,
-	.dma_rx_param	= &mop500_sdi4_dma_cfg_rx,
-	.dma_tx_param	= &mop500_sdi4_dma_cfg_tx,
-#endif
 };
-- 
1.8.5.3
