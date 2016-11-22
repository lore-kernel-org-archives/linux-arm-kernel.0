From: maitysanchayan@gmail.com (Sanchayan Maity)
Date: Tue, 22 Nov 2016 12:31:31 +0530
Subject: [PATCH v3 2/3] spi: spi-fsl-dspi: Fix continuous selection format
In-Reply-To: <cover.1479796821.git.maitysanchayan@gmail.com>
References: <cover.1479796821.git.maitysanchayan@gmail.com>
Message-ID: <fd5dac77580ba02edb38319d04345e23a34b2d9d.1479796821.git.maitysanchayan@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Current DMA implementation was not handling the continuous selection
format viz. SPI chip select would be deasserted even between sequential
serial transfers.

Use existing dspi_data_to_pushr function to restructure the transmit
code path and set or reset the CONT bit on same lines as code path
in EOQ mode does. This correctly implements continuous selection format
while also correcting and cleaning up the transmit code path.

Signed-off-by: Sanchayan Maity <maitysanchayan@gmail.com>
---
 drivers/spi/spi-fsl-dspi.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 911aadb..8af3151 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -196,6 +196,8 @@ struct fsl_dspi {
 	struct fsl_dspi_dma	*dma;
 };
 
+static u32 dspi_data_to_pushr(struct fsl_dspi *dspi, int tx_word);
+
 static inline int is_double_byte_mode(struct fsl_dspi *dspi)
 {
 	unsigned int val;
@@ -242,24 +244,15 @@ static int dspi_next_xfer_dma_submit(struct fsl_dspi *dspi)
 	int time_left;
 	int tx_word;
 	int i;
-	u16 val;
 
 	tx_word = is_double_byte_mode(dspi);
 
-	for (i = 0; i < dma->curr_xfer_len - 1; i++) {
-		val = tx_word ? *(u16 *) dspi->tx : *(u8 *) dspi->tx;
-		dspi->dma->tx_dma_buf[i] =
-			SPI_PUSHR_TXDATA(val) | SPI_PUSHR_PCS(dspi->cs) |
-			SPI_PUSHR_CTAS(0) | SPI_PUSHR_CONT;
-		dspi->tx += tx_word + 1;
+	for (i = 0; i < dma->curr_xfer_len; i++) {
+		dspi->dma->tx_dma_buf[i] = dspi_data_to_pushr(dspi, tx_word);
+		if ((dspi->cs_change) && (!dspi->len))
+			dspi->dma->tx_dma_buf[i] &= ~SPI_PUSHR_CONT;
 	}
 
-	val = tx_word ? *(u16 *) dspi->tx : *(u8 *) dspi->tx;
-	dspi->dma->tx_dma_buf[i] = SPI_PUSHR_TXDATA(val) |
-					SPI_PUSHR_PCS(dspi->cs) |
-					SPI_PUSHR_CTAS(0);
-	dspi->tx += tx_word + 1;
-
 	dma->tx_desc = dmaengine_prep_slave_single(dma->chan_tx,
 					dma->tx_dma_phys,
 					dma->curr_xfer_len *
@@ -351,7 +344,6 @@ static int dspi_dma_xfer(struct fsl_dspi *dspi)
 			curr_remaining_bytes -= dma->curr_xfer_len * word;
 			if (curr_remaining_bytes < 0)
 				curr_remaining_bytes = 0;
-			dspi->len = curr_remaining_bytes;
 		}
 	}
 
-- 
2.10.2
