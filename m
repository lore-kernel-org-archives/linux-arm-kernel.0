From: w.sang@pengutronix.de (Wolfram Sang)
Date: Thu,  1 Nov 2012 12:56:43 +0100
Subject: [PATCH] i2c: mxs: remove broken PIOQUEUE support
Message-ID: <1351771003-6071-1-git-send-email-w.sang@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This I2C master can do DMA and PIOQUEUE (PIO with FIFO). Originally,
only PIOQEUE was supported, then DMA support was added. The original
intention was to keep PIOQUEUE since it has less overhead what is nice
for small transfers. However, runtime switching between PIOQEUE and DMA
depending on the transfer size never worked despite a lot of trying.
Since PIOQUEUE mode itself was flaky (polling at places where interrupts
failed to work) and the implementation also imposed a size limit for
transfers, it is best to remove the support altogether which makes the
driver a lot cleaner and more robust. If somebody really wants less
overhead, plain PIO mode could still be implemented with the addidtional
advantage that this mode is also available on MX23, too.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
Cc: Marek Vasut <marex@denx.de>
Cc: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/i2c/busses/i2c-mxs.c |  186 ++++--------------------------------------
 1 file changed, 14 insertions(+), 172 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mxs.c b/drivers/i2c/busses/i2c-mxs.c
index 1f58197..286ca19 100644
--- a/drivers/i2c/busses/i2c-mxs.c
+++ b/drivers/i2c/busses/i2c-mxs.c
@@ -1,7 +1,7 @@
 /*
  * Freescale MXS I2C bus driver
  *
- * Copyright (C) 2011 Wolfram Sang, Pengutronix e.K.
+ * Copyright (C) 2011-2012 Wolfram Sang, Pengutronix e.K.
  *
  * based on a (non-working) driver which was:
  *
@@ -35,10 +35,6 @@
 
 #define DRIVER_NAME "mxs-i2c"
 
-static bool use_pioqueue;
-module_param(use_pioqueue, bool, 0);
-MODULE_PARM_DESC(use_pioqueue, "Use PIOQUEUE mode for transfer instead of DMA");
-
 #define MXS_I2C_CTRL0		(0x00)
 #define MXS_I2C_CTRL0_SET	(0x04)
 
@@ -75,23 +71,6 @@ MODULE_PARM_DESC(use_pioqueue, "Use PIOQUEUE mode for transfer instead of DMA");
 				 MXS_I2C_CTRL1_SLAVE_STOP_IRQ | \
 				 MXS_I2C_CTRL1_SLAVE_IRQ)
 
-#define MXS_I2C_QUEUECTRL	(0x60)
-#define MXS_I2C_QUEUECTRL_SET	(0x64)
-#define MXS_I2C_QUEUECTRL_CLR	(0x68)
-
-#define MXS_I2C_QUEUECTRL_QUEUE_RUN		0x20
-#define MXS_I2C_QUEUECTRL_PIO_QUEUE_MODE	0x04
-
-#define MXS_I2C_QUEUESTAT	(0x70)
-#define MXS_I2C_QUEUESTAT_RD_QUEUE_EMPTY        0x00002000
-#define MXS_I2C_QUEUESTAT_WRITE_QUEUE_CNT_MASK	0x0000001F
-
-#define MXS_I2C_QUEUECMD	(0x80)
-
-#define MXS_I2C_QUEUEDATA	(0x90)
-
-#define MXS_I2C_DATA		(0xa0)
-
 
 #define MXS_CMD_I2C_SELECT	(MXS_I2C_CTRL0_RETAIN_CLOCK |	\
 				 MXS_I2C_CTRL0_PRE_SEND_START |	\
@@ -153,7 +132,6 @@ struct mxs_i2c_dev {
 	const struct mxs_i2c_speed_config *speed;
 
 	/* DMA support components */
-	bool				dma_mode;
 	int				dma_channel;
 	struct dma_chan         	*dmach;
 	struct mxs_dma_data		dma_data;
@@ -172,99 +150,6 @@ static void mxs_i2c_reset(struct mxs_i2c_dev *i2c)
 	writel(i2c->speed->timing2, i2c->regs + MXS_I2C_TIMING2);
 
 	writel(MXS_I2C_IRQ_MASK << 8, i2c->regs + MXS_I2C_CTRL1_SET);
