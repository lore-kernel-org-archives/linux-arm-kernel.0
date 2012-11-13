From: Frank.Li@freescale.com (Frank Li)
Date: Tue, 13 Nov 2012 16:54:04 +0800
Subject: [PATCH 2/2] hwmon: MMA8451: Add mma8451 3 axis digtial accelerometer
 driver
Message-ID: <1352796844-24216-1-git-send-email-Frank.Li@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sammy He <r62914@freescale.com>

Add mma8451 accelerometer driver.

Signed-off-by: Xinyu Chen <xinyu.chen@freescale.com>
Signed-off-by: Sammy He <r62914@freescale.com>
Signed-off-by: Frank Li <Frank.Li@freescale.com>
---
 drivers/hwmon/Kconfig   |    7 +
 drivers/hwmon/Makefile  |    1 +
 drivers/hwmon/mma8451.c |  426 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 434 insertions(+), 0 deletions(-)
 create mode 100644 drivers/hwmon/mma8451.c

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 4800d4c..1119a36 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -1432,6 +1432,13 @@ config SENSORS_MC13783_ADC
         help
           Support for the A/D converter on MC13783 and MC13892 PMIC.
 
+config SENSORS_MMA8451
+	tristate "Freescale MMA8451 device driver"
+	depends on I2C
+	help
+	  If you say yes here you get support for the freescale 3 axis
+	  accelerometer  MMA8451
+
 if ACPI
 
 comment "ACPI drivers"
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index a930f09..40e6b10 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -131,6 +131,7 @@ obj-$(CONFIG_SENSORS_W83L785TS)	+= w83l785ts.o
 obj-$(CONFIG_SENSORS_W83L786NG)	+= w83l786ng.o
 obj-$(CONFIG_SENSORS_WM831X)	+= wm831x-hwmon.o
 obj-$(CONFIG_SENSORS_WM8350)	+= wm8350-hwmon.o
+obj-$(CONFIG_SENSORS_MMA8451)	+= mma8451.o
 
 obj-$(CONFIG_PMBUS)		+= pmbus/
 
