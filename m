From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 31 May 2013 15:56:45 +0200
Subject: [PATCH 2/2] ARM: shmobile: sdhi: remove DMA hardware dependencies
In-Reply-To: <1370008605-3745603-1-git-send-email-arnd@arndb.de>
References: <1370008605-3745603-1-git-send-email-arnd@arndb.de>
Message-ID: <1370008605-3745603-2-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The MMC driver should not need to care what the dma engine
is that it is using, so it must not rely on the argument
to the filter function to be a 'slave_id' value.

Passing the slave id in dmaengine_slave_config is not
portable, and does not work with DT-enabled systems,
so this turns the filter argument into a void pointer
that gets set by the platform code and gets passed
to the dmaengine code as an opaque value.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
Cc: Chris Ball <cjb@laptop.org>
Cc: Samuel Ortiz <sameo@linux.intel.com>
Cc: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-ag5evm.c          |  4 ++--
 arch/arm/mach-shmobile/board-ap4evb.c          |  8 ++++----
 arch/arm/mach-shmobile/board-armadillo800eva.c |  8 ++++----
 arch/arm/mach-shmobile/board-kzm9g.c           |  8 ++++----
 arch/arm/mach-shmobile/board-mackerel.c        | 12 ++++++------
 drivers/mmc/host/sh_mobile_sdhi.c              | 20 +++-----------------
 drivers/mmc/host/tmio_mmc_dma.c                |  6 ++----
 include/linux/mfd/tmio.h                       |  2 --
 include/linux/mmc/sh_mobile_sdhi.h             |  5 +++--
 9 files changed, 28 insertions(+), 45 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ag5evm.c b/arch/arm/mach-shmobile/board-ag5evm.c
