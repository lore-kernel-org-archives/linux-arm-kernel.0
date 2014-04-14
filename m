From: 21cnbao@gmail.com (Barry Song)
Date: Mon, 14 Apr 2014 14:30:00 +0800
Subject: [PATCH 4/5] spi: sirf: fix line over 80 characters style issue
In-Reply-To: <1397457001-5266-1-git-send-email-21cnbao@gmail.com>
References: <1397457001-5266-1-git-send-email-21cnbao@gmail.com>
Message-ID: <1397457001-5266-5-git-send-email-21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Qipan Li <Qipan.Li@csr.com>

fix a lot of "line over 80 characters" checkpatch issues, on which
the users of the driver, key customers care about this very much.

Signed-off-by: Qipan Li <Qipan.Li@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 drivers/spi/spi-sirf.c |   51 ++++++++++++++++++++++++++++++-----------------
 1 files changed, 32 insertions(+), 19 deletions(-)

diff --git a/drivers/spi/spi-sirf.c b/drivers/spi/spi-sirf.c
index 67d8909..3c12f39 100644
--- a/drivers/spi/spi-sirf.c
+++ b/drivers/spi/spi-sirf.c
@@ -382,14 +382,16 @@ static int spi_sirfsoc_transfer(struct spi_device *spi, struct spi_transfer *t)
 	if (IS_DMA_VALID(t)) {
 		struct dma_async_tx_descriptor *rx_desc, *tx_desc;
 
-		sspi->dst_start = dma_map_single(&spi->dev, sspi->rx, t->len, DMA_FROM_DEVICE);
+		sspi->dst_start = dma_map_single(&spi->dev,
+				sspi->rx, t->len, DMA_FROM_DEVICE);
 		rx_desc = dmaengine_prep_slave_single(sspi->rx_chan,
 			sspi->dst_start, t->len, DMA_DEV_TO_MEM,
 			DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 		rx_desc->callback = spi_sirfsoc_dma_fini_callback;
 		rx_desc->callback_param = &sspi->rx_done;
 
-		sspi->src_start = dma_map_single(&spi->dev, (void *)sspi->tx, t->len, DMA_TO_DEVICE);
+		sspi->src_start = dma_map_single(&spi->dev,
+				(void *)sspi->tx, t->len, DMA_TO_DEVICE);
 		tx_desc = dmaengine_prep_slave_single(sspi->tx_chan,
 			sspi->src_start, t->len, DMA_MEM_TO_DEV,
 			DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
@@ -404,13 +406,18 @@ static int spi_sirfsoc_transfer(struct spi_device *spi, struct spi_transfer *t)
 		/* Send the first word to trigger the whole tx/rx process */
 		sspi->tx_word(sspi);
 
-		writel(SIRFSOC_SPI_RX_OFLOW_INT_EN | SIRFSOC_SPI_TX_UFLOW_INT_EN |
-			SIRFSOC_SPI_RXFIFO_THD_INT_EN | SIRFSOC_SPI_TXFIFO_THD_INT_EN |
-			SIRFSOC_SPI_FRM_END_INT_EN | SIRFSOC_SPI_RXFIFO_FULL_INT_EN |
-			SIRFSOC_SPI_TXFIFO_EMPTY_INT_EN, sspi->base + SIRFSOC_SPI_INT_EN);
+		writel(SIRFSOC_SPI_RX_OFLOW_INT_EN |
+			SIRFSOC_SPI_TX_UFLOW_INT_EN |
+			SIRFSOC_SPI_RXFIFO_THD_INT_EN |
+			SIRFSOC_SPI_TXFIFO_THD_INT_EN |
+			SIRFSOC_SPI_FRM_END_INT_EN |
+			SIRFSOC_SPI_RXFIFO_FULL_INT_EN |
+			SIRFSOC_SPI_TXFIFO_EMPTY_INT_EN,
+			sspi->base + SIRFSOC_SPI_INT_EN);
 	}
 
-	writel(SIRFSOC_SPI_RX_EN | SIRFSOC_SPI_TX_EN, sspi->base + SIRFSOC_SPI_TX_RX_EN);
+	writel(SIRFSOC_SPI_RX_EN | SIRFSOC_SPI_TX_EN,
+			sspi->base + SIRFSOC_SPI_TX_RX_EN);
 
 	if (!IS_DMA_VALID(t)) { /* for PIO */
 		if (wait_for_completion_timeout(&sspi->rx_done, timeout) == 0)
@@ -434,8 +441,10 @@ static int spi_sirfsoc_transfer(struct spi_device *spi, struct spi_transfer *t)
 	}
 
 	if (IS_DMA_VALID(t)) {
-		dma_unmap_single(&spi->dev, sspi->src_start, t->len, DMA_TO_DEVICE);
-		dma_unmap_single(&spi->dev, sspi->dst_start, t->len, DMA_FROM_DEVICE);
+		dma_unmap_single(&spi->dev,
+				sspi->src_start, t->len, DMA_TO_DEVICE);
+		dma_unmap_single(&spi->dev,
+				sspi->dst_start, t->len, DMA_FROM_DEVICE);
 	}
 
 	/* TX, RX FIFO stop */
@@ -512,7 +521,8 @@ spi_sirfsoc_setup_transfer(struct spi_device *spi, struct spi_transfer *t)
 		break;
 	case 12:
 	case 16:
-		regval |= (bits_per_word ==  12) ? SIRFSOC_SPI_TRAN_DAT_FORMAT_12 :
+		regval |= (bits_per_word ==  12) ?
+			SIRFSOC_SPI_TRAN_DAT_FORMAT_12 :
 			SIRFSOC_SPI_TRAN_DAT_FORMAT_16;
 		sspi->rx_word = spi_sirfsoc_rx_word_u16;
 		sspi->tx_word = spi_sirfsoc_tx_word_u16;
@@ -540,8 +550,8 @@ spi_sirfsoc_setup_transfer(struct spi_device *spi, struct spi_transfer *t)
 		regval |= SIRFSOC_SPI_CLK_IDLE_STAT;
 
 	/*
-	 * Data should be driven at least 1/2 cycle before the fetch edge to make
-	 * sure that data gets stable at the fetch edge.
+	 * Data should be driven at least 1/2 cycle before the fetch edge
+	 * to make sure that data gets stable at the fetch edge.
 	 */
 	if (((spi->mode & SPI_CPOL) && (spi->mode & SPI_CPHA)) ||
 	    (!(spi->mode & SPI_CPOL) && !(spi->mode & SPI_CPHA)))
@@ -578,11 +588,14 @@ spi_sirfsoc_setup_transfer(struct spi_device *spi, struct spi_transfer *t)
 	if (IS_DMA_VALID(t)) {
 		/* Enable DMA mode for RX, TX */
 		writel(0, sspi->base + SIRFSOC_SPI_TX_DMA_IO_CTRL);
-		writel(SIRFSOC_SPI_RX_DMA_FLUSH, sspi->base + SIRFSOC_SPI_RX_DMA_IO_CTRL);
+		writel(SIRFSOC_SPI_RX_DMA_FLUSH,
+			sspi->base + SIRFSOC_SPI_RX_DMA_IO_CTRL);
 	} else {
 		/* Enable IO mode for RX, TX */
-		writel(SIRFSOC_SPI_IO_MODE_SEL, sspi->base + SIRFSOC_SPI_TX_DMA_IO_CTRL);
-		writel(SIRFSOC_SPI_IO_MODE_SEL, sspi->base + SIRFSOC_SPI_RX_DMA_IO_CTRL);
+		writel(SIRFSOC_SPI_IO_MODE_SEL,
+			sspi->base + SIRFSOC_SPI_TX_DMA_IO_CTRL);
+		writel(SIRFSOC_SPI_IO_MODE_SEL,
+			sspi->base + SIRFSOC_SPI_RX_DMA_IO_CTRL);
 	}
 
 	return 0;
@@ -612,7 +625,8 @@ static int spi_sirfsoc_probe(struct platform_device *pdev)
 		goto err_cs;
 	}
 
-	master = spi_alloc_master(&pdev->dev, sizeof(*sspi) + sizeof(int) * num_cs);
+	master = spi_alloc_master(&pdev->dev,
+			sizeof(*sspi) + sizeof(int) * num_cs);
 	if (!master) {
 		dev_err(&pdev->dev, "Unable to allocate SPI master\n");
 		return -ENOMEM;
@@ -808,8 +822,7 @@ static struct platform_driver spi_sirfsoc_driver = {
 	.remove = spi_sirfsoc_remove,
 };
 module_platform_driver(spi_sirfsoc_driver);
-
 MODULE_DESCRIPTION("SiRF SoC SPI master driver");
-MODULE_AUTHOR("Zhiwu Song <Zhiwu.Song@csr.com>, "
-		"Barry Song <Baohua.Song@csr.com>");
+MODULE_AUTHOR("Zhiwu Song <Zhiwu.Song@csr.com>");
+MODULE_AUTHOR("Barry Song <Baohua.Song@csr.com>");
 MODULE_LICENSE("GPL v2");
-- 
1.7.5.4
