From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Tue, 12 Jan 2010 11:22:22 -0500
Subject: [PATCH] regulator: support max8649
Message-ID: <mailman.138.1263285699.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable Maxim max8649 regulator driver.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 drivers/regulator/Kconfig   |    7 +
 drivers/regulator/Makefile  |    1 +
 drivers/regulator/max8649.c |  347 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 355 insertions(+), 0 deletions(-)
 create mode 100644 drivers/regulator/max8649.c

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 1cdd281..d17242a 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -69,6 +69,13 @@ config REGULATOR_MAX1586
 	  regulator via I2C bus. The provided regulator is suitable
 	  for PXA27x chips to control VCC_CORE and VCC_USIM voltages.

+config REGULATOR_MAX8649
+	tristate "Maxim 8649 voltage regulator"
+	depends on I2C
+	help
+	  This driver controls a Maxim 8649 voltage output regulator via
+	  I2C bus.
+
 config REGULATOR_MAX8660
 	tristate "Maxim 8660/8661 voltage regulator"
 	depends on I2C
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index cd73740..3894c17 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_REGULATOR_BQ24022) += bq24022.o
 obj-$(CONFIG_REGULATOR_LP3971) += lp3971.o
 obj-$(CONFIG_REGULATOR_MAX1586) += max1586.o
 obj-$(CONFIG_REGULATOR_TWL4030) += twl-regulator.o
+obj-$(CONFIG_REGULATOR_MAX8649)	+= max8649.o
 obj-$(CONFIG_REGULATOR_MAX8660) += max8660.o
 obj-$(CONFIG_REGULATOR_MAX8925) += max8925.o
 obj-$(CONFIG_REGULATOR_WM831X) += wm831x-dcdc.o
