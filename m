From: fisaksen@baylibre.com (Frode Isaksen)
Date: Fri, 10 Feb 2017 16:29:37 +0100
Subject: [PATCH 1/8] spi: davinci: Use SPI framework to handle DMA mapping
In-Reply-To: <1486740584-17875-1-git-send-email-fisaksen@baylibre.com>
References: <1486740584-17875-1-git-send-email-fisaksen@baylibre.com>
Message-ID: <1486740584-17875-2-git-send-email-fisaksen@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabien Parent <fparent@baylibre.com>

Uppers layers like MTD can pass vmalloc'd buffers to the SPI driver,
and the current implementation will fail to map these kind of buffers.
The SPI framework is able to detect the best way to handle and map
buffers.
This commit updates the davinci SPI driver in order to use the SPI
framework to handle the DMA mapping of buffers coming from an upper
layer.
Note that the dummy buffer used when doing one-way transfer, must
still be mapped in this module.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 drivers/spi/spi-davinci.c | 80 ++++++++++++++++++++++++++++-------------------
 1 file changed, 48 insertions(+), 32 deletions(-)

diff --git a/drivers/spi/spi-davinci.c b/drivers/spi/spi-davinci.c
index 02fb967..84c0d76 100644
--- a/drivers/spi/spi-davinci.c
+++ b/drivers/spi/spi-davinci.c
@@ -467,6 +467,20 @@ static void davinci_spi_cleanup(struct spi_device *spi)
 		kfree(spicfg);
 }
 
+static inline bool __davinci_spi_can_dma(struct spi_device *spi)
+{
+	struct davinci_spi_config *spicfg = spi->controller_data;
+
+	return spicfg ? spicfg->io_type == SPI_IO_TYPE_DMA : false;
+}
+
+static bool davinci_spi_can_dma(struct spi_master *master,
+				struct spi_device *spi,
+				struct spi_transfer *xfer)
+{
+	return __davinci_spi_can_dma(spi);
+}
+
 static int davinci_spi_check_error(struct davinci_spi *dspi, int int_status)
 {
 	struct device *sdev = dspi->bitbang.master->dev.parent;
@@ -630,7 +644,6 @@ static int davinci_spi_bufs(struct spi_device *spi, struct spi_transfer *t)
 		};
 		struct dma_async_tx_descriptor *rxdesc;
 		struct dma_async_tx_descriptor *txdesc;
-		void *buf;
 
 		dummy_buf = kzalloc(t->len, GFP_KERNEL);
 		if (!dummy_buf)
@@ -639,42 +652,40 @@ static int davinci_spi_bufs(struct spi_device *spi, struct spi_transfer *t)
 		dmaengine_slave_config(dspi->dma_rx, &dma_rx_conf);
 		dmaengine_slave_config(dspi->dma_tx, &dma_tx_conf);
 
