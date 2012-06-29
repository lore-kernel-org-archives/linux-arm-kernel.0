From: marex@denx.de (Marek Vasut)
Date: Fri, 29 Jun 2012 10:22:54 +0200
Subject: [PATCH 2/8] mmc: spi: Rename IMX2[38]_MMC to IMX2[38]_SSP
In-Reply-To: <1340958180-2291-1-git-send-email-marex@denx.de>
References: <1340958180-2291-1-git-send-email-marex@denx.de>
Message-ID: <1340958180-2291-2-git-send-email-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since the SSP controller can act as both SPI and MMC host,
renaming the enum to properly reflect the naming seems
appropriate.

Based on previous attempt by:
Fabio Estevam <fabio.estevam@freescale.com>

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Chris Ball <cjb@laptop.org>
Cc: Detlev Zundel <dzu@denx.de>
CC: Dong Aisheng <b29396@freescale.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Linux ARM kernel <linux-arm-kernel@lists.infradead.org>
Cc: Rob Herring <rob.herring@calxeda.com>
CC: Shawn Guo <shawn.guo@linaro.org>
Cc: Stefano Babic <sbabic@denx.de>
Cc: Wolfgang Denk <wd@denx.de>
---
 drivers/mmc/host/mxs-mmc.c  |   18 +++++++++---------
 include/linux/spi/mxs-spi.h |    8 ++++----
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
index 6a14e10..97d3df2 100644
--- a/drivers/mmc/host/mxs-mmc.c
+++ b/drivers/mmc/host/mxs-mmc.c
@@ -78,7 +78,7 @@ struct mxs_mmc_host {
 	enum dma_transfer_direction	slave_dirn;
 	u32				ssp_pio_words[SSP_PIO_NUM];
 
-	enum mxs_mmc_id			devid;
+	enum mxs_ssp_id			devid;
 	unsigned char			bus_width;
 	spinlock_t			lock;
 	int				sdio_irq_en;
@@ -601,22 +601,22 @@ static bool mxs_mmc_dma_filter(struct dma_chan *chan, void *param)
 	return true;
 }
 
-static struct platform_device_id mxs_mmc_ids[] = {
+static struct platform_device_id mxs_ssp_ids[] = {
 	{
 		.name = "imx23-mmc",
-		.driver_data = IMX23_MMC,
+		.driver_data = IMX23_SSP,
 	}, {
 		.name = "imx28-mmc",
-		.driver_data = IMX28_MMC,
+		.driver_data = IMX28_SSP,
 	}, {
 		/* sentinel */
 	}
 };
-MODULE_DEVICE_TABLE(platform, mxs_mmc_ids);
+MODULE_DEVICE_TABLE(platform, mxs_ssp_ids);
 
 static const struct of_device_id mxs_mmc_dt_ids[] = {
-	{ .compatible = "fsl,imx23-mmc", .data = (void *) IMX23_MMC, },
-	{ .compatible = "fsl,imx28-mmc", .data = (void *) IMX28_MMC, },
+	{ .compatible = "fsl,imx23-mmc", .data = (void *) IMX23_SSP, },
+	{ .compatible = "fsl,imx28-mmc", .data = (void *) IMX28_SSP, },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, mxs_mmc_dt_ids);
@@ -654,7 +654,7 @@ static int mxs_mmc_probe(struct platform_device *pdev)
 	}
 
 	if (np) {
-		host->devid = (enum mxs_mmc_id) of_id->data;
+		host->devid = (enum mxs_ssp_id) of_id->data;
 		/*
 		 * TODO: This is a temporary solution and should be changed
 		 * to use generic DMA binding later when the helpers get in.
@@ -818,7 +818,7 @@ static const struct dev_pm_ops mxs_mmc_pm_ops = {
 static struct platform_driver mxs_mmc_driver = {
 	.probe		= mxs_mmc_probe,
 	.remove		= mxs_mmc_remove,
-	.id_table	= mxs_mmc_ids,
+	.id_table	= mxs_ssp_ids,
 	.driver		= {
 		.name	= DRIVER_NAME,
 		.owner	= THIS_MODULE,
diff --git a/include/linux/spi/mxs-spi.h b/include/linux/spi/mxs-spi.h
index b7ccd57..c08aef5 100644
--- a/include/linux/spi/mxs-spi.h
+++ b/include/linux/spi/mxs-spi.h
@@ -24,7 +24,7 @@
 #ifndef __LINUX_SPI_MXS_SPI_H__
 #define __LINUX_SPI_MXS_SPI_H__
 
-#define ssp_is_old(host)	((host)->devid == IMX23_MMC)
+#define ssp_is_old(host)	((host)->devid == IMX23_SSP)
 
 /* SSP registers */
 #define HW_SSP_CTRL0				0x000
@@ -101,9 +101,9 @@
 
 #define SSP_PIO_NUM	3
 
-enum mxs_mmc_id {
-	IMX23_MMC,
-	IMX28_MMC,
+enum mxs_ssp_id {
+	IMX23_SSP,
+	IMX28_SSP,
 };
 
 #endif	/* __LINUX_SPI_MXS_SPI_H__ */
-- 
1.7.10
