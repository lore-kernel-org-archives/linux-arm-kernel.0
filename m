From: ludovic.desroches@atmel.com (ludovic.desroches at atmel.com)
Date: Tue, 13 Nov 2012 16:43:21 +0100
Subject: [PATCH v2] i2c: at91: fix SMBus quick command
Message-ID: <1352821401-1944-1-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ludovic Desroches <ludovic.desroches@atmel.com>

The driver claims to support SMBus quick command but it was not the case.
This patch fixes this issue.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---

Hi Wolfram,

Thanks to Jean explanation about i2cdetect and eeprom behavior, I realized
that the first version of the patch was incorrect. This time all the i2c
devices are detected with i2cdetect -q.

I hope this fix could go into 3.7 since the driver claims SMBus quick
capability but it doesn't support it. Moreover without it i2cdetect find
imaginary devices, and with some IP versions, trying to send 0 byte can cause
issue when writing data to an EEPROM.

Regards

Ludovic

Changes since v1:
 * enable txcomp irq to have a correct behavior

 drivers/i2c/busses/i2c-at91.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at91.c
index f471747..e9c926c 100644
--- a/drivers/i2c/busses/i2c-at91.c
+++ b/drivers/i2c/busses/i2c-at91.c
@@ -44,6 +44,7 @@
 #define	AT91_TWI_STOP		0x0002	/* Send a Stop Condition */
 #define	AT91_TWI_MSEN		0x0004	/* Master Transfer Enable */
 #define	AT91_TWI_SVDIS		0x0020	/* Slave Transfer Disable */
+#define	AT91_TWI_QUICK		0x0040	/* SMBus quick command */
 #define	AT91_TWI_SWRST		0x0080	/* Software Reset */
 
 #define	AT91_TWI_MMR		0x0004	/* Master Mode Register */
@@ -386,7 +387,11 @@ static int at91_do_twi_transfer(struct at91_twi_dev *dev)
 
 	INIT_COMPLETION(dev->cmd_complete);
 	dev->transfer_status = 0;
-	if (dev->msg->flags & I2C_M_RD) {
+
+	if (!dev->buf_len) {
+		at91_twi_write(dev, AT91_TWI_CR, AT91_TWI_QUICK);
+		at91_twi_write(dev, AT91_TWI_IER, AT91_TWI_TXCOMP);
+	} else if (dev->msg->flags & I2C_M_RD) {
 		unsigned start_flags = AT91_TWI_START;
 
 		if (at91_twi_read(dev, AT91_TWI_SR) & AT91_TWI_RXRDY) {
-- 
1.7.11.3
