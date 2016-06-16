From: t-kristo@ti.com (Tero Kristo)
Date: Thu, 16 Jun 2016 15:25:18 +0300
Subject: [PATCH] ARM: OMAP2+: timer: add probe for clocksources
Message-ID: <1466079918-6810-1-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A few platforms are currently missing clocksource_probe() completely
in their time_init functionality. On OMAP3430 for example, this is
causing cpuidle to be pretty much dead, as the counter32k is not
going to be registered and instead a gptimer is used as a clocksource.
This will tick in periodic mode, preventing any deeper idle states.

While here, also drop one unnecessary check for populated DT before
existing clocksource_probe() call.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/timer.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index 5b385bb..cb9497a 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -496,8 +496,7 @@ void __init omap_init_time(void)
 	__omap_sync32k_timer_init(1, "timer_32k_ck", "ti,timer-alwon",
 			2, "timer_sys_ck", NULL, false);
 
-	if (of_have_populated_dt())
-		clocksource_probe();
+	clocksource_probe();
 }
 
 #if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_SOC_AM43XX)
@@ -505,6 +504,8 @@ void __init omap3_secure_sync32k_timer_init(void)
 {
 	__omap_sync32k_timer_init(12, "secure_32k_fck", "ti,timer-secure",
 			2, "timer_sys_ck", NULL, false);
+
+	clocksource_probe();
 }
 #endif /* CONFIG_ARCH_OMAP3 */
 
@@ -513,6 +514,8 @@ void __init omap3_gptimer_timer_init(void)
 {
 	__omap_sync32k_timer_init(2, "timer_sys_ck", NULL,
 			1, "timer_sys_ck", "ti,timer-alwon", true);
+
+	clocksource_probe();
 }
 #endif
 
-- 
1.9.1
