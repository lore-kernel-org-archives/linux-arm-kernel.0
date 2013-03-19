From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Tue, 19 Mar 2013 15:49:01 +0800
Subject: [PATCH v7 10/14] spi/spi-atmel: correct 16 bits transfers with DMA
In-Reply-To: <1363678866-3567-1-git-send-email-wenyou.yang@atmel.com>
References: <1363678866-3567-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <1363679341-4087-1-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Richard Genoud <richard.genoud@gmail.com>

Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
Cc: spi-devel-general at lists.sourceforge.net
Cc: linux-kernel at vger.kernel.org
[wenyou.yang at atmel.com: submit the patch]
Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
---
 drivers/spi/spi-atmel.c |   17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index 3aa3809..e6539b7 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -388,12 +388,18 @@ static inline int atmel_spi_xfer_can_be_chained(struct spi_transfer *xfer)
 }
 
 static int atmel_spi_dma_slave_config(struct atmel_spi *as,
-				struct dma_slave_config *slave_config)
+				struct dma_slave_config *slave_config,
+				u8 bits_per_word)
 {
 	int err = 0;
 
-	slave_config->dst_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
-	slave_config->src_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
+	if (bits_per_word > 8) {
+		slave_config->dst_addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
+		slave_config->src_addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
+	} else {
+		slave_config->dst_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
+		slave_config->src_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
+	}
 
 	slave_config->dst_addr = (dma_addr_t)as->phybase + SPI_TDR;
 	slave_config->src_addr = (dma_addr_t)as->phybase + SPI_RDR;
@@ -454,7 +460,7 @@ static int atmel_spi_configure_dma(struct atmel_spi *as)
 		goto error;
 	}
 
-	err = atmel_spi_dma_slave_config(as, &slave_config);
+	err = atmel_spi_dma_slave_config(as, &slave_config, 8);
 	if (err)
 		goto error;
 
@@ -588,10 +594,9 @@ static int atmel_spi_next_xfer_dma_submit(struct spi_master *master,
 
 	*plen = len;
 
-	if (atmel_spi_dma_slave_config(as, &slave_config))
+	if (atmel_spi_dma_slave_config(as, &slave_config, 8))
 		goto err_exit;
 
-
 	/* Send both scatterlists */
 	rxdesc = rxchan->device->device_prep_slave_sg(rxchan,
 					&as->dma.sgrx,
-- 
1.7.9.5
