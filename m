From: carlo@caione.org (Carlo Caione)
Date: Wed,  1 Mar 2017 14:20:28 +0100
Subject: [PATCH] hwmon: (scpi) Add slope and offset to SCP sensor readings
Message-ID: <20170301132028.25309-1-carlo@caione.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Carlo Caione <carlo@endlessm.com>

The temperature provided by the SCP sensors not always is expressed in
millicelsius, whereas this is required by the thermal framework. This is
for example the case for the Amlogic devices, where the SCP sensor
readings are expressed in degree (and not milli degree) Celsius.

To convert the sensor readings, the thermal framework provides the
"coefficients" property, used by the thermal sensor device to adjust
their reading. This adjustment in currently not considered by the SCPI
hwmon driver. Fix this introducing slope and offset for the SCP sensor
readings.

Signed-off-by: Carlo Caione <carlo@endlessm.com>
---
 drivers/hwmon/scpi-hwmon.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/hwmon/scpi-hwmon.c b/drivers/hwmon/scpi-hwmon.c
index 094f948f99ff..cdc05c60ba67 100644
--- a/drivers/hwmon/scpi-hwmon.c
+++ b/drivers/hwmon/scpi-hwmon.c
@@ -33,6 +33,7 @@ struct sensor_data {
 struct scpi_thermal_zone {
 	int sensor_id;
 	struct scpi_sensors *scpi_sensors;
+	struct thermal_zone_device *z;
 };
 
 struct scpi_sensors {
@@ -51,13 +52,17 @@ static int scpi_read_temp(void *dev, int *temp)
 	struct scpi_ops *scpi_ops = scpi_sensors->scpi_ops;
 	struct sensor_data *sensor = &scpi_sensors->data[zone->sensor_id];
 	u64 value;
+	int slope, offset;
 	int ret;
 
 	ret = scpi_ops->sensor_get_value(sensor->info.sensor_id, &value);
 	if (ret)
 		return ret;
 
-	*temp = value;
+	slope = thermal_zone_get_slope(zone->z);
+	offset = thermal_zone_get_offset(zone->z);
+
+	*temp = value * slope + offset;
 	return 0;
 }
 
@@ -216,7 +221,6 @@ static int scpi_hwmon_probe(struct platform_device *pdev)
 	INIT_LIST_HEAD(&scpi_sensors->thermal_zones);
 	for (i = 0; i < nr_sensors; i++) {
 		struct sensor_data *sensor = &scpi_sensors->data[i];
-		struct thermal_zone_device *z;
 		struct scpi_thermal_zone *zone;
 
 		if (sensor->info.class != TEMPERATURE)
@@ -228,17 +232,17 @@ static int scpi_hwmon_probe(struct platform_device *pdev)
 
 		zone->sensor_id = i;
 		zone->scpi_sensors = scpi_sensors;
-		z = devm_thermal_zone_of_sensor_register(dev,
-							 sensor->info.sensor_id,
-							 zone,
-							 &scpi_sensor_ops);
+		zone->z = devm_thermal_zone_of_sensor_register(dev,
+							       sensor->info.sensor_id,
+							       zone,
+							       &scpi_sensor_ops);
 		/*
 		 * The call to thermal_zone_of_sensor_register returns
 		 * an error for sensors that are not associated with
 		 * any thermal zones or if the thermal subsystem is
 		 * not configured.
 		 */
-		if (IS_ERR(z)) {
+		if (IS_ERR(zone->z)) {
 			devm_kfree(dev, zone);
 			continue;
 		}
-- 
2.12.0
