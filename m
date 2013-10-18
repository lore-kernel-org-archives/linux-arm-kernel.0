From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 18 Oct 2013 11:51:45 +0200
Subject: [PATCH 2/5 v2] mfd: tc3589x: Detect the precise version
Message-ID: <1382089905-20730-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of detecting the "tc3589x" and hard-coding the number of
GPIO pins to 24, encode all the possible subtypes and set the
number of GPIO pins from the type.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Compress the switch tree to the two variables we currently
  have to deal with.
---
 drivers/mfd/tc3589x.c | 37 +++++++++++++++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/tc3589x.c b/drivers/mfd/tc3589x.c
index 70f4909f..87ea51d 100644
--- a/drivers/mfd/tc3589x.c
+++ b/drivers/mfd/tc3589x.c
@@ -16,6 +16,19 @@
 #include <linux/mfd/core.h>
 #include <linux/mfd/tc3589x.h>
 
+/**
+ * enum tc3589x_version - indicates the TC3589x version
+ */
+enum tc3589x_version {
+	TC3589X_TC35890,
+	TC3589X_TC35892,
+	TC3589X_TC35893,
+	TC3589X_TC35894,
+	TC3589X_TC35895,
+	TC3589X_TC35896,
+	TC3589X_UNKNOWN,
+};
+
 #define TC3589x_CLKMODE_MODCTL_SLEEP		0x0
 #define TC3589x_CLKMODE_MODCTL_OPERATION	(1 << 0)
 
@@ -361,7 +374,21 @@ static int tc3589x_probe(struct i2c_client *i2c,
 	tc3589x->i2c = i2c;
 	tc3589x->pdata = pdata;
 	tc3589x->irq_base = pdata->irq_base;
-	tc3589x->num_gpio = id->driver_data;
+
+	switch (id->driver_data) {
+	case TC3589X_TC35893:
+	case TC3589X_TC35895:
+	case TC3589X_TC35896:
+		tc3589x->num_gpio = 20;
+		break;
+	case TC3589X_TC35890:
+	case TC3589X_TC35892:
+	case TC3589X_TC35894:
+	case TC3589X_UNKNOWN:
+	default:
+		tc3589x->num_gpio = 24;
+		break;
+	}
 
 	i2c_set_clientdata(i2c, tc3589x);
 
@@ -432,7 +459,13 @@ static int tc3589x_resume(struct device *dev)
 static SIMPLE_DEV_PM_OPS(tc3589x_dev_pm_ops, tc3589x_suspend, tc3589x_resume);
 
 static const struct i2c_device_id tc3589x_id[] = {
-	{ "tc3589x", 24 },
+	{ "tc35890", TC3589X_TC35890 },
+	{ "tc35892", TC3589X_TC35892 },
+	{ "tc35893", TC3589X_TC35893 },
+	{ "tc35894", TC3589X_TC35894 },
+	{ "tc35895", TC3589X_TC35895 },
+	{ "tc35896", TC3589X_TC35896 },
+	{ "tc3589x", TC3589X_UNKNOWN },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, tc3589x_id);
-- 
1.8.3.1
