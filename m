From: carlo@caione.org (Carlo Caione)
Date: Tue, 30 May 2017 11:05:07 +0200
Subject: [PATCH v4 2/2] hwmon: (scpi) Fix the scale of SCP sensor readings
In-Reply-To: <20170530090507.16611-1-carlo@caione.org>
References: <20170530090507.16611-1-carlo@caione.org>
Message-ID: <20170530090507.16611-3-carlo@caione.org>
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
SCP a new compatible 'amlogic,meson-gxbb-scpi-sensors' is introduced and
used in this patch by the scpi-hwmon driver to convert the sensor
readings to the expected scale.

Signed-off-by: Carlo Caione <carlo@endlessm.com>
---
 drivers/hwmon/scpi-hwmon.c | 54 ++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 48 insertions(+), 6 deletions(-)

diff --git a/drivers/hwmon/scpi-hwmon.c b/drivers/hwmon/scpi-hwmon.c
index 094f948..a586480 100644
--- a/drivers/hwmon/scpi-hwmon.c
+++ b/drivers/hwmon/scpi-hwmon.c
@@ -16,6 +16,7 @@
 
 #include <linux/hwmon.h>
 #include <linux/module.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/scpi_protocol.h>
 #include <linux/slab.h>
@@ -23,6 +24,7 @@
 #include <linux/thermal.h>
 
 struct sensor_data {
+	unsigned int scale;
 	struct scpi_sensor_info info;
 	struct device_attribute dev_attr_input;
 	struct device_attribute dev_attr_label;
@@ -44,6 +46,30 @@ struct scpi_sensors {
 	const struct attribute_group *groups[2];
 };
 
+static const u32 gxbb_scpi_scale[] = {
+	[TEMPERATURE]	= 1,		/* (celsius)		*/
+	[VOLTAGE]	= 1000,		/* (millivolts)		*/
+	[CURRENT]	= 1000,		/* (milliamperes)	*/
+	[POWER]		= 1000000,	/* (microwatts)		*/
+	[ENERGY]	= 1000000,	/* (microjoules)	*/
+};
+
+static const u32 scpi_scale[] = {
+	[TEMPERATURE]	= 1000,		/* (millicelsius)	*/
+	[VOLTAGE]	= 1000,		/* (millivolts)		*/
+	[CURRENT]	= 1000,		/* (milliamperes)	*/
+	[POWER]		= 1000000,	/* (microwatts)		*/
+	[ENERGY]	= 1000000,	/* (microjoules)	*/
+};
+
+static void scpi_scale_reading(u64 *value, struct sensor_data *sensor)
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
@@ -57,6 +83,8 @@ static int scpi_read_temp(void *dev, int *temp)
 	if (ret)
 		return ret;
 
+	scpi_scale_reading(&value, sensor);
+
 	*temp = value;
 	return 0;
 }
@@ -77,6 +105,8 @@ scpi_show_sensor(struct device *dev, struct device_attribute *attr, char *buf)
 	if (ret)
 		return ret;
 
+	scpi_scale_reading(&value, sensor);
+
 	return sprintf(buf, "%llu\n", value);
 }
 
@@ -94,14 +124,23 @@ static struct thermal_zone_of_device_ops scpi_sensor_ops = {
 	.get_temp = scpi_read_temp,
 };
 
+static const struct of_device_id scpi_of_match[] = {
+	{.compatible = "arm,scpi-sensors", .data = &scpi_scale},
+	{.compatible = "amlogic,meson-gxbb-scpi-sensors", .data = &gxbb_scpi_scale},
+	{},
+};
+MODULE_DEVICE_TABLE(of, scpi_of_match);
+
 static int scpi_hwmon_probe(struct platform_device *pdev)
 {
 	u16 nr_sensors, i;
+	const u32 *scale;
 	int num_temp = 0, num_volt = 0, num_current = 0, num_power = 0;
 	int num_energy = 0;
 	struct scpi_ops *scpi_ops;
 	struct device *hwdev, *dev = &pdev->dev;
 	struct scpi_sensors *scpi_sensors;
+	const struct of_device_id *of_id;
 	int idx, ret;
 
 	scpi_ops = get_scpi_ops();
@@ -131,6 +170,13 @@ static int scpi_hwmon_probe(struct platform_device *pdev)
 
 	scpi_sensors->scpi_ops = scpi_ops;
 
+	of_id = of_match_device(scpi_of_match, &pdev->dev);
+	if (!of_id) {
+		dev_err(&pdev->dev, "Unable to initialize scpi-hwmon data\n");
+		return -ENODEV;
+	}
+	scale = of_id->data;
+
 	for (i = 0, idx = 0; i < nr_sensors; i++) {
 		struct sensor_data *sensor = &scpi_sensors->data[idx];
 
@@ -178,6 +224,8 @@ static int scpi_hwmon_probe(struct platform_device *pdev)
 			continue;
 		}
 
+		sensor->scale = scale[sensor->info.class];
+
 		sensor->dev_attr_input.attr.mode = S_IRUGO;
 		sensor->dev_attr_input.show = scpi_show_sensor;
 		sensor->dev_attr_input.attr.name = sensor->input;
@@ -247,12 +295,6 @@ static int scpi_hwmon_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct of_device_id scpi_of_match[] = {
-	{.compatible = "arm,scpi-sensors"},
-	{},
-};
-MODULE_DEVICE_TABLE(of, scpi_of_match);
-
 static struct platform_driver scpi_hwmon_platdrv = {
 	.driver = {
 		.name	= "scpi-hwmon",
-- 
2.9.3
