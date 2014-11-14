From: arno@natisbad.org (Arnaud Ebalard)
Date: Sat, 15 Nov 2014 00:07:27 +0100
Subject: [PATCHv1 6/6] rtc: rtc-isl12057: add alarm support to Intersil
 ISL12057 RTC driver
In-Reply-To: <cover.1416006090.git.arno@natisbad.org>
References: <cover.1416006090.git.arno@natisbad.org>
Message-ID: <986ee8d9d3e6862007f398ffddc2a4bb2368933e.1416006090.git.arno@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


This patch adds alarm support to Intersil ISL12057 driver. This allows
to configure the chip to generate an interrupt when the alarm matches
current time value. Alarm can be programmed up to one month in the
future and is accurate to the second.

The patch was developed to support two different configurations:
systems w/ and w/o RTC chip IRQ line connected to the main CPU.

The latter is the one found on current 3 kernel users of the chip
for which support was initially developed (Netgear ReadyNAS 102,
104 and 2120 NAS). On those devices, the IRQ#2 pin of the chip is not
connected to the SoC but to a PMIC. This allows setting an alarm,
powering off the device and have it wake up when the alarm rings.
To support that configuration the driver does the following:

 1. it has alarm_irq_enable() function returns -ENOTTY when no IRQ
    is passed to the driver.
 2. it marks the device as a wakeup source in all cases (whether an
    IRQ is passed to the driver or not) to have 'wakealarm' sysfs
    entry created.
 3. it marks the device has not supporting UIE mode when no IRQ is
    passed to the driver (see the commmit message of c9f5c7e7a84f)

This specific configuration was tested on a ReadyNAS 102 by setting
an alarm, powering off the device and see it reboot as expected
when the alarm rang.

The former configuration was tested on a Netgear ReadyNAS 102 after
some soldering of the IRQ#2 pin of the RTC chip to a MPP line of the
SoC (the one used usually handles the reset button). The test was
performed using a modified .dts file reflecting this change (see below)
and rtc-test.c program available in Documentation/rtc.txt. This test
program ran as expected, which validates alarm supports, including
interrupt support.

As a side note, the ISL12057 remains in the list of trivial devices,
i.e. no specific DT binding being added by this patch: i2c core
automatically handles extraction of IRQ line info from .dts file. For
instance, if one wants to reference the interrupt line for the
alarm in its .dts file, adding interrupt and interrupt-parent
properties works as expected:

          isl12057: isl12057 at 68 {
                  compatible = "isil,isl12057";
                  interrupt-parent = <&gpio0>;
                  interrupts = <6 IRQ_TYPE_EDGE_FALLING>;
                  reg = <0x68>;
          };

FWIW, if someone is looking for a way to test alarm support on a system
on which the chip IRQ line has the ability to boot the system (e.g.
ReadyNAS 102, 104, etc):

    # echo 0 > /sys/class/rtc/rtc0/wakealarm
    # echo `date '+%s' -d '+ 1 minutes'` > /sys/class/rtc/rtc0/wakealarm
    # shutdown -h now

With the commandes above, after a minute, the system comes back to life.

