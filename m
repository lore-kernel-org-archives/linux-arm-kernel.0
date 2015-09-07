From: leilk.liu@mediatek.com (Leilk Liu)
Date: Mon, 7 Sep 2015 19:37:57 +0800
Subject: [PATCH] spi: mediatek: fix spi cs polarity error
Message-ID: <1441625877-583-1-git-send-email-leilk.liu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mediatek spi HW can't set cs inactive(keep cs high) directly.
Instead, it supplies pause mode to do it indirectly. If driver
unsets SPI_CMD_PAUSE_MODE in CMD_REG, it also needs to reset
internal state machine to let cs inactive at once.

Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
---
 drivers/spi/spi-mt65xx.c | 27 +++++++--------------------
 1 file changed, 7 insertions(+), 20 deletions(-)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index 401e2e0..ba0fc10 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -173,22 +173,6 @@ static void mtk_spi_config(struct mtk_spi *mdata,
 		writel(mdata->pad_sel, mdata->base + SPI_PAD_SEL_REG);
 }
 
-static int mtk_spi_prepare_hardware(struct spi_master *master)
-{
-	struct spi_transfer *trans;
-	struct mtk_spi *mdata = spi_master_get_devdata(master);
-	struct spi_message *msg = master->cur_msg;
-
-	trans = list_first_entry(&msg->transfers, struct spi_transfer,
-				 transfer_list);
-	if (!trans->cs_change) {
-		mdata->state = MTK_SPI_IDLE;
-		mtk_spi_reset(mdata);
-	}
-
-	return 0;
-}
-
 static int mtk_spi_prepare_message(struct spi_master *master,
 				   struct spi_message *msg)
 {
@@ -228,11 +212,15 @@ static void mtk_spi_set_cs(struct spi_device *spi, bool enable)
 	struct mtk_spi *mdata = spi_master_get_devdata(spi->master);
 
 	reg_val = readl(mdata->base + SPI_CMD_REG);
-	if (!enable)
+	if (!enable) {
 		reg_val |= SPI_CMD_PAUSE_EN;
-	else
+		writel(reg_val, mdata->base + SPI_CMD_REG);
+	} else {
 		reg_val &= ~SPI_CMD_PAUSE_EN;
-	writel(reg_val, mdata->base + SPI_CMD_REG);
+		writel(reg_val, mdata->base + SPI_CMD_REG);
+		mdata->state = MTK_SPI_IDLE;
+		mtk_spi_reset(mdata);
+	}
 }
 
 static void mtk_spi_prepare_transfer(struct spi_master *master,
@@ -509,7 +497,6 @@ static int mtk_spi_probe(struct platform_device *pdev)
 	master->mode_bits = SPI_CPOL | SPI_CPHA;
 
 	master->set_cs = mtk_spi_set_cs;
-	master->prepare_transfer_hardware = mtk_spi_prepare_hardware;
 	master->prepare_message = mtk_spi_prepare_message;
 	master->transfer_one = mtk_spi_transfer_one;
 	master->can_dma = mtk_spi_can_dma;
-- 
1.8.1.1.dirty
