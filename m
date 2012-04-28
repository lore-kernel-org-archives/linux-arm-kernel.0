From: marex@denx.de (Marek Vasut)
Date: Sat, 28 Apr 2012 05:03:52 +0200
Subject: [TEST PATCH] mxs-i2c DMA support
In-Reply-To: <20120427163756.GH16504@pengutronix.de>
References: <20120427163756.GH16504@pengutronix.de>
Message-ID: <1335582232-3516-1-git-send-email-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch is by no means complete. This patch does have issues, see below.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: linux-i2c at vger.kernel.org
Cc: Wolfram Sang <w.sang@pengutronix.de>
---
 drivers/i2c/busses/i2c-mxs.c |  257 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 238 insertions(+), 19 deletions(-)

NOTE: It's still crappy and in-the-works, but I wanted to push it out ASAP so
others can play around (so don't bash me for coding style etc.). I still need
to fix various things here and there until I make this official:

1) The printk("%s[%i]\n", __func__, __LINE__); in mxs_i2c_xfer_msg(), without
   this it craps out for some reason, I'll have to check it after I get some
   sleep.
2) The coexistence of DMA and PIO transfers.

NOTE2: Wolfram, I merged our patch into this as I hoped it might fix my DMA/PIO
       coexistance issue, but obviously I'd like to see your patch go in
       separately.

diff --git a/drivers/i2c/busses/i2c-mxs.c b/drivers/i2c/busses/i2c-mxs.c
index 3d471d5..eea2d8a 100644
--- a/drivers/i2c/busses/i2c-mxs.c
+++ b/drivers/i2c/busses/i2c-mxs.c
@@ -26,6 +26,9 @@
 #include <linux/platform_device.h>
 #include <linux/jiffies.h>
 #include <linux/io.h>
+#include <linux/dma-mapping.h>
+#include <linux/dmaengine.h>
+#include <linux/fsl/mxs-dma.h>
 
 #include <mach/common.h>
 
