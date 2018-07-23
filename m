From: wsa+renesas@sang-engineering.com (Wolfram Sang)
Date: Mon, 23 Jul 2018 22:26:11 +0200
Subject: [PATCH 07/12] i2c: stu300: use core to detect 'no zero length' quirk
In-Reply-To: <20180723202617.15230-1-wsa+renesas@sang-engineering.com>
References: <20180723202617.15230-1-wsa+renesas@sang-engineering.com>
Message-ID: <20180723202617.15230-8-wsa+renesas@sang-engineering.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

And don't reimplement in the driver.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Only build tested.

 drivers/i2c/busses/i2c-stu300.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-stu300.c b/drivers/i2c/busses/i2c-stu300.c
index fce52bdab2b7..5503fa171df0 100644
--- a/drivers/i2c/busses/i2c-stu300.c
+++ b/drivers/i2c/busses/i2c-stu300.c
@@ -673,12 +673,6 @@ static int stu300_xfer_msg(struct i2c_adapter *adap,
 			msg->addr, msg->len, msg->flags, stop);
 	}
 
-	/* Zero-length messages are not supported by this hardware */
-	if (msg->len == 0) {
-		ret = -EINVAL;
-		goto exit_disable;
-	}
-
 	/*
 	 * For some reason, sending the address sometimes fails when running
 	 * on  the 13 MHz clock. No interrupt arrives. This is a work around,
@@ -863,6 +857,10 @@ static const struct i2c_algorithm stu300_algo = {
 	.functionality	= stu300_func,
 };
 
+static const struct i2c_adapter_quirks stu300_quirks = {
+	.flags = I2C_AQ_NO_ZERO_LEN,
+};
+
 static int stu300_probe(struct platform_device *pdev)
 {
 	struct stu300_dev *dev;
@@ -920,6 +918,8 @@ static int stu300_probe(struct platform_device *pdev)
 	adap->algo = &stu300_algo;
 	adap->dev.parent = &pdev->dev;
 	adap->dev.of_node = pdev->dev.of_node;
+	adap->quirks = &stu300_quirks;
+
 	i2c_set_adapdata(adap, dev);
 
 	/* i2c device drivers may be active on return from add_adapter() */
-- 
2.11.0
