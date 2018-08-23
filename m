From: jae.hyun.yoo@linux.intel.com (Jae Hyun Yoo)
Date: Thu, 23 Aug 2018 15:57:31 -0700
Subject: [PATCH i2c-next v6] i2c: aspeed: Handle master/slave combined irq
 events properly
Message-ID: <20180823225731.19063-1-jae.hyun.yoo@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In most of cases, interrupt bits are set one by one but there are
also a lot of other cases that Aspeed I2C IP sends multiple
interrupt bits with combining master and slave events using a
single interrupt call. It happens much more in multi-master
environment than single-master. For an example, when master is
waiting for a NORMAL_STOP interrupt in its MASTER_STOP state,
SLAVE_MATCH and RX_DONE interrupts could come along with the
NORMAL_STOP in case of an another master immediately sends data
just after acquiring the bus. In this case, the NORMAL_STOP
interrupt should be handled by master_irq and the SLAVE_MATCH and
RX_DONE interrupts should be handled by slave_irq. This commit
modifies irq hadling logic to handle the master/slave combined
events properly.

Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
---
Changes since v5:
- Changed variable names in irq hanlders to represent proper meaning.
- Fixed an error printing message again to make it use the irq_handled variable.

Changes since v4:
- Fixed an error printing message that handlers didn't handle all interrupts.

Changes since v3:
- Fixed typos in a comment.

Changes since v2:
- Changed the name of ASPEED_I2CD_INTR_ERRORS to ASPEED_I2CD_INTR_MASTER_ERRORS
- Removed a member irq_status from the struct aspeed_i2c_bus and changed
  master_irq and slave_irq handlers to make them return status_ack.
- Added a comment to explain why it needs to try both irq handlers.

Changes since v1:
- Fixed a grammar issue in commit message.
- Added a missing line feed character into a message printing.

 drivers/i2c/busses/i2c-aspeed.c | 131 ++++++++++++++++++--------------
 1 file changed, 76 insertions(+), 55 deletions(-)

diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
index a4f956c6d567..c258c4d9a4c0 100644
--- a/drivers/i2c/busses/i2c-aspeed.c
+++ b/drivers/i2c/busses/i2c-aspeed.c
@@ -82,6 +82,11 @@
 #define ASPEED_I2CD_INTR_RX_DONE			BIT(2)
 #define ASPEED_I2CD_INTR_TX_NAK				BIT(1)
 #define ASPEED_I2CD_INTR_TX_ACK				BIT(0)
+#define ASPEED_I2CD_INTR_MASTER_ERRORS					       \
+		(ASPEED_I2CD_INTR_SDA_DL_TIMEOUT |			       \
+		 ASPEED_I2CD_INTR_SCL_TIMEOUT |				       \
+		 ASPEED_I2CD_INTR_ABNORMAL |				       \
+		 ASPEED_I2CD_INTR_ARBIT_LOSS)
 #define ASPEED_I2CD_INTR_ALL						       \
 		(ASPEED_I2CD_INTR_SDA_DL_TIMEOUT |			       \
 		 ASPEED_I2CD_INTR_BUS_RECOVER_DONE |			       \
@@ -227,32 +232,26 @@ static int aspeed_i2c_recover_bus(struct aspeed_i2c_bus *bus)
 }
 
 #if IS_ENABLED(CONFIG_I2C_SLAVE)
-static bool aspeed_i2c_slave_irq(struct aspeed_i2c_bus *bus)
+static u32 aspeed_i2c_slave_irq(struct aspeed_i2c_bus *bus, u32 irq_status)
 {
-	u32 command, irq_status, status_ack = 0;
+	u32 command, irq_handled = 0;
 	struct i2c_client *slave = bus->slave;
-	bool irq_handled = true;
 	u8 value;
 
-	if (!slave) {
-		irq_handled = false;
-		goto out;
-	}
+	if (!slave)
+		return 0;
 
 	command = readl(bus->base + ASPEED_I2C_CMD_REG);
-	irq_status = readl(bus->base + ASPEED_I2C_INTR_STS_REG);
 
 	/* Slave was requested, restart state machine. */
 	if (irq_status & ASPEED_I2CD_INTR_SLAVE_MATCH) {
-		status_ack |= ASPEED_I2CD_INTR_SLAVE_MATCH;
+		irq_handled |= ASPEED_I2CD_INTR_SLAVE_MATCH;
 		bus->slave_state = ASPEED_I2C_SLAVE_START;
 	}
 
 	/* Slave is not currently active, irq was for someone else. */
-	if (bus->slave_state == ASPEED_I2C_SLAVE_STOP) {
-		irq_handled = false;
-		goto out;
-	}
+	if (bus->slave_state == ASPEED_I2C_SLAVE_STOP)
+		return irq_handled;
 
 	dev_dbg(bus->dev, "slave irq status 0x%08x, cmd 0x%08x\n",
 		irq_status, command);
@@ -269,31 +268,31 @@ static bool aspeed_i2c_slave_irq(struct aspeed_i2c_bus *bus)
 				bus->slave_state =
 						ASPEED_I2C_SLAVE_WRITE_REQUESTED;
 		}
