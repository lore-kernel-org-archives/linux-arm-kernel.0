From: sudeep.holla@arm.com (Sudeep Holla)
Date: Thu, 28 Sep 2017 14:11:44 +0100
Subject: [PATCH v3 20/22] hwmon: add support for sensors exported via ARM SCMI
In-Reply-To: <1506604306-20739-1-git-send-email-sudeep.holla@arm.com>
References: <1506604306-20739-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <1506604306-20739-21-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Create a driver to add support for SoC sensors exported by the System
Control Processor (SCP) via the System Control and Management Interface
(SCMI). The supported sensor types is one of voltage, temperature,
current, and power.

The sensor labels and values provided by the SCP are exported via the
hwmon sysfs interface.

Cc: Guenter Roeck <linux@roeck-us.net>
Cc: linux-hwmon at vger.kernel.org
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/hwmon/Kconfig      |  12 +++
 drivers/hwmon/Makefile     |   1 +
 drivers/hwmon/scmi-hwmon.c | 235 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 248 insertions(+)
 create mode 100644 drivers/hwmon/scmi-hwmon.c

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index d65431417b17..0b75e9a89463 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -321,6 +321,18 @@ config SENSORS_APPLESMC
 	  Say Y here if you have an applicable laptop and want to experience
 	  the awesome power of applesmc.
 
+config SENSORS_ARM_SCMI
+	tristate "ARM SCMI Sensors"
+	depends on ARM_SCMI_PROTOCOL
+	depends on THERMAL || !THERMAL_OF
+	help
+	  This driver provides support for temperature, voltage, current
+	  and power sensors available on SCMI based platforms. The actual
+	  number and type of sensors exported depend on the platform.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called scmi-hwmon.
+
 config SENSORS_ARM_SCPI
 	tristate "ARM SCPI Sensors"
 	depends on ARM_SCPI_PROTOCOL
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index c84d9784be98..a51c2dcef11c 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -44,6 +44,7 @@ obj-$(CONFIG_SENSORS_ADT7462)	+= adt7462.o
 obj-$(CONFIG_SENSORS_ADT7470)	+= adt7470.o
 obj-$(CONFIG_SENSORS_ADT7475)	+= adt7475.o
 obj-$(CONFIG_SENSORS_APPLESMC)	+= applesmc.o
+obj-$(CONFIG_SENSORS_ARM_SCMI)	+= scmi-hwmon.o
 obj-$(CONFIG_SENSORS_ARM_SCPI)	+= scpi-hwmon.o
 obj-$(CONFIG_SENSORS_ASC7621)	+= asc7621.o
 obj-$(CONFIG_SENSORS_ASPEED)	+= aspeed-pwm-tacho.o
