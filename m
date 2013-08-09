From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri,  9 Aug 2013 11:05:56 +0200
Subject: [PATCH v5 1/3] i2c-mv64xxx: Add I2C Transaction Generator support
In-Reply-To: <1376039158-1896-1-git-send-email-gregory.clement@free-electrons.com>
References: <1376039158-1896-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1376039158-1896-2-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The I2C Transaction Generator offloads CPU from managing I2C
transfer step by step.

This feature is currently only available on Armada XP, so usage of
this mechanism is activated through device tree.

Based on the work of Piotr Ziecik and rewrote to use the new way of
handling multiples i2c messages.

Signed-off-by: Piotr Ziecik <kosmo@semihalf.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 drivers/i2c/busses/i2c-mv64xxx.c | 208 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 197 insertions(+), 11 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mv64xxx.c b/drivers/i2c/busses/i2c-mv64xxx.c
index b1f42bf..406d9c6 100644
--- a/drivers/i2c/busses/i2c-mv64xxx.c
+++ b/drivers/i2c/busses/i2c-mv64xxx.c
@@ -55,6 +55,32 @@
 #define	MV64XXX_I2C_STATUS_MAST_RD_ADDR_2_NO_ACK	0xe8
 #define	MV64XXX_I2C_STATUS_NO_STATUS			0xf8
 
