From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Fri, 23 Sep 2016 22:34:41 +0900
Subject: [PATCH v2] i2c: uniphier-f: fix misdetection of incomplete STOP
 condition
Message-ID: <1474637681-9589-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, the status register FI2C_SR is checked immediately after
a STOP condition is issued in case of the deferred STOP condition.
It takes typically 5-10 usec until the corresponding bits in the
register are set, so the error check for "stop condition was not
completed" is very likely to be false positive.

Add wait code to relax the status register check.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2:
  - use readl_poll_timeout()

 drivers/i2c/busses/i2c-uniphier-f.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-uniphier-f.c b/drivers/i2c/busses/i2c-uniphier-f.c
index 829df91..db9105e 100644
--- a/drivers/i2c/busses/i2c-uniphier-f.c
+++ b/drivers/i2c/busses/i2c-uniphier-f.c
@@ -14,6 +14,7 @@
 
 #include <linux/clk.h>
 #include <linux/i2c.h>
+#include <linux/iopoll.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/module.h>
@@ -348,14 +349,19 @@ static int uniphier_fi2c_master_xfer_one(struct i2c_adapter *adap,
 	dev_dbg(&adap->dev, "complete\n");
 
 	if (unlikely(priv->flags & UNIPHIER_FI2C_DEFER_STOP_COMP)) {
-		u32 status = readl(priv->membase + UNIPHIER_FI2C_SR);
-
-		if (!(status & UNIPHIER_FI2C_SR_STS) ||
-		    status & UNIPHIER_FI2C_SR_BB) {
+		u32 status;
+		int ret;
+
+		ret = readl_poll_timeout(priv->membase + UNIPHIER_FI2C_SR,
+					 status,
+					 (status & UNIPHIER_FI2C_SR_STS) &&
+					 !(status & UNIPHIER_FI2C_SR_BB),
+					 1, 20);
+		if (ret) {
 			dev_err(&adap->dev,
 				"stop condition was not completed.\n");
 			uniphier_fi2c_recover(priv);
-			return -EBUSY;
+			return ret;
 		}
 	}
 
-- 
1.9.1
