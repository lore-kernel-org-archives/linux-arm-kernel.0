From: liguo.zhang@mediatek.com (Liguo Zhang)
Date: Tue, 8 Mar 2016 02:23:51 +0800
Subject: [PATCH v3] i2c: mediatek: i2c multi transfer optimization
Message-ID: <1457375031-3769-1-git-send-email-liguo.zhang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signal complete() in the i2c irq handler after one transfer done,
and then wait_for_completion_timeout() will return, this procedure
may cost much time, so only signal complete() when the entire
transaction has been completed, it will reduce the entire transaction
time.

Signed-off-by: Liguo Zhang <liguo.zhang@mediatek.com>
---
change in v3:
Update the commit message of this patch.
change in v2:
Remove the unused variable left_num in mtk_i2c_transfer().
---
 drivers/i2c/busses/i2c-mt65xx.c | 221 ++++++++++++++++++++++------------------
 1 file changed, 123 insertions(+), 98 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mt65xx.c b/drivers/i2c/busses/i2c-mt65xx.c
index 453358b..3a498e1 100644
--- a/drivers/i2c/busses/i2c-mt65xx.c
+++ b/drivers/i2c/busses/i2c-mt65xx.c
@@ -139,6 +139,15 @@ struct mtk_i2c_compatible {
 	unsigned char support_33bits: 1;
 };
 
