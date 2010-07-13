From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Tue, 13 Jul 2010 23:12:59 +0300
Subject: [PATCH v3 4/5] s3c_adc_battery: add LED trigger
In-Reply-To: <1279051980-6316-1-git-send-email-anarsoul@gmail.com>
References: <1279051980-6316-1-git-send-email-anarsoul@gmail.com>
Message-ID: <1279051980-6316-5-git-send-email-anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 drivers/power/s3c_adc_battery.c |   26 ++++++++++++++++++++++++++
 1 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/drivers/power/s3c_adc_battery.c b/drivers/power/s3c_adc_battery.c
index 4eb05ab..3be2637 100644
--- a/drivers/power/s3c_adc_battery.c
+++ b/drivers/power/s3c_adc_battery.c
@@ -38,6 +38,10 @@ struct s3c_adc_bat {
 	int							cable_plugged:1;
 };
 
+#ifdef CONFIG_LEDS_TRIGGERS
+DEFINE_LED_TRIGGER(charger_led_trigger);
+#endif
+
 static struct delayed_work bat_work;
 
 static void s3c_adc_bat_ext_power_changed(struct power_supply *psy)
@@ -219,10 +223,16 @@ static void s3c_adc_bat_work(struct work_struct *work)
 	if (is_plugged != was_plugged) {
 		was_plugged = is_plugged;
 		if (is_plugged) {
+#ifdef CONFIG_LEDS_TRIGGERS
+			led_trigger_event(charger_led_trigger, LED_HALF);
+#endif
 			if (bat->pdata->enable_charger)
 				bat->pdata->enable_charger();
 			bat->status = POWER_SUPPLY_STATUS_CHARGING;
 		} else {
+#ifdef CONFIG_LEDS_TRIGGERS
+			led_trigger_event(charger_led_trigger, LED_OFF);
+#endif
 			if (bat->pdata->disable_charger)
 				bat->pdata->disable_charger();
 			bat->status = POWER_SUPPLY_STATUS_DISCHARGING;
@@ -232,10 +242,18 @@ static void s3c_adc_bat_work(struct work_struct *work)
 			is_charged = gpio_get_value(
 				main_bat.pdata->gpio_charge_finished);
 			if (is_charged) {
+#ifdef CONFIG_LEDS_TRIGGERS
+				led_trigger_event(charger_led_trigger,
+					LED_FULL);
+#endif
 				if (bat->pdata->disable_charger)
 					bat->pdata->disable_charger();
 				bat->status = POWER_SUPPLY_STATUS_FULL;
 			} else {
+#ifdef CONFIG_LEDS_TRIGGERS
+				led_trigger_event(charger_led_trigger,
+					LED_HALF);
+#endif
 				if (bat->pdata->enable_charger)
 					bat->pdata->enable_charger();
 				bat->status = POWER_SUPPLY_STATUS_CHARGING;
@@ -307,6 +325,10 @@ static int __init s3c_adc_bat_probe(struct platform_device *pdev)
 			goto err_platform;
 	}
 
+#ifdef CONFIG_LEDS_TRIGGERS
+	led_trigger_register_simple("s3c-adc-charger", &charger_led_trigger);
+#endif
+
 	dev_info(&pdev->dev, "successfully loaded\n");
 	device_init_wakeup(&pdev->dev, 1);
 
@@ -336,6 +358,10 @@ static int s3c_adc_bat_remove(struct platform_device *pdev)
 	struct s3c_adc_client *client = platform_get_drvdata(pdev);
 	struct s3c_adc_bat_pdata *pdata = pdev->dev.platform_data;
 
+#ifdef CONFIG_LEDS_TRIGGERS
+	led_trigger_unregister_simple(charger_led_trigger);
+#endif
+
 	power_supply_unregister(&main_bat.psy);
 	if (pdata->backup_volt_mult)
 		power_supply_unregister(&backup_bat.psy);
-- 
1.7.1.1
