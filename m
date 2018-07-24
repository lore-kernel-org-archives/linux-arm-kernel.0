From: jae.hyun.yoo@linux.intel.com (Jae Hyun Yoo)
Date: Tue, 24 Jul 2018 10:31:23 -0700
Subject: [PATCH v2] i2c: aspeed: Handle master/slave combined irq events
 properly
Message-ID: <20180724173123.4377-1-jae.hyun.yoo@linux.intel.com>
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

Changes since v1:
- Fixed a grammer issue in commit message.
- Added a missing line feed character into a message printing.

Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
---
 drivers/i2c/busses/i2c-aspeed.c | 135 ++++++++++++++++++--------------
 1 file changed, 75 insertions(+), 60 deletions(-)

diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
index efb89422d496..75431e305073 100644
--- a/drivers/i2c/busses/i2c-aspeed.c
+++ b/drivers/i2c/busses/i2c-aspeed.c
@@ -82,6 +82,11 @@
 #define ASPEED_I2CD_INTR_RX_DONE			BIT(2)
 #define ASPEED_I2CD_INTR_TX_NAK				BIT(1)
 #define ASPEED_I2CD_INTR_TX_ACK				BIT(0)
+#define ASPEED_I2CD_INTR_ERRORS						       \
+		(ASPEED_I2CD_INTR_SDA_DL_TIMEOUT |			       \
+		 ASPEED_I2CD_INTR_SCL_TIMEOUT |				       \
+		 ASPEED_I2CD_INTR_ABNORMAL |				       \
+		 ASPEED_I2CD_INTR_ARBIT_LOSS)
 #define ASPEED_I2CD_INTR_ALL						       \
 		(ASPEED_I2CD_INTR_SDA_DL_TIMEOUT |			       \
 		 ASPEED_I2CD_INTR_BUS_RECOVER_DONE |			       \
@@ -150,6 +155,7 @@ struct aspeed_i2c_bus {
 	int				cmd_err;
 	/* Protected only by i2c_lock_bus */
 	int				master_xfer_result;
+	u32				irq_status;
 #if IS_ENABLED(CONFIG_I2C_SLAVE)
 	struct i2c_client		*slave;
 	enum aspeed_i2c_slave_state	slave_state;
@@ -229,36 +235,30 @@ static int aspeed_i2c_recover_bus(struct aspeed_i2c_bus *bus)
 #if IS_ENABLED(CONFIG_I2C_SLAVE)
 static bool aspeed_i2c_slave_irq(struct aspeed_i2c_bus *bus)
 {
-	u32 command, irq_status, status_ack = 0;
+	u32 command, status_ack = 0;
 	struct i2c_client *slave = bus->slave;
-	bool irq_handled = true;
 	u8 value;
 
-	if (!slave) {
-		irq_handled = false;
-		goto out;
-	}
+	if (!slave)
+		return false;
 
 	command = readl(bus->base + ASPEED_I2C_CMD_REG);
-	irq_status = readl(bus->base + ASPEED_I2C_INTR_STS_REG);
 
 	/* Slave was requested, restart state machine. */
-	if (irq_status & ASPEED_I2CD_INTR_SLAVE_MATCH) {
+	if (bus->irq_status & ASPEED_I2CD_INTR_SLAVE_MATCH) {
 		status_ack |= ASPEED_I2CD_INTR_SLAVE_MATCH;
 		bus->slave_state = ASPEED_I2C_SLAVE_START;
 	}
 
 	/* Slave is not currently active, irq was for someone else. */
-	if (bus->slave_state == ASPEED_I2C_SLAVE_STOP) {
-		irq_handled = false;
-		goto out;
-	}
+	if (bus->slave_state == ASPEED_I2C_SLAVE_STOP)
+		return false;
 
 	dev_dbg(bus->dev, "slave irq status 0x%08x, cmd 0x%08x\n",
-		irq_status, command);
+		bus->irq_status, command);
 
 	/* Slave was sent something. */
-	if (irq_status & ASPEED_I2CD_INTR_RX_DONE) {
+	if (bus->irq_status & ASPEED_I2CD_INTR_RX_DONE) {
 		value = readl(bus->base + ASPEED_I2C_BYTE_BUF_REG) >> 8;
 		/* Handle address frame. */
 		if (bus->slave_state == ASPEED_I2C_SLAVE_START) {
@@ -273,28 +273,29 @@ static bool aspeed_i2c_slave_irq(struct aspeed_i2c_bus *bus)
 	}
 
 	/* Slave was asked to stop. */
-	if (irq_status & ASPEED_I2CD_INTR_NORMAL_STOP) {
+	if (bus->irq_status & ASPEED_I2CD_INTR_NORMAL_STOP) {
 		status_ack |= ASPEED_I2CD_INTR_NORMAL_STOP;
 		bus->slave_state = ASPEED_I2C_SLAVE_STOP;
 	}
-	if (irq_status & ASPEED_I2CD_INTR_TX_NAK) {
+	if (bus->irq_status & ASPEED_I2CD_INTR_TX_NAK) {
 		status_ack |= ASPEED_I2CD_INTR_TX_NAK;
 		bus->slave_state = ASPEED_I2C_SLAVE_STOP;
 	}
+	if (bus->irq_status & ASPEED_I2CD_INTR_TX_ACK) {
+		status_ack |= ASPEED_I2CD_INTR_TX_ACK;
+	}
 
 	switch (bus->slave_state) {
 	case ASPEED_I2C_SLAVE_READ_REQUESTED:
-		if (irq_status & ASPEED_I2CD_INTR_TX_ACK)
+		if (bus->irq_status & ASPEED_I2CD_INTR_TX_ACK)
 			dev_err(bus->dev, "Unexpected ACK on read request.\n");
 		bus->slave_state = ASPEED_I2C_SLAVE_READ_PROCESSED;
-
 		i2c_slave_event(slave, I2C_SLAVE_READ_REQUESTED, &value);
 		writel(value, bus->base + ASPEED_I2C_BYTE_BUF_REG);
 		writel(ASPEED_I2CD_S_TX_CMD, bus->base + ASPEED_I2C_CMD_REG);
 		break;
 	case ASPEED_I2C_SLAVE_READ_PROCESSED:
-		status_ack |= ASPEED_I2CD_INTR_TX_ACK;
-		if (!(irq_status & ASPEED_I2CD_INTR_TX_ACK))
+		if (!(bus->irq_status & ASPEED_I2CD_INTR_TX_ACK))
 			dev_err(bus->dev,
 				"Expected ACK after processed read.\n");
 		i2c_slave_event(slave, I2C_SLAVE_READ_PROCESSED, &value);
@@ -317,14 +318,8 @@ static bool aspeed_i2c_slave_irq(struct aspeed_i2c_bus *bus)
 		break;
 	}
 
-	if (status_ack != irq_status)
-		dev_err(bus->dev,
-			"irq handled != irq. expected %x, but was %x\n",
-			irq_status, status_ack);
-	writel(status_ack, bus->base + ASPEED_I2C_INTR_STS_REG);
-
-out:
-	return irq_handled;
+	bus->irq_status ^= status_ack;
+	return !bus->irq_status;
 }
 #endif /* CONFIG_I2C_SLAVE */
 
@@ -382,19 +377,19 @@ static int aspeed_i2c_is_irq_error(u32 irq_status)
 
 static bool aspeed_i2c_master_irq(struct aspeed_i2c_bus *bus)
 {
-	u32 irq_status, status_ack = 0, command = 0;
+	u32 status_ack = 0, command = 0;
 	struct i2c_msg *msg;
 	u8 recv_byte;
 	int ret;
 
-	irq_status = readl(bus->base + ASPEED_I2C_INTR_STS_REG);
-	/* Ack all interrupt bits. */
-	writel(irq_status, bus->base + ASPEED_I2C_INTR_STS_REG);
-
-	if (irq_status & ASPEED_I2CD_INTR_BUS_RECOVER_DONE) {
+	if (bus->irq_status & ASPEED_I2CD_INTR_BUS_RECOVER_DONE) {
 		bus->master_state = ASPEED_I2C_MASTER_INACTIVE;
 		status_ack |= ASPEED_I2CD_INTR_BUS_RECOVER_DONE;
 		goto out_complete;
+	} else {
+		/* Master is not currently active, irq was for someone else. */
+		if (bus->master_state == ASPEED_I2C_MASTER_INACTIVE)
+			goto out_no_complete;
 	}
 
 	/*
@@ -402,20 +397,23 @@ static bool aspeed_i2c_master_irq(struct aspeed_i2c_bus *bus)
 	 * should clear the command queue effectively taking us back to the
 	 * INACTIVE state.
 	 */
-	ret = aspeed_i2c_is_irq_error(irq_status);
-	if (ret < 0) {
+	ret = aspeed_i2c_is_irq_error(bus->irq_status);
+	if (ret) {
 		dev_dbg(bus->dev, "received error interrupt: 0x%08x\n",
-			irq_status);
+			bus->irq_status);
 		bus->cmd_err = ret;
 		bus->master_state = ASPEED_I2C_MASTER_INACTIVE;
+		status_ack |= (bus->irq_status & ASPEED_I2CD_INTR_ERRORS);
 		goto out_complete;
 	}
 
 	/* We are in an invalid state; reset bus to a known state. */
 	if (!bus->msgs) {
-		dev_err(bus->dev, "bus in unknown state\n");
+		dev_err(bus->dev, "bus in unknown state irq_status: 0x%x\n",
+			bus->irq_status);
 		bus->cmd_err = -EIO;
-		if (bus->master_state != ASPEED_I2C_MASTER_STOP)
+		if (bus->master_state != ASPEED_I2C_MASTER_STOP &&
+		    bus->master_state != ASPEED_I2C_MASTER_INACTIVE)
 			aspeed_i2c_do_stop(bus);
 		goto out_no_complete;
 	}
@@ -427,7 +425,13 @@ static bool aspeed_i2c_master_irq(struct aspeed_i2c_bus *bus)
 	 * then update the state and handle the new state below.
 	 */
 	if (bus->master_state == ASPEED_I2C_MASTER_START) {
-		if (unlikely(!(irq_status & ASPEED_I2CD_INTR_TX_ACK))) {
+		if (unlikely(!(bus->irq_status & ASPEED_I2CD_INTR_TX_ACK))) {
+			if (unlikely(!(bus->irq_status &
+				     ASPEED_I2CD_INTR_TX_NAK))) {
+				bus->cmd_err = -ENXIO;
+				bus->master_state = ASPEED_I2C_MASTER_INACTIVE;
+				goto out_complete;
+			}
 			pr_devel("no slave present at %02x\n", msg->addr);
 			status_ack |= ASPEED_I2CD_INTR_TX_NAK;
 			bus->cmd_err = -ENXIO;
@@ -447,11 +451,12 @@ static bool aspeed_i2c_master_irq(struct aspeed_i2c_bus *bus)
 
 	switch (bus->master_state) {
 	case ASPEED_I2C_MASTER_TX:
-		if (unlikely(irq_status & ASPEED_I2CD_INTR_TX_NAK)) {
+		if (unlikely(bus->irq_status & ASPEED_I2CD_INTR_TX_NAK)) {
 			dev_dbg(bus->dev, "slave NACKed TX\n");
 			status_ack |= ASPEED_I2CD_INTR_TX_NAK;
 			goto error_and_stop;
-		} else if (unlikely(!(irq_status & ASPEED_I2CD_INTR_TX_ACK))) {
+		} else if (unlikely(!(bus->irq_status &
+				      ASPEED_I2CD_INTR_TX_ACK))) {
 			dev_err(bus->dev, "slave failed to ACK TX\n");
 			goto error_and_stop;
 		}
@@ -470,11 +475,11 @@ static bool aspeed_i2c_master_irq(struct aspeed_i2c_bus *bus)
 		goto out_no_complete;
 	case ASPEED_I2C_MASTER_RX_FIRST:
 		/* RX may not have completed yet (only address cycle) */
-		if (!(irq_status & ASPEED_I2CD_INTR_RX_DONE))
+		if (!(bus->irq_status & ASPEED_I2CD_INTR_RX_DONE))
 			goto out_no_complete;
 		/* fallthrough intended */
 	case ASPEED_I2C_MASTER_RX:
-		if (unlikely(!(irq_status & ASPEED_I2CD_INTR_RX_DONE))) {
+		if (unlikely(!(bus->irq_status & ASPEED_I2CD_INTR_RX_DONE))) {
 			dev_err(bus->dev, "master failed to RX\n");
 			goto error_and_stop;
 		}
@@ -505,8 +510,11 @@ static bool aspeed_i2c_master_irq(struct aspeed_i2c_bus *bus)
 		}
 		goto out_no_complete;
 	case ASPEED_I2C_MASTER_STOP:
-		if (unlikely(!(irq_status & ASPEED_I2CD_INTR_NORMAL_STOP))) {
-			dev_err(bus->dev, "master failed to STOP\n");
+		if (unlikely(!(bus->irq_status &
+			       ASPEED_I2CD_INTR_NORMAL_STOP))) {
+			dev_err(bus->dev,
+				"master failed to STOP irq_status:0x%x\n",
+				bus->irq_status);
 			bus->cmd_err = -EIO;
 			/* Do not STOP as we have already tried. */
 		} else {
@@ -518,7 +526,7 @@ static bool aspeed_i2c_master_irq(struct aspeed_i2c_bus *bus)
 	case ASPEED_I2C_MASTER_INACTIVE:
 		dev_err(bus->dev,
 			"master received interrupt 0x%08x, but is inactive\n",
-			irq_status);
+			bus->irq_status);
 		bus->cmd_err = -EIO;
 		/* Do not STOP as we should be inactive. */
 		goto out_complete;
@@ -540,33 +548,40 @@ static bool aspeed_i2c_master_irq(struct aspeed_i2c_bus *bus)
 		bus->master_xfer_result = bus->msgs_index + 1;
 	complete(&bus->cmd_complete);
 out_no_complete:
-	if (irq_status != status_ack)
-		dev_err(bus->dev,
-			"irq handled != irq. expected 0x%08x, but was 0x%08x\n",
-			irq_status, status_ack);
-	return !!irq_status;
+	bus->irq_status ^= status_ack;
+	return !bus->irq_status;
 }
 
 static irqreturn_t aspeed_i2c_bus_irq(int irq, void *dev_id)
 {
 	struct aspeed_i2c_bus *bus = dev_id;
-	bool ret;
+	u32 irq_received;
 
 	spin_lock(&bus->lock);
+	irq_received = readl(bus->base + ASPEED_I2C_INTR_STS_REG);
+	bus->irq_status = irq_received;
 
 #if IS_ENABLED(CONFIG_I2C_SLAVE)
-	if (aspeed_i2c_slave_irq(bus)) {
-		dev_dbg(bus->dev, "irq handled by slave.\n");
-		ret = true;
-		goto out;
+	if (bus->master_state != ASPEED_I2C_MASTER_INACTIVE) {
+		if (!aspeed_i2c_master_irq(bus))
+			aspeed_i2c_slave_irq(bus);
+	} else {
+		if (!aspeed_i2c_slave_irq(bus))
+			aspeed_i2c_master_irq(bus);
 	}
+#else
+	aspeed_i2c_master_irq(bus);
 #endif /* CONFIG_I2C_SLAVE */
 
-	ret = aspeed_i2c_master_irq(bus);
+	if (bus->irq_status)
+		dev_err(bus->dev,
+			"irq handled != irq. expected 0x%08x, but was 0x%08x\n",
+			irq_received, irq_received ^ bus->irq_status);
 
-out:
+	/* Ack all interrupt bits. */
+	writel(irq_received, bus->base + ASPEED_I2C_INTR_STS_REG);
 	spin_unlock(&bus->lock);
-	return ret ? IRQ_HANDLED : IRQ_NONE;
+	return bus->irq_status ? IRQ_NONE : IRQ_HANDLED;
 }
 
 static int aspeed_i2c_master_xfer(struct i2c_adapter *adap,
-- 
2.18.0
