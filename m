From: leilk.liu@mediatek.com (Leilk Liu)
Date: Tue, 11 Aug 2015 18:43:09 +0800
Subject: [PATCH] spi: Mediatek: fix endian warnings
Message-ID: <1439289789-29026-1-git-send-email-leilk.liu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes endian warnings detected by sparse:
- sparse: incorrect type in argument 1 (different base types)
	  expected unsigned int [unsigned] val
	  got restricted __le32 [usertype] <noident>
- sparse: incorrect type in argument 1 (different base types)
	  expected unsigned int [unsigned] val
	  got restricted __le32 [usertype] <noident>

Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
---
 drivers/spi/spi-mt65xx.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index 4676b01..ae645fa 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -359,9 +359,11 @@ static void mtk_spi_setup_dma_addr(struct spi_master *master,
 	struct mtk_spi *mdata = spi_master_get_devdata(master);
 
 	if (mdata->tx_sgl)
-		writel(cpu_to_le32(xfer->tx_dma), mdata->base + SPI_TX_SRC_REG);
+		writel((__force u32)cpu_to_le32(xfer->tx_dma),
+		       mdata->base + SPI_TX_SRC_REG);
 	if (mdata->rx_sgl)
-		writel(cpu_to_le32(xfer->rx_dma), mdata->base + SPI_RX_DST_REG);
+		writel((__force u32)cpu_to_le32(xfer->rx_dma),
+		       mdata->base + SPI_RX_DST_REG);
 }
 
 static int mtk_spi_fifo_transfer(struct spi_master *master,
-- 
1.8.1.1.dirty
