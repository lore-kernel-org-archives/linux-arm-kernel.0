From: shinya.kuribayashi@necel.com (Shinya Kuribayashi)
Date: Tue, 13 Oct 2009 11:52:01 +0900
Subject: [PATCH 10/16] i2c-designware: Do dw_i2c_pump_msg's jobs in the
	interrutp handler
In-Reply-To: <4AD3E974.8080200@necel.com>
References: <4AD3E974.8080200@necel.com>
Message-ID: <4AD3EB51.7030502@necel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Symptom:
--------
When we're going to send/receive the data with bigger size than the
Tx FIFO length, the I2C transaction will be divided into several
separated transactions, limited by the Tx FIFO length.

Details:
--------
As a hardware feature, DesignWare I2C core emits a STOP condition
whenever Tx FIFO becomes empty (strictly speaking, whenever the last
byte in the Tx FIFO has been sent out), even if we have more bytes to
be written.  Then, once a new transmit data is written to the Tx FIFO,
DW I2C core will initiate a new I2C transaction, which leads to another
START condition.

This explains how the transaction in question goes, and implies that
current tasklet-based dw_i2c_pump_msg() couldn't meet the timing
constraint required for avoiding the Tx FIFO underrun.

To avoid this scenario, we must keep providing new transmit data out
within a given time period.  In case of Fast-mode + 32-byte Tx FIFO,
for instance, it takes about 22.5[us] to process one byte, and 720[us]
in total.

This patch removes the existing tasklet-based "pump" system, then put
its jobs into the interrupt handler.

Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi@necel.com>
---
 drivers/i2c/busses/i2c-designware.c |   42 ++++++++++++++--------------------
 1 files changed, 17 insertions(+), 25 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware.c b/drivers/i2c/busses/i2c-designware.c
index 6bfdc5f..52a69a2 100644
--- a/drivers/i2c/busses/i2c-designware.c
+++ b/drivers/i2c/busses/i2c-designware.c
@@ -149,7 +149,6 @@ static char *abort_sources[] = {
  * @dev: driver model device node
  * @base: IO registers pointer
  * @cmd_complete: tx completion indicator
- * @pump_msg: continue in progress transfers
  * @lock: protect this struct and IO registers
  * @clk: input reference clock
  * @cmd_err: run time hadware error code
@@ -175,7 +174,6 @@ struct dw_i2c_dev {
 	struct device		*dev;
 	void __iomem		*base;
 	struct completion	cmd_complete;
-	struct tasklet_struct	pump_msg;
 	struct mutex		lock;
 	struct clk		*clk;
 	int			cmd_err;
@@ -324,7 +322,7 @@ static int i2c_dw_wait_bus_not_busy(struct dw_i2c_dev *dev)
 /*
  * Initiate low level master read/write transaction.
  * This function is called from i2c_dw_xfer when starting a transfer.
- * This function is also called from dw_i2c_pump_msg to continue a transfer
+ * This function is also called from i2c_dw_isr to continue a transfer
  * that is longer than the size of the TX FIFO.
  */
 static void
@@ -489,10 +487,7 @@ i2c_dw_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
 
 	/* no error */
 	if (likely(!dev->cmd_err)) {
-		/* read rx fifo, and disable the adapter */
-		do {
-			i2c_dw_read(dev);
-		} while (dev->status & STATUS_READ_IN_PROGRESS);
+		/* Disable the adapter */
 		writel(0, dev->base + DW_IC_ENABLE);
 		ret = num;
 		goto done;
@@ -520,20 +515,6 @@ static u32 i2c_dw_func(struct i2c_adapter *adap)
 	return I2C_FUNC_I2C | I2C_FUNC_10BIT_ADDR;
 }
 
-static void dw_i2c_pump_msg(unsigned long data)
-{
-	struct dw_i2c_dev *dev = (struct dw_i2c_dev *) data;
-	u32 intr_mask;
-
-	i2c_dw_read(dev);
-	i2c_dw_xfer_msg(dev);
-
-	intr_mask = DW_IC_INTR_STOP_DET | DW_IC_INTR_TX_ABRT;
-	if (dev->status & STATUS_WRITE_IN_PROGRESS)
-		intr_mask |= DW_IC_INTR_TX_EMPTY;
-	writel(intr_mask, dev->base + DW_IC_INTR_MASK);
-}
-
 static u32 i2c_dw_read_clear_intrbits(struct dw_i2c_dev *dev)
 {
 	u32 stat;
@@ -599,10 +580,22 @@ static irqreturn_t i2c_dw_isr(int this_irq, void *dev_id)
 		dev->abort_source = readl(dev->base + DW_IC_TX_ABRT_SOURCE);
 		dev->cmd_err |= DW_IC_ERR_TX_ABRT;
 		dev->status = STATUS_IDLE;
-	} else if (stat & DW_IC_INTR_TX_EMPTY)
-		tasklet_schedule(&dev->pump_msg);
+	}
+
+	if (stat & DW_IC_INTR_TX_EMPTY) {
+		/* Allocate room for data reception prior to xfer_msg() */
+		i2c_dw_read(dev);
+		i2c_dw_xfer_msg(dev);
+	}
+
+	/*
+	 * No need to modify or disable the interrupt mask here, as
+	 * i2c_dw_xfer_msg() above will do that job according to the
+	 * state machine.
+	 *
+	 * This comment can be removed once approved by I2C list.
+	 */
 
-	writel(0, dev->base + DW_IC_INTR_MASK);	/* disable interrupts */
 	if (stat & (DW_IC_INTR_TX_ABRT | DW_IC_INTR_STOP_DET))
 		complete(&dev->cmd_complete);
 
@@ -648,7 +641,6 @@ static int __devinit dw_i2c_probe(struct platform_device *pdev)
 	}
 
 	init_completion(&dev->cmd_complete);
-	tasklet_init(&dev->pump_msg, dw_i2c_pump_msg, (unsigned long) dev);
 	mutex_init(&dev->lock);
 	dev->dev = get_device(&pdev->dev);
 	dev->irq = irq;
-- 
1.6.5
