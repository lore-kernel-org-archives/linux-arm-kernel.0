From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 17 May 2012 14:45:16 +0100
Subject: [PATCH 11/18] regulator: Enable the ab8500 for Device Tree
In-Reply-To: <1337262323-27692-1-git-send-email-lee.jones@linaro.org>
References: <1337262323-27692-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1337262323-27692-12-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here we setup the ab8500 regulator driver for DT. We first do
this in the normal way, by providing a match structure during
initialisation, but then we provide information so that
whilst probing we can use existing data structures to do DT
look-ups.

Cc: linux-kernel at vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/regulator/ab8500.c |   54 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/drivers/regulator/ab8500.c b/drivers/regulator/ab8500.c
index 3571b54..e1b8c54 100644
--- a/drivers/regulator/ab8500.c
+++ b/drivers/regulator/ab8500.c
@@ -18,9 +18,12 @@
 #include <linux/platform_device.h>
 #include <linux/mfd/abx500.h>
 #include <linux/mfd/abx500/ab8500.h>
+#include <linux/of.h>
+#include <linux/regulator/of_regulator.h>
 #include <linux/regulator/driver.h>
 #include <linux/regulator/machine.h>
 #include <linux/regulator/ab8500.h>
+#include <linux/slab.h>
 
 /**
  * struct ab8500_regulator_info - ab8500 regulator information
@@ -790,12 +793,57 @@ static __devinit int ab8500_regulator_register(struct platform_device *pdev,
 	return 0;
 }
 
+static struct of_regulator_match ab8500_regulator_matches[] = {
+	{ .name	= "LDO-AUX1",    .driver_data = (void *) AB8500_LDO_AUX1, },
+	{ .name	= "LDO-AUX2",    .driver_data = (void *) AB8500_LDO_AUX2, },
+	{ .name	= "LDO-AUX3",    .driver_data = (void *) AB8500_LDO_AUX3, },
+	{ .name	= "LDO-INTCORE", .driver_data = (void *) AB8500_LDO_INTCORE, },
+	{ .name	= "LDO-TVOUT",   .driver_data = (void *) AB8500_LDO_TVOUT, },
+	{ .name = "LDO-USB",     .driver_data = (void *) AB8500_LDO_USB, },
+	{ .name = "LDO-AUDIO",   .driver_data = (void *) AB8500_LDO_AUDIO, },
+	{ .name	= "LDO-ANAMIC1", .driver_data = (void *) AB8500_LDO_ANAMIC1, },
+	{ .name	= "LDO-ANAMIC2", .driver_data = (void *) AB8500_LDO_ANAMIC2, },
+	{ .name	= "LDO-DMIC",    .driver_data = (void *) AB8500_LDO_DMIC, },
+	{ .name	= "LDO-ANA",     .driver_data = (void *) AB8500_LDO_ANA, },
+};
+
+static __devinit int
+ab8500_regulator_of_probe(struct platform_device *pdev, struct device_node *np)
+{
+	int err, i;
+
+	for (i = 0; i < ARRAY_SIZE(ab8500_regulator_info); i++) {
+		err = ab8500_regulator_register(
+			pdev, ab8500_regulator_matches[i].init_data,
+			i, ab8500_regulator_matches[i].of_node);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
 static __devinit int ab8500_regulator_probe(struct platform_device *pdev)
 {
 	struct ab8500 *ab8500 = dev_get_drvdata(pdev->dev.parent);
 	struct ab8500_platform_data *pdata;
+	struct device_node *np = pdev->dev.of_node;
 	int i, err;
 
+	if (np) {
+		err = of_regulator_match(&pdev->dev, np,
+					ab8500_regulator_matches,
+					ARRAY_SIZE(ab8500_regulator_matches));
+		if (err < 0) {
+			dev_err(&pdev->dev,
+				"Error parsing regulator init data: %d\n", err);
+			return err;
+		}
+
+		err = ab8500_regulator_of_probe(pdev, np);
+		return err;
+	}
+
 	if (!ab8500) {
 		dev_err(&pdev->dev, "null mfd parent\n");
 		return -EINVAL;
@@ -858,12 +906,18 @@ static __devexit int ab8500_regulator_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id ab8500_regulator_match[] = {
+        { .compatible = "stericsson,ab8500-regulator", },
+        {}
+};
+
 static struct platform_driver ab8500_regulator_driver = {
 	.probe = ab8500_regulator_probe,
 	.remove = __devexit_p(ab8500_regulator_remove),
 	.driver         = {
 		.name   = "ab8500-regulator",
 		.owner  = THIS_MODULE,
+		.of_match_table = ab8500_regulator_match,
 	},
 };
 
-- 
1.7.9.5
