From: eddie.huang@mediatek.com (Eddie Huang)
Date: Thu, 21 May 2015 16:53:30 +0800
Subject: [PATCH v9 3/3] I2C: mediatek: Add driver for MediaTek MT8173 I2C
 controller
In-Reply-To: <1432198410-6576-1-git-send-email-eddie.huang@mediatek.com>
References: <1432198410-6576-1-git-send-email-eddie.huang@mediatek.com>
Message-ID: <1432198410-6576-4-git-send-email-eddie.huang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add mediatek MT8173 I2C controller driver. Compare to I2C controller
of earlier mediatek SoC, MT8173 fix write-then-read limitation, and
also increase message size to 64kb.

Signed-off-by: Xudong Chen <xudong.chen@mediatek.com>
Signed-off-by: Liguo Zhang <liguo.zhang@mediatek.com>
Signed-off-by: Eddie Huang <eddie.huang@mediatek.com>
Acked-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/i2c/busses/i2c-mt65xx.c | 103 +++++++++++++++++++++++++++++-----------
 1 file changed, 74 insertions(+), 29 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mt65xx.c b/drivers/i2c/busses/i2c-mt65xx.c
index b1d2d7c..9920eef 100644
--- a/drivers/i2c/busses/i2c-mt65xx.c
+++ b/drivers/i2c/busses/i2c-mt65xx.c
@@ -33,10 +33,13 @@
 #include <linux/sched.h>
 #include <linux/slab.h>
 
+#define I2C_RS_TRANSFER			(1 << 4)
 #define I2C_HS_NACKERR			(1 << 2)
 #define I2C_ACKERR			(1 << 1)
 #define I2C_TRANSAC_COMP		(1 << 0)
 #define I2C_TRANSAC_START		(1 << 0)
+#define I2C_RS_MUL_CNFG			(1 << 15)
+#define I2C_RS_MUL_TRIG			(1 << 14)
 #define I2C_DCM_DISABLE			0x0000
 #define I2C_IO_CONFIG_OPEN_DRAIN	0x0003
 #define I2C_IO_CONFIG_PUSH_PULL		0x0000
