From: broonie@kernel.org (Mark Brown)
Date: Mon, 21 Nov 2016 19:20:45 +0000
Subject: Applied "spi: spi-fsl-dspi: Fix SPI transfer issue when using
 multiple SPI_IOC_MESSAGE" to the spi tree
In-Reply-To: <bbdbc8df434dd2af74eb351b799a2812a1c1967e.1479384571.git.maitysanchayan@gmail.com>
Message-ID: <E1c8u8z-00081L-O7@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   spi: spi-fsl-dspi: Fix SPI transfer issue when using multiple SPI_IOC_MESSAGE

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

>From 9811430465fccae17862213d07eba017c149eb9c Mon Sep 17 00:00:00 2001
From: Sanchayan Maity <maitysanchayan@gmail.com>
Date: Thu, 17 Nov 2016 17:46:48 +0530
Subject: [PATCH] spi: spi-fsl-dspi: Fix SPI transfer issue when using multiple
 SPI_IOC_MESSAGE

Current DMA implementation had a bug where the DMA transfer would
exit the loop in dspi_transfer_one_message after the completion of
a single transfer. This results in a multi message transfer submitted
with SPI_IOC_MESSAGE to terminate incorrectly without an error.

Signed-off-by: Sanchayan Maity <maitysanchayan@gmail.com>
Reviewed-by: Stefan Agner <stefan@agner.ch>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-fsl-dspi.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index bc64700b514d..b1ee1f521ba0 100644
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