diff --git a/drivers/regulator/max8649.c b/drivers/regulator/max8649.c
new file mode 100644
index 0000000..1dffbba
--- /dev/null
+++ b/drivers/regulator/max8649.c
@@ -0,0 +1,347 @@
+/*
+ * Regulators driver for Maxim max8649
+ *
+ * Copyright (C) 2009-2010 Marvell International Ltd.
+ *      Haojian Zhuang <haojian.zhuang@marvell.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/platform_device.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/max8649.h>
+
+#define MAX8649_DCDC_VMIN	750000		/* uV */
+#define MAX8649_DCDC_VMAX	1380000		/* uV */
+#define MAX8649_DCDC_STEP	10000		/* uV */
+#define MAX8649_VOL_MASK	0x3f
+
+/* Registers */
+#define MAX8649_MODE0		0x00
+#define MAX8649_MODE1		0x01
+#define MAX8649_MODE2		0x02
+#define MAX8649_MODE3		0x03
+#define MAX8649_CONTROL		0x04
+#define MAX8649_SYNC		0x05
+#define MAX8649_RAMP		0x06
+#define MAX8649_CHIP_ID1	0x08
+#define MAX8649_CHIP_ID2	0x09
+
+/* Bits */
+#define MAX8649_EN_PD		(1 << 7)
+#define MAX8649_VID0_PD		(1 << 6)
+#define MAX8649_VID1_PD		(1 << 5)
+#define MAX8649_VID_MASK	(3 << 5)
+
+#define MAX8649_POWER_SAVE	(1 << 7)
+#define MAX8649_SYNC_EXTCLK	(1 << 6)
+
+#define MAX8649_EXT_MASK	(3 << 6)
+
+#define MAX8649_RAMP_MASK	(7 << 5)
+#define MAX8649_RAMP_DOWN	(1 << 1)
+
+struct max8649_regulator_info {
+	struct regulator_dev	*regulator;
+	struct i2c_client	*i2c;
+	struct device		*dev;
+	struct mutex		io_lock;
+
+	int		vol_reg;
+	unsigned	mode:2;	/* bit[1:0] = VID1, VID0 */
+	unsigned	extclk_freq:2;
+	unsigned	extclk:1;
+	unsigned	powersave:1;	
+	unsigned	ramp_timing:3;
+	unsigned	ramp_down:1;
+};
+
+/* I2C operations */
+
+static inline int max8649_read_device(struct i2c_client *i2c,
+				      int reg, int bytes, void *dest)
+{
+	unsigned char data;
+	int ret;
+
+	data = (unsigned char)reg;
+	ret = i2c_master_send(i2c, &data, 1);
+	if (ret < 0)
+		return ret;
+	ret = i2c_master_recv(i2c, dest, bytes);
+	if (ret < 0)
+		return ret;
+	return 0;
+}
+
+static inline int max8649_write_device(struct i2c_client *i2c,
+				       int reg, int bytes, void *src)
+{
+	unsigned char buf[bytes + 1];
+	int ret;
+
+	buf[0] = (unsigned char)reg;
+	memcpy(&buf[1], src, bytes);
+
+	ret = i2c_master_send(i2c, buf, bytes + 1);
+	if (ret < 0)
+		return ret;
+	return 0;
+}
+
+static int max8649_reg_read(struct i2c_client *i2c, int reg)
+{
+	struct max8649_regulator_info *info = i2c_get_clientdata(i2c);
+	unsigned char data;
+	int ret;
+
+	mutex_lock(&info->io_lock);
+	ret = max8649_read_device(i2c, reg, 1, &data);
+	mutex_unlock(&info->io_lock);
+
+	if (ret < 0)
+		return ret;
+	return (int)data;
+}
+
+static int max8649_set_bits(struct i2c_client *i2c, int reg,
+			    unsigned char mask, unsigned char data)
+{
+	struct max8649_regulator_info *info = i2c_get_clientdata(i2c);
+	unsigned char value;
+	int ret;
+
+	mutex_lock(&info->io_lock);
+	ret = max8649_read_device(i2c, reg, 1, &value);
+	if (ret < 0)
+		goto out;
+	value &= ~mask;
+	value |= data;
+	ret = max8649_write_device(i2c, reg, 1, &value);
+out:
+	mutex_unlock(&info->io_lock);
+	return ret;
+}
+
+static inline int check_range(int min_uV, int max_uV)
+{
+	if ((min_uV < MAX8649_DCDC_VMIN) || (max_uV > MAX8649_DCDC_VMAX)
+		|| (min_uV > max_uV))
+		return -EINVAL;
+	return 0;
+}
+
+static int max8649_list_voltage(struct regulator_dev *rdev, unsigned index)
+{
+	return MAX8649_DCDC_VMIN + index * MAX8649_DCDC_STEP;
+}
+
+static int max8649_get_voltage(struct regulator_dev *rdev)
+{
+	struct max8649_regulator_info *info = rdev_get_drvdata(rdev);
+	unsigned char data;
+	int ret;
+
+	ret = max8649_reg_read(info->i2c, info->vol_reg);
+	if (ret < 0)
+		return ret;
+	data = (unsigned char)ret & MAX8649_VOL_MASK;
+	return max8649_list_voltage(rdev, data);
+}
+
+static int max8649_set_voltage(struct regulator_dev *rdev,
+			       int min_uV, int max_uV)
+{
+	struct max8649_regulator_info *info = rdev_get_drvdata(rdev);
+	unsigned char data, mask;
+
+	if (check_range(min_uV, max_uV)) {
+		dev_err(info->dev, "invalid voltage range (%d, %d) uV\n",
+			min_uV, max_uV);
+		return -EINVAL;
+	}
+	data= (min_uV - MAX8649_DCDC_VMIN + MAX8649_DCDC_STEP - 1)
+		/ MAX8649_DCDC_STEP;
+	mask = MAX8649_VOL_MASK;
+
+	return max8649_set_bits(info->i2c, info->vol_reg, mask, data);
+}
+
+/* EN_PD means pulldown on EN input */
+static int max8649_enable(struct regulator_dev *rdev)
+{
+	struct max8649_regulator_info *info = rdev_get_drvdata(rdev);
+	return max8649_set_bits(info->i2c, MAX8649_CONTROL, MAX8649_EN_PD, 0);
+}
+
+/*
+ * Applied internal pulldown resistor on EN input pin.
+ * If pulldown EN pin outside, it would be better.
+ */
+static int max8649_disable(struct regulator_dev *rdev)
+{
+	struct max8649_regulator_info *info = rdev_get_drvdata(rdev);
+	return max8649_set_bits(info->i2c, MAX8649_CONTROL, MAX8649_EN_PD,
+				MAX8649_EN_PD);
+}
+
+static int max8649_is_enabled(struct regulator_dev *rdev)
+{
+	struct max8649_regulator_info *info = rdev_get_drvdata(rdev);
+	int ret;
+
+	ret = max8649_reg_read(info->i2c, MAX8649_CONTROL);
+	if (ret < 0)
+		return ret;
+	return !((unsigned char)ret & MAX8649_EN_PD);
+}
+
+static struct regulator_ops max8649_dcdc_ops = {
+	.set_voltage	= max8649_set_voltage,
+	.get_voltage	= max8649_get_voltage,
+	.list_voltage	= max8649_list_voltage,
+	.enable		= max8649_enable,
+	.disable	= max8649_disable,
+	.is_enabled	= max8649_is_enabled,
+
+};
+
+static struct regulator_desc dcdc_desc = {
+	.name		= "DCDC",
+	.ops		= &max8649_dcdc_ops,
+	.type		= REGULATOR_VOLTAGE,
+	.n_voltages	= 1 << 7,
+	.owner		= THIS_MODULE,
+};
+
+static int __devinit max8649_regulator_probe(struct i2c_client *client,
+					     const struct i2c_device_id *id)
+{
+	struct max8649_platform_data *pdata = client->dev.platform_data;
+	struct max8649_regulator_info *info = NULL;
+	unsigned char data;
+	int ret;
+
+	info = kzalloc(sizeof(struct max8649_regulator_info), GFP_KERNEL);
+	if (!info) {
+		dev_err(&client->dev, "No enough memory\n");
+		return -ENOMEM;
+	}
+
+	info->i2c = client;
+	info->dev = &client->dev;
+	mutex_init(&info->io_lock);
+	i2c_set_clientdata(client, info);
+
+	info->mode = pdata->mode;
+	info->vol_reg = (info->mode == 0) ? MAX8649_MODE0
+			: ((info->mode == 1) ? MAX8649_MODE1
+			: ((info->mode == 2) ? MAX8649_MODE2
+			: MAX8649_MODE3));
+
+	ret = max8649_reg_read(info->i2c, MAX8649_CHIP_ID1);
+	if (ret < 0) {
+		dev_err(info->dev, "Failed to detect ID of MAX8649:%d\n",
+			ret);
+		goto out;
+	}
+	dev_info(info->dev, "Detected MAX8649 (ID:%x)\n", ret);
+
+	/* enable VID0 & VID1 */
+	max8649_set_bits(info->i2c, MAX8649_CONTROL, MAX8649_VID_MASK, 0);
+
+	/* enable/disable external clock synchronization */
+	info->extclk = pdata->extclk;
+	data = (info->extclk) ? MAX8649_SYNC_EXTCLK : 0;
+	max8649_set_bits(info->i2c, info->vol_reg, MAX8649_SYNC_EXTCLK, data);
+	if (info->extclk) {
+		/* set external clock frequency */
+		info->extclk_freq = pdata->extclk_freq;
+		max8649_set_bits(info->i2c, MAX8649_SYNC, MAX8649_EXT_MASK,
+				 info->extclk_freq);
+	}
+
+	/* enable/disable auto enter power save mode */
+	info->powersave = pdata->powersave;
+	data = (info->powersave) ? 0 : MAX8649_POWER_SAVE;
+	max8649_set_bits(info->i2c, info->vol_reg, MAX8649_POWER_SAVE, data);
+
+	if (pdata->ramp_timing) {
+		info->ramp_timing = pdata->ramp_timing;
+		max8649_set_bits(info->i2c, MAX8649_RAMP, MAX8649_RAMP_MASK,
+				 info->ramp_timing << 5);
+	}
+
+	info->ramp_down = pdata->ramp_down;
+	if (info->powersave && info->ramp_down) {
+		max8649_set_bits(info->i2c, MAX8649_RAMP, MAX8649_RAMP_DOWN,
+				 MAX8649_RAMP_DOWN);
+	}
+
+	info->regulator = regulator_register(&dcdc_desc, &client->dev,
+					     pdata->regulator, info);
+	if (IS_ERR(info->regulator)) {
+		dev_err(info->dev, "failed to register regulator %s\n",
+			dcdc_desc.name);
+		ret = PTR_ERR(info->regulator);
+		goto out;
+	}
+
+	pr_info("Max8649 regulator device is detected.\n");
+	return 0;
+out:
+	kfree(info);
+	return ret;
+}
+
+static int __devexit max8649_regulator_remove(struct i2c_client *client)
+{
+	struct max8649_regulator_info *info = i2c_get_clientdata(client);
+
+	if (info) {
+		if (info->regulator)
+			regulator_unregister(info->regulator);
+		kfree(info);
+	}
+	i2c_set_clientdata(client, NULL);
+
+	return 0;
+}
+
+static const struct i2c_device_id max8649_id[] = {
+	{ "max8649", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, max8649_id);
+
+static struct i2c_driver max8649_driver = {
+	.probe		= max8649_regulator_probe,
+	.remove		= __devexit_p(max8649_regulator_remove),
+	.driver		= {
+		.name	= "max8649",
+	},
+	.id_table	= max8649_id,
+};
+
+static int __init max8649_init(void)
+{
+	return i2c_add_driver(&max8649_driver);
+}
+subsys_initcall(max8649_init);
+
+static void __exit max8649_exit(void)
+{
+	i2c_del_driver(&max8649_driver);
+}
+module_exit(max8649_exit);
+
+/* Module information */
+MODULE_DESCRIPTION("MAXIM 8649 voltage regulator driver");
+MODULE_AUTHOR("Haojian Zhuang <haojian.zhuang@marvell.com>");
+MODULE_LICENSE("GPL");
+
-- 
1.5.6.5

--00504502c13bdd7d2e047cf39ee8
Content-Type: text/x-patch; charset=US-ASCII; name="0001-regulator-support-max8649.patch"
Content-Disposition: attachment; 
	filename="0001-regulator-support-max8649.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g4cw8z7i0

RnJvbSA0YzFmNGVmMDFiOTFiNWFlNzkyMTUwOWI0NTZjZWQ0NWNlY2RmYzMwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBIYW9qaWFuIFpodWFuZyA8aGFvamlhbi56aHVhbmdAbWFydmVs
bC5jb20+CkRhdGU6IFR1ZSwgMTIgSmFuIDIwMTAgMTE6MjI6MjIgLTA1MDAKU3ViamVjdDogW1BB
VENIXSByZWd1bGF0b3I6IHN1cHBvcnQgbWF4ODY0OQoKRW5hYmxlIE1heGltIG1heDg2NDkgcmVn
dWxhdG9yIGRyaXZlci4KClNpZ25lZC1vZmYtYnk6IEhhb2ppYW4gWmh1YW5nIDxoYW9qaWFuLnpo
dWFuZ0BtYXJ2ZWxsLmNvbT4KLS0tCiBkcml2ZXJzL3JlZ3VsYXRvci9LY29uZmlnICAgfCAgICA3
ICsKIGRyaXZlcnMvcmVndWxhdG9yL01ha2VmaWxlICB8ICAgIDEgKwogZHJpdmVycy9yZWd1bGF0
b3IvbWF4ODY0OS5jIHwgIDM0NyArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrCiAzIGZpbGVzIGNoYW5nZWQsIDM1NSBpbnNlcnRpb25zKCspLCAwIGRlbGV0aW9ucygt
KQogY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvcmVndWxhdG9yL21heDg2NDkuYwoKZGlmZiAt
LWdpdCBhL2RyaXZlcnMvcmVndWxhdG9yL0tjb25maWcgYi9kcml2ZXJzL3JlZ3VsYXRvci9LY29u
ZmlnCmluZGV4IDFjZGQyODEuLmQxNzI0MmEgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvcmVndWxhdG9y
L0tjb25maWcKKysrIGIvZHJpdmVycy9yZWd1bGF0b3IvS2NvbmZpZwpAQCAtNjksNiArNjksMTMg
QEAgY29uZmlnIFJFR1VMQVRPUl9NQVgxNTg2CiAJICByZWd1bGF0b3IgdmlhIEkyQyBidXMuIFRo
ZSBwcm92aWRlZCByZWd1bGF0b3IgaXMgc3VpdGFibGUKIAkgIGZvciBQWEEyN3ggY2hpcHMgdG8g
Y29udHJvbCBWQ0NfQ09SRSBhbmQgVkNDX1VTSU0gdm9sdGFnZXMuCiAKK2NvbmZpZyBSRUdVTEFU
T1JfTUFYODY0OQorCXRyaXN0YXRlICJNYXhpbSA4NjQ5IHZvbHRhZ2UgcmVndWxhdG9yIgorCWRl
cGVuZHMgb24gSTJDCisJaGVscAorCSAgVGhpcyBkcml2ZXIgY29udHJvbHMgYSBNYXhpbSA4NjQ5
IHZvbHRhZ2Ugb3V0cHV0IHJlZ3VsYXRvciB2aWEKKwkgIEkyQyBidXMuCisKIGNvbmZpZyBSRUdV
TEFUT1JfTUFYODY2MAogCXRyaXN0YXRlICJNYXhpbSA4NjYwLzg2NjEgdm9sdGFnZSByZWd1bGF0
b3IiCiAJZGVwZW5kcyBvbiBJMkMKZGlmZiAtLWdpdCBhL2RyaXZlcnMvcmVndWxhdG9yL01ha2Vm
aWxlIGIvZHJpdmVycy9yZWd1bGF0b3IvTWFrZWZpbGUKaW5kZXggY2Q3Mzc0MC4uMzg5NGMxNyAx
MDA2NDQKLS0tIGEvZHJpdmVycy9yZWd1bGF0b3IvTWFrZWZpbGUKKysrIGIvZHJpdmVycy9yZWd1
bGF0b3IvTWFrZWZpbGUKQEAgLTEyLDYgKzEyLDcgQEAgb2JqLSQoQ09ORklHX1JFR1VMQVRPUl9C
UTI0MDIyKSArPSBicTI0MDIyLm8KIG9iai0kKENPTkZJR19SRUdVTEFUT1JfTFAzOTcxKSArPSBs
cDM5NzEubwogb2JqLSQoQ09ORklHX1JFR1VMQVRPUl9NQVgxNTg2KSArPSBtYXgxNTg2Lm8KIG9i
ai0kKENPTkZJR19SRUdVTEFUT1JfVFdMNDAzMCkgKz0gdHdsLXJlZ3VsYXRvci5vCitvYmotJChD
T05GSUdfUkVHVUxBVE9SX01BWDg2NDkpCSs9IG1heDg2NDkubwogb2JqLSQoQ09ORklHX1JFR1VM
QVRPUl9NQVg4NjYwKSArPSBtYXg4NjYwLm8KIG9iai0kKENPTkZJR19SRUdVTEFUT1JfTUFYODky
NSkgKz0gbWF4ODkyNS5vCiBvYmotJChDT05GSUdfUkVHVUxBVE9SX1dNODMxWCkgKz0gd204MzF4
LWRjZGMubwpkaWZmIC0tZ2l0IGEvZHJpdmVycy9yZWd1bGF0b3IvbWF4ODY0OS5jIGIvZHJpdmVy
cy9yZWd1bGF0b3IvbWF4ODY0OS5jCm5ldyBmaWxlIG1vZGUgMTAwNjQ0CmluZGV4IDAwMDAwMDAu
LjFkZmZiYmEKLS0tIC9kZXYvbnVsbAorKysgYi9kcml2ZXJzL3JlZ3VsYXRvci9tYXg4NjQ5LmMK
QEAgLTAsMCArMSwzNDcgQEAKKy8qCisgKiBSZWd1bGF0b3JzIGRyaXZlciBmb3IgTWF4aW0gbWF4
ODY0OQorICoKKyAqIENvcHlyaWdodCAoQykgMjAwOS0yMDEwIE1hcnZlbGwgSW50ZXJuYXRpb25h
bCBMdGQuCisgKiAgICAgIEhhb2ppYW4gWmh1YW5nIDxoYW9qaWFuLnpodWFuZ0BtYXJ2ZWxsLmNv
bT4KKyAqCisgKiBUaGlzIHByb2dyYW0gaXMgZnJlZSBzb2Z0d2FyZTsgeW91IGNhbiByZWRpc3Ry
aWJ1dGUgaXQgYW5kL29yIG1vZGlmeQorICogaXQgdW5kZXIgdGhlIHRlcm1zIG9mIHRoZSBHTlUg
R2VuZXJhbCBQdWJsaWMgTGljZW5zZSB2ZXJzaW9uIDIgYXMKKyAqIHB1Ymxpc2hlZCBieSB0aGUg
RnJlZSBTb2Z0d2FyZSBGb3VuZGF0aW9uLgorICovCisjaW5jbHVkZSA8bGludXgva2VybmVsLmg+
CisjaW5jbHVkZSA8bGludXgvbW9kdWxlLmg+CisjaW5jbHVkZSA8bGludXgvZXJyLmg+CisjaW5j
bHVkZSA8bGludXgvaTJjLmg+CisjaW5jbHVkZSA8bGludXgvcGxhdGZvcm1fZGV2aWNlLmg+Cisj
aW5jbHVkZSA8bGludXgvcmVndWxhdG9yL2RyaXZlci5oPgorI2luY2x1ZGUgPGxpbnV4L3JlZ3Vs
YXRvci9tYXg4NjQ5Lmg+CisKKyNkZWZpbmUgTUFYODY0OV9EQ0RDX1ZNSU4JNzUwMDAwCQkvKiB1
ViAqLworI2RlZmluZSBNQVg4NjQ5X0RDRENfVk1BWAkxMzgwMDAwCQkvKiB1ViAqLworI2RlZmlu
ZSBNQVg4NjQ5X0RDRENfU1RFUAkxMDAwMAkJLyogdVYgKi8KKyNkZWZpbmUgTUFYODY0OV9WT0xf
TUFTSwkweDNmCisKKy8qIFJlZ2lzdGVycyAqLworI2RlZmluZSBNQVg4NjQ5X01PREUwCQkweDAw
CisjZGVmaW5lIE1BWDg2NDlfTU9ERTEJCTB4MDEKKyNkZWZpbmUgTUFYODY0OV9NT0RFMgkJMHgw
MgorI2RlZmluZSBNQVg4NjQ5X01PREUzCQkweDAzCisjZGVmaW5lIE1BWDg2NDlfQ09OVFJPTAkJ
MHgwNAorI2RlZmluZSBNQVg4NjQ5X1NZTkMJCTB4MDUKKyNkZWZpbmUgTUFYODY0OV9SQU1QCQkw
eDA2CisjZGVmaW5lIE1BWDg2NDlfQ0hJUF9JRDEJMHgwOAorI2RlZmluZSBNQVg4NjQ5X0NISVBf
SUQyCTB4MDkKKworLyogQml0cyAqLworI2RlZmluZSBNQVg4NjQ5X0VOX1BECQkoMSA8PCA3KQor
I2RlZmluZSBNQVg4NjQ5X1ZJRDBfUEQJCSgxIDw8IDYpCisjZGVmaW5lIE1BWDg2NDlfVklEMV9Q
RAkJKDEgPDwgNSkKKyNkZWZpbmUgTUFYODY0OV9WSURfTUFTSwkoMyA8PCA1KQorCisjZGVmaW5l
IE1BWDg2NDlfUE9XRVJfU0FWRQkoMSA8PCA3KQorI2RlZmluZSBNQVg4NjQ5X1NZTkNfRVhUQ0xL
CSgxIDw8IDYpCisKKyNkZWZpbmUgTUFYODY0OV9FWFRfTUFTSwkoMyA8PCA2KQorCisjZGVmaW5l
IE1BWDg2NDlfUkFNUF9NQVNLCSg3IDw8IDUpCisjZGVmaW5lIE1BWDg2NDlfUkFNUF9ET1dOCSgx
IDw8IDEpCisKK3N0cnVjdCBtYXg4NjQ5X3JlZ3VsYXRvcl9pbmZvIHsKKwlzdHJ1Y3QgcmVndWxh
dG9yX2RldgkqcmVndWxhdG9yOworCXN0cnVjdCBpMmNfY2xpZW50CSppMmM7CisJc3RydWN0IGRl
dmljZQkJKmRldjsKKwlzdHJ1Y3QgbXV0ZXgJCWlvX2xvY2s7CisKKwlpbnQJCXZvbF9yZWc7CisJ
dW5zaWduZWQJbW9kZToyOwkvKiBiaXRbMTowXSA9IFZJRDEsIFZJRDAgKi8KKwl1bnNpZ25lZAll
eHRjbGtfZnJlcToyOworCXVuc2lnbmVkCWV4dGNsazoxOworCXVuc2lnbmVkCXBvd2Vyc2F2ZTox
OwkKKwl1bnNpZ25lZAlyYW1wX3RpbWluZzozOworCXVuc2lnbmVkCXJhbXBfZG93bjoxOworfTsK
KworLyogSTJDIG9wZXJhdGlvbnMgKi8KKworc3RhdGljIGlubGluZSBpbnQgbWF4ODY0OV9yZWFk
X2RldmljZShzdHJ1Y3QgaTJjX2NsaWVudCAqaTJjLAorCQkJCSAgICAgIGludCByZWcsIGludCBi
eXRlcywgdm9pZCAqZGVzdCkKK3sKKwl1bnNpZ25lZCBjaGFyIGRhdGE7CisJaW50IHJldDsKKwor
CWRhdGEgPSAodW5zaWduZWQgY2hhcilyZWc7CisJcmV0ID0gaTJjX21hc3Rlcl9zZW5kKGkyYywg
JmRhdGEsIDEpOworCWlmIChyZXQgPCAwKQorCQlyZXR1cm4gcmV0OworCXJldCA9IGkyY19tYXN0
ZXJfcmVjdihpMmMsIGRlc3QsIGJ5dGVzKTsKKwlpZiAocmV0IDwgMCkKKwkJcmV0dXJuIHJldDsK
KwlyZXR1cm4gMDsKK30KKworc3RhdGljIGlubGluZSBpbnQgbWF4ODY0OV93cml0ZV9kZXZpY2Uo
c3RydWN0IGkyY19jbGllbnQgKmkyYywKKwkJCQkgICAgICAgaW50IHJlZywgaW50IGJ5dGVzLCB2
b2lkICpzcmMpCit7CisJdW5zaWduZWQgY2hhciBidWZbYnl0ZXMgKyAxXTsKKwlpbnQgcmV0Owor
CisJYnVmWzBdID0gKHVuc2lnbmVkIGNoYXIpcmVnOworCW1lbWNweSgmYnVmWzFdLCBzcmMsIGJ5
dGVzKTsKKworCXJldCA9IGkyY19tYXN0ZXJfc2VuZChpMmMsIGJ1ZiwgYnl0ZXMgKyAxKTsKKwlp
ZiAocmV0IDwgMCkKKwkJcmV0dXJuIHJldDsKKwlyZXR1cm4gMDsKK30KKworc3RhdGljIGludCBt
YXg4NjQ5X3JlZ19yZWFkKHN0cnVjdCBpMmNfY2xpZW50ICppMmMsIGludCByZWcpCit7CisJc3Ry
dWN0IG1heDg2NDlfcmVndWxhdG9yX2luZm8gKmluZm8gPSBpMmNfZ2V0X2NsaWVudGRhdGEoaTJj
KTsKKwl1bnNpZ25lZCBjaGFyIGRhdGE7CisJaW50IHJldDsKKworCW11dGV4X2xvY2soJmluZm8t
PmlvX2xvY2spOworCXJldCA9IG1heDg2NDlfcmVhZF9kZXZpY2UoaTJjLCByZWcsIDEsICZkYXRh
KTsKKwltdXRleF91bmxvY2soJmluZm8tPmlvX2xvY2spOworCisJaWYgKHJldCA8IDApCisJCXJl
dHVybiByZXQ7CisJcmV0dXJuIChpbnQpZGF0YTsKK30KKworc3RhdGljIGludCBtYXg4NjQ5X3Nl
dF9iaXRzKHN0cnVjdCBpMmNfY2xpZW50ICppMmMsIGludCByZWcsCisJCQkgICAgdW5zaWduZWQg
Y2hhciBtYXNrLCB1bnNpZ25lZCBjaGFyIGRhdGEpCit7CisJc3RydWN0IG1heDg2NDlfcmVndWxh
dG9yX2luZm8gKmluZm8gPSBpMmNfZ2V0X2NsaWVudGRhdGEoaTJjKTsKKwl1bnNpZ25lZCBjaGFy
IHZhbHVlOworCWludCByZXQ7CisKKwltdXRleF9sb2NrKCZpbmZvLT5pb19sb2NrKTsKKwlyZXQg
PSBtYXg4NjQ5X3JlYWRfZGV2aWNlKGkyYywgcmVnLCAxLCAmdmFsdWUpOworCWlmIChyZXQgPCAw
KQorCQlnb3RvIG91dDsKKwl2YWx1ZSAmPSB+bWFzazsKKwl2YWx1ZSB8PSBkYXRhOworCXJldCA9
IG1heDg2NDlfd3JpdGVfZGV2aWNlKGkyYywgcmVnLCAxLCAmdmFsdWUpOworb3V0OgorCW11dGV4
X3VubG9jaygmaW5mby0+aW9fbG9jayk7CisJcmV0dXJuIHJldDsKK30KKworc3RhdGljIGlubGlu
ZSBpbnQgY2hlY2tfcmFuZ2UoaW50IG1pbl91ViwgaW50IG1heF91VikKK3sKKwlpZiAoKG1pbl91
ViA8IE1BWDg2NDlfRENEQ19WTUlOKSB8fCAobWF4X3VWID4gTUFYODY0OV9EQ0RDX1ZNQVgpCisJ
CXx8IChtaW5fdVYgPiBtYXhfdVYpKQorCQlyZXR1cm4gLUVJTlZBTDsKKwlyZXR1cm4gMDsKK30K
Kworc3RhdGljIGludCBtYXg4NjQ5X2xpc3Rfdm9sdGFnZShzdHJ1Y3QgcmVndWxhdG9yX2RldiAq
cmRldiwgdW5zaWduZWQgaW5kZXgpCit7CisJcmV0dXJuIE1BWDg2NDlfRENEQ19WTUlOICsgaW5k
ZXggKiBNQVg4NjQ5X0RDRENfU1RFUDsKK30KKworc3RhdGljIGludCBtYXg4NjQ5X2dldF92b2x0
YWdlKHN0cnVjdCByZWd1bGF0b3JfZGV2ICpyZGV2KQoreworCXN0cnVjdCBtYXg4NjQ5X3JlZ3Vs
YXRvcl9pbmZvICppbmZvID0gcmRldl9nZXRfZHJ2ZGF0YShyZGV2KTsKKwl1bnNpZ25lZCBjaGFy
IGRhdGE7CisJaW50IHJldDsKKworCXJldCA9IG1heDg2NDlfcmVnX3JlYWQoaW5mby0+aTJjLCBp
bmZvLT52b2xfcmVnKTsKKwlpZiAocmV0IDwgMCkKKwkJcmV0dXJuIHJldDsKKwlkYXRhID0gKHVu
c2lnbmVkIGNoYXIpcmV0ICYgTUFYODY0OV9WT0xfTUFTSzsKKwlyZXR1cm4gbWF4ODY0OV9saXN0
X3ZvbHRhZ2UocmRldiwgZGF0YSk7Cit9CisKK3N0YXRpYyBpbnQgbWF4ODY0OV9zZXRfdm9sdGFn
ZShzdHJ1Y3QgcmVndWxhdG9yX2RldiAqcmRldiwKKwkJCSAgICAgICBpbnQgbWluX3VWLCBpbnQg
bWF4X3VWKQoreworCXN0cnVjdCBtYXg4NjQ5X3JlZ3VsYXRvcl9pbmZvICppbmZvID0gcmRldl9n
ZXRfZHJ2ZGF0YShyZGV2KTsKKwl1bnNpZ25lZCBjaGFyIGRhdGEsIG1hc2s7CisKKwlpZiAoY2hl
Y2tfcmFuZ2UobWluX3VWLCBtYXhfdVYpKSB7CisJCWRldl9lcnIoaW5mby0+ZGV2LCAiaW52YWxp
ZCB2b2x0YWdlIHJhbmdlICglZCwgJWQpIHVWXG4iLAorCQkJbWluX3VWLCBtYXhfdVYpOworCQly
ZXR1cm4gLUVJTlZBTDsKKwl9CisJZGF0YT0gKG1pbl91ViAtIE1BWDg2NDlfRENEQ19WTUlOICsg
TUFYODY0OV9EQ0RDX1NURVAgLSAxKQorCQkvIE1BWDg2NDlfRENEQ19TVEVQOworCW1hc2sgPSBN
QVg4NjQ5X1ZPTF9NQVNLOworCisJcmV0dXJuIG1heDg2NDlfc2V0X2JpdHMoaW5mby0+aTJjLCBp
bmZvLT52b2xfcmVnLCBtYXNrLCBkYXRhKTsKK30KKworLyogRU5fUEQgbWVhbnMgcHVsbGRvd24g
b24gRU4gaW5wdXQgKi8KK3N0YXRpYyBpbnQgbWF4ODY0OV9lbmFibGUoc3RydWN0IHJlZ3VsYXRv
cl9kZXYgKnJkZXYpCit7CisJc3RydWN0IG1heDg2NDlfcmVndWxhdG9yX2luZm8gKmluZm8gPSBy
ZGV2X2dldF9kcnZkYXRhKHJkZXYpOworCXJldHVybiBtYXg4NjQ5X3NldF9iaXRzKGluZm8tPmky
YywgTUFYODY0OV9DT05UUk9MLCBNQVg4NjQ5X0VOX1BELCAwKTsKK30KKworLyoKKyAqIEFwcGxp
ZWQgaW50ZXJuYWwgcHVsbGRvd24gcmVzaXN0b3Igb24gRU4gaW5wdXQgcGluLgorICogSWYgcHVs
bGRvd24gRU4gcGluIG91dHNpZGUsIGl0IHdvdWxkIGJlIGJldHRlci4KKyAqLworc3RhdGljIGlu
dCBtYXg4NjQ5X2Rpc2FibGUoc3RydWN0IHJlZ3VsYXRvcl9kZXYgKnJkZXYpCit7CisJc3RydWN0
IG1heDg2NDlfcmVndWxhdG9yX2luZm8gKmluZm8gPSByZGV2X2dldF9kcnZkYXRhKHJkZXYpOwor
CXJldHVybiBtYXg4NjQ5X3NldF9iaXRzKGluZm8tPmkyYywgTUFYODY0OV9DT05UUk9MLCBNQVg4
NjQ5X0VOX1BELAorCQkJCU1BWDg2NDlfRU5fUEQpOworfQorCitzdGF0aWMgaW50IG1heDg2NDlf
aXNfZW5hYmxlZChzdHJ1Y3QgcmVndWxhdG9yX2RldiAqcmRldikKK3sKKwlzdHJ1Y3QgbWF4ODY0
OV9yZWd1bGF0b3JfaW5mbyAqaW5mbyA9IHJkZXZfZ2V0X2RydmRhdGEocmRldik7CisJaW50IHJl
dDsKKworCXJldCA9IG1heDg2NDlfcmVnX3JlYWQoaW5mby0+aTJjLCBNQVg4NjQ5X0NPTlRST0wp
OworCWlmIChyZXQgPCAwKQorCQlyZXR1cm4gcmV0OworCXJldHVybiAhKCh1bnNpZ25lZCBjaGFy
KXJldCAmIE1BWDg2NDlfRU5fUEQpOworfQorCitzdGF0aWMgc3RydWN0IHJlZ3VsYXRvcl9vcHMg
bWF4ODY0OV9kY2RjX29wcyA9IHsKKwkuc2V0X3ZvbHRhZ2UJPSBtYXg4NjQ5X3NldF92b2x0YWdl
LAorCS5nZXRfdm9sdGFnZQk9IG1heDg2NDlfZ2V0X3ZvbHRhZ2UsCisJLmxpc3Rfdm9sdGFnZQk9
IG1heDg2NDlfbGlzdF92b2x0YWdlLAorCS5lbmFibGUJCT0gbWF4ODY0OV9lbmFibGUsCisJLmRp
c2FibGUJPSBtYXg4NjQ5X2Rpc2FibGUsCisJLmlzX2VuYWJsZWQJPSBtYXg4NjQ5X2lzX2VuYWJs
ZWQsCisKK307CisKK3N0YXRpYyBzdHJ1Y3QgcmVndWxhdG9yX2Rlc2MgZGNkY19kZXNjID0gewor
CS5uYW1lCQk9ICJEQ0RDIiwKKwkub3BzCQk9ICZtYXg4NjQ5X2RjZGNfb3BzLAorCS50eXBlCQk9
IFJFR1VMQVRPUl9WT0xUQUdFLAorCS5uX3ZvbHRhZ2VzCT0gMSA8PCA3LAorCS5vd25lcgkJPSBU
SElTX01PRFVMRSwKK307CisKK3N0YXRpYyBpbnQgX19kZXZpbml0IG1heDg2NDlfcmVndWxhdG9y
X3Byb2JlKHN0cnVjdCBpMmNfY2xpZW50ICpjbGllbnQsCisJCQkJCSAgICAgY29uc3Qgc3RydWN0
IGkyY19kZXZpY2VfaWQgKmlkKQoreworCXN0cnVjdCBtYXg4NjQ5X3BsYXRmb3JtX2RhdGEgKnBk
YXRhID0gY2xpZW50LT5kZXYucGxhdGZvcm1fZGF0YTsKKwlzdHJ1Y3QgbWF4ODY0OV9yZWd1bGF0
b3JfaW5mbyAqaW5mbyA9IE5VTEw7CisJdW5zaWduZWQgY2hhciBkYXRhOworCWludCByZXQ7CisK
KwlpbmZvID0ga3phbGxvYyhzaXplb2Yoc3RydWN0IG1heDg2NDlfcmVndWxhdG9yX2luZm8pLCBH
RlBfS0VSTkVMKTsKKwlpZiAoIWluZm8pIHsKKwkJZGV2X2VycigmY2xpZW50LT5kZXYsICJObyBl
bm91Z2ggbWVtb3J5XG4iKTsKKwkJcmV0dXJuIC1FTk9NRU07CisJfQorCisJaW5mby0+aTJjID0g
Y2xpZW50OworCWluZm8tPmRldiA9ICZjbGllbnQtPmRldjsKKwltdXRleF9pbml0KCZpbmZvLT5p
b19sb2NrKTsKKwlpMmNfc2V0X2NsaWVudGRhdGEoY2xpZW50LCBpbmZvKTsKKworCWluZm8tPm1v
ZGUgPSBwZGF0YS0+bW9kZTsKKwlpbmZvLT52b2xfcmVnID0gKGluZm8tPm1vZGUgPT0gMCkgPyBN
QVg4NjQ5X01PREUwCisJCQk6ICgoaW5mby0+bW9kZSA9PSAxKSA/IE1BWDg2NDlfTU9ERTEKKwkJ
CTogKChpbmZvLT5tb2RlID09IDIpID8gTUFYODY0OV9NT0RFMgorCQkJOiBNQVg4NjQ5X01PREUz
KSk7CisKKwlyZXQgPSBtYXg4NjQ5X3JlZ19yZWFkKGluZm8tPmkyYywgTUFYODY0OV9DSElQX0lE
MSk7CisJaWYgKHJldCA8IDApIHsKKwkJZGV2X2VycihpbmZvLT5kZXYsICJGYWlsZWQgdG8gZGV0
ZWN0IElEIG9mIE1BWDg2NDk6JWRcbiIsCisJCQlyZXQpOworCQlnb3RvIG91dDsKKwl9CisJZGV2
X2luZm8oaW5mby0+ZGV2LCAiRGV0ZWN0ZWQgTUFYODY0OSAoSUQ6JXgpXG4iLCByZXQpOworCisJ
LyogZW5hYmxlIFZJRDAgJiBWSUQxICovCisJbWF4ODY0OV9zZXRfYml0cyhpbmZvLT5pMmMsIE1B
WDg2NDlfQ09OVFJPTCwgTUFYODY0OV9WSURfTUFTSywgMCk7CisKKwkvKiBlbmFibGUvZGlzYWJs
ZSBleHRlcm5hbCBjbG9jayBzeW5jaHJvbml6YXRpb24gKi8KKwlpbmZvLT5leHRjbGsgPSBwZGF0
YS0+ZXh0Y2xrOworCWRhdGEgPSAoaW5mby0+ZXh0Y2xrKSA/IE1BWDg2NDlfU1lOQ19FWFRDTEsg
OiAwOworCW1heDg2NDlfc2V0X2JpdHMoaW5mby0+aTJjLCBpbmZvLT52b2xfcmVnLCBNQVg4NjQ5
X1NZTkNfRVhUQ0xLLCBkYXRhKTsKKwlpZiAoaW5mby0+ZXh0Y2xrKSB7CisJCS8qIHNldCBleHRl
cm5hbCBjbG9jayBmcmVxdWVuY3kgKi8KKwkJaW5mby0+ZXh0Y2xrX2ZyZXEgPSBwZGF0YS0+ZXh0
Y2xrX2ZyZXE7CisJCW1heDg2NDlfc2V0X2JpdHMoaW5mby0+aTJjLCBNQVg4NjQ5X1NZTkMsIE1B
WDg2NDlfRVhUX01BU0ssCisJCQkJIGluZm8tPmV4dGNsa19mcmVxKTsKKwl9CisKKwkvKiBlbmFi
bGUvZGlzYWJsZSBhdXRvIGVudGVyIHBvd2VyIHNhdmUgbW9kZSAqLworCWluZm8tPnBvd2Vyc2F2
ZSA9IHBkYXRhLT5wb3dlcnNhdmU7CisJZGF0YSA9IChpbmZvLT5wb3dlcnNhdmUpID8gMCA6IE1B
WDg2NDlfUE9XRVJfU0FWRTsKKwltYXg4NjQ5X3NldF9iaXRzKGluZm8tPmkyYywgaW5mby0+dm9s
X3JlZywgTUFYODY0OV9QT1dFUl9TQVZFLCBkYXRhKTsKKworCWlmIChwZGF0YS0+cmFtcF90aW1p
bmcpIHsKKwkJaW5mby0+cmFtcF90aW1pbmcgPSBwZGF0YS0+cmFtcF90aW1pbmc7CisJCW1heDg2
NDlfc2V0X2JpdHMoaW5mby0+aTJjLCBNQVg4NjQ5X1JBTVAsIE1BWDg2NDlfUkFNUF9NQVNLLAor
CQkJCSBpbmZvLT5yYW1wX3RpbWluZyA8PCA1KTsKKwl9CisKKwlpbmZvLT5yYW1wX2Rvd24gPSBw
ZGF0YS0+cmFtcF9kb3duOworCWlmIChpbmZvLT5wb3dlcnNhdmUgJiYgaW5mby0+cmFtcF9kb3du
KSB7CisJCW1heDg2NDlfc2V0X2JpdHMoaW5mby0+aTJjLCBNQVg4NjQ5X1JBTVAsIE1BWDg2NDlf
UkFNUF9ET1dOLAorCQkJCSBNQVg4NjQ5X1JBTVBfRE9XTik7CisJfQorCisJaW5mby0+cmVndWxh
dG9yID0gcmVndWxhdG9yX3JlZ2lzdGVyKCZkY2RjX2Rlc2MsICZjbGllbnQtPmRldiwKKwkJCQkJ
ICAgICBwZGF0YS0+cmVndWxhdG9yLCBpbmZvKTsKKwlpZiAoSVNfRVJSKGluZm8tPnJlZ3VsYXRv
cikpIHsKKwkJZGV2X2VycihpbmZvLT5kZXYsICJmYWlsZWQgdG8gcmVnaXN0ZXIgcmVndWxhdG9y
ICVzXG4iLAorCQkJZGNkY19kZXNjLm5hbWUpOworCQlyZXQgPSBQVFJfRVJSKGluZm8tPnJlZ3Vs
YXRvcik7CisJCWdvdG8gb3V0OworCX0KKworCXByX2luZm8oIk1heDg2NDkgcmVndWxhdG9yIGRl
dmljZSBpcyBkZXRlY3RlZC5cbiIpOworCXJldHVybiAwOworb3V0OgorCWtmcmVlKGluZm8pOwor
CXJldHVybiByZXQ7Cit9CisKK3N0YXRpYyBpbnQgX19kZXZleGl0IG1heDg2NDlfcmVndWxhdG9y
X3JlbW92ZShzdHJ1Y3QgaTJjX2NsaWVudCAqY2xpZW50KQoreworCXN0cnVjdCBtYXg4NjQ5X3Jl
Z3VsYXRvcl9pbmZvICppbmZvID0gaTJjX2dldF9jbGllbnRkYXRhKGNsaWVudCk7CisKKwlpZiAo
aW5mbykgeworCQlpZiAoaW5mby0+cmVndWxhdG9yKQorCQkJcmVndWxhdG9yX3VucmVnaXN0ZXIo
aW5mby0+cmVndWxhdG9yKTsKKwkJa2ZyZWUoaW5mbyk7CisJfQorCWkyY19zZXRfY2xpZW50ZGF0
YShjbGllbnQsIE5VTEwpOworCisJcmV0dXJuIDA7Cit9CisKK3N0YXRpYyBjb25zdCBzdHJ1Y3Qg
aTJjX2RldmljZV9pZCBtYXg4NjQ5X2lkW10gPSB7CisJeyAibWF4ODY0OSIsIDAgfSwKKwl7IH0K
K307CitNT0RVTEVfREVWSUNFX1RBQkxFKGkyYywgbWF4ODY0OV9pZCk7CisKK3N0YXRpYyBzdHJ1
Y3QgaTJjX2RyaXZlciBtYXg4NjQ5X2RyaXZlciA9IHsKKwkucHJvYmUJCT0gbWF4ODY0OV9yZWd1
bGF0b3JfcHJvYmUsCisJLnJlbW92ZQkJPSBfX2RldmV4aXRfcChtYXg4NjQ5X3JlZ3VsYXRvcl9y
ZW1vdmUpLAorCS5kcml2ZXIJCT0geworCQkubmFtZQk9ICJtYXg4NjQ5IiwKKwl9LAorCS5pZF90
YWJsZQk9IG1heDg2NDlfaWQsCit9OworCitzdGF0aWMgaW50IF9faW5pdCBtYXg4NjQ5X2luaXQo
dm9pZCkKK3sKKwlyZXR1cm4gaTJjX2FkZF9kcml2ZXIoJm1heDg2NDlfZHJpdmVyKTsKK30KK3N1
YnN5c19pbml0Y2FsbChtYXg4NjQ5X2luaXQpOworCitzdGF0aWMgdm9pZCBfX2V4aXQgbWF4ODY0
OV9leGl0KHZvaWQpCit7CisJaTJjX2RlbF9kcml2ZXIoJm1heDg2NDlfZHJpdmVyKTsKK30KK21v
ZHVsZV9leGl0KG1heDg2NDlfZXhpdCk7CisKKy8qIE1vZHVsZSBpbmZvcm1hdGlvbiAqLworTU9E
VUxFX0RFU0NSSVBUSU9OKCJNQVhJTSA4NjQ5IHZvbHRhZ2UgcmVndWxhdG9yIGRyaXZlciIpOwor
TU9EVUxFX0FVVEhPUigiSGFvamlhbiBaaHVhbmcgPGhhb2ppYW4uemh1YW5nQG1hcnZlbGwuY29t
PiIpOworTU9EVUxFX0xJQ0VOU0UoIkdQTCIpOworCi0tIAoxLjUuNi41Cgo=
--00504502c13bdd7d2e047cf39ee8--
