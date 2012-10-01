From: rajanikanth.hv@stericsson.com (Rajanikanth H.V)
Date: Mon, 1 Oct 2012 09:38:31 +0530
Subject: =?UTF-8?q?=5BPATCH=202/4=5D=20mfd=3A=20ab8500=3A=20add=20devicetree=20support=20for=20Btemp?=
In-Reply-To: <1349064513-31301-1-git-send-email-rajanikanth.hv@stericsson.com>
References: <1349064513-31301-1-git-send-email-rajanikanth.hv@stericsson.com>
Message-ID: <1349064513-31301-3-git-send-email-rajanikanth.hv@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Rajanikanth H.V" <rajanikanth.hv@stericsson.com>

This patch adds device tree support for
battery-temperature-monitor-driver

Signed-off-by: Rajanikanth H.V <rajanikanth.hv@stericsson.com>
---
 Documentation/devicetree/bindings/mfd/ab8500.txt   |    7 ++-
 .../bindings/power_supply/ab8500/btemp.txt         |   29 +++++++++++
 arch/arm/boot/dts/dbx5x0.dtsi                      |    7 +++
 drivers/mfd/ab8500-core.c                          |    1 +
 drivers/power/Kconfig                              |    6 ---
 drivers/power/ab8500_bmdata.c                      |    4 +-
 drivers/power/ab8500_btemp.c                       |   53 +++++++++++++++-----
 7 files changed, 86 insertions(+), 21 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power_supply/ab8500/btemp.txt

diff --git a/Documentation/devicetree/bindings/mfd/ab8500.txt b/Documentation/devicetree/bindings/mfd/ab8500.txt
index 762dc11..47d232e 100644
--- a/Documentation/devicetree/bindings/mfd/ab8500.txt
+++ b/Documentation/devicetree/bindings/mfd/ab8500.txt
@@ -30,7 +30,12 @@ ab8500-fg                : 			: vddadc       : Fuel Gauge
 			 : LOW_BAT_F		:	       : LOW threshold battery voltage
 			 : CC_INT_CALIB		:	       : Counter Counter Internal Calibration
 			 : CCEOC		:	       : Coulomb Counter End of Conversion
-			 :			:	       :
+ab8500-btemp		 :			: vtvout       : Battery Temperature
+			 : BAT_CTRL_INDB        :              : Battery Removal Indicator
+			 : BTEMP_LOW            :              : Btemp < BtempLow, if battery temperature is lower than -10?C
+			 : BTEMP_HIGH           :              : BtempLow < Btemp < BtempMedium,if battery temperature is between -10 and 0?C
+			 : BTEMP_LOW_MEDIUM     :              : BtempMedium < Btemp < BtempHigh,if battery temperature is between 0?C and?MaxTemp
+			 : BTEMP_MEDIUM_HIGH    :	       : Btemp > BtempHigh, if battery temperature is higher than ?MaxTemp?
 ab8500-gpadc             : HW_CONV_END          : vddadc       : Analogue to Digital Converter
                            SW_CONV_END          :              :
 ab8500-gpio              :                      :              : GPIO Controller