-	if (i2c->dma_mode)
-		writel(MXS_I2C_QUEUECTRL_PIO_QUEUE_MODE,
-			i2c->regs + MXS_I2C_QUEUECTRL_CLR);
-	else
-		writel(MXS_I2C_QUEUECTRL_PIO_QUEUE_MODE,
-			i2c->regs + MXS_I2C_QUEUECTRL_SET);
-}
-
-static void mxs_i2c_pioq_setup_read(struct mxs_i2c_dev *i2c, u8 addr, int len,
-					int flags)
-{
-	u32 data;
-
-	writel(MXS_CMD_I2C_SELECT, i2c->regs + MXS_I2C_QUEUECMD);
-
-	data = (addr << 1) | I2C_SMBUS_READ;
-	writel(data, i2c->regs + MXS_I2C_DATA);
-
-	data = MXS_CMD_I2C_READ | MXS_I2C_CTRL0_XFER_COUNT(len) | flags;
-	writel(data, i2c->regs + MXS_I2C_QUEUECMD);
-}
-
-static void mxs_i2c_pioq_setup_write(struct mxs_i2c_dev *i2c,
-				    u8 addr, u8 *buf, int len, int flags)
-{
-	u32 data;
-	int i, shifts_left;
-
-	data = MXS_CMD_I2C_WRITE | MXS_I2C_CTRL0_XFER_COUNT(len + 1) | flags;
-	writel(data, i2c->regs + MXS_I2C_QUEUECMD);
-
-	/*
-	 * We have to copy the slave address (u8) and buffer (arbitrary number
-	 * of u8) into the data register (u32). To achieve that, the u8 are put
-	 * into the MSBs of 'data' which is then shifted for the next u8. When
-	 * appropriate, 'data' is written to MXS_I2C_DATA. So, the first u32
-	 * looks like this:
-	 *
-	 *  3          2          1          0
-	 * 10987654|32109876|54321098|76543210
-	 * --------+--------+--------+--------
-	 * buffer+2|buffer+1|buffer+0|slave_addr
-	 */
-
-	data = ((addr << 1) | I2C_SMBUS_WRITE) << 24;
-
-	for (i = 0; i < len; i++) {
-		data >>= 8;
-		data |= buf[i] << 24;
-		if ((i & 3) == 2)
-			writel(data, i2c->regs + MXS_I2C_DATA);
-	}
-
-	/* Write out the remaining bytes if any */
-	shifts_left = 24 - (i & 3) * 8;
-	if (shifts_left)
-		writel(data >> shifts_left, i2c->regs + MXS_I2C_DATA);
-}
-
-/*
- * TODO: should be replaceable with a waitqueue and RD_QUEUE_IRQ (setting the
- * rd_threshold to 1). Couldn't get this to work, though.
- */
-static int mxs_i2c_wait_for_data(struct mxs_i2c_dev *i2c)
-{
-	unsigned long timeout = jiffies + msecs_to_jiffies(1000);
-
-	while (readl(i2c->regs + MXS_I2C_QUEUESTAT)
-			& MXS_I2C_QUEUESTAT_RD_QUEUE_EMPTY) {
-			if (time_after(jiffies, timeout))
-				return -ETIMEDOUT;
-			cond_resched();
-	}
-
-	return 0;
-}
-
-static int mxs_i2c_finish_read(struct mxs_i2c_dev *i2c, u8 *buf, int len)
-{
-	u32 uninitialized_var(data);
-	int i;
-
-	for (i = 0; i < len; i++) {
-		if ((i & 3) == 0) {
-			if (mxs_i2c_wait_for_data(i2c))
-				return -ETIMEDOUT;
-			data = readl(i2c->regs + MXS_I2C_QUEUEDATA);
-		}
-		buf[i] = data & 0xff;
-		data >>= 8;
-	}
-
-	return 0;
 }
 
 static void mxs_i2c_dma_finish(struct mxs_i2c_dev *i2c)
