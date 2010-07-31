From: marek.vasut@gmail.com (Marek Vasut)
Date: Sun,  1 Aug 2010 00:51:11 +0200
Subject: [PATCH v3] PXA: Reworked spitz-battery
Message-ID: <1280616671-11396-1-git-send-email-marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
---
 arch/arm/mach-pxa/Makefile    |    2 +-
 arch/arm/mach-pxa/spitz.c     |   23 ++
 drivers/power/Kconfig         |    7 +
 drivers/power/Makefile        |    1 +
 drivers/power/spitz_battery.c |  547 +++++++++++++++++++++++++++++++++++++++++
 5 files changed, 579 insertions(+), 1 deletions(-)
 create mode 100644 drivers/power/spitz_battery.c

diff --git a/arch/arm/mach-pxa/Makefile b/arch/arm/mach-pxa/Makefile
index 85c7fb3..704fb31 100644
--- a/arch/arm/mach-pxa/Makefile
+++ b/arch/arm/mach-pxa/Makefile
@@ -82,7 +82,7 @@ obj-$(CONFIG_MACH_PALMZ72)	+= palmz72.o
 obj-$(CONFIG_MACH_PALMLD)	+= palmld.o
 obj-$(CONFIG_PALM_TREO)		+= palmtreo.o
 obj-$(CONFIG_PXA_SHARP_C7xx)	+= corgi.o sharpsl_pm.o corgi_pm.o
-obj-$(CONFIG_PXA_SHARP_Cxx00)	+= spitz.o sharpsl_pm.o spitz_pm.o
+obj-$(CONFIG_PXA_SHARP_Cxx00)	+= spitz.o
 obj-$(CONFIG_MACH_POODLE)	+= poodle.o
 obj-$(CONFIG_MACH_TOSA)		+= tosa.o
 obj-$(CONFIG_MACH_ICONTROL)     += icontrol.o mxm8x10.o
diff --git a/arch/arm/mach-pxa/spitz.c b/arch/arm/mach-pxa/spitz.c
index a8d4e3a..6cee4aa 100644
--- a/arch/arm/mach-pxa/spitz.c
+++ b/arch/arm/mach-pxa/spitz.c
@@ -683,6 +683,28 @@ static inline void spitz_irda_init(void) {}
 #endif
 
 /******************************************************************************
+ * Battery
+ ******************************************************************************/
+//#if defined(CONFIG_PXA_FICP) || defined(CONFIG_PXA_FICP_MODULE)
+static struct platform_device spitz_batt_device = {
+	.name	= "spitz-battery",
+	.id	= -1,
+//	.dev	= {
+//		.platform_data	= &spitz_gpio_keys_platform_data,
+//	},
+};
+
+static void __init spitz_batt_init(void)
+{
+	printk("%s[%i]\n", __FUNCTION__, __LINE__);
+	platform_device_register(&spitz_batt_device);	
+	printk("%s[%i]\n", __FUNCTION__, __LINE__);
+}
+//#else
+//static inline void spitz_batt_init(void) {}
+//#endif
+
+/******************************************************************************
  * Framebuffer
  ******************************************************************************/
 #if defined(CONFIG_FB_PXA) || defined(CONFIG_FB_PXA_MODULE)
@@ -966,6 +988,7 @@ static void __init spitz_init(void)
 	spitz_nor_init();
 	spitz_nand_init();
 	spitz_i2c_init();
