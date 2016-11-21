From: maitysanchayan@gmail.com (Sanchayan Maity)
Date: Mon, 21 Nov 2016 11:24:01 +0530
Subject: [PATCH v2 1/4] spi: spi-fsl-dspi: Fix SPI transfer issue when using
 multiple SPI_IOC_MESSAGE
In-Reply-To: <cover.1479706671.git.maitysanchayan@gmail.com>
References: <cover.1479706671.git.maitysanchayan@gmail.com>
Message-ID: <bbdbc8df434dd2af74eb351b799a2812a1c1967e.1479706671.git.maitysanchayan@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Current DMA implementation had a bug where the DMA transfer would
exit the loop in dspi_transfer_one_message after the completion of
a single transfer. This results in a multi message transfer submitted
with SPI_IOC_MESSAGE to terminate incorrectly without an error.

Signed-off-by: Sanchayan Maity <maitysanchayan@gmail.com>
Reviewed-by: Stefan Agner <stefan@agner.ch>
---
 drivers/spi/spi-fsl-dspi.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index bc64700..b1ee1f5 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -714,7 +714,7 @@ static int dspi_transfer_one_message(struct spi_master *master,
 				SPI_RSER_TFFFE | SPI_RSER_TFFFD |
 				SPI_RSER_RFDFE | SPI_RSER_RFDFD);
 			status = dspi_dma_xfer(dspi);
-			goto out;
+			break;
 		default:
 			dev_err(&dspi->pdev->dev, "unsupported trans_mode %u\n",
 				trans_mode);
@@ -722,9 +722,13 @@ static int dspi_transfer_one_message(struct spi_master *master,
 			goto out;
 		}
 
-		if (wait_event_interruptible(dspi->waitq, dspi->waitflags))
-			dev_err(&dspi->pdev->dev, "wait transfer complete fail!\n");
-		dspi->waitflags = 0;
+		if (trans_mode != DSPI_DMA_MODE) {
+			if (wait_event_interruptible(dspi->waitq,
+						dspi->waitflags))
+				dev_err(&dspi->pdev->dev,
+					"wait transfer complete fail!\n");
+			dspi->waitflags = 0;
+		}
 
 		if (transfer->delay_usecs)
 			udelay(transfer->delay_usecs);
-- 
2.10.2
