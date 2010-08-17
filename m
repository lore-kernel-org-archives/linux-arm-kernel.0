From: tony@atomide.com (Tony Lindgren)
Date: Tue, 17 Aug 2010 13:33:23 +0300
Subject: [PATCH] omap: Fix SMP on UP initialization for multi-omap
Message-ID: <mailman.227.1283455814.27306.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix SMP on UP initialization for multi-omap.

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/omap-smp.c b/arch/arm/mach-omap2/omap-smp.c
index 9e9f70e..3695232 100644
--- a/arch/arm/mach-omap2/omap-smp.c
+++ b/arch/arm/mach-omap2/omap-smp.c
@@ -22,6 +22,7 @@
 
 #include <asm/cacheflush.h>
 #include <asm/localtimer.h>
+#include <asm/smp_plat.h>
 #include <asm/smp_scu.h>
 #include <mach/hardware.h>
 #include <mach/omap4-common.h>
@@ -114,11 +115,15 @@ void __init smp_init_cpus(void)
 {
 	unsigned int i, ncores;
 
-	/* Never released */
-	scu_base = ioremap(OMAP44XX_SCU_BASE, SZ_256);
-	BUG_ON(!scu_base);
+	if (!smp_cpu()) {
+		ncores = 1;
+	} else {
+		/* Never released */
+		scu_base = ioremap(OMAP44XX_SCU_BASE, SZ_256);
+		BUG_ON(!scu_base);
 
-	ncores = get_core_count();
+		ncores = get_core_count();
+	}
 
 	for (i = 0; i < ncores; i++)
 		set_cpu_possible(i, true);
diff --git a/arch/arm/mach-omap2/timer-gp.c b/arch/arm/mach-omap2/timer-gp.c
index 74fbed8..a21b4a4 100644
--- a/arch/arm/mach-omap2/timer-gp.c
+++ b/arch/arm/mach-omap2/timer-gp.c
@@ -37,6 +37,7 @@
 #include <linux/clockchips.h>
 
 #include <asm/mach/time.h>
+#include <asm/smp_plat.h>
 #include <plat/dmtimer.h>
 #include <asm/localtimer.h>
 
@@ -228,8 +229,10 @@ static void __init omap2_gp_clocksource_init(void)
 static void __init omap2_gp_timer_init(void)
 {
 #ifdef CONFIG_LOCAL_TIMERS
-	twd_base = ioremap(OMAP44XX_LOCAL_TWD_BASE, SZ_256);
-	BUG_ON(!twd_base);
+	if (!smp_cpu()) {
+		twd_base = ioremap(OMAP44XX_LOCAL_TWD_BASE, SZ_256);
+		BUG_ON(!twd_base);
+	}
 #endif
 	omap_dm_timer_init();
 

--SWTRyWv/ijrBap1m--
