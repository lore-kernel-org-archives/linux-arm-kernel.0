From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 18 Dec 2015 15:52:28 +0100
Subject: [PATCH] hwmon: sht15 needs CONFIG_BITREVERSE
Message-ID: <1562989.nyG23Y3QQo@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If CONFIG_BITREVERSE is not built-in, the sht15 driver fails to link:

drivers/built-in.o: In function `sht15_crc8':
drivers/hwmon/sht15.c:195: undefined reference to `byte_rev_table'

This adds a Kconfig 'select' statement, like all other users of
bitrev.h have it.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 33836ee98533 ("hwmon:change sht15_reverse()")

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 4a6e7c217329..60fb80bd353d 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -1207,6 +1207,7 @@ config SENSORS_PWM_FAN
 config SENSORS_SHT15
 	tristate "Sensiron humidity and temperature sensors. SHT15 and compat."
 	depends on GPIOLIB || COMPILE_TEST
+	select BITREVERSE
 	help
 	  If you say yes here you get support for the Sensiron SHT10, SHT11,
 	  SHT15, SHT71, SHT75 humidity and temperature sensors.
