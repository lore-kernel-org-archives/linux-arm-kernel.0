From: shinya.kuribayashi@necel.com (Shinya Kuribayashi)
Date: Tue, 13 Oct 2009 11:52:49 +0900
Subject: [PATCH 12/16] i2c-designware: Divide i2c_dw_xfer_msg into two
	functions
In-Reply-To: <4AD3E974.8080200@necel.com>
References: <4AD3E974.8080200@necel.com>
Message-ID: <4AD3EB81.9060803@necel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We have some steps at the top of i2c_dw_xfer_msg() to set up the slave
address and enable the DW I2C core.  It's executed only when we don't
have STATUS_WRITE_IN_PROGRESS.

Then we need to make sure that STATUS_WRITE_IN_PROGRESS only indicates
that we have a pending i2c_msg to process.  In other words, even if
STATUS_WRITE_IN_PROGRESS is not set, that doesn't mean we're at initial
state in the I2C transaction.

Since i2c_dw_xfer_msg() will be invoked again and again during the
transaction, those init steps have a possibility to be re-processed
needlessly.  For example, this issue easily takes place when processing
a combined transaction with a certain condition (the number of tx bytes
in the first i2c_msg == Tx FIFO depth).

Consequently we should not use STATUS_WRITE_IN_PROGRESS to determine
where we're at in the I2C transaction, then let's separate those
initialization steps from i2c_dw_xfer_msg().

Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi@necel.com>
---
 drivers/i2c/busses/i2c-designware.c |   45 +++++++++++++++++++---------------
 1 files changed, 25 insertions(+), 20 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware.c b/drivers/i2c/busses/i2c-designware.c
index d9b5790..de006f0 100644
--- a/drivers/i2c/busses/i2c-designware.c
+++ b/drivers/i2c/busses/i2c-designware.c
@@ -325,6 +325,29 @@ static int i2c_dw_wait_bus_not_busy(struct dw_i2c_dev *dev)
 	return 0;
 }
 
+static void i2c_dw_xfer_init(struct dw_i2c_dev *dev)
+{
+	struct i2c_msg *msgs = dev->msgs;
+	u32 ic_con;
+
+	/* Disable the adapter */
+	writel(0, dev->base + DW_IC_ENABLE);
+
+	/* set the slave (target) address */
+	writel(msgs[dev->msg_write_idx].addr, dev->base + DW_IC_TAR);
+
+	/* if the slave address is ten bit address, enable 10BITADDR */
+	ic_con = readl(dev->base + DW_IC_CON);
+	if (msgs[dev->msg_write_idx].flags & I2C_M_TEN)
+		ic_con |= DW_IC_CON_10BITADDR_MASTER;
+	else
+		ic_con &= ~DW_IC_CON_10BITADDR_MASTER;
+	writel(ic_con, dev->base + DW_IC_CON);
+
+	/* Enable the adapter */
+	writel(1, dev->base + DW_IC_ENABLE);
+}
+
 /*
  * Initiate low level master read/write transaction.
  * This function is called from i2c_dw_xfer when starting a transfer.
@@ -335,31 +358,12 @@ static void
 i2c_dw_xfer_msg(struct dw_i2c_dev *dev)
 {
 	struct i2c_msg *msgs = dev->msgs;
-	u32 ic_con, intr_mask;
+	u32 intr_mask;
 	int tx_limit = dev->tx_fifo_depth - readl(dev->base + DW_IC_TXFLR);
 	int rx_limit = dev->rx_fifo_depth - readl(dev->base + DW_IC_RXFLR);
 	u32 addr = msgs[dev->msg_write_idx].addr;
 	u32 buf_len = dev->tx_buf_len;
 
-	if (!(dev->status & STATUS_WRITE_IN_PROGRESS)) {
-		/* Disable the adapter */
-		writel(0, dev->base + DW_IC_ENABLE);
-
-		/* set the slave (target) address */
-		writel(msgs[dev->msg_write_idx].addr, dev->base + DW_IC_TAR);
-
-		/* if the slave address is ten bit address, enable 10BITADDR */
-		ic_con = readl(dev->base + DW_IC_CON);
-		if (msgs[dev->msg_write_idx].flags & I2C_M_TEN)
-			ic_con |= DW_IC_CON_10BITADDR_MASTER;
-		else
-			ic_con &= ~DW_IC_CON_10BITADDR_MASTER;
-		writel(ic_con, dev->base + DW_IC_CON);
-
-		/* Enable the adapter */
-		writel(1, dev->base + DW_IC_ENABLE);
-	}
-
 	for (; dev->msg_write_idx < dev->msgs_num; dev->msg_write_idx++) {
 		/* if target address has changed, we need to
 		 * reprogram the target address in the i2c
@@ -474,6 +478,7 @@ i2c_dw_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
 		goto done;
 
 	/* start the transfers */
+	i2c_dw_xfer_init(dev);
 	i2c_dw_xfer_msg(dev);
 
 	/* wait for tx to complete */
-- 
1.6.5
