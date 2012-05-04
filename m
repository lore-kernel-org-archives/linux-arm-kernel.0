From: lee.jones@linaro.org (Lee Jones)
Date: Fri,  4 May 2012 19:23:21 +0100
Subject: [PATCH 11/15] drivers/mfd: Enable Device Tree for ab8500-core driver
In-Reply-To: <1336155805-18554-1-git-send-email-lee.jones@linaro.org>
References: <1336155805-18554-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1336155805-18554-12-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch will allow the ab8500-core driver to be probed and set up
when booting when Device Tree is enabled. This includes platform ID
look-up which identifies the machine it is currently running on. If
we are undergoing a DT enabled boot, we will refuse to setup each of
the other ab8500-* devices, as they will be probed individually by DT.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/ab8500-core.c |   62 ++++++++++++++++++++++++++++++++-------------
 1 file changed, 45 insertions(+), 17 deletions(-)

diff --git a/drivers/mfd/ab8500-core.c b/drivers/mfd/ab8500-core.c
index 74e6661..9f8547e 100644
--- a/drivers/mfd/ab8500-core.c
+++ b/drivers/mfd/ab8500-core.c
@@ -20,6 +20,8 @@
 #include <linux/mfd/abx500/ab8500.h>
 #include <linux/mfd/dbx500-prcmu.h>
 #include <linux/regulator/ab8500.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
 
 /*
  * Interrupt register offsets
@@ -1039,11 +1041,20 @@ static struct attribute_group ab9540_attr_group = {
 	.attrs	= ab9540_sysfs_entries,
 };
 
+static const struct of_device_id ab8500_match[] = {
+	{
+		.compatible = "stericsson,ab8500",
+		.data = (void *)AB8500_VERSION_AB8500,
+	},
+	{},
+};
+
 static int __devinit ab8500_probe(struct platform_device *pdev)
 {
 	struct ab8500_platform_data *plat = dev_get_platdata(&pdev->dev);
 	const struct platform_device_id *platid = platform_get_device_id(pdev);
-	enum ab8500_version version = platid->driver_data;
+	enum ab8500_version version = AB8500_VERSION_UNDEFINED;
+	struct device_node *np = pdev->dev.of_node;
 	struct ab8500 *ab8500;
 	struct resource *resource;
 	int ret;
@@ -1056,6 +1067,14 @@ static int __devinit ab8500_probe(struct platform_device *pdev)
 
 	if (plat)
 		ab8500->irq_base = plat->irq_base;
+	else if (np)
+		ret = of_property_read_u32(np, "stericsson,irq-base", &ab8500->irq_base);
+
+	if (ab8500->irq_base == 0) {
+		dev_info(&pdev->dev, "couldn't find irq-base\n");
+		ret = -EINVAL;
+		goto out_free_ab8500;
+	}
 
 	ab8500->dev = &pdev->dev;
 
@@ -1076,6 +1095,12 @@ static int __devinit ab8500_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, ab8500);
 
+	if (platid)
+		version = platid->driver_data;
+	else if (np)
+		version = (unsigned int)
+			of_match_device(ab8500_match, &pdev->dev)->data;
+
 	if (version != AB8500_VERSION_UNDEFINED)
 		ab8500->version = version;
 	else {
@@ -1172,23 +1197,25 @@ static int __devinit ab8500_probe(struct platform_device *pdev)
 			goto out_removeirq;
 	}
 
-	ret = mfd_add_devices(ab8500->dev, 0, abx500_common_devs,
-			      ARRAY_SIZE(abx500_common_devs), NULL,
-			      ab8500->irq_base);
+	if (!np) {
+		ret = mfd_add_devices(ab8500->dev, 0, abx500_common_devs,
+				ARRAY_SIZE(abx500_common_devs), NULL,
+				ab8500->irq_base);
 
-	if (ret)
-		goto out_freeirq;
-
-	if (is_ab9540(ab8500))
-		ret = mfd_add_devices(ab8500->dev, 0, ab9540_devs,
-			      ARRAY_SIZE(ab9540_devs), NULL,
-			      ab8500->irq_base);
-	else
-		ret = mfd_add_devices(ab8500->dev, 0, ab8500_devs,
-			      ARRAY_SIZE(ab9540_devs), NULL,
-			      ab8500->irq_base);
-	if (ret)
-		goto out_freeirq;
+		if (ret)
+			goto out_freeirq;
+
+		if (is_ab9540(ab8500))
+			ret = mfd_add_devices(ab8500->dev, 0, ab9540_devs,
+					ARRAY_SIZE(ab9540_devs), NULL,
+					ab8500->irq_base);
+		else
+			ret = mfd_add_devices(ab8500->dev, 0, ab8500_devs,
+					ARRAY_SIZE(ab9540_devs), NULL,
+					ab8500->irq_base);
+		if (ret)
+			goto out_freeirq;
+	}
 
 	if (is_ab9540(ab8500))
 		ret = sysfs_create_group(&ab8500->dev->kobj,
@@ -1249,6 +1276,7 @@ static struct platform_driver ab8500_core_driver = {
 	.driver = {
 		.name = "ab8500-core",
 		.owner = THIS_MODULE,
+		.of_match_table = ab8500_match,
 	},
 	.probe	= ab8500_probe,
 	.remove	= __devexit_p(ab8500_remove),
-- 
1.7.9.5