+	spitz_batt_init();
 }
 
 static void __init spitz_fixup(struct machine_desc *desc,
diff --git a/drivers/power/Kconfig b/drivers/power/Kconfig
index 8e9ba17..e4c538c 100644
--- a/drivers/power/Kconfig
+++ b/drivers/power/Kconfig
@@ -136,6 +136,13 @@ config BATTERY_Z2
 	help
 	  Say Y to include support for the battery on the Zipit Z2.
 
+config BATTERY_SPITZ
+	tristate "Sharp Spitz/Akita/Borzoi battery driver"
+	depends on SENSORS_MAX1111 && (MACH_AKITA || MACH_SPITZ || MACH_BORZOI)
+	help
+	  Say Y to include support for the battery in the
+	  Sharp Spitz/Akita/Borzoi.
+
 config CHARGER_PCF50633
 	tristate "NXP PCF50633 MBC"
 	depends on MFD_PCF50633
diff --git a/drivers/power/Makefile b/drivers/power/Makefile
index 0005080..3d282be 100644
--- a/drivers/power/Makefile
+++ b/drivers/power/Makefile
@@ -33,4 +33,5 @@ obj-$(CONFIG_BATTERY_BQ27x00)	+= bq27x00_battery.o
 obj-$(CONFIG_BATTERY_DA9030)	+= da9030_battery.o
 obj-$(CONFIG_BATTERY_MAX17040)	+= max17040_battery.o
 obj-$(CONFIG_BATTERY_Z2)	+= z2_battery.o
+obj-$(CONFIG_BATTERY_SPITZ)	+= spitz_battery.o
 obj-$(CONFIG_CHARGER_PCF50633)	+= pcf50633-charger.o
diff --git a/drivers/power/spitz_battery.c b/drivers/power/spitz_battery.c
new file mode 100644
index 0000000..7617700
--- /dev/null
+++ b/drivers/power/spitz_battery.c
@@ -0,0 +1,547 @@
+/*
+ * Battery and Power Management code for the Sharp SL-Cxxxx
+ *
+ * Copyright (C) 2010 Marek Vasut <marek.vasut@gmail.com>
+ *
+ * Based on previous attempt:
+ * Copyright (C) 2009 Pavel Machek <pavel@ucw.cz>
+ *
+ * Also based on spitz_pm and sharpsl_pm:
+ * Copyright (C) 2005 Richard Purdie
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * Li-ion batteries are angry beasts, and they like to explode.
+ * If angry lithium comes your way, the hw was misdesigned.
+ *
+ */
+#include <linux/platform_device.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/power_supply.h>
+#include <linux/delay.h>
+#include <linux/spinlock.h>
+#include <linux/interrupt.h>
+#include <linux/gpio.h>
+#include <linux/kthread.h>
+#include <linux/freezer.h>
+
+#include <asm/mach-types.h>
+#include <mach/spitz.h>
+
+#define	SHARPSL_CHECK_BATTERY_WAIT_TIME_TEMP	10	/* 10 msec */
+#define	SHARPSL_CHECK_BATTERY_WAIT_TIME_VOLT	10	/* 10 msec */
+#define	SHARPSL_CHECK_BATTERY_WAIT_TIME_ACIN	10	/* 10 msec */
+
+#define	SHARPSL_WAIT_DISCHARGE_ON		100	/* 100 msec */
+
+#define	SHARPSL_SAMPLE_DELAY			1000	/* 1 sec */
+
+/* Apparently, the SEL0 bit is ignored and the SEL2 bit is LSB */
+#define	SHARPSL_MAX111_BATT_TEMP	0x1	/* Channel 2 */
+#define	SHARPSL_MAX111_BATT_VOLT	0x2	/* Channel 1 */
+#define	SHARPSL_MAX111_ACIN_VOLT	0x3	/* Channel 3 */
+
+static int spitz_bat_status = POWER_SUPPLY_STATUS_UNKNOWN;
+static int spitz_bat_charge = POWER_SUPPLY_CHARGE_TYPE_UNKNOWN;
+static int spitz_bat_temp = -1;
+static int spitz_bat_volt = -1;
+static int spitz_ac_volt = -1;
+
+static DEFINE_MUTEX(bat_lock);
+static DECLARE_WAIT_QUEUE_HEAD(bat_wait);
+static struct task_struct *bat_thread;
+static int bat_restart;
+static int bat_update;
+
+extern int max1111_read_channel(int);
+
+static int spitz_bat_get_property(struct power_supply *psy,
+			    enum power_supply_property psp,
+			    union power_supply_propval *val)
+{
+	switch (psp) {
+	case POWER_SUPPLY_PROP_CHARGE_TYPE:
+		mutex_lock(&bat_lock);
+		val->intval = spitz_bat_charge;
+		mutex_unlock(&bat_lock);
+		return 0;
+	case POWER_SUPPLY_PROP_STATUS:
+		mutex_lock(&bat_lock);
+		val->intval = spitz_bat_status;
+		mutex_unlock(&bat_lock);
+		return 0;
+	case POWER_SUPPLY_PROP_TECHNOLOGY:
+		val->intval = POWER_SUPPLY_TECHNOLOGY_LION;
+		return 0;
+	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
+		/*
+		 * Thanks to Stanislav B. ADC has 3.3V as reference, is
+		 * connected to battery over 47kOhm, and to ground over 100kOhm.
+		 */
+		if (spitz_bat_volt >= 0) {
+			mutex_lock(&bat_lock);
+			val->intval = spitz_bat_volt * 1000 * 147 * 33 / 256;
+			mutex_unlock(&bat_lock);
+			return 0;
+		} else
+			return -EINVAL;
+	case POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN:
+		val->intval = 4200000;
+		return 0;
+	case POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN:
+		val->intval = 3400000;
+		return 0;
+	case POWER_SUPPLY_PROP_TEMP:
+		/*
+		 * SHARPSL_BATT_TEMP returns:
+		 * 121: battery finished charging in 22C room
+		 * 141: outside at 6C
+		 */
+		if (spitz_bat_temp >= 0) {
+			mutex_lock(&bat_lock);
+			val->intval = (-((spitz_bat_temp - 141) * 4) / 5) + 6;
+			mutex_unlock(&bat_lock);
+			return 0;
+		} else
+			return -EINVAL;
+	case POWER_SUPPLY_PROP_PRESENT:
+		val->intval = 1;
+		return 0;
+	case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
+		val->intval = 2000000;
+		return 0;
+	default:
+		return -EINVAL;
+	}
+	return -EINVAL;
+}
+
+static int spitz_ac_get_property(struct power_supply *psy,
+			    enum power_supply_property psp,
+			    union power_supply_propval *val)
+{
+	switch (psp) {
+	case POWER_SUPPLY_PROP_STATUS:
+		mutex_lock(&bat_lock);
+		val->intval = spitz_bat_status;
+		mutex_unlock(&bat_lock);
+		return 0;
+	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
+		/*
+		 * Thanks to Stanislav B. ADC has 3.3V as reference,
+		 * is connected to acin over 2kOhm, and to ground over 1kOhm.
+		 */
+		if (spitz_ac_volt >= 0) {
+			mutex_lock(&bat_lock);
+			val->intval = spitz_ac_volt * 3000 * 3300 / 256;
+			mutex_unlock(&bat_lock);
+			return 0;
+		} else
+			return -EINVAL;
+	case POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN:
+		val->intval = 5250000;
+		return 0;
+	case POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN:
+		val->intval = 4750000;
+		return 0;
+	case POWER_SUPPLY_PROP_PRESENT:
+		val->intval = !gpio_get_value(SPITZ_GPIO_AC_IN);
+		return 0;
+	default:
+		return -EINVAL;
+	}
+	return -EINVAL;
+}
+
+static enum power_supply_property spitz_bat_main_props[] = {
+	POWER_SUPPLY_PROP_STATUS,
+	POWER_SUPPLY_PROP_TECHNOLOGY,
+	POWER_SUPPLY_PROP_VOLTAGE_NOW,
+	POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN,
+	POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN,
+	POWER_SUPPLY_PROP_TEMP,
+	POWER_SUPPLY_PROP_PRESENT,
+	POWER_SUPPLY_PROP_CHARGE_TYPE,
+	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
+};
+
+static struct power_supply spitz_bat_main = {
+	.name			= "main-battery",
+	.type			= POWER_SUPPLY_TYPE_BATTERY,
+	.properties		= spitz_bat_main_props,
+	.num_properties		= ARRAY_SIZE(spitz_bat_main_props),
+	.get_property		= spitz_bat_get_property,
+	.use_for_apm		= 1,
+};
+
+static enum power_supply_property spitz_ac_props[] = {
+	POWER_SUPPLY_PROP_STATUS,
+	POWER_SUPPLY_PROP_VOLTAGE_NOW,
+	POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN,
+	POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN,
+	POWER_SUPPLY_PROP_PRESENT,
+};
+
+static struct power_supply spitz_ac = {
+	.name		= "ac",
+	.type		= POWER_SUPPLY_TYPE_MAINS,
+	.properties	= spitz_ac_props,
+	.num_properties	= ARRAY_SIZE(spitz_ac_props),
+	.get_property	= spitz_ac_get_property,
+};
+
+static void spitz_bat_set_chrg(int type, int update)
+{
+/* If something fails here ...
+ *
+ *         ..,:*:"*:~"*;'*'..
+ *       .::*;;*~*:*;~:`::"'':;.
+ *      ,'*":*';~*":*";*'''":'":.
+ *      :;.'*.',;*~,;*';,*;*,*;;*
+ *      ';*:*';):"=*.~.,'(*,;*';`
+ *        '*~"` :"*';.*;. `~=*`
+ *             (":*:*'*;')
+ *              :"':' ';:
+ *             .. "  ""';.    ..
+ *   .        :;.'";;": *::  //
+ *__/..""".._....,..,.,.,.,.//;:;,.,..::.
+ *               BOOM!!
+ */
+	spitz_bat_charge = type;
+	switch (type) {
+		case POWER_SUPPLY_CHARGE_TYPE_NONE:
+			gpio_set_value(SPITZ_GPIO_JK_B, 0);
+			gpio_set_value(SPITZ_GPIO_CHRG_ON, 1);
+			break;
+		case POWER_SUPPLY_CHARGE_TYPE_TRICKLE:
+			gpio_set_value(SPITZ_GPIO_JK_B, 0);
+			gpio_set_value(SPITZ_GPIO_CHRG_ON, 0);
+			break;
+		case POWER_SUPPLY_CHARGE_TYPE_FAST:
+			gpio_set_value(SPITZ_GPIO_JK_B, 1);
+			gpio_set_value(SPITZ_GPIO_CHRG_ON, 0);
+			break;
+		default:
+			spitz_bat_charge = POWER_SUPPLY_CHARGE_TYPE_UNKNOWN;
+			break;
+
+	}
+	if (update && bat_update) {
+		power_supply_changed(&spitz_ac);
+		power_supply_changed(&spitz_bat_main);
+	}
+}
+
+static int spitz_bat_max_sample(int channel, int delay)
+{
+	int i;
+	int ret = 0;
+
+	/* Ignore first read as that still might be weird */
+	max1111_read_channel(channel);
+	mdelay(delay);
+
+	for (i = 0; i < 5; i++) {
+		ret += max1111_read_channel(channel);
+		mdelay(delay);
+	}
+
+	return ret / 5;
+}
+
+static int spitz_bat_get_temp(void)
+{
+	int ret;
+
+	mdelay(SHARPSL_CHECK_BATTERY_WAIT_TIME_TEMP);
+	gpio_set_value(SPITZ_GPIO_ADC_TEMP_ON, 1);
+	mdelay(SHARPSL_CHECK_BATTERY_WAIT_TIME_TEMP);
+	ret = spitz_bat_max_sample(SHARPSL_MAX111_BATT_TEMP,
+		SHARPSL_CHECK_BATTERY_WAIT_TIME_TEMP);
+	gpio_set_value(SPITZ_GPIO_ADC_TEMP_ON, 0);
+
+	return ret;
+}
+
+static int spitz_bat_get_volt(void)
+{
+	int ret;
+	int charge = spitz_bat_charge;
+
+	spitz_bat_set_chrg(POWER_SUPPLY_CHARGE_TYPE_NONE, 0);
+
+	gpio_set_value(SPITZ_GPIO_JK_A, 1);
+	mdelay(SHARPSL_WAIT_DISCHARGE_ON);
+
+	ret = spitz_bat_max_sample(SHARPSL_MAX111_BATT_VOLT,
+		SHARPSL_CHECK_BATTERY_WAIT_TIME_VOLT);
+
+	gpio_set_value(SPITZ_GPIO_JK_A, 0);
+
+	spitz_bat_set_chrg(charge, 0);
+
+	return ret;
+}
+
+static int spitz_bat_get_acin_volt(void)
+{
+	return spitz_bat_max_sample(SHARPSL_MAX111_ACIN_VOLT,
+			SHARPSL_CHECK_BATTERY_WAIT_TIME_ACIN);
+}
+
+static void spitz_bat_config_chrg(int ac_in, int chrg_full, int fatal_bat)
+{
+	if (ac_in) {
+		/* XXX check temperature !!! */
+		if (chrg_full) {
+			/* XXX stop fast charging by not only checking GPIO */
+			if (spitz_bat_status != POWER_SUPPLY_STATUS_FULL) {
+			spitz_bat_set_chrg(POWER_SUPPLY_CHARGE_TYPE_TRICKLE, 1);
+			spitz_bat_status = POWER_SUPPLY_STATUS_FULL;
+			}
+		} else {
+			if (spitz_bat_status != POWER_SUPPLY_STATUS_CHARGING) {
+			spitz_bat_set_chrg(POWER_SUPPLY_CHARGE_TYPE_FAST, 1);
+			spitz_bat_status = POWER_SUPPLY_STATUS_CHARGING;
+			}
+		}
+	} else {
+		if (spitz_bat_status != POWER_SUPPLY_STATUS_DISCHARGING) {
+		spitz_bat_set_chrg(POWER_SUPPLY_CHARGE_TYPE_NONE, 1);
+		spitz_bat_status = POWER_SUPPLY_STATUS_DISCHARGING;
+		}
+	}
+}
+
+static int spitz_bat_thread(void *null)
+{
+	int ac_in, chrg_full, fatal_bat;
+
+	set_freezable();
+
+	do {
+		ac_in = !gpio_get_value(SPITZ_GPIO_AC_IN);
+		chrg_full = gpio_get_value(SPITZ_GPIO_CHRG_FULL);
+		fatal_bat = !gpio_get_value(SPITZ_GPIO_FATAL_BAT);
+
+		bat_restart = 0;
+
+		mutex_lock(&bat_lock);
+
+		if (fatal_bat) {
+			spitz_bat_set_chrg(POWER_SUPPLY_CHARGE_TYPE_NONE, 1);
+			spitz_bat_status = POWER_SUPPLY_STATUS_UNKNOWN;
+			goto end;
+		}
+
+		spitz_bat_temp = spitz_bat_get_temp();
+		spitz_bat_volt = spitz_bat_get_volt();
+		spitz_ac_volt = spitz_bat_get_acin_volt();
+
+		spitz_bat_config_chrg(ac_in, chrg_full, fatal_bat);
+
+end:
+		mutex_unlock(&bat_lock);
+
+		wait_event_freezable_timeout(bat_wait,
+			bat_restart || kthread_should_stop(),
+			msecs_to_jiffies(SHARPSL_SAMPLE_DELAY));
+
+	} while (!kthread_should_stop());
+
+	bat_thread = NULL;
+
+	return 0;
+}
+
+static irqreturn_t spitz_bat_fatal_bat_irq(int irq, void *data)
+{
+	pr_err("Fatal battery error!\n");
+	spitz_bat_set_chrg(POWER_SUPPLY_CHARGE_TYPE_NONE, 1);
+	return IRQ_HANDLED;
+}
+
+static int __devinit spitz_bat_probe(struct platform_device *pdev)
+{
+	int ret;
+
+	if (!(machine_is_spitz() || machine_is_akita()
+		|| machine_is_borzoi())) {
+		dev_err(&pdev->dev,
+			"This driver only supports Akita, Spitz and Borzoi!");
+		return -ENODEV;
+	}
+
+	if (pdev->id != -1) {
+		dev_err(&pdev->dev,
+			"Can't register multiple instances of this driver!");
+		return -EINVAL;
+	}
+
+	ret = gpio_request(SPITZ_GPIO_AC_IN, "AC IN");
+	if (ret)
+		goto err;
+	ret = gpio_direction_input(SPITZ_GPIO_AC_IN);
+	if (ret)
+		goto err2;
+
+	ret = gpio_request(SPITZ_GPIO_CHRG_FULL, "CHRG FULL");
+	if (ret)
+		goto err2;
+	ret = gpio_direction_input(SPITZ_GPIO_CHRG_FULL);
+	if (ret)
+		goto err4;
+
+	ret = gpio_request(SPITZ_GPIO_FATAL_BAT, "FATAL BAT");
+	if (ret)
+		goto err4;
+	ret = gpio_direction_input(SPITZ_GPIO_FATAL_BAT);
+	if (ret)
+		goto err6;
+	ret = request_irq(gpio_to_irq(SPITZ_GPIO_FATAL_BAT),
+			spitz_bat_fatal_bat_irq, IRQF_TRIGGER_RISING |
+			IRQF_TRIGGER_FALLING, "Battery error", pdev);
+	if (ret)
+		goto err6;
+
+	ret = gpio_request(SPITZ_GPIO_JK_A, "JK A");
+	if (ret)
+		goto err7;
+	ret = gpio_direction_output(SPITZ_GPIO_JK_A, 0);
+	if (ret)
+		goto err8;
+	gpio_set_value(SPITZ_GPIO_JK_A, 0);
+
+	ret = gpio_request(SPITZ_GPIO_JK_B, "JK B");
+	if (ret)
+		goto err8;
+	ret = gpio_direction_output(SPITZ_GPIO_JK_B, 0);
+	if (ret)
+		goto err9;
+
+	ret = gpio_request(SPITZ_GPIO_CHRG_ON, "CHRG ON");
+	if (ret)
+		goto err9;
+	ret = gpio_direction_output(SPITZ_GPIO_CHRG_ON, 1);
+	if (ret)
+		goto err10;
+
+	ret = gpio_request(SPITZ_GPIO_ADC_TEMP_ON, "TEMP MSMT");
+	if (ret)
+		goto err10;
+	ret = gpio_direction_output(SPITZ_GPIO_ADC_TEMP_ON, 0);
+	if (ret)
+		goto err11;
+
+	mutex_init(&bat_lock);
+
+	bat_restart = 0;
+	bat_update = 0;
+	init_waitqueue_head(&bat_wait);
+	bat_thread = kthread_run(spitz_bat_thread, NULL, "spitz-bat");
+
+	ret = power_supply_register(&pdev->dev, &spitz_bat_main);
+	if (ret)
+		goto err11;
+
+	ret = power_supply_register(&pdev->dev, &spitz_ac);
+	if (ret)
+		goto err12;
+
+	mutex_lock(&bat_lock);
+	bat_update = 1;
+	mutex_unlock(&bat_lock);
+
+	return 0;
+
+err12:
+	power_supply_unregister(&spitz_bat_main);
+err11:
+	gpio_free(SPITZ_GPIO_ADC_TEMP_ON);
+err10:
+	gpio_free(SPITZ_GPIO_CHRG_ON);
+err9:
+	gpio_free(SPITZ_GPIO_JK_B);
+err8:
+	gpio_free(SPITZ_GPIO_JK_A);
+err7:
+	free_irq(gpio_to_irq(SPITZ_GPIO_FATAL_BAT), pdev);
+err6:
+	gpio_free(SPITZ_GPIO_FATAL_BAT);
+err4:
+	gpio_free(SPITZ_GPIO_CHRG_FULL);
+err2:
+	gpio_free(SPITZ_GPIO_AC_IN);
+err:
+	return ret;
+}
+
+static int __devexit spitz_bat_remove(struct platform_device *pdev)
+{
+	kthread_stop(bat_thread);
+	power_supply_unregister(&spitz_ac);
+	power_supply_unregister(&spitz_bat_main);
+	gpio_free(SPITZ_GPIO_ADC_TEMP_ON);
+	gpio_free(SPITZ_GPIO_CHRG_ON);
+	gpio_free(SPITZ_GPIO_JK_B);
+	gpio_free(SPITZ_GPIO_JK_A);
+	free_irq(gpio_to_irq(SPITZ_GPIO_FATAL_BAT), pdev);
+	gpio_free(SPITZ_GPIO_FATAL_BAT);
+	free_irq(gpio_to_irq(SPITZ_GPIO_CHRG_FULL), pdev);
+	gpio_free(SPITZ_GPIO_CHRG_FULL);
+	free_irq(gpio_to_irq(SPITZ_GPIO_AC_IN), pdev);
+	gpio_free(SPITZ_GPIO_AC_IN);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int spitz_bat_suspend(struct device *dev)
+{
+	return 0;
+}
+
+static int spitz_bat_resume(struct device *dev)
+{
+	wake_up(&bat_wait);
+	return 0;
+}
+
+static const struct dev_pm_ops spitz_bat_pm_ops = {
+	.suspend	= spitz_bat_suspend,
+	.resume		= spitz_bat_resume,
+};
+#endif
+
+static struct platform_driver spitz_bat_driver = {
+	.driver	= {
+		.name	= "spitz-battery",
+		.owner	= THIS_MODULE,
+#ifdef	CONFIG_PM
+		.pm	= &spitz_bat_pm_ops,
+#endif
+	},
+	.probe		= spitz_bat_probe,
+	.remove		= __devexit_p(spitz_bat_remove),
+};
+
+static int __init spitz_bat_init(void)
+{
+	return platform_driver_register(&spitz_bat_driver);
+}
+
+static void __exit spitz_bat_exit(void)
+{
+	platform_driver_unregister(&spitz_bat_driver);
+}
+
+module_init(spitz_bat_init);
+module_exit(spitz_bat_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Marek Vasut <marek.vasut@gmail.com>");
+MODULE_DESCRIPTION("Spitz battery driver");
+MODULE_ALIAS("platform:spitz-battery");
-- 
1.7.1
