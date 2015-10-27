From: liguo.zhang@mediatek.com (Liguo Zhang)
Date: Tue, 27 Oct 2015 16:59:26 +0800
Subject: [PATCH 1/2] i2c: mediatek: add i2c first write then read optimization
In-Reply-To: <1445936367-30141-1-git-send-email-liguo.zhang@mediatek.com>
References: <1445936367-30141-1-git-send-email-liguo.zhang@mediatek.com>
Message-ID: <1445936367-30141-2-git-send-email-liguo.zhang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For platform with auto restart support, between every transfer,
i2c controller will trigger an interrupt and SW need to handle
it to start new transfer. When doing write-then-read transfer,
instead of restart mechanism, using WRRD mode to have controller
send both transfer in one request to reduce latency.

Signed-off-by: Liguo Zhang <liguo.zhang@mediatek.com>
---
 drivers/i2c/busses/i2c-mt65xx.c | 33 +++++++++++++++++++++++++++------
 1 file changed, 27 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mt65xx.c b/drivers/i2c/busses/i2c-mt65xx.c
index 9b86716..dc4aac6 100644
--- a/drivers/i2c/busses/i2c-mt65xx.c
+++ b/drivers/i2c/busses/i2c-mt65xx.c
@@ -132,6 +132,7 @@ struct mtk_i2c_compatible {
 	unsigned char pmic_i2c: 1;
 	unsigned char dcm: 1;
 	unsigned char auto_restart: 1;
+	unsigned char aux_len_reg: 1;
 };
 
 struct mtk_i2c {
@@ -153,6 +154,7 @@ struct mtk_i2c {
 	enum mtk_trans_op op;
 	u16 timing_reg;
 	u16 high_speed_reg;
+	unsigned char auto_restart;
 	const struct mtk_i2c_compatible *dev_comp;
 };
 
@@ -178,6 +180,7 @@ static const struct mtk_i2c_compatible mt6577_compat = {
 	.pmic_i2c = 0,
 	.dcm = 1,
 	.auto_restart = 0,
+	.aux_len_reg = 0,
 };
 
 static const struct mtk_i2c_compatible mt6589_compat = {
@@ -185,6 +188,7 @@ static const struct mtk_i2c_compatible mt6589_compat = {
 	.pmic_i2c = 1,
 	.dcm = 0,
 	.auto_restart = 0,
+	.aux_len_reg = 0,
 };
 
 static const struct mtk_i2c_compatible mt8173_compat = {
@@ -192,6 +196,7 @@ static const struct mtk_i2c_compatible mt8173_compat = {
 	.pmic_i2c = 0,
 	.dcm = 1,
 	.auto_restart = 1,
+	.aux_len_reg = 1,
 };
 
 static const struct of_device_id mtk_i2c_of_match[] = {
@@ -373,7 +378,7 @@ static int mtk_i2c_do_transfer(struct mtk_i2c *i2c, struct i2c_msg *msgs,
 
 	i2c->irq_stat = 0;
 
-	if (i2c->dev_comp->auto_restart)
+	if (i2c->auto_restart)
 		restart_flag = I2C_RS_TRANSFER;
 
 	reinit_completion(&i2c->msg_complete);
@@ -411,8 +416,14 @@ static int mtk_i2c_do_transfer(struct mtk_i2c *i2c, struct i2c_msg *msgs,
 
 	/* Set transfer and transaction len */
 	if (i2c->op == I2C_MASTER_WRRD) {
-		writew(msgs->len | ((msgs + 1)->len) << 8,
-		       i2c->base + OFFSET_TRANSFER_LEN);
+		if (i2c->dev_comp->aux_len_reg) {
+			writew(msgs->len, i2c->base + OFFSET_TRANSFER_LEN);
+			writew((msgs + 1)->len, i2c->base +
+			       OFFSET_TRANSFER_LEN_AUX);
+		} else {
+			writew(msgs->len | ((msgs + 1)->len) << 8,
+			       i2c->base + OFFSET_TRANSFER_LEN);
+		}
 		writew(I2C_WRRD_TRANAC_VALUE, i2c->base + OFFSET_TRANSAC_LEN);
 	} else {
 		writew(msgs->len, i2c->base + OFFSET_TRANSFER_LEN);
@@ -461,7 +472,7 @@ static int mtk_i2c_do_transfer(struct mtk_i2c *i2c, struct i2c_msg *msgs,
 
 	writel(I2C_DMA_START_EN, i2c->pdmabase + OFFSET_EN);
 
-	if (!i2c->dev_comp->auto_restart) {
+	if (!i2c->auto_restart) {
 		start_reg = I2C_TRANSAC_START;
 	} else {
 		start_reg = I2C_TRANSAC_START | I2C_RS_MUL_TRIG;
@@ -518,6 +529,16 @@ static int mtk_i2c_transfer(struct i2c_adapter *adap,
 	if (ret)
 		return ret;
 
+	i2c->auto_restart = i2c->dev_comp->auto_restart;
+
+	/* checking if we can skip restart and optimize using WRRD mode */
+	if (i2c->auto_restart && num == 2) {
+		if (!(msgs[0].flags & I2C_M_RD) && (msgs[1].flags & I2C_M_RD) &&
+		    msgs[0].addr == msgs[1].addr) {
+			i2c->auto_restart = 0;
+		}
+	}
+
 	while (left_num--) {
 		if (!msgs->buf) {
 			dev_dbg(i2c->dev, "data buffer is NULL.\n");
@@ -530,7 +551,7 @@ static int mtk_i2c_transfer(struct i2c_adapter *adap,
 		else
 			i2c->op = I2C_MASTER_WR;
 
-		if (!i2c->dev_comp->auto_restart) {
+		if (!i2c->auto_restart) {
 			if (num > 1) {
 				/* combined two messages into one transaction */
 				i2c->op = I2C_MASTER_WRRD;
@@ -559,7 +580,7 @@ static irqreturn_t mtk_i2c_irq(int irqno, void *dev_id)
 	u16 restart_flag = 0;
 	u16 intr_stat;
 
-	if (i2c->dev_comp->auto_restart)
+	if (i2c->auto_restart)
 		restart_flag = I2C_RS_TRANSFER;
 
 	intr_stat = readw(i2c->base + OFFSET_INTR_STAT);
-- 
1.8.1.1.dirty