+/* Register defines (I2C bridge) */
+#define	MV64XXX_I2C_REG_TX_DATA_LO			0xc0
+#define	MV64XXX_I2C_REG_TX_DATA_HI			0xc4
+#define	MV64XXX_I2C_REG_RX_DATA_LO			0xc8
+#define	MV64XXX_I2C_REG_RX_DATA_HI			0xcc
+#define	MV64XXX_I2C_REG_BRIDGE_CONTROL			0xd0
+#define	MV64XXX_I2C_REG_BRIDGE_STATUS			0xd4
+#define	MV64XXX_I2C_REG_BRIDGE_INTR_CAUSE		0xd8
+#define	MV64XXX_I2C_REG_BRIDGE_INTR_MASK		0xdC
+#define	MV64XXX_I2C_REG_BRIDGE_TIMING			0xe0
+
+/* Bridge Control values */
+#define	MV64XXX_I2C_BRIDGE_CONTROL_WR			0x00000001
+#define	MV64XXX_I2C_BRIDGE_CONTROL_RD			0x00000002
+#define	MV64XXX_I2C_BRIDGE_CONTROL_ADDR_SHIFT		2
+#define	MV64XXX_I2C_BRIDGE_CONTROL_ADDR_EXT		0x00001000
+#define	MV64XXX_I2C_BRIDGE_CONTROL_TX_SIZE_SHIFT	13
+#define	MV64XXX_I2C_BRIDGE_CONTROL_RX_SIZE_SHIFT	16
+#define	MV64XXX_I2C_BRIDGE_CONTROL_ENABLE		0x00080000
+
+/* Bridge Status values */
+#define	MV64XXX_I2C_BRIDGE_STATUS_ERROR			0x00000001
+#define	MV64XXX_I2C_STATUS_OFFLOAD_ERROR		0xf0000001
+#define	MV64XXX_I2C_STATUS_OFFLOAD_OK			0xf0000000
+
+
 /* Driver states */
 enum {
 	MV64XXX_I2C_STATE_INVALID,
@@ -71,14 +97,17 @@ enum {
 enum {
 	MV64XXX_I2C_ACTION_INVALID,
 	MV64XXX_I2C_ACTION_CONTINUE,
+	MV64XXX_I2C_ACTION_OFFLOAD_SEND_START,
 	MV64XXX_I2C_ACTION_SEND_START,
 	MV64XXX_I2C_ACTION_SEND_RESTART,
+	MV64XXX_I2C_ACTION_OFFLOAD_RESTART,
 	MV64XXX_I2C_ACTION_SEND_ADDR_1,
 	MV64XXX_I2C_ACTION_SEND_ADDR_2,
 	MV64XXX_I2C_ACTION_SEND_DATA,
 	MV64XXX_I2C_ACTION_RCV_DATA,
 	MV64XXX_I2C_ACTION_RCV_DATA_STOP,
 	MV64XXX_I2C_ACTION_SEND_STOP,
+	MV64XXX_I2C_ACTION_OFFLOAD_SEND_STOP,
 };
 
 struct mv64xxx_i2c_regs {
@@ -117,6 +146,7 @@ struct mv64xxx_i2c_data {
 	spinlock_t		lock;
 	struct i2c_msg		*msg;
 	struct i2c_adapter	adapter;
+	bool			offload_enabled;
 };
 
 static struct mv64xxx_i2c_regs mv64xxx_i2c_regs_mv64xxx = {
@@ -165,6 +195,79 @@ mv64xxx_i2c_prepare_for_io(struct mv64xxx_i2c_data *drv_data,
 	}
 }
 
+static int mv64xxx_i2c_offload_msg(struct mv64xxx_i2c_data *drv_data)
+{
+	unsigned long data_reg_hi = 0;
+	unsigned long data_reg_lo = 0;
+	unsigned long ctrl_reg;
+	unsigned int i;
+	struct i2c_msg *msg = drv_data->msgs;
+
+	drv_data->msg = msg;
+	drv_data->byte_posn = 0;
+	drv_data->bytes_left = msg->len;
+	drv_data->aborting = 0;
+	drv_data->rc = 0;
+	/* Only regular transactions can be offloaded */
+	if ((msg->flags & ~(I2C_M_TEN | I2C_M_RD)) != 0)
+		return 1;
+
+	/* Only 1-8 byte transfers can be offloaded */
+	if (msg->len < 1 || msg->len > 8)
+		return 1;
+
+	/* Build transaction */
+	ctrl_reg = MV64XXX_I2C_BRIDGE_CONTROL_ENABLE |
+		   (msg->addr << MV64XXX_I2C_BRIDGE_CONTROL_ADDR_SHIFT);
+
+	if ((msg->flags & I2C_M_TEN) != 0)
+		ctrl_reg |=  MV64XXX_I2C_BRIDGE_CONTROL_ADDR_EXT;
+
+	if ((msg->flags & I2C_M_RD) == 0) {
+		for (i = 0; i < 4 && i < msg->len; i++)
+			data_reg_lo = data_reg_lo |
+					(msg->buf[i] << ((i & 0x3) * 8));
+
+		for (i = 4; i < 8 && i < msg->len; i++)
+			data_reg_hi = data_reg_hi |
+					(msg->buf[i] << ((i & 0x3) * 8));
+
+		ctrl_reg |= MV64XXX_I2C_BRIDGE_CONTROL_WR |
+		    (msg->len - 1) << MV64XXX_I2C_BRIDGE_CONTROL_TX_SIZE_SHIFT;
+	} else {
+		ctrl_reg |= MV64XXX_I2C_BRIDGE_CONTROL_RD |
+		    (msg->len - 1) << MV64XXX_I2C_BRIDGE_CONTROL_RX_SIZE_SHIFT;
+	}
+
+	/* Execute transaction */
+	writel_relaxed(data_reg_lo,
+		drv_data->reg_base + MV64XXX_I2C_REG_TX_DATA_LO);
+	writel_relaxed(data_reg_hi,
+		drv_data->reg_base + MV64XXX_I2C_REG_TX_DATA_HI);
+	writel(ctrl_reg, drv_data->reg_base + MV64XXX_I2C_REG_BRIDGE_CONTROL);
+
+	return 0;
+}
+
+static void
+mv64xxx_i2c_update_offload_data(struct i2c_msg *msg, unsigned long data_reg_hi,
+	unsigned long data_reg_lo)
+{
+	int i;
+
+	if ((msg->flags & I2C_M_RD) != 0) {
+		for (i = 0; i < 4 && i < msg->len; i++) {
+			msg->buf[i] = data_reg_lo & 0xFF;
+			data_reg_lo >>= 8;
+		}
+
+		for (i = 4; i < 8 && i < msg->len; i++) {
+			msg->buf[i] = data_reg_hi & 0xFF;
+			data_reg_hi >>= 8;
+		}
+	}
+
+}
 /*
  *****************************************************************************
  *
@@ -177,6 +280,15 @@ mv64xxx_i2c_prepare_for_io(struct mv64xxx_i2c_data *drv_data,
 static void
 mv64xxx_i2c_hw_init(struct mv64xxx_i2c_data *drv_data)
 {
+	if (drv_data->offload_enabled) {
+		writel(0, drv_data->reg_base + MV64XXX_I2C_REG_BRIDGE_CONTROL);
+		writel(0, drv_data->reg_base + MV64XXX_I2C_REG_BRIDGE_TIMING);
+		writel(0, drv_data->reg_base +
+			MV64XXX_I2C_REG_BRIDGE_INTR_CAUSE);
+		writel(0, drv_data->reg_base +
+			MV64XXX_I2C_REG_BRIDGE_INTR_MASK);
+	}
+
 	writel(0, drv_data->reg_base + drv_data->reg_offsets.soft_reset);
 	writel(MV64XXX_I2C_BAUD_DIV_M(drv_data->freq_m) | MV64XXX_I2C_BAUD_DIV_N(drv_data->freq_n),
 		drv_data->reg_base + drv_data->reg_offsets.clock);
@@ -283,6 +395,16 @@ mv64xxx_i2c_fsm(struct mv64xxx_i2c_data *drv_data, u32 status)
 		drv_data->rc = -ENXIO;
 		break;
 
+	case MV64XXX_I2C_STATUS_OFFLOAD_OK:
+		if (drv_data->send_stop || drv_data->aborting) {
+			drv_data->action = MV64XXX_I2C_ACTION_OFFLOAD_SEND_STOP;
+			drv_data->state = MV64XXX_I2C_STATE_IDLE;
+		} else {
+			drv_data->action = MV64XXX_I2C_ACTION_OFFLOAD_RESTART;
+			drv_data->state = MV64XXX_I2C_STATE_WAITING_FOR_RESTART;
+		}
+		break;
+
 	default:
 		dev_err(&drv_data->adapter.dev,
 			"mv64xxx_i2c_fsm: Ctlr Error -- state: 0x%x, "
@@ -298,21 +420,36 @@ mv64xxx_i2c_fsm(struct mv64xxx_i2c_data *drv_data, u32 status)
 static void
 mv64xxx_i2c_do_action(struct mv64xxx_i2c_data *drv_data)
 {
+	unsigned long data_reg_hi = 0;
+	unsigned long data_reg_lo = 0;
+
 	switch(drv_data->action) {
+	case MV64XXX_I2C_ACTION_OFFLOAD_RESTART:
+		data_reg_lo = readl(drv_data->reg_base +
+				MV64XXX_I2C_REG_RX_DATA_LO);
+		data_reg_hi = readl(drv_data->reg_base +
+				MV64XXX_I2C_REG_RX_DATA_HI);
+		mv64xxx_i2c_update_offload_data(drv_data->msg, data_reg_hi,
+						data_reg_lo);
+		writel(0, drv_data->reg_base +	MV64XXX_I2C_REG_BRIDGE_CONTROL);
+		writel(0, drv_data->reg_base +
+			MV64XXX_I2C_REG_BRIDGE_INTR_CAUSE);
+		/* FALLTHRU */
 	case MV64XXX_I2C_ACTION_SEND_RESTART:
 		/* We should only get here if we have further messages */
 		BUG_ON(drv_data->num_msgs == 0);
 
-		drv_data->cntl_bits |= MV64XXX_I2C_REG_CONTROL_START;
-		writel(drv_data->cntl_bits,
-			drv_data->reg_base + drv_data->reg_offsets.control);
-
 		drv_data->msgs++;
 		drv_data->num_msgs--;
+		if (!(drv_data->offload_enabled &&
+				mv64xxx_i2c_offload_msg(drv_data))) {
+			drv_data->cntl_bits |= MV64XXX_I2C_REG_CONTROL_START;
+			writel(drv_data->cntl_bits,
+			drv_data->reg_base + drv_data->reg_offsets.control);
 
-		/* Setup for the next message */
-		mv64xxx_i2c_prepare_for_io(drv_data, drv_data->msgs);
-
+			/* Setup for the next message */
+			mv64xxx_i2c_prepare_for_io(drv_data, drv_data->msgs);
+		}
 		/*
 		 * We're never at the start of the message here, and by this
 		 * time it's already too late to do any protocol mangling.
@@ -326,6 +463,12 @@ mv64xxx_i2c_do_action(struct mv64xxx_i2c_data *drv_data)
 			drv_data->reg_base + drv_data->reg_offsets.control);
 		break;
 
+	case MV64XXX_I2C_ACTION_OFFLOAD_SEND_START:
+		if (mv64xxx_i2c_offload_msg(drv_data) <= 0)
+			break;
+		else
+			drv_data->action = MV64XXX_I2C_ACTION_SEND_START;
+		/* FALLTHRU */
 	case MV64XXX_I2C_ACTION_SEND_START:
 		writel(drv_data->cntl_bits | MV64XXX_I2C_REG_CONTROL_START,
 			drv_data->reg_base + drv_data->reg_offsets.control);
@@ -375,6 +518,7 @@ mv64xxx_i2c_do_action(struct mv64xxx_i2c_data *drv_data)
 			"mv64xxx_i2c_do_action: Invalid action: %d\n",
 			drv_data->action);
 		drv_data->rc = -EIO;
+
 		/* FALLTHRU */
 	case MV64XXX_I2C_ACTION_SEND_STOP:
 		drv_data->cntl_bits &= ~MV64XXX_I2C_REG_CONTROL_INTEN;
@@ -383,6 +527,20 @@ mv64xxx_i2c_do_action(struct mv64xxx_i2c_data *drv_data)
 		drv_data->block = 0;
 		wake_up(&drv_data->waitq);
 		break;
+
+	case MV64XXX_I2C_ACTION_OFFLOAD_SEND_STOP:
+		data_reg_lo = readl(drv_data->reg_base +
+				MV64XXX_I2C_REG_RX_DATA_LO);
+		data_reg_hi = readl(drv_data->reg_base +
+				MV64XXX_I2C_REG_RX_DATA_HI);
+		mv64xxx_i2c_update_offload_data(drv_data->msg, data_reg_hi,
+						data_reg_lo);
+		writel(0, drv_data->reg_base +	MV64XXX_I2C_REG_BRIDGE_CONTROL);
+		writel(0, drv_data->reg_base +
+			MV64XXX_I2C_REG_BRIDGE_INTR_CAUSE);
+		drv_data->block = 0;
+		wake_up(&drv_data->waitq);
+		break;
 	}
 }
 
