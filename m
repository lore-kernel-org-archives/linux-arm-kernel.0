From: marex@denx.de (Marek Vasut)
Date: Fri, 29 Jun 2012 10:24:03 +0200
Subject: [PATCH 2/2] MXS: Implement DMA support into mxs-i2c
In-Reply-To: <1340958243-2332-1-git-send-email-marex@denx.de>
References: <1340958243-2332-1-git-send-email-marex@denx.de>
Message-ID: <1340958243-2332-2-git-send-email-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch implements DMA support into mxs-i2c. DMA transfers are now enabled
via DT. The DMA operation is enabled by default.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Detlev Zundel <dzu@denx.de>
CC: Dong Aisheng <b29396@freescale.com>
CC: Fabio Estevam <fabio.estevam@freescale.com>
Cc: Linux ARM kernel <linux-arm-kernel@lists.infradead.org>
Cc: linux-i2c at vger.kernel.org
CC: Sascha Hauer <s.hauer@pengutronix.de>
CC: Shawn Guo <shawn.guo@linaro.org>
Cc: Stefano Babic <sbabic@denx.de>
CC: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Cc: Wolfgang Denk <wd@denx.de>
Cc: Wolfram Sang <w.sang@pengutronix.de>
---
 Documentation/devicetree/bindings/i2c/i2c-mxs.txt |    4 +
 arch/arm/boot/dts/imx28.dtsi                      |    2 +
 drivers/i2c/busses/i2c-mxs.c                      |  267 +++++++++++++++++++--
 3 files changed, 251 insertions(+), 22 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-mxs.txt b/Documentation/devicetree/bindings/i2c/i2c-mxs.txt
index d2bf750..9497ee0 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-mxs.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-mxs.txt
@@ -5,6 +5,10 @@ Required properties:
 - reg: Should contain registers location and length
 - interrupts: Should contain ERROR and DMA interrupts
 - clock-frequency: desired I2C bus clock frequency in Hz.
+- fsl,i2c-dma-channel: APBX DMA channel for the I2C
+
+Optional properties:
+- fsl,use-pio: Use PIO transfers instead of DMA, useful for debug
 
 Examples:
 
diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index 832d30a..e4a4842 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -420,6 +420,7 @@
 				reg = <0x80058000 2000>;
 				interrupts = <111 68>;
 				clock-frequency = <400000>;
+				fsl,i2c-dma-channel = <6>;
 				status = "disabled";
 			};
 
@@ -430,6 +431,7 @@
 				reg = <0x8005a000 2000>;
 				interrupts = <110 69>;
 				clock-frequency = <400000>;
+				fsl,i2c-dma-channel = <7>;
 				status = "disabled";
 			};
 
diff --git a/drivers/i2c/busses/i2c-mxs.c b/drivers/i2c/busses/i2c-mxs.c
index cdcfd3f..b8efc8b 100644
--- a/drivers/i2c/busses/i2c-mxs.c
+++ b/drivers/i2c/busses/i2c-mxs.c
@@ -7,8 +7,6 @@
  *
  * Copyright (C) 2009-2010 Freescale Semiconductor, Inc. All Rights Reserved.
  *
- * TODO: add dma-support if platform-support for it is available
- *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
  * the Free Software Foundation; either version 2 of the License, or
@@ -31,6 +29,9 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/of_i2c.h>
+#include <linux/dma-mapping.h>
+#include <linux/dmaengine.h>
+#include <linux/fsl/mxs-dma.h>
 
 #define DRIVER_NAME "mxs-i2c"
 
@@ -136,6 +137,16 @@ struct mxs_i2c_dev {
 	u32 cmd_err;
 	struct i2c_adapter adapter;
 	const struct mxs_i2c_speed_config *speed;
+
+	/* DMA support components */
+	bool				dma_mode;
+	int				dma_channel;
+	struct dma_chan         	*dmach;
+	struct mxs_dma_data		dma_data;
+	uint32_t			pio_data[2];
+	uint32_t			addr_data;
+	struct scatterlist		sg_io[2];
+	bool				dma_read;
 };
 
 static void mxs_i2c_reset(struct mxs_i2c_dev *i2c)
@@ -147,7 +158,11 @@ static void mxs_i2c_reset(struct mxs_i2c_dev *i2c)
 	writel(i2c->speed->timing2, i2c->regs + MXS_I2C_TIMING2);
 
 	writel(MXS_I2C_IRQ_MASK << 8, i2c->regs + MXS_I2C_CTRL1_SET);
-	writel(MXS_I2C_QUEUECTRL_PIO_QUEUE_MODE,
+	if (i2c->dma_mode)
+		writel(MXS_I2C_QUEUECTRL_PIO_QUEUE_MODE,
+			i2c->regs + MXS_I2C_QUEUECTRL_CLR);
+	else
+		writel(MXS_I2C_QUEUECTRL_PIO_QUEUE_MODE,
 			i2c->regs + MXS_I2C_QUEUECTRL_SET);
 }
 
