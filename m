From: noralf@tronnes.org (=?UTF-8?q?Noralf=20Tr=C3=B8nnes?=)
Date: Mon, 19 Sep 2016 17:26:16 +0200
Subject: [PATCH 2/3] i2c: bcm2835: Add support for combined write-read transfer
In-Reply-To: <1474298777-5858-1-git-send-email-noralf@tronnes.org>
References: <1474298777-5858-1-git-send-email-noralf@tronnes.org>
Message-ID: <1474298777-5858-2-git-send-email-noralf@tronnes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some SMBus protocols use Repeated Start Condition to switch from write
mode to read mode. Devices like MMA8451 won't work without it.

When downstream implemented support for this in i2c-bcm2708, it broke
support for some devices, so a module parameter was added and combined
transfer was disabled by default.
See https://github.com/raspberrypi/linux/issues/599
It doesn't seem to have been any investigation into what the problem
really was. Later there was added a timeout on the polling loop.

One of the devices mentioned to partially stop working was DS1307.

I have run thousands of transfers to a DS1307 (rtc), MMA8451 (accel)
and AT24C32 (eeprom) in parallel without problems.

Signed-off-by: Noralf Tr?nnes <noralf@tronnes.org>
---
 drivers/i2c/busses/i2c-bcm2835.c | 107 +++++++++++++++++++++++++++++++++++----
 1 file changed, 98 insertions(+), 9 deletions(-)

diff --git a/drivers/i2c/busses/i2c-bcm2835.c b/drivers/i2c/busses/i2c-bcm2835.c
index f283b71..b3ce565 100644
--- a/drivers/i2c/busses/i2c-bcm2835.c
+++ b/drivers/i2c/busses/i2c-bcm2835.c
@@ -154,8 +154,39 @@ static irqreturn_t bcm2835_i2c_isr(int this_irq, void *data)
 	return IRQ_NONE;
 }
 
