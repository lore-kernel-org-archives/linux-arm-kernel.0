From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Sat, 28 Jul 2012 14:58:39 +0800
Subject: [PATCH 3/6] pinctrl: support dt in pxa series
In-Reply-To: <1343458722-17127-1-git-send-email-haojian.zhuang@gmail.com>
References: <1343458722-17127-1-git-send-email-haojian.zhuang@gmail.com>
Message-ID: <1343458722-17127-4-git-send-email-haojian.zhuang@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add DT support in PXA168/PXA910/MMP2 pinctrl driver.

Signed-off-by: Haojian Zhuang <haojian.zhuang@gmail.com>
---
 drivers/pinctrl/pinctrl-mmp2.c   |   10 ++-
 drivers/pinctrl/pinctrl-pxa168.c |   10 ++-
 drivers/pinctrl/pinctrl-pxa3xx.c |  136 ++++++++++++++++++++++++++++++++++++++
 drivers/pinctrl/pinctrl-pxa910.c |   10 ++-
 4 files changed, 163 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-mmp2.c b/drivers/pinctrl/pinctrl-mmp2.c
index 2cfed55..25b9cd3 100644
--- a/drivers/pinctrl/pinctrl-mmp2.c
+++ b/drivers/pinctrl/pinctrl-mmp2.c
@@ -14,6 +14,7 @@
 #include <linux/device.h>
 #include <linux/module.h>
 #include <linux/io.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include "pinctrl-pxa3xx.h"
 
@@ -696,10 +697,16 @@ static int __devexit mmp2_pinmux_remove(struct platform_device *pdev)
 	return pxa3xx_pinctrl_unregister(pdev);
 }
 
+static struct of_device_id mmp2_pinctrl_of_match[] __devinitdata = {
+	{ .compatible = "marvell,mmp2-pinmux", },
+	{ },
+};
+
 static struct platform_driver mmp2_pinmux_driver = {
 	.driver = {
 		.name	= "mmp2-pinmux",
 		.owner	= THIS_MODULE,
+		.of_match_table	= mmp2_pinctrl_of_match,
 	},
 	.probe	= mmp2_pinmux_probe,
 	.remove	= __devexit_p(mmp2_pinmux_remove),
@@ -718,5 +725,6 @@ static void __exit mmp2_pinmux_exit(void)
 module_exit(mmp2_pinmux_exit);
 
 MODULE_AUTHOR("Haojian Zhuang <haojian.zhuang@marvell.com>");
-MODULE_DESCRIPTION("PXA3xx pin control driver");
+MODULE_DESCRIPTION("MMP2 pin control driver");
 MODULE_LICENSE("GPL v2");
+MODULE_DEVICE_TABLE(of, mmp2_pinctrl_of_match);
diff --git a/drivers/pinctrl/pinctrl-pxa168.c b/drivers/pinctrl/pinctrl-pxa168.c
index c1997fa..959a13d 100644
--- a/drivers/pinctrl/pinctrl-pxa168.c
+++ b/drivers/pinctrl/pinctrl-pxa168.c
@@ -14,6 +14,7 @@
 #include <linux/device.h>
 #include <linux/module.h>
 #include <linux/io.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include "pinctrl-pxa3xx.h"
 
@@ -625,10 +626,16 @@ static int __devexit pxa168_pinmux_remove(struct platform_device *pdev)
 	return pxa3xx_pinctrl_unregister(pdev);
 }
 
