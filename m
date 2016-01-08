From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 08 Jan 2016 21:06:43 +0100
Subject: [PATCH] regulator: max8973: add THERMAL_OF dependency
Message-ID: <7607130.s0M7SSqlJV@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>From 9f5ddfc667eb45dc2c5459e5acc5de45572456cd Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 8 Jan 2016 20:59:29 +0100
Subject: [PATCH] regulator: max8973: add THERMAL_OF dependency

The max8973 regulator driver has gained thermal support, but it
now fails to link when the driver is built-in and CONFIG_THERMAL=m:

drivers/built-in.o: In function `max8973_remove':
console.c:(.text+0x94ac4): undefined reference to `thermal_zone_of_sensor_unregister'
drivers/built-in.o: In function `max8973_probe':
console.c:(.text+0x95710): undefined reference to `thermal_zone_of_sensor_register'

This adds a dependency "depends on THERMAL || !THERMAL_OF" to ensure
that the driver cannot be built-in when THERMAL=m but is forced to
be a module as well, unless THERMAL_OF is disabled.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 1b7a4c6a9eea ("regulator: max8973: add support for junction thermal warning")
---
I've run into the same problem a couple of times now, with every driver
that calls thermal_zone_of_sensor_register(). I think we need a better
solution in general, but this fixes the immediate build error for now.

Maybe we should replace the "#ifdef CONFIG_THERMAL_OF" with "#if
IS_REACHABLE(CONFIG_THERMAL) && IS_ENABLED(CONFIG_THERMAL_OF)"?
The disadvantage of that is that the thermal management would be
silently disabled rather than cause a link error, and that may also
not be desired.

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 8155e80dd3f8..7df9da82f592 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -383,6 +383,7 @@ config REGULATOR_MAX8952
 config REGULATOR_MAX8973
 	tristate "Maxim MAX8973 voltage regulator "
 	depends on I2C
+	depends on THERMAL || !THERMAL_OF
 	select REGMAP_I2C
 	help
 	  The MAXIM MAX8973 high-efficiency. three phase, DC-DC step-down
