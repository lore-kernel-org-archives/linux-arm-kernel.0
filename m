From: marex@denx.de (Marek Vasut)
Date: Mon, 30 Apr 2012 00:36:09 +0200
Subject: [PATCH 2/2] I2C: Implement DMA support into mxs-i2c
In-Reply-To: <1335738969-27445-1-git-send-email-marex@denx.de>
References: <1335738969-27445-1-git-send-email-marex@denx.de>
Message-ID: <1335738969-27445-2-git-send-email-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch implements DMA support into mxs-i2c. DMA transfers are now enabled by
default, though it is possible for example for debugging purposes, to disable
them via i2c->dma_mode.

Cc: Linux I2C <linux-i2c@vger.kernel.org>
Cc: Detlev Zundel <dzu@denx.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Stefano Babic <sbabic@denx.de>
Cc: Wolfgang Denk <wd@denx.de>
Cc: Wolfram Sang <w.sang@pengutronix.de>
---
 arch/arm/mach-mxs/devices/platform-mxs-i2c.c    |    5 +
 arch/arm/mach-mxs/include/mach/devices-common.h |    1 +
 drivers/i2c/busses/i2c-mxs.c                    |  261 +++++++++++++++++++++--
 3 files changed, 245 insertions(+), 22 deletions(-)

diff --git a/arch/arm/mach-mxs/devices/platform-mxs-i2c.c b/arch/arm/mach-mxs/devices/platform-mxs-i2c.c
index 79222ec..a94f308 100644
--- a/arch/arm/mach-mxs/devices/platform-mxs-i2c.c
+++ b/arch/arm/mach-mxs/devices/platform-mxs-i2c.c
@@ -14,6 +14,7 @@
 	{								\
 		.id = _id,						\
 		.iobase = soc ## _I2C ## _id ## _BASE_ADDR,		\
+		.dma	= soc ## _DMA_I2C ## _id,			\
 		.errirq = soc ## _INT_I2C ## _id ## _ERROR,		\
 		.dmairq = soc ## _INT_I2C ## _id ## _DMA,		\
 	}
