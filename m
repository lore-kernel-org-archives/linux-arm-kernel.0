From: carlo@caione.org (Carlo Caione)
Date: Thu,  2 Mar 2017 13:15:00 +0100
Subject: [PATCH 2/2] hwmon: (scpi) Fix the scale of SCP sensor readings
In-Reply-To: <20170302121500.8121-1-carlo@caione.org>
References: <20170302121500.8121-1-carlo@caione.org>
Message-ID: <20170302121500.8121-3-carlo@caione.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Carlo Caione <carlo@endlessm.com>

The implementation details for SCPI seems to suggest that the sensor
readings must be reported by SCP using a well defined scale
(millidegree Celsius for temperature, millivolts for voltage,
milliamperes for current, microwatts for power and microjoules for
energy).

This is also important for the interaction with other subsystems: for
example both the thermal sub-system and the hwmon sysfs interface expect
the temperature expressed in millidegree Celsius.

Unfortunately since this behaviour is dependent on the firmware
implementation there are cases where the sensor readings are reported
using a different scale. For example in the Amlogic SoCs the
temperature is reported in degree and not millidegree Celsius.

To take into account this discrepancy and fixup the values reported by
SCP a new DT property `scpi,sensors-scale' is introduced and used in
this patch by the scpi-hwmon driver to convert the sensor readings to
the expected scale.

Signed-off-by: Carlo Caione <carlo@endlessm.com>
---
 drivers/hwmon/scpi-hwmon.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/hwmon/scpi-hwmon.c b/drivers/hwmon/scpi-hwmon.c
index 094f948f99ff..64a51e06c8df 100644
--- a/drivers/hwmon/scpi-hwmon.c
+++ b/drivers/hwmon/scpi-hwmon.c
@@ -23,6 +23,7 @@
 #include <linux/thermal.h>
 
 struct sensor_data {
+	unsigned int scale;
 	struct scpi_sensor_info info;
 	struct device_attribute dev_attr_input;
 	struct device_attribute dev_attr_label;
@@ -44,6 +45,14 @@ struct scpi_sensors {
 	const struct attribute_group *groups[2];
 };
 
+static const unsigned int scpi_scale[] = {
+	1000,		/* Temperature (millidegrees Celsius)	*/
+	1000,		/* Voltage     (millivolts)		*/
+	1000,		/* Current     (milliamperes)		*/
+	1000000,	/* Power       (microwatts)		*/
+	1000000,	/* Energy      (microjoules)		*/
+};
+
 static int scpi_read_temp(void *dev, int *temp)
 {
 	struct scpi_thermal_zone *zone = dev;
@@ -57,6 +66,11 @@ static int scpi_read_temp(void *dev, int *temp)
 	if (ret)
 		return ret;
 
+	if (scpi_scale[sensor->info.class] != sensor->scale) {
+		value *= scpi_scale[sensor->info.class];
+		do_div(value, sensor->scale);
+	}
+
 	*temp = value;
 	return 0;
 }
@@ -77,6 +91,11 @@ scpi_show_sensor(struct device *dev, struct device_attribute *attr, char *buf)
 	if (ret)
 		return ret;
 
+	if (scpi_scale[sensor->info.class] != sensor->scale) {
+		value *= scpi_scale[sensor->info.class];
+		do_div(value, sensor->scale);
+	}
+
 	return sprintf(buf, "%llu\n", value);
 }
 
@@ -97,6 +116,7 @@ static struct thermal_zone_of_device_ops scpi_sensor_ops = {
 static int scpi_hwmon_probe(struct platform_device *pdev)
 {
 	u16 nr_sensors, i;
+	u32 scale[] = { 1000, 1000, 1000, 1000000, 1000000 };
 	int num_temp = 0, num_volt = 0, num_current = 0, num_power = 0;
 	int num_energy = 0;
 	struct scpi_ops *scpi_ops;
@@ -131,6 +151,9 @@ static int scpi_hwmon_probe(struct platform_device *pdev)
 
 	scpi_sensors->scpi_ops = scpi_ops;
 
+	of_property_read_u32_array(dev->of_node, "scpi,sensors-scale",
+				   scale, ARRAY_SIZE(scale));
+
 	for (i = 0, idx = 0; i < nr_sensors; i++) {
 		struct sensor_data *sensor = &scpi_sensors->data[idx];
 
@@ -178,6 +201,8 @@ static int scpi_hwmon_probe(struct platform_device *pdev)
 			continue;
 		}
 
+		sensor->scale = scale[sensor->info.class];
+
 		sensor->dev_attr_input.attr.mode = S_IRUGO;
 		sensor->dev_attr_input.show = scpi_show_sensor;
 		sensor->dev_attr_input.attr.name = sensor->input;
-- 
2.12.0
