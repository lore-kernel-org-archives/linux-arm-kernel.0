From: rajanikanth.hv@stericsson.com (Rajanikanth H.V)
Date: Mon, 1 Oct 2012 09:38:32 +0530
Subject: =?UTF-8?q?=5BPATCH=203/4=5D=20mfd=3A=20ab8500=3A=20add=20devicetree=20support=20for=20charger?=
In-Reply-To: <1349064513-31301-1-git-send-email-rajanikanth.hv@stericsson.com>
References: <1349064513-31301-1-git-send-email-rajanikanth.hv@stericsson.com>
Message-ID: <1349064513-31301-4-git-send-email-rajanikanth.hv@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Rajanikanth H.V" <rajanikanth.hv@stericsson.com>

This patch adds device tree support for charger driver

Signed-off-by: Rajanikanth H.V <rajanikanth.hv@stericsson.com>
---
 Documentation/devicetree/bindings/mfd/ab8500.txt   |   14 +++++
 .../bindings/power_supply/ab8500/charger.txt       |   44 ++++++++++++++
 arch/arm/boot/dts/dbx5x0.dtsi                      |   11 ++++
 drivers/mfd/ab8500-core.c                          |    1 +
 drivers/power/ab8500_charger.c                     |   61 +++++++++++++++-----
 5 files changed, 118 insertions(+), 13 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power_supply/ab8500/charger.txt

diff --git a/Documentation/devicetree/bindings/mfd/ab8500.txt b/Documentation/devicetree/bindings/mfd/ab8500.txt
index 47d232e..4b45a73 100644
--- a/Documentation/devicetree/bindings/mfd/ab8500.txt
+++ b/Documentation/devicetree/bindings/mfd/ab8500.txt
@@ -36,6 +36,20 @@ ab8500-btemp		 :			: vtvout       : Battery Temperature
 			 : BTEMP_HIGH           :              : BtempLow < Btemp < BtempMedium,if battery temperature is between -10 and 0?C
 			 : BTEMP_LOW_MEDIUM     :              : BtempMedium < Btemp < BtempHigh,if battery temperature is between 0?C and?MaxTemp
 			 : BTEMP_MEDIUM_HIGH    :	       : Btemp > BtempHigh, if battery temperature is higher than ?MaxTemp?
+ab8500-charger		 :			: vddadc       : Charger interface
+			 : MAIN_CH_UNPLUG_DET	:	       : main charger unplug detection management (not in 8505)
+			 : MAIN_CHARGE_PLUG_DET	:	       : main charger plug detection management (not in 8505)
+			 : MAIN_EXT_CH_NOT_OK	:	       : main charger not OK
+			 : MAIN_CH_TH_PROT_R	:	       : Die temp is above main charger
+			 : MAIN_CH_TH_PROT_F	:	       : Die temp is below main charger
+			 : VBUS_DET_F		:	       : VBUS falling detected
+			 : VBUS_DET_R		:	       : VBUS rising detected
+			 : USB_LINK_STATUS	:	       : USB link status has changed
+			 : USB_CH_TH_PROT_R	:	       : Die temp is above usb charger
+			 : USB_CH_TH_PROT_F	:	       : Die temp is below usb charger
+			 : USB_CHARGER_NOT_OKR	:	       : allowed USB charger not ok detection
+			 : VBUS_OVV		:	       : Overvoltage on Vbus ball detected (USB charge is stopped)
+			 : CH_WD_EXP		:	       : Charger watchdog detected
 ab8500-gpadc             : HW_CONV_END          : vddadc       : Analogue to Digital Converter
                            SW_CONV_END          :              :
 ab8500-gpio              :                      :              : GPIO Controller
diff --git a/Documentation/devicetree/bindings/power_supply/ab8500/charger.txt b/Documentation/devicetree/bindings/power_supply/ab8500/charger.txt
new file mode 100644
index 0000000..b78d565
--- /dev/null
+++ b/Documentation/devicetree/bindings/power_supply/ab8500/charger.txt
@@ -0,0 +1,44 @@
+=== AB8500 Charger Driver ===
+
+Batter charger module is part of energy-management-module,
+the other components of this module are:
+main-charger, usb-combo-charger and fuel-gauge.
+
+The properties below describes the node for charger driver.
+
+Required Properties:
+- compatible = "stericsson,ab8500-charger"
+- interface-name:
+	Name of the controller/driver which is part of energy-management-module
+- supplied-to:
+	This property shall have dependent nodes which represent other
+	energy-management-module.
+	e.g:
+	ab8500-charger{
+		/* dependent energy management modules */
+		supplied-to = <
+			&ab8500_chargalg
+			&ab8500_fuel_gauge
+			&ab8500_battery_temp>;
+	};
+- vddadc-supply:
+	Supply for USB and Main charger
+	e.g.
+	ab8500-charger{
+		vddadc-supply	= <&ab8500_ldo_tvout_reg>;
+	}
+- autopower_cfg:
+	Boolean value depicting the presence of 'automatic pwron after pwrloss'
+	e.g:
+	ab8500-charger{
+		autopower_cfg;
+	};
+
+dependent node:
+	ab8500_battery_info: ab8500_bat_type {
+	};
+	This node provide information on 'thermistor interface' and
+	'battery technology type' used.
+
+ref: further details.
+	Documentation/devicetree/bindings/power_supply/ab8500/fg.txt
diff --git a/arch/arm/boot/dts/dbx5x0.dtsi b/arch/arm/boot/dts/dbx5x0.dtsi
index 9f5fde8..0848ae4 100644
--- a/arch/arm/boot/dts/dbx5x0.dtsi
+++ b/arch/arm/boot/dts/dbx5x0.dtsi
@@ -378,6 +378,17 @@
 					supplied-to    = <&ab8500_chargalg &ab8500_fuel_gauge>;
 				};
 