@@ -37,6 +38,10 @@ struct platform_device *__init mxs_add_mxs_i2c(
 			.end = data->iobase + SZ_8K - 1,
 			.flags = IORESOURCE_MEM,
 		}, {
+			.start	= data->dma,
+			.end	= data->dma,
+			.flags	= IORESOURCE_DMA,
+		}, {
 			.start = data->errirq,
 			.end = data->errirq,
 			.flags = IORESOURCE_IRQ,
diff --git a/arch/arm/mach-mxs/include/mach/devices-common.h b/arch/arm/mach-mxs/include/mach/devices-common.h
index f2e3839..791d99c 100644
--- a/arch/arm/mach-mxs/include/mach/devices-common.h
+++ b/arch/arm/mach-mxs/include/mach/devices-common.h
@@ -80,6 +80,7 @@ mxs_add_gpmi_nand(const struct gpmi_nand_platform_data *pdata,
 struct mxs_mxs_i2c_data {
 	int id;
 	resource_size_t iobase;
+	resource_size_t dma;
 	resource_size_t errirq;
 	resource_size_t dmairq;
 };
diff --git a/drivers/i2c/busses/i2c-mxs.c b/drivers/i2c/busses/i2c-mxs.c
index 0d8e485..b364b8b 100644
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
 
@@ -113,6 +116,16 @@ struct mxs_i2c_dev {
 	struct completion cmd_complete;
 	u32 cmd_err;
 	struct i2c_adapter adapter;
+
+	/* DMA support components */
+	bool				dma_mode;
+	struct resource			*dmares;
+	struct dma_chan         	*dmach;
+	struct mxs_dma_data		dma_data;
+	uint32_t			pio_data[2];
+	uint32_t			addr_data;
+	struct scatterlist		sg_io[2];
+	bool				dma_read;
 };
 
 /*
@@ -129,7 +142,12 @@ static void mxs_i2c_reset(struct mxs_i2c_dev *i2c)
 	writel(0x0015000d, i2c->regs + MXS_I2C_TIMING2);
 
 	writel(MXS_I2C_IRQ_MASK << 8, i2c->regs + MXS_I2C_CTRL1_SET);
-	writel(MXS_I2C_QUEUECTRL_PIO_QUEUE_MODE,
+
+	if (i2c->dma_mode)
+		writel(MXS_I2C_QUEUECTRL_PIO_QUEUE_MODE,
+			i2c->regs + MXS_I2C_QUEUECTRL_CLR);
+	else
+		writel(MXS_I2C_QUEUECTRL_PIO_QUEUE_MODE,
 			i2c->regs + MXS_I2C_QUEUECTRL_SET);
 }
 
@@ -204,7 +222,7 @@ static int mxs_i2c_wait_for_data(struct mxs_i2c_dev *i2c)
 
 static int mxs_i2c_finish_read(struct mxs_i2c_dev *i2c, u8 *buf, int len)
 {
-	u32 data;
+	u32 data = 0;
 	int i;
 
 	for (i = 0; i < len; i++) {
@@ -220,9 +238,155 @@ static int mxs_i2c_finish_read(struct mxs_i2c_dev *i2c, u8 *buf, int len)
 	return 0;
 }
 
+static void mxs_i2c_dma_finish(struct mxs_i2c_dev *i2c)
+{
+	if (i2c->dma_read) {
+		dma_unmap_sg(i2c->dev, &i2c->sg_io[0], 1, DMA_TO_DEVICE);
+		dma_unmap_sg(i2c->dev, &i2c->sg_io[1], 1, DMA_FROM_DEVICE);
+	} else {
+		dma_unmap_sg(i2c->dev, i2c->sg_io, 2, DMA_TO_DEVICE);
+	}
+}
+
+static void mxs_i2c_dma_irq_callback(void *param)
+{
+	struct mxs_i2c_dev *i2c = param;
+
+	complete(&i2c->cmd_complete);
+	mxs_i2c_dma_finish(i2c);
+}
+
+static int mxs_i2c_dma_setup_xfer(struct i2c_adapter *adap,
+			struct i2c_msg *msg, uint32_t flags)
+{
+	struct dma_async_tx_descriptor *desc;
+	struct mxs_i2c_dev *i2c = i2c_get_adapdata(adap);
+
+	if (msg->flags & I2C_M_RD) {
+		i2c->dma_read = 1;
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
+			dev_err(i2c->dev,
+				"Failed to get PIO reg. write descriptor.\n");
+			goto select_init_pio_fail;
+		}
+
+		/* Queue the DMA data transfer. */
+		sg_init_one(&i2c->sg_io[0], &i2c->addr_data, 1);
+		dma_map_sg(i2c->dev, &i2c->sg_io[0], 1, DMA_TO_DEVICE);
+		desc = dmaengine_prep_slave_sg(i2c->dmach, &i2c->sg_io[0], 1,
+					DMA_MEM_TO_DEV,
+					DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+		if (!desc) {
+			dev_err(i2c->dev,
+				"Failed to get DMA data write descriptor.\n");
+			goto select_init_dma_fail;
+		}
+
+		/*
+		 * READ command.
+		 */
+
+		/* Queue the PIO register write transfer. */
+		i2c->pio_data[1] = flags | MXS_CMD_I2C_READ |
+				MXS_I2C_CTRL0_XFER_COUNT(msg->len);
+		desc = dmaengine_prep_slave_sg(i2c->dmach,
+					(struct scatterlist *)&i2c->pio_data[1],
+					1, DMA_TRANS_NONE, DMA_PREP_INTERRUPT);
+		if (!desc) {
+			dev_err(i2c->dev,
+				"Failed to get PIO reg. write descriptor.\n");
+			goto select_init_dma_fail;
+		}
+
+		/* Queue the DMA data transfer. */
+		sg_init_one(&i2c->sg_io[1], msg->buf, msg->len);
+		dma_map_sg(i2c->dev, &i2c->sg_io[1], 1, DMA_FROM_DEVICE);
+		desc = dmaengine_prep_slave_sg(i2c->dmach, &i2c->sg_io[1], 1,
+					DMA_DEV_TO_MEM,
+					DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+		if (!desc) {
+			dev_err(i2c->dev,
+				"Failed to get DMA data write descriptor.\n");
+			goto read_init_dma_fail;
+		}
+	} else {
+		i2c->dma_read = 0;
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
+			dev_err(i2c->dev,
+				"Failed to get PIO reg. write descriptor.\n");
+			goto write_init_pio_fail;
+		}
+
+		/* Queue the DMA data transfer. */
+		sg_init_table(i2c->sg_io, 2);
+		sg_set_buf(&i2c->sg_io[0], &i2c->addr_data, 1);
+		sg_set_buf(&i2c->sg_io[1], msg->buf, msg->len);
+		dma_map_sg(i2c->dev, i2c->sg_io, 2, DMA_TO_DEVICE);
+		desc = dmaengine_prep_slave_sg(i2c->dmach, i2c->sg_io, 2,
+					DMA_MEM_TO_DEV,
+					DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+		if (!desc) {
+			dev_err(i2c->dev,
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
+	dma_async_issue_pending(i2c->dmach);
+	return 0;
+
+/* Read failpath. */
+read_init_dma_fail:
+	dma_unmap_sg(i2c->dev, &i2c->sg_io[1], 1, DMA_FROM_DEVICE);
+select_init_dma_fail:
+	dma_unmap_sg(i2c->dev, &i2c->sg_io[0], 1, DMA_TO_DEVICE);
+select_init_pio_fail:
+	return 1;
+
+
+/* Write failpath. */
+write_init_dma_fail:
+	dma_unmap_sg(i2c->dev, i2c->sg_io, 2, DMA_TO_DEVICE);
+write_init_pio_fail:
+	return 1;
+}
+
 /*
  * Low level master read/write transaction.
  */
+
 static int mxs_i2c_xfer_msg(struct i2c_adapter *adap, struct i2c_msg *msg,
 				int stop)
 {
@@ -230,6 +394,8 @@ static int mxs_i2c_xfer_msg(struct i2c_adapter *adap, struct i2c_msg *msg,
 	int ret;
 	int flags;
 
+	flags = stop ? MXS_I2C_CTRL0_POST_SEND_STOP : 0;
+
 	dev_dbg(i2c->dev, "addr: 0x%04x, len: %d, flags: 0x%x, stop: %d\n",
 		msg->addr, msg->len, msg->flags, stop);
 
@@ -238,23 +404,30 @@ static int mxs_i2c_xfer_msg(struct i2c_adapter *adap, struct i2c_msg *msg,
 
 	init_completion(&i2c->cmd_complete);
 
-	flags = stop ? MXS_I2C_CTRL0_POST_SEND_STOP : 0;
-
-	if (msg->flags & I2C_M_RD)
-		mxs_i2c_pioq_setup_read(i2c, msg->addr, msg->len, flags);
-	else
-		mxs_i2c_pioq_setup_write(i2c, msg->addr, msg->buf, msg->len,
-					flags);
+	if (i2c->dma_mode) {
+		ret = mxs_i2c_dma_setup_xfer(adap, msg, flags);
+		if (ret)
+			return -EINVAL;
+	} else {
+		if (msg->flags & I2C_M_RD) {
+			mxs_i2c_pioq_setup_read(i2c, msg->addr,
+						msg->len, flags);
+		} else {
+			mxs_i2c_pioq_setup_write(i2c, msg->addr, msg->buf,
+						msg->len, flags);
+		}
 
-	writel(MXS_I2C_QUEUECTRL_QUEUE_RUN,
+		writel(MXS_I2C_QUEUECTRL_QUEUE_RUN,
 			i2c->regs + MXS_I2C_QUEUECTRL_SET);
+	}
 
 	ret = wait_for_completion_timeout(&i2c->cmd_complete,
 						msecs_to_jiffies(1000));
+
 	if (ret == 0)
 		goto timeout;
 
-	if ((!i2c->cmd_err) && (msg->flags & I2C_M_RD)) {
+	if (!i2c->dma_mode && (!i2c->cmd_err) && (msg->flags & I2C_M_RD)) {
 		ret = mxs_i2c_finish_read(i2c, msg->buf, msg->len);
 		if (ret)
 			goto timeout;
@@ -269,7 +442,9 @@ static int mxs_i2c_xfer_msg(struct i2c_adapter *adap, struct i2c_msg *msg,
 
 timeout:
 	dev_dbg(i2c->dev, "Timeout!\n");
+	mxs_i2c_dma_finish(i2c);
 	mxs_i2c_reset(i2c);
+
 	return -ETIMEDOUT;
 }
 
@@ -312,11 +487,13 @@ static irqreturn_t mxs_i2c_isr(int this_irq, void *dev_id)
 	else
 		i2c->cmd_err = 0;
 
-	is_last_cmd = (readl(i2c->regs + MXS_I2C_QUEUESTAT) &
-		MXS_I2C_QUEUESTAT_WRITE_QUEUE_CNT_MASK) == 0;
+	if (!i2c->dma_mode) {
+		is_last_cmd = (readl(i2c->regs + MXS_I2C_QUEUESTAT) &
+			MXS_I2C_QUEUESTAT_WRITE_QUEUE_CNT_MASK) == 0;
 
-	if (is_last_cmd || i2c->cmd_err)
-		complete(&i2c->cmd_complete);
+		if (!i2c->dma_mode && (is_last_cmd || i2c->cmd_err))
+			complete(&i2c->cmd_complete);
+	}
 
 	writel(stat, i2c->regs + MXS_I2C_CTRL1_CLR);
 
@@ -328,21 +505,41 @@ static const struct i2c_algorithm mxs_i2c_algo = {
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
 
 	res_size = resource_size(res);
@@ -353,15 +550,32 @@ static int __devinit mxs_i2c_probe(struct platform_device *pdev)
 	if (!i2c->regs)
 		return -EBUSY;
 
-	irq = platform_get_irq(pdev, 0);
-	if (irq < 0)
-		return irq;
-
 	err = devm_request_irq(dev, irq, mxs_i2c_isr, 0, dev_name(dev), i2c);
 	if (err)
 		return err;
 
 	i2c->dev = dev;
+
+	/*
+	 * The MXS I2C DMA mode is prefered and enabled by default.
+	 * The PIO mode is still supported, but should be used only
+	 * for debuging purposes etc.
+	 */
+	i2c->dma_mode = 1;
+
+	/* Setup the DMA */
+	if (i2c->dma_mode) {
+		i2c->dmares = dmares;
+		dma_cap_zero(mask);
+		dma_cap_set(DMA_SLAVE, mask);
+		i2c->dma_data.chan_irq = dmairq;
+		i2c->dmach = dma_request_channel(mask, mxs_i2c_dma_filter, i2c);
+		if (!i2c->dmach) {
+			dev_err(dev, "Failed to request dma\n");
+			return -ENODEV;
+		}
+	}
+
 	platform_set_drvdata(pdev, i2c);
 
 	/* Do reset to enforce correct startup after pinmuxing */
@@ -394,6 +608,9 @@ static int __devexit mxs_i2c_remove(struct platform_device *pdev)
 	if (ret)
 		return -EBUSY;
 
+	if (i2c->dmach)
+		dma_release_channel(i2c->dmach);
+
 	writel(MXS_I2C_QUEUECTRL_QUEUE_RUN,
 			i2c->regs + MXS_I2C_QUEUECTRL_CLR);
 	writel(MXS_I2C_CTRL0_SFTRST, i2c->regs + MXS_I2C_CTRL0_SET);
-- 
1.7.10
