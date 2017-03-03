From: carlo@caione.org (Carlo Caione)
Date: Fri,  3 Mar 2017 10:14:49 +0100
Subject: [PATCH v2 2/2] hwmon: (scpi) Fix the scale of SCP sensor readings
In-Reply-To: <20170303091449.3512-1-carlo@caione.org>
References: <20170303091449.3512-1-carlo@caione.org>
Message-ID: <20170303091449.3512-3-carlo@caione.org>
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
 drivers/hwmon/scpi-hwmon.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/hwmon/scpi-hwmon.c b/drivers/hwmon/scpi-hwmon.c
index 094f948f99ff..b64fe7d10742 100644
--- a/drivers/hwmon/scpi-hwmon.c
+++ b/drivers/hwmon/scpi-hwmon.c
@@ -23,6 +23,7 @@
 #include <linux/thermal.h>
 
 struct sensor_data {
+	unsigned int scale;
 	struct scpi_sensor_info info;
 	struct device_attribute dev_attr_input;
 	struct device_attribute dev_attr_label;
@@ -44,6 +45,22 @@ struct scpi_sensors {
 	const struct attribute_group *groups[2];
 };
 
+static const u32 scpi_scale[] = {
+	[TEMPERATURE]	= 1000,		/* (millicelsius)	*/
+	[VOLTAGE]	= 1000,		/* (millivolts)		*/
+	[CURRENT]	= 1000,		/* (milliamperes)	*/
+	[POWER]		= 1000000,	/* (microwatts)		*/
+	[ENERGY]	= 1000000,	/* (microjoules)	*/
+};
+
+void scpi_scale_reading(u64 *value, struct sensor_data *sensor)
+{
+	if (scpi_scale[sensor->info.class] != sensor->scale) {
+		*value *= scpi_scale[sensor->info.class];
+		do_div(*value, sensor->scale);
+	}
+}
+
 static int scpi_read_temp(void *dev, int *temp)
 {
 	struct scpi_thermal_zone *zone = dev;
@@ -57,6 +74,8 @@ static int scpi_read_temp(void *dev, int *temp)
 	if (ret)
 		return ret;
 
+	scpi_scale_reading(&value, sensor);
+
 	*temp = value;
 	return 0;
 }
@@ -77,6 +96,8 @@ scpi_show_sensor(struct device *dev, struct device_attribute *attr, char *buf)
 	if (ret)
 		return ret;
 
+	scpi_scale_reading(&value, sensor);
+
 	return sprintf(buf, "%llu\n", value);
 }
 
@@ -97,6 +118,7 @@ static struct thermal_zone_of_device_ops scpi_sensor_ops = {
 static int scpi_hwmon_probe(struct platform_device *pdev)
 {
 	u16 nr_sensors, i;
+	u32 scale[] = { 1000, 1000, 1000, 1000000, 1000000 };
 	int num_temp = 0, num_volt = 0, num_current = 0, num_power = 0;
 	int num_energy = 0;
 	struct scpi_ops *scpi_ops;
@@ -131,6 +153,16 @@ static int scpi_hwmon_probe(struct platform_device *pdev)
 
 	scpi_sensors->scpi_ops = scpi_ops;
 
+	of_property_read_u32_array(dev->of_node, "scpi,sensors-scale",
+				   scale, ARRAY_SIZE(scale));
+
+	for (i = 0; i < ARRAY_SIZE(scale); i++) {
+		if (!scale[i]) {
+			dev_err(dev, "%s: scale cannot be zero (%d)\n", __func__, i);
+			return -EINVAL;
+		}
+	}
+
 	for (i = 0, idx = 0; i < nr_sensors; i++) {
 		struct sensor_data *sensor = &scpi_sensors->data[idx];
 
@@ -178,6 +210,8 @@ static int scpi_hwmon_probe(struct platform_device *pdev)
 			continue;
 		}
 
+		sensor->scale = scale[sensor->info.class];
+
 		sensor->dev_attr_input.attr.mode = S_IRUGO;
 		sensor->dev_attr_input.show = scpi_show_sensor;
 		sensor->dev_attr_input.attr.name = sensor->input;
-- 
2.12.0