+static struct of_device_id pxa168_pinctrl_of_match[] __devinitdata = {
+	{ .compatible = "marvell,pxa168-pinmux", },
+	{ },
+};
+
 static struct platform_driver pxa168_pinmux_driver = {
 	.driver = {
 		.name	= "pxa168-pinmux",
 		.owner	= THIS_MODULE,
+		.of_match_table	= pxa168_pinctrl_of_match,
 	},
 	.probe	= pxa168_pinmux_probe,
 	.remove	= __devexit_p(pxa168_pinmux_remove),
@@ -647,5 +654,6 @@ static void __exit pxa168_pinmux_exit(void)
 module_exit(pxa168_pinmux_exit);
 
 MODULE_AUTHOR("Haojian Zhuang <haojian.zhuang@marvell.com>");
-MODULE_DESCRIPTION("PXA3xx pin control driver");
+MODULE_DESCRIPTION("PXA168 pin control driver");
 MODULE_LICENSE("GPL v2");
+MODULE_DEVICE_TABLE(of, pxa168_pinctrl_of_match);
diff --git a/drivers/pinctrl/pinctrl-pxa3xx.c b/drivers/pinctrl/pinctrl-pxa3xx.c
index cae74db..125839f 100644
--- a/drivers/pinctrl/pinctrl-pxa3xx.c
+++ b/drivers/pinctrl/pinctrl-pxa3xx.c
@@ -14,6 +14,7 @@
 #include <linux/module.h>
 #include <linux/device.h>
 #include <linux/io.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/pinctrl/machine.h>
@@ -54,10 +55,145 @@ static int pxa3xx_get_group_pins(struct pinctrl_dev *pctrldev,
 	return 0;
 }
 
+static int pxa3xx_pinctrl_dt_node_to_map(struct pinctrl_dev *pctrl_dev,
+					 struct device_node *np_config,
+					 struct pinctrl_map **map,
+					 unsigned *num_maps)
+{
+	struct pxa3xx_pinmux_info *info = pinctrl_dev_get_drvdata(pctrl_dev);
+	struct device_node *np;
+	struct property *prop;
+	const char *func, *group;
+	int ret, count = 0, i = 0, pin_num, size;
+	u32 ds, cfg;
+
+	/* verify subnode */
+	for_each_child_of_node(np_config, np) {
+		ret = of_property_read_string(np, "marvell,function", &func);
+		if (ret < 0)
+			return ret;
+		ret = of_property_count_strings(np, "marvell,pins");
+		if (ret < 0)
+			return ret;
+		count += ret;
+		pin_num = ret;
+
+		if (!of_property_read_u32(np, "marvell,drive-strength", &ds))
+			count += pin_num;
+
+		if (of_find_property(np, "marvell,pull-up", &size)
+			|| of_find_property(np, "marvell,pull-down", &size))
+			count += pin_num;
+
+		if (of_find_property(np, "marvell,lowpower-pull-up", &size)
+			|| of_find_property(np, "marvell,lowpower-pull-down",
+				&size)
+			|| of_find_property(np, "marvell,lowpower-drive-high",
+				&size)
+			|| of_find_property(np, "marvell,lowpower-drive-low",
+				&size)
+			|| of_find_property(np, "marvell,lowpower-float", &size)
+			|| of_find_property(np, "marvell,lowpower-zero", &size))
+			count += pin_num;
+	}
+
+	if (!count) {
+		dev_err(info->dev, "No child nodes passed via DT\n");
+		return -ENODEV;
+	}
+
+	*map = kzalloc(sizeof(**map) * count, GFP_KERNEL);
+	if (!*map)
+		return -ENOMEM;
+
+	for_each_child_of_node(np_config, np) {
+		of_property_read_string(np, "marvell,function", &func);
+		of_property_for_each_string(np, "marvell,pins", prop, group) {
+			(*map)[i].type = PIN_MAP_TYPE_MUX_GROUP;
+			(*map)[i].data.mux.group = group;
+			(*map)[i].data.mux.function = func;
+			i++;
+
+			cfg = 0;
+			if (of_find_property(np, "marvell,pull-up", &size))
+				cfg = PXA3XX_PINCONF_PULL_UP;
+			else if (of_find_property(np,
+				"marvell,pull-down", &size))
+				cfg = PXA3XX_PINCONF_PULL_DOWN;
+			if (cfg) {
+				(*map)[i].type = PIN_MAP_TYPE_CONFIGS_GROUP;
+				(*map)[i].data.configs.configs =
+					kmemdup(&cfg, sizeof(cfg), GFP_KERNEL);
+				(*map)[i].data.configs.group_or_pin = group;
+				(*map)[i].data.configs.num_configs = 1;
+				i++;
+			}
+
+			cfg = 0;
+			if (of_find_property(np, "marvell,lowpower-pull-up",
+				&size))
+				cfg = PXA3XX_PINCONF_LOWPOWER_PULL_UP;
+			else if (of_find_property(np,
+				"marvell,lowpower-pull-down", &size))
+				cfg = PXA3XX_PINCONF_LOWPOWER_PULL_DOWN;
+			else if (of_find_property(np,
+				"marvell,lowpower-drive-high", &size))
+				cfg = PXA3XX_PINCONF_LOWPOWER_DRIVE_HIGH;
+			else if (of_find_property(np,
+				"marvell,lowpower-drive-low", &size))
+				cfg = PXA3XX_PINCONF_LOWPOWER_DRIVE_LOW;
+			else if (of_find_property(np,
+				"marvell,lowpower-float", &size))
+				cfg = PXA3XX_PINCONF_LOWPOWER_FLOAT;
+			else if (of_find_property(np,
+				"marvell,lowpower-zero", &size))
+				cfg = PXA3XX_PINCONF_LOWPOWER_ZERO;
+			if (cfg) {
+				(*map)[i].type = PIN_MAP_TYPE_CONFIGS_GROUP;
+				(*map)[i].data.configs.configs =
+					kmemdup(&cfg, sizeof(cfg), GFP_KERNEL);
+				(*map)[i].data.configs.group_or_pin = group;
+				(*map)[i].data.configs.num_configs = 1;
+				i++;
+			}
+
+			cfg = 0;
+			if (!of_property_read_u32(np,
+				"marvell,drive-strength", &ds))
+				cfg = PXA3XX_PINCONF_DRIVE_STRENGTH
+					| (ds << PXA3XX_PINCONF_DS_SHIFT);
+			if (cfg) {
+				(*map)[i].type = PIN_MAP_TYPE_CONFIGS_GROUP;
+				(*map)[i].data.configs.configs =
+					kmemdup(&cfg, sizeof(cfg), GFP_KERNEL);
+				(*map)[i].data.configs.group_or_pin = group;
+				(*map)[i].data.configs.num_configs = 1;
+				i++;
+			}
+		}
+	}
+	*num_maps = count;
+	return 0;
+}
+
+static void pxa3xx_pinctrl_dt_free_map(struct pinctrl_dev *pctrl_dev,
+				       struct pinctrl_map *map,
+				       unsigned num_maps)
+{
+	int i;
+
+	for (i = 0; i < num_maps; i++)
+		if (map[i].type == PIN_MAP_TYPE_CONFIGS_GROUP)
+			kfree(map[i].data.configs.configs);
+	kfree(map);
+}
+
 static struct pinctrl_ops pxa3xx_pctrl_ops = {
 	.get_groups_count = pxa3xx_get_groups_count,
 	.get_group_name	= pxa3xx_get_group_name,
 	.get_group_pins	= pxa3xx_get_group_pins,
+	.dt_node_to_map = pxa3xx_pinctrl_dt_node_to_map,
+	.dt_free_map = pxa3xx_pinctrl_dt_free_map,
 };
 
 static int pxa3xx_pmx_get_funcs_count(struct pinctrl_dev *pctrldev)
diff --git a/drivers/pinctrl/pinctrl-pxa910.c b/drivers/pinctrl/pinctrl-pxa910.c
index 4164a6b..ccda259 100644
--- a/drivers/pinctrl/pinctrl-pxa910.c
+++ b/drivers/pinctrl/pinctrl-pxa910.c
@@ -14,6 +14,7 @@
 #include <linux/device.h>
 #include <linux/module.h>
 #include <linux/io.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include "pinctrl-pxa3xx.h"
 
@@ -985,10 +986,16 @@ static int __devexit pxa910_pinmux_remove(struct platform_device *pdev)
 	return pxa3xx_pinctrl_unregister(pdev);
 }
 
+static struct of_device_id pxa910_pinctrl_of_match[] __devinitdata = {
+	{ .compatible = "marvell,pxa910-pinmux", },
+	{ },
+};
+
 static struct platform_driver pxa910_pinmux_driver = {
 	.driver = {
 		.name	= "pxa910-pinmux",
 		.owner	= THIS_MODULE,
+		.of_match_table	= pxa910_pinctrl_of_match,
 	},
 	.probe	= pxa910_pinmux_probe,
 	.remove	= __devexit_p(pxa910_pinmux_remove),
@@ -1007,5 +1014,6 @@ static void __exit pxa910_pinmux_exit(void)
 module_exit(pxa910_pinmux_exit);
 
 MODULE_AUTHOR("Haojian Zhuang <haojian.zhuang@marvell.com>");
-MODULE_DESCRIPTION("PXA3xx pin control driver");
+MODULE_DESCRIPTION("PXA910 pin control driver");
 MODULE_LICENSE("GPL v2");
+MODULE_DEVICE_TABLE(of, pxa910_pinctrl_of_match);
-- 
1.7.9.5