+struct mtk_i2c_transaction {
+	u32 num;
+	u32 index;
+	dma_addr_t wpaddr;
+	dma_addr_t rpaddr;
+	struct i2c_msg *msgs;
+	int result;
+};
+
 struct mtk_i2c {
 	struct i2c_adapter adap;	/* i2c host adapter */
 	struct device *dev;
@@ -161,6 +170,7 @@ struct mtk_i2c {
 	unsigned char auto_restart;
 	bool ignore_restart_irq;
 	const struct mtk_i2c_compatible *dev_comp;
+	struct mtk_i2c_transaction transac;
 };
 
 static const struct i2c_adapter_quirks mt6577_i2c_quirks = {
@@ -378,8 +388,7 @@ static inline u32 mtk_i2c_set_4g_mode(dma_addr_t addr)
 	return (addr & BIT_ULL(32)) ? I2C_DMA_4G_MODE : I2C_DMA_CLR_FLAG;
 }
 
-static int mtk_i2c_do_transfer(struct mtk_i2c *i2c, struct i2c_msg *msgs,
-			       int num, int left_num)
+static int mtk_i2c_start_transfer(struct mtk_i2c *i2c)
 {
 	u16 addr_reg;
 	u16 start_reg;
@@ -388,15 +397,31 @@ static int mtk_i2c_do_transfer(struct mtk_i2c *i2c, struct i2c_msg *msgs,
 	u32 reg_4g_mode;
 	dma_addr_t rpaddr = 0;
 	dma_addr_t wpaddr = 0;
-	int ret;
+	struct i2c_msg *msg;
+	struct mtk_i2c_transaction *i2c_transac;
+	int num;
+	int left_num;
 
 	i2c->irq_stat = 0;
 
+	i2c_transac = &i2c->transac;
+	num = i2c_transac->num;
+	left_num = i2c_transac->num - i2c_transac->index - 1;
+	msg = &i2c_transac->msgs[i2c_transac->index];
+
+	if (!msg->buf)
+		return -EINVAL;
+
+	if (i2c->op == I2C_MASTER_WRRD)
+		left_num--;
+	else if (msg->flags & I2C_M_RD)
+		i2c->op = I2C_MASTER_RD;
+	else
+		i2c->op = I2C_MASTER_WR;
+
 	if (i2c->auto_restart)
 		restart_flag = I2C_RS_TRANSFER;
 
-	reinit_completion(&i2c->msg_complete);
-
 	control_reg = readw(i2c->base + OFFSET_CONTROL) &
 			~(I2C_CONTROL_DIR_CHANGE | I2C_CONTROL_RS);
 	if ((i2c->speed_hz > 400000) || (left_num >= 1))
@@ -413,7 +438,7 @@ static int mtk_i2c_do_transfer(struct mtk_i2c *i2c, struct i2c_msg *msgs,
 	else
 		writew(I2C_FS_START_CON, i2c->base + OFFSET_EXT_CONF);
 
-	addr_reg = msgs->addr << 1;
+	addr_reg = msg->addr << 1;
 	if (i2c->op == I2C_MASTER_RD)
 		addr_reg |= 0x1;
 
@@ -431,16 +456,16 @@ static int mtk_i2c_do_transfer(struct mtk_i2c *i2c, struct i2c_msg *msgs,
 	/* Set transfer and transaction len */
 	if (i2c->op == I2C_MASTER_WRRD) {
 		if (i2c->dev_comp->aux_len_reg) {
-			writew(msgs->len, i2c->base + OFFSET_TRANSFER_LEN);
-			writew((msgs + 1)->len, i2c->base +
+			writew(msg->len, i2c->base + OFFSET_TRANSFER_LEN);
+			writew((msg + 1)->len, i2c->base +
 			       OFFSET_TRANSFER_LEN_AUX);
 		} else {
-			writew(msgs->len | ((msgs + 1)->len) << 8,
+			writew(msg->len | ((msg + 1)->len) << 8,
 			       i2c->base + OFFSET_TRANSFER_LEN);
 		}
 		writew(I2C_WRRD_TRANAC_VALUE, i2c->base + OFFSET_TRANSAC_LEN);
 	} else {
-		writew(msgs->len, i2c->base + OFFSET_TRANSFER_LEN);
+		writew(msg->len, i2c->base + OFFSET_TRANSFER_LEN);
 		writew(num, i2c->base + OFFSET_TRANSAC_LEN);
 	}
 
@@ -448,8 +473,8 @@ static int mtk_i2c_do_transfer(struct mtk_i2c *i2c, struct i2c_msg *msgs,
 	if (i2c->op == I2C_MASTER_RD) {
 		writel(I2C_DMA_INT_FLAG_NONE, i2c->pdmabase + OFFSET_INT_FLAG);
 		writel(I2C_DMA_CON_RX, i2c->pdmabase + OFFSET_CON);
-		rpaddr = dma_map_single(i2c->dev, msgs->buf,
-					msgs->len, DMA_FROM_DEVICE);
+		rpaddr = dma_map_single(i2c->dev, msg->buf, msg->len,
+					DMA_FROM_DEVICE);
 		if (dma_mapping_error(i2c->dev, rpaddr))
 			return -ENOMEM;
 
@@ -459,12 +484,13 @@ static int mtk_i2c_do_transfer(struct mtk_i2c *i2c, struct i2c_msg *msgs,
 		}
 
 		writel((u32)rpaddr, i2c->pdmabase + OFFSET_RX_MEM_ADDR);
-		writel(msgs->len, i2c->pdmabase + OFFSET_RX_LEN);
+		writel(msg->len, i2c->pdmabase + OFFSET_RX_LEN);
+		i2c_transac->rpaddr = rpaddr;
 	} else if (i2c->op == I2C_MASTER_WR) {
 		writel(I2C_DMA_INT_FLAG_NONE, i2c->pdmabase + OFFSET_INT_FLAG);
 		writel(I2C_DMA_CON_TX, i2c->pdmabase + OFFSET_CON);
-		wpaddr = dma_map_single(i2c->dev, msgs->buf,
-					msgs->len, DMA_TO_DEVICE);
+		wpaddr = dma_map_single(i2c->dev, msg->buf, msg->len,
+					DMA_TO_DEVICE);
 		if (dma_mapping_error(i2c->dev, wpaddr))
 			return -ENOMEM;
 
@@ -474,20 +500,21 @@ static int mtk_i2c_do_transfer(struct mtk_i2c *i2c, struct i2c_msg *msgs,
 		}
 
 		writel((u32)wpaddr, i2c->pdmabase + OFFSET_TX_MEM_ADDR);
-		writel(msgs->len, i2c->pdmabase + OFFSET_TX_LEN);
+		writel(msg->len, i2c->pdmabase + OFFSET_TX_LEN);
+
+		i2c_transac->wpaddr = wpaddr;
 	} else {
 		writel(I2C_DMA_CLR_FLAG, i2c->pdmabase + OFFSET_INT_FLAG);
 		writel(I2C_DMA_CLR_FLAG, i2c->pdmabase + OFFSET_CON);
-		wpaddr = dma_map_single(i2c->dev, msgs->buf,
-					msgs->len, DMA_TO_DEVICE);
+		wpaddr = dma_map_single(i2c->dev, msg->buf, msg->len,
+					DMA_TO_DEVICE);
 		if (dma_mapping_error(i2c->dev, wpaddr))
 			return -ENOMEM;
-		rpaddr = dma_map_single(i2c->dev, (msgs + 1)->buf,
-					(msgs + 1)->len,
-					DMA_FROM_DEVICE);
+		rpaddr = dma_map_single(i2c->dev, (msg + 1)->buf,
+					(msg + 1)->len, DMA_FROM_DEVICE);
 		if (dma_mapping_error(i2c->dev, rpaddr)) {
-			dma_unmap_single(i2c->dev, wpaddr,
-					 msgs->len, DMA_TO_DEVICE);
+			dma_unmap_single(i2c->dev, wpaddr, msg->len,
+					 DMA_TO_DEVICE);
 			return -ENOMEM;
 		}
 
@@ -501,8 +528,11 @@ static int mtk_i2c_do_transfer(struct mtk_i2c *i2c, struct i2c_msg *msgs,
 
 		writel((u32)wpaddr, i2c->pdmabase + OFFSET_TX_MEM_ADDR);
 		writel((u32)rpaddr, i2c->pdmabase + OFFSET_RX_MEM_ADDR);
-		writel(msgs->len, i2c->pdmabase + OFFSET_TX_LEN);
-		writel((msgs + 1)->len, i2c->pdmabase + OFFSET_RX_LEN);
+		writel(msg->len, i2c->pdmabase + OFFSET_TX_LEN);
+		writel((msg + 1)->len, i2c->pdmabase + OFFSET_RX_LEN);
+
+		i2c_transac->wpaddr = wpaddr;
+		i2c_transac->rpaddr = rpaddr;
 	}
 
 	writel(I2C_DMA_START_EN, i2c->pdmabase + OFFSET_EN);
@@ -516,40 +546,6 @@ static int mtk_i2c_do_transfer(struct mtk_i2c *i2c, struct i2c_msg *msgs,
 	}
 	writew(start_reg, i2c->base + OFFSET_START);
 
-	ret = wait_for_completion_timeout(&i2c->msg_complete,
-					  i2c->adap.timeout);
-
-	/* Clear interrupt mask */
-	writew(~(restart_flag | I2C_HS_NACKERR | I2C_ACKERR |
-	       I2C_TRANSAC_COMP), i2c->base + OFFSET_INTR_MASK);
-
-	if (i2c->op == I2C_MASTER_WR) {
-		dma_unmap_single(i2c->dev, wpaddr,
-				 msgs->len, DMA_TO_DEVICE);
-	} else if (i2c->op == I2C_MASTER_RD) {
-		dma_unmap_single(i2c->dev, rpaddr,
-				 msgs->len, DMA_FROM_DEVICE);
-	} else {
-		dma_unmap_single(i2c->dev, wpaddr, msgs->len,
-				 DMA_TO_DEVICE);
-		dma_unmap_single(i2c->dev, rpaddr, (msgs + 1)->len,
-				 DMA_FROM_DEVICE);
-	}
-
-	if (ret == 0) {
-		dev_dbg(i2c->dev, "addr: %x, transfer timeout\n", msgs->addr);
-		mtk_i2c_init_hw(i2c);
-		return -ETIMEDOUT;
-	}
-
-	completion_done(&i2c->msg_complete);
-
-	if (i2c->irq_stat & (I2C_HS_NACKERR | I2C_ACKERR)) {
-		dev_dbg(i2c->dev, "addr: %x, transfer ACK error\n", msgs->addr);
-		mtk_i2c_init_hw(i2c);
-		return -ENXIO;
-	}
-
 	return 0;
 }
 
@@ -557,21 +553,28 @@ static int mtk_i2c_transfer(struct i2c_adapter *adap,
 			    struct i2c_msg msgs[], int num)
 {
 	int ret;
-	int left_num = num;
 	struct mtk_i2c *i2c = i2c_get_adapdata(adap);
+	struct mtk_i2c_transaction *i2c_transac = &i2c->transac;
+
+	i2c_transac->num = num;
+	i2c_transac->index = 0;
+	i2c_transac->msgs = msgs;
+	i2c_transac->result = 0;
+
+	reinit_completion(&i2c->msg_complete);
 
 	ret = mtk_i2c_clock_enable(i2c);
 	if (ret)
 		return ret;
 
+	i2c->op = 0;
 	i2c->auto_restart = i2c->dev_comp->auto_restart;
 
 	/* checking if we can skip restart and optimize using WRRD mode */
-	if (i2c->auto_restart && num == 2) {
-		if (!(msgs[0].flags & I2C_M_RD) && (msgs[1].flags & I2C_M_RD) &&
-		    msgs[0].addr == msgs[1].addr) {
-			i2c->auto_restart = 0;
-		}
+	if (num == 2 && !(msgs[0].flags & I2C_M_RD) &&
+	    (msgs[1].flags & I2C_M_RD) && msgs[0].addr == msgs[1].addr) {
+		i2c->op = I2C_MASTER_WRRD;
+		i2c->auto_restart = 0;
 	}
 
 	if (i2c->auto_restart && num >= 2 && i2c->speed_hz > MAX_FS_MODE_SPEED)
@@ -582,33 +585,33 @@ static int mtk_i2c_transfer(struct i2c_adapter *adap,
 	else
 		i2c->ignore_restart_irq = false;
 
-	while (left_num--) {
-		if (!msgs->buf) {
-			dev_dbg(i2c->dev, "data buffer is NULL.\n");
-			ret = -EINVAL;
-			goto err_exit;
-		}
+	/* always use DMA mode. */
+	ret = mtk_i2c_start_transfer(i2c);
+	if (ret < 0)
+		goto err_exit;
 
-		if (msgs->flags & I2C_M_RD)
-			i2c->op = I2C_MASTER_RD;
-		else
-			i2c->op = I2C_MASTER_WR;
-
-		if (!i2c->auto_restart) {
-			if (num > 1) {
-				/* combined two messages into one transaction */
-				i2c->op = I2C_MASTER_WRRD;
-				left_num--;
-			}
-		}
+	ret = wait_for_completion_timeout(&i2c->msg_complete,
+					  i2c->adap.timeout);
 
-		/* always use DMA mode. */
-		ret = mtk_i2c_do_transfer(i2c, msgs, num, left_num);
-		if (ret < 0)
-			goto err_exit;
+	if (ret == 0) {
+		dev_dbg(i2c->dev, "addr: %x, transfer timeout\n", msgs->addr);
+		mtk_i2c_init_hw(i2c);
+		ret = -ETIMEDOUT;
+		goto err_exit;
+	}
 
-		msgs++;
+	if (i2c->irq_stat & (I2C_HS_NACKERR | I2C_ACKERR)) {
+		dev_dbg(i2c->dev, "addr: %x, transfer ACK error\n", msgs->addr);
+		mtk_i2c_init_hw(i2c);
+		ret = -ENXIO;
+		goto err_exit;
+	}
+
+	if (i2c_transac->result) {
+		ret = i2c_transac->result;
+		goto err_exit;
 	}
+
 	/* the return value is number of executed messages */
 	ret = num;
 
@@ -621,29 +624,51 @@ static irqreturn_t mtk_i2c_irq(int irqno, void *dev_id)
 {
 	struct mtk_i2c *i2c = dev_id;
 	u16 restart_flag = 0;
-	u16 intr_stat;
+	struct i2c_msg *msg;
+	struct mtk_i2c_transaction *i2c_transac = &i2c->transac;
 
 	if (i2c->auto_restart)
 		restart_flag = I2C_RS_TRANSFER;
 
-	intr_stat = readw(i2c->base + OFFSET_INTR_STAT);
-	writew(intr_stat, i2c->base + OFFSET_INTR_STAT);
+	/* Clear interrupt mask */
+	writew(~(restart_flag | I2C_HS_NACKERR | I2C_ACKERR |
+	       I2C_TRANSAC_COMP), i2c->base + OFFSET_INTR_MASK);
 
-	/*
-	 * when occurs ack error, i2c controller generate two interrupts
-	 * first is the ack error interrupt, then the complete interrupt
-	 * i2c->irq_stat need keep the two interrupt value.
-	 */
-	i2c->irq_stat |= intr_stat;
+	i2c->irq_stat = readw(i2c->base + OFFSET_INTR_STAT);
+	writew(i2c->irq_stat, i2c->base + OFFSET_INTR_STAT);
 
 	if (i2c->ignore_restart_irq && (i2c->irq_stat & restart_flag)) {
 		i2c->ignore_restart_irq = false;
 		i2c->irq_stat = 0;
+		/* Enable interrupt */
+		writew(restart_flag | I2C_HS_NACKERR | I2C_ACKERR |
+		       I2C_TRANSAC_COMP, i2c->base + OFFSET_INTR_MASK);
 		writew(I2C_RS_MUL_CNFG | I2C_RS_MUL_TRIG | I2C_TRANSAC_START,
 		       i2c->base + OFFSET_START);
 	} else {
-		if (i2c->irq_stat & (I2C_TRANSAC_COMP | restart_flag))
+		msg = &i2c_transac->msgs[i2c_transac->index];
+
+		if (i2c->op == I2C_MASTER_WR || i2c->op == I2C_MASTER_WRRD) {
+			dma_unmap_single(i2c->dev, i2c_transac->wpaddr,
+					 msg->len, DMA_TO_DEVICE);
+		}
+
+		if (i2c->op == I2C_MASTER_WRRD)
+			dma_unmap_single(i2c->dev, i2c_transac->rpaddr,
+					 (msg + 1)->len, DMA_FROM_DEVICE);
+
+		if (i2c->op == I2C_MASTER_RD)
+			dma_unmap_single(i2c->dev, i2c_transac->rpaddr,
+					 msg->len, DMA_FROM_DEVICE);
+
+		if (i2c->irq_stat & ~restart_flag) {
 			complete(&i2c->msg_complete);
+		} else {
+			i2c_transac->index++;
+			i2c_transac->result = mtk_i2c_start_transfer(i2c);
+			if (i2c_transac->result)
+				complete(&i2c->msg_complete);
+		}
 	}
 
 	return IRQ_HANDLED;
-- 
1.8.1.1.dirty
