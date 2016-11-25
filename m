From: broonie@kernel.org (Mark Brown)
Date: Fri, 25 Nov 2016 13:10:22 +0000
Subject: Applied "spi: atmel: Use SPI core DMA mapping framework" to the spi
 tree
In-Reply-To: <0539d3d8c41760bbf0536009b07b4bda57265467.1479985886.git.nicolas.ferre@atmel.com>
Message-ID: <E1cAGGk-0005F3-6f@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   spi: atmel: Use SPI core DMA mapping framework

has been applied to the spi tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 04242ca4e8917999ac2bbc3d2b10409661f60272 Mon Sep 17 00:00:00 2001
From: Cyrille Pitchen <cyrille.pitchen@atmel.com>
Date: Thu, 24 Nov 2016 12:24:59 +0100
Subject: [PATCH] spi: atmel: Use SPI core DMA mapping framework

Use the SPI core DMA mapping framework instead of our own
in case of DMA support. PDC support is not converted to this
framework.

The driver is now able to transfer a complete sg list through DMA.
This eventually fix an issue with vmalloc'ed DMA memory that is
provided for example by UBI/UBIFS layers.

Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
[nicolas.ferre at atmel.com: restrict the use to non-PDC DMA]
Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-atmel.c | 57 ++++++++++++++++++++++---------------------------
 1 file changed, 25 insertions(+), 32 deletions(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index 8f20d4f75e4a..7e03e221d307 100644
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
 
@@ -453,6 +451,15 @@ static inline bool atmel_spi_use_dma(struct atmel_spi *as,
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
@@ -720,7 +727,6 @@ static int atmel_spi_next_xfer_dma_submit(struct spi_master *master,
 	struct dma_async_tx_descriptor *txdesc;
 	struct dma_slave_config	slave_config;
 	dma_cookie_t		cookie;
-	u32	len = *plen;
 
 	dev_vdbg(master->dev.parent, "atmel_spi_next_xfer_dma_submit\n");
 
@@ -731,34 +737,22 @@ static int atmel_spi_next_xfer_dma_submit(struct spi_master *master,
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
@@ -804,15 +798,10 @@ static void atmel_spi_next_xfer_data(struct spi_master *master,
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
@@ -1252,7 +1241,7 @@ static int atmel_spi_one_transfer(struct spi_master *master,
 	 * better fault reporting.
 	 */
 	if ((!msg->is_dma_mapped)
-		&& (atmel_spi_use_dma(as, xfer)	|| as->use_pdc)) {
+		&& as->use_pdc) {
 		if (atmel_spi_dma_map_xfer(as, xfer) < 0)
 			return -ENOMEM;
 	}
@@ -1329,7 +1318,7 @@ static int atmel_spi_one_transfer(struct spi_master *master,
 		}
 
 		if (!msg->is_dma_mapped
-			&& (atmel_spi_use_dma(as, xfer) || as->use_pdc))
+			&& as->use_pdc)
 			atmel_spi_dma_unmap_xfer(master, xfer);
 
 		return 0;
@@ -1340,7 +1329,7 @@ static int atmel_spi_one_transfer(struct spi_master *master,
 	}
 
 	if (!msg->is_dma_mapped
-		&& (atmel_spi_use_dma(as, xfer) || as->use_pdc))
+		&& as->use_pdc)
 		atmel_spi_dma_unmap_xfer(master, xfer);
 
 	if (xfer->delay_usecs)
@@ -1518,6 +1507,7 @@ static int atmel_spi_probe(struct platform_device *pdev)
 	master->cleanup = atmel_spi_cleanup;
 	master->auto_runtime_pm = true;
 	master->max_dma_len = SPI_MAX_DMA_XFER;
+	master->can_dma = atmel_spi_can_dma;
 	platform_set_drvdata(pdev, master);
 
 	as = spi_master_get_devdata(master);
@@ -1554,10 +1544,13 @@ static int atmel_spi_probe(struct platform_device *pdev)
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
2.10.2
