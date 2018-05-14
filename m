From: peda@axentia.se (Peter Rosin)
Date: Mon, 14 May 2018 16:53:29 +0200
Subject: [PATCH 20/21] i2c: stu300: make use of i2c_8bit_addr_from_msg
In-Reply-To: <20180514145330.4857-1-peda@axentia.se>
References: <20180514145330.4857-1-peda@axentia.se>
Message-ID: <20180514145330.4857-21-peda@axentia.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Because it looks neater.

Also restructure debug output for resends, since that code as a
result is only handling debug output.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/i2c/busses/i2c-stu300.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/i2c/busses/i2c-stu300.c b/drivers/i2c/busses/i2c-stu300.c
index dc63236b45b2..e866c481bfc3 100644
--- a/drivers/i2c/busses/i2c-stu300.c
+++ b/drivers/i2c/busses/i2c-stu300.c
@@ -602,20 +602,24 @@ static int stu300_send_address(struct stu300_dev *dev,
 	u32 val;
 	int ret;
 
-	if (msg->flags & I2C_M_TEN)
+	if (msg->flags & I2C_M_TEN) {
 		/* This is probably how 10 bit addresses look */
 		val = (0xf0 | (((u32) msg->addr & 0x300) >> 7)) &
 			I2C_DR_D_MASK;
-	else
-		val = ((msg->addr << 1) & I2C_DR_D_MASK);
+		if (msg->flags & I2C_M_RD)
+			/* This is the direction bit */
+			val |= 0x01;
+	} else {
+		val = i2c_8bit_addr_from_msg(msg);
+	}
 
-	if (msg->flags & I2C_M_RD) {
-		/* This is the direction bit */
-		val |= 0x01;
-		if (resend)
+	if (resend) {
+		if (msg->flags & I2C_M_RD)
 			dev_dbg(&dev->pdev->dev, "read resend\n");
-	} else if (resend)
-		dev_dbg(&dev->pdev->dev, "write resend\n");
+		else
+			dev_dbg(&dev->pdev->dev, "write resend\n");
+	}
+
 	stu300_wr8(val, dev->virtbase + I2C_DR);
 
 	/* For 10bit addressing, await 10bit request (EVENT 9) */
-- 
2.11.0
