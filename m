From: david.engraf@sysgo.com (David Engraf)
Date: Thu, 26 Apr 2018 11:53:14 +0200
Subject: [PATCH v2] i2c: at91: Read all available bytes at once
In-Reply-To: <20180426082558.GX13305@rfolt0960.corp.atmel.com>
References: <20180426082558.GX13305@rfolt0960.corp.atmel.com>
Message-ID: <20180426095314.12758-1-david.engraf@sysgo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With FIFO enabled it is possible to read multiple bytes
at once in the interrupt handler as long as RXRDY is
set. This may also reduce the number of interrupts.

This patch polls RXRDY and reads all available bytes at
once.

Signed-off-by: David Engraf <david.engraf@sysgo.com>
---
 drivers/i2c/busses/i2c-at91.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at91.c
index bfd1fdff64a9..9caee5b79eac 100644
--- a/drivers/i2c/busses/i2c-at91.c
+++ b/drivers/i2c/busses/i2c-at91.c
@@ -518,8 +518,16 @@ static irqreturn_t atmel_twi_interrupt(int irq, void *dev_id)
 	 * the RXRDY interrupt first in order to not keep garbage data in the
 	 * Receive Holding Register for the next transfer.
 	 */
-	if (irqstatus & AT91_TWI_RXRDY)
-		at91_twi_read_next_byte(dev);
+	if (irqstatus & AT91_TWI_RXRDY) {
+		/*
+		 * Read all available bytes at once by polling RXRDY usable w/ and w/o
+		 * FIFO. With FIFO enabled we could also read RXFL and avoid polling
+		 * RXRDY.
+		 */
+		do {
+			at91_twi_read_next_byte(dev);
+		} while (at91_twi_read(dev, AT91_TWI_SR) & AT91_TWI_RXRDY);
+	}
 
 	/*
 	 * When a NACK condition is detected, the I2C controller sets the NACK,
-- 
2.14.1
