From: broonie@kernel.org (Mark Brown)
Date: Tue, 22 Nov 2016 17:26:49 +0000
Subject: Applied "spi: spi-fsl-dspi: Fix continuous selection format" to the
 spi tree
In-Reply-To: <fd5dac77580ba02edb38319d04345e23a34b2d9d.1479796821.git.maitysanchayan@gmail.com>
Message-ID: <E1c9EqH-0005wi-D8@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   spi: spi-fsl-dspi: Fix continuous selection format

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

>From ccf7d8ee3d6eb600338a184e9a192ec1d5aee924 Mon Sep 17 00:00:00 2001
From: Sanchayan Maity <maitysanchayan@gmail.com>
Date: Tue, 22 Nov 2016 12:31:31 +0530
Subject: [PATCH] spi: spi-fsl-dspi: Fix continuous selection format

Current DMA implementation was not handling the continuous selection
format viz. SPI chip select would be deasserted even between sequential
serial transfers.

Use existing dspi_data_to_pushr function to restructure the transmit
code path and set or reset the CONT bit on same lines as code path
in EOQ mode does. This correctly implements continuous selection format
while also correcting and cleaning up the transmit code path.

Signed-off-by: Sanchayan Maity <maitysanchayan@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-fsl-dspi.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index cb41c327bd77..7ada112bfd85 100644
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
