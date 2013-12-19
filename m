From: arno@natisbad.org (Arnaud Ebalard)
Date: Thu, 19 Dec 2013 17:24:47 +0100
Subject: [PATCHv6] rtc: Add support for Intersil ISL12057 I2C RTC chip
Message-ID: <e1551dff312307ecd5b23c10414f57a5bbdb8b75.1387445441.git.arno@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Intersil ISL12057 is an I2C RTC chip also supporting two alarms. This
patch only adds support for basic RTC functionalities (i.e. getting
and setting time). Tests have been performed on NETGEAR ReadyNAS 102
w/ startup/shutdown scripts, hwclock, ntpdate and openntpd.

Reviewed-by: Mark Brown <broonie@linaro.org>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Arnaud Ebalard <arno@natisbad.org>
---

In order to get at least some initial support for the chip available in
mainline kernel (v3.14 will have three users waiting for it: ReadyNAS
102, 104 and 2120), I decided to temporarily remove the alarm and IRQ
related code I pushed earlier (see [1] below). If possible, I'd like to
iterate on this before Christmas in order not to miss ARM submission
cutoff (around -rc5) to push the .dts changes (once the driver is queued
for 3.14).

I will submit a patch later to add back Alarm/IRQ support once I get
some feedback from RTC community on how to correctly handle the
specificities of the hardware (Alarm1 interrupt line connected to a power
component and not to the SoC).

Comments welcome!

Cheers,

a+

[1]: http://thread.gmane.org/gmane.linux.drivers.devicetree/46581

Changes since previous v5 (comments from Mark Brown):
 - Added Reviewed-By from Mark

Changes since previous v4 (comments from Guenter Roeck):
 - M-x tabified the whole driver and manually handled tab before
   comments (after defines). In the long run, I will try and find
   a way to make emacs wiser on that last point.
 - Removed checkpatch false positive by cleaning header
 - remove useless forward declaration of isl12057_driver
 - added missing comment about lack of mutex protection
 - typo (s/enable/unable/)
 - removed forgotten data->rtc and associated field in 'data'

 NOTE: I kept definitions of bits (Alarms, etc) to avoid sparse
 info in the file. Additionally, those will be reused soon.

Changes since previous v3 (comments from Guenter Roeck):
 - use BIT() instead of (1<<X)
 - use dev_set_drvdata()/dev_get_drvdata() to simplify access to 'data'
 - removed two (now) useless fields in private 'data' structure
 - now use dev instead of &client->dev

Changes since previous v2 (Comments from Mark Brown):
 - converted to regmap

Changes since previous v1 (Comments from Mark Rutland):
 - fixed return values for isl12057_i2c_{read,set}_regs()
 - checked associated return paths

Changes since previous v0:
 - removed alarm and IRQ related code
 - Switched to isl for intersil (no existing driver has any reference
   to isil, even though this would be the recommended choice)
 - Added intersil info in vendor-prefixes.txt file
 - Added entry for ISL 12057 in I2C trivial-devices.txt file
 - Added mutex protection for non atomic read/write


 .../devicetree/bindings/i2c/trivial-devices.txt    |   1 +
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 drivers/rtc/Kconfig                                |  11 +
 drivers/rtc/Makefile                               |   1 +
 drivers/rtc/rtc-isl12057.c                         | 351 +++++++++++++++++++++
 5 files changed, 365 insertions(+)
 create mode 100644 drivers/rtc/rtc-isl12057.c

diff --git a/Documentation/devicetree/bindings/i2c/trivial-devices.txt b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
index b1cb341..cdf1430 100644
--- a/Documentation/devicetree/bindings/i2c/trivial-devices.txt
+++ b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
@@ -39,6 +39,7 @@ fsl,sgtl5000		SGTL5000: Ultra Low-Power Audio Codec
 gmt,g751		G751: Digital Temperature Sensor and Thermal Watchdog with Two-Wire Interface
 infineon,slb9635tt	Infineon SLB9635 (Soft-) I2C TPM (old protocol, max 100khz)
 infineon,slb9645tt	Infineon SLB9645 I2C TPM (new protocol, max 400khz)
