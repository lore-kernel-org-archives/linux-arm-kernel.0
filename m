From: arno@natisbad.org (Arnaud Ebalard)
Date: Wed, 05 Nov 2014 22:42:52 +0100
Subject: [PATCHv0 3/3] rtc: rtc-isl12057: add alarm support to Intersil
 ISL12057 RTC driver
In-Reply-To: <cover.1415222752.git.arno@natisbad.org>
References: <cover.1415222752.git.arno@natisbad.org>
Message-ID: <148403c0ab1d556cbb99d9242c65f714a77843e5.1415222752.git.arno@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


This patch adds alarm support to Intersil ISL12057 driver. This allows
to configure the chip to generate an interrupt when the alarm matches
current time value. Alarm can be programmed up to one month in the
future.

The patch was tested on a Netgear ReadyNAS 102 after some soldering of
the IRQ#2 pin of the RTC chip to a MPP line of the SoC (the one used
usually handles the reset button). By default, on this device, the
interrupt line of the RTC chip is not directly connected to the SoC
but to a PMIC which handles powering of the device upon alarm when it
is off.

The test was performed using a modified .dts file reflecting this
change and rtc-test.c program available in Documentation/rtc.txt.
This test program ran as expected, which validates alarm supports,
including interrupt support. Additional tests were performed on an
unmodified ReadyNAS 102 to validate the ability to wake up the device
based on a configured alarm value.

As a side note, the ISL12057 remains in the list of trivial devices,
i.e. no specific DT binding being added by this patch: i2c core
automatically handles extraction of IRQ line info from .dts file. For
instance, if one wants to reference the interrupt line for the
alarm in its .dts file, adding interrupt and interrupt-parent
properties should work as expected:

          isl12057: isl12057 at 68 {
                  compatible = "isil,isl12057";
                  interrupt-parent = <&gpio0>;
                  interrupts = <6 IRQ_TYPE_EDGE_FALLING>;
                  reg = <0x68>;
          };

Signed-off-by: Arnaud Ebalard <arno@natisbad.org>
---
 .../devicetree/bindings/i2c/trivial-devices.txt    |   2 +-
 drivers/rtc/rtc-isl12057.c                         | 311 ++++++++++++++++++++-
 2 files changed, 304 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/trivial-devices.txt b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
index edac97c0f756..f716e7da44a9 100644
--- a/Documentation/devicetree/bindings/i2c/trivial-devices.txt
+++ b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
@@ -55,7 +55,7 @@ fsl,sgtl5000		SGTL5000: Ultra Low-Power Audio Codec
 gmt,g751		G751: Digital Temperature Sensor and Thermal Watchdog with Two-Wire Interface
 infineon,slb9635tt	Infineon SLB9635 (Soft-) I2C TPM (old protocol, max 100khz)
 infineon,slb9645tt	Infineon SLB9645 I2C TPM (new protocol, max 400khz)
-isil,isl12057		Intersil ISL12057 I2C RTC Chip
+isil,isl12057		Intersil ISL12057 I2C RTC/Alarm Chip
 maxim,ds1050		5 Bit Programmable, Pulse-Width Modulator
 maxim,max1237		Low-Power, 4-/12-Channel, 2-Wire Serial, 12-Bit ADCs
 maxim,max6625		9-Bit/12-Bit Temperature Sensors with I?C-Compatible Serial Interface
