From: wsa@the-dreams.de (Wolfram Sang)
Date: Wed, 25 Feb 2015 17:02:00 +0100
Subject: [RFC V2 09/12] i2c: powermac: make use of the new infrastructure for
 quirks
In-Reply-To: <1424880126-15047-1-git-send-email-wsa@the-dreams.de>
References: <1424880126-15047-1-git-send-email-wsa@the-dreams.de>
Message-ID: <1424880126-15047-10-git-send-email-wsa@the-dreams.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-powermac.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-powermac.c b/drivers/i2c/busses/i2c-powermac.c
index 60a53c169ed2b3..6abcf696e3594b 100644
--- a/drivers/i2c/busses/i2c-powermac.c
+++ b/drivers/i2c/busses/i2c-powermac.c
@@ -153,12 +153,6 @@ static int i2c_powermac_master_xfer(	struct i2c_adapter *adap,
 	int			read;
 	int			addrdir;
 
-	if (num != 1) {
-		dev_err(&adap->dev,
-			"Multi-message I2C transactions not supported\n");
-		return -EOPNOTSUPP;
-	}
-
 	if (msgs->flags & I2C_M_TEN)
 		return -EINVAL;
 	read = (msgs->flags & I2C_M_RD) != 0;
@@ -205,6 +199,9 @@ static const struct i2c_algorithm i2c_powermac_algorithm = {
 	.functionality	= i2c_powermac_func,
 };
 
+static struct i2c_adapter_quirks i2c_powermac_quirks = {
+	.max_num_msgs = 1,
+};
 
 static int i2c_powermac_remove(struct platform_device *dev)
 {
@@ -434,6 +431,7 @@ static int i2c_powermac_probe(struct platform_device *dev)
 
 	platform_set_drvdata(dev, adapter);
 	adapter->algo = &i2c_powermac_algorithm;
+	adapter->quirks = &i2c_powermac_quirks;
 	i2c_set_adapdata(adapter, bus);
 	adapter->dev.parent = &dev->dev;
 
-- 
2.1.4
