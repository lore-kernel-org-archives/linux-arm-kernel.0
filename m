From: maitysanchayan@gmail.com (Sanchayan Maity)
Date: Thu, 17 Nov 2016 17:46:51 +0530
Subject: [PATCH 4/4] spi: spi-fsl-dspi: Minor code cleanup and error path fixes
In-Reply-To: <cover.1479384571.git.maitysanchayan@gmail.com>
References: <20161111122036.fubv7b4jc5vkdxhc@sirena.org.uk>
 <cover.1479384571.git.maitysanchayan@gmail.com>
Message-ID: <f6511e066bb3ab069923c7962071355e5be0e7a3.1479384571.git.maitysanchayan@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Code cleanup for improving code readability and error path fixes
and cleanup removing use of devm_kfree.

Signed-off-by: Sanchayan Maity <maitysanchayan@gmail.com>
---
 drivers/spi/spi-fsl-dspi.c | 34 +++++++++++++++++++++++++---------
 1 file changed, 25 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 164e2e1..382a7f9 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -222,13 +222,18 @@ static void dspi_rx_dma_callback(void *arg)
 
 	rx_word = is_double_byte_mode(dspi);
 
-	len = rx_word ? (dma->curr_xfer_len / 2) : dma->curr_xfer_len;
+	if (rx_word)
+		len = dma->curr_xfer_len / 2;
+	else
+		len = dma->curr_xfer_len;
 
 	if (!(dspi->dataflags & TRAN_STATE_RX_VOID)) {
 		for (i = 0; i < len; i++) {
 			d = dspi->dma->rx_dma_buf[i];
-			rx_word ? (*(u16 *)dspi->rx = d) :
-						(*(u8 *)dspi->rx = d);
+			if (rx_word)
+				*(u16 *)dspi->rx = d;
+			else
+				*(u8 *)dspi->rx = d;
 			dspi->rx += rx_word + 1;
 		}
 	}
@@ -247,17 +252,27 @@ static int dspi_next_xfer_dma_submit(struct fsl_dspi *dspi)
 
 	tx_word = is_double_byte_mode(dspi);
 
-	len = tx_word ? (dma->curr_xfer_len / 2) : dma->curr_xfer_len;
+	if (tx_word)
+		len = dma->curr_xfer_len / 2;
+	else
+		len = dma->curr_xfer_len;
 
 	for (i = 0; i < len - 1; i++) {
-		val = tx_word ? *(u16 *) dspi->tx : *(u8 *) dspi->tx;
+		if (tx_word)
+			val = *(u16 *) dspi->tx;
+		else
+			val = *(u8 *) dspi->tx;
 		dspi->dma->tx_dma_buf[i] =
 			SPI_PUSHR_TXDATA(val) | SPI_PUSHR_PCS(dspi->cs) |
 			SPI_PUSHR_CTAS(0) | SPI_PUSHR_CONT;
 		dspi->tx += tx_word + 1;
 	}
 
-	val = tx_word ? *(u16 *) dspi->tx : *(u8 *) dspi->tx;
+	if (tx_word)
+		val = *(u16 *) dspi->tx;
+	else
+		val = *(u8 *) dspi->tx;
+
 	if (dspi->cs_change) {
 		dspi->dma->tx_dma_buf[i] = SPI_PUSHR_TXDATA(val) |
 						SPI_PUSHR_PCS(dspi->cs) |
@@ -440,15 +455,16 @@ static int dspi_request_dma(struct fsl_dspi *dspi, phys_addr_t phy_addr)
 	return 0;
 
 err_slave_config:
-	devm_kfree(dev, dma->rx_dma_buf);
+	dma_free_coherent(dev, DSPI_DMA_BUFSIZE,
+			dma->rx_dma_buf, dma->rx_dma_phys);
 err_rx_dma_buf:
-	devm_kfree(dev, dma->tx_dma_buf);
+	dma_free_coherent(dev, DSPI_DMA_BUFSIZE,
+			dma->tx_dma_buf, dma->tx_dma_phys);
 err_tx_dma_buf:
 	dma_release_channel(dma->chan_tx);
 err_tx_channel:
 	dma_release_channel(dma->chan_rx);
 
-	devm_kfree(dev, dma);
 	dspi->dma = NULL;
 
 	return ret;
-- 
2.10.2