diff --git a/drivers/rtc/rtc-isl12057.c b/drivers/rtc/rtc-isl12057.c
index adb0646236b1..56d222f31baa 100644
--- a/drivers/rtc/rtc-isl12057.c
+++ b/drivers/rtc/rtc-isl12057.c
@@ -1,5 +1,5 @@
 /*
- * rtc-isl12057 - Driver for Intersil ISL12057 I2C Real Time Clock
+ * rtc-isl12057 - Driver for Intersil ISL12057 I2C Real Time Clock / Alarm
  *
  * Copyright (C) 2013, Arnaud EBALARD <arno@natisbad.org>
  *
@@ -27,7 +27,6 @@
 #include <linux/i2c.h>
 #include <linux/bcd.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/regmap.h>
 
 #define DRV_NAME "rtc-isl12057"
@@ -78,6 +77,7 @@
 #define ISL12057_MEM_MAP_LEN	0x10
 
 struct isl12057_rtc_data {
+	struct rtc_device *rtc;
 	struct regmap *regmap;
 	struct mutex lock;
 };
@@ -148,17 +148,42 @@ static int isl12057_i2c_validate_chip(struct regmap *regmap)
 	return 0;
 }
 
-static int isl12057_rtc_read_time(struct device *dev, struct rtc_time *tm)
+static int _isl12057_rtc_clear_alarm(struct device *dev)
+{
+	struct isl12057_rtc_data *data = dev_get_drvdata(dev);
+	int ret;
+
+	ret = regmap_update_bits(data->regmap, ISL12057_REG_SR,
+				 ISL12057_REG_SR_A1F, 0);
+
+	if (ret)
+		dev_err(dev, "%s: clearing alarm failed\n", __func__);
+
+	return ret;
+}
+
+static int _isl12057_rtc_toggle_alarm(struct device *dev, int enable)
+{
+	struct isl12057_rtc_data *data = dev_get_drvdata(dev);
+	int ret;
+
+	ret = regmap_update_bits(data->regmap, ISL12057_REG_INT,
+				 ISL12057_REG_INT_A1IE,
+				 enable ? ISL12057_REG_INT_A1IE : 0);
+	if (ret)
+		dev_err(dev, "%s: writing INT failed\n", __func__);
+
+	return ret;
+}
+
+static int _isl12057_rtc_read_time(struct device *dev, struct rtc_time *tm)
 {
 	struct isl12057_rtc_data *data = dev_get_drvdata(dev);
 	u8 regs[ISL12057_RTC_SEC_LEN];
 	int ret;
 
-	mutex_lock(&data->lock);
 	ret = regmap_bulk_read(data->regmap, ISL12057_REG_RTC_SC, regs,
 			       ISL12057_RTC_SEC_LEN);
-	mutex_unlock(&data->lock);
-
 	if (ret) {
 		dev_err(dev, "%s: RTC read failed\n", __func__);
 		return ret;
@@ -169,6 +194,176 @@ static int isl12057_rtc_read_time(struct device *dev, struct rtc_time *tm)
 	return rtc_valid_tm(tm);
 }
 
+static int isl12057_rtc_toggle_alarm(struct device *dev, int enable)
+{
+	struct isl12057_rtc_data *data = dev_get_drvdata(dev);
+	int ret;
+
+	mutex_lock(&data->lock);
+	ret = _isl12057_rtc_toggle_alarm(dev, enable);
+	mutex_unlock(&data->lock);
+
+	return ret;
+}
+
+static int isl12057_rtc_read_time(struct device *dev, struct rtc_time *tm)
+{
+	struct isl12057_rtc_data *data = dev_get_drvdata(dev);
+	int ret;
+
+	mutex_lock(&data->lock);
+	ret = _isl12057_rtc_read_time(dev, tm);
+	mutex_unlock(&data->lock);
+
+	return ret;
+}
+
+static int isl12057_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alarm)
+{
+	struct isl12057_rtc_data *data = dev_get_drvdata(dev);
+	struct rtc_time rtc_tm, *alarm_tm = &alarm->time;
+	unsigned long rtc_secs, alarm_secs;
+	u8 regs[ISL12057_A1_SEC_LEN];
+	unsigned int ir;
+	int ret;
+
+	mutex_lock(&data->lock);
+	ret = regmap_bulk_read(data->regmap, ISL12057_REG_A1_SC, regs,
+			       ISL12057_A1_SEC_LEN);
+	if (ret) {
+		dev_err(dev, "%s: reading alarm section failed\n", __func__);
+		goto err_unlock;
+	}
+
+	alarm_tm->tm_sec  = bcd2bin(regs[0] & 0x7f);
+	alarm_tm->tm_min  = bcd2bin(regs[1] & 0x7f);
+	alarm_tm->tm_hour = bcd2bin(regs[2] & 0x3f);
+	alarm_tm->tm_mday = bcd2bin(regs[3] & 0x3f);
+	alarm_tm->tm_wday = -1;
+
+	/*
+	 * The alarm section does not store year/month. We use the ones in rtc
+	 * section as a basis and increment month and then year if needed to get
+	 * alarm after current time.
+	 */
+	ret = _isl12057_rtc_read_time(dev, &rtc_tm);
+	if (ret)
+		goto err_unlock;
+
+	alarm_tm->tm_year = rtc_tm.tm_year;
+	alarm_tm->tm_mon = rtc_tm.tm_mon;
+
+	ret = rtc_tm_to_time(&rtc_tm, &rtc_secs);
+	if (ret)
+		goto err_unlock;
+
+	ret = rtc_tm_to_time(alarm_tm, &alarm_secs);
+	if (ret)
+		goto err_unlock;
+
+	if (alarm_secs < rtc_secs) {
+		if (alarm_tm->tm_mon == 11) {
+			alarm_tm->tm_mon = 0;
+			alarm_tm->tm_year += 1;
+		} else {
+			alarm_tm->tm_mon += 1;
+		}
+	}
+
+	ret = regmap_read(data->regmap, ISL12057_REG_INT, &ir);
+	if (ret) {
+		dev_err(dev, "%s: reading INT failed\n", __func__);
+		goto err_unlock;
+	}
+
+	alarm->enabled = !!(ir & ISL12057_REG_INT_A1IE);
+
+err_unlock:
+	mutex_unlock(&data->lock);
+
+	return ret;
+}
+
+static int isl12057_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alarm)
+{
+	struct isl12057_rtc_data *data = dev_get_drvdata(dev);
+	struct rtc_time *alarm_tm = &alarm->time;
+	unsigned long rtc_secs, alarm_secs;
+	u8 regs[ISL12057_A1_SEC_LEN];
+	struct rtc_time rtc_tm;
+	int ret, enable = 1;
+
+	mutex_lock(&data->lock);
+	ret = _isl12057_rtc_read_time(dev, &rtc_tm);
+	if (ret)
+		goto err_unlock;
+
+	ret = rtc_tm_to_time(&rtc_tm, &rtc_secs);
+	if (ret)
+		goto err_unlock;
+
+	ret = rtc_tm_to_time(alarm_tm, &alarm_secs);
+	if (ret)
+		goto err_unlock;
+
+	/* If alarm time is before current time, disable the alarm */
+	if (!alarm->enabled || alarm_secs <= rtc_secs) {
+		enable = 0;
+	} else {
+		/*
+		 * Chip only support alarms up to one month in the future. Let's
+		 * return an error if we get something after that limit.
+		 * Comparison is done by incrementing rtc_tm month field by one
+		 * and checking alarm value is still below.
+		 */
+		if (rtc_tm.tm_mon == 11) { /* handle year wrapping */
+			rtc_tm.tm_mon = 0;
+			rtc_tm.tm_year += 1;
+		} else {
+			rtc_tm.tm_mon += 1;
+		}
+
+		ret = rtc_tm_to_time(&rtc_tm, &rtc_secs);
+		if (ret)
+			goto err_unlock;
+
+		if (alarm_secs > rtc_secs) {
+			dev_err(dev, "%s: max one month in the future\n",
+				__func__);
+			ret = -EINVAL;
+			goto err_unlock;
+		}
+	}
+
+	/* Disable the alarm before modifying it */
+	ret = _isl12057_rtc_toggle_alarm(dev, 0);
+	if (ret < 0) {
+		dev_err(dev, "Unable to disable the alarm\n");
+		goto err_unlock;
+	}
+
+	/* Program alarm registers */
+	regs[0] = bin2bcd(alarm_tm->tm_sec) & 0x7f;
+	regs[1] = bin2bcd(alarm_tm->tm_min) & 0x7f;
+	regs[2] = bin2bcd(alarm_tm->tm_hour) & 0x3f;
+	regs[3] = bin2bcd(alarm_tm->tm_mday) & 0x3f;
+
+	ret = regmap_bulk_write(data->regmap, ISL12057_REG_A1_SC, regs,
+				ISL12057_A1_SEC_LEN);
+	if (ret < 0) {
+		dev_err(dev, "%s: writing ALARM section failed\n", __func__);
+		goto err_unlock;
+	}
+
+	/* Enable or disable alarm */
+	ret = _isl12057_rtc_toggle_alarm(dev, enable);
+
+err_unlock:
+	mutex_unlock(&data->lock);
+
+	return ret;
+}
+
 static int isl12057_rtc_set_time(struct device *dev, struct rtc_time *tm)
 {
 	struct isl12057_rtc_data *data = dev_get_drvdata(dev);
@@ -226,9 +421,42 @@ static int isl12057_check_rtc_status(struct device *dev, struct regmap *regmap)
 	return 0;
 }
 
