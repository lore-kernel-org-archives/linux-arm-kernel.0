From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 02 Jan 2010 11:21:50 +0000
Subject: [PATCH 16/18] ARM: PNX4008: i2c-pnx: don't split messages across
	several lines
In-Reply-To: <20100102111849.GA2529@n2100.arm.linux.org.uk>
References: <20100102111849.GA2529@n2100.arm.linux.org.uk>
Message-ID: <16d6258a79def9009ccb317960b48a391518a711.1262431163.git.rmk+kernel@arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It makes them harder to grep for.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/i2c/busses/i2c-pnx.c |   81 +++++++++++++++++++++++-------------------
 1 files changed, 44 insertions(+), 37 deletions(-)

diff --git a/drivers/i2c/busses/i2c-pnx.c b/drivers/i2c/busses/i2c-pnx.c
index da11ade..a71cd93 100644
--- a/drivers/i2c/busses/i2c-pnx.c
+++ b/drivers/i2c/busses/i2c-pnx.c
@@ -86,25 +86,26 @@ static int i2c_pnx_start(unsigned char slave_addr,
 
 	/* Check for 7 bit slave addresses only */
 	if (slave_addr & ~0x7f) {
-		dev_err(&alg_data->adapter.dev, "%s: Invalid slave address %x. "
-		       "Only 7-bit addresses are supported\n",
-		       alg_data->adapter.name, slave_addr);
+		dev_err(&alg_data->adapter.dev,
+			"%s: Invalid slave address %x. Only 7-bit addresses are supported\n",
+			alg_data->adapter.name, slave_addr);
 		return -EINVAL;
 	}
 
 	/* First, make sure bus is idle */
 	if (wait_timeout(I2C_PNX_TIMEOUT, alg_data)) {
 		/* Somebody else is monopolizing the bus */
-		dev_err(&alg_data->adapter.dev, "%s: Bus busy. Slave addr = %02x, "
-		       "cntrl = %x, stat = %x\n",
-		       alg_data->adapter.name, slave_addr,
-		       ioread32(I2C_REG_CTL(alg_data)),
-		       ioread32(I2C_REG_STS(alg_data)));
+		dev_err(&alg_data->adapter.dev,
+			"%s: Bus busy. Slave addr = %02x, cntrl = %x, stat = %x\n",
+			alg_data->adapter.name, slave_addr,
+			ioread32(I2C_REG_CTL(alg_data)),
+			ioread32(I2C_REG_STS(alg_data)));
 		return -EBUSY;
 	} else if (ioread32(I2C_REG_STS(alg_data)) & mstatus_afi) {
 		/* Sorry, we lost the bus */
-		dev_err(&alg_data->adapter.dev, "%s: Arbitration failure. "
-		       "Slave addr = %02x\n", alg_data->adapter.name, slave_addr);
+		dev_err(&alg_data->adapter.dev,
+		        "%s: Arbitration failure. Slave addr = %02x\n",
+			alg_data->adapter.name, slave_addr);
 		return -EIO;
 	}
 
@@ -182,15 +183,15 @@ static int i2c_pnx_master_xmit(struct i2c_pnx_algo_data *alg_data)
 		alg_data->mif.len--;
 		iowrite32(val, I2C_REG_TX(alg_data));
 
-		dev_dbg(&alg_data->adapter.dev, "%s(): xmit %#x [%d]\n", __func__,
-			val, alg_data->mif.len + 1);
+		dev_dbg(&alg_data->adapter.dev, "%s(): xmit %#x [%d]\n",
+			__func__, val, alg_data->mif.len + 1);
 
 		if (alg_data->mif.len == 0) {
 			if (alg_data->last) {
 				/* Wait until the STOP is seen. */
 				if (wait_timeout(I2C_PNX_TIMEOUT, alg_data))
-					dev_err(&alg_data->adapter.dev, "The bus is still "
-						"active after timeout\n");
+					dev_err(&alg_data->adapter.dev,
+						"The bus is still active after timeout\n");
 			}
 			/* Disable master interrupts */
 			iowrite32(ioread32(I2C_REG_CTL(alg_data)) &
@@ -199,7 +200,8 @@ static int i2c_pnx_master_xmit(struct i2c_pnx_algo_data *alg_data)
 
 			del_timer_sync(&alg_data->mif.timer);
 
-			dev_dbg(&alg_data->adapter.dev, "%s(): Waking up xfer routine.\n",
+			dev_dbg(&alg_data->adapter.dev,
+				"%s(): Waking up xfer routine.\n",
 				__func__);
 
 			complete(&alg_data->mif.complete);
@@ -215,8 +217,9 @@ static int i2c_pnx_master_xmit(struct i2c_pnx_algo_data *alg_data)
 
 		/* Stop timer. */
 		del_timer_sync(&alg_data->mif.timer);
-		dev_dbg(&alg_data->adapter.dev, "%s(): Waking up xfer routine after "
-			"zero-xfer.\n", __func__);
+		dev_dbg(&alg_data->adapter.dev,
+			"%s(): Waking up xfer routine after zero-xfer.\n",
+			__func__);
 
 		complete(&alg_data->mif.complete);
 	}
@@ -245,8 +248,9 @@ static int i2c_pnx_master_rcv(struct i2c_pnx_algo_data *alg_data)
 	 * or we didn't 'ask' for it yet.
 	 */
 	if (ioread32(I2C_REG_STS(alg_data)) & mstatus_rfe) {
-		dev_dbg(&alg_data->adapter.dev, "%s(): Write dummy data to fill "
-			"Rx-fifo...\n", __func__);
+		dev_dbg(&alg_data->adapter.dev,
+			"%s(): Write dummy data to fill Rx-fifo...\n",
+			__func__);
 
 		if (alg_data->mif.len == 1) {
 			/* Last byte, do not acknowledge next rcv. */
@@ -278,16 +282,16 @@ static int i2c_pnx_master_rcv(struct i2c_pnx_algo_data *alg_data)
 	if (alg_data->mif.len > 0) {
 		val = ioread32(I2C_REG_RX(alg_data));
 		*alg_data->mif.buf++ = (u8) (val & 0xff);
-		dev_dbg(&alg_data->adapter.dev, "%s(): rcv 0x%x [%d]\n", __func__, val,
-			alg_data->mif.len);
+		dev_dbg(&alg_data->adapter.dev, "%s(): rcv 0x%x [%d]\n",
+			__func__, val, alg_data->mif.len);
 
 		alg_data->mif.len--;
 		if (alg_data->mif.len == 0) {
 			if (alg_data->last)
 				/* Wait until the STOP is seen. */
 				if (wait_timeout(I2C_PNX_TIMEOUT, alg_data))
-					dev_err(&alg_data->adapter.dev, "The bus is still "
-						"active after timeout\n");
+					dev_err(&alg_data->adapter.dev,
+						"The bus is still active after timeout\n");
 
 			/* Disable master interrupts */
 			ctl = ioread32(I2C_REG_CTL(alg_data));
@@ -312,7 +316,8 @@ static irqreturn_t i2c_pnx_interrupt(int irq, void *dev_id)
 	struct i2c_pnx_algo_data *alg_data = dev_id;
 	u32 stat, ctl;
 
-	dev_dbg(&alg_data->adapter.dev, "%s(): mstat = %x mctrl = %x, mode = %d\n",
+	dev_dbg(&alg_data->adapter.dev,
+		"%s(): mstat = %x mctrl = %x, mode = %d\n",
 		__func__,
 		ioread32(I2C_REG_STS(alg_data)),
 		ioread32(I2C_REG_CTL(alg_data)),
@@ -335,8 +340,8 @@ static irqreturn_t i2c_pnx_interrupt(int irq, void *dev_id)
 		complete(&alg_data->mif.complete);
 	} else if (stat & mstatus_nai) {
 		/* Slave did not acknowledge, generate a STOP */
-		dev_dbg(&alg_data->adapter.dev, "%s(): "
-			"Slave did not acknowledge, generating a STOP.\n",
+		dev_dbg(&alg_data->adapter.dev,
+			"%s(): Slave did not acknowledge, generating a STOP.\n",
 			__func__);
 		i2c_pnx_stop(alg_data);
 
@@ -375,7 +380,8 @@ static irqreturn_t i2c_pnx_interrupt(int irq, void *dev_id)
 	stat = ioread32(I2C_REG_STS(alg_data));
 	iowrite32(stat | mstatus_tdi | mstatus_afi, I2C_REG_STS(alg_data));
 
-	dev_dbg(&alg_data->adapter.dev, "%s(): exiting, stat = %x ctrl = %x.\n",
+	dev_dbg(&alg_data->adapter.dev,
+		"%s(): exiting, stat = %x ctrl = %x.\n",
 		 __func__, ioread32(I2C_REG_STS(alg_data)),
 		 ioread32(I2C_REG_CTL(alg_data)));
 
@@ -387,10 +393,10 @@ static void i2c_pnx_timeout(unsigned long data)
 	struct i2c_pnx_algo_data *alg_data = (struct i2c_pnx_algo_data *)data;
 	u32 ctl;
 
-	dev_err(&alg_data->adapter.dev, "Master timed out. stat = %04x, cntrl = %04x. "
-	       "Resetting master...\n",
-	       ioread32(I2C_REG_STS(alg_data)),
-	       ioread32(I2C_REG_CTL(alg_data)));
+	dev_err(&alg_data->adapter.dev,
+		"Master timed out. stat = %04x, cntrl = %04x. Resetting master...\n",
+		ioread32(I2C_REG_STS(alg_data)),
+		ioread32(I2C_REG_CTL(alg_data)));
 
 	/* Reset master and disable interrupts */
 	ctl = ioread32(I2C_REG_CTL(alg_data));
@@ -411,7 +417,7 @@ static inline void bus_reset_if_active(struct i2c_pnx_algo_data *alg_data)
 	if ((stat = ioread32(I2C_REG_STS(alg_data))) & mstatus_active) {
 		dev_err(&alg_data->adapter.dev,
 			"%s: Bus is still active after xfer. Reset it...\n",
-		       alg_data->adapter.name);
+			alg_data->adapter.name);
 		iowrite32(ioread32(I2C_REG_CTL(alg_data)) | mcntrl_reset,
 			  I2C_REG_CTL(alg_data));
 		wait_reset(I2C_PNX_TIMEOUT, alg_data);
@@ -445,7 +451,8 @@ i2c_pnx_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 	struct i2c_pnx_algo_data *alg_data = adap->algo_data;
 	u32 stat = ioread32(I2C_REG_STS(alg_data));
 
-	dev_dbg(&alg_data->adapter.dev, "%s(): entering: %d messages, stat = %04x.\n",
+	dev_dbg(&alg_data->adapter.dev,
+		"%s(): entering: %d messages, stat = %04x.\n",
 		__func__, num, ioread32(I2C_REG_STS(alg_data)));
 
 	bus_reset_if_active(alg_data);
@@ -472,9 +479,8 @@ i2c_pnx_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 		alg_data->mif.ret = 0;
 		alg_data->last = (i == num - 1);
 
-		dev_dbg(&alg_data->adapter.dev, "%s(): mode %d, %d bytes\n", __func__,
-			alg_data->mif.mode,
-			alg_data->mif.len);
+		dev_dbg(&alg_data->adapter.dev, "%s(): mode %d, %d bytes\n",
+			__func__, alg_data->mif.mode, alg_data->mif.len);
 
 		i2c_pnx_arm_timer(alg_data);
 
@@ -496,7 +502,8 @@ i2c_pnx_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 
 		if (!(rc = alg_data->mif.ret))
 			completed++;
-		dev_dbg(&alg_data->adapter.dev, "%s(): Complete, return code = %d.\n",
+		dev_dbg(&alg_data->adapter.dev,
+			"%s(): Complete, return code = %d.\n",
 			__func__, rc);
 
 		/* Clear TDI and AFI bits in case they are set. */
-- 
1.6.2.5
