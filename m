From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Mon, 12 Nov 2012 16:52:28 +0800
Subject: [PATCH 08/17] spi/atmel_spi: Fix spi-atmel driver to adapt to
 slave_config changes
In-Reply-To: <1352710357-3265-1-git-send-email-wenyou.yang@atmel.com>
References: <1352710357-3265-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <1352710357-3265-9-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Richard Genoud <richard.genoud@gmail.com>

This is the following of the patch e2b35f3dbfc080f15b72834d08f04f0269dbe9be

Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
Cc: grant.likely at secretlab.ca
Cc: spi-devel-general at lists.sourceforge.net
---
 drivers/spi/spi-atmel.c |   44 +++++++++++++++++++++++++++++++++++---------
 1 file changed, 35 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index 4cb5f05..00e729b 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -409,14 +409,21 @@ static bool filter(struct dma_chan *chan, void *slave)
 static int __devinit atmel_spi_configure_dma(struct atmel_spi *as)
 {
 	struct at_dma_slave *sdata = (struct at_dma_slave *)&as->data.dma_slave;
+	struct dma_slave_config	slave_config;
+	int err;
+
+	memset(&slave_config, 0, sizeof(slave_config));
+	slave_config.dst_addr = (dma_addr_t)as->phybase + SPI_TDR;
+	slave_config.src_addr = (dma_addr_t)as->phybase + SPI_RDR;
+	slave_config.dst_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
+	slave_config.src_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
+	slave_config.src_maxburst = 1;
+	slave_config.dst_maxburst = 1;
+	slave_config.device_fc = false;
 
 	if (sdata && sdata->dma_dev) {
 		dma_cap_mask_t mask;
 
-		/* setup DMA addresses */
-		sdata->rx_reg = (dma_addr_t)as->phybase + SPI_RDR;
-		sdata->tx_reg = (dma_addr_t)as->phybase + SPI_TDR;
-
 		/* Try to grab two DMA channels */
 		dma_cap_zero(mask);
 		dma_cap_set(DMA_SLAVE, mask);
@@ -426,13 +433,26 @@ static int __devinit atmel_spi_configure_dma(struct atmel_spi *as)
 				dma_request_channel(mask, filter, sdata);
 	}
 	if (!as->dma.chan_rx || !as->dma.chan_tx) {
-		if (as->dma.chan_rx)
-			dma_release_channel(as->dma.chan_rx);
-		if (as->dma.chan_tx)
-			dma_release_channel(as->dma.chan_tx);
 		dev_err(&as->pdev->dev, "DMA channel not available, " \
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
 
 	dev_info(&as->pdev->dev, "Using %s (tx) and " \
@@ -441,6 +461,12 @@ static int __devinit atmel_spi_configure_dma(struct atmel_spi *as)
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
1.7.9.5
