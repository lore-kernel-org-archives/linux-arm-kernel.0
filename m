From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 27 Nov 2015 14:43:23 +0800
Subject: [PATCH v5 2/9] mfd: axp20x: Remove second struct device * parameter
 for axp20x_match_device()
In-Reply-To: <1448606610-32647-1-git-send-email-wens@csie.org>
References: <1448606610-32647-1-git-send-email-wens@csie.org>
Message-ID: <1448606610-32647-3-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The first argument passed to axp20x_match_device(), struct axp20x_dev *,
already contains a pointer to the device. By rearranging some code,
moving the assignment of the pointer before axp20x_match_device() is
called, we can eliminate the second parameter.

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/mfd/axp20x.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index 9842199e2e6c..685a78614f83 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -606,8 +606,9 @@ static void axp20x_power_off(void)
 		     AXP20X_OFF);
 }
 
-static int axp20x_match_device(struct axp20x_dev *axp20x, struct device *dev)
+static int axp20x_match_device(struct axp20x_dev *axp20x)
 {
+	struct device *dev = axp20x->dev;
 	const struct acpi_device_id *acpi_id;
 	const struct of_device_id *of_id;
 
@@ -673,14 +674,14 @@ static int axp20x_i2c_probe(struct i2c_client *i2c,
 	if (!axp20x)
 		return -ENOMEM;
 
-	ret = axp20x_match_device(axp20x, &i2c->dev);
-	if (ret)
-		return ret;
-
 	axp20x->i2c_client = i2c;
 	axp20x->dev = &i2c->dev;
 	dev_set_drvdata(axp20x->dev, axp20x);
 
+	ret = axp20x_match_device(axp20x);
+	if (ret)
+		return ret;
+
 	axp20x->regmap = devm_regmap_init_i2c(i2c, axp20x->regmap_cfg);
 	if (IS_ERR(axp20x->regmap)) {
 		ret = PTR_ERR(axp20x->regmap);
-- 
2.6.2
