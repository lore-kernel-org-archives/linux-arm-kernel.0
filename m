From: pavel@ucw.cz (Pavel Machek)
Date: Tue, 11 Sep 2018 23:01:33 +0200
Subject: [PATCH 1/3] mfd: ti-lmu: switch to gpiod
Message-ID: <20180911210133.GA32497@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use new descriptor based API instead of the legacy one.
    
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Signed-off-by: Pavel Machek <pavel@ucw.cz>

diff --git a/drivers/mfd/ti-lmu.c b/drivers/mfd/ti-lmu.c
index 990437e..e14cb9f 100644
--- a/drivers/mfd/ti-lmu.c
+++ b/drivers/mfd/ti-lmu.c
@@ -12,7 +12,7 @@
 
 #include <linux/delay.h>
 #include <linux/err.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/i2c.h>
 #include <linux/kernel.h>
 #include <linux/mfd/core.h>
@@ -21,7 +21,6 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
-#include <linux/of_gpio.h>
 #include <linux/slab.h>
 
 struct ti_lmu_data {
@@ -32,17 +31,8 @@ struct ti_lmu_data {
 
 static int ti_lmu_enable_hw(struct ti_lmu *lmu, enum ti_lmu_id id)
 {
-	int ret;
-
-	if (gpio_is_valid(lmu->en_gpio)) {
-		ret = devm_gpio_request_one(lmu->dev, lmu->en_gpio,
-					    GPIOF_OUT_INIT_HIGH, "lmu_hwen");
-		if (ret) {
-			dev_err(lmu->dev, "Can not request enable GPIO: %d\n",
-				ret);
-			return ret;
-		}
-	}
+	if (lmu->en_gpio)
+		gpiod_set_value(lmu->en_gpio, 1);
 
 	/* Delay about 1ms after HW enable pin control */
 	usleep_range(1000, 1500);
@@ -59,8 +49,8 @@ static int ti_lmu_enable_hw(struct ti_lmu *lmu, enum ti_lmu_id id)
 
 static void ti_lmu_disable_hw(struct ti_lmu *lmu)
 {
-	if (gpio_is_valid(lmu->en_gpio))
-		gpio_set_value(lmu->en_gpio, 0);
+	if (lmu->en_gpio)
+		gpiod_set_value(lmu->en_gpio, 0);
 }
 
 static const struct mfd_cell lm3532_devices[] = {
@@ -204,7 +194,13 @@ static int ti_lmu_probe(struct i2c_client *cl, const struct i2c_device_id *id)
 		return PTR_ERR(lmu->regmap);
 
 	/* HW enable pin control and additional power up sequence if required */
-	lmu->en_gpio = of_get_named_gpio(dev->of_node, "enable-gpios", 0);
+	lmu->en_gpio = devm_gpiod_get_optional(dev, "enable", GPIOD_OUT_HIGH);
+	if (IS_ERR(lmu->en_gpio)) {
+		ret = PTR_ERR(lmu->en_gpio);
+		dev_err(dev, "Can not request enable GPIO: %d\n", ret);
+		return ret;
+	}
+
 	ret = ti_lmu_enable_hw(lmu, id->driver_data);
 	if (ret)
 		return ret;
diff --git a/include/linux/mfd/ti-lmu.h b/include/linux/mfd/ti-lmu.h
index 09d5f30..1ef51ed 100644
--- a/include/linux/mfd/ti-lmu.h
+++ b/include/linux/mfd/ti-lmu.h
@@ -16,6 +16,7 @@
 #include <linux/gpio.h>
 #include <linux/notifier.h>
 #include <linux/regmap.h>
+#include <linux/gpio/consumer.h>
 
 /* Notifier event */
 #define LMU_EVENT_MONITOR_DONE		0x01
@@ -81,7 +82,7 @@ enum lm363x_regulator_id {
 struct ti_lmu {
 	struct device *dev;
 	struct regmap *regmap;
-	int en_gpio;
+	struct gpio_desc *en_gpio;
 	struct blocking_notifier_head notifier;
 };
 #endif


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180911/22c2b6f5/attachment.sig>