@@ -126,6 +129,7 @@ struct mtk_i2c_compatible {
 	const struct i2c_adapter_quirks *quirks;
 	unsigned char pmic_i2c: 1;
 	unsigned char dcm: 1;
+	unsigned char auto_restart: 1;
 };
 
 struct mtk_i2c {
@@ -159,21 +163,39 @@ static const struct i2c_adapter_quirks mt6577_i2c_quirks = {
 	.max_comb_2nd_msg_len = 31,
 };
 
+static const struct i2c_adapter_quirks mt8173_i2c_quirks = {
+	.max_num_msgs = 65535,
+	.max_write_len = 65535,
+	.max_read_len = 65535,
+	.max_comb_1st_msg_len = 65535,
+	.max_comb_2nd_msg_len = 65535,
+};
+
 static const struct mtk_i2c_compatible mt6577_compat = {
 	.quirks = &mt6577_i2c_quirks,
 	.pmic_i2c = 0,
 	.dcm = 1,
+	.auto_restart = 0,
 };
 
 static const struct mtk_i2c_compatible mt6589_compat = {
 	.quirks = &mt6577_i2c_quirks,
 	.pmic_i2c = 1,
 	.dcm = 0,
+	.auto_restart = 0,
+};
+
+static const struct mtk_i2c_compatible mt8173_compat = {
+	.quirks = &mt8173_i2c_quirks,
+	.pmic_i2c = 0,
+	.dcm = 1,
+	.auto_restart = 1,
 };
 
 static const struct of_device_id mtk_i2c_of_match[] = {
 	{ .compatible = "mediatek,mt6577-i2c", .data = &mt6577_compat },
 	{ .compatible = "mediatek,mt6589-i2c", .data = &mt6589_compat },
+	{ .compatible = "mediatek,mt8173-i2c", .data = &mt8173_compat },
 	{}
 };
 MODULE_DEVICE_TABLE(of, mtk_i2c_of_match);
@@ -332,21 +354,27 @@ static int mtk_i2c_set_speed(struct mtk_i2c *i2c, unsigned int parent_clk,
 	return 0;
 }
 
-static int mtk_i2c_do_transfer(struct mtk_i2c *i2c, struct i2c_msg *msgs)
+static int mtk_i2c_do_transfer(struct mtk_i2c *i2c, struct i2c_msg *msgs,
+			       int num, int left_num)
 {
 	u16 addr_reg;
+	u16 start_reg;
 	u16 control_reg;
+	u16 restart_flag = 0;
 	dma_addr_t rpaddr = 0;
 	dma_addr_t wpaddr = 0;
 	int ret;
 
 	i2c->irq_stat = 0;
 
+	if (i2c->dev_comp->auto_restart)
+		restart_flag = I2C_RS_TRANSFER;
+
 	reinit_completion(&i2c->msg_complete);
 
 	control_reg = readw(i2c->base + OFFSET_CONTROL) &
 			~(I2C_CONTROL_DIR_CHANGE | I2C_CONTROL_RS);
-	if (i2c->speed_hz > 400000)
+	if ((i2c->speed_hz > 400000) || (left_num >= 1))
 		control_reg |= I2C_CONTROL_RS;
 
 	if (i2c->op == I2C_MASTER_WRRD)
@@ -367,13 +395,13 @@ static int mtk_i2c_do_transfer(struct mtk_i2c *i2c, struct i2c_msg *msgs)
 	writew(addr_reg, i2c->base + OFFSET_SLAVE_ADDR);
 
 	/* Clear interrupt status */
-	writew(I2C_HS_NACKERR | I2C_ACKERR | I2C_TRANSAC_COMP,
-	       i2c->base + OFFSET_INTR_STAT);
+	writew(restart_flag | I2C_HS_NACKERR | I2C_ACKERR |
+	       I2C_TRANSAC_COMP, i2c->base + OFFSET_INTR_STAT);
 	writew(I2C_FIFO_ADDR_CLR, i2c->base + OFFSET_FIFO_ADDR_CLR);
 
 	/* Enable interrupt */
-	writew(I2C_HS_NACKERR | I2C_ACKERR | I2C_TRANSAC_COMP,
-	       i2c->base + OFFSET_INTR_MASK);
+	writew(restart_flag | I2C_HS_NACKERR | I2C_ACKERR |
+	       I2C_TRANSAC_COMP, i2c->base + OFFSET_INTR_MASK);
 
 	/* Set transfer and transaction len */
 	if (i2c->op == I2C_MASTER_WRRD) {
@@ -382,7 +410,7 @@ static int mtk_i2c_do_transfer(struct mtk_i2c *i2c, struct i2c_msg *msgs)
 		writew(I2C_WRRD_TRANAC_VALUE, i2c->base + OFFSET_TRANSAC_LEN);
 	} else {
 		writew(msgs->len, i2c->base + OFFSET_TRANSFER_LEN);
-		writew(I2C_RD_TRANAC_VALUE, i2c->base + OFFSET_TRANSAC_LEN);
+		writew(num, i2c->base + OFFSET_TRANSAC_LEN);
 	}
 
 	/* Prepare buffer data to start transfer */
@@ -426,13 +454,21 @@ static int mtk_i2c_do_transfer(struct mtk_i2c *i2c, struct i2c_msg *msgs)
 	}
 
 	writel(I2C_DMA_START_EN, i2c->pdmabase + OFFSET_EN);
-	writew(I2C_TRANSAC_START, i2c->base + OFFSET_START);
+
+	if (!i2c->dev_comp->auto_restart) {
+		start_reg = I2C_TRANSAC_START;
+	} else {
+		start_reg = I2C_TRANSAC_START | I2C_RS_MUL_TRIG;
+		if (left_num >= 1)
+			start_reg |= I2C_RS_MUL_CNFG;
+	}
+	writew(start_reg, i2c->base + OFFSET_START);
 
 	ret = wait_for_completion_timeout(&i2c->msg_complete,
 					  i2c->adap.timeout);
 
 	/* Clear interrupt mask */
-	writew(~(I2C_HS_NACKERR | I2C_ACKERR |
+	writew(~(restart_flag | I2C_HS_NACKERR | I2C_ACKERR |
 	       I2C_TRANSAC_COMP), i2c->base + OFFSET_INTR_MASK);
 
 	if (i2c->op == I2C_MASTER_WR) {
@@ -476,28 +512,33 @@ static int mtk_i2c_transfer(struct i2c_adapter *adap,
 	if (ret)
 		return ret;
 
-	if (!msgs->buf) {
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
+		if (!msgs->buf) {
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
+		if (!i2c->dev_comp->auto_restart) {
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
 
@@ -509,9 +550,13 @@ err_exit:
 static irqreturn_t mtk_i2c_irq(int irqno, void *dev_id)
 {
 	struct mtk_i2c *i2c = dev_id;
+	u16 restart_flag = 0;
+
+	if (i2c->dev_comp->auto_restart)
+		restart_flag = I2C_RS_TRANSFER;
 
 	i2c->irq_stat = readw(i2c->base + OFFSET_INTR_STAT);
-	writew(I2C_HS_NACKERR | I2C_ACKERR
+	writew(restart_flag | I2C_HS_NACKERR | I2C_ACKERR
 		| I2C_TRANSAC_COMP, i2c->base + OFFSET_INTR_STAT);
 
 	complete(&i2c->msg_complete);
-- 
1.8.1.1.dirty
