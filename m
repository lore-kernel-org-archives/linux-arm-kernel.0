From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Mon, 26 Oct 2015 10:38:27 +0100
Subject: [PATCH v3] i2c: at91: manage unexpected RXRDY flag when starting a
 transfer
In-Reply-To: <20151022130847.GE1517@katana>
References: <20151022130847.GE1517@katana>
Message-ID: <1445852312-28389-1-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In some cases, we could start a new i2c transfer with the RXRDY flag
set. It is not a clean state and it leads to print annoying error
messages even if there no real issue. The cause is only having garbage
data in the Receive Holding Register because of a weird behavior of the
RXRDY flag.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
Fixes: 93563a6a71bb ("i2c: at91: fix a race condition when using the DMA
controller")
Reported-by: Peter Rosin <peda@lysator.liu.se>
Tested-by: Peter Rosin <peda@lysator.liu.se>
Cc: stable at vger.kernel.org #4.1
---

Changes from v2:
- fix smatch warning: variable 'sr' set but not used

 drivers/i2c/busses/i2c-at91.c | 36 ++++++++++++++++++++++++++----------
 1 file changed, 26 insertions(+), 10 deletions(-)

diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at91.c
index 94c087b..10835d1 100644
--- a/drivers/i2c/busses/i2c-at91.c
+++ b/drivers/i2c/busses/i2c-at91.c
@@ -347,8 +347,14 @@ error:
 
 static void at91_twi_read_next_byte(struct at91_twi_dev *dev)
 {
-	if (!dev->buf_len)
+	/*
+	 * If we are in this case, it means there is garbage data in RHR, so
+	 * delete them.
+	 */
+	if (!dev->buf_len) {
+		at91_twi_read(dev, AT91_TWI_RHR);
 		return;
+	}
 
 	/* 8bit read works with and without FIFO */
 	*dev->buf = readb_relaxed(dev->base + AT91_TWI_RHR);
@@ -465,6 +471,24 @@ static irqreturn_t atmel_twi_interrupt(int irq, void *dev_id)
 
 	if (!irqstatus)
 		return IRQ_NONE;
+	/*
+	 * In reception, the behavior of the twi device (before sama5d2) is
+	 * weird. There is some magic about RXRDY flag! When a data has been
+	 * almost received, the reception of a new one is anticipated if there
+	 * is no stop command to send. That is the reason why ask for sending
+	 * the stop command not on the last data but on the second last one.
+	 *
+	 * Unfortunately, we could still have the RXRDY flag set even if the
+	 * transfer is done and we have read the last data. It might happen
+	 * when the i2c slave device sends too quickly data after receiving the
+	 * ack from the master. The data has been almost received before having
+	 * the order to send stop. In this case, sending the stop command could
+	 * cause a RXRDY interrupt with a TXCOMP one. It is better to manage
+	 * the RXRDY interrupt first in order to not keep garbage data in the
+	 * Receive Holding Register for the next transfer.
+	 */
+	if (irqstatus & AT91_TWI_RXRDY)
+		at91_twi_read_next_byte(dev);
 
 	/*
 	 * When a NACK condition is detected, the I2C controller sets the NACK,
@@ -507,8 +531,6 @@ static irqreturn_t atmel_twi_interrupt(int irq, void *dev_id)
 	if (irqstatus & (AT91_TWI_TXCOMP | AT91_TWI_NACK)) {
 		at91_disable_twi_interrupts(dev);
 		complete(&dev->cmd_complete);
-	} else if (irqstatus & AT91_TWI_RXRDY) {
-		at91_twi_read_next_byte(dev);
 	} else if (irqstatus & AT91_TWI_TXRDY) {
 		at91_twi_write_next_byte(dev);
 	}
@@ -525,7 +547,6 @@ static int at91_do_twi_transfer(struct at91_twi_dev *dev)
 	unsigned long time_left;
 	bool has_unre_flag = dev->pdata->has_unre_flag;
 	bool has_alt_cmd = dev->pdata->has_alt_cmd;
-	unsigned sr;
 
 	/*
 	 * WARNING: the TXCOMP bit in the Status Register is NOT a clear on
@@ -577,7 +598,7 @@ static int at91_do_twi_transfer(struct at91_twi_dev *dev)
 	dev->transfer_status = 0;
 
 	/* Clear pending interrupts, such as NACK. */
-	sr = at91_twi_read(dev, AT91_TWI_SR);
+	at91_twi_read(dev, AT91_TWI_SR);
 
 	if (dev->fifo_size) {
 		unsigned fifo_mr = at91_twi_read(dev, AT91_TWI_FMR);
@@ -600,11 +621,6 @@ static int at91_do_twi_transfer(struct at91_twi_dev *dev)
 	} else if (dev->msg->flags & I2C_M_RD) {
 		unsigned start_flags = AT91_TWI_START;
 
-		if (sr & AT91_TWI_RXRDY) {
-			dev_err(dev->dev, "RXRDY still set!");
-			at91_twi_read(dev, AT91_TWI_RHR);
-		}
-
 		/* if only one byte is to be read, immediately stop transfer */
 		if (!has_alt_cmd && dev->buf_len <= 1 &&
 		    !(dev->msg->flags & I2C_M_RECV_LEN))
-- 
2.5.0
