From: jae.hyun.yoo@linux.intel.com (Jae Hyun Yoo)
Date: Tue, 11 Sep 2018 15:24:45 -0700
Subject: [PATCH] Revert "i2c: aspeed: Handle master/slave combined irq events
 properly"
In-Reply-To: <e5135af4-9105-214f-5de2-65cc03804222@linux.intel.com>
References: <e5135af4-9105-214f-5de2-65cc03804222@linux.intel.com>
Message-ID: <20180911222445.18064-1-jae.hyun.yoo@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This reverts commit 3e9efc3299dd "i2c: aspeed: Handle master/slave
combined irq events properly" to fix an issue which is reported
from QEMU v3.0 environment.

Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Cc: Guenter Roeck <linux@roeck-us.net>
---
 drivers/i2c/busses/i2c-aspeed.c | 131 ++++++++++++++------------------
 1 file changed, 55 insertions(+), 76 deletions(-)

diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
index c258c4d9a4c0..a4f956c6d567 100644
--- a/drivers/i2c/busses/i2c-aspeed.c
+++ b/drivers/i2c/busses/i2c-aspeed.c
@@ -82,11 +82,6 @@
 #define ASPEED_I2CD_INTR_RX_DONE			BIT(2)
 #define ASPEED_I2CD_INTR_TX_NAK				BIT(1)
 #define ASPEED_I2CD_INTR_TX_ACK				BIT(0)
-#define ASPEED_I2CD_INTR_MASTER_ERRORS					       \
-		(ASPEED_I2CD_INTR_SDA_DL_TIMEOUT |			       \
-		 ASPEED_I2CD_INTR_SCL_TIMEOUT |				       \
-		 ASPEED_I2CD_INTR_ABNORMAL |				       \
-		 ASPEED_I2CD_INTR_ARBIT_LOSS)
 #define ASPEED_I2CD_INTR_ALL						       \
 		(ASPEED_I2CD_INTR_SDA_DL_TIMEOUT |			       \
 		 ASPEED_I2CD_INTR_BUS_RECOVER_DONE |			       \
@@ -232,26 +227,32 @@ static int aspeed_i2c_recover_bus(struct aspeed_i2c_bus *bus)
 }
 
 #if IS_ENABLED(CONFIG_I2C_SLAVE)
-static u32 aspeed_i2c_slave_irq(struct aspeed_i2c_bus *bus, u32 irq_status)
+static bool aspeed_i2c_slave_irq(struct aspeed_i2c_bus *bus)
 {
-	u32 command, irq_handled = 0;
+	u32 command, irq_status, status_ack = 0;
 	struct i2c_client *slave = bus->slave;
+	bool irq_handled = true;
 	u8 value;
 
-	if (!slave)
-		return 0;
+	if (!slave) {
+		irq_handled = false;
+		goto out;
+	}
 
 	command = readl(bus->base + ASPEED_I2C_CMD_REG);
+	irq_status = readl(bus->base + ASPEED_I2C_INTR_STS_REG);
 
 	/* Slave was requested, restart state machine. */
 	if (irq_status & ASPEED_I2CD_INTR_SLAVE_MATCH) {
-		irq_handled |= ASPEED_I2CD_INTR_SLAVE_MATCH;
+		status_ack |= ASPEED_I2CD_INTR_SLAVE_MATCH;
 		bus->slave_state = ASPEED_I2C_SLAVE_START;
 	}
 
 	/* Slave is not currently active, irq was for someone else. */
-	if (bus->slave_state == ASPEED_I2C_SLAVE_STOP)
-		return irq_handled;
+	if (bus->slave_state == ASPEED_I2C_SLAVE_STOP) {
+		irq_handled = false;
+		goto out;
+	}
 
 	dev_dbg(bus->dev, "slave irq status 0x%08x, cmd 0x%08x\n",
 		irq_status, command);
@@ -268,31 +269,31 @@ static u32 aspeed_i2c_slave_irq(struct aspeed_i2c_bus *bus, u32 irq_status)
 				bus->slave_state =
 						ASPEED_I2C_SLAVE_WRITE_REQUESTED;
 		}
