From: rajanikanth.hv@stericsson.com (Rajanikanth H.V)
Date: Mon, 1 Oct 2012 09:38:33 +0530
Subject: [PATCH 4/4] mfd: ab8500: add devicetree support for charging algorithm
In-Reply-To: <1349064513-31301-1-git-send-email-rajanikanth.hv@stericsson.com>
References: <1349064513-31301-1-git-send-email-rajanikanth.hv@stericsson.com>
Message-ID: <1349064513-31301-5-git-send-email-rajanikanth.hv@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Rajanikanth H.V" <rajanikanth.hv@stericsson.com>

This patch adds device tree support for charging algorithm
driver

Signed-off-by: Rajanikanth H.V <rajanikanth.hv@stericsson.com>
---
 .../bindings/power_supply/ab8500/chargalg.txt      |   36 ++++++++++++
 drivers/mfd/ab8500-core.c                          |    1 +
 drivers/power/abx500_chargalg.c                    |   58 ++++++++++++++++----
 3 files changed, 83 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power_supply/ab8500/chargalg.txt

diff --git a/Documentation/devicetree/bindings/power_supply/ab8500/chargalg.txt b/Documentation/devicetree/bindings/power_supply/ab8500/chargalg.txt
new file mode 100644
index 0000000..73b7ccc
--- /dev/null
+++ b/Documentation/devicetree/bindings/power_supply/ab8500/chargalg.txt
@@ -0,0 +1,36 @@
+=== AB8500 Charging Algorithm Driver ===
+
+Charging algorithm is logical part of energy-management-module
+which implements the state machine to handle charing status w.r.t
+VBUS and main charger, battery-state, over-voltage protection,
+'battery-temperature' status.
+Charging algorithm also implements subset of power-supply properties.
+Ref: enum power_supply_property, include/linux/power_supply.h
+
+This module does not directly interact with h/w, it primarily depends
+on fuel-gauge and runtime battery status information.
+
+The properties below describes the node for Charging Algorithm
+module:
+
+Required Properties:
+- compatible = "stericsson,ab8500-chargalg"
+- interface-name:
+	Name of the controller/driver which is part of energy-management-module
+- supplied-to:
+	This property shall have dependent nodes which represent other
+	energy-management-module.
+	example:
+	ab8500-btemp {
+		/* dependent energy management module */
+		supplied-to = <&ab8500_fuel_gauge>;
+	};
+
+Other dependent node is:
+	ab8500_battery_info: ab8500_bat_type {
+	};
+	This node will provide information on 'thermistor interface' and
+	'battery technology type' used.
+
+ref: further details.
+	Documentation/devicetree/bindings/power_supply/ab8500/fg.txt
diff --git a/drivers/mfd/ab8500-core.c b/drivers/mfd/ab8500-core.c
index 0c81138..0ab3506 100644
--- a/drivers/mfd/ab8500-core.c
+++ b/drivers/mfd/ab8500-core.c
@@ -1059,6 +1059,7 @@ static struct mfd_cell __devinitdata ab8500_bm_devs[] = {
 	},
 	{
 		.name = "ab8500-chargalg",
+		.of_compatible = "stericsson,ab8500-chargalg",
 		.num_resources = ARRAY_SIZE(ab8500_chargalg_resources),
 		.resources = ab8500_chargalg_resources,
 	},
diff --git a/drivers/power/abx500_chargalg.c b/drivers/power/abx500_chargalg.c
index ba548e4..8d83580 100644
--- a/drivers/power/abx500_chargalg.c
+++ b/drivers/power/abx500_chargalg.c
@@ -21,6 +21,7 @@
 #include <linux/completion.h>
 #include <linux/workqueue.h>
 #include <linux/kobject.h>
+#include <linux/of.h>
 #include <linux/mfd/abx500.h>
 #include <linux/mfd/abx500/ux500_chargalg.h>
 #include <linux/mfd/abx500/ab8500-bm.h>
