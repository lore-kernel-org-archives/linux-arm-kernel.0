From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Fri, 04 Nov 2016 17:14:50 +0100
Subject: [PATCH RFC 3/7] spi: s3c64xx: Do not use platform_data for DMA
 parameters
In-Reply-To: <1478276094-19135-1-git-send-email-s.nawrocki@samsung.com>
References: <1478276094-19135-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <1478276094-19135-5-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All related platforms use either devicetree or the DMA slave
map API for mapping DMA channels to DMA slaves so we can now
stop using platform_data for passing DMA details.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 drivers/spi/spi-s3c64xx.c | 21 ++++-----------------
 1 file changed, 4 insertions(+), 17 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 3c09e94..28dfdce 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -341,27 +341,20 @@ static void s3c64xx_spi_set_cs(struct spi_device *spi, bool enable)
 static int s3c64xx_spi_prepare_transfer(struct spi_master *spi)
 {
 	struct s3c64xx_spi_driver_data *sdd = spi_master_get_devdata(spi);
-	dma_filter_fn filter = sdd->cntrlr_info->filter;
 	struct device *dev = &sdd->pdev->dev;
-	dma_cap_mask_t mask;
 
 	if (is_polling(sdd))
 		return 0;
 
-	dma_cap_zero(mask);
-	dma_cap_set(DMA_SLAVE, mask);
-
 	/* Acquire DMA channels */
-	sdd->rx_dma.ch = dma_request_slave_channel_compat(mask, filter,
-			   sdd->cntrlr_info->dma_rx, dev, "rx");
+	sdd->rx_dma.ch = dma_request_slave_channel(dev, "rx");
 	if (!sdd->rx_dma.ch) {
 		dev_err(dev, "Failed to get RX DMA channel\n");
 		return -EBUSY;
 	}
 	spi->dma_rx = sdd->rx_dma.ch;
 
-	sdd->tx_dma.ch = dma_request_slave_channel_compat(mask, filter,
-			   sdd->cntrlr_info->dma_tx, dev, "tx");
+	sdd->tx_dma.ch = dma_request_slave_channel(dev, "tx");
 	if (!sdd->tx_dma.ch) {
 		dev_err(dev, "Failed to get TX DMA channel\n");
 		dma_release_channel(sdd->rx_dma.ch);
@@ -1091,11 +1084,6 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
 
 	sdd->cur_bpw = 8;
 
-	if (!sdd->pdev->dev.of_node && (!sci->dma_tx || !sci->dma_rx)) {
-		dev_warn(&pdev->dev, "Unable to get SPI tx/rx DMA data. Switching to poll mode\n");
-		sdd->port_conf->quirks = S3C64XX_SPI_QUIRK_POLL;
-	}
-
 	sdd->tx_dma.direction = DMA_MEM_TO_DEV;
 	sdd->rx_dma.direction = DMA_DEV_TO_MEM;
 
@@ -1205,9 +1193,8 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
 
 	dev_dbg(&pdev->dev, "Samsung SoC SPI Driver loaded for Bus SPI-%d with %d Slaves attached\n",
 					sdd->port_id, master->num_chipselect);
-	dev_dbg(&pdev->dev, "\tIOmem=[%pR]\tFIFO %dbytes\tDMA=[Rx-%p, Tx-%p]\n",
-					mem_res, (FIFO_LVL_MASK(sdd) >> 1) + 1,
-					sci->dma_rx, sci->dma_tx);
+	dev_dbg(&pdev->dev, "\tIOmem=[%pR]\tFIFO %dbytes\n",
+					mem_res, (FIFO_LVL_MASK(sdd) >> 1) + 1);
 
 	pm_runtime_mark_last_busy(&pdev->dev);
 	pm_runtime_put_autosuspend(&pdev->dev);
-- 
1.9.1