diff --git a/drivers/hwmon/mma8451.c b/drivers/hwmon/mma8451.c
new file mode 100644
index 0000000..9ed21be
--- /dev/null
+++ b/drivers/hwmon/mma8451.c
@@ -0,0 +1,426 @@
+/*
+ *  mma8451.c - Linux kernel modules for 3-Axis Orientation/Motion
+ *  Detection Sensor
+ *
+ *  Copyright (C) 2012 Freescale Semiconductor, Inc. All Rights Reserved.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/i2c.h>
+#include <linux/mutex.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/hwmon-sysfs.h>
+#include <linux/err.h>
+#include <linux/hwmon.h>
+#include <linux/input-polldev.h>
+#include <linux/regulator/consumer.h>
+
+/*
+ * Defines
+ */
+#define MMA8451_DRV_NAME	"mma8451"
+#define MMA8451_I2C_ADDR	0x1C
+#define MMA8451_ID		0x1A
+
+#define POLL_INTERVAL		100
+#define INPUT_FUZZ		32
+#define INPUT_FLAT		32
+#define MODE_CHANGE_DELAY_MS	100
+
+/* register enum for mma8451 registers */
+enum {
+	MMA8451_STATUS = 0x00,
+	MMA8451_OUT_X_MSB,
+	MMA8451_OUT_X_LSB,
+	MMA8451_OUT_Y_MSB,
+	MMA8451_OUT_Y_LSB,
+	MMA8451_OUT_Z_MSB,
+	MMA8451_OUT_Z_LSB,
+
+	MMA8451_F_SETUP = 0x09,
+	MMA8451_TRIG_CFG,
+	MMA8451_SYSMOD,
+	MMA8451_INT_SOURCE,
+	MMA8451_WHO_AM_I,
+	MMA8451_XYZ_DATA_CFG,
+	MMA8451_HP_FILTER_CUTOFF,
+
+	MMA8451_PL_STATUS,
+	MMA8451_PL_CFG,
+	MMA8451_PL_COUNT,
+	MMA8451_PL_BF_ZCOMP,
+	MMA8451_P_L_THS_REG,
+
+	MMA8451_FF_MT_CFG,
+	MMA8451_FF_MT_SRC,
+	MMA8451_FF_MT_THS,
+	MMA8451_FF_MT_COUNT,
+
+	MMA8451_TRANSIENT_CFG = 0x1D,
+	MMA8451_TRANSIENT_SRC,
+	MMA8451_TRANSIENT_THS,
+	MMA8451_TRANSIENT_COUNT,
+
+	MMA8451_PULSE_CFG,
+	MMA8451_PULSE_SRC,
+	MMA8451_PULSE_THSX,
+	MMA8451_PULSE_THSY,
+	MMA8451_PULSE_THSZ,
+	MMA8451_PULSE_TMLT,
+	MMA8451_PULSE_LTCY,
+	MMA8451_PULSE_WIND,
+
+	MMA8451_ASLP_COUNT,
+	MMA8451_CTRL_REG1,
+	MMA8451_CTRL_REG2,
+	MMA8451_CTRL_REG3,
+	MMA8451_CTRL_REG4,
+	MMA8451_CTRL_REG5,
+
+	MMA8451_OFF_X,
+	MMA8451_OFF_Y,
+	MMA8451_OFF_Z,
+
+	MMA8451_REG_END,
+};
+
+enum {
+	MODE_2G = 0,
+	MODE_4G,
+	MODE_8G,
+};
+
+/* mma8451 status */
+struct mma8451_status {
+	u8 mode;
+	u8 ctl_reg1;
+};
+
+static struct mma8451_status mma_status = {
+	.mode = 0,
+	.ctl_reg1 = 0
+};
+
+struct mma8451_data {
+	struct input_polled_dev *idev;
+	struct device *hwmon_dev;
+	struct i2c_client *i2c_client;
+	struct regulator *reg_vdd;
+	struct regulator *reg_vddio;
+};
+
+/***************************************************************
+ *
+ * Initialization function
+ *
+ **************************************************************/
+static int mma8451_init_client(struct i2c_client *client)
+{
+	int result;
+
+	mma_status.ctl_reg1 = 0x00;
+	result =
+	    i2c_smbus_write_byte_data(client, MMA8451_CTRL_REG1,
+				      mma_status.ctl_reg1);
+	mma_status.mode = MODE_2G;
+	result =
+	    i2c_smbus_write_byte_data(client, MMA8451_XYZ_DATA_CFG,
+				      mma_status.mode);
+	mma_status.ctl_reg1 |= 0x01;
+	result =
+	    i2c_smbus_write_byte_data(client, MMA8451_CTRL_REG1,
+				      mma_status.ctl_reg1);
+	mdelay(MODE_CHANGE_DELAY_MS);
+
+	return result;
+}
+
+/***************************************************************
+*
+* read sensor data from mma8451
+*
+***************************************************************/
+static int mma8451_read_data(struct i2c_client *client, short *x, short *y,
+			     short *z)
+{
+	u8 tmp_data[7];
+
+	if (i2c_smbus_read_i2c_block_data
+	    (client, MMA8451_OUT_X_MSB, 7, tmp_data) < 7) {
+		dev_err(&client->dev, "i2c block read failed\n");
+		return -3;
+	}
+
+	*x = ((tmp_data[0] << 8) & 0xff00) | tmp_data[1];
+	*y = ((tmp_data[2] << 8) & 0xff00) | tmp_data[3];
+	*z = ((tmp_data[4] << 8) & 0xff00) | tmp_data[5];
+
+	*x = (short)(*x) >> 2;
+	*y = (short)(*y) >> 2;
+	*z = (short)(*z) >> 2;
+
+	if (mma_status.mode == MODE_4G) {
+		(*x) = (*x) << 1;
+		(*y) = (*y) << 1;
+		(*z) = (*z) << 1;
+	} else if (mma_status.mode == MODE_8G) {
+		(*x) = (*x) << 2;
+		(*y) = (*y) << 2;
+		(*z) = (*z) << 2;
+	}
+
+	return 0;
+}
+
+static void report_abs(struct mma8451_data *data)
+{
+	short x, y, z;
+	int result;
+
+	do {
+		result =
+		    i2c_smbus_read_byte_data(data->i2c_client, MMA8451_STATUS);
+	} while (!(result & 0x08));	/* wait for new data */
+
+	if (mma8451_read_data(data->i2c_client, &x, &y, &z) != 0)
+		return;
+
+	input_report_abs(data->idev->input, ABS_X, x);
+	input_report_abs(data->idev->input, ABS_Y, y);
+	input_report_abs(data->idev->input, ABS_Z, z);
+	input_sync(data->idev->input);
+}
+
+static void mma8451_dev_poll(struct input_polled_dev *dev)
+{
+	struct mma8451_data *data = (struct mma8451_data *)dev->private;
+
+	report_abs(data);
+}
+
+static int __devinit mma8451_probe(struct i2c_client *client,
+				   const struct i2c_device_id *id)
+{
+	int result, ret;
+	struct i2c_adapter *adapter = to_i2c_adapter(client->dev.parent);
+	struct mma8451_data *data;
+	struct input_dev *idev;
+
+	data =
+	    devm_kzalloc(&client->dev, sizeof(struct mma8451_data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->reg_vdd = devm_regulator_get(&client->dev, "vdd");
+	if (!IS_ERR(data->reg_vdd)) {
+		ret = regulator_enable(data->reg_vdd);
+		if (ret) {
+			dev_err(&client->dev,
+				"Failed to enable phy regulator: %d\n", ret);
+			result = -EINVAL;
+			goto err_detach_client;
+		}
+	}
+
+	data->reg_vddio = devm_regulator_get(&client->dev, "vddio");
+	if (!IS_ERR(data->reg_vddio)) {
+		ret = regulator_enable(data->reg_vddio);
+		if (ret) {
+			dev_err(&client->dev,
+				"Failed to enable phy regulator: %d\n", ret);
+			result = -EINVAL;
+			goto err_detach_client;
+		}
+	}
+
+	i2c_set_clientdata(client, data);
+	data->i2c_client = client;
+	result = i2c_check_functionality(adapter,
+					 I2C_FUNC_SMBUS_BYTE |
+					 I2C_FUNC_SMBUS_BYTE_DATA);
+
+	pr_info("check mma8451 chip ID\n");
+	result = i2c_smbus_read_byte_data(client, MMA8451_WHO_AM_I);
+
+	if (MMA8451_ID != result) {
+		dev_err(&client->dev,
+			"read chip ID 0x%x is not equal to 0x%x!\n", result,
+			MMA8451_ID);
+		pr_info("read chip ID failed\n");
+		result = -EINVAL;
+		goto err_detach_client;
+	}
+
+	/* Initialize the MMA8451 chip */
+	result = mma8451_init_client(client);
+
+	data->hwmon_dev = hwmon_device_register(&client->dev);
+	if (IS_ERR(data->hwmon_dev)) {
+		pr_err("hwmon register fail\n");
+		result = -EINVAL;
+		goto err_detach_client;
+	}
+
+	dev_info(&client->dev, "build time %s %s\n", __DATE__, __TIME__);
+
+	/*input poll device register */
+	data->idev = input_allocate_polled_device();
+	if (IS_ERR(data->idev)) {
+		dev_err(&client->dev, "alloc poll device failed!\n");
+		result = -ENOMEM;
+		goto err_detach_client;
+	}
+	data->idev->poll = mma8451_dev_poll;
+	data->idev->poll_interval = POLL_INTERVAL;
+	data->idev->private = data;
+	idev = data->idev->input;
+	idev->name = MMA8451_DRV_NAME;
+	idev->id.bustype = BUS_I2C;
+	idev->dev.parent = &client->dev;
+	idev->evbit[0] = BIT_MASK(EV_ABS);
+
+	input_set_abs_params(idev, ABS_X, -8192, 8191, INPUT_FUZZ, INPUT_FLAT);
+	input_set_abs_params(idev, ABS_Y, -8192, 8191, INPUT_FUZZ, INPUT_FLAT);
+	input_set_abs_params(idev, ABS_Z, -8192, 8191, INPUT_FUZZ, INPUT_FLAT);
+	result = input_register_polled_device(data->idev);
+	if (result) {
+		dev_err(&client->dev, "register poll device failed!\n");
+		goto err_detach_client;
+	}
+	return result;
+
+err_detach_client:
+	if (!IS_ERR(data->hwmon_dev)) {
+		hwmon_device_unregister(data->hwmon_dev);
+		data->hwmon_dev = NULL;
+	}
+	if (!IS_ERR(data->idev)) {
+		input_unregister_polled_device(data->idev);
+		input_free_polled_device(data->idev);
+		data->idev = NULL;
+	}
+	if (!IS_ERR(data->reg_vdd))
+		regulator_disable(data->reg_vdd);
+	if (!IS_ERR(data->reg_vddio))
+		regulator_disable(data->reg_vddio);
+
+	return result;
+}
+
+static int __devexit mma8451_remove(struct i2c_client *client)
+{
+	int result;
+	struct mma8451_data *data = (struct mma8451_data *)
+	    i2c_get_clientdata(client);
+
+	mma_status.ctl_reg1 =
+	    i2c_smbus_read_byte_data(client, MMA8451_CTRL_REG1);
+	result =
+	    i2c_smbus_write_byte_data(client, MMA8451_CTRL_REG1,
+				      mma_status.ctl_reg1 & 0xFE);
+
+	hwmon_device_unregister(data->hwmon_dev);
+	if (!IS_ERR(data->idev)) {
+		input_unregister_polled_device(data->idev);
+		input_free_polled_device(data->idev);
+		data->idev = NULL;
+	}
+
+	if (!IS_ERR(data->reg_vdd))
+		regulator_disable(data->reg_vdd);
+	if (!IS_ERR(data->reg_vddio))
+		regulator_disable(data->reg_vddio);
+
+	return result;
+}
+
+static int mma8451_suspend(struct i2c_client *client, pm_message_t mesg)
+{
+	int result;
+	mma_status.ctl_reg1 =
+	    i2c_smbus_read_byte_data(client, MMA8451_CTRL_REG1);
+	result =
+	    i2c_smbus_write_byte_data(client, MMA8451_CTRL_REG1,
+				      mma_status.ctl_reg1 & 0xFE);
+	return result;
+}
+
+static int mma8451_resume(struct i2c_client *client)
+{
+	int result;
+	result =
+	    i2c_smbus_write_byte_data(client, MMA8451_CTRL_REG1,
+				      mma_status.ctl_reg1);
+	return result;
+}
+
+static const struct i2c_device_id mma8451_id[] = {
+	{MMA8451_DRV_NAME, 0},
+	{},
+};
+
+static const struct of_device_id mma_match[] = {
+	{.compatible = "fsl,mma8451",},
+	{ /* sentinel */ }
+};
+
+MODULE_DEVICE_TABLE(i2c, mma8451_id);
+
+static struct i2c_driver mma8451_driver = {
+	.driver = {
+		   .name = MMA8451_DRV_NAME,
+		   .owner = THIS_MODULE,
+		   .of_match_table = mma_match,
+		   },
+	.suspend = mma8451_suspend,
+	.resume = mma8451_resume,
+	.probe = mma8451_probe,
+	.remove = __devexit_p(mma8451_remove),
+	.id_table = mma8451_id,
+};
+
+static int __init mma8451_init(void)
+{
+	/* register driver */
+	int res;
+
+	res = i2c_add_driver(&mma8451_driver);
+	if (res < 0) {
+		pr_info("add mma8451 i2c driver failed\n");
+		return -ENODEV;
+	}
+	pr_info("add mma8451 i2c driver\n");
+
+	return res;
+}
+
+static void __exit mma8451_exit(void)
+{
+	pr_info("remove mma8451 i2c driver.\n");
+	i2c_del_driver(&mma8451_driver);
+}
+
+MODULE_AUTHOR("Freescale Semiconductor, Inc.");
+MODULE_DESCRIPTION("MMA8451 3-Axis Orientation/Motion Detection Sensor driver");
+MODULE_LICENSE("GPL");
+
+module_init(mma8451_init);
+module_exit(mma8451_exit);
-- 
1.7.1