@@ -238,6 +253,151 @@ static int mxs_i2c_finish_read(struct mxs_i2c_dev *i2c, u8 *buf, int len)
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
@@ -248,6 +408,8 @@ static int mxs_i2c_xfer_msg(struct i2c_adapter *adap, struct i2c_msg *msg,
 	int ret;
 	int flags;
 
+	flags = stop ? MXS_I2C_CTRL0_POST_SEND_STOP : 0;
+
 	dev_dbg(i2c->dev, "addr: 0x%04x, len: %d, flags: 0x%x, stop: %d\n",
 		msg->addr, msg->len, msg->flags, stop);
 
@@ -257,23 +419,29 @@ static int mxs_i2c_xfer_msg(struct i2c_adapter *adap, struct i2c_msg *msg,
 	init_completion(&i2c->cmd_complete);
 	i2c->cmd_err = 0;
 
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
 	if (ret == 0)
 		goto timeout;
 
-	if ((!i2c->cmd_err) && (msg->flags & I2C_M_RD)) {
+	if (!i2c->dma_mode && !i2c->cmd_err && (msg->flags & I2C_M_RD)) {
 		ret = mxs_i2c_finish_read(i2c, msg->buf, msg->len);
 		if (ret)
 			goto timeout;
@@ -291,6 +459,7 @@ static int mxs_i2c_xfer_msg(struct i2c_adapter *adap, struct i2c_msg *msg,
 
 timeout:
 	dev_dbg(i2c->dev, "Timeout!\n");
+	mxs_i2c_dma_finish(i2c);
 	mxs_i2c_reset(i2c);
 	return -ETIMEDOUT;
 }
@@ -332,11 +501,13 @@ static irqreturn_t mxs_i2c_isr(int this_irq, void *dev_id)
 		/* MXS_I2C_CTRL1_OVERSIZE_XFER_TERM_IRQ is only for slaves */
 		i2c->cmd_err = -EIO;
 
-	is_last_cmd = (readl(i2c->regs + MXS_I2C_QUEUESTAT) &
-		MXS_I2C_QUEUESTAT_WRITE_QUEUE_CNT_MASK) == 0;
+	if (!i2c->dma_mode) {
+		is_last_cmd = (readl(i2c->regs + MXS_I2C_QUEUESTAT) &
+			MXS_I2C_QUEUESTAT_WRITE_QUEUE_CNT_MASK) == 0;
 
-	if (is_last_cmd || i2c->cmd_err)
-		complete(&i2c->cmd_complete);
+		if (is_last_cmd || i2c->cmd_err)
+			complete(&i2c->cmd_complete);
+	}
 
 	writel(stat, i2c->regs + MXS_I2C_CTRL1_CLR);
 
@@ -348,6 +519,21 @@ static const struct i2c_algorithm mxs_i2c_algo = {
 	.functionality = mxs_i2c_func,
 };
 
+static bool mxs_i2c_dma_filter(struct dma_chan *chan, void *param)
+{
+	struct mxs_i2c_dev *i2c = param;
+
+	if (!mxs_dma_is_apbx(chan))
+		return false;
+
+	if (chan->chan_id != i2c->dma_channel)
+		return false;
+
+	chan->private = &i2c->dma_data;
+
+	return true;
+}
+
 static int mxs_i2c_get_ofdata(struct mxs_i2c_dev *i2c)
 {
 	uint32_t speed;
@@ -358,6 +544,28 @@ static int mxs_i2c_get_ofdata(struct mxs_i2c_dev *i2c)
 	if (!node)
 		return -EINVAL;
 
+	/*
+	 * The MXS I2C DMA mode is prefered and enabled by default.
+	 * The PIO mode is still supported, but should be used only
+	 * for debuging purposes etc.
+	 */
+	i2c->dma_mode = 1;
+	if (of_find_property(node, "fsl,use-pio", NULL)) {
+		i2c->dma_mode = 0;
+		dev_info(dev, "Using PIO mode for I2C transfers!\n");
+	}
+
+	/*
+	 * TODO: This is a temporary solution and should be changed
+	 * to use generic DMA binding later when the helpers get in.
+	 */
+	ret = of_property_read_u32(node, "fsl,i2c-dma-channel",
+				   &i2c->dma_channel);
+	if (ret) {
+		dev_warn(dev, "Failed to get DMA channel!\n");
+		i2c->dma_mode = 0;
+	}
+
 	i2c->speed = &mxs_i2c_95kHz_config;
 	ret = of_property_read_u32(node, "clock-frequency", &speed);
 	if (ret)
@@ -378,7 +586,8 @@ static int __devinit mxs_i2c_probe(struct platform_device *pdev)
 	struct pinctrl *pinctrl;
 	struct resource *res;
 	resource_size_t res_size;
-	int err, irq;
+	int err, irq, dmairq;
+	dma_cap_mask_t mask;
 
 	pinctrl = devm_pinctrl_get_select_default(dev);
 	if (IS_ERR(pinctrl))
@@ -389,7 +598,10 @@ static int __devinit mxs_i2c_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res)
+	irq = platform_get_irq(pdev, 0);
+	dmairq = platform_get_irq(pdev, 1);
+
+	if (!res || irq < 0 || dmairq < 0)
 		return -ENOENT;
 
 	res_size = resource_size(res);
@@ -400,10 +612,6 @@ static int __devinit mxs_i2c_probe(struct platform_device *pdev)
 	if (!i2c->regs)
 		return -EBUSY;
 
-	irq = platform_get_irq(pdev, 0);
-	if (irq < 0)
-		return irq;
-
 	err = devm_request_irq(dev, irq, mxs_i2c_isr, 0, dev_name(dev), i2c);
 	if (err)
 		return err;
@@ -414,6 +622,18 @@ static int __devinit mxs_i2c_probe(struct platform_device *pdev)
 	if (err)
 		return err;
 
+	/* Setup the DMA */
+	if (i2c->dma_mode) {
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
@@ -449,6 +669,9 @@ static int __devexit mxs_i2c_remove(struct platform_device *pdev)
 	if (ret)
 		return -EBUSY;
 
+	if (i2c->dmach)
+		dma_release_channel(i2c->dmach);
+
 	writel(MXS_I2C_CTRL0_SFTRST, i2c->regs + MXS_I2C_CTRL0_SET);
 
 	platform_set_drvdata(pdev, NULL);
-- 
1.7.10