-		status_ack |= ASPEED_I2CD_INTR_RX_DONE;
+		irq_handled |= ASPEED_I2CD_INTR_RX_DONE;
 	}
 
 	/* Slave was asked to stop. */
 	if (irq_status & ASPEED_I2CD_INTR_NORMAL_STOP) {
-		status_ack |= ASPEED_I2CD_INTR_NORMAL_STOP;
+		irq_handled |= ASPEED_I2CD_INTR_NORMAL_STOP;
 		bus->slave_state = ASPEED_I2C_SLAVE_STOP;
 	}
 	if (irq_status & ASPEED_I2CD_INTR_TX_NAK) {
-		status_ack |= ASPEED_I2CD_INTR_TX_NAK;
+		irq_handled |= ASPEED_I2CD_INTR_TX_NAK;
 		bus->slave_state = ASPEED_I2C_SLAVE_STOP;
 	}
+	if (irq_status & ASPEED_I2CD_INTR_TX_ACK)
+		irq_handled |= ASPEED_I2CD_INTR_TX_ACK;
 
 	switch (bus->slave_state) {
 	case ASPEED_I2C_SLAVE_READ_REQUESTED:
 		if (irq_status & ASPEED_I2CD_INTR_TX_ACK)
 			dev_err(bus->dev, "Unexpected ACK on read request.\n");
 		bus->slave_state = ASPEED_I2C_SLAVE_READ_PROCESSED;
-
 		i2c_slave_event(slave, I2C_SLAVE_READ_REQUESTED, &value);
 		writel(value, bus->base + ASPEED_I2C_BYTE_BUF_REG);
 		writel(ASPEED_I2CD_S_TX_CMD, bus->base + ASPEED_I2C_CMD_REG);
 		break;
 	case ASPEED_I2C_SLAVE_READ_PROCESSED:
-		status_ack |= ASPEED_I2CD_INTR_TX_ACK;
 		if (!(irq_status & ASPEED_I2CD_INTR_TX_ACK))
 			dev_err(bus->dev,
 				"Expected ACK after processed read.\n");
@@ -317,13 +316,6 @@ static bool aspeed_i2c_slave_irq(struct aspeed_i2c_bus *bus)
 		break;
 	}
 
-	if (status_ack != irq_status)
-		dev_err(bus->dev,
-			"irq handled != irq. expected %x, but was %x\n",
-			irq_status, status_ack);
-	writel(status_ack, bus->base + ASPEED_I2C_INTR_STS_REG);
-
-out:
 	return irq_handled;
 }
 #endif /* CONFIG_I2C_SLAVE */
@@ -380,21 +372,21 @@ static int aspeed_i2c_is_irq_error(u32 irq_status)
 	return 0;
 }
 
