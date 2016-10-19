From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Wed, 19 Oct 2016 13:38:31 +0900
Subject: [PATCH] i2c: uniphier[-f]: fix bool logic calculation
Message-ID: <1476851911-21729-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This code is working, but it should not depend on how "bool" is
typedef'ed, or the bit position of I2C_M_RD.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/i2c/busses/i2c-uniphier-f.c | 2 +-
 drivers/i2c/busses/i2c-uniphier.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-uniphier-f.c b/drivers/i2c/busses/i2c-uniphier-f.c
index db9105e..b54448e 100644
--- a/drivers/i2c/busses/i2c-uniphier-f.c
+++ b/drivers/i2c/busses/i2c-uniphier-f.c
@@ -309,7 +309,7 @@ static int uniphier_fi2c_master_xfer_one(struct i2c_adapter *adap,
 					 struct i2c_msg *msg, bool stop)
 {
 	struct uniphier_fi2c_priv *priv = i2c_get_adapdata(adap);
-	bool is_read = msg->flags & I2C_M_RD;
+	bool is_read = !!(msg->flags & I2C_M_RD);
 	unsigned long time_left;
 
 	dev_dbg(&adap->dev, "%s: addr=0x%02x, len=%d, stop=%d\n",
diff --git a/drivers/i2c/busses/i2c-uniphier.c b/drivers/i2c/busses/i2c-uniphier.c
index 56e92af..cc80bb2 100644
--- a/drivers/i2c/busses/i2c-uniphier.c
+++ b/drivers/i2c/busses/i2c-uniphier.c
@@ -177,7 +177,7 @@ static int uniphier_i2c_stop(struct i2c_adapter *adap)
 static int uniphier_i2c_master_xfer_one(struct i2c_adapter *adap,
 					struct i2c_msg *msg, bool stop)
 {
-	bool is_read = msg->flags & I2C_M_RD;
+	bool is_read = !!(msg->flags & I2C_M_RD);
 	bool recovery = false;
 	int ret;
 
-- 
1.9.1
