From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 12 Feb 2014 16:58:06 +0000
Subject: [PATCH 1/1] mfd: max665x: Differentiate between MAX665X devices
Message-ID: <1392224286-31084-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This driver is pretty sparse at the moment, but once we start to add
more functionality it's highly probable that we'll be required to
differentiate between supported devices. To enable us to do that
efficiently via Device Tree we need to separate out the compatible
strings, one per variant.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/max665x.c               | 3 ++-
 include/linux/mfd/max665x-private.h | 5 +++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/max665x.c b/drivers/mfd/max665x.c
index 54fdc11..3bcb765b0 100644
--- a/drivers/mfd/max665x.c
+++ b/drivers/mfd/max665x.c
@@ -71,7 +71,8 @@ static int max665x_remove(struct i2c_client *i2c)
 }
 
 static struct of_device_id max665x_dt_match[] = {
-	{ .compatible = "maxim,max665x" },
+	{ .compatible = "maxim,max6650", .data = (void *)MAX6550 },
+	{ .compatible = "maxim,max6651", .data = (void *)MAX6551 },
 	{},
 };
 MODULE_DEVICE_TABLE(of, max665x_dt_match);
diff --git a/include/linux/mfd/max665x-private.h b/include/linux/mfd/max665x-private.h
index 293db4b..1578a04 100644
--- a/include/linux/mfd/max665x-private.h
+++ b/include/linux/mfd/max665x-private.h
@@ -23,6 +23,11 @@
 #include <linux/i2c.h>
 #include <linux/regmap.h>
 
+enum max655x_id {
+	MAX6550 = 0,
+	MAX6551,
+}
+
 struct max665x_dev {
 	struct device *dev;
 	struct mutex iolock;
-- 
1.8.3.2