-		irq_handled |= ASPEED_I2CD_INTR_RX_DONE;
+		status_ack |= ASPEED_I2CD_INTR_RX_DONE;
 	}
 
 	/* Slave was asked to stop. */
 	if (irq_status & ASPEED_I2CD_INTR_NORMAL_STOP) {
-		irq_handled |= ASPEED_I2CD_INTR_NORMAL_STOP;
+		status_ack |= ASPEED_I2CD_INTR_NORMAL_STOP;
 		bus->slave_state = ASPEED_I2C_SLAVE_STOP;
 	}
 	if (irq_status & ASPEED_I2CD_INTR_TX_NAK) {
-		irq_handled |= ASPEED_I2CD_INTR_TX_NAK;
+		status_ack |= ASPEED_I2CD_INTR_TX_NAK;
 		bus->slave_state = ASPEED_I2C_SLAVE_STOP;
 	}
-	if (irq_status & ASPEED_I2CD_INTR_TX_ACK)
-		irq_handled |= ASPEED_I2CD_INTR_TX_ACK;
 
 	switch (bus->slave_state) {
 	case ASPEED_I2C_SLAVE_READ_REQUESTED:
 		if (irq_status & ASPEED_I2CD_INTR_TX_ACK)
 			dev_err(bus->dev, "Unexpected ACK on read request.\n");
 		bus->slave_state = ASPEED_I2C_SLAVE_READ_PROCESSED;
+
 		i2c_slave_event(slave, I2C_SLAVE_READ_REQUESTED, &value);
 		writel(value, bus->base + ASPEED_I2C_BYTE_BUF_REG);
 		writel(ASPEED_I2CD_S_TX_CMD, bus->base + ASPEED_I2C_CMD_REG);
 		break;
 	case ASPEED_I2C_SLAVE_READ_PROCESSED:
+		status_ack |= ASPEED_I2CD_INTR_TX_ACK;
 		if (!(irq_status & ASPEED_I2CD_INTR_TX_ACK))
 			dev_err(bus->dev,
 				"Expected ACK after processed read.\n");
@@ -316,6 +317,13 @@ static u32 aspeed_i2c_slave_irq(struct aspeed_i2c_bus *bus, u32 irq_status)
 		break;
 	}
 
+	if (status_ack != irq_status)
+		dev_err(bus->dev,
+			"irq handled != irq. expected %x, but was %x\n",
+			irq_status, status_ack);
+	writel(status_ack, bus->base + ASPEED_I2C_INTR_STS_REG);
+
+out:
 	return irq_handled;
 }
 #endif /* CONFIG_I2C_SLAVE */
@@ -372,21 +380,21 @@ static int aspeed_i2c_is_irq_error(u32 irq_status)
 	return 0;
 }
 