Signed-off-by: Arnaud Ebalard <arno@natisbad.org>
---
 .../devicetree/bindings/i2c/trivial-devices.txt    |   2 +-
 drivers/rtc/rtc-isl12057.c                         | 324 ++++++++++++++++++++-
 2 files changed, 315 insertions(+), 11 deletions(-)

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
index a783e16cfd2f..2c5b5ecb30b6 100644
--- a/drivers/rtc/rtc-isl12057.c
+++ b/drivers/rtc/rtc-isl12057.c
@@ -1,5 +1,5 @@
 /*
- * rtc-isl12057 - Driver for Intersil ISL12057 I2C Real Time Clock
+ * rtc-isl12057 - Driver for Intersil ISL12057 I2C Real Time Clock / Alarm
  *
  * Copyright (C) 2013, Arnaud EBALARD <arno@natisbad.org>
  *
@@ -79,8 +79,10 @@
 #define ISL12057_MEM_MAP_LEN	0x10
 
 struct isl12057_rtc_data {
+	struct rtc_device *rtc;
 	struct regmap *regmap;
 	struct mutex lock;
+	int irq;
 };
 
 static void isl12057_rtc_regs_to_tm(struct rtc_time *tm, u8 *regs)
@@ -160,14 +162,47 @@ static int isl12057_i2c_validate_chip(struct regmap *regmap)
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
+	if (ret)
+		dev_err(dev, "%s: clearing alarm failed (%d)\n", __func__, ret);
+
+	return ret;
+}
+
+static int _isl12057_rtc_update_alarm(struct device *dev, int enable)
+{
+	struct isl12057_rtc_data *data = dev_get_drvdata(dev);
+	int ret;
+
+	ret = regmap_update_bits(data->regmap, ISL12057_REG_INT,
+				 ISL12057_REG_INT_A1IE,
+				 enable ? ISL12057_REG_INT_A1IE : 0);
+	if (ret)
+		dev_err(dev, "%s: changing alarm interrupt flag failed (%d)\n",
+			__func__, ret);
+
+	return ret;
+}
+
+/*
+ * Note: as we only read from device and do not perform any update, there is
+ * no need for an equivalent function which would try and get driver's main
+ * lock. Here, it is safe for everyone if we just use regmap internal lock
+ * on the device when reading.
+ */
+static int _isl12057_rtc_read_time(struct device *dev, struct rtc_time *tm)
 {
 	struct isl12057_rtc_data *data = dev_get_drvdata(dev);
 	u8 regs[ISL12057_RTC_SEC_LEN];
 	unsigned int sr;
 	int ret;
 
-	mutex_lock(&data->lock);
 	ret = regmap_read(data->regmap, ISL12057_REG_SR, &sr);
 	if (ret) {
 		dev_err(dev, "%s: unable to read oscillator status flag (%d)\n",
@@ -187,8 +222,6 @@ static int isl12057_rtc_read_time(struct device *dev, struct rtc_time *tm)
 			__func__, ret);
 
 out:
-	mutex_unlock(&data->lock);
-
 	if (ret)
 		return ret;
 
@@ -197,6 +230,168 @@ out:
 	return rtc_valid_tm(tm);
 }
 
+static int isl12057_rtc_update_alarm(struct device *dev, int enable)
+{
+	struct isl12057_rtc_data *data = dev_get_drvdata(dev);
+	int ret;
+
+	mutex_lock(&data->lock);
+	ret = _isl12057_rtc_update_alarm(dev, enable);
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
+		dev_err(dev, "%s: reading alarm section failed (%d)\n",
+			__func__, ret);
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
+		dev_err(dev, "%s: reading alarm interrupt flag failed (%d)\n",
+			__func__, ret);
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
+			dev_err(dev, "%s: max for alarm is one month (%d)\n",
+				__func__, ret);
+			ret = -EINVAL;
+			goto err_unlock;
+		}
+	}
+
+	/* Disable the alarm before modifying it */
+	ret = _isl12057_rtc_update_alarm(dev, 0);
+	if (ret < 0) {
+		dev_err(dev, "%s: unable to disable the alarm (%d)\n",
+			__func__, ret);
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
+		dev_err(dev, "%s: writing alarm section failed (%d)\n",
+			__func__, ret);
+		goto err_unlock;
+	}
+
+	/* Enable or disable alarm */
+	ret = _isl12057_rtc_update_alarm(dev, enable);
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
@@ -262,9 +457,48 @@ static int isl12057_check_rtc_status(struct device *dev, struct regmap *regmap)
 	return 0;
 }
 
