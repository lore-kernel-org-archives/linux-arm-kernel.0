From: l.majewski@samsung.com (Lukasz Majewski)
Date: Thu, 09 Oct 2014 18:38:39 +0200
Subject: [PATCH 03/21] thermal: of: Extend of-thermal.c to provide number of
 non critical trip points
In-Reply-To: <1412872737-624-1-git-send-email-l.majewski@samsung.com>
References: <1412872737-624-1-git-send-email-l.majewski@samsung.com>
Message-ID: <1412872737-624-4-git-send-email-l.majewski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch extends the of-thermal.c to provide information about number of
available non critical (i.e. non HW) trip points in the system.

Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
---
 drivers/thermal/of-thermal.c   | 12 ++++++++++++
 drivers/thermal/thermal_core.h |  5 +++++
 2 files changed, 17 insertions(+)

diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
index 23c8d6c..cd74e64 100644
--- a/drivers/thermal/of-thermal.c
+++ b/drivers/thermal/of-thermal.c
@@ -128,6 +128,18 @@ int of_thermal_is_trip_en(struct thermal_zone_device *tz, int trip)
 	return 1;
 }
 
+int of_thermal_get_non_crit_ntrips(struct thermal_zone_device *tz)
+{
+	struct __thermal_zone *data = tz->devdata;
+	int i;
+
+	for (i = 0; i < data->ntrips; i++)
+		if (data->trips[i].type != THERMAL_TRIP_CRITICAL)
+			continue;
+
+	return --i;
+}
+
 static int of_thermal_get_trend(struct thermal_zone_device *tz, int trip,
 				enum thermal_trend *trend)
 {
diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index ed8ff05..334a7be 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -83,6 +83,7 @@ int of_parse_thermal_zones(void);
 void of_thermal_destroy_zones(void);
 int of_thermal_get_ntrips(struct thermal_zone_device *);
 int of_thermal_is_trip_en(struct thermal_zone_device *, int);
+int of_thermal_get_non_crit_ntrips(struct thermal_zone_device *);
 #else
 static inline int of_parse_thermal_zones(void) { return 0; }
 static inline void of_thermal_destroy_zones(void) { }
@@ -94,6 +95,10 @@ int of_thermal_is_trip_en(struct thermal_zone_device *, int)
 {
 	return 0;
 }
+int of_thermal_get_non_crit_ntrips(struct thermal_zone_device *)
+{
+	return 0;
+}
 #endif
 
 #endif /* __THERMAL_CORE_H__ */
-- 
2.0.0.rc2