index ad01651..cb467fb 100644
--- a/arch/arm/mach-shmobile/board-ag5evm.c
+++ b/arch/arm/mach-shmobile/board-ag5evm.c
@@ -405,8 +405,8 @@ static struct regulator_consumer_supply fixed2v8_power_consumers[] =
 /* SDHI0 */
 static struct sh_mobile_sdhi_info sdhi0_info = {
 #ifdef CONFIG_SH_DMAE_BASE
-	.dma_slave_tx	= SHDMA_SLAVE_SDHI0_TX,
-	.dma_slave_rx	= SHDMA_SLAVE_SDHI0_RX,
+	.dma_slave_tx	= (void *)SHDMA_SLAVE_SDHI0_TX,
+	.dma_slave_rx	= (void *)SHDMA_SLAVE_SDHI0_RX,
 	.dma_filter	= shdma_chan_filter,
 #endif
 	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT | TMIO_MMC_USE_GPIO_CD,
diff --git a/arch/arm/mach-shmobile/board-ap4evb.c b/arch/arm/mach-shmobile/board-ap4evb.c
index c900e24..d7ccb2e 100644
--- a/arch/arm/mach-shmobile/board-ap4evb.c
+++ b/arch/arm/mach-shmobile/board-ap4evb.c
@@ -357,8 +357,8 @@ static struct platform_device sh_mmcif_device = {
 /* SDHI0 */
 static struct sh_mobile_sdhi_info sdhi0_info = {
 #ifdef CONFIG_SH_DMAE_BASE
-	.dma_slave_tx	= SHDMA_SLAVE_SDHI0_TX,
-	.dma_slave_rx	= SHDMA_SLAVE_SDHI0_RX,
+	.dma_slave_tx	= (void *)SHDMA_SLAVE_SDHI0_TX,
+	.dma_slave_rx	= (void *)SHDMA_SLAVE_SDHI0_RX,
 	.dma_filter	= shdma_chan_filter,
 #endif
 	.tmio_caps	= MMC_CAP_SDIO_IRQ,
@@ -398,8 +398,8 @@ static struct platform_device sdhi0_device = {
 /* SDHI1 */
 static struct sh_mobile_sdhi_info sdhi1_info = {
 #ifdef CONFIG_SH_DMAE_BASE
-	.dma_slave_tx	= SHDMA_SLAVE_SDHI1_TX,
-	.dma_slave_rx	= SHDMA_SLAVE_SDHI1_RX,
+	.dma_slave_tx	= (void *)SHDMA_SLAVE_SDHI1_TX,
+	.dma_slave_rx	= (void *)SHDMA_SLAVE_SDHI1_RX,
 	.dma_filter	= shdma_chan_filter,
 #endif
 	.tmio_ocr_mask	= MMC_VDD_165_195,
diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
index e95e5dc..fcea414 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
@@ -690,8 +690,8 @@ static struct platform_device vcc_sdhi1 = {
 #define IRQ31	irq_pin(31)
 static struct sh_mobile_sdhi_info sdhi0_info = {
 #ifdef CONFIG_SH_DMAE_BASE
-	.dma_slave_tx	= SHDMA_SLAVE_SDHI0_TX,
-	.dma_slave_rx	= SHDMA_SLAVE_SDHI0_RX,
+	.dma_slave_tx	= (void *)SHDMA_SLAVE_SDHI0_TX,
+	.dma_slave_rx	= (void *)SHDMA_SLAVE_SDHI0_RX,
 	.dma_filter	= shdma_chan_filter,
 #endif
 	.tmio_caps	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ |
@@ -735,8 +735,8 @@ static struct platform_device sdhi0_device = {
 /* SDHI1 */
 static struct sh_mobile_sdhi_info sdhi1_info = {
 #ifdef CONFIG_SH_DMAE_BASE
-	.dma_slave_tx	= SHDMA_SLAVE_SDHI1_TX,
-	.dma_slave_rx	= SHDMA_SLAVE_SDHI1_RX,
+	.dma_slave_tx	= (void *)SHDMA_SLAVE_SDHI1_TX,
+	.dma_slave_rx	= (void *)SHDMA_SLAVE_SDHI1_RX,
 	.dma_filter	= shdma_chan_filter,
 #endif
 	.tmio_caps	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ |
diff --git a/arch/arm/mach-shmobile/board-kzm9g.c b/arch/arm/mach-shmobile/board-kzm9g.c
index 0434b36..3f3092f 100644
--- a/arch/arm/mach-shmobile/board-kzm9g.c
+++ b/arch/arm/mach-shmobile/board-kzm9g.c
@@ -444,8 +444,8 @@ static struct platform_device vcc_sdhi2 = {
 /* SDHI */
 static struct sh_mobile_sdhi_info sdhi0_info = {
 #ifdef CONFIG_SH_DMAE_BASE
-	.dma_slave_tx	= SHDMA_SLAVE_SDHI0_TX,
-	.dma_slave_rx	= SHDMA_SLAVE_SDHI0_RX,
+	.dma_slave_tx	= (void *)SHDMA_SLAVE_SDHI0_TX,
+	.dma_slave_rx	= (void *)SHDMA_SLAVE_SDHI0_RX,
 	.dma_filter	= shdma_chan_filter,
 #endif
 	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT,
@@ -489,8 +489,8 @@ static struct platform_device sdhi0_device = {
 /* Micro SD */
 static struct sh_mobile_sdhi_info sdhi2_info = {
 #ifdef CONFIG_SH_DMAE_BASE
-	.dma_slave_tx	= SHDMA_SLAVE_SDHI2_TX,
-	.dma_slave_rx	= SHDMA_SLAVE_SDHI2_RX,
+	.dma_slave_tx	= (void *)SHDMA_SLAVE_SDHI2_TX,
+	.dma_slave_rx	= (void *)SHDMA_SLAVE_SDHI2_RX,
 	.dma_filter	= shdma_chan_filter,
 #endif
 	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT |
diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index 49755ff..4522b76 100644
--- a/arch/arm/mach-shmobile/board-mackerel.c
+++ b/arch/arm/mach-shmobile/board-mackerel.c
@@ -973,8 +973,8 @@ static struct platform_device nand_flash_device = {
 /* SDHI0 */
 static struct sh_mobile_sdhi_info sdhi0_info = {
 #ifdef CONFIG_SH_DMAE_BASE
-	.dma_slave_tx	= SHDMA_SLAVE_SDHI0_TX,
-	.dma_slave_rx	= SHDMA_SLAVE_SDHI0_RX,
+	.dma_slave_tx	= (void *)SHDMA_SLAVE_SDHI0_TX,
+	.dma_slave_rx	= (void *)SHDMA_SLAVE_SDHI0_RX,
 	.dma_filter	= shdma_chan_filter,
 #endif
 	.tmio_flags	= TMIO_MMC_USE_GPIO_CD,
@@ -1015,8 +1015,8 @@ static struct platform_device sdhi0_device = {
 /* GPIO 41 can trigger IRQ8, but it is used by USBHS1, we have to poll */
 static struct sh_mobile_sdhi_info sdhi1_info = {
 #ifdef CONFIG_SH_DMAE_BASE
-	.dma_slave_tx	= SHDMA_SLAVE_SDHI1_TX,
-	.dma_slave_rx	= SHDMA_SLAVE_SDHI1_RX,
+	.dma_slave_tx	= (void *)SHDMA_SLAVE_SDHI1_TX,
+	.dma_slave_rx	= (void *)SHDMA_SLAVE_SDHI1_RX,
 	.dma_filter	= shdma_chan_filter,
 #endif
 	.tmio_flags	= TMIO_MMC_WRPROTECT_DISABLE | TMIO_MMC_USE_GPIO_CD,
@@ -1061,8 +1061,8 @@ static struct platform_device sdhi1_device = {
  */
 static struct sh_mobile_sdhi_info sdhi2_info = {
 #ifdef CONFIG_SH_DMAE_BASE
-	.dma_slave_tx	= SHDMA_SLAVE_SDHI2_TX,
-	.dma_slave_rx	= SHDMA_SLAVE_SDHI2_RX,
+	.dma_slave_tx	= (void *)SHDMA_SLAVE_SDHI2_TX,
+	.dma_slave_rx	= (void *)SHDMA_SLAVE_SDHI2_RX,
 	.dma_filter	= shdma_chan_filter,
 #endif
 	.tmio_flags	= TMIO_MMC_WRPROTECT_DISABLE | TMIO_MMC_USE_GPIO_CD,
diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index efe3386..c4a0aab 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -185,23 +185,9 @@ static int sh_mobile_sdhi_probe(struct platform_device *pdev)
 		if (p->get_cd)
 			mmc_data->get_cd = sh_mobile_sdhi_get_cd;
 
-		if (p->dma_slave_tx > 0 && p->dma_slave_rx > 0) {
-			/*
-			 * Yes, we have to provide slave IDs twice to TMIO:
-			 * once as a filter parameter and once for channel
-			 * configuration as an explicit slave ID
-			 */
-			dma_priv->chan_priv_tx = (void *)p->dma_slave_tx;
-			dma_priv->chan_priv_rx = (void *)p->dma_slave_rx;
-			/*
-			 * This is a layering violation: the slave driver
-			 * should not be aware that the chan_priv_* is the
-			 * slave id.
-			 * We should not really need to set the slave id
-			 * here anyway. -arnd
-			 */
-			dma_priv->slave_id_tx = p->dma_slave_tx;
-			dma_priv->slave_id_rx = p->dma_slave_rx;
+		if (p->dma_slave_tx && p->dma_slave_rx) {
+			dma_priv->chan_priv_tx = p->dma_slave_tx;
+			dma_priv->chan_priv_rx = p->dma_slave_rx;
 			dma_priv->filter = p->dma_filter;
 		}
 	}
diff --git a/drivers/mmc/host/tmio_mmc_dma.c b/drivers/mmc/host/tmio_mmc_dma.c
index 47bdb8f..caad28e 100644
--- a/drivers/mmc/host/tmio_mmc_dma.c
+++ b/drivers/mmc/host/tmio_mmc_dma.c
@@ -290,8 +290,7 @@ void tmio_mmc_request_dma(struct tmio_mmc_host *host, struct tmio_mmc_data *pdat
 		if (!host->chan_tx)
 			return;
 
-		if (pdata->dma->chan_priv_tx)
-			cfg.slave_id = pdata->dma->slave_id_tx;
+		cfg.slave_id = 0; /* already set */
 		cfg.direction = DMA_MEM_TO_DEV;
 		cfg.dst_addr = res->start + (CTL_SD_DATA_PORT << host->bus_shift);
 		cfg.src_addr = 0;
@@ -308,8 +307,7 @@ void tmio_mmc_request_dma(struct tmio_mmc_host *host, struct tmio_mmc_data *pdat
 		if (!host->chan_rx)
 			goto ereqrx;
 
-		if (pdata->dma->chan_priv_rx)
-			cfg.slave_id = pdata->dma->slave_id_rx;
+		cfg.slave_id = 0;
 		cfg.direction = DMA_DEV_TO_MEM;
 		cfg.src_addr = cfg.dst_addr;
 		cfg.dst_addr = 0;
diff --git a/include/linux/mfd/tmio.h b/include/linux/mfd/tmio.h
index ce35113..0990d8a 100644
--- a/include/linux/mfd/tmio.h
+++ b/include/linux/mfd/tmio.h
@@ -86,8 +86,6 @@ struct dma_chan;
 struct tmio_mmc_dma {
 	void *chan_priv_tx;
 	void *chan_priv_rx;
-	int slave_id_tx;
-	int slave_id_rx;
 	int alignment_shift;
 	bool (*filter)(struct dma_chan *chan, void *arg);
 };
diff --git a/include/linux/mmc/sh_mobile_sdhi.h b/include/linux/mmc/sh_mobile_sdhi.h
index 342f07b..66a7d1c 100644
--- a/include/linux/mmc/sh_mobile_sdhi.h
+++ b/include/linux/mmc/sh_mobile_sdhi.h
@@ -2,6 +2,7 @@
 #define LINUX_MMC_SH_MOBILE_SDHI_H
 
 #include <linux/types.h>
+#include <linux/dmaengine.h>
 
 struct platform_device;
 
@@ -18,8 +19,8 @@ struct sh_mobile_sdhi_ops {
 };
 
 struct sh_mobile_sdhi_info {
-	int dma_slave_tx;
-	int dma_slave_rx;
+	void *dma_slave_tx;
+	void *dma_slave_rx;
 	dma_filter_fn dma_filter;
 	unsigned long tmio_flags;
 	unsigned long tmio_caps;
-- 
1.8.1.2
