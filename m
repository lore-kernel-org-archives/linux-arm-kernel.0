From: myungjoo.ham@samsung.com (MyungJoo Ham)
Date: Thu, 19 Aug 2010 16:05:15 +0900
Subject: [PATCH] MAX8952 PMIC Driver Initial Release
Message-ID: <1282201515-11385-1-git-send-email-myungjoo.ham@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MAX8952 PMIC is used to provide VDD_ARM for S5PC210/UNIVERSAL board. In
this initial release, users can set voltages for four DVS modes, RAMP
delay values, and SYNC frequency. Controlling FPWM/SYNC_MODE/Pull-Down/
Ramp Modes and reading CHIP_ID is not supported in this release.

If MAX8952's EN is not going to be changed by this driver, the user
should set gpio_en_writable as false. In S5PC210/UNIVERSL board,
controlling EN pin at MAX8952 driver can be dangerous because this gpio
pin is shared with another PMIC.

We assume that V_OUT is capable to provide every voltage from 770mV to
1.40V in 10mV steps although the data sheet has some ambiguity on it.

Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
---
 drivers/regulator/Kconfig         |    8 +
 drivers/regulator/Makefile        |    1 +
 drivers/regulator/max8952.c       |  374 +++++++++++++++++++++++++++++++++++++
 include/linux/regulator/max8952.h |  141 ++++++++++++++
 4 files changed, 524 insertions(+), 0 deletions(-)
 create mode 100644 drivers/regulator/max8952.c
 create mode 100644 include/linux/regulator/max8952.h

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 172951b..4889caa 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -100,6 +100,14 @@ config REGULATOR_MAX8925
 	help
 	  Say y here to support the voltage regulaltor of Maxim MAX8925 PMIC.
 
+config REGULATOR_MAX8952
+	tristate "Maxim MAX8952 Power Management IC"
+	depends on I2C
+	help
+	  This driver controls a Maxim 8952 voltage output regulator
+	  via I2C bus. Maxim 8952 has one voltage output and supports 4 DVS
+	  modes ranging from 0.77V to 1.40V by 0.01V steps.
+
 config REGULATOR_MAX8998
 	tristate "Maxim 8998 voltage regulator"
 	depends on MFD_MAX8998
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index 8285fd8..beff6da 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -17,6 +17,7 @@ obj-$(CONFIG_REGULATOR_TWL4030) += twl-regulator.o
 obj-$(CONFIG_REGULATOR_MAX8649)	+= max8649.o
 obj-$(CONFIG_REGULATOR_MAX8660) += max8660.o
 obj-$(CONFIG_REGULATOR_MAX8925) += max8925-regulator.o
+obj-$(CONFIG_REGULATOR_MAX8952) += max8952.o
 obj-$(CONFIG_REGULATOR_MAX8998) += max8998.o
 obj-$(CONFIG_REGULATOR_WM831X) += wm831x-dcdc.o
 obj-$(CONFIG_REGULATOR_WM831X) += wm831x-isink.o
