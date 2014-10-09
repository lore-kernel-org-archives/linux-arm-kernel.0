From: l.majewski@samsung.com (Lukasz Majewski)
Date: Thu, 09 Oct 2014 18:38:38 +0200
Subject: [PATCH 02/21] thermal: of: Extend of-thermal.c to provide check if
 trip point is enabled
In-Reply-To: <1412872737-624-1-git-send-email-l.majewski@samsung.com>
References: <1412872737-624-1-git-send-email-l.majewski@samsung.com>
Message-ID: <1412872737-624-3-git-send-email-l.majewski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch extends the of-thermal.c to provide check if trip point is
enabled.

Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
---
 drivers/thermal/of-thermal.c   | 9 +++++++++
 drivers/thermal/thermal_core.h | 5 +++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
index b2390d9..23c8d6c 100644
--- a/drivers/thermal/of-thermal.c
+++ b/drivers/thermal/of-thermal.c
@@ -119,6 +119,15 @@ int of_thermal_get_ntrips(struct thermal_zone_device *tz)
 	return data->ntrips;
 }
 
+int of_thermal_is_trip_en(struct thermal_zone_device *tz, int trip)
+{
+	struct __thermal_zone *data = tz->devdata;
+
+	if (trip >= data->ntrips || trip < 0)
+		return 0;
+	return 1;
+}
+
 static int of_thermal_get_trend(struct thermal_zone_device *tz, int trip,
 				enum thermal_trend *trend)
 {
diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index 587ca5c..ed8ff05 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -82,6 +82,7 @@ static inline void thermal_gov_user_space_unregister(void) {}
 int of_parse_thermal_zones(void);
 void of_thermal_destroy_zones(void);
 int of_thermal_get_ntrips(struct thermal_zone_device *);
+int of_thermal_is_trip_en(struct thermal_zone_device *, int);
 #else
 static inline int of_parse_thermal_zones(void) { return 0; }
 static inline void of_thermal_destroy_zones(void) { }
@@ -89,6 +90,10 @@ static inline int of_thermal_get_ntrips(struct thermal_zone_device *)
 {
 	return 0;
 }
+int of_thermal_is_trip_en(struct thermal_zone_device *, int)
+{
+	return 0;
+}
 #endif
 
 #endif /* __THERMAL_CORE_H__ */
-- 
2.0.0.rc2
