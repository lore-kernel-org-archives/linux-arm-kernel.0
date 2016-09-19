From: noralf@tronnes.org (=?UTF-8?q?Noralf=20Tr=C3=B8nnes?=)
Date: Mon, 19 Sep 2016 17:26:17 +0200
Subject: [PATCH 3/3] i2c: bcm2835: Use ratelimited logging on transfer errors
In-Reply-To: <1474298777-5858-1-git-send-email-noralf@tronnes.org>
References: <1474298777-5858-1-git-send-email-noralf@tronnes.org>
Message-ID: <1474298777-5858-3-git-send-email-noralf@tronnes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Writing to an AT24C32 generates on average 2x i2c transfer errors per
32-byte page write. Which amounts to a lot for a 4k write. This is due
to the fact that the chip doesn't respond during it's internal write
cycle when the at24 driver tries and retries the next write.
Reduce this flooding of the log by using dev_err_ratelimited().

Signed-off-by: Noralf Tr?nnes <noralf@tronnes.org>
---
 drivers/i2c/busses/i2c-bcm2835.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-bcm2835.c b/drivers/i2c/busses/i2c-bcm2835.c
index b3ce565..dc0a5d5 100644
--- a/drivers/i2c/busses/i2c-bcm2835.c
+++ b/drivers/i2c/busses/i2c-bcm2835.c
@@ -274,7 +274,8 @@ static int bcm2835_i2c_xfer_msg(struct bcm2835_i2c_dev *i2c_dev,
 	    (msg->flags & I2C_M_IGNORE_NAK))
 		return 0;
 
-	dev_err(i2c_dev->dev, "i2c transfer failed: %x\n", i2c_dev->msg_err);
+	dev_err_ratelimited(i2c_dev->dev, "i2c transfer failed: %x\n",
+			    i2c_dev->msg_err);
 
 	if (i2c_dev->msg_err & BCM2835_I2C_S_ERR)
 		return -EREMOTEIO;
-- 
2.8.2