diff --git a/Documentation/devicetree/bindings/power_supply/ab8500/btemp.txt b/Documentation/devicetree/bindings/power_supply/ab8500/btemp.txt
new file mode 100644
index 0000000..f58c697
--- /dev/null
+++ b/Documentation/devicetree/bindings/power_supply/ab8500/btemp.txt
@@ -0,0 +1,29 @@
+=== AB8500 Battery Temperature Monitor Driver ===
+
+Battery temperature monitoring support is part of energy-
+management-module, the other components of this module
+are: main-charger, usb-combo-charger and fuel-gauge.
+
+The properties below describes the node for battery
+temperature monitor driver.
+
+Required Properties:
+- compatible = "stericsson,ab8500-btemp"
+- interface-name:
+	Name of the controller/driver which is part of energy-management-module
+- supplied-to:
+	This property shall have dependent nodes which represent other
+	energy-management-module.
+	example:
+	ab8500-btemp {
+		/* dependent energy management modules */
+		supplied-to = <&ab8500_chargalg &ab8500_fuel_gauge>;
+	};
+Other dependent node for battery temperature is:
+	ab8500_battery_info: ab8500_bat_type {
+	};
+	This node will provide information on 'thermistor interface' and
+	'battery technology type' used.
+
+ref: further details.
+	Documentation/devicetree/bindings/power_supply/ab8500/fg.txt
diff --git a/arch/arm/boot/dts/dbx5x0.dtsi b/arch/arm/boot/dts/dbx5x0.dtsi
index bd22c56..9f5fde8 100644
--- a/arch/arm/boot/dts/dbx5x0.dtsi
+++ b/arch/arm/boot/dts/dbx5x0.dtsi
@@ -371,6 +371,13 @@
 					supplied-to    = <&ab8500_chargalg &ab8500_usb>;
 				};
 
