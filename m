From: fisaksen@baylibre.com (Frode Isaksen)
Date: Fri, 10 Feb 2017 16:29:40 +0100
Subject: [PATCH 4/8] spi: davinci: flush caches when performing DMA
In-Reply-To: <1486740584-17875-1-git-send-email-fisaksen@baylibre.com>
References: <1486740584-17875-1-git-send-email-fisaksen@baylibre.com>
Message-ID: <1486740584-17875-5-git-send-email-fisaksen@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This CPU has VIVT caches, so need to flush the
cache for vmalloc'ed buffers, since the address
may be aliased (same phyiscal address used by
multiple virtual addresses).
This fixes errors when mounting and reading/writing
UBIFS volumes with SPI flash.

Signed-off-by: Frode Isaksen <fisaksen@baylibre.com>
---
 drivers/spi/spi-davinci.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-davinci.c b/drivers/spi/spi-davinci.c
index f1b46f6..c735425 100644
--- a/drivers/spi/spi-davinci.c
+++ b/drivers/spi/spi-davinci.c
@@ -29,6 +29,7 @@
 #include <linux/spi/spi.h>
 #include <linux/spi/spi_bitbang.h>
 #include <linux/slab.h>
+#include <asm/cacheflush.h>
 
 #include <linux/platform_data/spi-davinci.h>
 
@@ -676,7 +677,9 @@ static int davinci_spi_bufs(struct spi_device *spi, struct spi_transfer *t)
 			}
 			sg_dma_address(&sg_rx) = t->rx_dma;
 			sg_dma_len(&sg_rx) = t->len;
-		}
+		} else if (is_vmalloc_addr(t->rx_buf))
+			/* VIVT cache, flush since aliased address */
+			flush_kernel_vmap_range((void *)t->rx_buf, t->len);
 
 		sg_init_table(&sg_tx, 1);
 		if (!t->tx_buf) {
@@ -688,7 +691,9 @@ static int davinci_spi_bufs(struct spi_device *spi, struct spi_transfer *t)
 			}
 			sg_dma_address(&sg_tx) = t->tx_dma;
 			sg_dma_len(&sg_tx) = t->len;
-		}
+		} else if (is_vmalloc_addr(t->tx_buf))
+			/* VIVT cache, flush since aliased address */
+			flush_kernel_vmap_range((void *)t->tx_buf, t->len);
 
 		rxdesc = dmaengine_prep_slave_sg(dspi->dma_rx,
 				t->rx_sg.sgl ?: &sg_rx, t->rx_sg.nents ?: 1,
@@ -741,6 +746,10 @@ static int davinci_spi_bufs(struct spi_device *spi, struct spi_transfer *t)
 		if (!t->rx_buf)
 			dma_unmap_single(&spi->dev, t->rx_dma,
 					t->len, DMA_FROM_DEVICE);
+		else if (is_vmalloc_addr(t->rx_buf))
+			/* VIVT cache, invalidate since aliased address */
+			invalidate_kernel_vmap_range((void *)t->rx_buf, t->len);
+
 		if (!t->tx_buf)
 			dma_unmap_single(&spi->dev, t->tx_dma,
 					t->len, DMA_TO_DEVICE);
-- 
2.7.4
