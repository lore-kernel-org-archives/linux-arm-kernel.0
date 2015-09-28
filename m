From: balbi@ti.com (Felipe Balbi)
Date: Mon, 28 Sep 2015 13:25:44 -0500
Subject: [PATCH] arm: omap2: timer: always define omap4_local_timer_init
Message-ID: <1443464744-16561-1-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

omap4_local_timer_init() can be used by other
platforms as is. At least AM437x wants to use
it. Instead of making omap4-only and providing
a stub for builds without OMAP4, we can just
always define that function.

Reported-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap2/timer.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index a55655127ef2..f9028582e962 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -642,20 +642,11 @@ static OMAP_SYS_32K_TIMER_INIT(4, 1, "timer_32k_ck", "ti,timer-alwon",
 			       2, "sys_clkin_ck", NULL);
 #endif
 
-#ifdef CONFIG_ARCH_OMAP4
-#ifdef CONFIG_HAVE_ARM_TWD
 void __init omap4_local_timer_init(void)
 {
 	omap4_sync32k_timer_init();
 	clocksource_of_init();
 }
-#else
-void __init omap4_local_timer_init(void)
-{
-	omap4_sync32k_timer_init();
-}
-#endif /* CONFIG_HAVE_ARM_TWD */
-#endif /* CONFIG_ARCH_OMAP4 */
 
 #if defined(CONFIG_SOC_OMAP5) || defined(CONFIG_SOC_DRA7XX)
 void __init omap5_realtime_timer_init(void)
-- 
2.5.0.GIT
