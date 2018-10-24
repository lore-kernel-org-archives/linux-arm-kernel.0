From: shubhrajyoti.datta@gmail.com (shubhrajyoti.datta at gmail.com)
Date: Wed, 24 Oct 2018 16:20:03 +0530
Subject: [PATCH] i2c: cadence: Implement timeout
Message-ID: <1540378203-1655-1-git-send-email-shubhrajyoti.datta@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>

In some cases we are waiting in a loop. Replace the infinite wait with
the  timeout.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
---
 drivers/i2c/busses/i2c-cadence.c | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-cadence.c b/drivers/i2c/busses/i2c-cadence.c
index b136057..9c38278 100644
--- a/drivers/i2c/busses/i2c-cadence.c
+++ b/drivers/i2c/busses/i2c-cadence.c
@@ -209,6 +209,7 @@ static irqreturn_t cdns_i2c_isr(int irq, void *ptr)
 	struct cdns_i2c *id = ptr;
 	/* Signal completion only after everything is updated */
 	int done_flag = 0;
+	unsigned int timeout;
 	irqreturn_t status = IRQ_NONE;
 
 	isr_status = cdns_i2c_readreg(CDNS_I2C_ISR_OFFSET);
@@ -235,6 +236,7 @@ static irqreturn_t cdns_i2c_isr(int irq, void *ptr)
 	    ((isr_status & CDNS_I2C_IXR_COMP) ||
 	     (isr_status & CDNS_I2C_IXR_DATA))) {
 		/* Read data if receive data valid is set */
+		timeout = 1000;
 		while (cdns_i2c_readreg(CDNS_I2C_SR_OFFSET) &
 		       CDNS_I2C_SR_RXDV) {
 			/*
@@ -253,6 +255,16 @@ static irqreturn_t cdns_i2c_isr(int irq, void *ptr)
 
 			if (cdns_is_holdquirk(id, hold_quirk))
 				break;
+			timeout--;
+			if (timeout)
+				mdelay(1);
+			else
+				break;
+		}
+		if (!timeout) {
+			id->err_status = -ETIMEDOUT;
+			complete(&id->xfer_done);
+			return IRQ_HANDLED;
 		}
 
 		/*
@@ -262,12 +274,22 @@ static irqreturn_t cdns_i2c_isr(int irq, void *ptr)
 		 * maintain transfer size non-zero while performing a large
 		 * receive operation.
 		 */
+		timeout = 1000;
 		if (cdns_is_holdquirk(id, hold_quirk)) {
 			/* wait while fifo is full */
-			while (cdns_i2c_readreg(CDNS_I2C_XFER_SIZE_OFFSET) !=
-			       (id->curr_recv_count - CDNS_I2C_FIFO_DEPTH))
-				;
-
+			while ((cdns_i2c_readreg(CDNS_I2C_XFER_SIZE_OFFSET) !=
+			       (id->curr_recv_count - CDNS_I2C_FIFO_DEPTH))) {
+				timeout--;
+				if (timeout)
+					mdelay(1);
+				else
+					break;
+			}
+			if (!timeout) {
+				id->err_status = -ETIMEDOUT;
+				complete(&id->xfer_done);
+				return IRQ_HANDLED;
+			}
 			/*
 			 * Check number of bytes to be received against maximum
 			 * transfer size and update register accordingly.
-- 
2.1.1
