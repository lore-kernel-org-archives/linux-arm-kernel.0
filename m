From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sun, 11 Aug 2013 02:33:30 +0200
Subject: [PATCH 3/3] spi: s3c64xx: Use dmaengine_prep_slave_single() to
 prepare DMA transfers
In-Reply-To: <1376181210-14599-1-git-send-email-tomasz.figa@gmail.com>
References: <1376181210-14599-1-git-send-email-tomasz.figa@gmail.com>
Message-ID: <1376181210-14599-3-git-send-email-tomasz.figa@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since the driver supports only contiguous buffers, there is no need to
manually construct a scatterlist with just a single entry, when there is
a dedicated helper for this purpose.

This patch modifies prepare_dma() function to use available helper instead
of manually creating a scatterlist.

Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
---
 drivers/spi/spi-s3c64xx.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 597dc2f..9b4e54d 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -386,7 +386,6 @@ static void prepare_dma(struct s3c64xx_spi_dma_data *dma,
 {
 	struct s3c64xx_spi_driver_data *sdd;
 	struct dma_slave_config config;
-	struct scatterlist sg;
 	struct dma_async_tx_descriptor *desc;
 
 	memset(&config, 0, sizeof(config));
@@ -409,14 +408,8 @@ static void prepare_dma(struct s3c64xx_spi_dma_data *dma,
 		dmaengine_slave_config(dma->ch, &config);
 	}
 
-	sg_init_table(&sg, 1);
-	sg_dma_len(&sg) = len;
-	sg_set_page(&sg, pfn_to_page(PFN_DOWN(buf)),
-		    len, offset_in_page(buf));
-	sg_dma_address(&sg) = buf;
-
-	desc = dmaengine_prep_slave_sg(dma->ch,
-		&sg, 1, dma->direction, DMA_PREP_INTERRUPT);
+	desc = dmaengine_prep_slave_single(dma->ch, buf, len,
+					dma->direction, DMA_PREP_INTERRUPT);
 
 	desc->callback = s3c64xx_spi_dmacb;
 	desc->callback_param = dma;
-- 
1.8.3.2
