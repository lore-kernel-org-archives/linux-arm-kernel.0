From: leilk.liu@mediatek.com (Leilk Liu)
Date: Thu, 13 Aug 2015 20:06:41 +0800
Subject: [PATCH] spi: Mediatek: fixup cpu_to_le32 incorrect usage
Message-ID: <1439467601-10209-1-git-send-email-leilk.liu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

writel() already does a cpu_to_le32 conversion, so
remove cpu_to_le32().

Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
---
 drivers/spi/spi-mt65xx.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index ae645fa..519f50c 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -359,11 +359,9 @@ static void mtk_spi_setup_dma_addr(struct spi_master *master,
 	struct mtk_spi *mdata = spi_master_get_devdata(master);
 
 	if (mdata->tx_sgl)
-		writel((__force u32)cpu_to_le32(xfer->tx_dma),
-		       mdata->base + SPI_TX_SRC_REG);
+		writel(xfer->tx_dma, mdata->base + SPI_TX_SRC_REG);
 	if (mdata->rx_sgl)
-		writel((__force u32)cpu_to_le32(xfer->rx_dma),
-		       mdata->base + SPI_RX_DST_REG);
+		writel(xfer->rx_dma, mdata->base + SPI_RX_DST_REG);
 }
 
 static int mtk_spi_fifo_transfer(struct spi_master *master,
-- 
1.8.1.1.dirty