+				ab8500_charger: ab8500_charger_if {
+					compatible	= "stericsson,ab8500-charger";
+					interface-name 	= "ab8500_charger";
+					battery-info   	= <&ab8500_battery_info>;
+					supplied-to 	= <
+							&ab8500_chargalg
+							&ab8500_fuel_gauge
+							&ab8500_battery_temp>;
+					vddadc-supply	= <&ab8500_ldo_tvout_reg>;
+				};
+
 				ab8500_usb: ab8500_usb_if {
 					compatible = "stericsson,ab8500-usb";
 					interface-name = "ab8500_usb";
diff --git a/drivers/mfd/ab8500-core.c b/drivers/mfd/ab8500-core.c
index 0173417..0c81138 100644
--- a/drivers/mfd/ab8500-core.c
+++ b/drivers/mfd/ab8500-core.c
@@ -1041,6 +1041,7 @@ static struct mfd_cell __devinitdata abx500_common_devs[] = {
 static struct mfd_cell __devinitdata ab8500_bm_devs[] = {
 	{
 		.name = "ab8500-charger",
+		.of_compatible = "stericsson,ab8500-charger",
 		.num_resources = ARRAY_SIZE(ab8500_charger_resources),
 		.resources = ab8500_charger_resources,
 	},
diff --git a/drivers/power/ab8500_charger.c b/drivers/power/ab8500_charger.c
index 5ff0d83..456cd78 100644
--- a/drivers/power/ab8500_charger.c
+++ b/drivers/power/ab8500_charger.c
@@ -23,6 +23,7 @@
 #include <linux/err.h>
 #include <linux/workqueue.h>
 #include <linux/kobject.h>
+#include <linux/of.h>
 #include <linux/mfd/abx500/ab8500.h>
 #include <linux/mfd/abx500.h>
 #include <linux/mfd/abx500/ab8500-bm.h>
@@ -2526,7 +2527,6 @@ static int __devexit ab8500_charger_remove(struct platform_device *pdev)
 	power_supply_unregister(&di->usb_chg.psy);
 	power_supply_unregister(&di->ac_chg.psy);
 	platform_set_drvdata(pdev, NULL);
-	kfree(di);
 
 	return 0;
 }
@@ -2535,17 +2535,44 @@ static int __devinit ab8500_charger_probe(struct platform_device *pdev)
 {
 	int irq, i, charger_status, ret = 0;
 	struct abx500_bm_plat_data *plat_data = pdev->dev.platform_data;
+	struct device_node *np = pdev->dev.of_node;
 	struct ab8500_charger *di;
 
+	di = devm_kzalloc(&pdev->dev, sizeof(*di), GFP_KERNEL);
+	if (!di) {
+		dev_err(&pdev->dev, "%s no mem for ab8500_charger\n", __func__);
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
@@ -2558,16 +2585,21 @@ static int __devinit ab8500_charger_probe(struct platform_device *pdev)
 	di->pdata = plat_data->bmdev_pdata;
 	if (!di->pdata) {
 		dev_err(di->dev, "no charger platform data supplied\n");
-		ret = -EINVAL;
-		goto free_device_info;
+		return -EINVAL;
 	}
 
+	if (of_property_read_bool(np,
+			"autopower_cfg") == false){
+		dev_warn(di->dev, "missing property autopower_cfg\n");
+		di->pdata->autopower_cfg = false;
+	} else
+		di->pdata->autopower_cfg = true;
+
 	/* get battery specific platform data */
 	di->bat = plat_data->battery;
 	if (!di->bat) {
 		dev_err(di->dev, "no battery platform data supplied\n");
-		ret = -EINVAL;
-		goto free_device_info;
+		return -EINVAL;
 	}
 
 	di->autopower = false;
@@ -2614,7 +2646,7 @@ static int __devinit ab8500_charger_probe(struct platform_device *pdev)
 		create_singlethread_workqueue("ab8500_charger_wq");
 	if (di->charger_wq == NULL) {
 		dev_err(di->dev, "failed to create work queue\n");
-		goto free_device_info;
+		return -ENOMEM;
 	}
 
 	/* Init work for HW failure check */
@@ -2666,7 +2698,6 @@ static int __devinit ab8500_charger_probe(struct platform_device *pdev)
 		goto free_charger_wq;
 	}
 
-
 	/* Initialize OVV, and other registers */
 	ret = ab8500_charger_init_hw_registers(di);
 	if (ret) {
@@ -2756,12 +2787,15 @@ free_regulator:
 	regulator_put(di->regu);
 free_charger_wq:
 	destroy_workqueue(di->charger_wq);
-free_device_info:
-	kfree(di);
 
 	return ret;
 }
 
+static const struct of_device_id ab8500_charger_match[] = {
+	{.compatible = "stericsson,ab8500-charger",},
+	{},
+};
+
 static struct platform_driver ab8500_charger_driver = {
 	.probe = ab8500_charger_probe,
 	.remove = __devexit_p(ab8500_charger_remove),
@@ -2770,6 +2804,7 @@ static struct platform_driver ab8500_charger_driver = {
 	.driver = {
 		.name = "ab8500-charger",
 		.owner = THIS_MODULE,
+		.of_match_table = ab8500_charger_match,
 	},
 };
 
-- 
1.7.9.5