+static int isl12057_rtc_alarm_irq_enable(struct device *dev,
+					 unsigned int enable)
+{
+	struct isl12057_rtc_data *rtc_data = dev_get_drvdata(dev);
+	int ret = -ENOTTY;
+
+	if (rtc_data->irq)
+		ret = isl12057_rtc_update_alarm(dev, enable);
+
+	return ret;
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
+		_isl12057_rtc_update_alarm(&client->dev, 0);
+
+		handled = IRQ_HANDLED;
+	}
+
+	return handled;
+}
+
 static const struct rtc_class_ops rtc_ops = {
-	.read_time = isl12057_rtc_read_time,
+	.read_time = _isl12057_rtc_read_time,
 	.set_time = isl12057_rtc_set_time,
+	.read_alarm = isl12057_rtc_read_alarm,
+	.set_alarm = isl12057_rtc_set_alarm,
+	.alarm_irq_enable = isl12057_rtc_alarm_irq_enable,
 };
 
 static struct regmap_config isl12057_rtc_regmap_config = {
@@ -277,7 +511,6 @@ static int isl12057_probe(struct i2c_client *client,
 {
 	struct device *dev = &client->dev;
 	struct isl12057_rtc_data *data;
-	struct rtc_device *rtc;
 	struct regmap *regmap;
 	int ret;
 
@@ -310,10 +543,79 @@ static int isl12057_probe(struct i2c_client *client,
 	data->regmap = regmap;
 	dev_set_drvdata(dev, data);
 
-	rtc = devm_rtc_device_register(dev, DRV_NAME, &rtc_ops, THIS_MODULE);
-	return PTR_ERR_OR_ZERO(rtc);
+	if (client->irq > 0) {
+		ret = devm_request_threaded_irq(dev, client->irq, NULL,
+						isl12057_rtc_interrupt,
+						IRQF_SHARED|IRQF_ONESHOT,
+						DRV_NAME, client);
+		if (!ret)
+			data->irq = client->irq;
+		else
+			dev_err(dev, "%s: irq %d unavailable (%d)\n", __func__,
+				client->irq, ret);
+	}
+
+	/*
+	 * This is needed to have 'wakealarm' sysfs entry available. One
+	 * would expect the device to be marked as a wakeup source only
+	 * when an IRQ pin of the RTC is routed to an interrupt line of the
+	 * CPU. In practice, such an IRQ pin can be connected to a PMIC and
+	 * this allows the device to be powered up when RTC alarm rings.
+	 */
+	device_init_wakeup(dev, true);
+
+	data->rtc = devm_rtc_device_register(dev, DRV_NAME, &rtc_ops,
+					     THIS_MODULE);
+	ret = PTR_ERR_OR_ZERO(data->rtc);
+	if (ret) {
+		dev_err(dev, "%s: unable to register RTC device (%d)\n",
+			__func__, ret);
+		goto err;
+	}
+
+	/* We cannot support UIE mode if we do not have an IRQ line */
+	if (!data->irq)
+		data->rtc->uie_unsupported = 1;
+
+err:
+	return ret;
 }
 
+static int isl12057_remove(struct i2c_client *client)
+{
+	struct isl12057_rtc_data *rtc_data = dev_get_drvdata(&client->dev);
+
+	if (rtc_data->irq > 0)
+		device_init_wakeup(&client->dev, false);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int isl12057_rtc_suspend(struct device *dev)
+{
+	struct isl12057_rtc_data *rtc_data = dev_get_drvdata(dev);
+
+	if (device_may_wakeup(dev))
+		return enable_irq_wake(rtc_data->irq);
+
+	return 0;
+}
+
+static int isl12057_rtc_resume(struct device *dev)
+{
+	struct isl12057_rtc_data *rtc_data = dev_get_drvdata(dev);
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
 	{ .compatible = "isl,isl12057" },  /* obsolete */
@@ -332,13 +634,15 @@ static struct i2c_driver isl12057_driver = {
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
