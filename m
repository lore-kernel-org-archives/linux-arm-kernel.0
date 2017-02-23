From: fisaksen@baylibre.com (Frode Isaksen)
Date: Thu, 23 Feb 2017 19:01:56 +0100
Subject: [PATCH v3 1/6] spi: davinci: Use SPI framework to handle DMA mapping
In-Reply-To: <1487872921-26628-1-git-send-email-fisaksen@baylibre.com>
References: <1487872921-26628-1-git-send-email-fisaksen@baylibre.com>
Message-ID: <1487872921-26628-2-git-send-email-fisaksen@baylibre.com>
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

Signed-off-by: Fabien Parent <fparent@baylibre.com>
Signed-off-by: Frode Isaksen <fisaksen@baylibre.com>
---
 drivers/spi/spi-davinci.c | 69 +++++++++++++----------------------------------
 1 file changed, 18 insertions(+), 51 deletions(-)

diff --git a/drivers/spi/spi-davinci.c b/drivers/spi/spi-davinci.c
index 02fb967..164cc71 100644
--- a/drivers/spi/spi-davinci.c
+++ b/drivers/spi/spi-davinci.c
@@ -467,6 +467,19 @@ static void davinci_spi_cleanup(struct spi_device *spi)
 		kfree(spicfg);
 }
 
+static bool davinci_spi_can_dma(struct spi_master *master,
+				struct spi_device *spi,
+				struct spi_transfer *xfer)
+{
+	struct davinci_spi_config *spicfg = spi->controller_data;
+	bool can_dma = false;
+
+	if (spicfg)
+		can_dma = spicfg->io_type == SPI_IO_TYPE_DMA;
+
+	return can_dma;
+}
+
 static int davinci_spi_check_error(struct davinci_spi *dspi, int int_status)
 {
 	struct device *sdev = dspi->bitbang.master->dev.parent;
@@ -581,8 +594,6 @@ static int davinci_spi_bufs(struct spi_device *spi, struct spi_transfer *t)
 	struct davinci_spi_config *spicfg;
 	struct davinci_spi_platform_data *pdata;
 	unsigned uninitialized_var(rx_buf_count);
-	void *dummy_buf = NULL;
-	struct scatterlist sg_rx, sg_tx;
 
 	dspi = spi_master_get_devdata(spi->master);
 	pdata = &dspi->pdata;
@@ -630,51 +641,18 @@ static int davinci_spi_bufs(struct spi_device *spi, struct spi_transfer *t)
 		};
 		struct dma_async_tx_descriptor *rxdesc;
 		struct dma_async_tx_descriptor *txdesc;
-		void *buf;
-
-		dummy_buf = kzalloc(t->len, GFP_KERNEL);
-		if (!dummy_buf)
-			goto err_alloc_dummy_buf;
 
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
-		}
-		sg_dma_address(&sg_rx) = t->rx_dma;
-		sg_dma_len(&sg_rx) = t->len;
-
-		sg_init_table(&sg_tx, 1);
-		if (!t->tx_buf)
-			buf = dummy_buf;
-		else
-			buf = (void *)t->tx_buf;
-		t->tx_dma = dma_map_single(&spi->dev, buf,
-				t->len, DMA_TO_DEVICE);
-		if (dma_mapping_error(&spi->dev, t->tx_dma)) {
-			ret = -EFAULT;
-			goto err_tx_map;
-		}
-		sg_dma_address(&sg_tx) = t->tx_dma;
-		sg_dma_len(&sg_tx) = t->len;
-
 		rxdesc = dmaengine_prep_slave_sg(dspi->dma_rx,
-				&sg_rx, 1, DMA_DEV_TO_MEM,
+				t->rx_sg.sgl, t->rx_sg.nents, DMA_DEV_TO_MEM,
 				DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 		if (!rxdesc)
 			goto err_desc;
 
 		txdesc = dmaengine_prep_slave_sg(dspi->dma_tx,
-				&sg_tx, 1, DMA_MEM_TO_DEV,
+				t->tx_sg.sgl, t->tx_sg.nents, DMA_MEM_TO_DEV,
 				DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 		if (!txdesc)
 			goto err_desc;
@@ -710,16 +688,9 @@ static int davinci_spi_bufs(struct spi_device *spi, struct spi_transfer *t)
 	}
 
 	clear_io_bits(dspi->base + SPIINT, SPIINT_MASKALL);
-	if (spicfg->io_type == SPI_IO_TYPE_DMA) {
+	if (spicfg->io_type == SPI_IO_TYPE_DMA)
 		clear_io_bits(dspi->base + SPIINT, SPIINT_DMA_REQ_EN);
 
-		dma_unmap_single(&spi->dev, t->rx_dma,
-				t->len, DMA_FROM_DEVICE);
-		dma_unmap_single(&spi->dev, t->tx_dma,
-				t->len, DMA_TO_DEVICE);
-		kfree(dummy_buf);
-	}
-
 	clear_io_bits(dspi->base + SPIGCR1, SPIGCR1_SPIENA_MASK);
 	set_io_bits(dspi->base + SPIGCR1, SPIGCR1_POWERDOWN_MASK);
 
@@ -742,12 +713,6 @@ static int davinci_spi_bufs(struct spi_device *spi, struct spi_transfer *t)
 	return t->len;
 
 err_desc:
-	dma_unmap_single(&spi->dev, t->tx_dma, t->len, DMA_TO_DEVICE);
-err_tx_map:
-	dma_unmap_single(&spi->dev, t->rx_dma, t->len, DMA_FROM_DEVICE);
-err_rx_map:
-	kfree(dummy_buf);
-err_alloc_dummy_buf:
 	return ret;
 }
 
@@ -988,8 +953,10 @@ static int davinci_spi_probe(struct platform_device *pdev)
 	master->bus_num = pdev->id;
 	master->num_chipselect = pdata->num_chipselect;
 	master->bits_per_word_mask = SPI_BPW_RANGE_MASK(2, 16);
+	master->flags = (SPI_MASTER_MUST_RX | SPI_MASTER_MUST_TX);
 	master->setup = davinci_spi_setup;
 	master->cleanup = davinci_spi_cleanup;
+	master->can_dma = davinci_spi_can_dma;
 
 	dspi->bitbang.chipselect = davinci_spi_chipselect;
 	dspi->bitbang.setup_transfer = davinci_spi_setup_transfer;
-- 
2.7.4
