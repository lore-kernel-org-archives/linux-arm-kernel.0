From: eddie.huang@mediatek.com (Eddie Huang)
Date: Sat, 21 Mar 2015 14:05:22 +0800
Subject: [PATCH v5 3/3] I2C: mediatek: Add driver for MediaTek MT8173 I2C
 controller
In-Reply-To: <1426917922-61356-1-git-send-email-eddie.huang@mediatek.com>
References: <1426917922-61356-1-git-send-email-eddie.huang@mediatek.com>
Message-ID: <1426917922-61356-4-git-send-email-eddie.huang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add mediatek MT8173 I2C controller driver. Compare to I2C controller
of earlier mediatek SoC, MT8173 fix write-then-read limitation, and
also increase message size to 64kb.

Signed-off-by: Xudong Chen <xudong.chen@mediatek.com>
Signed-off-by: Liguo Zhang <liguo.zhang@mediatek.com>
Signed-off-by: Eddie Huang <eddie.huang@mediatek.com>
---
 drivers/i2c/busses/i2c-mt65xx.c | 107 ++++++++++++++++++++++++++++------------
 1 file changed, 75 insertions(+), 32 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mt65xx.c b/drivers/i2c/busses/i2c-mt65xx.c
index 3940112..17607c8 100644
--- a/drivers/i2c/busses/i2c-mt65xx.c
+++ b/drivers/i2c/busses/i2c-mt65xx.c
@@ -33,10 +33,13 @@
 #include <linux/of_irq.h>
 #include <linux/clk.h>
 
+#define I2C_RS_TRANSFER			(1 << 4)
 #define I2C_HS_NACKERR			(1 << 2)
 #define I2C_ACKERR			(1 << 1)
 #define I2C_TRANSAC_COMP		(1 << 0)
 #define I2C_TRANSAC_START		(1 << 0)
+#define I2C_RS_MUL_CNFG			(1 << 15)
+#define I2C_RS_MUL_TRIG			(1 << 14)
 #define I2C_TIMING_STEP_DIV_MASK	(0x3f << 0)
 #define I2C_TIMING_SAMPLE_COUNT_MASK	(0x7 << 0)
 #define I2C_TIMING_SAMPLE_DIV_MASK	(0x7 << 8)
@@ -67,6 +70,9 @@
 #define MAX_MSG_NUM_MT6577		1
 #define MAX_DMA_TRANS_SIZE_MT6577	255
 #define MAX_WRRD_TRANS_SIZE_MT6577	31
+#define MAX_MSG_NUM_MT8173		65535
+#define MAX_DMA_TRANS_SIZE_MT8173	65535
+#define MAX_WRRD_TRANS_SIZE_MT8173	65535
 #define MAX_SAMPLE_CNT_DIV		8
 #define MAX_STEP_CNT_DIV		64
 #define MAX_HS_STEP_CNT_DIV		8
@@ -81,6 +87,7 @@
 
 #define COMPAT_MT6577			(0x1 << 0)
 #define COMPAT_MT6589			(0x1 << 1)
+#define COMPAT_MT8173			(0x1 << 2)
 
 #define I2C_DRV_NAME		"mt-i2c"
 
@@ -172,6 +179,7 @@ struct mtk_i2c {
 static const struct of_device_id mtk_i2c_of_match[] = {
 	{ .compatible = "mediatek,mt6577-i2c", .data = (void *)COMPAT_MT6577 },
 	{ .compatible = "mediatek,mt6589-i2c", .data = (void *)COMPAT_MT6589 },
+	{ .compatible = "mediatek,mt8173-i2c", .data = (void *)COMPAT_MT8173 },
 	{}
 };
 MODULE_DEVICE_TABLE(of, mtk_i2c_match);
@@ -236,7 +244,7 @@ static inline void mtk_i2c_init_hw(struct mtk_i2c *i2c)
 	else
 		mtk_i2c_writew(I2C_IO_CONFIG_OPEN_DRAIN, i2c, OFFSET_IO_CONFIG);
 
-	if (i2c->platform_compat & COMPAT_MT6577)
+	if (i2c->platform_compat & (COMPAT_MT6577 | COMPAT_MT8173))
 		mtk_i2c_writew(I2C_DCM_DISABLE, i2c, OFFSET_DCM_EN);
 
 	mtk_i2c_writew(i2c->timing_reg, i2c, OFFSET_TIMING);
@@ -320,10 +328,12 @@ static int i2c_set_speed(struct mtk_i2c *i2c, unsigned int clk_src_in_hz)
 	return 0;
 }
 
