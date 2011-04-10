From: marek.vasut@gmail.com (Marek Vasut)
Date: Mon, 11 Apr 2011 01:40:13 +0200
Subject: [PATCH] PXA: Use dev_pm_ops in z2_battery
Message-ID: <1302478813-17945-1-git-send-email-marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
---
btw. Anton, do you want to apply it or shall pxa tree pick this up?

Cheers :)

 drivers/power/z2_battery.c |   20 ++++++++++++++------
 1 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/power/z2_battery.c b/drivers/power/z2_battery.c
index e5ed52d..82dae53 100644
--- a/drivers/power/z2_battery.c
+++ b/drivers/power/z2_battery.c
@@ -269,24 +269,33 @@ static int __devexit z2_batt_remove(struct i2c_client *client)
 }
 
 #ifdef CONFIG_PM
-static int z2_batt_suspend(struct i2c_client *client, pm_message_t state)
+static int z2_batt_suspend(struct device *dev)
 {
+	struct i2c_client *client = to_i2c_client(dev);
 	struct z2_charger *charger = i2c_get_clientdata(client);
 
 	flush_work_sync(&charger->bat_work);
 	return 0;
 }
 
-static int z2_batt_resume(struct i2c_client *client)
+static int z2_batt_resume(struct device *dev)
 {
+	struct i2c_client *client = to_i2c_client(dev);
 	struct z2_charger *charger = i2c_get_clientdata(client);
 
 	schedule_work(&charger->bat_work);
 	return 0;
 }
+
+static const struct dev_pm_ops z2_battery_pm_ops = {
+	.suspend	= z2_batt_suspend,
+	.resume		= z2_batt_resume,
+};
+
+#define	Z2_BATTERY_PM_OPS	(&z2_battery_pm_ops)
+
 #else
-#define z2_batt_suspend NULL
-#define z2_batt_resume NULL
+#define	Z2_BATTERY_PM_OPS	(NULL)
 #endif
 
 static const struct i2c_device_id z2_batt_id[] = {
@@ -298,11 +307,10 @@ static struct i2c_driver z2_batt_driver = {
 	.driver	= {
 		.name	= "z2-battery",
 		.owner	= THIS_MODULE,
+		.pm	= Z2_BATTERY_PM_OPS
 	},
 	.probe		= z2_batt_probe,
 	.remove		= z2_batt_remove,
-	.suspend	= z2_batt_suspend,
-	.resume		= z2_batt_resume,
 	.id_table	= z2_batt_id,
 };
 
-- 
1.7.4.1
