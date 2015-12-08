From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 08 Dec 2015 16:43:35 +0100
Subject: [PATCH] regulator: add regulator_sync_voltage inline dummy
Message-ID: <1983152.2iYiBkp4xd@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Only one driver calls regulator_sync_voltage(), but that driver
can currently be built with CONFIG_REGULATOR disabled, producing
this build error:

drivers/cpufreq/tegra124-cpufreq.c: In function 'tegra124_cpu_switch_to_pllx':
drivers/cpufreq/tegra124-cpufreq.c:68:2: error: implicit declaration of function 'regulator_sync_voltage' [-Werror=implicit-function-declaration]
  regulator_sync_voltage(priv->vdd_cpu_reg);

This modifies the API header so we provide a static inline function
with the same prototype as the normal function of this name. This matches
what we do for all other regulator API functions and avoids the build
error.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/regulator/consumer.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/regulator/consumer.h b/include/linux/regulator/consumer.h
index 48603506f8de..d45e2e99396a 100644
--- a/include/linux/regulator/consumer.h
+++ b/include/linux/regulator/consumer.h
@@ -458,6 +458,11 @@ static inline int regulator_get_voltage(struct regulator *regulator)
 	return -EINVAL;
 }
 
+static inline int regulator_sync_voltage(struct regulator *regulator)
+{
+	return 0;
+}
+
 static inline int regulator_is_supported_voltage(struct regulator *regulator,
 				   int min_uV, int max_uV)
 {
-- 
2.1.0.rc2