-static u32 aspeed_i2c_master_irq(struct aspeed_i2c_bus *bus, u32 irq_status)
+static bool aspeed_i2c_master_irq(struct aspeed_i2c_bus *bus)
 {
-	u32 irq_handled = 0, command = 0;
+	u32 irq_status, status_ack = 0, command = 0;
 	struct i2c_msg *msg;
 	u8 recv_byte;
 	int ret;
 
+	irq_status = readl(bus->base + ASPEED_I2C_INTR_STS_REG);
+	/* Ack all interrupt bits. */
+	writel(irq_status, bus->base + ASPEED_I2C_INTR_STS_REG);
+
 	if (irq_status & ASPEED_I2CD_INTR_BUS_RECOVER_DONE) {
 		bus->master_state = ASPEED_I2C_MASTER_INACTIVE;
-		irq_handled |= ASPEED_I2CD_INTR_BUS_RECOVER_DONE;
+		status_ack |= ASPEED_I2CD_INTR_BUS_RECOVER_DONE;
 		goto out_complete;
-	} else {
-		/* Master is not currently active, irq was for someone else. */
-		if (bus->master_state == ASPEED_I2C_MASTER_INACTIVE)
-			goto out_no_complete;
 	}
 
 	/*
@@ -395,22 +403,19 @@ static u32 aspeed_i2c_master_irq(struct aspeed_i2c_bus *bus, u32 irq_status)
 	 * INACTIVE state.
 	 */
 	ret = aspeed_i2c_is_irq_error(irq_status);
-	if (ret) {
+	if (ret < 0) {
 		dev_dbg(bus->dev, "received error interrupt: 0x%08x\n",
 			irq_status);
 		bus->cmd_err = ret;
 		bus->master_state = ASPEED_I2C_MASTER_INACTIVE;
-		irq_handled |= (irq_status & ASPEED_I2CD_INTR_MASTER_ERRORS);
 		goto out_complete;
 	}
 
 	/* We are in an invalid state; reset bus to a known state. */
 	if (!bus->msgs) {
-		dev_err(bus->dev, "bus in unknown state. irq_status: 0x%x\n",
-			irq_status);
+		dev_err(bus->dev, "bus in unknown state\n");
 		bus->cmd_err = -EIO;
-		if (bus->master_state != ASPEED_I2C_MASTER_STOP &&
-		    bus->master_state != ASPEED_I2C_MASTER_INACTIVE)
+		if (bus->master_state != ASPEED_I2C_MASTER_STOP)
 			aspeed_i2c_do_stop(bus);
 		goto out_no_complete;
 	}
@@ -423,18 +428,13 @@ static u32 aspeed_i2c_master_irq(struct aspeed_i2c_bus *bus, u32 irq_status)
 	 */
 	if (bus->master_state == ASPEED_I2C_MASTER_START) {
 		if (unlikely(!(irq_status & ASPEED_I2CD_INTR_TX_ACK))) {
-			if (unlikely(!(irq_status & ASPEED_I2CD_INTR_TX_NAK))) {
-				bus->cmd_err = -ENXIO;
-				bus->master_state = ASPEED_I2C_MASTER_INACTIVE;
-				goto out_complete;
-			}
 			pr_devel("no slave present at %02x\n", msg->addr);
-			irq_handled |= ASPEED_I2CD_INTR_TX_NAK;
+			status_ack |= ASPEED_I2CD_INTR_TX_NAK;
 			bus->cmd_err = -ENXIO;
 			aspeed_i2c_do_stop(bus);
 			goto out_no_complete;
 		}
-		irq_handled |= ASPEED_I2CD_INTR_TX_ACK;
+		status_ack |= ASPEED_I2CD_INTR_TX_ACK;
 		if (msg->len == 0) { /* SMBUS_QUICK */
 			aspeed_i2c_do_stop(bus);
 			goto out_no_complete;
@@ -449,13 +449,13 @@ static u32 aspeed_i2c_master_irq(struct aspeed_i2c_bus *bus, u32 irq_status)
 	case ASPEED_I2C_MASTER_TX:
 		if (unlikely(irq_status & ASPEED_I2CD_INTR_TX_NAK)) {
 			dev_dbg(bus->dev, "slave NACKed TX\n");
-			irq_handled |= ASPEED_I2CD_INTR_TX_NAK;
+			status_ack |= ASPEED_I2CD_INTR_TX_NAK;
 			goto error_and_stop;
 		} else if (unlikely(!(irq_status & ASPEED_I2CD_INTR_TX_ACK))) {
 			dev_err(bus->dev, "slave failed to ACK TX\n");
 			goto error_and_stop;
 		}
-		irq_handled |= ASPEED_I2CD_INTR_TX_ACK;
+		status_ack |= ASPEED_I2CD_INTR_TX_ACK;
 		/* fallthrough intended */
 	case ASPEED_I2C_MASTER_TX_FIRST:
 		if (bus->buf_index < msg->len) {
@@ -478,7 +478,7 @@ static u32 aspeed_i2c_master_irq(struct aspeed_i2c_bus *bus, u32 irq_status)
 			dev_err(bus->dev, "master failed to RX\n");
 			goto error_and_stop;
 		}
-		irq_handled |= ASPEED_I2CD_INTR_RX_DONE;
+		status_ack |= ASPEED_I2CD_INTR_RX_DONE;
 
 		recv_byte = readl(bus->base + ASPEED_I2C_BYTE_BUF_REG) >> 8;
 		msg->buf[bus->buf_index++] = recv_byte;
@@ -506,13 +506,11 @@ static u32 aspeed_i2c_master_irq(struct aspeed_i2c_bus *bus, u32 irq_status)
 		goto out_no_complete;
 	case ASPEED_I2C_MASTER_STOP:
 		if (unlikely(!(irq_status & ASPEED_I2CD_INTR_NORMAL_STOP))) {
-			dev_err(bus->dev,
-				"master failed to STOP. irq_status:0x%x\n",
-				irq_status);
+			dev_err(bus->dev, "master failed to STOP\n");
 			bus->cmd_err = -EIO;
 			/* Do not STOP as we have already tried. */
 		} else {
-			irq_handled |= ASPEED_I2CD_INTR_NORMAL_STOP;
+			status_ack |= ASPEED_I2CD_INTR_NORMAL_STOP;
 		}
 
 		bus->master_state = ASPEED_I2C_MASTER_INACTIVE;
@@ -542,52 +540,33 @@ static u32 aspeed_i2c_master_irq(struct aspeed_i2c_bus *bus, u32 irq_status)
 		bus->master_xfer_result = bus->msgs_index + 1;
 	complete(&bus->cmd_complete);
 out_no_complete:
-	return irq_handled;
+	if (irq_status != status_ack)
+		dev_err(bus->dev,
+			"irq handled != irq. expected 0x%08x, but was 0x%08x\n",
+			irq_status, status_ack);
+	return !!irq_status;
 }
 
 static irqreturn_t aspeed_i2c_bus_irq(int irq, void *dev_id)
 {
 	struct aspeed_i2c_bus *bus = dev_id;
-	u32 irq_received, irq_remaining, irq_handled;
+	bool ret;
 
 	spin_lock(&bus->lock);
-	irq_received = readl(bus->base + ASPEED_I2C_INTR_STS_REG);
-	irq_remaining = irq_received;
 
 #if IS_ENABLED(CONFIG_I2C_SLAVE)
-	/*
-	 * In most cases, interrupt bits will be set one by one, although
-	 * multiple interrupt bits could be set at the same time. It's also
-	 * possible that master interrupt bits could be set along with slave
-	 * interrupt bits. Each case needs to be handled using corresponding
-	 * handlers depending on the current state.
-	 */
-	if (bus->master_state != ASPEED_I2C_MASTER_INACTIVE) {
-		irq_handled = aspeed_i2c_master_irq(bus, irq_remaining);
-		irq_remaining &= ~irq_handled;
-		if (irq_remaining)
-			irq_handled |= aspeed_i2c_slave_irq(bus, irq_remaining);
-	} else {
-		irq_handled = aspeed_i2c_slave_irq(bus, irq_remaining);
-		irq_remaining &= ~irq_handled;
-		if (irq_remaining)
-			irq_handled |= aspeed_i2c_master_irq(bus,
-							     irq_remaining);
+	if (aspeed_i2c_slave_irq(bus)) {
+		dev_dbg(bus->dev, "irq handled by slave.\n");
+		ret = true;
+		goto out;
 	}
-#else
-	irq_handled = aspeed_i2c_master_irq(bus, irq_remaining);
 #endif /* CONFIG_I2C_SLAVE */
 
-	irq_remaining &= ~irq_handled;
-	if (irq_remaining)
-		dev_err(bus->dev,
-			"irq handled != irq. expected 0x%08x, but was 0x%08x\n",
-			irq_received, irq_handled);
+	ret = aspeed_i2c_master_irq(bus);
 
-	/* Ack all interrupt bits. */
-	writel(irq_received, bus->base + ASPEED_I2C_INTR_STS_REG);
+out:
 	spin_unlock(&bus->lock);
-	return irq_remaining ? IRQ_NONE : IRQ_HANDLED;
+	return ret ? IRQ_HANDLED : IRQ_NONE;
 }
 
 static int aspeed_i2c_master_xfer(struct i2c_adapter *adap,
-- 
2.18.0
