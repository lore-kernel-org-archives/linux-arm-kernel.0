From: fisaksen@baylibre.com (Frode Isaksen)
Date: Thu, 23 Feb 2017 19:01:59 +0100
Subject: [PATCH v3 4/6] spi: davinci: do not use DMA if transfer length is
 less than 16
In-Reply-To: <1487872921-26628-1-git-send-email-fisaksen@baylibre.com>
References: <1487872921-26628-1-git-send-email-fisaksen@baylibre.com>
Message-ID: <1487872921-26628-5-git-send-email-fisaksen@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Higher bitrate and lower CPU load if using PIO in this case.

Signed-off-by: Frode Isaksen <fisaksen@baylibre.com>
---
 drivers/spi/spi-davinci.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-davinci.c b/drivers/spi/spi-davinci.c
index ca12216..75c658e 100644
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
2.7.4
