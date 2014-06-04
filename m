From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 04 Jun 2014 16:46 +0200
Subject: [PATCH] regulator: add regulator_can_change_voltage stub
Message-ID: <4605709.T97aRyQTUM@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When CONFIG_REGULATOR is not set, we cannot call
regulator_can_change_voltage() from a device driver, which results
in a build error like

video/fbdev/omap2/dss/hdmi5.c: In function 'hdmi_init_regulator':
video/fbdev/omap2/dss/hdmi5.c:149:2: error: implicit declaration of function 'regulator_can_change_voltage' [-Werror=implicit-function-declaration]

even for drivers that don't require the regulator API normally.
Such a use was recently added in the omap2+ hdmi driver.

This avoids the problem by adding a static inline function
stub in the API header, as we have for most of the other
regulator functions as well.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Mark Brown <broonie@kernel.org>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

diff --git a/include/linux/regulator/consumer.h b/include/linux/regulator/consumer.h
index a2d9d81..14ec18d 100644
--- a/include/linux/regulator/consumer.h
+++ b/include/linux/regulator/consumer.h
@@ -395,6 +395,11 @@ static inline void regulator_bulk_free(int num_consumers,
 {
 }
 
+static inline int regulator_can_change_voltage(struct regulator *regulator)
+{
+	return 0;
+}
+
 static inline int regulator_set_voltage(struct regulator *regulator,
 					int min_uV, int max_uV)
 {
