From: lkundrak@v3.sk (Lubomir Rintel)
Date: Fri, 16 Nov 2018 17:24:01 +0100
Subject: [PATCH v2 15/17] power: supply: olpc_battery: Use
 devm_power_supply_register()
In-Reply-To: <20181116162403.49854-1-lkundrak@v3.sk>
References: <20181116162403.49854-1-lkundrak@v3.sk>
Message-ID: <20181116162403.49854-16-lkundrak@v3.sk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This simplifies the error handling.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

---
Changes since v1:
- This was split off the "power: supply: olpc_battery: Move priv data to
  a struct" patch.

 drivers/power/supply/olpc_battery.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/drivers/power/supply/olpc_battery.c b/drivers/power/supply/olpc_battery.c
index b091f897c1d4..4433eb10a23d 100644
--- a/drivers/power/supply/olpc_battery.c
+++ b/drivers/power/supply/olpc_battery.c
@@ -628,7 +628,7 @@ static int olpc_battery_probe(struct platform_device *pdev)
 	psy_cfg.of_node = pdev->dev.of_node;
 	psy_cfg.drv_data = data;
 
-	data->olpc_ac = power_supply_register(&pdev->dev, &olpc_ac_desc, &psy_cfg);
+	data->olpc_ac = devm_power_supply_register(&pdev->dev, &olpc_ac_desc, &psy_cfg);
 	if (IS_ERR(data->olpc_ac))
 		return PTR_ERR(data->olpc_ac);
 
@@ -643,15 +643,13 @@ static int olpc_battery_probe(struct platform_device *pdev)
 		olpc_bat_desc.num_properties = ARRAY_SIZE(olpc_xo1_bat_props);
 	}
 
-	data->olpc_bat = power_supply_register(&pdev->dev, &olpc_bat_desc, &psy_cfg);
-	if (IS_ERR(olpc_bat)) {
-		ret = PTR_ERR(olpc_bat);
-		goto battery_failed;
-	}
+	data->olpc_bat = devm_power_supply_register(&pdev->dev, &olpc_bat_desc, &psy_cfg);
+	if (IS_ERR(data->olpc_bat))
+		return PTR_ERR(data->olpc_bat);
 
 	ret = device_create_bin_file(&data->olpc_bat->dev, &olpc_bat_eeprom);
 	if (ret)
-		goto eeprom_failed;
+		return ret;
 
 	ret = device_create_file(&data->olpc_bat->dev, &olpc_bat_error);
 	if (ret)
@@ -666,10 +664,6 @@ static int olpc_battery_probe(struct platform_device *pdev)
 
 error_failed:
 	device_remove_bin_file(&data->olpc_bat->dev, &olpc_bat_eeprom);
-eeprom_failed:
-	power_supply_unregister(data->olpc_bat);
-battery_failed:
-	power_supply_unregister(data->olpc_ac);
 	return ret;
 }
 
@@ -679,9 +673,6 @@ static int olpc_battery_remove(struct platform_device *pdev)
 
 	device_remove_file(&data->olpc_bat->dev, &olpc_bat_error);
 	device_remove_bin_file(&data->olpc_bat->dev, &olpc_bat_eeprom);
-	power_supply_unregister(data->olpc_bat);
-	power_supply_unregister(data->olpc_ac);
-
 	return 0;
 }
 
-- 
2.19.1
