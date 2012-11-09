From: ludovic.desroches@atmel.com (ludovic.desroches at atmel.com)
Date: Fri, 9 Nov 2012 18:23:17 +0100
Subject: [PATCH] i2c: at91: fix SMBus quick command
Message-ID: <1352481797-3520-1-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ludovic Desroches <ludovic.desroches@atmel.com>

SMBus command was not performed. This patch fixes this issue. The timeout log
priority has been decreased to not make console dirty uselessly.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---

Hi Wolfram,

It would be great if this patch could be included into 3.7. The driver was
claiming that it supports SMBus quick command but it was not true. Moreover,
with some IP versions, it could cause data corruption.

I tested it with i2cdetect as you suggested. EEPROMs were detected but not
other devices (lm75 and ds1337). I have exactly the same behavior by using
i2c-gpio driver so I think there is no major issue on a driver point of view.

Thanks.

Regards.

Ludovic

 drivers/i2c/busses/i2c-at91.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at91.c
index aa59a25..a6670eb 100644
--- a/drivers/i2c/busses/i2c-at91.c
+++ b/drivers/i2c/busses/i2c-at91.c
@@ -39,6 +39,7 @@
 #define	AT91_TWI_STOP		0x0002	/* Send a Stop Condition */
 #define	AT91_TWI_MSEN		0x0004	/* Master Transfer Enable */
 #define	AT91_TWI_SVDIS		0x0020	/* Slave Transfer Disable */
+#define	AT91_TWI_QUICK		0x0040	/* SMBus quick command */
 #define	AT91_TWI_SWRST		0x0080	/* Software Reset */
 
 #define	AT91_TWI_MMR		0x0004	/* Master Mode Register */
@@ -212,7 +213,10 @@ static int at91_do_twi_transfer(struct at91_twi_dev *dev)
 
 	INIT_COMPLETION(dev->cmd_complete);
 	dev->transfer_status = 0;
-	if (dev->msg->flags & I2C_M_RD) {
+
+	if (!dev->buf_len) {
+		at91_twi_write(dev, AT91_TWI_CR, AT91_TWI_QUICK);
+	} else if (dev->msg->flags & I2C_M_RD) {
 		unsigned start_flags = AT91_TWI_START;
 
 		if (at91_twi_read(dev, AT91_TWI_SR) & AT91_TWI_RXRDY) {
@@ -235,7 +239,7 @@ static int at91_do_twi_transfer(struct at91_twi_dev *dev)
 	ret = wait_for_completion_interruptible_timeout(&dev->cmd_complete,
 							dev->adapter.timeout);
 	if (ret == 0) {
-		dev_err(dev->dev, "controller timed out\n");
+		dev_dbg(dev->dev, "controller timed out\n");
 		at91_init_twi_bus(dev);
 		return -ETIMEDOUT;
 	}
-- 
1.7.11.3
