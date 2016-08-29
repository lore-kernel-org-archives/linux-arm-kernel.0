From: Anson.Huang@nxp.com (Anson Huang)
Date: Mon, 29 Aug 2016 23:41:12 +0800
Subject: [PATCH V2] ARM: imx: add cpuidle support for i.mx6ul
Message-ID: <1472485272-17036-1-git-send-email-Anson.Huang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables cpuidle driver for i.MX6UL, it
reuses i.MX6SX's cpuidle driver, 3 levels of cpuidle
supported:

1. ARM WFI;
2. SOC in WAIT mode;
3. SOC in WAIT mode + ARM power off.

As i.MX6UL has cortex-A7 CORE with an internal L2
cache, so flushing it before powering down ARM platform
is necessary, flush_cache_all() in last step of cpu_suspend
has very small overhead, just call it to avoid cache
type check for different platforms.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
changes since V1:
	remove L2 cache contional code, just call flush_cache_all
	is just fine since it has very small overhead for L1 cache flush.
 arch/arm/mach-imx/cpuidle-imx6sx.c | 10 ++++++++++
 arch/arm/mach-imx/mach-imx6ul.c    |  3 +++
 2 files changed, 13 insertions(+)

diff --git a/arch/arm/mach-imx/cpuidle-imx6sx.c b/arch/arm/mach-imx/cpuidle-imx6sx.c
index 261aaa4..c5a5c3a 100644
--- a/arch/arm/mach-imx/cpuidle-imx6sx.c
+++ b/arch/arm/mach-imx/cpuidle-imx6sx.c
@@ -9,6 +9,7 @@
 #include <linux/cpuidle.h>
 #include <linux/cpu_pm.h>
 #include <linux/module.h>
+#include <asm/cacheflush.h>
 #include <asm/cpuidle.h>
 #include <asm/suspend.h>
 
@@ -17,6 +18,15 @@
 
 static int imx6sx_idle_finish(unsigned long val)
 {
+	/*
+	 * for Cortex-A7 which has an internal L2
+	 * cache, need to flush it before powering
+	 * down ARM platform, since flushing L1 cache
+	 * here again has very small overhead, compared
+	 * to adding conditional code for L2 cache type,
+	 * just call flush_cache_all() is fine.
+	 */
+	flush_cache_all();
 	cpu_do_idle();
 
 	return 0;
diff --git a/arch/arm/mach-imx/mach-imx6ul.c b/arch/arm/mach-imx/mach-imx6ul.c
index 6bb7d9c..58a2b88 100644
--- a/arch/arm/mach-imx/mach-imx6ul.c
+++ b/arch/arm/mach-imx/mach-imx6ul.c
@@ -16,6 +16,7 @@
 #include <asm/mach/map.h>
 
 #include "common.h"
+#include "cpuidle.h"
 
 static void __init imx6ul_enet_clk_init(void)
 {
@@ -80,6 +81,8 @@ static void __init imx6ul_init_irq(void)
 
 static void __init imx6ul_init_late(void)
 {
+	imx6sx_cpuidle_init();
+
 	if (IS_ENABLED(CONFIG_ARM_IMX6Q_CPUFREQ))
 		platform_device_register_simple("imx6q-cpufreq", -1, NULL, 0);
 }
-- 
1.9.1