-static int mtk_i2c_do_transfer(struct mtk_i2c *i2c, struct i2c_msg *msgs)
+static int mtk_i2c_do_transfer(struct mtk_i2c *i2c, struct i2c_msg *msgs,
+					int num, int left_num)
 {
 	u16 addr_reg;
 	u16 control_reg;
+	u16 start_reg = 0;
 	u16 irqstat;
 	dma_addr_t rpaddr = 0;
 	dma_addr_t wpaddr = 0;
@@ -344,6 +354,8 @@ static int mtk_i2c_do_transfer(struct mtk_i2c *i2c, struct i2c_msg *msgs)
 		control_reg |= I2C_CONTROL_RS;
 	if (i2c->op == I2C_MASTER_WRRD)
 		control_reg |= I2C_CONTROL_DIR_CHANGE | I2C_CONTROL_RS;
+	if (left_num >= 1)
+		control_reg |= I2C_CONTROL_RS;
 	mtk_i2c_writew(control_reg, i2c, OFFSET_CONTROL);
 
 	/* set start condition */
@@ -361,13 +373,13 @@ static int mtk_i2c_do_transfer(struct mtk_i2c *i2c, struct i2c_msg *msgs)
 	mtk_i2c_writew(addr_reg, i2c, OFFSET_SLAVE_ADDR);
 
 	/* Clear interrupt status */
-	mtk_i2c_writew(I2C_HS_NACKERR | I2C_ACKERR | I2C_TRANSAC_COMP,
-		i2c, OFFSET_INTR_STAT);
+	mtk_i2c_writew(I2C_RS_TRANSFER | I2C_HS_NACKERR | I2C_ACKERR
+			| I2C_TRANSAC_COMP, i2c, OFFSET_INTR_STAT);
 	mtk_i2c_writew(I2C_FIFO_ADDR_CLR, i2c, OFFSET_FIFO_ADDR_CLR);
 
 	/* Enable interrupt */
-	mtk_i2c_writew(I2C_HS_NACKERR | I2C_ACKERR | I2C_TRANSAC_COMP,
-		i2c, OFFSET_INTR_MASK);
+	mtk_i2c_writew(I2C_RS_TRANSFER | I2C_HS_NACKERR | I2C_ACKERR
+			| I2C_TRANSAC_COMP, i2c, OFFSET_INTR_MASK);
 
 	/* Set transfer and transaction len */
 	if (i2c->op == I2C_MASTER_WRRD) {
@@ -376,7 +388,7 @@ static int mtk_i2c_do_transfer(struct mtk_i2c *i2c, struct i2c_msg *msgs)
 		mtk_i2c_writew(I2C_WRRD_TRANAC_VALUE, i2c, OFFSET_TRANSAC_LEN);
 	} else {
 		mtk_i2c_writew(msgs->len, i2c, OFFSET_TRANSFER_LEN);
-		mtk_i2c_writew(I2C_RD_TRANAC_VALUE, i2c, OFFSET_TRANSAC_LEN);
+		mtk_i2c_writew(num, i2c, OFFSET_TRANSAC_LEN);
 	}
 
 	/* Prepare buffer data to start transfer */
@@ -422,7 +434,17 @@ static int mtk_i2c_do_transfer(struct mtk_i2c *i2c, struct i2c_msg *msgs)
 	/* flush before sending start */
 	mb();
 	mtk_i2c_writel_dma(I2C_DMA_START_EN, i2c, OFFSET_EN);
-	mtk_i2c_writew(I2C_TRANSAC_START, i2c, OFFSET_START);
+
+	if (i2c->platform_compat & (COMPAT_MT6577 | COMPAT_MT6589)) {
+		start_reg = I2C_TRANSAC_START;
+	} else if (i2c->platform_compat & COMPAT_MT8173) {
+		if (left_num >= 1)
+			start_reg = I2C_TRANSAC_START | I2C_RS_MUL_CNFG
+					| I2C_RS_MUL_TRIG;
+		else
+			start_reg = I2C_TRANSAC_START | I2C_RS_MUL_TRIG;
+	}
+	mtk_i2c_writew(start_reg, i2c, OFFSET_START);
 
 	tmo = wait_event_timeout(i2c->wait, i2c->trans_stop, tmo);
 
@@ -455,6 +477,10 @@ static int mtk_i2c_do_transfer(struct mtk_i2c *i2c, struct i2c_msg *msgs)
 		return -EREMOTEIO;
 	}
 
+	if (irqstat & I2C_RS_TRANSFER)
+		dev_dbg(i2c->dev, "addr: %x, restart transfer interrupt.\n",
+				msgs->addr);
+
 	return 0;
 }
 
