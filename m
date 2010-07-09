From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Fri,  9 Jul 2010 14:27:21 +0300
Subject: [PATCH 2/3] Add s3c-adc-battery driver
In-Reply-To: <1278674842-17583-1-git-send-email-anarsoul@gmail.com>
References: <1278674842-17583-1-git-send-email-anarsoul@gmail.com>
Message-ID: <1278674842-17583-3-git-send-email-anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

s3c-adc-battery is driver for monitoring
and charging battery on iPAQ H1930/H1940/RX1950.
It depends on s3c-adc driver to get battery voltage and current.

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 drivers/power/Kconfig           |    6 +
 drivers/power/Makefile          |    1 +
 drivers/power/s3c_adc_battery.c |  518 +++++++++++++++++++++++++++++++++++++++
 include/linux/s3c_adc_battery.h |   37 +++
 4 files changed, 562 insertions(+), 0 deletions(-)
 create mode 100644 drivers/power/s3c_adc_battery.c
 create mode 100644 include/linux/s3c_adc_battery.h

diff --git a/drivers/power/Kconfig b/drivers/power/Kconfig
index 8e9ba17..645baa5 100644
--- a/drivers/power/Kconfig
+++ b/drivers/power/Kconfig
@@ -136,6 +136,12 @@ config BATTERY_Z2
 	help
 	  Say Y to include support for the battery on the Zipit Z2.
 
+config BATTERY_S3C_ADC
+	tristate "Battery driver for Samsung ADC based monitoring"
+	depends on S3C_ADC
+	help
+	  Say Y here to enable support for iPAQ h1930/h1940/rx1950 battery
+
 config CHARGER_PCF50633
 	tristate "NXP PCF50633 MBC"
 	depends on MFD_PCF50633
diff --git a/drivers/power/Makefile b/drivers/power/Makefile
index 0005080..166bcbf 100644
--- a/drivers/power/Makefile
+++ b/drivers/power/Makefile
@@ -33,4 +33,5 @@ obj-$(CONFIG_BATTERY_BQ27x00)	+= bq27x00_battery.o
 obj-$(CONFIG_BATTERY_DA9030)	+= da9030_battery.o
 obj-$(CONFIG_BATTERY_MAX17040)	+= max17040_battery.o
 obj-$(CONFIG_BATTERY_Z2)	+= z2_battery.o
+obj-$(CONFIG_BATTERY_S3C_ADC)	+= s3c_adc_battery.o
 obj-$(CONFIG_CHARGER_PCF50633)	+= pcf50633-charger.o
