From: leilk.liu@mediatek.com (Leilk Liu)
Date: Thu, 20 Aug 2015 17:19:09 +0800
Subject: [PATCH v2 4/4] spi: mediatek: revise coding style
In-Reply-To: <1440062349-25513-1-git-send-email-leilk.liu@mediatek.com>
References: <1440062349-25513-1-git-send-email-leilk.liu@mediatek.com>
Message-ID: <1440062349-25513-5-git-send-email-leilk.liu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch revises littery coding style according to comments.

Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
---
 drivers/spi/spi-mt65xx.c | 52 ++++++++++++++++++++++++++++--------------------
 1 file changed, 30 insertions(+), 22 deletions(-)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index 43c1dd5..eaadc7e 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -16,6 +16,7 @@
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/interrupt.h>
+#include <linux/io.h>
 #include <linux/ioport.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -66,6 +67,8 @@
 
 #define MT8173_SPI_MAX_PAD_SEL 3
 
+#define MTK_SPI_PAUSE_INT_STATUS 0x2
+
 #define MTK_SPI_IDLE 0
 #define MTK_SPI_PAUSED 1
 
@@ -178,7 +181,7 @@ static int mtk_spi_prepare_hardware(struct spi_master *master)
 
 	trans = list_first_entry(&msg->transfers, struct spi_transfer,
 				 transfer_list);
-	if (trans->cs_change == 0) {
+	if (!trans->cs_change) {
 		mdata->state = MTK_SPI_IDLE;
 		mtk_spi_reset(mdata);
 	}
@@ -235,8 +238,7 @@ static void mtk_spi_set_cs(struct spi_device *spi, bool enable)
 static void mtk_spi_prepare_transfer(struct spi_master *master,
 				     struct spi_transfer *xfer)
 {
-	u32 spi_clk_hz, div, high_time, low_time, holdtime,
-	    setuptime, cs_idletime, reg_val = 0;
+	u32 spi_clk_hz, div, sck_time, cs_time, reg_val = 0;
 	struct mtk_spi *mdata = spi_master_get_devdata(master);
 
 	spi_clk_hz = clk_get_rate(mdata->spi_clk);
@@ -245,21 +247,18 @@ static void mtk_spi_prepare_transfer(struct spi_master *master,
 	else
 		div = 1;
 
-	high_time = (div + 1) / 2;
-	low_time = (div + 1) / 2;
-	holdtime = (div + 1) / 2 * 2;
-	setuptime = (div + 1) / 2 * 2;
-	cs_idletime = (div + 1) / 2 * 2;
+	sck_time = (div + 1) / 2;
+	cs_time = sck_time * 2;
 
-	reg_val |= (((high_time - 1) & 0xff) << SPI_CFG0_SCK_HIGH_OFFSET);
-	reg_val |= (((low_time - 1) & 0xff) << SPI_CFG0_SCK_LOW_OFFSET);
-	reg_val |= (((holdtime - 1) & 0xff) << SPI_CFG0_CS_HOLD_OFFSET);
-	reg_val |= (((setuptime - 1) & 0xff) << SPI_CFG0_CS_SETUP_OFFSET);
+	reg_val |= (((sck_time - 1) & 0xff) << SPI_CFG0_SCK_HIGH_OFFSET);
+	reg_val |= (((sck_time - 1) & 0xff) << SPI_CFG0_SCK_LOW_OFFSET);
+	reg_val |= (((cs_time - 1) & 0xff) << SPI_CFG0_CS_HOLD_OFFSET);
+	reg_val |= (((cs_time - 1) & 0xff) << SPI_CFG0_CS_SETUP_OFFSET);
 	writel(reg_val, mdata->base + SPI_CFG0_REG);
 
 	reg_val = readl(mdata->base + SPI_CFG1_REG);
 	reg_val &= ~SPI_CFG1_CS_IDLE_MASK;
-	reg_val |= (((cs_idletime - 1) & 0xff) << SPI_CFG1_CS_IDLE_OFFSET);
+	reg_val |= (((cs_time - 1) & 0xff) << SPI_CFG1_CS_IDLE_OFFSET);
 	writel(reg_val, mdata->base + SPI_CFG1_REG);
 }
 
@@ -268,11 +267,11 @@ static void mtk_spi_setup_packet(struct spi_master *master)
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
@@ -280,7 +279,7 @@ static void mtk_spi_setup_packet(struct spi_master *master)
 
 static void mtk_spi_enable_transfer(struct spi_master *master)
 {
-	int cmd;
+	u32 cmd;
 	struct mtk_spi *mdata = spi_master_get_devdata(master);
 
 	cmd = readl(mdata->base + SPI_CMD_REG);
@@ -291,9 +290,9 @@ static void mtk_spi_enable_transfer(struct spi_master *master)
 	writel(cmd, mdata->base + SPI_CMD_REG);
 }
 
-static int mtk_spi_get_mult_delta(int xfer_len)
+static int mtk_spi_get_mult_delta(u32 xfer_len)
 {
-	int mult_delta;
+	u32 mult_delta;
 
 	if (xfer_len > MTK_SPI_PACKET_SIZE)
 		mult_delta = xfer_len % MTK_SPI_PACKET_SIZE;
@@ -434,7 +433,7 @@ static irqreturn_t mtk_spi_interrupt(int irq, void *dev_id)
 	struct spi_transfer *trans = mdata->cur_transfer;
 
 	reg_val = readl(mdata->base + SPI_STATUS0_REG);
-	if (reg_val & 0x2)
+	if (reg_val & MTK_SPI_PAUSE_INT_STATUS)
 		mdata->state = MTK_SPI_PAUSED;
 	else
 		mdata->state = MTK_SPI_IDLE;
@@ -497,7 +496,7 @@ static int mtk_spi_probe(struct platform_device *pdev)
 	struct mtk_spi *mdata;
 	const struct of_device_id *of_id;
 	struct resource *res;
-	int	irq, ret;
+	int irq, ret;
 
 	master = spi_alloc_master(&pdev->dev, sizeof(*mdata));
 	if (!master) {
@@ -662,8 +661,10 @@ static int mtk_spi_resume(struct device *dev)
 
 	if (!pm_runtime_suspended(dev)) {
 		ret = clk_prepare_enable(mdata->spi_clk);
-		if (ret < 0)
+		if (ret < 0) {
+			dev_err(dev, "failed to enable spi_clk (%d)\n", ret);
 			return ret;
+		}
 	}
 
 	ret = spi_master_resume(master);
@@ -689,8 +690,15 @@ static int mtk_spi_runtime_resume(struct device *dev)
 {
 	struct spi_master *master = dev_get_drvdata(dev);
 	struct mtk_spi *mdata = spi_master_get_devdata(master);
+	int ret;
 
-	return clk_prepare_enable(mdata->spi_clk);
+	ret = clk_prepare_enable(mdata->spi_clk);
+	if (ret < 0) {
+		dev_err(dev, "failed to enable spi_clk (%d)\n", ret);
+		return ret;
+	}
+
+	return 0;
 }
 #endif /* CONFIG_PM */
 
-- 
1.8.1.1.dirty