@@ -432,39 +317,17 @@ static int mxs_i2c_xfer_msg(struct i2c_adapter *adap, struct i2c_msg *msg,
 	init_completion(&i2c->cmd_complete);
 	i2c->cmd_err = 0;
 
-	if (i2c->dma_mode) {
-		ret = mxs_i2c_dma_setup_xfer(adap, msg, flags);
-		if (ret)
-			return ret;
-	} else {
-		if (msg->flags & I2C_M_RD) {
-			mxs_i2c_pioq_setup_read(i2c, msg->addr,
-						msg->len, flags);
-		} else {
-			mxs_i2c_pioq_setup_write(i2c, msg->addr, msg->buf,
-						msg->len, flags);
-		}
-
-		writel(MXS_I2C_QUEUECTRL_QUEUE_RUN,
-			i2c->regs + MXS_I2C_QUEUECTRL_SET);
-	}
+	ret = mxs_i2c_dma_setup_xfer(adap, msg, flags);
+	if (ret)
+		return ret;
 
 	ret = wait_for_completion_timeout(&i2c->cmd_complete,
 						msecs_to_jiffies(1000));
 	if (ret == 0)
 		goto timeout;
 
-	if (!i2c->dma_mode && !i2c->cmd_err && (msg->flags & I2C_M_RD)) {
-		ret = mxs_i2c_finish_read(i2c, msg->buf, msg->len);
-		if (ret)
-			goto timeout;
-	}
-
 	if (i2c->cmd_err == -ENXIO)
 		mxs_i2c_reset(i2c);
-	else
-		writel(MXS_I2C_QUEUECTRL_QUEUE_RUN,
-				i2c->regs + MXS_I2C_QUEUECTRL_CLR);
 
 	dev_dbg(i2c->dev, "Done with err=%d\n", i2c->cmd_err);
 
@@ -472,8 +335,7 @@ static int mxs_i2c_xfer_msg(struct i2c_adapter *adap, struct i2c_msg *msg,
 
 timeout:
 	dev_dbg(i2c->dev, "Timeout!\n");
-	if (i2c->dma_mode)
-		mxs_i2c_dma_finish(i2c);
+	mxs_i2c_dma_finish(i2c);
 	mxs_i2c_reset(i2c);
 	return -ETIMEDOUT;
 }
@@ -502,7 +364,6 @@ static irqreturn_t mxs_i2c_isr(int this_irq, void *dev_id)
 {
 	struct mxs_i2c_dev *i2c = dev_id;
 	u32 stat = readl(i2c->regs + MXS_I2C_CTRL1) & MXS_I2C_IRQ_MASK;
-	bool is_last_cmd;
 
 	if (!stat)
 		return IRQ_NONE;
@@ -515,14 +376,6 @@ static irqreturn_t mxs_i2c_isr(int this_irq, void *dev_id)
 		/* MXS_I2C_CTRL1_OVERSIZE_XFER_TERM_IRQ is only for slaves */
 		i2c->cmd_err = -EIO;
 
-	if (!i2c->dma_mode) {
-		is_last_cmd = (readl(i2c->regs + MXS_I2C_QUEUESTAT) &
-			MXS_I2C_QUEUESTAT_WRITE_QUEUE_CNT_MASK) == 0;
-
-		if (is_last_cmd || i2c->cmd_err)
-			complete(&i2c->cmd_complete);
-	}
-
 	writel(stat, i2c->regs + MXS_I2C_CTRL1_CLR);
 
 	return IRQ_HANDLED;
@@ -556,23 +409,14 @@ static int mxs_i2c_get_ofdata(struct mxs_i2c_dev *i2c)
 	int ret;
 
 	/*
-	 * The MXS I2C DMA mode is prefered and enabled by default.
-	 * The PIO mode is still supported, but should be used only
-	 * for debuging purposes etc.
-	 */
-	i2c->dma_mode = !use_pioqueue;
-	if (!i2c->dma_mode)
-		dev_info(dev, "Using PIOQUEUE mode for I2C transfers!\n");
-
-	/*
 	 * TODO: This is a temporary solution and should be changed
 	 * to use generic DMA binding later when the helpers get in.
 	 */
 	ret = of_property_read_u32(node, "fsl,i2c-dma-channel",
 				   &i2c->dma_channel);
 	if (ret) {
-		dev_warn(dev, "Failed to get DMA channel, using PIOQUEUE!\n");
-		i2c->dma_mode = 0;
+		dev_err(dev, "Failed to get DMA channel!\n");
+		return -ENODEV;
 	}
 
 	ret = of_property_read_u32(node, "clock-frequency", &speed);
@@ -634,15 +478,13 @@ static int __devinit mxs_i2c_probe(struct platform_device *pdev)
 	}
 
 	/* Setup the DMA */
-	if (i2c->dma_mode) {
-		dma_cap_zero(mask);
-		dma_cap_set(DMA_SLAVE, mask);
-		i2c->dma_data.chan_irq = dmairq;
-		i2c->dmach = dma_request_channel(mask, mxs_i2c_dma_filter, i2c);
-		if (!i2c->dmach) {
-			dev_err(dev, "Failed to request dma\n");
-			return -ENODEV;
-		}
+	dma_cap_zero(mask);
+	dma_cap_set(DMA_SLAVE, mask);
+	i2c->dma_data.chan_irq = dmairq;
+	i2c->dmach = dma_request_channel(mask, mxs_i2c_dma_filter, i2c);
+	if (!i2c->dmach) {
+		dev_err(dev, "Failed to request dma\n");
+		return -ENODEV;
 	}
 
 	platform_set_drvdata(pdev, i2c);
-- 
1.7.10.4
