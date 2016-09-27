From: noralf@tronnes.org (=?UTF-8?q?Noralf=20Tr=C3=B8nnes?=)
Date: Tue, 27 Sep 2016 13:57:02 +0200
Subject: [PATCH v2 4/8] i2c: bcm2835: Can't support I2C_M_IGNORE_NAK
In-Reply-To: <1474977426-3272-1-git-send-email-noralf@tronnes.org>
References: <1474977426-3272-1-git-send-email-noralf@tronnes.org>
Message-ID: <1474977426-3272-5-git-send-email-noralf@tronnes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The controller can't support this flag, so remove it.

Documentation/i2c/i2c-protocol states that all of the message is sent:

I2C_M_IGNORE_NAK:
    Normally message is interrupted immediately if there is [NA] from the
    client. Setting this flag treats any [NA] as [A], and all of
    message is sent.

>From the BCM2835 ARM Peripherals datasheet:

    The ERR field is set when the slave fails to acknowledge either
    its address or a data byte written to it.

So when the controller doesn't receive an ack, it sets ERR and raises
an interrupt. In other words, the whole message is not sent.

Signed-off-by: Noralf Tr?nnes <noralf@tronnes.org>
---
 drivers/i2c/busses/i2c-bcm2835.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-bcm2835.c b/drivers/i2c/busses/i2c-bcm2835.c
index 370a322..4e08add 100644
--- a/drivers/i2c/busses/i2c-bcm2835.c
+++ b/drivers/i2c/busses/i2c-bcm2835.c
@@ -203,10 +203,6 @@ static int bcm2835_i2c_xfer_msg(struct bcm2835_i2c_dev *i2c_dev,
 	if (likely(!i2c_dev->msg_err))
 		return 0;
 
-	if ((i2c_dev->msg_err & BCM2835_I2C_S_ERR) &&
-	    (msg->flags & I2C_M_IGNORE_NAK))
-		return 0;
-
 	dev_err_ratelimited(i2c_dev->dev, "i2c transfer failed: %x\n",
 			    i2c_dev->msg_err);
 
-- 
2.8.2
