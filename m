From: leilk.liu@mediatek.com (Leilk Liu)
Date: Mon, 24 Aug 2015 11:45:16 +0800
Subject: [PATCH v3 2/4] spi: mediatek: replace int with u32,
 delete TAB and define MTK_SPI_PAUSE_INT_STATUS marco
In-Reply-To: <1440387918-22191-1-git-send-email-leilk.liu@mediatek.com>
References: <1440387918-22191-1-git-send-email-leilk.liu@mediatek.com>
Message-ID: <1440387918-22191-3-git-send-email-leilk.liu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

this patch replaces int with u32, deletes TAB, and defines
MTK_SPI_PAUSE_INT_STATUS marco.

Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
---
 drivers/spi/spi-mt65xx.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index fe4eda3..f81618c 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -67,6 +67,8 @@
 
 #define MT8173_SPI_MAX_PAD_SEL 3
 
+#define MTK_SPI_PAUSE_INT_STATUS 0x2
+
 #define MTK_SPI_IDLE 0
 #define MTK_SPI_PAUSED 1
 
@@ -179,7 +181,7 @@ static int mtk_spi_prepare_hardware(struct spi_master *master)
 
 	trans = list_first_entry(&msg->transfers, struct spi_transfer,
 				 transfer_list);
-	if (trans->cs_change == 0) {
+	if (!trans->cs_change) {
 		mdata->state = MTK_SPI_IDLE;
 		mtk_spi_reset(mdata);
 	}
@@ -269,11 +271,11 @@ static void mtk_spi_setup_packet(struct spi_master *master)
 	u32 packet_size, packet_loop, reg_val;
 	struct mtk_spi *mdata = spi_master_get_devdata(master);
 
-	packet_size = min_t(unsigned, mdata->xfer_len, MTK_SPI_PACKET_SIZE);
+	packet_size = min_t(u32, mdata->xfer_len, MTK_SPI_PACKET_SIZE);
 	packet_loop = mdata->xfer_len / packet_size;
 
 	reg_val = readl(mdata->base + SPI_CFG1_REG);
-	reg_val &= ~(SPI_CFG1_PACKET_LENGTH_MASK + SPI_CFG1_PACKET_LOOP_MASK);
+	reg_val &= ~(SPI_CFG1_PACKET_LENGTH_MASK | SPI_CFG1_PACKET_LOOP_MASK);
 	reg_val |= (packet_size - 1) << SPI_CFG1_PACKET_LENGTH_OFFSET;
 	reg_val |= (packet_loop - 1) << SPI_CFG1_PACKET_LOOP_OFFSET;
 	writel(reg_val, mdata->base + SPI_CFG1_REG);
@@ -281,7 +283,7 @@ static void mtk_spi_setup_packet(struct spi_master *master)
 
 static void mtk_spi_enable_transfer(struct spi_master *master)
 {
-	int cmd;
+	u32 cmd;
 	struct mtk_spi *mdata = spi_master_get_devdata(master);
 
 	cmd = readl(mdata->base + SPI_CMD_REG);
@@ -292,9 +294,9 @@ static void mtk_spi_enable_transfer(struct spi_master *master)
 	writel(cmd, mdata->base + SPI_CMD_REG);
 }
 
-static int mtk_spi_get_mult_delta(int xfer_len)
+static int mtk_spi_get_mult_delta(u32 xfer_len)
 {
-	int mult_delta;
+	u32 mult_delta;
 
 	if (xfer_len > MTK_SPI_PACKET_SIZE)
 		mult_delta = xfer_len % MTK_SPI_PACKET_SIZE;
@@ -435,7 +437,7 @@ static irqreturn_t mtk_spi_interrupt(int irq, void *dev_id)
 	struct spi_transfer *trans = mdata->cur_transfer;
 
 	reg_val = readl(mdata->base + SPI_STATUS0_REG);
-	if (reg_val & 0x2)
+	if (reg_val & MTK_SPI_PAUSE_INT_STATUS)
 		mdata->state = MTK_SPI_PAUSED;
 	else
 		mdata->state = MTK_SPI_IDLE;
@@ -498,7 +500,7 @@ static int mtk_spi_probe(struct platform_device *pdev)
 	struct mtk_spi *mdata;
 	const struct of_device_id *of_id;
 	struct resource *res;
-	int	irq, ret;
+	int irq, ret;
 
 	master = spi_alloc_master(&pdev->dev, sizeof(*mdata));
 	if (!master) {
-- 
1.8.1.1.dirty
