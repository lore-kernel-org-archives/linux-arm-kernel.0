From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sun, 11 Aug 2013 02:33:28 +0200
Subject: [PATCH 1/3] spi: s3c64xx: Zero dma_slave_config struct in
 prepare_dma()
Message-ID: <1376181210-14599-1-git-send-email-tomasz.figa@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Not all fields of dma_slave_config struct are being initialized by
prepare_dma() function, leaving those which are not in undefined state,
which can confuse DMA drivers using them.

This patch adds call to memset() to zero the struct before initializing
a subset of its fields.

Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
---
 drivers/spi/spi-s3c64xx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 62f32c4..1be162c 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -389,6 +389,8 @@ static void prepare_dma(struct s3c64xx_spi_dma_data *dma,
 	struct scatterlist sg;
 	struct dma_async_tx_descriptor *desc;
 
+	memset(&config, 0, sizeof(config));
+
 	if (dma->direction == DMA_DEV_TO_MEM) {
 		sdd = container_of((void *)dma,
 			struct s3c64xx_spi_driver_data, rx_dma);
-- 
1.8.3.2
