From: fisaksen@baylibre.com (Frode Isaksen)
Date: Fri, 17 Feb 2017 11:38:22 +0100
Subject: [PATCH v2 4/6] spi: davinci: flush caches when performing DMA
In-Reply-To: <1487327904-28311-1-git-send-email-fisaksen@baylibre.com>
References: <1487327904-28311-1-git-send-email-fisaksen@baylibre.com>
Message-ID: <1487327904-28311-5-git-send-email-fisaksen@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This CPU has VIVT caches, so need to flush the cache
for vmalloc'ed buffers, since the address may be aliased
(same phyiscal address used by multiple virtual addresses).
This fixes errors when mounting and reading/writing UBIFS
volumes with SPI NOR flash.

Signed-off-by: Frode Isaksen <fisaksen@baylibre.com>
---
 drivers/spi/spi-davinci.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-davinci.c b/drivers/spi/spi-davinci.c
index 2632ae0..b69a370 100644
--- a/drivers/spi/spi-davinci.c
+++ b/drivers/spi/spi-davinci.c
@@ -29,6 +29,7 @@
 #include <linux/spi/spi.h>
 #include <linux/spi/spi_bitbang.h>
 #include <linux/slab.h>
+#include <asm/cacheflush.h>
 
 #include <linux/platform_data/spi-davinci.h>
 
@@ -650,6 +651,10 @@ static int davinci_spi_bufs(struct spi_device *spi, struct spi_transfer *t)
 		dmaengine_slave_config(dspi->dma_rx, &dma_rx_conf);
 		dmaengine_slave_config(dspi->dma_tx, &dma_tx_conf);
 
+		if (is_vmalloc_addr(t->rx_buf))
+			/* VIVT cache: flush since addr. may be aliased */
+			flush_kernel_vmap_range((void *)t->rx_buf, t->len);
+
 		rxdesc = dmaengine_prep_slave_sg(dspi->dma_rx,
 				t->rx_sg.sgl, t->rx_sg.nents, DMA_DEV_TO_MEM,
 				DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
@@ -660,7 +665,9 @@ static int davinci_spi_bufs(struct spi_device *spi, struct spi_transfer *t)
 			/* use rx buffer as dummy tx buffer */
 			t->tx_sg.sgl = t->rx_sg.sgl;
 			t->tx_sg.nents = t->rx_sg.nents;
-		}
+		} else if (is_vmalloc_addr(t->tx_buf))
+			/* VIVT cache: flush since addr. may be aliased */
+			flush_kernel_vmap_range((void *)t->tx_buf, t->len);
 
 		txdesc = dmaengine_prep_slave_sg(dspi->dma_tx,
 				t->tx_sg.sgl, t->tx_sg.nents, DMA_MEM_TO_DEV,
@@ -699,8 +706,12 @@ static int davinci_spi_bufs(struct spi_device *spi, struct spi_transfer *t)
 	}
 
 	clear_io_bits(dspi->base + SPIINT, SPIINT_MASKALL);
-	if (spicfg->io_type == SPI_IO_TYPE_DMA)
+	if (spicfg->io_type == SPI_IO_TYPE_DMA) {
 		clear_io_bits(dspi->base + SPIINT, SPIINT_DMA_REQ_EN);
+		if (is_vmalloc_addr(t->rx_buf))
+			/* VIVT cache: invalidate since addr. may be aliased */
+			invalidate_kernel_vmap_range((void *)t->rx_buf, t->len);
+	}
 
 	clear_io_bits(dspi->base + SPIGCR1, SPIGCR1_SPIENA_MASK);
 	set_io_bits(dspi->base + SPIGCR1, SPIGCR1_POWERDOWN_MASK);
-- 
2.7.4
