From: david.engraf@sysgo.com (David Engraf)
Date: Wed, 18 Apr 2018 14:40:55 +0200
Subject: [PATCH] i2c: at91: Read all available bytes at once
Message-ID: <20180418124055.21333-1-david.engraf@sysgo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With FIFO enabled it is possible to read multiple bytes
at once in the interrupt handler as long as RXRDY is
set. This may also reduce the number of interrupts.

Signed-off-by: David Engraf <david.engraf@sysgo.com>
---
 drivers/i2c/busses/i2c-at91.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at91.c
index bfd1fdff64a9..d01c2b2384bd 100644
--- a/drivers/i2c/busses/i2c-at91.c
+++ b/drivers/i2c/busses/i2c-at91.c
@@ -518,8 +518,12 @@ static irqreturn_t atmel_twi_interrupt(int irq, void *dev_id)
 	 * the RXRDY interrupt first in order to not keep garbage data in the
 	 * Receive Holding Register for the next transfer.
 	 */
-	if (irqstatus & AT91_TWI_RXRDY)
-		at91_twi_read_next_byte(dev);
+	if (irqstatus & AT91_TWI_RXRDY) {
+		/* read all available bytes at once when FIFO is used */
+		do {
+			at91_twi_read_next_byte(dev);
+		} while (at91_twi_read(dev, AT91_TWI_SR) & AT91_TWI_RXRDY);
+	}
 
 	/*
 	 * When a NACK condition is detected, the I2C controller sets the NACK,
-- 
2.14.1
