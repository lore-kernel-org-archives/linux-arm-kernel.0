From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri,  9 Jan 2015 18:21:40 +0100
Subject: [RFC 10/11] i2c: viperboard: make use of the new infrastructure for
 quirks
In-Reply-To: <1420824103-24169-1-git-send-email-wsa@the-dreams.de>
References: <1420824103-24169-1-git-send-email-wsa@the-dreams.de>
Message-ID: <1420824103-24169-11-git-send-email-wsa@the-dreams.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 drivers/i2c/busses/i2c-viperboard.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-viperboard.c b/drivers/i2c/busses/i2c-viperboard.c
index 7533fa34d737..47e88adf2011 100644
--- a/drivers/i2c/busses/i2c-viperboard.c
+++ b/drivers/i2c/busses/i2c-viperboard.c
@@ -288,10 +288,6 @@ static int vprbrd_i2c_xfer(struct i2c_adapter *i2c, struct i2c_msg *msgs,
 			i, pmsg->flags & I2C_M_RD ? "read" : "write",
 			pmsg->flags, pmsg->len, pmsg->addr);
 
-		/* msgs longer than 2048 bytes are not supported by adapter */
-		if (pmsg->len > 2048)
-			return -EINVAL;
-
 		mutex_lock(&vb->lock);
 		/* directly send the message */
 		if (pmsg->flags & I2C_M_RD) {
@@ -358,6 +354,11 @@ static const struct i2c_algorithm vprbrd_algorithm = {
 	.functionality	= vprbrd_i2c_func,
 };
 
+static struct i2c_adapter_quirks vprbrd_quirks = {
+	.max_read_len = 2048,
+	.max_write_len = 2048,
+};
+
 static int vprbrd_i2c_probe(struct platform_device *pdev)
 {
 	struct vprbrd *vb = dev_get_drvdata(pdev->dev.parent);
@@ -373,6 +374,7 @@ static int vprbrd_i2c_probe(struct platform_device *pdev)
 	vb_i2c->i2c.owner = THIS_MODULE;
 	vb_i2c->i2c.class = I2C_CLASS_HWMON;
 	vb_i2c->i2c.algo = &vprbrd_algorithm;
+	vb_i2c->i2c.quirks = &vprbrd_quirks;
 	vb_i2c->i2c.algo_data = vb;
 	/* save the param in usb capabable memory */
 	vb_i2c->bus_freq_param = i2c_bus_param;
-- 
2.1.3