@@ -1795,27 +1796,56 @@ static int __devexit abx500_chargalg_remove(struct platform_device *pdev)
 	flush_scheduled_work();
 	power_supply_unregister(&di->chargalg_psy);
 	platform_set_drvdata(pdev, NULL);
-	kfree(di);
 
 	return 0;
 }
 
 static int __devinit abx500_chargalg_probe(struct platform_device *pdev)
 {
-	struct abx500_bm_plat_data *plat_data;
 	int ret = 0;
+	struct abx500_chargalg *di;
+	struct device_node *np = pdev->dev.of_node;
+	struct abx500_bm_plat_data *plat_data = pdev->dev.platform_data;
 
-	struct abx500_chargalg *di =
-		kzalloc(sizeof(struct abx500_chargalg), GFP_KERNEL);
-	if (!di)
+	di = devm_kzalloc(&pdev->dev, sizeof(*di), GFP_KERNEL);
+	if (!di) {
+		dev_err(&pdev->dev, "%s no mem for ab8500_chargalg\n", __func__);
 		return -ENOMEM;
+	}
+	if (np) {
+		if (!plat_data) {
+			plat_data =
+			devm_kzalloc(&pdev->dev, sizeof(*plat_data),
+					GFP_KERNEL);
+			if (!plat_data) {
+				dev_err(&pdev->dev,
+					"%s no mem for plat_data\n", __func__);
+				return -ENOMEM;
+			}
+			plat_data->bmdev_pdata = devm_kzalloc(&pdev->dev,
+				sizeof(*plat_data->bmdev_pdata), GFP_KERNEL);
+			if (!plat_data->bmdev_pdata) {
+				dev_err(&pdev->dev,
+					"%s no mem for pdata->chargalg\n",
+					__func__);
+				return -ENOMEM;
+			}
+		}
+		ret = bmdevs_of_probe(&pdev->dev, np, plat_data);
+		if (ret < 0) {
+			dev_err(&pdev->dev, "failed to get platform data\n");
+			return ret;
+		}
+	}
+	if (!plat_data) {
+		dev_err(&pdev->dev, "No platform data\n");
+		return -EINVAL;
+	}
 
 	/* get device struct */
-	di->dev = &pdev->dev;
-
-	plat_data = pdev->dev.platform_data;
+	di->dev	  = &pdev->dev;
 	di->pdata = plat_data->bmdev_pdata;
-	di->bat = plat_data->battery;
+	di->bat   = plat_data->battery;
 
 	/* chargalg supply */
 	di->chargalg_psy.name = "abx500_chargalg";
@@ -1844,7 +1874,7 @@ static int __devinit abx500_chargalg_probe(struct platform_device *pdev)
 		create_singlethread_workqueue("abx500_chargalg_wq");
 	if (di->chargalg_wq == NULL) {
 		dev_err(di->dev, "failed to create work queue\n");
-		goto free_device_info;
+		return -ENOMEM;
 	}
 
 	/* Init work for chargalg */
@@ -1885,12 +1915,15 @@ free_psy:
 	power_supply_unregister(&di->chargalg_psy);
 free_chargalg_wq:
 	destroy_workqueue(di->chargalg_wq);
-free_device_info:
-	kfree(di);
 
 	return ret;
 }
 
+static const struct of_device_id ab8500_chargalg_match[] = {
+	{.compatible = "stericsson,ab8500-chargalg",},
+	{},
+};
+
 static struct platform_driver abx500_chargalg_driver = {
 	.probe = abx500_chargalg_probe,
 	.remove = __devexit_p(abx500_chargalg_remove),
@@ -1899,6 +1932,7 @@ static struct platform_driver abx500_chargalg_driver = {
 	.driver = {
 		.name = "abx500-chargalg",
 		.owner = THIS_MODULE,
+		.of_match_table = ab8500_chargalg_match,
 	},
 };
 
-- 
1.7.9.5