@@ -469,28 +495,33 @@ static int mtk_i2c_transfer(struct i2c_adapter *adap,
 	if (ret)
 		return ret;
 
-	if (msgs->buf == NULL) {
-		dev_dbg(i2c->dev, "data buffer is NULL.\n");
-		ret = -EINVAL;
-		goto err_exit;
-	}
-
-	if (msgs->flags & I2C_M_RD)
-		i2c->op = I2C_MASTER_RD;
-	else
-		i2c->op = I2C_MASTER_WR;
+	while (left_num--) {
+		if (msgs->buf == NULL) {
+			dev_dbg(i2c->dev, "data buffer is NULL.\n");
+			ret = -EINVAL;
+			goto err_exit;
+		}
 
-	if (num > 1) {
-		/* combined two messages into one transaction */
-		i2c->op = I2C_MASTER_WRRD;
-		left_num--;
-	}
+		if (msgs->flags & I2C_M_RD)
+			i2c->op = I2C_MASTER_RD;
+		else
+			i2c->op = I2C_MASTER_WR;
+
+		if (i2c->platform_compat & (COMPAT_MT6577 | COMPAT_MT6589)) {
+			if (num > 1) {
+				/* combined two messages into one transaction */
+				i2c->op = I2C_MASTER_WRRD;
+				left_num--;
+			}
+		}
 
-	/* always use DMA mode. */
-	ret = mtk_i2c_do_transfer(i2c, msgs);
-	if (ret < 0)
-		goto err_exit;
+		/* always use DMA mode. */
+		ret = mtk_i2c_do_transfer(i2c, msgs, num, left_num);
+		if (ret < 0)
+			goto err_exit;
 
+		msgs++;
+	}
 	/* the return value is number of executed messages */
 	ret = num;
 
@@ -504,14 +535,14 @@ static irqreturn_t mtk_i2c_irq(int irqno, void *dev_id)
 	struct mtk_i2c *i2c = dev_id;
 
 	/* Clear interrupt mask */
-	mtk_i2c_writew(~(I2C_HS_NACKERR | I2C_ACKERR | I2C_TRANSAC_COMP),
-		i2c, OFFSET_INTR_MASK);
+	mtk_i2c_writew(~(I2C_RS_TRANSFER | I2C_HS_NACKERR | I2C_ACKERR
+			| I2C_TRANSAC_COMP), i2c, OFFSET_INTR_MASK);
 
 	spin_lock(&i2c->irqlock);
 	i2c->irq_stat = mtk_i2c_readw(i2c, OFFSET_INTR_STAT);
 	i2c->trans_stop = true;
 	spin_unlock(&i2c->irqlock);
-	mtk_i2c_writew(I2C_HS_NACKERR | I2C_ACKERR
+	mtk_i2c_writew(I2C_RS_TRANSFER | I2C_HS_NACKERR | I2C_ACKERR
 			| I2C_TRANSAC_COMP, i2c, OFFSET_INTR_STAT);
 	wake_up(&i2c->wait);
 
@@ -569,6 +600,14 @@ static const struct i2c_adapter_quirks mt6577_i2c_quirks = {
 	.max_comb_2nd_msg_len = MAX_WRRD_TRANS_SIZE_MT6577,
 };
 
+static const struct i2c_adapter_quirks mt8173_i2c_quirks = {
+	.max_num_msgs = MAX_MSG_NUM_MT8173,
+	.max_write_len = MAX_DMA_TRANS_SIZE_MT8173,
+	.max_read_len = MAX_DMA_TRANS_SIZE_MT8173,
+	.max_comb_1st_msg_len = MAX_DMA_TRANS_SIZE_MT8173,
+	.max_comb_2nd_msg_len = MAX_WRRD_TRANS_SIZE_MT8173,
+};
+
 static int mtk_i2c_probe(struct platform_device *pdev)
 {
 	int ret = 0;
@@ -587,7 +626,8 @@ static int mtk_i2c_probe(struct platform_device *pdev)
 		return -EINVAL;
 
 	i2c->platform_compat = mtk_get_device_prop(pdev);
-	if (i2c->have_pmic && (i2c->platform_compat & COMPAT_MT6577))
+	if (i2c->have_pmic && (i2c->platform_compat &
+			(COMPAT_MT6577 | COMPAT_MT8173)))
 		return -EINVAL;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -613,7 +653,10 @@ static int mtk_i2c_probe(struct platform_device *pdev)
 	i2c->adap.dev.parent = &pdev->dev;
 	i2c->adap.owner = THIS_MODULE;
 	i2c->adap.algo = &mtk_i2c_algorithm;
-	i2c->adap.quirks = &mt6577_i2c_quirks;
+	if (i2c->platform_compat & COMPAT_MT8173)
+		i2c->adap.quirks = &mt8173_i2c_quirks;
+	else
+		i2c->adap.quirks = &mt6577_i2c_quirks;
 	i2c->adap.timeout = 2 * HZ;
 	i2c->adap.retries = 1;
 
-- 
1.8.1.1.dirty
