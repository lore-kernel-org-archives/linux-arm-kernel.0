From: leo.yan@linaro.org (Leo Yan)
Date: Tue, 29 Mar 2016 19:27:12 +0800
Subject: [PATCH v3 1/4] thermal: hisilicon: support to use any sensor
In-Reply-To: <1459250835-25561-1-git-send-email-leo.yan@linaro.org>
References: <1459250835-25561-1-git-send-email-leo.yan@linaro.org>
Message-ID: <1459250835-25561-2-git-send-email-leo.yan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In current code sensor driver registers all 4 sensors together and if
any of them has not bound to thermal zone successfully then driver will
return failure for driver's initialization. As a result, if DT binds
thermal zone with only one sensor, then the thermal driver will not work
well anymore.

So this patch is to fix this issue. It allows the thermal sensor driver
can register any number sensors at initialization phase, and fix up code
for other related code to skip related sensor's accessing if the sensor
has not been enabled in initialization phase.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 drivers/thermal/hisi_thermal.c | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
index 36d0729..0fed5cf 100644
--- a/drivers/thermal/hisi_thermal.c
+++ b/drivers/thermal/hisi_thermal.c
@@ -160,7 +160,7 @@ static int hisi_thermal_get_temp(void *_sensor, int *temp)
 	struct hisi_thermal_sensor *sensor = _sensor;
 	struct hisi_thermal_data *data = sensor->thermal;
 
-	int sensor_id = 0, i;
+	int sensor_id = -1, i;
 	long max_temp = 0;
 
 	*temp = hisi_thermal_get_sensor_temp(data, sensor);
@@ -168,12 +168,19 @@ static int hisi_thermal_get_temp(void *_sensor, int *temp)
 	sensor->sensor_temp = *temp;
 
 	for (i = 0; i < HISI_MAX_SENSORS; i++) {
+		if (!data->sensors[i].tzd)
+			continue;
+
 		if (data->sensors[i].sensor_temp >= max_temp) {
 			max_temp = data->sensors[i].sensor_temp;
 			sensor_id = i;
 		}
 	}
 
+	/* If no sensor has been enabled, then skip to enable irq */
+	if (sensor_id == -1)
+		return 0;
+
 	mutex_lock(&data->thermal_lock);
 	data->irq_bind_sensor = sensor_id;
 	mutex_unlock(&data->thermal_lock);
@@ -226,8 +233,12 @@ static irqreturn_t hisi_thermal_alarm_irq_thread(int irq, void *dev)
 		 sensor->thres_temp / 1000);
 	mutex_unlock(&data->thermal_lock);
 
-	for (i = 0; i < HISI_MAX_SENSORS; i++)
+	for (i = 0; i < HISI_MAX_SENSORS; i++) {
+		if (!data->sensors[i].tzd)
+			continue;
+
 		thermal_zone_device_update(data->sensors[i].tzd);
+	}
 
 	return IRQ_HANDLED;
 }
@@ -247,6 +258,7 @@ static int hisi_thermal_register_sensor(struct platform_device *pdev,
 				sensor, &hisi_of_thermal_ops);
 	if (IS_ERR(sensor->tzd)) {
 		ret = PTR_ERR(sensor->tzd);
+		sensor->tzd = NULL;
 		dev_err(&pdev->dev, "failed to register sensor id %d: %d\n",
 			sensor->id, ret);
 		return ret;
@@ -334,25 +346,17 @@ static int hisi_thermal_probe(struct platform_device *pdev)
 	for (i = 0; i < HISI_MAX_SENSORS; ++i) {
 		ret = hisi_thermal_register_sensor(pdev, data,
 						   &data->sensors[i], i);
-		if (ret) {
+		if (ret)
 			dev_err(&pdev->dev,
 				"failed to register thermal sensor: %d\n", ret);
-			goto err_get_sensor_data;
-		}
+		else
+			hisi_thermal_toggle_sensor(&data->sensors[i], true);
 	}
 
 	hisi_thermal_enable_bind_irq_sensor(data);
 	data->irq_enabled = true;
 
-	for (i = 0; i < HISI_MAX_SENSORS; i++)
-		hisi_thermal_toggle_sensor(&data->sensors[i], true);
-
 	return 0;
-
-err_get_sensor_data:
-	clk_disable_unprepare(data->clk);
-
-	return ret;
 }
 
 static int hisi_thermal_remove(struct platform_device *pdev)
@@ -363,6 +367,9 @@ static int hisi_thermal_remove(struct platform_device *pdev)
 	for (i = 0; i < HISI_MAX_SENSORS; i++) {
 		struct hisi_thermal_sensor *sensor = &data->sensors[i];
 
+		if (!sensor->tzd)
+			continue;
+
 		hisi_thermal_toggle_sensor(sensor, false);
 		thermal_zone_of_sensor_unregister(&pdev->dev, sensor->tzd);
 	}
-- 
1.9.1
