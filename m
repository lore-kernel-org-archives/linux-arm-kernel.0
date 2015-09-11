From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 11 Sep 2015 10:15:14 +0200
Subject: cpufreq: mediatek: allow modular build
Message-ID: <1768766.yu1lxjsjLL@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The newly merged cpufreq-mt8173 driver breaks the ARM allmodconfig
build because of a dependency on the cpu-cooling infrastructure that
may be built as a loadable module:

drivers/built-in.o: In function `mtk_cpufreq_ready':
binder.c:(.text+0x324c8c): undefined reference to `of_cpufreq_cooling_register'
drivers/built-in.o: In function `mtk_cpufreq_exit':
binder.c:(.text+0x324ea0): undefined reference to `cpufreq_cooling_unregister'

This works around the issue by allowing this driver to be built
as a module as well, and adding a dependency on THERMAL that prevents
it from being built-in when the cpu-cooling driver is a module.

This is not perfect because there is still a case where THERMAL=m
and CPU_COOLING=n that should allow us to have this driver built-in
as well, but I decided to follow existing practice in other drivers
here, and that case seems irrelevant in practice.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
I have not checked if someone else has already sent a patch for this,
just ignore mine if the issue has been fixed already.

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 77aa34eae92c..28844bdf026d 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -131,8 +131,8 @@ config ARM_KIRKWOOD_CPUFREQ
 	  SoCs.
 
 config ARM_MT8173_CPUFREQ
-	bool "Mediatek MT8173 CPUFreq support"
-	depends on ARCH_MEDIATEK && REGULATOR
+	tristate "Mediatek MT8173 CPUFreq support"
+	depends on ARCH_MEDIATEK && REGULATOR && THERMAL
 	select PM_OPP
 	help
 	  This adds the CPUFreq driver support for Mediatek MT8173 SoC.
diff --git a/drivers/cpufreq/mt8173-cpufreq.c b/drivers/cpufreq/mt8173-cpufreq.c
index 49caed293a3b..2131e1a81be9 100644
--- a/drivers/cpufreq/mt8173-cpufreq.c
+++ b/drivers/cpufreq/mt8173-cpufreq.c
@@ -17,6 +17,7 @@
 #include <linux/cpu_cooling.h>
 #include <linux/cpufreq.h>
 #include <linux/cpumask.h>
+#include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pm_opp.h>
@@ -524,4 +525,5 @@ static int mt8173_cpufreq_driver_init(void)
 
 	return 0;
 }
-device_initcall(mt8173_cpufreq_driver_init);
+module_init(mt8173_cpufreq_driver_init);
+MODULE_LICENSE("GPL v2");
