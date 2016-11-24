From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 24 Nov 2016 12:24:59 +0100
Subject: [PATCH 3/5] spi: atmel: Use SPI core DMA mapping framework
In-Reply-To: <cover.1479985886.git.nicolas.ferre@atmel.com>
References: <cover.1479985886.git.nicolas.ferre@atmel.com>
Message-ID: <0539d3d8c41760bbf0536009b07b4bda57265467.1479985886.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Cyrille Pitchen <cyrille.pitchen@atmel.com>

Use the SPI core DMA mapping framework instead of our own
in case of DMA support. PDC support is not converted to this
framework.

The driver is now able to transfer a complete sg list through DMA.
This eventually fix an issue with vmalloc'ed DMA memory that is
provided for example by UBI/UBIFS layers.

Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
[nicolas.ferre at atmel.com: restrict the use to non-PDC DMA]
Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 drivers/spi/spi-atmel.c | 57 ++++++++++++++++++++++---------------------------
 1 file changed, 25 insertions(+), 32 deletions(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index d0a56e11e148..f62bc2d27c9e 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -268,8 +268,6 @@
 struct atmel_spi_dma {
 	struct dma_chan			*chan_rx;
 	struct dma_chan			*chan_tx;
-	struct scatterlist		sgrx;
-	struct scatterlist		sgtx;
 	struct dma_async_tx_descriptor	*data_desc_rx;
 	struct dma_async_tx_descriptor	*data_desc_tx;
 
@@ -454,6 +452,15 @@ static inline bool atmel_spi_use_dma(struct atmel_spi *as,
 	return as->use_dma && xfer->len >= DMA_MIN_BYTES;
 }
 
+static bool atmel_spi_can_dma(struct spi_master *master,
+			      struct spi_device *spi,
+			      struct spi_transfer *xfer)
+{
+	struct atmel_spi *as = spi_master_get_devdata(master);
+
+	return atmel_spi_use_dma(as, xfer);
+}
+
 static int atmel_spi_dma_slave_config(struct atmel_spi *as,
 				struct dma_slave_config *slave_config,
 				u8 bits_per_word)
@@ -721,7 +728,6 @@ static int atmel_spi_next_xfer_dma_submit(struct spi_master *master,
 	struct dma_async_tx_descriptor *txdesc;
 	struct dma_slave_config	slave_config;
 	dma_cookie_t		cookie;
-	u32	len = *plen;
 
 	dev_vdbg(master->dev.parent, "atmel_spi_next_xfer_dma_submit\n");
 
@@ -732,34 +738,22 @@ static int atmel_spi_next_xfer_dma_submit(struct spi_master *master,
 	/* release lock for DMA operations */
 	atmel_spi_unlock(as);
 
-	/* prepare the RX dma transfer */
-	sg_init_table(&as->dma.sgrx, 1);
-	as->dma.sgrx.dma_address = xfer->rx_dma + xfer->len - *plen;
-
-	/* prepare the TX dma transfer */
-	sg_init_table(&as->dma.sgtx, 1);
-	as->dma.sgtx.dma_address = xfer->tx_dma + xfer->len - *plen;
-
-	if (len > master->max_dma_len)
-		len = master->max_dma_len;
-
-	sg_dma_len(&as->dma.sgtx) = len;
-	sg_dma_len(&as->dma.sgrx) = len;
-
-	*plen = len;
+	*plen = xfer->len;
 
 	if (atmel_spi_dma_slave_config(as, &slave_config,
 				       xfer->bits_per_word))
 		goto err_exit;
 
 	/* Send both scatterlists */
-	rxdesc = dmaengine_prep_slave_sg(rxchan, &as->dma.sgrx, 1,
+	rxdesc = dmaengine_prep_slave_sg(rxchan,
+					 xfer->rx_sg.sgl, xfer->rx_sg.nents,
 					 DMA_FROM_DEVICE,
 					 DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 	if (!rxdesc)
 		goto err_dma;
 
-	txdesc = dmaengine_prep_slave_sg(txchan, &as->dma.sgtx, 1,
+	txdesc = dmaengine_prep_slave_sg(txchan,
+					 xfer->tx_sg.sgl, xfer->tx_sg.nents,
 					 DMA_TO_DEVICE,
 					 DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 	if (!txdesc)
@@ -805,15 +799,10 @@ static void atmel_spi_next_xfer_data(struct spi_master *master,
 				dma_addr_t *rx_dma,
 				u32 *plen)
 {
-	struct atmel_spi	*as = spi_master_get_devdata(master);
-	u32			len = *plen;
-
 	*rx_dma = xfer->rx_dma + xfer->len - *plen;
 	*tx_dma = xfer->tx_dma + xfer->len - *plen;
-	if (len > master->max_dma_len)
-		len = master->max_dma_len;
-
-	*plen = len;
+	if (*plen > master->max_dma_len)
+		*plen = master->max_dma_len;
 }
 
 static int atmel_spi_set_xfer_speed(struct atmel_spi *as,
@@ -1253,7 +1242,7 @@ static int atmel_spi_one_transfer(struct spi_master *master,
 	 * better fault reporting.
 	 */
 	if ((!msg->is_dma_mapped)
-		&& (atmel_spi_use_dma(as, xfer)	|| as->use_pdc)) {
+		&& as->use_pdc) {
 		if (atmel_spi_dma_map_xfer(as, xfer) < 0)
 			return -ENOMEM;
 	}
@@ -1330,7 +1319,7 @@ static int atmel_spi_one_transfer(struct spi_master *master,
 		}
 
 		if (!msg->is_dma_mapped
-			&& (atmel_spi_use_dma(as, xfer) || as->use_pdc))
+			&& as->use_pdc)
 			atmel_spi_dma_unmap_xfer(master, xfer);
 
 		return 0;
@@ -1341,7 +1330,7 @@ static int atmel_spi_one_transfer(struct spi_master *master,
 	}
 
 	if (!msg->is_dma_mapped
-		&& (atmel_spi_use_dma(as, xfer) || as->use_pdc))
+		&& as->use_pdc)
 		atmel_spi_dma_unmap_xfer(master, xfer);
 
 	if (xfer->delay_usecs)
@@ -1519,6 +1508,7 @@ static int atmel_spi_probe(struct platform_device *pdev)
 	master->cleanup = atmel_spi_cleanup;
 	master->auto_runtime_pm = true;
 	master->max_dma_len = SPI_MAX_DMA_XFER;
+	master->can_dma = atmel_spi_can_dma;
 	platform_set_drvdata(pdev, master);
 
 	as = spi_master_get_devdata(master);
@@ -1555,10 +1545,13 @@ static int atmel_spi_probe(struct platform_device *pdev)
 	as->use_pdc = false;
 	if (as->caps.has_dma_support) {
 		ret = atmel_spi_configure_dma(as);
-		if (ret == 0)
+		if (ret == 0) {
+			master->dma_tx = as->dma.chan_tx;
+			master->dma_rx = as->dma.chan_rx;
 			as->use_dma = true;
-		else if (ret == -EPROBE_DEFER)
+		} else if (ret == -EPROBE_DEFER) {
 			return ret;
+		}
 	} else {
 		as->use_pdc = true;
 	}
-- 
2.9.0
