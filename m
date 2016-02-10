From: linux@baker-net.org.uk (Adam Baker)
Date: Wed, 10 Feb 2016 23:33:43 +0000
Subject: [PATCH 2/3] ARM: mvebu: Create a NSA3xx hardware monitoring driver
In-Reply-To: <1455147224-6742-1-git-send-email-linux@baker-net.org.uk>
References: <1455147224-6742-1-git-send-email-linux@baker-net.org.uk>
Message-ID: <1455147224-6742-3-git-send-email-linux@baker-net.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Create a driver to support the hardware monitoring chip present in
several models of Zyxel NSA3xx NAS devices.

The driver reads fan speed and temperature from a suitably programmed
MCU on the device.

Signed-off-by: Adam Baker <linux@baker-net.org.uk>
---
I've tested this on an NSA-320, I've had someone offer to test it on
NSA-325 so hopefully I will get a tested by back.
---
 drivers/hwmon/Kconfig        |  13 +++
 drivers/hwmon/Makefile       |   1 +
 drivers/hwmon/nsa3xx-hwmon.c | 223 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 237 insertions(+)
 create mode 100644 drivers/hwmon/nsa3xx-hwmon.c

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 80a73bf..8801b78 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -1757,6 +1757,19 @@ config SENSORS_ULTRA45
 	  This driver provides support for the Ultra45 workstation environmental
 	  sensors.
 
+config SENSORS_NSA3XX
+	tristate "ZyXEL NSA3xx fan speed and temperature sensors"
+	depends on GPIOLIB && OF
+	help
+	  If you say yes here you get support for hardware monitoring
+	  for the ZyXEL NSA3XX Media Servers.
+
+	  The sensor data is taken from a Holtek HT46R065 microcontroller
+	  connected to GPIO lines.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called nsa3xx-hwmon.
+
 if ACPI
 
 comment "ACPI drivers"
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index 12a3239..e85414a 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -118,6 +118,7 @@ obj-$(CONFIG_SENSORS_MAX6650)	+= max6650.o
 obj-$(CONFIG_SENSORS_MAX6697)	+= max6697.o
 obj-$(CONFIG_SENSORS_MAX31790)	+= max31790.o
 obj-$(CONFIG_SENSORS_MC13783_ADC)+= mc13783-adc.o
+obj-$(CONFIG_SENSORS_NSA3XX)	+= nsa3xx-hwmon.o
 obj-$(CONFIG_SENSORS_MCP3021)	+= mcp3021.o
 obj-$(CONFIG_SENSORS_MENF21BMC_HWMON) += menf21bmc_hwmon.o
 obj-$(CONFIG_SENSORS_NCT6683)	+= nct6683.o
