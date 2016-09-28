From: noralf@tronnes.org (=?UTF-8?q?Noralf=20Tr=C3=B8nnes?=)
Date: Wed, 28 Sep 2016 19:50:51 +0200
Subject: [PATCH v3 2/7] i2c: bcm2835: Protect against unexpected TXW/RXR
 interrupts
In-Reply-To: <1475085056-5205-1-git-send-email-noralf@tronnes.org>
References: <1475085056-5205-1-git-send-email-noralf@tronnes.org>
Message-ID: <1475085056-5205-3-git-send-email-noralf@tronnes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If an unexpected TXW or RXR interrupt occurs (msg_buf_remaining == 0),
the driver has no way to fill/drain the FIFO to stop the interrupts.
In this case the controller has to be disabled and the transfer
completed to avoid hang.

(CLKT | ERR) and DONE interrupts are completed in their own paths, and
the controller is disabled in the transfer function after completion.
Unite the code paths and do disabling inside the interrupt routine.

Clear interrupt status bits in the united completion path instead of
trying to do it on every interrupt which isn't necessary.
Only CLKT, ERR and DONE can be cleared that way.

Add the status value to the error value in case of TXW/RXR errors to
distinguish them from the other S_LEN error.

Signed-off-by: Noralf Tr?nnes <noralf@tronnes.org>
---
 drivers/i2c/busses/i2c-bcm2835.c | 31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/drivers/i2c/busses/i2c-bcm2835.c b/drivers/i2c/busses/i2c-bcm2835.c
index f283b71..df036ed 100644
--- a/drivers/i2c/busses/i2c-bcm2835.c
+++ b/drivers/i2c/busses/i2c-bcm2835.c
@@ -50,8 +50,6 @@
 #define BCM2835_I2C_S_CLKT	BIT(9)
 #define BCM2835_I2C_S_LEN	BIT(10) /* Fake bit for SW error reporting */
 
-#define BCM2835_I2C_BITMSK_S	0x03FF
-
 #define BCM2835_I2C_CDIV_MIN	0x0002
 #define BCM2835_I2C_CDIV_MAX	0xFFFE
 
@@ -117,14 +115,11 @@ static irqreturn_t bcm2835_i2c_isr(int this_irq, void *data)
 	u32 val, err;
 
 	val = bcm2835_i2c_readl(i2c_dev, BCM2835_I2C_S);
-	val &= BCM2835_I2C_BITMSK_S;
-	bcm2835_i2c_writel(i2c_dev, BCM2835_I2C_S, val);
 
 	err = val & (BCM2835_I2C_S_CLKT | BCM2835_I2C_S_ERR);
 	if (err) {
 		i2c_dev->msg_err = err;
-		complete(&i2c_dev->completion);
-		return IRQ_HANDLED;
+		goto complete;
 	}
 
 	if (val & BCM2835_I2C_S_DONE) {
@@ -137,21 +132,38 @@ static irqreturn_t bcm2835_i2c_isr(int this_irq, void *data)
 			i2c_dev->msg_err = BCM2835_I2C_S_LEN;
 		else
 			i2c_dev->msg_err = 0;
-		complete(&i2c_dev->completion);
-		return IRQ_HANDLED;
+		goto complete;
 	}
 
 	if (val & BCM2835_I2C_S_TXW) {
+		if (!i2c_dev->msg_buf_remaining) {
+			i2c_dev->msg_err = val | BCM2835_I2C_S_LEN;
+			goto complete;
+		}
+
 		bcm2835_fill_txfifo(i2c_dev);
 		return IRQ_HANDLED;
 	}
 
 	if (val & BCM2835_I2C_S_RXR) {
+		if (!i2c_dev->msg_buf_remaining) {
+			i2c_dev->msg_err = val | BCM2835_I2C_S_LEN;
+			goto complete;
+		}
+
 		bcm2835_drain_rxfifo(i2c_dev);
 		return IRQ_HANDLED;
 	}
 
 	return IRQ_NONE;
+
+complete:
+	bcm2835_i2c_writel(i2c_dev, BCM2835_I2C_C, BCM2835_I2C_C_CLEAR);
+	bcm2835_i2c_writel(i2c_dev, BCM2835_I2C_S, BCM2835_I2C_S_CLKT |
+			   BCM2835_I2C_S_ERR | BCM2835_I2C_S_DONE);
+	complete(&i2c_dev->completion);
+
+	return IRQ_HANDLED;
 }
 
 static int bcm2835_i2c_xfer_msg(struct bcm2835_i2c_dev *i2c_dev,
@@ -181,8 +193,9 @@ static int bcm2835_i2c_xfer_msg(struct bcm2835_i2c_dev *i2c_dev,
 
 	time_left = wait_for_completion_timeout(&i2c_dev->completion,
 						BCM2835_I2C_TIMEOUT);
-	bcm2835_i2c_writel(i2c_dev, BCM2835_I2C_C, BCM2835_I2C_C_CLEAR);
 	if (!time_left) {
+		bcm2835_i2c_writel(i2c_dev, BCM2835_I2C_C,
+				   BCM2835_I2C_C_CLEAR);
 		dev_err(i2c_dev->dev, "i2c transfer timed out\n");
 		return -ETIMEDOUT;
 	}
-- 
2.8.2
