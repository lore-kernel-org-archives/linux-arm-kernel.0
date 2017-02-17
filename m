From: fisaksen@baylibre.com (Frode Isaksen)
Date: Fri, 17 Feb 2017 11:38:23 +0100
Subject: [PATCH v2 5/6] spi: davinci: do not use DMA if transfer length is
 less than 16
In-Reply-To: <1487327904-28311-1-git-send-email-fisaksen@baylibre.com>
References: <1487327904-28311-1-git-send-email-fisaksen@baylibre.com>
Message-ID: <1487327904-28311-6-git-send-email-fisaksen@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Higher bitrate and lower CPU load if using PIO in this case.

Signed-off-by: Frode Isaksen <fisaksen@baylibre.com>
---
 drivers/spi/spi-davinci.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-davinci.c b/drivers/spi/spi-davinci.c
index b69a370..826bff1 100644
--- a/drivers/spi/spi-davinci.c
+++ b/drivers/spi/spi-davinci.c
@@ -110,6 +110,8 @@
 #define SPIDEF		0x4c
 #define SPIFMT0		0x50
 
+#define DMA_MIN_BYTES	16
+
 /* SPI Controller driver's private data. */
 struct davinci_spi {
 	struct spi_bitbang	bitbang;
@@ -483,7 +485,7 @@ static bool davinci_spi_can_dma(struct spi_master *master,
 				struct spi_device *spi,
 				struct spi_transfer *xfer)
 {
-	return __davinci_spi_can_dma(spi);
+	return __davinci_spi_can_dma(spi) && (xfer->len >= DMA_MIN_BYTES);
 }
 
 static int davinci_spi_check_error(struct davinci_spi *dspi, int int_status)
@@ -622,10 +624,9 @@ static int davinci_spi_bufs(struct spi_device *spi, struct spi_transfer *t)
 
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
@@ -706,7 +707,7 @@ static int davinci_spi_bufs(struct spi_device *spi, struct spi_transfer *t)
 	}
 
 	clear_io_bits(dspi->base + SPIINT, SPIINT_MASKALL);
-	if (spicfg->io_type == SPI_IO_TYPE_DMA) {
+	if (davinci_spi_can_dma(spi->master, spi, t)) {
 		clear_io_bits(dspi->base + SPIINT, SPIINT_DMA_REQ_EN);
 		if (is_vmalloc_addr(t->rx_buf))
 			/* VIVT cache: invalidate since addr. may be aliased */
-- 
2.7.4