diff --git a/drivers/hwmon/nsa3xx-hwmon.c b/drivers/hwmon/nsa3xx-hwmon.c
new file mode 100644
index 0000000..0fbf118
--- /dev/null
+++ b/drivers/hwmon/nsa3xx-hwmon.c
@@ -0,0 +1,223 @@
+/*
+ * drivers/hwmon/nsa3xx-hwmon.c
+ *
+ * ZyXEL NSA3xx Media Servers
+ * hardware monitoring
+ *
+ * Copyright (C) 2016 Adam Baker <linux@baker-net.org.uk>
+ * based on a board file driver
+ * Copyright (C) 2012 Peter Schildmann <linux@schildmann.info>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License v2 as published by the
+ * Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ */
+
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/platform_device.h>
+#include <linux/err.h>
+#include <linux/gpio/consumer.h>
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
+#include <linux/jiffies.h>
+#include <linux/delay.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/of_platform.h>
+
+#define MAGIC_NUMBER 0x55
+
+/*
+ * The Zyxel hwmon MCU is a Holtek HT46R065 that is factory programmed
+ * to perform temperature and fan speed monitoring. It is read by taking
+ * the active pin low. The 32 bit output word is then clocked onto the
+ * data line. The MSB of the data word is a magic nuber to indicate it
+ * has been read correctly, the next byte is the fan speed (in hundreds
+ * of RPM) and the last two bytes are the temperature (in tenths of a
+ * degree)
+ */
+
+struct nsa3xx_hwmon {
+	struct device		*classdev;
+	struct mutex		update_lock;	/* lock GPIO operations */
+	unsigned long		last_updated;	/* jiffies */
+	u32			mcu_data;
+	struct gpio_desc	*act;
+	struct gpio_desc	*clk;
+	struct gpio_desc	*data;
+};
+
+enum nsa3xx_inputs {
+	NSA3XX_FAN = 1,
+	NSA3XX_TEMP = 0,
+};
+
+static const char * const nsa3xx_input_names[] = {
+	[NSA3XX_FAN] = "Chassis Fan",
+	[NSA3XX_TEMP] = "System Temperature",
+};
+
+/* Although this protocol looks similar to SPI the long delay
+ * between the active (aka chip select) signal and the shorter
+ * delay between clock pulses are needed for reliable operation.
+ * The delays provided are taken from the manufacturer kernel,
+ * testing suggest they probably incorporate a reasonable safety
+ * margin. (The single device tested became unreliable if the
+ * delay was reduced to 1/10th of this value.)
+ */
+static unsigned long nsa3xx_hwmon_update(struct device *dev)
+{
+	u32 mcu_data;
+	u32 mask;
+	struct nsa3xx_hwmon *hwmon = dev_get_drvdata(dev);
+
+	mutex_lock(&hwmon->update_lock);
+
+	mcu_data = hwmon->mcu_data;
+
+	if (time_after(jiffies, hwmon->last_updated + HZ) ||
+							mcu_data == 0) {
+
+		gpiod_set_value(hwmon->act, 1);
+		msleep(100);
+
+		for (mask = BIT(31); mask; mask >>= 1) {
+			gpiod_set_value(hwmon->clk, 0);
+			usleep_range(100, 200);
+			gpiod_set_value(hwmon->clk, 1);
+			usleep_range(100, 200);
+			if (gpiod_get_value(hwmon->data))
+				mcu_data |= mask;
+		}
+
+		gpiod_set_value(hwmon->act, 0);
+		dev_dbg(dev, "Read raw MCU data %08x\n", mcu_data);
+
+		if ((mcu_data >> 24) != MAGIC_NUMBER) {
+			dev_err(dev, "Read invalid MCU data %08x\n", mcu_data);
+			mcu_data = 0;
+		}
+
+		hwmon->mcu_data = mcu_data;
+		hwmon->last_updated = jiffies;
+	}
+
+	mutex_unlock(&hwmon->update_lock);
+
+	return mcu_data;
+}
+
+static ssize_t show_label(struct device *dev,
+			  struct device_attribute *attr, char *buf)
+{
+	int channel = to_sensor_dev_attr(attr)->index;
+
+	return sprintf(buf, "%s\n", nsa3xx_input_names[channel]);
+}
+
+static ssize_t show_value(struct device *dev,
+			  struct device_attribute *attr, char *buf)
+{
+	int channel = to_sensor_dev_attr(attr)->index;
+	unsigned long mcu_data = nsa3xx_hwmon_update(dev);
+	unsigned long value = 0;
+
+	pr_debug("channel value 0x%02x!\n", channel);
+	switch (channel) {
+	case NSA3XX_TEMP:
+		value = (mcu_data & 0xffff) * 100;
+		break;
+	case NSA3XX_FAN:
+		value = ((mcu_data & 0xff0000) >> 16) * 100;
+		break;
+	}
+	return sprintf(buf, "%lu\n", value);
+}
+
+static SENSOR_DEVICE_ATTR(temp1_label, S_IRUGO, show_label, NULL, NSA3XX_TEMP);
+static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_value, NULL, NSA3XX_TEMP);
+static SENSOR_DEVICE_ATTR(fan1_label, S_IRUGO, show_label, NULL, NSA3XX_FAN);
+static SENSOR_DEVICE_ATTR(fan1_input, S_IRUGO, show_value, NULL, NSA3XX_FAN);
+
+static struct attribute *nsa3xx_attrs[] = {
+	&sensor_dev_attr_temp1_label.dev_attr.attr,
+	&sensor_dev_attr_temp1_input.dev_attr.attr,
+	&sensor_dev_attr_fan1_label.dev_attr.attr,
+	&sensor_dev_attr_fan1_input.dev_attr.attr,
+	NULL
+};
+
+ATTRIBUTE_GROUPS(nsa3xx);
+
+static const struct of_device_id of_nsa3xx_hwmon_match[] = {
+	{ .compatible = "zyxel,nsa320-mcu", },
+	{ },
+};
+
+static int nsa3xx_hwmon_probe(struct platform_device *pdev)
+{
+	struct nsa3xx_hwmon *hwmon;
+
+	hwmon = devm_kzalloc(&pdev->dev, sizeof(*hwmon), GFP_KERNEL);
+	if (!hwmon)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, hwmon);
+
+	/* Look up the GPIO pins to use */
+	hwmon->act = devm_gpiod_get(&pdev->dev, "act", GPIOD_OUT_LOW);
+	hwmon->clk = devm_gpiod_get(&pdev->dev, "clk", GPIOD_OUT_HIGH);
+	hwmon->data = devm_gpiod_get(&pdev->dev, "data", GPIOD_IN);
+
+	if (IS_ERR(hwmon->act))
+		return PTR_ERR(hwmon->act);
+	if (IS_ERR(hwmon->clk))
+		return PTR_ERR(hwmon->clk);
+	if (IS_ERR(hwmon->data))
+		return PTR_ERR(hwmon->data);
+
+	mutex_init(&hwmon->update_lock);
+
+	hwmon->classdev = devm_hwmon_device_register_with_groups(&pdev->dev,
+					"nsa3xx", hwmon, nsa3xx_groups);
+	if (IS_ERR(hwmon->classdev))
+		return PTR_ERR(hwmon->classdev);
+
+	dev_dbg(&pdev->dev, "initialized\n");
+
+	return 0;
+}
+
+static int nsa3xx_hwmon_remove(struct platform_device *pdev)
+{
+	/* All resources are allocated with devm_*() so
+	 * there is nothing to do here.
+	 */
+
+	return 0;
+}
+
+static struct platform_driver nsa3xx_hwmon_driver = {
+	.probe = nsa3xx_hwmon_probe,
+	.remove = nsa3xx_hwmon_remove,
+	.driver = {
+		.name = "nsa3xx-hwmon",
+		.owner = THIS_MODULE,
+		.of_match_table = of_match_ptr(of_nsa3xx_hwmon_match),
+	},
+};
+
+module_platform_driver(nsa3xx_hwmon_driver);
+
+MODULE_DEVICE_TABLE(of, of_nsa3xx_hwmon_match);
+MODULE_AUTHOR("Peter Schildmann <linux@schildmann.info>");
+MODULE_AUTHOR("Adam Baker <linux@baker-net.org.uk>");
+MODULE_DESCRIPTION("NSA3XX Hardware Monitoring");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:nsa3xx-hwmon");
-- 
2.1.4