diff --git a/drivers/power/s3c_adc_battery.c b/drivers/power/s3c_adc_battery.c
new file mode 100644
index 0000000..d2b729b
--- /dev/null
+++ b/drivers/power/s3c_adc_battery.c
@@ -0,0 +1,518 @@
+/*
+ * drivers/power/s3c_adc_battery.c
+ *	Copyright (c) Vasily Khoruzhick
+ *	Based on h1940_battery.c by Arnaud Patard
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file COPYING in the main directory of this archive for
+ * more details.
+ *
+ *	    iPAQ h1930/h1940/rx1950 battery controler driver
+ */
+
+#include <linux/interrupt.h>
+#include <linux/platform_device.h>
+#include <linux/power_supply.h>
+#include <linux/leds.h>
+#include <linux/gpio.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/timer.h>
+#include <linux/jiffies.h>
+#include <linux/s3c_adc_battery.h>
+
+#include <asm/irq.h>
+#include <mach/regs-gpio.h>
+#include <mach/regs-gpioj.h>
+
+#include <plat/adc.h>
+
+#define BAT_POLL_INTERVAL			10000 /* ms */
+#define JITTER_DELAY				500 /* ms */
+
+struct s3c_adc_bat {
+	struct power_supply	psy;
+	struct s3c_adc_client	*client;
+	struct s3c_adc_batt_pdata *pdata;
+};
+
+#ifdef CONFIG_LEDS_CLASS
+DEFINE_LED_TRIGGER(charger_led_trigger);
+#endif
+
+static int s3c_adc_ac_get_property(struct power_supply *psy,
+				enum power_supply_property psp,
+				union power_supply_propval *val);
+
+static char *s3c_adc_supplied_to[] = {
+	"main-battery",
+};
+
+static enum power_supply_property s3c_adc_ac_props[] = {
+	POWER_SUPPLY_PROP_ONLINE,
+};
+
+static struct power_supply s3c_adc_ac = {
+	.name = "ac",
+	.type = POWER_SUPPLY_TYPE_MAINS,
+	.supplied_to = s3c_adc_supplied_to,
+	.num_supplicants = ARRAY_SIZE(s3c_adc_supplied_to),
+	.properties = s3c_adc_ac_props,
+	.num_properties = ARRAY_SIZE(s3c_adc_ac_props),
+	.get_property = s3c_adc_ac_get_property,
+};
+
+static enum power_supply_property s3c_adc_backup_bat_props[] = {
+	POWER_SUPPLY_PROP_VOLTAGE_NOW,
+	POWER_SUPPLY_PROP_VOLTAGE_MIN,
+	POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN,
+};
+
+static int s3c_adc_backup_bat_get_property(struct power_supply *psy,
+				enum power_supply_property psp,
+				union power_supply_propval *val);
+
+static struct s3c_adc_bat backup_bat = {
+	.psy = {
+		.name		= "backup-battery",
+		.type		= POWER_SUPPLY_TYPE_BATTERY,
+		.properties	= s3c_adc_backup_bat_props,
+		.num_properties = ARRAY_SIZE(s3c_adc_backup_bat_props),
+		.get_property	= s3c_adc_backup_bat_get_property,
+		.use_for_apm	= 1,
+	},
+};
+
+static enum power_supply_property s3c_adc_main_bat_props[] = {
+	POWER_SUPPLY_PROP_STATUS,
+	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
+	POWER_SUPPLY_PROP_CHARGE_EMPTY_DESIGN,
+	POWER_SUPPLY_PROP_CHARGE_NOW,
+	POWER_SUPPLY_PROP_VOLTAGE_NOW,
+	POWER_SUPPLY_PROP_CURRENT_NOW,
+};
+
+static int s3c_adc_bat_get_property(struct power_supply *psy,
+				enum power_supply_property psp,
+				union power_supply_propval *val);
+
+static struct s3c_adc_bat main_bat = {
+	.psy = {
+		.name		= "main-battery",
+		.type		= POWER_SUPPLY_TYPE_BATTERY,
+		.properties	= s3c_adc_main_bat_props,
+		.num_properties = ARRAY_SIZE(s3c_adc_main_bat_props),
+		.get_property	= s3c_adc_bat_get_property,
+		.use_for_apm	= 1,
+	},
+};
+
+static int s3c_adc_ac_get_property(struct power_supply *psy,
+				enum power_supply_property psp,
+				union power_supply_propval *val)
+{
+	int ret = 0;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_ONLINE:
+		val->intval =
+			!gpio_get_value(main_bat.pdata->gpio_cable_plugged);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+	return ret;
+}
+
+static int s3c_adc_backup_bat_get_property(struct power_supply *psy,
+				enum power_supply_property psp,
+				union power_supply_propval *val)
+{
+	struct s3c_adc_bat *bat = container_of(psy, struct s3c_adc_bat, psy);
+	static int volt_value = -1;
+	static unsigned int timestamp;
+
+	if (!bat) {
+		printk(KERN_ERR "%s: no battery infos ?!\n", __func__);
+		return -EINVAL;
+	}
+
+	if (volt_value < 0 ||
+		jiffies_to_msecs(jiffies - timestamp) > BAT_POLL_INTERVAL) {
+		volt_value = s3c_adc_read(bat->client,
+			bat->pdata->backup_volt_channel);
+		volt_value *= bat->pdata->backup_volt_mult;
+		timestamp = jiffies;
+	}
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
+		val->intval = volt_value;
+		return 0;
+	case POWER_SUPPLY_PROP_VOLTAGE_MIN:
+		val->intval = bat->pdata->backup_volt_min;
+		return 0;
+	case POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN:
+		val->intval = bat->pdata->backup_volt_max;
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
+static void cable_plugged_handler(unsigned long data)
+{
+	static int old_status;
+	int is_plugged = !gpio_get_value(main_bat.pdata->gpio_cable_plugged);
+
+	if (old_status == is_plugged)
+		return;
+
+	printk(KERN_INFO "Power cable %s\n",\
+			is_plugged ? "plugged" : "unplugged");
+	if (is_plugged) {
+		main_bat.pdata->enable_charger();
+#ifdef CONFIG_LEDS_CLASS
+		led_trigger_event(charger_led_trigger, LED_HALF);
+#endif
+	} else {
+		main_bat.pdata->disable_charger();
+#ifdef CONFIG_LEDS_CLASS
+		led_trigger_event(charger_led_trigger, LED_OFF);
+#endif
+	}
+
+	old_status = is_plugged;
+	power_supply_changed(&s3c_adc_ac);
+}
+
+static void charge_finished_handler(unsigned long data)
+{
+	static int old_status;
+	int is_plugged = !gpio_get_value(main_bat.pdata->gpio_cable_plugged);
+	int is_charged = gpio_get_value(main_bat.pdata->gpio_charge_finished);
+
+	if (old_status == is_charged)
+		return;
+
+	if (!is_plugged)
+		return;
+
+	if (is_charged) {
+#ifdef CONFIG_LEDS_CLASS
+		led_trigger_event(charger_led_trigger, LED_FULL);
+#endif
+		main_bat.pdata->disable_charger();
+	} else {
+#ifdef CONFIG_LEDS_CLASS
+		led_trigger_event(charger_led_trigger, LED_HALF);
+#endif
+		main_bat.pdata->enable_charger();
+	}
+
+	old_status = is_charged;
+	power_supply_changed(&main_bat.psy);
+}
+
+static DEFINE_TIMER(cable_plugged_timer, cable_plugged_handler, 0, 0);
+static DEFINE_TIMER(charge_finished_timer, charge_finished_handler, 0, 0);
+
+static irqreturn_t s3c_adc_batt_cable(int irq, void *dev_id)
+{
+	mod_timer(&cable_plugged_timer,
+		jiffies + msecs_to_jiffies(JITTER_DELAY));
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t s3c_adc_batt_charged(int irq, void *dev_id)
+{
+	mod_timer(&charge_finished_timer,
+		jiffies + msecs_to_jiffies(JITTER_DELAY));
+	return IRQ_HANDLED;
+}
+
+static int calc_full_volt(int volt_val, int cur_val)
+{
+	return volt_val +
+		cur_val * main_bat.pdata->internal_impedance / 1000;
+}
+
+static int s3c_adc_bat_get_property(struct power_supply *psy,
+				enum power_supply_property psp,
+				union power_supply_propval *val)
+{
+	struct s3c_adc_bat *bat = container_of(psy, struct s3c_adc_bat, psy);
+	static int volt_value = -1, cur_value = -1;
+	static unsigned int timestamp;
+	static int level = 1000000;
+
+	int status = POWER_SUPPLY_STATUS_DISCHARGING, new_level, full_volt;
+	const struct s3c_adc_batt_thresh *lut = bat->pdata->lut_noac;
+	unsigned int lut_size = bat->pdata->lut_noac_cnt;
+
+	if (!bat) {
+		printk(KERN_ERR "%s: no battery infos ?!\n", __func__);
+		return -EINVAL;
+	}
+
+	if (volt_value < 0 || cur_value < 0 ||
+		jiffies_to_msecs(jiffies - timestamp) > BAT_POLL_INTERVAL) {
+		volt_value = s3c_adc_read(bat->client,
+			bat->pdata->volt_channel) * bat->pdata->volt_mult;
+		cur_value = s3c_adc_read(bat->client,
+			bat->pdata->current_channel) * bat->pdata->current_mult;
+		timestamp = jiffies;
+	}
+
+	if (!gpio_get_value(bat->pdata->gpio_cable_plugged)) {
+		if (gpio_get_value(bat->pdata->gpio_charge_finished))
+			status = POWER_SUPPLY_STATUS_FULL;
+		else {
+			status = POWER_SUPPLY_STATUS_CHARGING;
+			lut = bat->pdata->lut_acin;
+			lut_size = bat->pdata->lut_acin_cnt;
+		}
+	}
+
+	new_level = 100000;
+	full_volt = calc_full_volt((volt_value / 1000), (cur_value / 1000));
+
+	if (full_volt < calc_full_volt(lut->volt, lut->cur)) {
+		lut_size--;
+		while (lut_size--) {
+			int lut_volt1, lut_volt2;
+			lut_volt1 = calc_full_volt(lut[0].volt, lut[0].cur);
+			lut_volt2 = calc_full_volt(lut[1].volt, lut[1].cur);
+			if (full_volt < lut_volt1 && full_volt >= lut_volt2) {
+				new_level = (lut[1].level +
+					(lut[0].level - lut[1].level) *
+					(full_volt - lut_volt2) /
+					(lut_volt1 - lut_volt2)) * 1000;
+				break;
+			}
+			new_level = lut[1].level * 1000;
+			lut++;
+		}
+	}
+
+#if 0
+	/* Battery level can't go up during discharging, and
+	 * can't go down during charging
+	 */
+	if ((status == POWER_SUPPLY_STATUS_DISCHARGING && new_level < level) ||
+		(status == POWER_SUPPLY_STATUS_CHARGING && new_level > level) ||
+		status == POWER_SUPPLY_STATUS_FULL)
+		level = new_level;
+#else
+	level = new_level;
+#endif
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_STATUS:
+		val->intval = status;
+		return 0;
+	case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
+		val->intval = 100000;
+		return 0;
+	case POWER_SUPPLY_PROP_CHARGE_EMPTY_DESIGN:
+		val->intval = 0;
+		return 0;
+	case POWER_SUPPLY_PROP_CHARGE_NOW:
+		val->intval = level;
+		return 0;
+	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
+		val->intval = volt_value;
+		return 0;
+	case POWER_SUPPLY_PROP_CURRENT_NOW:
+		val->intval = cur_value;
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int __init s3c_adc_batt_probe(struct platform_device *pdev)
+{
+	struct s3c_adc_client	*client;
+	struct s3c_adc_batt_pdata *pdata = pdev->dev.platform_data;
+	int ret;
+
+	client = s3c_adc_register(pdev, NULL, NULL, 0);
+	if (IS_ERR(client)) {
+		dev_err(&pdev->dev, "cannot register adc\n");
+		return PTR_ERR(client);
+	}
+
+	platform_set_drvdata(pdev, client);
+
+	main_bat.client = client;
+	main_bat.pdata = pdev->dev.platform_data;
+
+	ret = power_supply_register(&pdev->dev, &main_bat.psy);
+	if (ret)
+		goto err_reg_main;
+	if (pdata->backup_volt_mult) {
+		backup_bat.client = client;
+		backup_bat.pdata = pdev->dev.platform_data;
+		ret = power_supply_register(&pdev->dev, &backup_bat.psy);
+		if (ret)
+			goto err_reg_backup;
+	}
+	ret = power_supply_register(&pdev->dev, &s3c_adc_ac);
+	if (ret)
+		goto err_reg_ac;
+
+
+	ret = gpio_request(main_bat.pdata->gpio_cable_plugged, "batcable");
+	if (ret)
+		goto err_gpio1;
+
+	ret = request_irq(gpio_to_irq(main_bat.pdata->gpio_cable_plugged),
+			s3c_adc_batt_cable,
+			IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
+			pdev->name, NULL);
+	if (ret)
+		goto err_irq1;
+
+	ret = gpio_request(main_bat.pdata->gpio_charge_finished, "charged");
+	if (ret)
+		goto err_gpio2;
+
+	ret = request_irq(gpio_to_irq(main_bat.pdata->gpio_charge_finished),
+			s3c_adc_batt_charged,
+			IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
+			pdev->name, NULL);
+	if (ret)
+		goto err_irq2;
+
+	ret = pdata->init();
+	if (ret)
+		goto err_platform;
+
+#ifdef CONFIG_LEDS_CLASS
+	led_trigger_register_simple("s3c-adc-charger", &charger_led_trigger);
+#endif
+	printk(KERN_INFO "s3c-adc-batt successfully loaded\n");
+
+	device_init_wakeup(&pdev->dev, 1);
+
+	/* Schedule timer to check current status */
+	mod_timer(&cable_plugged_timer,
+		jiffies + msecs_to_jiffies(JITTER_DELAY));
+
+	return 0;
+
+err_platform:
+	free_irq(gpio_to_irq(main_bat.pdata->gpio_charge_finished), NULL);
+	del_timer_sync(&charge_finished_timer);
+err_irq2:
+	gpio_free(main_bat.pdata->gpio_charge_finished);
+err_gpio2:
+	free_irq(gpio_to_irq(main_bat.pdata->gpio_cable_plugged), NULL);
+	del_timer_sync(&cable_plugged_timer);
+err_irq1:
+	gpio_free(main_bat.pdata->gpio_cable_plugged);
+err_gpio1:
+	power_supply_unregister(&s3c_adc_ac);
+err_reg_ac:
+	if (pdata->backup_volt_mult)
+		power_supply_unregister(&backup_bat.psy);
+err_reg_backup:
+	power_supply_unregister(&main_bat.psy);
+err_reg_main:
+	return ret;
+}
+
+static int s3c_adc_batt_remove(struct platform_device *pdev)
+{
+	struct s3c_adc_client *client = platform_get_drvdata(pdev);
+	struct s3c_adc_batt_pdata *pdata = pdev->dev.platform_data;
+
+#ifdef CONFIG_LEDS_CLASS
+	led_trigger_unregister_simple(charger_led_trigger);
+#endif
+
+	power_supply_unregister(&s3c_adc_ac);
+	power_supply_unregister(&main_bat.psy);
+	if (pdata->backup_volt_mult)
+		power_supply_unregister(&backup_bat.psy);
+
+	s3c_adc_release(client);
+
+	free_irq(gpio_to_irq(pdata->gpio_charge_finished), NULL);
+	gpio_free(pdata->gpio_charge_finished);
+	del_timer_sync(&charge_finished_timer);
+	free_irq(gpio_to_irq(pdata->gpio_cable_plugged), NULL);
+	gpio_free(pdata->gpio_cable_plugged);
+	del_timer_sync(&cable_plugged_timer);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int s3c_adc_batt_suspend(struct platform_device *pdev,
+	pm_message_t state)
+{
+	struct s3c_adc_batt_pdata *pdata = pdev->dev.platform_data;
+	if (device_may_wakeup(&pdev->dev)) {
+		enable_irq_wake(gpio_to_irq(pdata->gpio_charge_finished));
+		enable_irq_wake(gpio_to_irq(pdata->gpio_cable_plugged));
+	} else {
+		disable_irq(gpio_to_irq(pdata->gpio_charge_finished));
+		disable_irq(gpio_to_irq(pdata->gpio_cable_plugged));
+		main_bat.pdata->disable_charger();
+	}
+
+	return 0;
+}
+
+static int s3c_adc_batt_resume(struct platform_device *pdev)
+{
+	struct s3c_adc_batt_pdata *pdata = pdev->dev.platform_data;
+	if (device_may_wakeup(&pdev->dev)) {
+		disable_irq_wake(gpio_to_irq(pdata->gpio_charge_finished));
+		disable_irq_wake(gpio_to_irq(pdata->gpio_cable_plugged));
+	} else {
+		enable_irq(gpio_to_irq(pdata->gpio_charge_finished));
+		enable_irq(gpio_to_irq(pdata->gpio_cable_plugged));
+	}
+
+	/* Schedule timer to check current status */
+	mod_timer(&cable_plugged_timer,
+		jiffies + msecs_to_jiffies(JITTER_DELAY));
+
+	return 0;
+}
+#else
+#define s3c_adc_battery_suspend NULL
+#define s3c_adc_battery_resume NULL
+#endif
+
+static struct platform_driver s3c_adc_batt_driver = {
+	.driver		= {
+		.name	= "s3c-adc-battery",
+	},
+	.probe		= s3c_adc_batt_probe,
+	.remove		= s3c_adc_batt_remove,
+	.suspend	= s3c_adc_batt_suspend,
+	.resume		= s3c_adc_batt_resume,
+};
+
+
+static int __init s3c_adc_batt_init(void)
+{
+	return platform_driver_register(&s3c_adc_batt_driver);
+}
+
+static void __exit s3c_adc_batt_exit(void)
+{
+	platform_driver_unregister(&s3c_adc_batt_driver);
+}
+
+module_init(s3c_adc_batt_init);
+module_exit(s3c_adc_batt_exit);
+
+MODULE_AUTHOR("Vasily Khoruzhick <anarsoul@gmail.com>");
+MODULE_DESCRIPTION("iPAQ H1930/H1940/RX1950 battery controler driver");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/s3c_adc_battery.h b/include/linux/s3c_adc_battery.h
new file mode 100644
index 0000000..a8dad74
--- /dev/null
+++ b/include/linux/s3c_adc_battery.h
@@ -0,0 +1,37 @@
+#ifndef _S3C_ADC_BATTERY_H
+#define _S3C_ADC_BATTERY_H
+
+struct s3c_adc_batt_thresh {
+	int volt; /* mV */
+	int cur; /* mA */
+	int level; /* percent */
+};
+
+struct s3c_adc_batt_pdata {
+	int (*init)(void);
+	void (*exit)(void);
+	void (*enable_charger)(void);
+	void (*disable_charger)(void);
+
+	unsigned int gpio_cable_plugged;
+	unsigned int gpio_charge_finished;
+
+	const struct s3c_adc_batt_thresh *lut_noac;
+	unsigned int lut_noac_cnt;
+	const struct s3c_adc_batt_thresh *lut_acin;
+	unsigned int lut_acin_cnt;
+
+	const unsigned int volt_channel;
+	const unsigned int current_channel;
+	const unsigned int backup_volt_channel;
+
+	const unsigned int volt_mult;
+	const unsigned int current_mult;
+	const unsigned int backup_volt_mult;
+	const unsigned int internal_impedance;
+
+	const unsigned int backup_volt_max;
+	const unsigned int backup_volt_min;
+};
+
+#endif
-- 
1.7.1
