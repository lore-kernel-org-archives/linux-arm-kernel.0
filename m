From: wsa+renesas@sang-engineering.com (Wolfram Sang)
Date: Thu, 20 Sep 2018 18:14:21 +0200
Subject: [RFC PATCH 2/4] i2c: core: remove level of indentation in i2c_transfer
In-Reply-To: <20180920161423.13990-1-wsa+renesas@sang-engineering.com>
References: <20180920161423.13990-1-wsa+renesas@sang-engineering.com>
Message-ID: <20180920161423.13990-3-wsa+renesas@sang-engineering.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Using the common kernel pattern to bail out at the beginning if some
conditions are not met, we can save a level of indentation. No
functional change.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/i2c-core-base.c | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index c2b352c46fae..799776c6d421 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -1922,6 +1922,11 @@ int i2c_transfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 {
 	int ret;
 
+	if (!adap->algo->master_xfer) {
+		dev_dbg(&adap->dev, "I2C level transfers not supported\n");
+		return -EOPNOTSUPP;
+	}
+
 	/* REVISIT the fault reporting model here is weak:
 	 *
 	 *  - When we get an error after receiving N bytes from a slave,
@@ -1938,25 +1943,19 @@ int i2c_transfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 	 *    one (discarding status on the second message) or errno
 	 *    (discarding status on the first one).
 	 */
-
-	if (adap->algo->master_xfer) {
-		if (in_atomic() || irqs_disabled()) {
-			ret = i2c_trylock_bus(adap, I2C_LOCK_SEGMENT);
-			if (!ret)
-				/* I2C activity is ongoing. */
-				return -EAGAIN;
-		} else {
-			i2c_lock_bus(adap, I2C_LOCK_SEGMENT);
-		}
-
-		ret = __i2c_transfer(adap, msgs, num);
-		i2c_unlock_bus(adap, I2C_LOCK_SEGMENT);
-
-		return ret;
+	if (in_atomic() || irqs_disabled()) {
+		ret = i2c_trylock_bus(adap, I2C_LOCK_SEGMENT);
+		if (!ret)
+			/* I2C activity is ongoing. */
+			return -EAGAIN;
 	} else {
-		dev_dbg(&adap->dev, "I2C level transfers not supported\n");
-		return -EOPNOTSUPP;
+		i2c_lock_bus(adap, I2C_LOCK_SEGMENT);
 	}
+
+	ret = __i2c_transfer(adap, msgs, num);
+	i2c_unlock_bus(adap, I2C_LOCK_SEGMENT);
+
+	return ret;
 }
 EXPORT_SYMBOL(i2c_transfer);
 
-- 
2.18.0
