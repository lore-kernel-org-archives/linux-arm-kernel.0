From: broonie@kernel.org (Mark Brown)
Date: Wed, 15 Mar 2017 19:37:16 +0000
Subject: Applied "spi: davinci: do not use DMA if transfer length is less than
 16" to the spi tree
In-Reply-To: <1487872921-26628-5-git-send-email-fisaksen@baylibre.com>
Message-ID: <E1coEjU-0004gr-QX@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   spi: davinci: do not use DMA if transfer length is less than 16

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

>From 0718b764880434ac7a5b7c0f5cb2c805c589a807 Mon Sep 17 00:00:00 2001
From: Frode Isaksen <fisaksen@baylibre.com>
Date: Thu, 23 Feb 2017 19:01:59 +0100
Subject: [PATCH] spi: davinci: do not use DMA if transfer length is less than
 16

Higher bitrate and lower CPU load if using PIO in this case.

Signed-off-by: Frode Isaksen <fisaksen@baylibre.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-davinci.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-davinci.c b/drivers/spi/spi-davinci.c
index ca122165a3c6..75c658e4e487 100644
--- a/drivers/spi/spi-davinci.c
+++ b/drivers/spi/spi-davinci.c
@@ -109,6 +109,8 @@
 #define SPIDEF		0x4c
 #define SPIFMT0		0x50
 
+#define DMA_MIN_BYTES	16
+
 /* SPI Controller driver's private data. */
 struct davinci_spi {
 	struct spi_bitbang	bitbang;
@@ -479,7 +481,8 @@ static bool davinci_spi_can_dma(struct spi_master *master,
 	bool can_dma = false;
 
 	if (spicfg)
-		can_dma = spicfg->io_type == SPI_IO_TYPE_DMA;
+		can_dma = (spicfg->io_type == SPI_IO_TYPE_DMA) &&
+			(xfer->len >= DMA_MIN_BYTES);
 
 	return can_dma;
 }
@@ -620,10 +623,9 @@ static int davinci_spi_bufs(struct spi_device *spi, struct spi_transfer *t)
 
 	reinit_completion(&dspi->done);
 
-	if (spicfg->io_type == SPI_IO_TYPE_INTR)
-		set_io_bits(dspi->base + SPIINT, SPIINT_MASKINT);
-
-	if (spicfg->io_type != SPI_IO_TYPE_DMA) {
+	if (!davinci_spi_can_dma(spi->master, spi, t)) {
+		if (spicfg->io_type != SPI_IO_TYPE_POLL)
+			set_io_bits(dspi->base + SPIINT, SPIINT_MASKINT);
 		/* start the transfer */
 		dspi->wcount--;
 		tx_data = dspi->get_tx(dspi);
@@ -698,7 +700,7 @@ static int davinci_spi_bufs(struct spi_device *spi, struct spi_transfer *t)
 	}
 
 	clear_io_bits(dspi->base + SPIINT, SPIINT_MASKALL);
-	if (spicfg->io_type == SPI_IO_TYPE_DMA)
+	if (davinci_spi_can_dma(spi->master, spi, t))
 		clear_io_bits(dspi->base + SPIINT, SPIINT_DMA_REQ_EN);
 
 	clear_io_bits(dspi->base + SPIGCR1, SPIGCR1_SPIENA_MASK);
-- 
2.11.0