+isl,isl12057		Intersil ISL12057 I2C RTC Chip
 maxim,ds1050		5 Bit Programmable, Pulse-Width Modulator
 maxim,max1237		Low-Power, 4-/12-Channel, 2-Wire Serial, 12-Bit ADCs
 maxim,max6625		9-Bit/12-Bit Temperature Sensors with I?C-Compatible Serial Interface
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index edbb8d8..ed0f63f 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -39,6 +39,7 @@ ibm	International Business Machines (IBM)
 idt	Integrated Device Technologies, Inc.
 img	Imagination Technologies Ltd.
 intercontrol	Inter Control Group
+isl	Intersil
 lg	LG Corporation
 linux	Linux-specific binding
 lsi	LSI Corp. (LSI Logic)
diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 0077302..9608210 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -304,6 +304,17 @@ config RTC_DRV_ISL12022
 	  This driver can also be built as a module. If so, the module
 	  will be called rtc-isl12022.
 
+config RTC_DRV_ISL12057
+       depends on I2C
+       select REGMAP_I2C
+       tristate "Intersil ISL12057"
+       help
+	  If you say yes here you get support for the Intersil ISL12057
+	  I2C RTC chip.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called rtc-isl12057.
+
 config RTC_DRV_X1205
 	tristate "Xicor/Intersil X1205"
 	help
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index 27b4bd8..d4089c0 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -58,6 +58,7 @@ obj-$(CONFIG_RTC_DRV_HID_SENSOR_TIME) += rtc-hid-sensor-time.o
 obj-$(CONFIG_RTC_DRV_IMXDI)	+= rtc-imxdi.o
 obj-$(CONFIG_RTC_DRV_ISL1208)	+= rtc-isl1208.o
 obj-$(CONFIG_RTC_DRV_ISL12022)	+= rtc-isl12022.o
+obj-$(CONFIG_RTC_DRV_ISL12057)	+= rtc-isl12057.o
 obj-$(CONFIG_RTC_DRV_JZ4740)	+= rtc-jz4740.o
 obj-$(CONFIG_RTC_DRV_LP8788)	+= rtc-lp8788.o
 obj-$(CONFIG_RTC_DRV_LPC32XX)	+= rtc-lpc32xx.o