@@ -109,6 +112,19 @@ struct mxs_i2c_dev {
 	struct completion cmd_complete;
 	u32 cmd_err;
 	struct i2c_adapter adapter;
+
+	bool				dma;
+	struct resource			*dmares;
+	struct dma_chan         	*dmach;
+	struct mxs_dma_data		dma_data;
+
+	struct mutex			mutex;
+
+	uint32_t			pio_data[2];
+	uint32_t			addr_data;
+	struct scatterlist		sg_io[2];
+
+	bool				read;
 };
 
 /*
@@ -194,7 +210,7 @@ static int mxs_i2c_wait_for_data(struct mxs_i2c_dev *i2c)
 
 static int mxs_i2c_finish_read(struct mxs_i2c_dev *i2c, u8 *buf, int len)
 {
-	u32 data;
+	u32 data = 0;
 	int i;
 
 	for (i = 0; i < len; i++) {
@@ -210,6 +226,148 @@ static int mxs_i2c_finish_read(struct mxs_i2c_dev *i2c, u8 *buf, int len)
 	return 0;
 }
 
+static void mxs_i2c_dma_irq_callback(void *param)
+{
+	struct mxs_i2c_dev *i2c = param;
+	struct i2c_adapter *adap = &i2c->adapter;
+
+	if (i2c->read) {
+		dma_unmap_sg(&adap->dev, &i2c->sg_io[0], 1, DMA_TO_DEVICE);
+		dma_unmap_sg(&adap->dev, &i2c->sg_io[1], 1, DMA_FROM_DEVICE);
+	} else {
+		dma_unmap_sg(&adap->dev, i2c->sg_io, 2, DMA_TO_DEVICE);
+	}
+
+	complete(&i2c->cmd_complete);
+}
+
+static int mxs_i2c_dma_setup_xfer(struct i2c_adapter *adap,
+			struct i2c_msg *msg, uint32_t flags)
+{
+	struct dma_async_tx_descriptor *desc;
+	struct mxs_i2c_dev *i2c = i2c_get_adapdata(adap);
+
+	if (msg->flags & I2C_M_RD) {
+		i2c->read = 1;
+		i2c->addr_data = (msg->addr << 1) | I2C_SMBUS_READ;
+
+		/*
+		 * SELECT command.
+		 */
+
+		/* Queue the PIO register write transfer. */
+		i2c->pio_data[0] = MXS_CMD_I2C_SELECT;
+		desc = dmaengine_prep_slave_sg(i2c->dmach,
+					(struct scatterlist *)&i2c->pio_data[0],
+					1, DMA_TRANS_NONE, 0);
+		if (!desc) {
+			dev_err(&adap->dev,
+				"Failed to get PIO reg. write descriptor.\n");
+			goto select_init_pio_fail;
+		}
+
+		/* Queue the DMA data transfer. */
+		sg_init_one(&i2c->sg_io[0], &i2c->addr_data, 1);
+		dma_map_sg(&adap->dev, &i2c->sg_io[0], 1, DMA_TO_DEVICE);
+		desc = dmaengine_prep_slave_sg(i2c->dmach, &i2c->sg_io[0], 1,
+					DMA_MEM_TO_DEV,
+					DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+		if (!desc) {
+			dev_err(&adap->dev,
+				"Failed to get DMA data write descriptor.\n");
+			goto select_init_dma_fail;
+		}
+
+		/*
+		 * READ command.
+		 */
+
+		/* Queue the PIO register write transfer. */
+		i2c->pio_data[1] = flags | MXS_I2C_CTRL0_MASTER_MODE |
+				MXS_I2C_CTRL0_XFER_COUNT(msg->len);
+		desc = dmaengine_prep_slave_sg(i2c->dmach,
+					(struct scatterlist *)&i2c->pio_data[1],
+					1, DMA_TRANS_NONE, DMA_PREP_INTERRUPT);
+		if (!desc) {
+			dev_err(&adap->dev,
+				"Failed to get PIO reg. write descriptor.\n");
+			goto select_init_dma_fail;
+		}
+
+		/* Queue the DMA data transfer. */
+		sg_init_one(&i2c->sg_io[1], msg->buf, msg->len);
+		dma_map_sg(&adap->dev, &i2c->sg_io[1], 1, DMA_FROM_DEVICE);
+		desc = dmaengine_prep_slave_sg(i2c->dmach, &i2c->sg_io[1], 1,
+					DMA_DEV_TO_MEM,
+					DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+		if (!desc) {
+			dev_err(&adap->dev,
+				"Failed to get DMA data write descriptor.\n");
+			goto read_init_dma_fail;
+		}
+	} else {
+		i2c->read = 0;
+		i2c->addr_data = (msg->addr << 1) | I2C_SMBUS_WRITE;
+
+		/*
+		 * WRITE command.
+		 */
+
+		/* Queue the PIO register write transfer. */
+		i2c->pio_data[0] = flags | MXS_CMD_I2C_WRITE |
+				MXS_I2C_CTRL0_XFER_COUNT(msg->len + 1);
+		desc = dmaengine_prep_slave_sg(i2c->dmach,
+					(struct scatterlist *)&i2c->pio_data[0],
+					1, DMA_TRANS_NONE, 0);
+		if (!desc) {
+			dev_err(&adap->dev,
+				"Failed to get PIO reg. write descriptor.\n");
+			goto write_init_pio_fail;
+		}
+
+		/* Queue the DMA data transfer. */
+		sg_init_table(i2c->sg_io, 2);
+		sg_set_buf(&i2c->sg_io[0], &i2c->addr_data, 1);
+		sg_set_buf(&i2c->sg_io[1], msg->buf, msg->len);
+		dma_map_sg(&adap->dev, i2c->sg_io, 2, DMA_TO_DEVICE);
+		desc = dmaengine_prep_slave_sg(i2c->dmach, i2c->sg_io, 2,
+					DMA_MEM_TO_DEV,
+					DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+		if (!desc) {
+			dev_err(&adap->dev,
+				"Failed to get DMA data write descriptor.\n");
+			goto write_init_dma_fail;
+		}
+	}
+
+	/*
+	 * The last descriptor must have this callback,
+	 * to finish the DMA transaction.
+	 */
+	desc->callback = mxs_i2c_dma_irq_callback;
+	desc->callback_param = i2c;
+
+	/* Start the transfer. */
+	dmaengine_submit(desc);
+
+	return 0;
+
+/* Read failpath. */
+read_init_dma_fail:
+	dma_unmap_sg(&adap->dev, &i2c->sg_io[1], 1, DMA_FROM_DEVICE);
+select_init_dma_fail:
+	dma_unmap_sg(&adap->dev, &i2c->sg_io[0], 1, DMA_TO_DEVICE);
+select_init_pio_fail:
+	return 1;
+
+
+/* Write failpath. */
+write_init_dma_fail:
+	dma_unmap_sg(&adap->dev, i2c->sg_io, 2, DMA_TO_DEVICE);
+write_init_pio_fail:
+	return 1;
+}
+
 /*
  * Low level master read/write transaction.
  */
@@ -220,31 +378,50 @@ static int mxs_i2c_xfer_msg(struct i2c_adapter *adap, struct i2c_msg *msg,
 	int ret;
 	int flags;
 
+	flags = stop ? MXS_I2C_CTRL0_POST_SEND_STOP : 0;
+
 	dev_dbg(i2c->dev, "addr: 0x%04x, len: %d, flags: 0x%x, stop: %d\n",
 		msg->addr, msg->len, msg->flags, stop);
 
 	if (msg->len == 0)
 		return -EINVAL;
 
+	i2c->dma = 1;//(msg->len > 16);
+
 	init_completion(&i2c->cmd_complete);
 
-	flags = stop ? MXS_I2C_CTRL0_POST_SEND_STOP : 0;
+	if (i2c->dma) {
+		writel(MXS_I2C_QUEUECTRL_PIO_QUEUE_MODE,
+			i2c->regs + MXS_I2C_QUEUECTRL_CLR);
 
-	if (msg->flags & I2C_M_RD)
-		mxs_i2c_pioq_setup_read(i2c, msg->addr, msg->len, flags);
-	else
-		mxs_i2c_pioq_setup_write(i2c, msg->addr, msg->buf, msg->len,
-					flags);
+		ret = mxs_i2c_dma_setup_xfer(adap, msg, flags);
+		if (ret)
+			return -EINVAL;
+	} else {
+		writel(MXS_I2C_QUEUECTRL_PIO_QUEUE_MODE,
+			i2c->regs + MXS_I2C_QUEUECTRL_SET);
 
-	writel(MXS_I2C_QUEUECTRL_QUEUE_RUN,
+		if (msg->flags & I2C_M_RD) {
+			mxs_i2c_pioq_setup_read(i2c, msg->addr,
+						msg->len, flags);
+		} else {
+			mxs_i2c_pioq_setup_write(i2c, msg->addr, msg->buf,
+						msg->len, flags);
+		}
+
+		writel(MXS_I2C_QUEUECTRL_QUEUE_RUN,
 			i2c->regs + MXS_I2C_QUEUECTRL_SET);
+	}
+
+	printk("%s[%i]\n", __func__, __LINE__);
 
 	ret = wait_for_completion_timeout(&i2c->cmd_complete,
 						msecs_to_jiffies(1000));
+
 	if (ret == 0)
 		goto timeout;
 
-	if ((!i2c->cmd_err) && (msg->flags & I2C_M_RD)) {
+	if (!i2c->dma && (!i2c->cmd_err) && (msg->flags & I2C_M_RD)) {
 		ret = mxs_i2c_finish_read(i2c, msg->buf, msg->len);
 		if (ret)
 			goto timeout;
@@ -252,6 +429,9 @@ static int mxs_i2c_xfer_msg(struct i2c_adapter *adap, struct i2c_msg *msg,
 
 	if (i2c->cmd_err == -ENXIO)
 		mxs_i2c_reset(i2c);
+	else
+		writel(MXS_I2C_QUEUECTRL_QUEUE_RUN,
+			i2c->regs + MXS_I2C_QUEUECTRL_CLR);
 
 	dev_dbg(i2c->dev, "Done with err=%d\n", i2c->cmd_err);
 
@@ -268,13 +448,20 @@ static int mxs_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[],
 {
 	int i;
 	int err;
+	struct mxs_i2c_dev *i2c = i2c_get_adapdata(adap);
+
+	mutex_lock(&i2c->mutex);
 
 	for (i = 0; i < num; i++) {
 		err = mxs_i2c_xfer_msg(adap, &msgs[i], i == (num - 1));
-		if (err)
+		if (err) {
+			mutex_unlock(&i2c->mutex);
 			return err;
+		}
 	}
 
+	mutex_unlock(&i2c->mutex);
+
 	return num;
 }
 
@@ -305,7 +494,7 @@ static irqreturn_t mxs_i2c_isr(int this_irq, void *dev_id)
 	is_last_cmd = (readl(i2c->regs + MXS_I2C_QUEUESTAT) &
 		MXS_I2C_QUEUESTAT_WRITE_QUEUE_CNT_MASK) == 0;
 
-	if (is_last_cmd || i2c->cmd_err)
+	if ((is_last_cmd || i2c->cmd_err) && !i2c->dma)
 		complete(&i2c->cmd_complete);
 
 	writel(stat, i2c->regs + MXS_I2C_CTRL1_CLR);
@@ -318,23 +507,45 @@ static const struct i2c_algorithm mxs_i2c_algo = {
 	.functionality = mxs_i2c_func,
 };
 
+static bool mxs_i2c_dma_filter(struct dma_chan *chan, void *param)
+{
+	struct mxs_i2c_dev *i2c = param;
+
+	if (!mxs_dma_is_apbx(chan))
+		return false;
+
+	if (chan->chan_id != i2c->dmares->start)
+		return false;
+
+	chan->private = &i2c->dma_data;
+
+	return true;
+}
+
 static int __devinit mxs_i2c_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct mxs_i2c_dev *i2c;
 	struct i2c_adapter *adap;
-	struct resource *res;
+	struct resource *res, *dmares;
 	resource_size_t res_size;
-	int err, irq;
+	int err, irq, dmairq;
+	dma_cap_mask_t mask;
 
 	i2c = devm_kzalloc(dev, sizeof(struct mxs_i2c_dev), GFP_KERNEL);
 	if (!i2c)
 		return -ENOMEM;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res)
+	dmares = platform_get_resource(pdev, IORESOURCE_DMA, 0);
+	irq = platform_get_irq(pdev, 0);
+	dmairq = platform_get_irq(pdev, 1);
+
+	if (!res || !dmares || irq < 0 || dmairq < 0)
 		return -ENOENT;
 
+	mutex_init(&i2c->mutex);
+
 	res_size = resource_size(res);
 	if (!devm_request_mem_region(dev, res->start, res_size, res->name))
 		return -EBUSY;
@@ -343,15 +554,23 @@ static int __devinit mxs_i2c_probe(struct platform_device *pdev)
 	if (!i2c->regs)
 		return -EBUSY;
 
-	irq = platform_get_irq(pdev, 0);
-	if (irq < 0)
-		return irq;
-
 	err = devm_request_irq(dev, irq, mxs_i2c_isr, 0, dev_name(dev), i2c);
 	if (err)
 		return err;
 
+	i2c->dmares = dmares;
 	i2c->dev = dev;
+
+	/* Setup the DMA */
+	dma_cap_zero(mask);
+	dma_cap_set(DMA_SLAVE, mask);
+	i2c->dma_data.chan_irq = dmairq;
+	i2c->dmach = dma_request_channel(mask, mxs_i2c_dma_filter, i2c);
+	if (!i2c->dmach) {
+		dev_err(dev, "Failed to request dma\n");
+		return -ENODEV;
+	}
+
 	platform_set_drvdata(pdev, i2c);
 
 	/* Do reset to enforce correct startup after pinmuxing */
-- 
1.7.10
