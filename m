From: fisaksen@baylibre.com (Frode Isaksen)
Date: Fri, 10 Feb 2017 16:29:39 +0100
Subject: [PATCH 3/8] spi: davinci: limit the transfer size if DMA enabled
In-Reply-To: <1486740584-17875-1-git-send-email-fisaksen@baylibre.com>
References: <1486740584-17875-1-git-send-email-fisaksen@baylibre.com>
Message-ID: <1486740584-17875-4-git-send-email-fisaksen@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Limit the transfer size to 20 scatter/gather pages if
DMA is enabled.
The eDMA DMA engine is limited to 20 SG entries in one DMA
transaction. If this number is exceeded, DMA receive fails.
This error occurs with large vmalloc'ed buffers.

Signed-off-by: Frode Isaksen <fisaksen@baylibre.com>
---
 drivers/spi/spi-davinci.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/spi/spi-davinci.c b/drivers/spi/spi-davinci.c
index b7b2da1..f1b46f6 100644
--- a/drivers/spi/spi-davinci.c
+++ b/drivers/spi/spi-davinci.c
@@ -485,6 +485,16 @@ static bool davinci_spi_can_dma(struct spi_master *master,
 	return __davinci_spi_can_dma(spi);
 }
 
+static size_t davinci_spi_max_transfer_size(struct spi_device *spi)
+{
+	/*
+	 * The eDMA DMA engine is limited to 20 SG entries in one DMA
+	 * transaction. If this number is exceeded, DMA receive fails.
+	 * An extra SG entry is needed when the buffer is not page aligned.
+	 */
+	return (__davinci_spi_can_dma(spi)) ? 19 * PAGE_SIZE : SIZE_MAX;
+}
+
 static int davinci_spi_check_error(struct davinci_spi *dspi, int int_status)
 {
 	struct device *sdev = dspi->bitbang.master->dev.parent;
@@ -1010,6 +1020,7 @@ static int davinci_spi_probe(struct platform_device *pdev)
 	master->setup = davinci_spi_setup;
 	master->cleanup = davinci_spi_cleanup;
 	master->can_dma = davinci_spi_can_dma;
+	master->max_transfer_size = davinci_spi_max_transfer_size;
 
 	dspi->bitbang.chipselect = davinci_spi_chipselect;
 	dspi->bitbang.setup_transfer = davinci_spi_setup_transfer;
-- 
2.7.4
