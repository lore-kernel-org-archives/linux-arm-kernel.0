From: stefan.xk.nilsson@stericsson.com (Stefan Nilsson XK)
Date: Wed, 26 Oct 2011 10:50:42 +0200
Subject: [PATCH] ARM: ux500: Add device sdi1 for SDIO
Message-ID: <1319619042-17086-1-git-send-email-stefan.xk.nilsson@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds device sdi1 for ST-Ericsson HREFv60 and later to enable
the possiblity of using the onboard CW1200 chip for WLAN.

Signed-off-by: Stefan Nilsson XK <stefan.xk.nilsson@stericsson.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-ux500/board-mop500-sdi.c |   38 ++++++++++++++++++++++++++++++++
 1 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-ux500/board-mop500-sdi.c b/arch/arm/mach-ux500/board-mop500-sdi.c
index 6826fae..cf93dca 100644
--- a/arch/arm/mach-ux500/board-mop500-sdi.c
+++ b/arch/arm/mach-ux500/board-mop500-sdi.c
@@ -132,6 +132,42 @@ void mop500_sdi_tc35892_init(void)
 }
 
 /*
+ * SDI1 (SDIO WLAN)
+ */
+#ifdef CONFIG_STE_DMA40
+static struct stedma40_chan_cfg sdi1_dma_cfg_rx = {
+	.mode = STEDMA40_MODE_LOGICAL,
+	.dir = STEDMA40_PERIPH_TO_MEM,
+	.src_dev_type = DB8500_DMA_DEV32_SD_MM1_RX,
+	.dst_dev_type = STEDMA40_DEV_DST_MEMORY,
+	.src_info.data_width = STEDMA40_WORD_WIDTH,
+	.dst_info.data_width = STEDMA40_WORD_WIDTH,
+};
+
+static struct stedma40_chan_cfg sdi1_dma_cfg_tx = {
+	.mode = STEDMA40_MODE_LOGICAL,
+	.dir = STEDMA40_MEM_TO_PERIPH,
+	.src_dev_type = STEDMA40_DEV_SRC_MEMORY,
+	.dst_dev_type = DB8500_DMA_DEV32_SD_MM1_TX,
+	.src_info.data_width = STEDMA40_WORD_WIDTH,
+	.dst_info.data_width = STEDMA40_WORD_WIDTH,
+};
+#endif
+
+static struct mmci_platform_data mop500_sdi1_data = {
+	.ocr_mask	= MMC_VDD_29_30,
+	.f_max		= 50000000,
+	.capabilities	= MMC_CAP_4_BIT_DATA,
+	.gpio_cd	= -1,
+	.gpio_wp	= -1,
+#ifdef CONFIG_STE_DMA40
+	.dma_filter	= stedma40_filter,
+	.dma_rx_param	= &sdi1_dma_cfg_rx,
+	.dma_tx_param	= &sdi1_dma_cfg_tx,
+#endif
+};
+
+/*
  * SDI 2 (POP eMMC, not on DB8500ed)
  */
 
@@ -260,4 +296,6 @@ void __init hrefv60_sdi_init(void)
 	sdi0_en = HREFV60_SDMMC_EN_GPIO;
 	sdi0_vsel = HREFV60_SDMMC_1V8_3V_GPIO;
 	sdi0_configure();
+
+	db8500_add_sdi1(&mop500_sdi1_data, periphid);
 }
-- 
1.7.7
