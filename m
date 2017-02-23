From: fisaksen@baylibre.com (Frode Isaksen)
Date: Thu, 23 Feb 2017 19:02:00 +0100
Subject: [PATCH v3 5/6] spi: davinci: do not use DMA for vmalloc'ed buffers
In-Reply-To: <1487872921-26628-1-git-send-email-fisaksen@baylibre.com>
References: <1487872921-26628-1-git-send-email-fisaksen@baylibre.com>
Message-ID: <1487872921-26628-6-git-send-email-fisaksen@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Using vmalloc'ed buffers will fail since daVinci has
VIVT cache and only the kernel lowmem virtual address
is invalidated/flushed when performing DMA.
The virtual address returned from vmalloc() is not
invalidated/flushed and may contain stale data when
returning from spi_sync().
Fixes errors when running UBIFS over SPI NOR.
Revert this when all upper layer users of vmalloc'ed
buffers sent to SPI handles cache flushing/invalidating.

Signed-off-by: Frode Isaksen <fisaksen@baylibre.com>
---
 drivers/spi/spi-davinci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-davinci.c b/drivers/spi/spi-davinci.c
index 75c658e..f37bbdd 100644
--- a/drivers/spi/spi-davinci.c
+++ b/drivers/spi/spi-davinci.c
@@ -482,7 +482,9 @@ static bool davinci_spi_can_dma(struct spi_master *master,
 
 	if (spicfg)
 		can_dma = (spicfg->io_type == SPI_IO_TYPE_DMA) &&
-			(xfer->len >= DMA_MIN_BYTES);
+			(xfer->len >= DMA_MIN_BYTES) &&
+			!is_vmalloc_addr(xfer->rx_buf) &&
+			!is_vmalloc_addr(xfer->tx_buf);
 
 	return can_dma;
 }
-- 
2.7.4
