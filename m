From: jae.hyun.yoo@linux.intel.com (Jae Hyun Yoo)
Date: Mon, 29 Oct 2018 14:14:14 -0700
Subject: [PATCH i2c-next v8 5/5] i2c: aspeed: Add bus idle waiting logic for
 multi-master use cases
In-Reply-To: <20181029211414.20771-1-jae.hyun.yoo@linux.intel.com>
References: <20181029211414.20771-1-jae.hyun.yoo@linux.intel.com>
Message-ID: <20181029211414.20771-6-jae.hyun.yoo@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In multi-master environment, this driver's master cannot know
exactly when a peer master sends data to this driver's slave so a
case can be happened that this master tries to send data through
the master_xfer function but slave data from peer master is still
being processed by this driver.

To prevent any state corruption in the case, this patch adds
checking code if any slave operation is ongoing and it waits up to
the bus timeout duration before starting a master_xfer operation.

Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
---
 drivers/i2c/busses/i2c-aspeed.c | 52 +++++++++++++++++++++++----------
 1 file changed, 37 insertions(+), 15 deletions(-)

diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
index 833b6b6a4c7e..4e92a405210b 100644
--- a/drivers/i2c/busses/i2c-aspeed.c
+++ b/drivers/i2c/busses/i2c-aspeed.c
@@ -12,6 +12,7 @@
 
 #include <linux/clk.h>
 #include <linux/completion.h>
+#include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/errno.h>
 #include <linux/i2c.h>
@@ -115,6 +116,9 @@
 /* 0x18 : I2CD Slave Device Address Register   */
 #define ASPEED_I2CD_DEV_ADDR_MASK			GENMASK(6, 0)
 
+/* Busy checking */
+#define ASPEED_I2C_BUS_BUSY_CHECK_INTERVAL_US		(10 * 1000)
+
 enum aspeed_i2c_master_state {
 	ASPEED_I2C_MASTER_INACTIVE,
 	ASPEED_I2C_MASTER_START,
@@ -156,6 +160,8 @@ struct aspeed_i2c_bus {
 	int				cmd_err;
 	/* Protected only by i2c_lock_bus */
 	int				master_xfer_result;
+	/* Multi-master */
+	bool				multi_master;
 #if IS_ENABLED(CONFIG_I2C_SLAVE)
 	struct i2c_client		*slave;
 	enum aspeed_i2c_slave_state	slave_state;
@@ -596,27 +602,41 @@ static irqreturn_t aspeed_i2c_bus_irq(int irq, void *dev_id)
 	return irq_remaining ? IRQ_NONE : IRQ_HANDLED;
 }
 
+static int aspeed_i2c_check_bus_busy(struct aspeed_i2c_bus *bus)
+{
+	unsigned long check_started;
+
+	if (bus->multi_master) {
+		might_sleep();
+		check_started = jiffies;
+	}
+
+	for (;;) {
+		if (!(readl(bus->base + ASPEED_I2C_CMD_REG) &
+		      ASPEED_I2CD_BUS_BUSY_STS) &&
+		    bus->slave_state == ASPEED_I2C_SLAVE_STOP)
+			return 0;
+		if (!bus->multi_master)
+			break;
+		if (time_after(jiffies, check_started + bus->adap.timeout))
+			break;
+		usleep_range((ASPEED_I2C_BUS_BUSY_CHECK_INTERVAL_US >> 2) + 1,
+			     ASPEED_I2C_BUS_BUSY_CHECK_INTERVAL_US);
+	}
+
+	return aspeed_i2c_recover_bus(bus);
+}
+
 static int aspeed_i2c_master_xfer(struct i2c_adapter *adap,
 				  struct i2c_msg *msgs, int num)
 {
 	struct aspeed_i2c_bus *bus = i2c_get_adapdata(adap);
 	unsigned long time_left, flags;
-	int ret = 0;
 
-	spin_lock_irqsave(&bus->lock, flags);
-	bus->cmd_err = 0;
-
-	/* If bus is busy, attempt recovery. We assume a single master
-	 * environment.
-	 */
-	if (readl(bus->base + ASPEED_I2C_CMD_REG) & ASPEED_I2CD_BUS_BUSY_STS) {
-		spin_unlock_irqrestore(&bus->lock, flags);
-		ret = aspeed_i2c_recover_bus(bus);
-		if (ret)
-			return ret;
-		spin_lock_irqsave(&bus->lock, flags);
-	}
+	if (aspeed_i2c_check_bus_busy(bus))
+		return -EAGAIN;
 
+	spin_lock_irqsave(&bus->lock, flags);
 	bus->cmd_err = 0;
 	bus->msgs = msgs;
 	bus->msgs_index = 0;
@@ -827,7 +847,9 @@ static int aspeed_i2c_init(struct aspeed_i2c_bus *bus,
 	if (ret < 0)
 		return ret;
 
-	if (!of_property_read_bool(pdev->dev.of_node, "multi-master"))
+	if (of_property_read_bool(pdev->dev.of_node, "multi-master"))
+		bus->multi_master = true;
+	else
 		fun_ctrl_reg |= ASPEED_I2CD_MULTI_MASTER_DIS;
 
 	/* Enable Master Mode */
-- 
2.19.1
