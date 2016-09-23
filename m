From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Fri, 23 Sep 2016 21:04:01 +0900
Subject: [PATCH] i2c: uniphier-f: fix misdetection of incomplete STOP condition
Message-ID: <1474632241-10440-1-git-send-email-yamada.masahiro@socionext.com>
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

 drivers/i2c/busses/i2c-uniphier-f.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-uniphier-f.c b/drivers/i2c/busses/i2c-uniphier-f.c
index 829df91..e5886eb 100644
--- a/drivers/i2c/busses/i2c-uniphier-f.c
+++ b/drivers/i2c/busses/i2c-uniphier-f.c
@@ -13,6 +13,7 @@
  */
 
 #include <linux/clk.h>
+#include <linux/delay.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
@@ -348,10 +349,19 @@ static int uniphier_fi2c_master_xfer_one(struct i2c_adapter *adap,
 	dev_dbg(&adap->dev, "complete\n");
 
 	if (unlikely(priv->flags & UNIPHIER_FI2C_DEFER_STOP_COMP)) {
-		u32 status = readl(priv->membase + UNIPHIER_FI2C_SR);
+		time_left = 20;
 
-		if (!(status & UNIPHIER_FI2C_SR_STS) ||
-		    status & UNIPHIER_FI2C_SR_BB) {
+		while (--time_left) {
+			u32 status = readl(priv->membase + UNIPHIER_FI2C_SR);
+
+			if ((status & UNIPHIER_FI2C_SR_STS) &&
+			    !(status & UNIPHIER_FI2C_SR_BB))
+				break;
+
+			udelay(1);
+		}
+
+		if (!time_left) {
 			dev_err(&adap->dev,
 				"stop condition was not completed.\n");
 			uniphier_fi2c_recover(priv);
-- 
1.9.1
