From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri,  9 Jan 2015 18:21:38 +0100
Subject: [RFC 08/11] i2c: dln2: make use of the new infrastructure for quirks
In-Reply-To: <1420824103-24169-1-git-send-email-wsa@the-dreams.de>
References: <1420824103-24169-1-git-send-email-wsa@the-dreams.de>
Message-ID: <1420824103-24169-9-git-send-email-wsa@the-dreams.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 drivers/i2c/busses/i2c-dln2.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-dln2.c b/drivers/i2c/busses/i2c-dln2.c
index b3fb86af4cbb..b6f9ba7eb175 100644
--- a/drivers/i2c/busses/i2c-dln2.c
+++ b/drivers/i2c/busses/i2c-dln2.c
@@ -144,7 +144,6 @@ static int dln2_i2c_xfer(struct i2c_adapter *adapter,
 {
 	struct dln2_i2c *dln2 = i2c_get_adapdata(adapter);
 	struct i2c_msg *pmsg;
-	struct device *dev = &dln2->adapter.dev;
 	int i;
 
 	for (i = 0; i < num; i++) {
@@ -152,11 +151,6 @@ static int dln2_i2c_xfer(struct i2c_adapter *adapter,
 
 		pmsg = &msgs[i];
 
-		if (pmsg->len > DLN2_I2C_MAX_XFER_SIZE) {
-			dev_warn(dev, "maximum transfer size exceeded\n");
-			return -EOPNOTSUPP;
-		}
-
 		if (pmsg->flags & I2C_M_RD) {
 			ret = dln2_i2c_read(dln2, pmsg->addr, pmsg->buf,
 					    pmsg->len);
@@ -187,6 +181,11 @@ static const struct i2c_algorithm dln2_i2c_usb_algorithm = {
 	.functionality = dln2_i2c_func,
 };
 
+static struct i2c_adapter_quirks dln2_i2c_quirks = {
+	.max_read_len = DLN2_I2C_MAX_XFER_SIZE,
+	.max_write_len = DLN2_I2C_MAX_XFER_SIZE,
+};
+
 static int dln2_i2c_probe(struct platform_device *pdev)
 {
 	int ret;
@@ -209,6 +208,7 @@ static int dln2_i2c_probe(struct platform_device *pdev)
 	dln2->adapter.owner = THIS_MODULE;
 	dln2->adapter.class = I2C_CLASS_HWMON;
 	dln2->adapter.algo = &dln2_i2c_usb_algorithm;
+	dln2->adapter.quirks = &dln2_i2c_quirks;
 	dln2->adapter.dev.parent = dev;
 	i2c_set_adapdata(&dln2->adapter, dln2);
 	snprintf(dln2->adapter.name, sizeof(dln2->adapter.name), "%s-%s-%d",
-- 
2.1.3