diff --git a/drivers/rtc/rtc-isl12057.c b/drivers/rtc/rtc-isl12057.c
new file mode 100644
index 0000000..68b2b7a
--- /dev/null
+++ b/drivers/rtc/rtc-isl12057.c
@@ -0,0 +1,351 @@
+/*
+ * rtc-isl12057 - Driver for Intersil ISL12057 I2C Real Time Clock
+ *
+ * Copyright (C) 2013, Arnaud EBALARD <arno@natisbad.org>
+ *
+ * This work is largely based on Intersil ISL1208 driver developed by
+ * Hebert Valerio Riedel <hvr@gnu.org>.
+ *
+ * Detailed datasheet on which this development is based is available here:
+ *
+ *  http://natisbad.org/NAS2/refs/ISL12057.pdf
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/rtc.h>
+#include <linux/i2c.h>
+#include <linux/bcd.h>
+#include <linux/rtc.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/regmap.h>
+
+#define DRV_NAME "rtc-isl12057"
+
+/* RTC section */
+#define ISL12057_REG_RTC_SC	0x00	/* Seconds */
+#define ISL12057_REG_RTC_MN	0x01	/* Minutes */
+#define ISL12057_REG_RTC_HR	0x02	/* Hours */
+#define ISL12057_REG_RTC_HR_PM	BIT(5)	/* AM/PM bit in 12h format */
+#define ISL12057_REG_RTC_HR_MIL BIT(6)	/* 24h/12h format */
+#define ISL12057_REG_RTC_DW	0x03	/* Day of the Week */
+#define ISL12057_REG_RTC_DT	0x04	/* Date */
+#define ISL12057_REG_RTC_MO	0x05	/* Month */
+#define ISL12057_REG_RTC_YR	0x06	/* Year */
+#define ISL12057_RTC_SEC_LEN	7
+
+/* Alarm 1 section */
+#define ISL12057_REG_A1_SC	0x07	/* Alarm 1 Seconds */
+#define ISL12057_REG_A1_MN	0x08	/* Alarm 1 Minutes */
+#define ISL12057_REG_A1_HR	0x09	/* Alarm 1 Hours */
+#define ISL12057_REG_A1_HR_PM	BIT(5)	/* AM/PM bit in 12h format */
+#define ISL12057_REG_A1_HR_MIL	BIT(6)	/* 24h/12h format */
+#define ISL12057_REG_A1_DWDT	0x0A	/* Alarm 1 Date / Day of the week */
+#define ISL12057_REG_A1_DWDT_B	BIT(6)	/* DW / DT selection bit */
+#define ISL12057_A1_SEC_LEN	4
+
+/* Alarm 2 section */
+#define ISL12057_REG_A2_MN	0x0B	/* Alarm 2 Minutes */
+#define ISL12057_REG_A2_HR	0x0C	/* Alarm 2 Hours */
+#define ISL12057_REG_A2_DWDT	0x0D	/* Alarm 2 Date / Day of the week */
+#define ISL12057_A2_SEC_LEN	3
+
+/* Control/Status registers */
+#define ISL12057_REG_INT	0x0E
+#define ISL12057_REG_INT_A1IE	BIT(0)	/* Alarm 1 interrupt enable bit */
+#define ISL12057_REG_INT_A2IE	BIT(1)	/* Alarm 2 interrupt enable bit */
+#define ISL12057_REG_INT_INTCN	BIT(2)	/* Interrupt control enable bit */
+#define ISL12057_REG_INT_RS1	BIT(3)	/* Freq out control bit 1 */
+#define ISL12057_REG_INT_RS2	BIT(4)	/* Freq out control bit 2 */
+#define ISL12057_REG_INT_EOSC	BIT(7)	/* Oscillator enable bit */
+
+#define ISL12057_REG_SR		0x0F
+#define ISL12057_REG_SR_A1F	BIT(0)	/* Alarm 1 interrupt bit */
+#define ISL12057_REG_SR_A2F	BIT(1)	/* Alarm 2 interrupt bit */
+#define ISL12057_REG_SR_OSF	BIT(7)	/* Oscillator failure bit */
+
+/* Register memory map length */
+#define ISL12057_MEM_MAP_LEN	0x10
+
+struct isl12057_rtc_data {
+	struct regmap *regmap;
+	struct mutex lock;
+};
+
+static void isl12057_rtc_regs_to_tm(struct rtc_time *tm, u8 *regs)
+{
+	tm->tm_sec = bcd2bin(regs[ISL12057_REG_RTC_SC]);
+	tm->tm_min = bcd2bin(regs[ISL12057_REG_RTC_MN]);
+
+	if (regs[ISL12057_REG_RTC_HR] & ISL12057_REG_RTC_HR_MIL) { /* AM/PM */
+		tm->tm_hour = bcd2bin(regs[ISL12057_REG_RTC_HR] & 0x0f);
+		if (regs[ISL12057_REG_RTC_HR] & ISL12057_REG_RTC_HR_PM)
+			tm->tm_hour += 12;
+	} else {					    /* 24 hour mode */
+		tm->tm_hour = bcd2bin(regs[ISL12057_REG_RTC_HR] & 0x3f);
+	}
+
+	tm->tm_mday = bcd2bin(regs[ISL12057_REG_RTC_DT]);
+	tm->tm_wday = bcd2bin(regs[ISL12057_REG_RTC_DW]) - 1; /* starts at 1 */
+	tm->tm_mon  = bcd2bin(regs[ISL12057_REG_RTC_MO]) - 1; /* starts at 1 */
+	tm->tm_year = bcd2bin(regs[ISL12057_REG_RTC_YR]) + 100;
+}
+
+static int isl12057_rtc_tm_to_regs(u8 *regs, struct rtc_time *tm)
+{
+	/*
+	 * The clock has an 8 bit wide bcd-coded register for the year.
+	 * tm_year is an offset from 1900 and we are interested in the
+	 * 2000-2099 range, so any value less than 100 is invalid.
+	 */
+	if (tm->tm_year < 100)
+		return -EINVAL;
+
+	regs[ISL12057_REG_RTC_SC] = bin2bcd(tm->tm_sec);
+	regs[ISL12057_REG_RTC_MN] = bin2bcd(tm->tm_min);
+	regs[ISL12057_REG_RTC_HR] = bin2bcd(tm->tm_hour); /* 24-hour format */
+	regs[ISL12057_REG_RTC_DT] = bin2bcd(tm->tm_mday);
+	regs[ISL12057_REG_RTC_MO] = bin2bcd(tm->tm_mon + 1);
+	regs[ISL12057_REG_RTC_YR] = bin2bcd(tm->tm_year - 100);
+	regs[ISL12057_REG_RTC_DW] = bin2bcd(tm->tm_wday + 1);
+
+	return 0;
+}
+
+/*
+ * Try and match register bits w/ fixed null values to see whether we
+ * are dealing with an ISL12057. Note: this function is called early
+ * during init and hence does need mutex protection.
+ */
+static int isl12057_i2c_validate_chip(struct regmap *regmap)
+{
+	u8 regs[ISL12057_MEM_MAP_LEN];
+	u8 mask[ISL12057_MEM_MAP_LEN] = { 0x80, 0x80, 0x80, 0xf8,
+					  0xc0, 0x60, 0x00, 0x00,
+					  0x00, 0x00, 0x00, 0x00,
+					  0x00, 0x00, 0x60, 0x7c };
+	int ret, i;
+
+	ret = regmap_bulk_read(regmap, 0, regs, ISL12057_MEM_MAP_LEN);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < ISL12057_MEM_MAP_LEN; ++i) {
+		if (regs[i] & mask[i])	/* check if bits are cleared */
+			return -ENODEV;
+	}
+
+	return 0;
+}
+
+static int isl12057_rtc_read_time(struct device *dev, struct rtc_time *tm)
+{
+	struct isl12057_rtc_data *data = dev_get_drvdata(dev);
+	u8 regs[ISL12057_RTC_SEC_LEN];
+	int ret;
+
+	mutex_lock(&data->lock);
+	ret = regmap_bulk_read(data->regmap, ISL12057_REG_RTC_SC, regs,
+			       ISL12057_RTC_SEC_LEN);
+	mutex_unlock(&data->lock);
+
+	if (ret) {
+		dev_err(dev, "%s: RTC read failed\n", __func__);
+		return ret;
+	}
+
+	isl12057_rtc_regs_to_tm(tm, regs);
+
+	return rtc_valid_tm(tm);
+}
+
+static int isl12057_rtc_set_time(struct device *dev, struct rtc_time *tm)
+{
+	struct isl12057_rtc_data *data = dev_get_drvdata(dev);
+	u8 regs[ISL12057_RTC_SEC_LEN];
+	int ret;
+
+	ret = isl12057_rtc_tm_to_regs(regs, tm);
+	if (ret)
+		return ret;
+
+	mutex_lock(&data->lock);
+	ret = regmap_bulk_write(data->regmap, ISL12057_REG_RTC_SC, regs,
+				ISL12057_RTC_SEC_LEN);
+	mutex_unlock(&data->lock);
+
+	if (ret)
+		dev_err(dev, "%s: RTC write failed\n", __func__);
+
+	return ret;
+}
+
+static int isl12057_rtc_proc(struct device *dev, struct seq_file *seq)
+{
+	struct isl12057_rtc_data *data = dev_get_drvdata(dev);
+	int reg, ret;
+
+	mutex_lock(&data->lock);
+
+	/* Status register */
+	ret = regmap_read(data->regmap, ISL12057_REG_SR, &reg);
+	if (ret) {
+		dev_err(dev, "%s: reading SR failed\n", __func__);
+		goto out;
+	}
+
+	seq_printf(seq, "status_reg\t:%s%s%s (0x%.2x)\n",
+		   (reg & ISL12057_REG_SR_OSF) ? " OSF" : "",
+		   (reg & ISL12057_REG_SR_A1F) ? " A1F" : "",
+		   (reg & ISL12057_REG_SR_A2F) ? " A2F" : "", reg);
+
+	/* Control register */
+	ret = regmap_read(data->regmap, ISL12057_REG_INT, &reg);
+	if (ret) {
+		dev_err(dev, "%s: reading INT failed\n", __func__);
+		goto out;
+	}
+
+	seq_printf(seq, "control_reg\t:%s%s%s%s%s%s (0x%.2x)\n",
+		   (reg & ISL12057_REG_INT_A1IE) ?  " A1IE"  : "",
+		   (reg & ISL12057_REG_INT_A2IE) ?  " A2IE"  : "",
+		   (reg & ISL12057_REG_INT_INTCN) ? " INTCN" : "",
+		   (reg & ISL12057_REG_INT_RS1) ?   " RS1"   : "",
+		   (reg & ISL12057_REG_INT_RS2) ?   " RS2"   : "",
+		   (reg & ISL12057_REG_INT_EOSC) ?  " EOSC"  : "", reg);
+
+ out:
+	mutex_unlock(&data->lock);
+
+	return ret;
+}
+
+/*
+ * Check current RTC status and enable/disable what needs to be. Return 0 if
+ * everything went ok and a negative value upon error. Note: this function
+ * is called early during init and hence does need mutex protection.
+ */
+static int isl12057_check_rtc_status(struct device *dev, struct regmap *regmap)
+{
+	int ret;
+
+	/* Enable oscillator if not already running */
+	ret = regmap_update_bits(regmap, ISL12057_REG_INT,
+				 ISL12057_REG_INT_EOSC, 0);
+	if (ret < 0) {
+		dev_err(dev, "Unable to enable oscillator\n");
+		return ret;
+	}
+
+	/* Clear oscillator failure bit if needed */
+	ret = regmap_update_bits(regmap, ISL12057_REG_SR,
+				 ISL12057_REG_SR_OSF, 0);
+	if (ret < 0) {
+		dev_err(dev, "Unable to clear oscillator failure bit\n");
+		return ret;
+	}
+
+	/* Clear alarm bit if needed */
+	ret = regmap_update_bits(regmap, ISL12057_REG_SR,
+				 ISL12057_REG_SR_A1F, 0);
+	if (ret < 0) {
+		dev_err(dev, "Unable to clear alarm bit\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct rtc_class_ops rtc_ops = {
+	.read_time = isl12057_rtc_read_time,
+	.set_time = isl12057_rtc_set_time,
+	.proc = isl12057_rtc_proc,
+};
+
+static struct regmap_config isl12057_rtc_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+};
+
+static int isl12057_probe(struct i2c_client *client,
+			  const struct i2c_device_id *id)
+{
+	struct device *dev = &client->dev;
+	struct isl12057_rtc_data *data;
+	struct rtc_device *rtc;
+	struct regmap *regmap;
+	int ret;
+
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C |
+				     I2C_FUNC_SMBUS_BYTE_DATA |
+				     I2C_FUNC_SMBUS_I2C_BLOCK))
+		return -ENODEV;
+
+	regmap = devm_regmap_init_i2c(client, &isl12057_rtc_regmap_config);
+	if (IS_ERR(regmap)) {
+		ret = PTR_ERR(regmap);
+		dev_err(dev, "regmap allocation failed: %d\n", ret);
+		return ret;
+	}
+
+	ret = isl12057_i2c_validate_chip(regmap);
+	if (ret)
+		return ret;
+
+	ret = isl12057_check_rtc_status(dev, regmap);
+	if (ret)
+		return ret;
+
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	mutex_init(&data->lock);
+	data->regmap = regmap;
+	dev_set_drvdata(dev, data);
+
+	rtc = devm_rtc_device_register(dev, DRV_NAME, &rtc_ops, THIS_MODULE);
+	if (IS_ERR(rtc))
+		return PTR_ERR(rtc);
+
+	return 0;
+}
+
+#ifdef CONFIG_OF
+static struct of_device_id isl12057_dt_match[] = {
+	{ .compatible = "isl,isl12057" },
+	{ },
+};
+#endif
+
+static const struct i2c_device_id isl12057_id[] = {
+	{ "isl12057", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, isl12057_id);
+
+static struct i2c_driver isl12057_driver = {
+	.driver = {
+		.name = DRV_NAME,
+		.owner = THIS_MODULE,
+		.of_match_table = of_match_ptr(isl12057_dt_match),
+	},
+	.probe	  = isl12057_probe,
+	.id_table = isl12057_id,
+};
+module_i2c_driver(isl12057_driver);
+
+MODULE_AUTHOR("Arnaud EBALARD <arno@natisbad.org>");
+MODULE_DESCRIPTION("Intersil ISL12057 RTC driver");
+MODULE_LICENSE("GPL");
-- 
1.8.4.4
