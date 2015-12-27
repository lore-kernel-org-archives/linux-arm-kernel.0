From: drinkcat@chromium.org (Nicolas Boichat)
Date: Sun, 27 Dec 2015 18:17:06 +0800
Subject: [PATCH] spi: mediatek: Prevent overflows in FIFO transfers
Message-ID: <1451211426-20436-1-git-send-email-drinkcat@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In the case where transfer length is not a multiple of 4, KASAN
reports 2 out-of-bounds memory accesses:
 - mtk_spi_interrupt: ioread32_rep writes past the end of
   trans->rx_buf.
 - mtk_spi_fifo_transfer: iowrite32_rep reads past the end of
   xfer->tx_buf.

Fix this by using memcpy on the remainder of the bytes.

Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
---
 drivers/spi/spi-mt65xx.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index 00a36da..8763eff 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -320,7 +320,8 @@ static int mtk_spi_fifo_transfer(struct spi_master *master,
 				 struct spi_device *spi,
 				 struct spi_transfer *xfer)
 {
-	int cnt;
+	int cnt, remainder;
+	u32 reg_val;
 	struct mtk_spi *mdata = spi_master_get_devdata(master);
 
 	mdata->cur_transfer = xfer;
@@ -328,12 +329,16 @@ static int mtk_spi_fifo_transfer(struct spi_master *master,
 	mtk_spi_prepare_transfer(master, xfer);
 	mtk_spi_setup_packet(master);
 
-	if (xfer->len % 4)
-		cnt = xfer->len / 4 + 1;
-	else
-		cnt = xfer->len / 4;
+	cnt = xfer->len / 4;
 	iowrite32_rep(mdata->base + SPI_TX_DATA_REG, xfer->tx_buf, cnt);
 
+	remainder = xfer->len % 4;
+	if (remainder > 0) {
+		reg_val = 0;
+		memcpy(&reg_val, xfer->tx_buf + (cnt * 4), remainder);
+		writel(reg_val, mdata->base + SPI_TX_DATA_REG);
+	}
+
 	mtk_spi_enable_transfer(master);
 
 	return 1;
@@ -415,7 +420,7 @@ static int mtk_spi_setup(struct spi_device *spi)
 
 static irqreturn_t mtk_spi_interrupt(int irq, void *dev_id)
 {
-	u32 cmd, reg_val, cnt;
+	u32 cmd, reg_val, cnt, remainder;
 	struct spi_master *master = dev_id;
 	struct mtk_spi *mdata = spi_master_get_devdata(master);
 	struct spi_transfer *trans = mdata->cur_transfer;
@@ -428,12 +433,15 @@ static irqreturn_t mtk_spi_interrupt(int irq, void *dev_id)
 
 	if (!master->can_dma(master, master->cur_msg->spi, trans)) {
 		if (trans->rx_buf) {
-			if (mdata->xfer_len % 4)
-				cnt = mdata->xfer_len / 4 + 1;
-			else
-				cnt = mdata->xfer_len / 4;
+			cnt = mdata->xfer_len / 4;
 			ioread32_rep(mdata->base + SPI_RX_DATA_REG,
 				     trans->rx_buf, cnt);
+			remainder = mdata->xfer_len % 4;
+			if (remainder > 0) {
+				reg_val = readl(mdata->base + SPI_RX_DATA_REG);
+				memcpy(trans->rx_buf + (cnt * 4),
+					&reg_val, remainder);
+			}
 		}
 		spi_finalize_current_transfer(master);
 		return IRQ_HANDLED;
-- 
2.6.0.rc2.230.g3dd15c0