+static int isl12057_rtc_alarm_irq_enable(struct device *dev,
+						unsigned int enable)
+{
+	return isl12057_rtc_toggle_alarm(dev, enable);
+}
+
+static irqreturn_t isl12057_rtc_interrupt(int irq, void *data)
+{
+	struct i2c_client *client = data;
+	struct isl12057_rtc_data *rtc_data = dev_get_drvdata(&client->dev);
+	struct rtc_device *rtc = rtc_data->rtc;
+	int ret, handled = IRQ_NONE;
+	unsigned int sr;
+
+	ret = regmap_read(rtc_data->regmap, ISL12057_REG_SR, &sr);
+	if (!ret && (sr & ISL12057_REG_SR_A1F)) {
+		dev_dbg(&client->dev, "RTC alarm!\n");
+
+		rtc_update_irq(rtc, 1, RTC_IRQF | RTC_AF);
+
+		/* Acknowledge and disable the alarm */
+		_isl12057_rtc_clear_alarm(&client->dev);
+		_isl12057_rtc_toggle_alarm(&client->dev, 0);
+
+		handled = IRQ_HANDLED;
+	}
+
+	return handled;
+}
+
 static const struct rtc_class_ops rtc_ops = {
 	.read_time = isl12057_rtc_read_time,
 	.set_time = isl12057_rtc_set_time,
+	.read_alarm = isl12057_rtc_read_alarm,
+	.set_alarm = isl12057_rtc_set_alarm,
+	.alarm_irq_enable = isl12057_rtc_alarm_irq_enable,
 };
 
 static struct regmap_config isl12057_rtc_regmap_config = {
@@ -273,10 +501,75 @@ static int isl12057_probe(struct i2c_client *client,
 	data->regmap = regmap;
 	dev_set_drvdata(dev, data);
 
+	if (client->irq > 0) {
+		ret = devm_request_threaded_irq(&client->dev, client->irq, NULL,
+						isl12057_rtc_interrupt,
+						IRQF_SHARED|IRQF_ONESHOT,
+						DRV_NAME, client);
+		if (!ret) {
+			device_init_wakeup(&client->dev, true);
+		} else {
+			dev_err(dev, "irq %d unavailable, no alarm support\n",
+				client->irq);
+			client->irq = 0;
+		}
+	}
+
 	rtc = devm_rtc_device_register(dev, DRV_NAME, &rtc_ops, THIS_MODULE);
-	return PTR_ERR_OR_ZERO(rtc);
+	ret = PTR_ERR_OR_ZERO(rtc);
+	if (ret) {
+		dev_err(dev, "unable to register RTC device\n");
+		goto err;
+
+		/*
+		 * XXX we may additionally need to unregister wakeup source
+		 * on error: see https://lkml.org/lkml/2014/10/9/425
+		 */
+	}
+
+	data->rtc = rtc;
+
+	return ret;
+
+err:
+	if (client->irq > 0)
+		free_irq(client->irq, client);
+
+	return ret;
+}
+
+static int isl12057_remove(struct i2c_client *client)
+{
+	if (client->irq > 0)
+		free_irq(client->irq, client);
+	return 0;
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int isl12057_rtc_suspend(struct device *dev)
+{
+	struct isl12057_rtc_data *rtc_data = dev_get_drvdata(&client->dev);
+
+	if (device_may_wakeup(dev))
+		return enable_irq_wake(rtc_data->irq);
+
+	return 0;
 }
 
+static int isl12057_rtc_resume(struct device *dev)
+{
+	struct isl12057_rtc_data *rtc_data = dev_get_drvdata(&client->dev);
+
+	if (device_may_wakeup(dev))
+		return disable_irq_wake(rtc_data->irq);
+
+	return 0;
+}
+#endif
+
+static SIMPLE_DEV_PM_OPS(isl12057_rtc_pm_ops, isl12057_rtc_suspend,
+			 isl12057_rtc_resume);
+
 #ifdef CONFIG_OF
 static const struct of_device_id isl12057_dt_match[] = {
 	{ .compatible = "isil,isl12057" },
@@ -294,13 +587,15 @@ static struct i2c_driver isl12057_driver = {
 	.driver = {
 		.name = DRV_NAME,
 		.owner = THIS_MODULE,
+		.pm = &isl12057_rtc_pm_ops,
 		.of_match_table = of_match_ptr(isl12057_dt_match),
 	},
 	.probe	  = isl12057_probe,
+	.remove	  = isl12057_remove,
 	.id_table = isl12057_id,
 };
 module_i2c_driver(isl12057_driver);
 
 MODULE_AUTHOR("Arnaud EBALARD <arno@natisbad.org>");
-MODULE_DESCRIPTION("Intersil ISL12057 RTC driver");
+MODULE_DESCRIPTION("Intersil ISL12057 RTC/Alarm driver");
 MODULE_LICENSE("GPL");
-- 
2.1.1