-static bool aspeed_i2c_master_irq(struct aspeed_i2c_bus *bus)
+static u32 aspeed_i2c_master_irq(struct aspeed_i2c_bus *bus, u32 irq_status)
 {
-	u32 irq_status, status_ack = 0, command = 0;
+	u32 irq_handled = 0, command = 0;
 	struct i2c_msg *msg;
 	u8 recv_byte;
 	int ret;
 
-	irq_status = readl(bus->base + ASPEED_I2C_INTR_STS_REG);
-	/* Ack all interrupt bits. */
-	writel(irq_status, bus->base + ASPEED_I2C_INTR_STS_REG);
-
 	if (irq_status & ASPEED_I2CD_INTR_BUS_RECOVER_DONE) {
 		bus->master_state = ASPEED_I2C_MASTER_INACTIVE;
-		status_ack |= ASPEED_I2CD_INTR_BUS_RECOVER_DONE;
+		irq_handled |= ASPEED_I2CD_INTR_BUS_RECOVER_DONE;
 		goto out_complete;
+	} else {
+		/* Master is not currently active, irq was for someone else. */
+		if (bus->master_state == ASPEED_I2C_MASTER_INACTIVE)
+			goto out_no_complete;
 	}
 
 	/*
@@ -403,19 +395,22 @@ static bool aspeed_i2c_master_irq(struct aspeed_i2c_bus *bus)
 	 * INACTIVE state.
 	 */
 	ret = aspeed_i2c_is_irq_error(irq_status);
-	if (ret < 0) {
+	if (ret) {
 		dev_dbg(bus->dev, "received error interrupt: 0x%08x\n",
 			irq_status);
 		bus->cmd_err = ret;
 		bus->master_state = ASPEED_I2C_MASTER_INACTIVE;
+		irq_handled |= (irq_status & ASPEED_I2CD_INTR_MASTER_ERRORS);
 		goto out_complete;
 	}
 
 	/* We are in an invalid state; reset bus to a known state. */
 	if (!bus->msgs) {
-		dev_err(bus->dev, "bus in unknown state\n");
+		dev_err(bus->dev, "bus in unknown state. irq_status: 0x%x\n",
+			irq_status);
 		bus->cmd_err = -EIO;
-		if (bus->master_state != ASPEED_I2C_MASTER_STOP)
+		if (bus->master_state != ASPEED_I2C_MASTER_STOP &&
+		    bus->master_state != ASPEED_I2C_MASTER_INACTIVE)
 			aspeed_i2c_do_stop(bus);
 		goto out_no_complete;
 	}
@@ -428,13 +423,18 @@ static bool aspeed_i2c_master_irq(struct aspeed_i2c_bus *bus)
 	 */
 	if (bus->master_state == ASPEED_I2C_MASTER_START) {
 		if (unlikely(!(irq_status & ASPEED_I2CD_INTR_TX_ACK))) {
+			if (unlikely(!(irq_status & ASPEED_I2CD_INTR_TX_NAK))) {
+				bus->cmd_err = -ENXIO;
+				bus->master_state = ASPEED_I2C_MASTER_INACTIVE;
+				goto out_complete;
+			}
 			pr_devel("no slave present at %02x\n", msg->addr);
-			status_ack |= ASPEED_I2CD_INTR_TX_NAK;
+			irq_handled |= ASPEED_I2CD_INTR_TX_NAK;
 			bus->cmd_err = -ENXIO;
 			aspeed_i2c_do_stop(bus);
 			goto out_no_complete;
 		}
-		status_ack |= ASPEED_I2CD_INTR_TX_ACK;
+		irq_handled |= ASPEED_I2CD_INTR_TX_ACK;
 		if (msg->len == 0) { /* SMBUS_QUICK */
 			aspeed_i2c_do_stop(bus);
 			goto out_no_complete;
@@ -449,13 +449,13 @@ static bool aspeed_i2c_master_irq(struct aspeed_i2c_bus *bus)
 	case ASPEED_I2C_MASTER_TX:
 		if (unlikely(irq_status & ASPEED_I2CD_INTR_TX_NAK)) {
 			dev_dbg(bus->dev, "slave NACKed TX\n");
-			status_ack |= ASPEED_I2CD_INTR_TX_NAK;
+			irq_handled |= ASPEED_I2CD_INTR_TX_NAK;
 			goto error_and_stop;
 		} else if (unlikely(!(irq_status & ASPEED_I2CD_INTR_TX_ACK))) {
 			dev_err(bus->dev, "slave failed to ACK TX\n");
 			goto error_and_stop;
 		}
-		status_ack |= ASPEED_I2CD_INTR_TX_ACK;
+		irq_handled |= ASPEED_I2CD_INTR_TX_ACK;
 		/* fallthrough intended */
 	case ASPEED_I2C_MASTER_TX_FIRST:
 		if (bus->buf_index < msg->len) {
@@ -478,7 +478,7 @@ static bool aspeed_i2c_master_irq(struct aspeed_i2c_bus *bus)
 			dev_err(bus->dev, "master failed to RX\n");
 			goto error_and_stop;
 		}
-		status_ack |= ASPEED_I2CD_INTR_RX_DONE;
+		irq_handled |= ASPEED_I2CD_INTR_RX_DONE;
 
 		recv_byte = readl(bus->base + ASPEED_I2C_BYTE_BUF_REG) >> 8;
 		msg->buf[bus->buf_index++] = recv_byte;
@@ -506,11 +506,13 @@ static bool aspeed_i2c_master_irq(struct aspeed_i2c_bus *bus)
 		goto out_no_complete;
 	case ASPEED_I2C_MASTER_STOP:
 		if (unlikely(!(irq_status & ASPEED_I2CD_INTR_NORMAL_STOP))) {
-			dev_err(bus->dev, "master failed to STOP\n");
+			dev_err(bus->dev,
+				"master failed to STOP. irq_status:0x%x\n",
+				irq_status);
 			bus->cmd_err = -EIO;
 			/* Do not STOP as we have already tried. */
 		} else {
-			status_ack |= ASPEED_I2CD_INTR_NORMAL_STOP;
+			irq_handled |= ASPEED_I2CD_INTR_NORMAL_STOP;
 		}
 
 		bus->master_state = ASPEED_I2C_MASTER_INACTIVE;
@@ -540,33 +542,52 @@ static bool aspeed_i2c_master_irq(struct aspeed_i2c_bus *bus)
 		bus->master_xfer_result = bus->msgs_index + 1;
 	complete(&bus->cmd_complete);
 out_no_complete:
-	if (irq_status != status_ack)
-		dev_err(bus->dev,
-			"irq handled != irq. expected 0x%08x, but was 0x%08x\n",
-			irq_status, status_ack);
-	return !!irq_status;
+	return irq_handled;
 }
 
 static irqreturn_t aspeed_i2c_bus_irq(int irq, void *dev_id)
 {
 	struct aspeed_i2c_bus *bus = dev_id;
-	bool ret;
+	u32 irq_received, irq_remaining, irq_handled;
 
 	spin_lock(&bus->lock);
+	irq_received = readl(bus->base + ASPEED_I2C_INTR_STS_REG);
+	irq_remaining = irq_received;
 
 #if IS_ENABLED(CONFIG_I2C_SLAVE)
-	if (aspeed_i2c_slave_irq(bus)) {
-		dev_dbg(bus->dev, "irq handled by slave.\n");
-		ret = true;
-		goto out;
+	/*
+	 * In most cases, interrupt bits will be set one by one, although
+	 * multiple interrupt bits could be set at the same time. It's also
+	 * possible that master interrupt bits could be set along with slave
+	 * interrupt bits. Each case needs to be handled using corresponding
+	 * handlers depending on the current state.
+	 */
+	if (bus->master_state != ASPEED_I2C_MASTER_INACTIVE) {
+		irq_handled = aspeed_i2c_master_irq(bus, irq_remaining);
+		irq_remaining &= ~irq_handled;
+		if (irq_remaining)
+			irq_handled |= aspeed_i2c_slave_irq(bus, irq_remaining);
+	} else {
+		irq_handled = aspeed_i2c_slave_irq(bus, irq_remaining);
+		irq_remaining &= ~irq_handled;
+		if (irq_remaining)
+			irq_handled |= aspeed_i2c_master_irq(bus,
+							     irq_remaining);
 	}
+#else
+	irq_handled = aspeed_i2c_master_irq(bus, irq_remaining);
 #endif /* CONFIG_I2C_SLAVE */
 
-	ret = aspeed_i2c_master_irq(bus);
+	irq_remaining &= ~irq_handled;
+	if (irq_remaining)
+		dev_err(bus->dev,
+			"irq handled != irq. expected 0x%08x, but was 0x%08x\n",
+			irq_received, irq_handled);
 
-out:
+	/* Ack all interrupt bits. */
+	writel(irq_received, bus->base + ASPEED_I2C_INTR_STS_REG);
 	spin_unlock(&bus->lock);
-	return ret ? IRQ_HANDLED : IRQ_NONE;
+	return irq_remaining ? IRQ_NONE : IRQ_HANDLED;
 }
 
 static int aspeed_i2c_master_xfer(struct i2c_adapter *adap,
-- 
2.18.0