diff --git a/drivers/regulator/max8952.c b/drivers/regulator/max8952.c
new file mode 100644
index 0000000..c7ad8c4
--- /dev/null
+++ b/drivers/regulator/max8952.c
@@ -0,0 +1,374 @@
+/*
+ * max8952.c - Voltage and current regulation for the Maxim 8952
+ *
+ * Copyright (C) 2010 Samsung Electronics
+ * MyungJoo Ham <myungjoo.ham@samsung.com>
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
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/i2c.h>
+#include <linux/err.h>
+#include <linux/platform_device.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/max8952.h>
+#include <linux/mutex.h>
+#include <linux/gpio.h>
+#include <linux/io.h>
+#include <linux/slab.h>
+
+/* Registers */
+enum {
+	MAX8952_REG_MODE0,
+	MAX8952_REG_MODE1,
+	MAX8952_REG_MODE2,
+	MAX8952_REG_MODE3,
+	MAX8952_REG_CONTROL,
+	MAX8952_REG_SYNC,
+	MAX8952_REG_RAMP,
+	MAX8952_REG_CHIP_ID1,
+	MAX8952_REG_CHIP_ID2,
+};
+
+struct max8952_data {
+	struct i2c_client	*client;
+	struct device		*dev;
+	struct mutex		mutex;
+	struct max8952_platform_data *pdata;
+	struct regulator_dev	*rdev;
+};
+
+static int max8952_i2c_read(struct i2c_client *client, u8 reg, u8 *dest)
+{
+	int ret;
+
+	ret = i2c_smbus_read_byte_data(client, reg);
+	if (ret < 0)
+		return -EIO;
+
+	ret &= 0xff;
+	*dest = ret;
+	return 0;
+}
+
+static int max8952_i2c_write(struct i2c_client *client, u8 reg, u8 value)
+{
+	int ret;
+
+	ret = i2c_smbus_write_byte_data(client, reg, value);
+	return ret;
+}
+
+static int max8952_read_reg(struct max8952_data *max8952, u8 reg)
+{
+	u8 value = 0;
+	int ret;
+
+	mutex_lock(&max8952->mutex);
+	ret = max8952_i2c_read(max8952->client, reg, &value);
+	mutex_unlock(&max8952->mutex);
+	if (!ret)
+		ret = value & 0xff;
+
+	return ret;
+}
+
+static int max8952_write_reg(struct max8952_data *max8952,
+		u8 reg, u8 value)
+{
+	int ret;
+
+	mutex_lock(&max8952->mutex);
+	ret = max8952_i2c_write(max8952->client, reg, value);
+	mutex_unlock(&max8952->mutex);
+
+	return ret;
+}
+
+static int max8952_voltage(struct max8952_data *max8952, u8 mode)
+{
+	return (max8952->pdata->dvs_mode[mode] * 10 + 770) * 1000;
+}
+
+static int max8952_list_voltage(struct regulator_dev *rdev,
+		unsigned int selector)
+{
+	struct max8952_data *max8952 = rdev_get_drvdata(rdev);
+
+	if (rdev_get_id(rdev) != 0)
+		return -EINVAL;
+
+	return max8952_voltage(max8952, selector);
+}
+
+static int max8952_is_enabled(struct regulator_dev *rdev)
+{
+	struct max8952_data *max8952 = rdev_get_drvdata(rdev);
+
+	if (gpio_is_valid(max8952->pdata->gpio_en))
+		return gpio_get_value(max8952->pdata->gpio_en);
+
+	return -ENXIO;
+}
+
+static int max8952_enable(struct regulator_dev *rdev)
+{
+	struct max8952_data *max8952 = rdev_get_drvdata(rdev);
+
+	if (max8952->pdata->gpio_en_writable) {
+		if (gpio_is_valid(max8952->pdata->gpio_en))
+			gpio_set_value(max8952->pdata->gpio_en, 1);
+		else
+			return -ENXIO;
+	} else
+		return -EPERM;
+
+	return 0;
+}
+
+static int max8952_disable(struct regulator_dev *rdev)
+{
+	struct max8952_data *max8952 = rdev_get_drvdata(rdev);
+
+	if (max8952->pdata->gpio_en_writable) {
+		if (gpio_is_valid(max8952->pdata->gpio_en))
+			gpio_set_value(max8952->pdata->gpio_en, 0);
+		else
+			return -ENXIO;
+	} else
+		return -EPERM;
+
+	return 0;
+}
+
+static int max8952_get_voltage(struct regulator_dev *rdev)
+{
+	struct max8952_data *max8952 = rdev_get_drvdata(rdev);
+	u8 vid = 0;
+
+	if (gpio_is_valid(max8952->pdata->gpio_vid0) &&
+			gpio_is_valid(max8952->pdata->gpio_vid1)) {
+		if (gpio_get_value(max8952->pdata->gpio_vid0))
+			vid += 1;
+		if (gpio_get_value(max8952->pdata->gpio_vid1))
+			vid += 2;
+	} else
+		return -ENXIO;
+
+	return max8952_voltage(max8952, vid);
+}
+
+static int max8952_set_voltage(struct regulator_dev *rdev,
+				int min_uV, int max_uV)
+{
+	struct max8952_data *max8952 = rdev_get_drvdata(rdev);
+	u8 vid = -1, i;
+
+	for (i = 0; i < MAX8952_NUM_DVS_MODE; i++) {
+		int volt = max8952_voltage(max8952, i);
+
+		/* Set the voltage as low as possible within the range */
+		if ((volt <= max_uV) && (volt >= min_uV))
+			if ((vid == -1) ||
+					(max8952_voltage(max8952, vid) > volt))
+				vid = i;
+	}
+
+	if ((vid >= 0) && (vid < MAX8952_NUM_DVS_MODE)) {
+		gpio_set_value(max8952->pdata->gpio_vid0, vid % 2);
+		gpio_set_value(max8952->pdata->gpio_vid1, (vid >> 1) % 2);
+	} else
+		return -EINVAL;
+
+	return 0;
+}
+
+static int max8952_do_nothing(struct regulator_dev *rdev)
+{
+	return 0;
+}
+
+static struct regulator_ops max8952_ops = {
+	.list_voltage		= max8952_list_voltage,
+	.is_enabled		= max8952_is_enabled,
+	.enable			= max8952_enable,
+	.disable		= max8952_disable,
+	.get_voltage		= max8952_get_voltage,
+	.set_voltage		= max8952_set_voltage,
+	.set_suspend_enable	= max8952_do_nothing,
+	.set_suspend_disable	= max8952_disable,
+};
+
+static struct regulator_desc regulator = {
+	.name		= "MAX8952_VOUT",
+	.id		= 0,
+	.n_voltages	= MAX8952_NUM_DVS_MODE,
+	.ops		= &max8952_ops,
+	.type		= REGULATOR_VOLTAGE,
+	.owner		= THIS_MODULE,
+};
+
+static int __devinit max8952_pmic_probe(struct i2c_client *client,
+		const struct i2c_device_id *i2c_id)
+{
+	struct i2c_adapter *adapter = to_i2c_adapter(client->dev.parent);
+	struct max8952_platform_data *pdata = client->dev.platform_data;
+	struct max8952_data *max8952;
+
+	int ret;
+
+	pr_info("MAX8952 Probing...\n");
+
+	if (!pdata) {
+		dev_err(&client->dev, "Require the platform data\n");
+		return -EINVAL;
+	}
+
+	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE))
+		return -EIO;
+
+	max8952 = kzalloc(sizeof(struct max8952_data), GFP_KERNEL);
+	if (!max8952)
+		return -ENOMEM;
+
+	if (pdata->gpio_en_writable == false) {
+		max8952_ops.enable = NULL;
+		max8952_ops.disable = NULL;
+		max8952_ops.set_suspend_disable = max8952_do_nothing;
+	}
+
+	max8952->client = client;
+	max8952->dev = &client->dev;
+	max8952->pdata = pdata;
+	mutex_init(&max8952->mutex);
+
+	max8952->rdev = regulator_register(&regulator, max8952->dev,
+			&pdata->reg_data, max8952);
+
+	ret = IS_ERR(max8952->rdev);
+	if (ret)
+		dev_err(max8952->dev, "regulator init failed\n");
+
+	if (gpio_is_valid(pdata->gpio_vid0) &&
+			gpio_is_valid(pdata->gpio_vid1) &&
+			gpio_is_valid(pdata->gpio_en)) {
+		ret = gpio_request(pdata->gpio_vid0, "MAX8952 VID0");
+		if (ret)
+			return ret;
+		gpio_direction_output(pdata->gpio_vid0,
+				(pdata->default_mode) % 2);
+
+		ret = gpio_request(pdata->gpio_vid1, "MAX8952 VID1");
+		if (ret)
+			goto out_vid1;
+		gpio_direction_output(pdata->gpio_vid1,
+				(pdata->default_mode >> 1) % 2);
+
+		ret = gpio_request(pdata->gpio_en, "MAX8952 EN");
+		if (ret)
+			goto out_en;
+
+		max8952_write_reg(max8952, MAX8952_REG_MODE0,
+				(max8952_read_reg(max8952,
+						  MAX8952_REG_MODE0) & 0xC0) |
+				(pdata->dvs_mode[0] & 0x3F));
+		max8952_write_reg(max8952, MAX8952_REG_MODE1,
+				(max8952_read_reg(max8952,
+						  MAX8952_REG_MODE1) & 0xC0) |
+				(pdata->dvs_mode[1] & 0x3F));
+		max8952_write_reg(max8952, MAX8952_REG_MODE2,
+				(max8952_read_reg(max8952,
+						  MAX8952_REG_MODE2) & 0xC0) |
+				(pdata->dvs_mode[2] & 0x3F));
+		max8952_write_reg(max8952, MAX8952_REG_MODE3,
+				(max8952_read_reg(max8952,
+						  MAX8952_REG_MODE3) & 0xC0) |
+				(pdata->dvs_mode[3] & 0x3F));
+	} else {
+		pr_err("MAX8952 Initilization Failed: Wrong GPIO setting.\n");
+		return -EINVAL;
+	}
+
+	max8952_write_reg(max8952, MAX8952_REG_SYNC,
+			(max8952_read_reg(max8952, MAX8952_REG_SYNC) & 0x3F) |
+			((pdata->sync_freq & 0x3) << 6));
+	max8952_write_reg(max8952, MAX8952_REG_RAMP,
+			(max8952_read_reg(max8952, MAX8952_REG_RAMP) & 0x1F) |
+			((pdata->ramp_speed & 0x7) << 5));
+
+	i2c_set_clientdata(client, max8952);
+	return 0;
+out_en:
+	gpio_free(pdata->gpio_vid1);
+out_vid1:
+	gpio_free(pdata->gpio_vid0);
+	return ret;
+}
+
+static int __devexit max8952_pmic_remove(struct i2c_client *client)
+{
+	struct max8952_data *max8952 = i2c_get_clientdata(client);
+	struct max8952_platform_data *pdata = max8952->pdata;
+	struct regulator_dev *rdev = max8952->rdev;
+
+	regulator_unregister(rdev);
+
+	gpio_free(pdata->gpio_vid0);
+	gpio_free(pdata->gpio_vid1);
+	gpio_free(pdata->gpio_en);
+
+	kfree(max8952);
+	i2c_set_clientdata(client, NULL);
+	return 0;
+}
+
+static const struct i2c_device_id max8952_ids[] = {
+	{ "max8952", 0 },
+	{ },
+};
+MODULE_DEVICE_TABLE(i2c, max8952_ids);
+
+static struct i2c_driver max8952_pmic_driver = {
+	.probe		= max8952_pmic_probe,
+	.remove		= __devexit_p(max8952_pmic_remove),
+	.driver		= {
+		.name	= "max8952",
+	},
+	.id_table	= max8952_ids,
+};
+
+static int __init max8952_pmic_init(void)
+{
+	return i2c_add_driver(&max8952_pmic_driver);
+}
+#ifdef CONFIG_REGULATOR_RESUME
+/* becasue alway_power_on, add this feature,
+ * To do this at bootloader is better */
+beforeresume_initcall(max8952_pmic_init);
+#else
+subsys_initcall(max8952_pmic_init);
+#endif
+
+static void __exit max8952_pmic_exit(void)
+{
+	i2c_del_driver(&max8952_pmic_driver);
+}
+module_exit(max8952_pmic_exit);
+
+MODULE_DESCRIPTION("MAXIM 8952 voltage regulator driver");
+MODULE_AUTHOR("MyungJoo Ham <myungjoo.ham@samsung.com>");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/regulator/max8952.h b/include/linux/regulator/max8952.h
new file mode 100644
index 0000000..34c898a
--- /dev/null
+++ b/include/linux/regulator/max8952.h
@@ -0,0 +1,141 @@
+/*
+ * max8952.h - Voltage regulation for the Maxim 8952
+ *
+ *  Copyright (C) 2010 Samsung Electrnoics
+ *  MyungJoo Ham <myungjoo.ham@samsung.com>
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
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#ifndef REGULATOR_MAX8952
+#define REGULATOR_MAX8952
+
+#include <linux/regulator/machine.h>
+
+enum {
+	MAX8952_DVS_MODE0,
+	MAX8952_DVS_MODE1,
+	MAX8952_DVS_MODE2,
+	MAX8952_DVS_MODE3,
+};
+
+enum {
+	MAX8952_DVS_770mV = 0,
+	MAX8952_DVS_780mV,
+	MAX8952_DVS_790mV,
+	MAX8952_DVS_800mV,
+	MAX8952_DVS_810mV,
+	MAX8952_DVS_820mV,
+	MAX8952_DVS_830mV,
+	MAX8952_DVS_840mV,
+	MAX8952_DVS_850mV,
+	MAX8952_DVS_860mV,
+	MAX8952_DVS_870mV,
+	MAX8952_DVS_880mV,
+	MAX8952_DVS_890mV,
+	MAX8952_DVS_900mV,
+	MAX8952_DVS_910mV,
+	MAX8952_DVS_920mV,
+	MAX8952_DVS_930mV,
+	MAX8952_DVS_940mV,
+	MAX8952_DVS_950mV,
+	MAX8952_DVS_960mV,
+	MAX8952_DVS_970mV,
+	MAX8952_DVS_980mV,
+	MAX8952_DVS_990mV,
+	MAX8952_DVS_1000mV,
+	MAX8952_DVS_1010mV,
+	MAX8952_DVS_1020mV,
+	MAX8952_DVS_1030mV,
+	MAX8952_DVS_1040mV,
+	MAX8952_DVS_1050mV,
+	MAX8952_DVS_1060mV,
+	MAX8952_DVS_1070mV,
+	MAX8952_DVS_1080mV,
+	MAX8952_DVS_1090mV,
+	MAX8952_DVS_1100mV,
+	MAX8952_DVS_1110mV,
+	MAX8952_DVS_1120mV,
+	MAX8952_DVS_1130mV,
+	MAX8952_DVS_1140mV,
+	MAX8952_DVS_1150mV,
+	MAX8952_DVS_1160mV,
+	MAX8952_DVS_1170mV,
+	MAX8952_DVS_1180mV,
+	MAX8952_DVS_1190mV,
+	MAX8952_DVS_1200mV,
+	MAX8952_DVS_1210mV,
+	MAX8952_DVS_1220mV,
+	MAX8952_DVS_1230mV,
+	MAX8952_DVS_1240mV,
+	MAX8952_DVS_1250mV,
+	MAX8952_DVS_1260mV,
+	MAX8952_DVS_1270mV,
+	MAX8952_DVS_1280mV,
+	MAX8952_DVS_1290mV,
+	MAX8952_DVS_1300mV,
+	MAX8952_DVS_1310mV,
+	MAX8952_DVS_1320mV,
+	MAX8952_DVS_1330mV,
+	MAX8952_DVS_1340mV,
+	MAX8952_DVS_1350mV,
+	MAX8952_DVS_1360mV,
+	MAX8952_DVS_1370mV,
+	MAX8952_DVS_1380mV,
+	MAX8952_DVS_1390mV,
+	MAX8952_DVS_1400mV,
+};
+
+enum {
+	MAX8952_SYNC_FREQ_26MHZ, /* Default */
+	MAX8952_SYNC_FREQ_13MHZ,
+	MAX8952_SYNC_FREQ_19_2MHZ,
+};
+
+enum {
+	MAX8952_RAMP_32mV_us = 0, /* Default */
+	MAX8952_RAMP_16mV_us,
+	MAX8952_RAMP_8mV_us,
+	MAX8952_RAMP_4mV_us,
+	MAX8952_RAMP_2mV_us,
+	MAX8952_RAMP_1mV_us,
+	MAX8952_RAMP_0_5mV_us,
+	MAX8952_RAMP_0_25mV_us,
+};
+
+#define MAX8952_NUM_DVS_MODE	4
+
+struct max8952_platform_data {
+	int gpio_vid0;
+	int gpio_vid1;
+	int gpio_en;
+
+	/*
+	 * In C210 Universal Board, EN is connected to PWR_EN, which can also
+	 * turn off the whole system. In such a case, disable en_writable.
+	 */
+	bool gpio_en_writable;
+
+	u8 default_mode;
+	u8 dvs_mode[MAX8952_NUM_DVS_MODE]; /* MAX8952_DVS_MODEx_XXXXmV */
+
+	u8 sync_freq;
+	u8 ramp_speed;
+
+	struct regulator_init_data reg_data;
+};
+
+
+#endif /* REGULATOR_MAX8952 */
-- 
1.6.3.3
