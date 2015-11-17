From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 17 Nov 2015 17:48:52 +0100
Subject: [PATCH] thermal: fix thermal_zone_bind_cooling_device prototype
Message-ID: <5439003.qQElgLSp5g@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When the prototype for thermal_zone_bind_cooling_device
changed, the static inline wrapper function was left alone,
which in theory can cause build warnings:

I have seen this error in the past:
drivers/thermal/db8500_thermal.c: In function 'db8500_cdev_bind':
drivers/thermal/db8500_thermal.c:78:9: error: too many arguments to function 'thermal_zone_bind_cooling_device'
   ret = thermal_zone_bind_cooling_device(thermal, i, cdev,

while this one no longer shows up, there is no doubt that
the prototype is still wrong, so let's just fix it anyway.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 6cd9e9f629f1 ("thermal: of: fix cooling device weights in device tree")

diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 4014a59828fc..613c29bd6baf 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -438,7 +438,8 @@ static inline void thermal_zone_device_unregister(
 static inline int thermal_zone_bind_cooling_device(
 	struct thermal_zone_device *tz, int trip,
 	struct thermal_cooling_device *cdev,
-	unsigned long upper, unsigned long lower)
+	unsigned long upper, unsigned long lower,
+	unsigned int weight)
 { return -ENODEV; }
 static inline int thermal_zone_unbind_cooling_device(
 	struct thermal_zone_device *tz, int trip,
