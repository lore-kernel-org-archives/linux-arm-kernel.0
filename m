From: magnus.damm@gmail.com (Magnus Damm)
Date: Fri, 09 Aug 2013 18:48:32 +0900
Subject: [PATCH 04/14] ARM: shmobile: sh73a0: Remove ->init_machine() special
 case
In-Reply-To: <20130809094748.6530.16511.sendpatchset@w520>
References: <20130809094748.6530.16511.sendpatchset@w520>
Message-ID: <20130809094832.6530.9438.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

No need to special case sh73a0 ->init_machine(),
so get rid of undesired cpufreq platform device
from the generic long term sh73a0 DT support code.

For short term support on KZM9D the DT reference
implementation now adds a "cpufreq-cpu0" platform
device so that can be used for development.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/board-kzm9g-reference.c |    9 ++++++++-
 arch/arm/mach-shmobile/include/mach/sh73a0.h   |    2 +-
 arch/arm/mach-shmobile/setup-sh73a0.c          |   23 ++++++-----------------
 3 files changed, 15 insertions(+), 19 deletions(-)

--- 0001/arch/arm/mach-shmobile/board-kzm9g-reference.c
+++ work/arch/arm/mach-shmobile/board-kzm9g-reference.c	2013-08-08 15:56:28.000000000 +0900
@@ -33,7 +33,14 @@
 
 static void __init kzm_init(void)
 {
-	sh73a0_add_standard_devices_dt();
+	/* clocks are setup late during boot in the case of DT */
+	sh73a0_clock_init();
+
+	sh73a0_add_dt_devices();
+
+	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+
+	platform_device_register_simple("cpufreq-cpu0", -1, NULL, 0);
 
 #ifdef CONFIG_CACHE_L2X0
 	/* Early BRESP enable, Shared attribute override enable, 64K*8way */
--- 0001/arch/arm/mach-shmobile/include/mach/sh73a0.h
+++ work/arch/arm/mach-shmobile/include/mach/sh73a0.h	2013-08-08 15:54:26.000000000 +0900
@@ -78,7 +78,7 @@ extern void sh73a0_map_io(void);
 extern void sh73a0_earlytimer_init(void);
 extern void sh73a0_add_early_devices(void);
 extern void sh73a0_add_standard_devices(void);
-extern void sh73a0_add_standard_devices_dt(void);
+extern void sh73a0_add_dt_devices(void);
 extern void sh73a0_clock_init(void);
 extern void sh73a0_pinmux_init(void);
 extern void sh73a0_pm_init(void);
--- 0001/arch/arm/mach-shmobile/setup-sh73a0.c
+++ work/arch/arm/mach-shmobile/setup-sh73a0.c	2013-08-08 15:57:42.000000000 +0900
@@ -23,7 +23,6 @@
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/platform_device.h>
-#include <linux/of_platform.h>
 #include <linux/delay.h>
 #include <linux/input.h>
 #include <linux/io.h>
@@ -901,6 +900,12 @@ static struct platform_device *sh73a0_la
 
 #define SRCR2          IOMEM(0xe61580b0)
 
+void __init sh73a0_add_dt_devices(void)
+{
+	platform_add_devices(sh73a0_devices_dt,
+			     ARRAY_SIZE(sh73a0_devices_dt));
+}
+
 void __init sh73a0_add_standard_devices(void)
 {
 	/* Clear software reset bit on SY-DMAC module */
@@ -943,21 +948,6 @@ void __init sh73a0_add_early_devices(voi
 
 #ifdef CONFIG_USE_OF
 
-void __init sh73a0_add_standard_devices_dt(void)
-{
-	struct platform_device_info devinfo = { .name = "cpufreq-cpu0", .id = -1, };
-
-	/* clocks are setup late during boot in the case of DT */
-	sh73a0_clock_init();
-
-	platform_add_devices(sh73a0_devices_dt,
-			     ARRAY_SIZE(sh73a0_devices_dt));
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
-
-	/* Instantiate cpufreq-cpu0 */
-	platform_device_register_full(&devinfo);
-}
-
 static const char *sh73a0_boards_compat_dt[] __initdata = {
 	"renesas,sh73a0",
 	NULL,
@@ -968,7 +958,6 @@ DT_MACHINE_START(SH73A0_DT, "Generic SH7
 	.map_io		= sh73a0_map_io,
 	.init_early	= sh73a0_init_delay,
 	.nr_irqs	= NR_IRQS_LEGACY,
-	.init_machine	= sh73a0_add_standard_devices_dt,
 	.dt_compat	= sh73a0_boards_compat_dt,
 MACHINE_END
 #endif /* CONFIG_USE_OF */
