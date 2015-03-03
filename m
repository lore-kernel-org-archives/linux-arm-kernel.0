From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue,  3 Mar 2015 10:32:26 +0100
Subject: [PATCH 3/5] leds: syscon: instantiate from platform device
In-Reply-To: <1425375148-4369-1-git-send-email-linus.walleij@linaro.org>
References: <1425375148-4369-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1425375148-4369-4-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently syscon LEDs will traverse the device tree looking for syscon devices
and if found, traverse any subnodes of these to identify matching children
and from there instantiate LED class devices.

This is not a good use of the Linux device model. Instead we have converted the
device trees to add the "simple-mfd" property to the MFD nexi spawning syscon
LEDs so that these will appear as platform devices in the system and we can
use the proper device probing mechanism.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Bryan: if you're OK with it, please ACK this patch so we can funnel it through
ARM SoC with the rest of the patches in this series.
---
 drivers/leds/leds-syscon.c | 170 ++++++++++++++++++++++-----------------------
 1 file changed, 85 insertions(+), 85 deletions(-)

diff --git a/drivers/leds/leds-syscon.c b/drivers/leds/leds-syscon.c
index 6896e2d9ba58..d1660b039812 100644
--- a/drivers/leds/leds-syscon.c
+++ b/drivers/leds/leds-syscon.c
@@ -20,6 +20,7 @@
  * MA 02111-1307 USA
  */
 #include <linux/io.h>
+#include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/of_address.h>
 #include <linux/platform_device.h>
@@ -66,102 +67,101 @@ static void syscon_led_set(struct led_classdev *led_cdev,
 		dev_err(sled->cdev.dev, "error updating LED status\n");
 }
 
-static int __init syscon_leds_spawn(struct device_node *np,
-				    struct device *dev,
-				    struct regmap *map)
+static int syscon_led_probe(struct platform_device *pdev)
 {
-	struct device_node *child;
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	struct device *parent;
+	struct regmap *map;
+	struct syscon_led *sled;
+	const char *state;
 	int ret;
 
-	for_each_available_child_of_node(np, child) {
-		struct syscon_led *sled;
-		const char *state;
-
-		/* Only check for register-bit-leds */
-		if (of_property_match_string(child, "compatible",
-					     "register-bit-led") < 0)
-			continue;
-
-		sled = devm_kzalloc(dev, sizeof(*sled), GFP_KERNEL);
-		if (!sled)
-			return -ENOMEM;
-
-		sled->map = map;
-
-		if (of_property_read_u32(child, "offset", &sled->offset))
-			return -EINVAL;
-		if (of_property_read_u32(child, "mask", &sled->mask))
-			return -EINVAL;
-		sled->cdev.name =
-			of_get_property(child, "label", NULL) ? : child->name;
-		sled->cdev.default_trigger =
-			of_get_property(child, "linux,default-trigger", NULL);
-
-		state = of_get_property(child, "default-state", NULL);
-		if (state) {
-			if (!strcmp(state, "keep")) {
-				u32 val;
-
-				ret = regmap_read(map, sled->offset, &val);
-				if (ret < 0)
-					return ret;
-				sled->state = !!(val & sled->mask);
-			} else if (!strcmp(state, "on")) {
-				sled->state = true;
-				ret = regmap_update_bits(map, sled->offset,
-							 sled->mask,
-							 sled->mask);
-				if (ret < 0)
-					return ret;
-			} else {
-				sled->state = false;
-				ret = regmap_update_bits(map, sled->offset,
-							 sled->mask, 0);
-				if (ret < 0)
-					return ret;
-			}
+	parent = dev->parent;
+	if (!parent) {
+		dev_err(dev, "no parent for syscon LED\n");
+		return -ENODEV;
+	}
+	map = syscon_node_to_regmap(parent->of_node);
+	if (!map) {
+		dev_err(dev, "no regmap for syscon LED parent\n");
+		return -ENODEV;
+	}
+
+	sled = devm_kzalloc(dev, sizeof(*sled), GFP_KERNEL);
+	if (!sled)
+		return -ENOMEM;
+
+	sled->map = map;
+
+	if (of_property_read_u32(np, "offset", &sled->offset))
+		return -EINVAL;
+	if (of_property_read_u32(np, "mask", &sled->mask))
+		return -EINVAL;
+	sled->cdev.name =
+		of_get_property(np, "label", NULL) ? : np->name;
+	sled->cdev.default_trigger =
+		of_get_property(np, "linux,default-trigger", NULL);
+
+	state = of_get_property(np, "default-state", NULL);
+	if (state) {
+		if (!strcmp(state, "keep")) {
+			u32 val;
+
+			ret = regmap_read(map, sled->offset, &val);
+			if (ret < 0)
+				return ret;
+			sled->state = !!(val & sled->mask);
+		} else if (!strcmp(state, "on")) {
+			sled->state = true;
+			ret = regmap_update_bits(map, sled->offset,
+						 sled->mask,
+						 sled->mask);
+			if (ret < 0)
+				return ret;
+		} else {
+			sled->state = false;
+			ret = regmap_update_bits(map, sled->offset,
+						 sled->mask, 0);
+			if (ret < 0)
+				return ret;
 		}
-		sled->cdev.brightness_set = syscon_led_set;
+	}
+	sled->cdev.brightness_set = syscon_led_set;
 
-		ret = led_classdev_register(dev, &sled->cdev);
-		if (ret < 0)
-			return ret;
+	ret = led_classdev_register(dev, &sled->cdev);
+	if (ret < 0)
+		return ret;
+
+	platform_set_drvdata(pdev, sled);
+	dev_info(dev, "registered LED %s\n", sled->cdev.name);
 
-		dev_info(dev, "registered LED %s\n", sled->cdev.name);
-	}
 	return 0;
 }
 
-static int __init syscon_leds_init(void)
+static int syscon_led_remove(struct platform_device *pdev)
 {
-	struct device_node *np;
-
-	for_each_of_allnodes(np) {
-		struct platform_device *pdev;
-		struct regmap *map;
-		int ret;
+	struct syscon_led *sled = platform_get_drvdata(pdev);
 
-		if (!of_device_is_compatible(np, "syscon"))
-			continue;
+	led_classdev_unregister(&sled->cdev);
+	/* Turn it off */
+	regmap_update_bits(sled->map, sled->offset, sled->mask, 0);
+	return 0;
+}
 
-		map = syscon_node_to_regmap(np);
-		if (IS_ERR(map)) {
-			pr_err("error getting regmap for syscon LEDs\n");
-			continue;
-		}
+static const struct of_device_id of_syscon_leds_match[] = {
+	{ .compatible = "register-bit-led", },
+	{},
+};
 
-		/*
-		 * If the map is there, the device should be there, we allocate
-		 * memory on the syscon device's behalf here.
-		 */
-		pdev = of_find_device_by_node(np);
-		if (!pdev)
-			return -ENODEV;
-		ret = syscon_leds_spawn(np, &pdev->dev, map);
-		if (ret)
-			dev_err(&pdev->dev, "could not spawn syscon LEDs\n");
-	}
+MODULE_DEVICE_TABLE(of, of_syscon_leds_match);
 
-	return 0;
-}
-device_initcall(syscon_leds_init);
+static struct platform_driver syscon_led_driver = {
+	.probe		= syscon_led_probe,
+	.remove		= syscon_led_remove,
+	.driver		= {
+		.name	= "leds-syscon",
+		.of_match_table = of_syscon_leds_match,
+	},
+};
+module_platform_driver(syscon_led_driver);
-- 
1.9.3