-		sg_init_table(&sg_rx, 1);
-		if (!t->rx_buf)
-			buf = dummy_buf;
-		else
-			buf = t->rx_buf;
-		t->rx_dma = dma_map_single(&spi->dev, buf,
-				t->len, DMA_FROM_DEVICE);
-		if (dma_mapping_error(&spi->dev, !t->rx_dma)) {
-			ret = -EFAULT;
-			goto err_rx_map;
+		if (!t->rx_buf) {
+			sg_init_table(&sg_rx, 1);
+			t->rx_dma = dma_map_single(&spi->dev, dummy_buf,
+					t->len, DMA_FROM_DEVICE);
+			if (dma_mapping_error(&spi->dev, !t->rx_dma)) {
+				ret = -EFAULT;
+				goto err_rx_map;
+			}
+			sg_dma_address(&sg_rx) = t->rx_dma;
+			sg_dma_len(&sg_rx) = t->len;
 		}
-		sg_dma_address(&sg_rx) = t->rx_dma;
-		sg_dma_len(&sg_rx) = t->len;
 
 		sg_init_table(&sg_tx, 1);
-		if (!t->tx_buf)
-			buf = dummy_buf;
-		else
-			buf = (void *)t->tx_buf;
-		t->tx_dma = dma_map_single(&spi->dev, buf,
-				t->len, DMA_TO_DEVICE);
-		if (dma_mapping_error(&spi->dev, t->tx_dma)) {
-			ret = -EFAULT;
-			goto err_tx_map;
+		if (!t->tx_buf) {
+			t->tx_dma = dma_map_single(&spi->dev, dummy_buf,
+					t->len, DMA_TO_DEVICE);
+			if (dma_mapping_error(&spi->dev, t->tx_dma)) {
+				ret = -EFAULT;
+				goto err_tx_map;
+			}
+			sg_dma_address(&sg_tx) = t->tx_dma;
+			sg_dma_len(&sg_tx) = t->len;
 		}
-		sg_dma_address(&sg_tx) = t->tx_dma;
-		sg_dma_len(&sg_tx) = t->len;
 
 		rxdesc = dmaengine_prep_slave_sg(dspi->dma_rx,
-				&sg_rx, 1, DMA_DEV_TO_MEM,
+				t->rx_sg.sgl ?: &sg_rx, t->rx_sg.nents ?: 1,
+				DMA_DEV_TO_MEM,
 				DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 		if (!rxdesc)
 			goto err_desc;
 
 		txdesc = dmaengine_prep_slave_sg(dspi->dma_tx,
-				&sg_tx, 1, DMA_MEM_TO_DEV,
+				t->tx_sg.sgl ?: &sg_tx, t->tx_sg.nents ?: 1,
+				DMA_MEM_TO_DEV,
 				DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 		if (!txdesc)
 			goto err_desc;
@@ -713,10 +724,12 @@ static int davinci_spi_bufs(struct spi_device *spi, struct spi_transfer *t)
 	if (spicfg->io_type == SPI_IO_TYPE_DMA) {
 		clear_io_bits(dspi->base + SPIINT, SPIINT_DMA_REQ_EN);
 
-		dma_unmap_single(&spi->dev, t->rx_dma,
-				t->len, DMA_FROM_DEVICE);
-		dma_unmap_single(&spi->dev, t->tx_dma,
-				t->len, DMA_TO_DEVICE);
+		if (!t->rx_buf)
+			dma_unmap_single(&spi->dev, t->rx_dma,
+					t->len, DMA_FROM_DEVICE);
+		if (!t->tx_buf)
+			dma_unmap_single(&spi->dev, t->tx_dma,
+					t->len, DMA_TO_DEVICE);
 		kfree(dummy_buf);
 	}
 
@@ -742,9 +755,11 @@ static int davinci_spi_bufs(struct spi_device *spi, struct spi_transfer *t)
 	return t->len;
 
 err_desc:
-	dma_unmap_single(&spi->dev, t->tx_dma, t->len, DMA_TO_DEVICE);
+	if (!t->tx_buf)
+		dma_unmap_single(&spi->dev, t->tx_dma, t->len, DMA_TO_DEVICE);
 err_tx_map:
-	dma_unmap_single(&spi->dev, t->rx_dma, t->len, DMA_FROM_DEVICE);
+	if (!t->rx_buf)
+		dma_unmap_single(&spi->dev, t->rx_dma, t->len, DMA_FROM_DEVICE);
 err_rx_map:
 	kfree(dummy_buf);
 err_alloc_dummy_buf:
@@ -990,6 +1005,7 @@ static int davinci_spi_probe(struct platform_device *pdev)
 	master->bits_per_word_mask = SPI_BPW_RANGE_MASK(2, 16);
 	master->setup = davinci_spi_setup;
 	master->cleanup = davinci_spi_cleanup;
+	master->can_dma = davinci_spi_can_dma;
 
 	dspi->bitbang.chipselect = davinci_spi_chipselect;
 	dspi->bitbang.setup_transfer = davinci_spi_setup_transfer;
-- 
2.7.4
