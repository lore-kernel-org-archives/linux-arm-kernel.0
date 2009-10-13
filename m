From: shinya.kuribayashi@necel.com (Shinya Kuribayashi)
Date: Tue, 13 Oct 2009 11:48:28 +0900
Subject: [PATCH 01/16] i2c-designware: Consolidate to use 32-bit word accesses
In-Reply-To: <4AD3E974.8080200@necel.com>
References: <4AD3E974.8080200@necel.com>
Message-ID: <4AD3EA7C.6020206@necel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This driver looks originally meant for armel machines where readw()/
writew() works perfectly fine.  But that doens't work for big-endian
systems.

This patch converts all 8/16-bit-aware usages to 32-bit variants, so
that the driver works for MIPS big-endian machines, too.

Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi@necel.com>
---
 drivers/i2c/busses/i2c-designware.c |   76 +++++++++++++++++-----------------
 1 files changed, 38 insertions(+), 38 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware.c b/drivers/i2c/busses/i2c-designware.c
index b444762..a4f928e 100644
--- a/drivers/i2c/busses/i2c-designware.c
+++ b/drivers/i2c/busses/i2c-designware.c
@@ -162,14 +162,14 @@ struct dw_i2c_dev {
 	struct i2c_msg		*msgs;
 	int			msgs_num;
 	int			msg_write_idx;
-	u16			tx_buf_len;
+	u32			tx_buf_len;
 	u8			*tx_buf;
 	int			msg_read_idx;
-	u16			rx_buf_len;
+	u32			rx_buf_len;
 	u8			*rx_buf;
 	int			msg_err;
 	unsigned int		status;
-	u16			abort_source;
+	u32			abort_source;
 	int			irq;
 	struct i2c_adapter	adapter;
 	unsigned int		tx_fifo_depth;
@@ -187,25 +187,25 @@ struct dw_i2c_dev {
 static void i2c_dw_init(struct dw_i2c_dev *dev)
 {
 	u32 input_clock_khz = clk_get_rate(dev->clk) / 1000;
-	u16 ic_con;
+	u32 ic_con;
 
 	/* Disable the adapter */
-	writeb(0, dev->base + DW_IC_ENABLE);
+	writel(0, dev->base + DW_IC_ENABLE);
 
 	/* set standard and fast speed deviders for high/low periods */
-	writew((input_clock_khz * 40 / 10000)+1, /* std speed high, 4us */
+	writel((input_clock_khz * 40 / 10000)+1, /* std speed high, 4us */
 			dev->base + DW_IC_SS_SCL_HCNT);
-	writew((input_clock_khz * 47 / 10000)+1, /* std speed low, 4.7us */
+	writel((input_clock_khz * 47 / 10000)+1, /* std speed low, 4.7us */
 			dev->base + DW_IC_SS_SCL_LCNT);
-	writew((input_clock_khz *  6 / 10000)+1, /* fast speed high, 0.6us */
+	writel((input_clock_khz *  6 / 10000)+1, /* fast speed high, 0.6us */
 			dev->base + DW_IC_FS_SCL_HCNT);
-	writew((input_clock_khz * 13 / 10000)+1, /* fast speed low, 1.3us */
+	writel((input_clock_khz * 13 / 10000)+1, /* fast speed low, 1.3us */
 			dev->base + DW_IC_FS_SCL_LCNT);
 
 	/* configure the i2c master */
 	ic_con = DW_IC_CON_MASTER | DW_IC_CON_SLAVE_DISABLE |
 		DW_IC_CON_RESTART_EN | DW_IC_CON_SPEED_FAST;
-	writew(ic_con, dev->base + DW_IC_CON);
+	writel(ic_con, dev->base + DW_IC_CON);
 }
 
 /*
@@ -215,7 +215,7 @@ static int i2c_dw_wait_bus_not_busy(struct dw_i2c_dev *dev)
 {
 	int timeout = TIMEOUT;
 
-	while (readb(dev->base + DW_IC_STATUS) & DW_IC_STATUS_ACTIVITY) {
+	while (readl(dev->base + DW_IC_STATUS) & DW_IC_STATUS_ACTIVITY) {
 		if (timeout <= 0) {
 			dev_warn(dev->dev, "timeout waiting for bus ready\n");
 			return -ETIMEDOUT;
@@ -239,29 +239,29 @@ i2c_dw_xfer_msg(struct i2c_adapter *adap)
 	struct dw_i2c_dev *dev = i2c_get_adapdata(adap);
 	struct i2c_msg *msgs = dev->msgs;
 	int num = dev->msgs_num;
-	u16 ic_con, intr_mask;
-	int tx_limit = dev->tx_fifo_depth - readb(dev->base + DW_IC_TXFLR);
-	int rx_limit = dev->rx_fifo_depth - readb(dev->base + DW_IC_RXFLR);
-	u16 addr = msgs[dev->msg_write_idx].addr;
-	u16 buf_len = dev->tx_buf_len;
+	u32 ic_con, intr_mask;
+	int tx_limit = dev->tx_fifo_depth - readl(dev->base + DW_IC_TXFLR);
+	int rx_limit = dev->rx_fifo_depth - readl(dev->base + DW_IC_RXFLR);
+	u32 addr = msgs[dev->msg_write_idx].addr;
+	u32 buf_len = dev->tx_buf_len;
 
 	if (!(dev->status & STATUS_WRITE_IN_PROGRESS)) {
 		/* Disable the adapter */
-		writeb(0, dev->base + DW_IC_ENABLE);
+		writel(0, dev->base + DW_IC_ENABLE);
 
 		/* set the slave (target) address */
-		writew(msgs[dev->msg_write_idx].addr, dev->base + DW_IC_TAR);
+		writel(msgs[dev->msg_write_idx].addr, dev->base + DW_IC_TAR);
 
 		/* if the slave address is ten bit address, enable 10BITADDR */
-		ic_con = readw(dev->base + DW_IC_CON);
+		ic_con = readl(dev->base + DW_IC_CON);
 		if (msgs[dev->msg_write_idx].flags & I2C_M_TEN)
 			ic_con |= DW_IC_CON_10BITADDR_MASTER;
 		else
 			ic_con &= ~DW_IC_CON_10BITADDR_MASTER;
-		writew(ic_con, dev->base + DW_IC_CON);
+		writel(ic_con, dev->base + DW_IC_CON);
 
 		/* Enable the adapter */
-		writeb(1, dev->base + DW_IC_ENABLE);
+		writel(1, dev->base + DW_IC_ENABLE);
 	}
 
 	for (; dev->msg_write_idx < num; dev->msg_write_idx++) {
@@ -287,10 +287,10 @@ i2c_dw_xfer_msg(struct i2c_adapter *adap)
 
 		while (buf_len > 0 && tx_limit > 0 && rx_limit > 0) {
 			if (msgs[dev->msg_write_idx].flags & I2C_M_RD) {
-				writew(0x100, dev->base + DW_IC_DATA_CMD);
+				writel(0x100, dev->base + DW_IC_DATA_CMD);
 				rx_limit--;
 			} else
-				writew(*(dev->tx_buf++),
+				writel(*(dev->tx_buf++),
 						dev->base + DW_IC_DATA_CMD);
 			tx_limit--; buf_len--;
 		}
@@ -302,7 +302,7 @@ i2c_dw_xfer_msg(struct i2c_adapter *adap)
 		dev->status |= STATUS_WRITE_IN_PROGRESS;
 	} else
 		dev->status &= ~STATUS_WRITE_IN_PROGRESS;
-	writew(intr_mask, dev->base + DW_IC_INTR_MASK);
+	writel(intr_mask, dev->base + DW_IC_INTR_MASK);
 
 	dev->tx_buf_len = buf_len;
 }
@@ -313,11 +313,11 @@ i2c_dw_read(struct i2c_adapter *adap)
 	struct dw_i2c_dev *dev = i2c_get_adapdata(adap);
 	struct i2c_msg *msgs = dev->msgs;
 	int num = dev->msgs_num;
-	u16 addr = msgs[dev->msg_read_idx].addr;
-	int rx_valid = readw(dev->base + DW_IC_RXFLR);
+	u32 addr = msgs[dev->msg_read_idx].addr;
+	int rx_valid = readl(dev->base + DW_IC_RXFLR);
 
 	for (; dev->msg_read_idx < num; dev->msg_read_idx++) {
-		u16 len;
+		u32 len;
 		u8 *buf;
 
 		if (!(msgs[dev->msg_read_idx].flags & I2C_M_RD))
@@ -336,7 +336,7 @@ i2c_dw_read(struct i2c_adapter *adap)
 		}
 
 		for (; len > 0 && rx_valid > 0; len--, rx_valid--)
-			*buf++ = readb(dev->base + DW_IC_DATA_CMD);
+			*buf++ = readl(dev->base + DW_IC_DATA_CMD);
 
 		if (len > 0) {
 			dev->status |= STATUS_READ_IN_PROGRESS;
@@ -398,7 +398,7 @@ i2c_dw_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
 		do {
 			i2c_dw_read(adap);
 		} while (dev->status & STATUS_READ_IN_PROGRESS);
-		writeb(0, dev->base + DW_IC_ENABLE);
+		writel(0, dev->base + DW_IC_ENABLE);
 		ret = num;
 		goto done;
 	}
@@ -428,7 +428,7 @@ static u32 i2c_dw_func(struct i2c_adapter *adap)
 static void dw_i2c_pump_msg(unsigned long data)
 {
 	struct dw_i2c_dev *dev = (struct dw_i2c_dev *) data;
-	u16 intr_mask;
+	u32 intr_mask;
 
 	i2c_dw_read(&dev->adapter);
 	i2c_dw_xfer_msg(&dev->adapter);
@@ -436,7 +436,7 @@ static void dw_i2c_pump_msg(unsigned long data)
 	intr_mask = DW_IC_INTR_STOP_DET | DW_IC_INTR_TX_ABRT;
 	if (dev->status & STATUS_WRITE_IN_PROGRESS)
 		intr_mask |= DW_IC_INTR_TX_EMPTY;
-	writew(intr_mask, dev->base + DW_IC_INTR_MASK);
+	writel(intr_mask, dev->base + DW_IC_INTR_MASK);
 }
 
 /*
@@ -446,19 +446,19 @@ static void dw_i2c_pump_msg(unsigned long data)
 static irqreturn_t i2c_dw_isr(int this_irq, void *dev_id)
 {
 	struct dw_i2c_dev *dev = dev_id;
-	u16 stat;
+	u32 stat;
 
-	stat = readw(dev->base + DW_IC_INTR_STAT);
+	stat = readl(dev->base + DW_IC_INTR_STAT);
 	dev_dbg(dev->dev, "%s: stat=0x%x\n", __func__, stat);
 	if (stat & DW_IC_INTR_TX_ABRT) {
-		dev->abort_source = readw(dev->base + DW_IC_TX_ABRT_SOURCE);
+		dev->abort_source = readl(dev->base + DW_IC_TX_ABRT_SOURCE);
 		dev->cmd_err |= DW_IC_ERR_TX_ABRT;
 		dev->status = STATUS_IDLE;
 	} else if (stat & DW_IC_INTR_TX_EMPTY)
 		tasklet_schedule(&dev->pump_msg);
 
-	readb(dev->base + DW_IC_CLR_INTR);	/* clear interrupts */
-	writew(0, dev->base + DW_IC_INTR_MASK);	/* disable interrupts */
+	readl(dev->base + DW_IC_CLR_INTR);	/* clear interrupts */
+	writel(0, dev->base + DW_IC_INTR_MASK);	/* disable interrupts */
 	if (stat & (DW_IC_INTR_TX_ABRT | DW_IC_INTR_STOP_DET))
 		complete(&dev->cmd_complete);
 
@@ -531,7 +531,7 @@ static int __devinit dw_i2c_probe(struct platform_device *pdev)
 	}
 	i2c_dw_init(dev);
 
-	writew(0, dev->base + DW_IC_INTR_MASK); /* disable IRQ */
+	writel(0, dev->base + DW_IC_INTR_MASK); /* disable IRQ */
 	r = request_irq(dev->irq, i2c_dw_isr, 0, pdev->name, dev);
 	if (r) {
 		dev_err(&pdev->dev, "failure requesting irq %i\n", dev->irq);
@@ -587,7 +587,7 @@ static int __devexit dw_i2c_remove(struct platform_device *pdev)
 	clk_put(dev->clk);
 	dev->clk = NULL;
 
-	writeb(0, dev->base + DW_IC_ENABLE);
+	writel(0, dev->base + DW_IC_ENABLE);
 	free_irq(dev->irq, dev);
 	kfree(dev);
 
-- 
1.6.5