+				ab8500_battery_temp: ab8500_btemp {
+					compatible     = "stericsson,ab8500-btemp";
+					interface-name = "ab8500_btemp";
+					battery-info   = <&ab8500_battery_info>;
+					supplied-to    = <&ab8500_chargalg &ab8500_fuel_gauge>;
+				};
+
 				ab8500_usb: ab8500_usb_if {
 					compatible = "stericsson,ab8500-usb";
 					interface-name = "ab8500_usb";
diff --git a/drivers/mfd/ab8500-core.c b/drivers/mfd/ab8500-core.c
index 6c3d7c2..0173417 100644
--- a/drivers/mfd/ab8500-core.c
+++ b/drivers/mfd/ab8500-core.c
@@ -1046,6 +1046,7 @@ static struct mfd_cell __devinitdata ab8500_bm_devs[] = {
 	},
 	{
 		.name = "ab8500-btemp",
+		.of_compatible = "stericsson,ab8500-btemp",
 		.num_resources = ARRAY_SIZE(ab8500_btemp_resources),
 		.resources = ab8500_btemp_resources,
 	},
diff --git a/drivers/power/Kconfig b/drivers/power/Kconfig
index c1892f3..1434871 100644
--- a/drivers/power/Kconfig
+++ b/drivers/power/Kconfig
@@ -304,12 +304,6 @@ config AB8500_BM
 	help
 	  Say Y to include support for AB8500 battery management.
 
-config AB8500_BATTERY_THERM_ON_BATCTRL
-	bool "Thermistor connected on BATCTRL ADC"
-	depends on AB8500_BM
-	help
-	  Say Y to enable battery temperature measurements using
-	  thermistor connected on BATCTRL ADC.
 endif # POWER_SUPPLY
 
 source "drivers/power/avs/Kconfig"
diff --git a/drivers/power/ab8500_bmdata.c b/drivers/power/ab8500_bmdata.c
index d0def3b..90d0e51 100644
--- a/drivers/power/ab8500_bmdata.c
+++ b/drivers/power/ab8500_bmdata.c
@@ -29,7 +29,7 @@ static struct abx500_res_to_temp temp_tbl_A_thermistor[] = {
 	{65, 12500},
 };
 static struct abx500_res_to_temp temp_tbl_B_thermistor[] = {
-	{-5, 165418},
+	{-5, 200000},
 	{ 0, 159024},
 	{ 5, 151921},
 	{10, 144300},
@@ -237,7 +237,7 @@ struct abx500_battery_type bat_type_thermistor[] = {
 },
 {
 	.name = POWER_SUPPLY_TECHNOLOGY_LIPO,
-	.resis_high = 165418,
+	.resis_high = 200000,
 	.resis_low = 82869,
 	.battery_resistance = 300,
 	.charge_full_design = 900,
diff --git a/drivers/power/ab8500_btemp.c b/drivers/power/ab8500_btemp.c
index 8e427e7..c4291e0 100644
--- a/drivers/power/ab8500_btemp.c
+++ b/drivers/power/ab8500_btemp.c
@@ -20,6 +20,7 @@
 #include <linux/power_supply.h>
 #include <linux/completion.h>
 #include <linux/workqueue.h>
+#include <linux/of.h>
 #include <linux/mfd/abx500/ab8500.h>
 #include <linux/mfd/abx500.h>
 #include <linux/mfd/abx500/ab8500-bm.h>
@@ -955,7 +956,6 @@ static int __devexit ab8500_btemp_remove(struct platform_device *pdev)
 	flush_scheduled_work();
 	power_supply_unregister(&di->btemp_psy);
 	platform_set_drvdata(pdev, NULL);
-	kfree(di);
 
 	return 0;
 }
@@ -965,17 +965,44 @@ static int __devinit ab8500_btemp_probe(struct platform_device *pdev)
 	int irq, i, ret = 0;
 	u8 val;
 	struct abx500_bm_plat_data *plat_data = pdev->dev.platform_data;
+	struct device_node *np = pdev->dev.of_node;
 	struct ab8500_btemp *di;
 
+	di = devm_kzalloc(&pdev->dev, sizeof(*di), GFP_KERNEL);
+	if (!di) {
+		dev_err(&pdev->dev, "%s no mem for ab8500_btemp\n", __func__);
+		return -ENOMEM;
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
+					"%s no mem for pdata->btemp\n",
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
 	if (!plat_data) {
 		dev_err(&pdev->dev, "No platform data\n");
 		return -EINVAL;
 	}
 
-	di = kzalloc(sizeof(*di), GFP_KERNEL);
-	if (!di)
-		return -ENOMEM;
-
 	/* get parent data */
 	di->dev = &pdev->dev;
 	di->parent = dev_get_drvdata(pdev->dev.parent);
@@ -985,16 +1012,14 @@ static int __devinit ab8500_btemp_probe(struct platform_device *pdev)
 	di->pdata = plat_data->bmdev_pdata;
 	if (!di->pdata) {
 		dev_err(di->dev, "no btemp platform data supplied\n");
-		ret = -EINVAL;
-		goto free_device_info;
+		return -EINVAL;
 	}
 
 	/* get battery specific platform data */
 	di->bat = plat_data->battery;
 	if (!di->bat) {
 		dev_err(di->dev, "no battery platform data supplied\n");
-		ret = -EINVAL;
-		goto free_device_info;
+		return -EINVAL;
 	}
 
 	/* BTEMP supply */
@@ -1014,7 +1039,7 @@ static int __devinit ab8500_btemp_probe(struct platform_device *pdev)
 		create_singlethread_workqueue("ab8500_btemp_wq");
 	if (di->btemp_wq == NULL) {
 		dev_err(di->dev, "failed to create work queue\n");
-		goto free_device_info;
+		return -ENOMEM;
 	}
 
 	/* Init work for measuring temperature periodically */
@@ -1092,12 +1117,15 @@ free_irq:
 	}
 free_btemp_wq:
 	destroy_workqueue(di->btemp_wq);
-free_device_info:
-	kfree(di);
 
 	return ret;
 }
 
+static const struct of_device_id ab8500_btemp_match[] = {
+	{.compatible = "stericsson,ab8500-btemp",},
+	{},
+};
+
 static struct platform_driver ab8500_btemp_driver = {
 	.probe = ab8500_btemp_probe,
 	.remove = __devexit_p(ab8500_btemp_remove),
@@ -1106,6 +1134,7 @@ static struct platform_driver ab8500_btemp_driver = {
 	.driver = {
 		.name = "ab8500-btemp",
 		.owner = THIS_MODULE,
+		.of_match_table = ab8500_btemp_match,
 	},
 };
 
-- 
1.7.9.5
