From: maitysanchayan@gmail.com (Sanchayan Maity)
Date: Mon, 21 Nov 2016 11:24:03 +0530
Subject: [PATCH v2 3/4] spi: spi-fsl-dspi: Fix incorrect DMA setup
In-Reply-To: <cover.1479706671.git.maitysanchayan@gmail.com>
References: <cover.1479706671.git.maitysanchayan@gmail.com>
Message-ID: <a36bac5f2499d1002693a7dbf95982bab186e51f.1479706671.git.maitysanchayan@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently dmaengine_prep_slave_single was being called with length
set to the complete DMA buffer size. This resulted in unwanted bytes
being transferred to the SPI register leading to clock and MOSI lines
having unwanted data even after chip select got deasserted and the
required bytes having been transferred.

While at it also clean up the use of curr_xfer_len which is central
to the DMA setup, from bytes to DMA transfers for every use.

Signed-off-by: Sanchayan Maity <maitysanchayan@gmail.com>
---
 drivers/spi/spi-fsl-dspi.c | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 41422cd..08882f7 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -151,6 +151,7 @@ static const struct fsl_dspi_devtype_data ls2085a_data = {
 };
 
 struct fsl_dspi_dma {
+	/* Length of transfer in words of DSPI_FIFO_SIZE */
 	u32 curr_xfer_len;
 
 	u32 *tx_dma_buf;
@@ -217,15 +218,13 @@ static void dspi_rx_dma_callback(void *arg)
 	struct fsl_dspi *dspi = arg;
 	struct fsl_dspi_dma *dma = dspi->dma;
 	int rx_word;
-	int i, len;
+	int i;
 	u16 d;
 
 	rx_word = is_double_byte_mode(dspi);
 
-	len = rx_word ? (dma->curr_xfer_len / 2) : dma->curr_xfer_len;
-
 	if (!(dspi->dataflags & TRAN_STATE_RX_VOID)) {
-		for (i = 0; i < len; i++) {
+		for (i = 0; i < dma->curr_xfer_len; i++) {
 			d = dspi->dma->rx_dma_buf[i];
 			rx_word ? (*(u16 *)dspi->rx = d) :
 						(*(u8 *)dspi->rx = d);
@@ -242,14 +241,12 @@ static int dspi_next_xfer_dma_submit(struct fsl_dspi *dspi)
 	struct device *dev = &dspi->pdev->dev;
 	int time_left;
 	int tx_word;
-	int i, len;
+	int i;
 	u16 val;
 
 	tx_word = is_double_byte_mode(dspi);
 
-	len = tx_word ? (dma->curr_xfer_len / 2) : dma->curr_xfer_len;
-
-	for (i = 0; i < len - 1; i++) {
+	for (i = 0; i < dma->curr_xfer_len - 1; i++) {
 		val = tx_word ? *(u16 *) dspi->tx : *(u8 *) dspi->tx;
 		dspi->dma->tx_dma_buf[i] =
 			SPI_PUSHR_TXDATA(val) | SPI_PUSHR_PCS(dspi->cs) |
@@ -267,7 +264,9 @@ static int dspi_next_xfer_dma_submit(struct fsl_dspi *dspi)
 
 	dma->tx_desc = dmaengine_prep_slave_single(dma->chan_tx,
 					dma->tx_dma_phys,
-					DSPI_DMA_BUFSIZE, DMA_MEM_TO_DEV,
+					dma->curr_xfer_len *
+					DMA_SLAVE_BUSWIDTH_4_BYTES,
+					DMA_MEM_TO_DEV,
 					DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 	if (!dma->tx_desc) {
 		dev_err(dev, "Not able to get desc for DMA xfer\n");
@@ -283,7 +282,9 @@ static int dspi_next_xfer_dma_submit(struct fsl_dspi *dspi)
 
 	dma->rx_desc = dmaengine_prep_slave_single(dma->chan_rx,
 					dma->rx_dma_phys,
-					DSPI_DMA_BUFSIZE, DMA_DEV_TO_MEM,
+					dma->curr_xfer_len *
+					DMA_SLAVE_BUSWIDTH_4_BYTES,
+					DMA_DEV_TO_MEM,
 					DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 	if (!dma->rx_desc) {
 		dev_err(dev, "Not able to get desc for DMA xfer\n");
@@ -330,17 +331,17 @@ static int dspi_dma_xfer(struct fsl_dspi *dspi)
 	struct device *dev = &dspi->pdev->dev;
 	int curr_remaining_bytes;
 	int bytes_per_buffer;
-	int tx_word;
+	int word = 1;
 	int ret = 0;
 
-	tx_word = is_double_byte_mode(dspi);
+	if (is_double_byte_mode(dspi))
+		word = 2;
 	curr_remaining_bytes = dspi->len;
+	bytes_per_buffer = DSPI_DMA_BUFSIZE / DSPI_FIFO_SIZE;
 	while (curr_remaining_bytes) {
 		/* Check if current transfer fits the DMA buffer */
-		dma->curr_xfer_len = curr_remaining_bytes;
-		bytes_per_buffer = DSPI_DMA_BUFSIZE /
-				(DSPI_FIFO_SIZE / (tx_word ? 2 : 1));
-		if (curr_remaining_bytes > bytes_per_buffer)
+		dma->curr_xfer_len = curr_remaining_bytes / word;
+		if (dma->curr_xfer_len > bytes_per_buffer)
 			dma->curr_xfer_len = bytes_per_buffer;
 
 		ret = dspi_next_xfer_dma_submit(dspi);
@@ -349,7 +350,7 @@ static int dspi_dma_xfer(struct fsl_dspi *dspi)
 			goto exit;
 
 		} else {
-			curr_remaining_bytes -= dma->curr_xfer_len;
+			curr_remaining_bytes -= dma->curr_xfer_len * word;
 			if (curr_remaining_bytes < 0)
 				curr_remaining_bytes = 0;
 			dspi->len = curr_remaining_bytes;
-- 
2.10.2
