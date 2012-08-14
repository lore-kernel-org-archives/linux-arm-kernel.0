From: richard.genoud@gmail.com (Richard Genoud)
Date: Tue, 14 Aug 2012 15:49:26 +0200
Subject: [PATCH 12/23] spi-atmel: Fix spi-atmel driver to adapt to
 slave_config changes
In-Reply-To: <1344952177-18385-1-git-send-email-richard.genoud@gmail.com>
References: <1344952177-18385-1-git-send-email-richard.genoud@gmail.com>
Message-ID: <1344952177-18385-13-git-send-email-richard.genoud@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the following of the patch e2b35f3dbfc080f15b72834d08f04f0269dbe9be

Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
---
 drivers/spi/spi-atmel.c |   45 ++++++++++++++++++++++++++++++++++++---------
 1 files changed, 36 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index d90e8fb..28a00ab 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -399,17 +399,24 @@ static int __devinit atmel_spi_configure_dma(struct spi_master *master)
 {
 	struct atmel_spi	*as = spi_master_get_devdata(master);
 	struct device		*controller = master->dev.parent;
+	struct dma_slave_config slave_config;
 	struct at_dma_slave	*sdata;
+	int err;
 
 	sdata = controller->platform_data;
 
+	memset(&slave_config, 0, sizeof(slave_config));
+	slave_config.dst_addr = (dma_addr_t)as->phybase + SPI_TDR;
+	slave_config.src_addr = (dma_addr_t)as->phybase + SPI_RDR;
+	slave_config.dst_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
+	slave_config.src_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
+	slave_config.src_maxburst = 1;
+	slave_config.dst_maxburst = 1;
+	slave_config.device_fc = false;
+
 	if (sdata && sdata->dma_dev) {
 		dma_cap_mask_t mask;
 
-		/* setup DMA addresses */
-		sdata->rx_reg = (dma_addr_t)as->phybase + SPI_RDR;
-		sdata->tx_reg = (dma_addr_t)as->phybase + SPI_TDR;
-
 		/* Try to grab two DMA channels */
 		dma_cap_zero(mask);
 		dma_cap_set(DMA_SLAVE, mask);
@@ -417,14 +424,28 @@ static int __devinit atmel_spi_configure_dma(struct spi_master *master)
 		if (as->dma.chan_tx)
 			as->dma.chan_rx = dma_request_channel(mask, filter, sdata);
 	}
+
 	if (!as->dma.chan_rx || !as->dma.chan_tx) {
-		if (as->dma.chan_rx)
-			dma_release_channel(as->dma.chan_rx);
-		if (as->dma.chan_tx)
-			dma_release_channel(as->dma.chan_tx);
 		dev_err(&as->pdev->dev, "DMA channel not available, "
 					"unable to use SPI\n");
-		return -EBUSY;
+		err = -EBUSY;
+		goto error;
+	}
+
+	slave_config.direction = DMA_TO_DEVICE;
+	if (dmaengine_slave_config(as->dma.chan_tx, &slave_config)) {
+		dev_err(&as->pdev->dev,
+			"failed to configure tx dma channel\n");
+		err = -EINVAL;
+		goto error;
+	}
+
+	slave_config.direction = DMA_FROM_DEVICE;
+	if (dmaengine_slave_config(as->dma.chan_rx, &slave_config)) {
+		dev_err(&as->pdev->dev,
+			"failed to configure rx dma channel\n");
+		err = -EINVAL;
+		goto error;
 	}
 
 	dev_info(&as->pdev->dev, "Using %s (tx) and "
@@ -433,6 +454,12 @@ static int __devinit atmel_spi_configure_dma(struct spi_master *master)
 				dma_chan_name(as->dma.chan_rx));
 
 	return 0;
+error:
+	if (as->dma.chan_rx)
+		dma_release_channel(as->dma.chan_rx);
+	if (as->dma.chan_tx)
+		dma_release_channel(as->dma.chan_tx);
+	return err;
 }
 
 static void atmel_spi_stop_dma(struct atmel_spi *as)
-- 
1.7.2.5