diff --git a/drivers/hwmon/scmi-hwmon.c b/drivers/hwmon/scmi-hwmon.c
new file mode 100644
index 000000000000..0a8c0e8dc5d1
--- /dev/null
+++ b/drivers/hwmon/scmi-hwmon.c
@@ -0,0 +1,235 @@
+/*
+ * System Control and Management Interface(SCMI) based hwmon sensor driver
+ *
+ * Copyright (C) 2017 ARM Ltd.
+ * Sudeep Holla <sudeep.holla@arm.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/hwmon.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/scmi_protocol.h>
+#include <linux/slab.h>
+#include <linux/sysfs.h>
+#include <linux/thermal.h>
+
+struct scmi_sensors {
+	const struct scmi_handle *handle;
+	const struct scmi_sensor_info **info[hwmon_max];
+};
+
+static int scmi_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
+			   u32 attr, int channel, long *val)
+{
+	int ret;
+	u64 value;
+	const struct scmi_sensor_info *sensor;
+	struct scmi_sensors *scmi_sensors = dev_get_drvdata(dev);
+	const struct scmi_handle *h = scmi_sensors->handle;
+
+	sensor = *(scmi_sensors->info[type] + channel);
+	ret = h->sensor_ops->reading_get(h, sensor->id, false, &value);
+	if (!ret)
+		*val = value;
+
+	return ret;
+}
+
+static int
+scmi_hwmon_read_string(struct device *dev, enum hwmon_sensor_types type,
+		       u32 attr, int channel, const char **str)
+{
+	const struct scmi_sensor_info *sensor;
+	struct scmi_sensors *scmi_sensors = dev_get_drvdata(dev);
+
+	sensor = *(scmi_sensors->info[type] + channel);
+	*str = sensor->name;
+
+	return 0;
+}
+
+static umode_t
+scmi_hwmon_is_visible(const void *drvdata, enum hwmon_sensor_types type,
+		      u32 attr, int channel)
+{
+	const struct scmi_sensor_info *sensor;
+	const struct scmi_sensors *scmi_sensors = drvdata;
+
+	sensor = *(scmi_sensors->info[type] + channel);
+	if (sensor && sensor->name)
+		return S_IRUGO;
+
+	return 0;
+}
+
+static const struct hwmon_ops scmi_hwmon_ops = {
+	.is_visible = scmi_hwmon_is_visible,
+	.read = scmi_hwmon_read,
+	.read_string = scmi_hwmon_read_string,
+};
+
+static struct hwmon_chip_info scmi_chip_info = {
+	.ops = &scmi_hwmon_ops,
+	.info = NULL,
+};
+
+static int scmi_hwmon_add_chan_info(struct hwmon_channel_info *scmi_hwmon_chan,
+				    struct device *dev, int num,
+				    enum hwmon_sensor_types type, u32 config)
+{
+	int i;
+	u32 *cfg = devm_kcalloc(dev, num + 1, sizeof(*cfg), GFP_KERNEL);
+
+	if (!cfg)
+		return -ENOMEM;
+
+	scmi_hwmon_chan->type = type;
+	scmi_hwmon_chan->config = cfg;
+	for (i = 0; i < num; i++, cfg++)
+		*cfg = config;
+
+	return 0;
+}
+
+static enum hwmon_sensor_types scmi_types[] = {
+	[TEMPERATURE_C] = hwmon_temp,
+	[VOLTAGE] = hwmon_in,
+	[CURRENT] = hwmon_curr,
+	[POWER] = hwmon_power,
+	[ENERGY] = hwmon_energy,
+};
+
+static u32 hwmon_attributes[] = {
+	[hwmon_chip] = HWMON_C_REGISTER_TZ,
+	[hwmon_temp] = HWMON_T_INPUT | HWMON_T_LABEL,
+	[hwmon_in] = HWMON_I_INPUT | HWMON_I_LABEL,
+	[hwmon_curr] = HWMON_C_INPUT | HWMON_C_LABEL,
+	[hwmon_power] = HWMON_P_INPUT | HWMON_P_LABEL,
+	[hwmon_energy] = HWMON_E_INPUT | HWMON_E_LABEL,
+};
+
+static int scmi_hwmon_probe(struct platform_device *pdev)
+{
+	int i, idx;
+	u16 nr_sensors;
+	enum hwmon_sensor_types type;
+	struct scmi_sensors *scmi_sensors;
+	const struct scmi_sensor_info *sensor;
+	int nr_count[hwmon_max] = {0}, nr_types = 0;
+	const struct hwmon_chip_info *chip_info;
+	struct device *hwdev, *dev = &pdev->dev;
+	struct hwmon_channel_info *scmi_hwmon_chan;
+	const struct hwmon_channel_info **ptr_scmi_ci;
+	const struct scmi_handle *handle = devm_scmi_handle_get(dev);
+
+	if (IS_ERR_OR_NULL(handle) || !handle->sensor_ops)
+		return -EPROBE_DEFER;
+
+	nr_sensors = handle->sensor_ops->count_get(handle);
+	if (!nr_sensors)
+		return -EIO;
+
+	scmi_sensors = devm_kzalloc(dev, sizeof(*scmi_sensors), GFP_KERNEL);
+	if (!scmi_sensors)
+		return -ENOMEM;
+
+	scmi_sensors->handle = handle;
+
+	for (i = 0; i < nr_sensors; i++) {
+		sensor = handle->sensor_ops->info_get(handle, i);
+		if (!sensor)
+			return PTR_ERR(sensor);
+
+		switch (sensor->type) {
+		case TEMPERATURE_C:
+		case VOLTAGE:
+		case CURRENT:
+		case POWER:
+		case ENERGY:
+			type = scmi_types[sensor->type];
+			if (!nr_count[type])
+				nr_types++;
+			nr_count[type]++;
+			break;
+		}
+	}
+
+	if (nr_count[hwmon_temp])
+		nr_count[hwmon_chip]++, nr_types++;
+
+	scmi_hwmon_chan = devm_kcalloc(dev, nr_types, sizeof(*scmi_hwmon_chan),
+				       GFP_KERNEL);
+	if (!scmi_hwmon_chan)
+		return -ENOMEM;
+
+	ptr_scmi_ci = devm_kcalloc(dev, nr_types + 1, sizeof(*ptr_scmi_ci),
+				   GFP_KERNEL);
+	if (!ptr_scmi_ci)
+		return -ENOMEM;
+
+	scmi_chip_info.info = ptr_scmi_ci;
+	chip_info = &scmi_chip_info;
+
+	for (type = 0; type < hwmon_max && nr_count[type]; type++) {
+		scmi_hwmon_add_chan_info(scmi_hwmon_chan, dev, nr_count[type],
+					 type, hwmon_attributes[type]);
+		*ptr_scmi_ci++ = scmi_hwmon_chan++;
+
+		scmi_sensors->info[type] =
+			devm_kcalloc(dev, nr_count[type],
+				     sizeof(*scmi_sensors->info), GFP_KERNEL);
+		if (!scmi_sensors->info[type])
+			return -ENOMEM;
+	}
+
+	*ptr_scmi_ci = NULL;
+	platform_set_drvdata(pdev, scmi_sensors);
+
+	for (i = nr_sensors - 1; i >= 0 ; i--) {
+		sensor = handle->sensor_ops->info_get(handle, i);
+		if (!sensor)
+			continue;
+
+		switch (sensor->type) {
+		case TEMPERATURE_C:
+		case VOLTAGE:
+		case CURRENT:
+		case POWER:
+		case ENERGY:
+			type = scmi_types[sensor->type];
+			idx = --nr_count[type];
+			*(scmi_sensors->info[type] + idx) = sensor;
+			break;
+		}
+	}
+
+	hwdev = devm_hwmon_device_register_with_info(dev, "scmi_sensors",
+						     scmi_sensors, chip_info,
+						     NULL);
+
+	if (IS_ERR(hwdev))
+		return PTR_ERR(hwdev);
+
+	return 0;
+}
+
+static struct platform_driver scmi_hwmon_platdrv = {
+	.driver = {
+		.name	= "scmi-hwmon",
+	},
+	.probe		= scmi_hwmon_probe,
+};
+module_platform_driver(scmi_hwmon_platdrv);
+
+MODULE_AUTHOR("Sudeep Holla <sudeep.holla@arm.com>");
+MODULE_DESCRIPTION("ARM SCMI HWMON interface driver");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4