+/*
+ * Repeated Start Condition (Sr)
+ * The BCM2835 ARM Peripherals datasheet mentions a way to trigger a Sr when it
+ * talks about reading from a slave with 10 bit address. This is achieved by
+ * issuing a write (without enabling interrupts), poll the I2CS.TA flag and
+ * wait for it to be set, and then issue a read.
+ * https://github.com/raspberrypi/linux/issues/254 shows how the firmware does
+ * it and states that it's a workaround for a problem in the state machine.
+ * This is the comment in the firmware code:
+ *
+ *     The I2C peripheral samples the values for rw_bit and xfer_count in the
+ *     IDLE state if start is set.
+ *
+ *     We want to generate a ReSTART not a STOP at the end of the TX phase. In
+ *     order to do that we must ensure the state machine goes
+ *     RACK1 -> RACK2 -> SRSTRT1 (not RACK1 -> RACK2 -> SSTOP1).
+ *
+ *     So, in the RACK2 state when (TX) xfer_count==0 we must therefore have
+ *     already set, ready to be sampled:
+ *     READ; rw_bit     <= I2CC bit 0 - must be "read"
+ *     ST;   start      <= I2CC bit 7 - must be "Go" in order to not issue STOP
+ *     DLEN; xfer_count <= I2CDLEN    - must be equal to our read amount
+ *
+ *     The plan to do this is:
+ *     1. Start the sub-address write, but don't let it finish (keep
+ *        xfer_count > 0)
+ *     2. Populate READ, DLEN and ST in preparation for ReSTART read sequence
+ *     3. Let TX finish (write the rest of the data)
+ *     4. Read back data as it arrives
+ */
+
 static int bcm2835_i2c_xfer_msg(struct bcm2835_i2c_dev *i2c_dev,
-				struct i2c_msg *msg)
+				struct i2c_msg *msg, struct i2c_msg *msg2)
 {
 	u32 c;
 	unsigned long time_left;
@@ -167,21 +198,70 @@ static int bcm2835_i2c_xfer_msg(struct bcm2835_i2c_dev *i2c_dev,
 
 	bcm2835_i2c_writel(i2c_dev, BCM2835_I2C_C, BCM2835_I2C_C_CLEAR);
 
-	if (msg->flags & I2C_M_RD) {
-		c = BCM2835_I2C_C_READ | BCM2835_I2C_C_INTR;
-	} else {
-		c = BCM2835_I2C_C_INTT;
+	if (!(msg->flags & I2C_M_RD))
 		bcm2835_fill_txfifo(i2c_dev);
-	}
-	c |= BCM2835_I2C_C_ST | BCM2835_I2C_C_INTD | BCM2835_I2C_C_I2CEN;
 
 	bcm2835_i2c_writel(i2c_dev, BCM2835_I2C_A, msg->addr);
 	bcm2835_i2c_writel(i2c_dev, BCM2835_I2C_DLEN, msg->len);
-	bcm2835_i2c_writel(i2c_dev, BCM2835_I2C_C, c);
+
+	if (!msg2) {
+		if (msg->flags & I2C_M_RD)
+			c = BCM2835_I2C_C_READ | BCM2835_I2C_C_INTR;
+		else
+			c = BCM2835_I2C_C_INTT;
+
+		c |= BCM2835_I2C_C_ST | BCM2835_I2C_C_INTD |
+		     BCM2835_I2C_C_I2CEN;
+		bcm2835_i2c_writel(i2c_dev, BCM2835_I2C_C, c);
+	} else {
+		unsigned long flags;
+		u32 stat, err = 0;
+
+		local_irq_save(flags);
+
+		/* Start write message */
+		c = BCM2835_I2C_C_ST | BCM2835_I2C_C_I2CEN;
+		bcm2835_i2c_writel(i2c_dev, BCM2835_I2C_C, c);
+
+		/* Wait for the transfer to become active */
+		for (time_left = 100; time_left > 0; time_left--) {
+			stat = bcm2835_i2c_readl(i2c_dev, BCM2835_I2C_S);
+
+			err = stat & (BCM2835_I2C_S_CLKT | BCM2835_I2C_S_ERR);
+			if (err)
+				break;
+
+			if (stat & BCM2835_I2C_S_TA)
+				break;
+		}
+
+		if (err || !time_left) {
+			i2c_dev->msg_err = err;
+			local_irq_restore(flags);
+			goto error;
+		}
+
+		/* Start read message */
+		i2c_dev->curr_msg = msg2;
+		i2c_dev->msg_buf = msg2->buf;
+		i2c_dev->msg_buf_remaining = msg2->len;
+		bcm2835_i2c_writel(i2c_dev, BCM2835_I2C_DLEN, msg2->len);
+
+		c = BCM2835_I2C_C_READ | BCM2835_I2C_C_INTR |
+		    BCM2835_I2C_C_INTD | BCM2835_I2C_C_ST |
+		    BCM2835_I2C_C_I2CEN;
+
+		bcm2835_i2c_writel(i2c_dev, BCM2835_I2C_C, c);
+
+		local_irq_restore(flags);
+	}
 
 	time_left = wait_for_completion_timeout(&i2c_dev->completion,
 						BCM2835_I2C_TIMEOUT);
+error:
 	bcm2835_i2c_writel(i2c_dev, BCM2835_I2C_C, BCM2835_I2C_C_CLEAR);
+	bcm2835_i2c_writel(i2c_dev, BCM2835_I2C_S, BCM2835_I2C_S_CLKT |
+			   BCM2835_I2C_S_ERR | BCM2835_I2C_S_DONE);
 	if (!time_left) {
 		dev_err(i2c_dev->dev, "i2c transfer timed out\n");
 		return -ETIMEDOUT;
@@ -209,8 +289,17 @@ static int bcm2835_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[],
 	int i;
 	int ret = 0;
 
+	/* Combined write-read to the same address (smbus) */
+	if (num == 2 && (msgs[0].addr == msgs[1].addr) &&
+	    !(msgs[0].flags & I2C_M_RD) && (msgs[1].flags & I2C_M_RD) &&
+	    (msgs[0].len <= 16)) {
+		ret = bcm2835_i2c_xfer_msg(i2c_dev, &msgs[0], &msgs[1]);
+
+		return ret ? ret : 2;
+	}
+
 	for (i = 0; i < num; i++) {
-		ret = bcm2835_i2c_xfer_msg(i2c_dev, &msgs[i]);
+		ret = bcm2835_i2c_xfer_msg(i2c_dev, &msgs[i], NULL);
 		if (ret)
 			break;
 	}
-- 
2.8.2
