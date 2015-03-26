From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 26 Mar 2015 16:53:53 +0100
Subject: [PATCH 06/13] thermal: streamline get_trend callbacks
In-Reply-To: <1427385240-6086-1-git-send-email-s.hauer@pengutronix.de>
References: <1427385240-6086-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1427385240-6086-7-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The .get_trend callback in struct thermal_zone_device_ops has the prototype:

	int (*get_trend) (struct thermal_zone_device *, int,
			  enum thermal_trend *);

whereas the .get_trend callback in struct thermal_zone_of_device_ops has:

	int (*get_trend)(void *, long *);

Streamline both prototypes and add the trip argument to the OF callback
aswell and use enum thermal_trend * instead of an integer pointer.

While the OF prototype may be the better one, this should be decided at
framework level and not on OF level.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/thermal/of-thermal.c                       | 11 +---------
 drivers/thermal/ti-soc-thermal/ti-thermal-common.c | 25 +++++++---------------
 include/linux/thermal.h                            |  2 +-
 3 files changed, 10 insertions(+), 28 deletions(-)

diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
index 668fb1b..b39e22f 100644
--- a/drivers/thermal/of-thermal.c
+++ b/drivers/thermal/of-thermal.c
@@ -187,24 +187,15 @@ static int of_thermal_get_trend(struct thermal_zone_device *tz, int trip,
 				enum thermal_trend *trend)
 {
 	struct __thermal_zone *data = tz->devdata;
-	long dev_trend;
 	int r;
 
 	if (!data->ops->get_trend)
 		return -EINVAL;
 
-	r = data->ops->get_trend(data->sensor_data, &dev_trend);
+	r = data->ops->get_trend(data->sensor_data, trip, trend);
 	if (r)
 		return r;
 
-	/* TODO: These intervals might have some thresholds, but in core code */
-	if (dev_trend > 0)
-		*trend = THERMAL_TREND_RAISING;
-	else if (dev_trend < 0)
-		*trend = THERMAL_TREND_DROPPING;
-	else
-		*trend = THERMAL_TREND_STABLE;
-
 	return 0;
 }
 
diff --git a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
index a38c175..7f8e5f3 100644
--- a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
+++ b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
@@ -238,7 +238,7 @@ static int ti_thermal_get_trip_temp(struct thermal_zone_device *thermal,
 	return 0;
 }
 
-static int __ti_thermal_get_trend(void *p, long *trend)
+static int __ti_thermal_get_trend(void *p, int trip, enum thermal_trend *trend)
 {
 	struct ti_thermal_data *data = p;
 	struct ti_bandgap *bgp;
@@ -251,22 +251,6 @@ static int __ti_thermal_get_trend(void *p, long *trend)
 	if (ret)
 		return ret;
 
-	*trend = tr;
-
-	return 0;
-}
-
-/* Get the temperature trend callback functions for thermal zone */
-static int ti_thermal_get_trend(struct thermal_zone_device *thermal,
-				int trip, enum thermal_trend *trend)
-{
-	int ret;
-	long tr;
-
-	ret = __ti_thermal_get_trend(thermal->devdata, &tr);
-	if (ret)
-		return ret;
-
 	if (tr > 0)
 		*trend = THERMAL_TREND_RAISING;
 	else if (tr < 0)
@@ -277,6 +261,13 @@ static int ti_thermal_get_trend(struct thermal_zone_device *thermal,
 	return 0;
 }
 
+/* Get the temperature trend callback functions for thermal zone */
+static int ti_thermal_get_trend(struct thermal_zone_device *thermal,
+				int trip, enum thermal_trend *trend)
+{
+	return __ti_thermal_get_trend(thermal->devdata, trip, trend);
+}
+
 /* Get critical temperature callback functions for thermal zone */
 static int ti_thermal_get_crit_temp(struct thermal_zone_device *thermal,
 				    unsigned long *temp)
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index db6c12b..ba2e29a 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -273,7 +273,7 @@ struct thermal_genl_event {
  */
 struct thermal_zone_of_device_ops {
 	int (*get_temp)(void *, long *);
-	int (*get_trend)(void *, long *);
+	int (*get_trend)(void *, int trend, enum thermal_trend *);
 	int (*set_emul_temp)(void *, unsigned long);
 };
 
-- 
2.1.4