@@ -395,6 +553,21 @@ mv64xxx_i2c_intr(int irq, void *dev_id)
 	irqreturn_t	rc = IRQ_NONE;
 
 	spin_lock_irqsave(&drv_data->lock, flags);
+
+	if (drv_data->offload_enabled) {
+		while (readl(drv_data->reg_base +
+				MV64XXX_I2C_REG_BRIDGE_INTR_CAUSE)) {
+			int reg_status = readl(drv_data->reg_base +
+					MV64XXX_I2C_REG_BRIDGE_STATUS);
+			if (reg_status & MV64XXX_I2C_BRIDGE_STATUS_ERROR)
+				status = MV64XXX_I2C_STATUS_OFFLOAD_ERROR;
+			else
+				status = MV64XXX_I2C_STATUS_OFFLOAD_OK;
+			mv64xxx_i2c_fsm(drv_data, status);
+			mv64xxx_i2c_do_action(drv_data);
+			rc = IRQ_HANDLED;
+		}
+	}
 	while (readl(drv_data->reg_base + drv_data->reg_offsets.control) &
 						MV64XXX_I2C_REG_CONTROL_IFLG) {
 		status = readl(drv_data->reg_base + drv_data->reg_offsets.status);
@@ -459,11 +632,15 @@ mv64xxx_i2c_execute_msg(struct mv64xxx_i2c_data *drv_data, struct i2c_msg *msg,
 	unsigned long	flags;
 
 	spin_lock_irqsave(&drv_data->lock, flags);
-	mv64xxx_i2c_prepare_for_io(drv_data, msg);
-
-	drv_data->action = MV64XXX_I2C_ACTION_SEND_START;
-	drv_data->state = MV64XXX_I2C_STATE_WAITING_FOR_START_COND;
+	if (drv_data->offload_enabled) {
+		drv_data->action = MV64XXX_I2C_ACTION_OFFLOAD_SEND_START;
+		drv_data->state = MV64XXX_I2C_STATE_WAITING_FOR_START_COND;
+	} else {
+		mv64xxx_i2c_prepare_for_io(drv_data, msg);
 
+		drv_data->action = MV64XXX_I2C_ACTION_SEND_START;
+		drv_data->state = MV64XXX_I2C_STATE_WAITING_FOR_START_COND;
+	}
 	drv_data->send_stop = is_last;
 	drv_data->block = 1;
 	mv64xxx_i2c_do_action(drv_data);
@@ -521,6 +698,7 @@ static const struct i2c_algorithm mv64xxx_i2c_algo = {
 static const struct of_device_id mv64xxx_i2c_of_match_table[] = {
 	{ .compatible = "allwinner,sun4i-i2c", .data = &mv64xxx_i2c_regs_sun4i},
 	{ .compatible = "marvell,mv64xxx-i2c", .data = &mv64xxx_i2c_regs_mv64xxx},
+	{ .compatible = "marvell,mv78230-i2c", .data = &mv64xxx_i2c_regs_mv64xxx},
 	{}
 };
 MODULE_DEVICE_TABLE(of, mv64xxx_i2c_of_match_table);
@@ -601,6 +779,13 @@ mv64xxx_of_config(struct mv64xxx_i2c_data *drv_data,
 
 	memcpy(&drv_data->reg_offsets, device->data, sizeof(drv_data->reg_offsets));
 
+	/*
+	 * For controllers embedded in new SoCs activate the
+	 * Transaction Generator support.
+	 */
+	if (of_device_is_compatible(np, "marvell,mv78230-i2c"))
+		drv_data->offload_enabled = true;
+
 out:
 	return rc;
 #endif
@@ -654,6 +839,7 @@ mv64xxx_i2c_probe(struct platform_device *pd)
 		drv_data->freq_n = pdata->freq_n;
 		drv_data->irq = platform_get_irq(pd, 0);
 		drv_data->adapter.timeout = msecs_to_jiffies(pdata->timeout);
+		drv_data->offload_enabled = 0;
 		memcpy(&drv_data->reg_offsets, &mv64xxx_i2c_regs_mv64xxx, sizeof(drv_data->reg_offsets));
 	} else if (pd->dev.of_node) {
 		rc = mv64xxx_of_config(drv_data, &pd->dev);
-- 
1.8.1.2
