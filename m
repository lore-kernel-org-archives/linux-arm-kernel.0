From: sudeep.holla@arm.com (Sudeep Holla)
Date: Fri,  4 Aug 2017 15:31:42 +0100
Subject: [PATCH v2 16/18] hwmon: add support for sensors exported via ARM SCMI
In-Reply-To: <1501857104-11279-1-git-send-email-sudeep.holla@arm.com>
References: <1501857104-11279-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <1501857104-11279-17-git-send-email-sudeep.holla@arm.com>
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
 drivers/hwmon/scmi-hwmon.c | 261 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 274 insertions(+)
 create mode 100644 drivers/hwmon/scmi-hwmon.c

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 5ef2814345ef..2bb63af8d674 100644
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
index d4641a9f16c1..02c3783c319f 100644
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
index 000000000000..f38c9708d99c
--- /dev/null
+++ b/drivers/hwmon/scmi-hwmon.c
@@ -0,0 +1,261 @@
+/*
+ * System Control and Management Interface(SCMI) based hwmon sensor driver
+ *
+ * Copyright (C) 2017 ARM Ltd.
+ * Punit Agrawal <punit.agrawal@arm.com>
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
+struct sensor_data {
+	const struct scmi_sensor_info *info;
+	struct device_attribute dev_attr_input;
+	struct device_attribute dev_attr_label;
+	char input[20];
+	char label[20];
+};
+
+struct scmi_thermal_zone {
+	int sensor_id;
+	struct scmi_sensors *scmi_sensors;
+};
+
+struct scmi_sensors {
+	const struct scmi_handle *handle;
+	struct sensor_data *data;
+	struct list_head thermal_zones;
+	struct attribute **attrs;
+	struct attribute_group group;
+	const struct attribute_group *groups[2];
+};
+
+static int scmi_read_temp(void *dev, int *temp)
+{
+	struct scmi_thermal_zone *zone = dev;
+	struct scmi_sensors *scmi_sensors = zone->scmi_sensors;
+	const struct scmi_handle *handle = scmi_sensors->handle;
+	struct sensor_data *sensor = &scmi_sensors->data[zone->sensor_id];
+	u64 value;
+	int ret;
+
+	ret = handle->sensor_ops->reading_get(handle, sensor->info->id,
+					      false, &value);
+	if (ret)
+		return ret;
+
+	*temp = value;
+	return 0;
+}
+
+/* hwmon callback functions */
+static ssize_t
+scmi_show_sensor(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct scmi_sensors *scmi_sensors = dev_get_drvdata(dev);
+	const struct scmi_handle *handle = scmi_sensors->handle;
+	struct sensor_data *sensor;
+	u64 value;
+	int ret;
+
+	sensor = container_of(attr, struct sensor_data, dev_attr_input);
+
+	ret = handle->sensor_ops->reading_get(handle, sensor->info->id,
+					      false, &value);
+	if (ret)
+		return ret;
+
+	return sprintf(buf, "%llu\n", value);
+}
+
+static ssize_t
+scmi_show_label(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct sensor_data *sensor;
+
+	sensor = container_of(attr, struct sensor_data, dev_attr_label);
+
+	return sprintf(buf, "%s\n", sensor->info->name);
+}
+
+static struct thermal_zone_of_device_ops scmi_sensor_ops = {
+	.get_temp = scmi_read_temp,
+};
+
+static int scmi_hwmon_probe(struct platform_device *pdev)
+{
+	int idx;
+	u16 nr_sensors, i;
+	int num_temp = 0, num_volt = 0, num_current = 0, num_power = 0;
+	int num_energy = 0;
+	struct device *hwdev, *dev = &pdev->dev;
+	struct scmi_sensors *scmi_sensors;
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
+	scmi_sensors->data = devm_kcalloc(dev, nr_sensors,
+					  sizeof(*scmi_sensors->data),
+					  GFP_KERNEL);
+	if (!scmi_sensors->data)
+		return -ENOMEM;
+
+	scmi_sensors->attrs = devm_kcalloc(dev, (nr_sensors * 2) + 1,
+					   sizeof(*scmi_sensors->attrs),
+					   GFP_KERNEL);
+	if (!scmi_sensors->attrs)
+		return -ENOMEM;
+
+	scmi_sensors->handle = handle;
+
+	for (i = 0, idx = 0; i < nr_sensors; i++) {
+		struct sensor_data *sensor = &scmi_sensors->data[idx];
+
+		sensor->info = handle->sensor_ops->info_get(handle, i);
+		if (!sensor->info)
+			return PTR_ERR(sensor->info);
+
+		switch (sensor->info->type) {
+		case TEMPERATURE_C:
+			snprintf(sensor->input, sizeof(sensor->input),
+				 "temp%d_input", num_temp + 1);
+			snprintf(sensor->label, sizeof(sensor->input),
+				 "temp%d_label", num_temp + 1);
+			num_temp++;
+			break;
+		case VOLTAGE:
+			snprintf(sensor->input, sizeof(sensor->input),
+				 "in%d_input", num_volt);
+			snprintf(sensor->label, sizeof(sensor->input),
+				 "in%d_label", num_volt);
+			num_volt++;
+			break;
+		case CURRENT:
+			snprintf(sensor->input, sizeof(sensor->input),
+				 "curr%d_input", num_current + 1);
+			snprintf(sensor->label, sizeof(sensor->input),
+				 "curr%d_label", num_current + 1);
+			num_current++;
+			break;
+		case POWER:
+			snprintf(sensor->input, sizeof(sensor->input),
+				 "power%d_input", num_power + 1);
+			snprintf(sensor->label, sizeof(sensor->input),
+				 "power%d_label", num_power + 1);
+			num_power++;
+			break;
+		case ENERGY:
+			snprintf(sensor->input, sizeof(sensor->input),
+				 "energy%d_input", num_energy + 1);
+			snprintf(sensor->label, sizeof(sensor->input),
+				 "energy%d_label", num_energy + 1);
+			num_energy++;
+			break;
+		default:
+			continue;
+		}
+
+		sensor->dev_attr_input.attr.mode = S_IRUGO;
+		sensor->dev_attr_input.show = scmi_show_sensor;
+		sensor->dev_attr_input.attr.name = sensor->input;
+
+		sensor->dev_attr_label.attr.mode = S_IRUGO;
+		sensor->dev_attr_label.show = scmi_show_label;
+		sensor->dev_attr_label.attr.name = sensor->label;
+
+		scmi_sensors->attrs[idx << 1] = &sensor->dev_attr_input.attr;
+		scmi_sensors->attrs[(idx << 1) + 1] =
+					&sensor->dev_attr_label.attr;
+
+		sysfs_attr_init(scmi_sensors->attrs[idx << 1]);
+		sysfs_attr_init(scmi_sensors->attrs[(idx << 1) + 1]);
+		idx++;
+	}
+
+	scmi_sensors->group.attrs = scmi_sensors->attrs;
+	scmi_sensors->groups[0] = &scmi_sensors->group;
+
+	platform_set_drvdata(pdev, scmi_sensors);
+
+	hwdev = devm_hwmon_device_register_with_groups(dev, "scmi_sensors",
+						       scmi_sensors,
+						       scmi_sensors->groups);
+
+	if (IS_ERR(hwdev))
+		return PTR_ERR(hwdev);
+
+	/*
+	 * Register the temperature sensors with the thermal framework
+	 * to allow their usage in setting up the thermal zones from
+	 * device tree.
+	 *
+	 * NOTE: Not all temperature sensors maybe used for thermal
+	 * control
+	 */
+	INIT_LIST_HEAD(&scmi_sensors->thermal_zones);
+	for (i = 0; i < nr_sensors; i++) {
+		struct sensor_data *sensor = &scmi_sensors->data[i];
+		const struct scmi_sensor_info *info = sensor->info;
+		struct thermal_zone_device *z;
+		struct scmi_thermal_zone *zone;
+
+		if (info->type != TEMPERATURE_C)
+			continue;
+
+		zone = devm_kzalloc(dev, sizeof(*zone), GFP_KERNEL);
+		if (!zone)
+			return -ENOMEM;
+
+		zone->sensor_id = i;
+		zone->scmi_sensors = scmi_sensors;
+		z = devm_thermal_zone_of_sensor_register(dev, info->id, zone,
+							 &scmi_sensor_ops);
+		/*
+		 * The call to thermal_zone_of_sensor_register returns
+		 * an error for sensors that are not associated with
+		 * any thermal zones or if the thermal subsystem is
+		 * not configured.
+		 */
+		if (IS_ERR(z)) {
+			devm_kfree(dev, zone);
+			continue;
+		}
+	}
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
+MODULE_AUTHOR("Punit Agrawal <punit.agrawal@arm.com>");
+MODULE_DESCRIPTION("ARM SCMI HWMON interface driver");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4
