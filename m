From: balbi@ti.com (Felipe Balbi)
Date: Tue, 6 Oct 2015 12:02:02 -0500
Subject: [PATCH 06/11] arm: omap2: timer: always call clocksource_of_init()
 when DT
In-Reply-To: <1444150927-14771-1-git-send-email-balbi@ti.com>
References: <1444150927-14771-1-git-send-email-balbi@ti.com>
Message-ID: <1444150927-14771-7-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If booting with DT, let's make sure to always
call clocksource_of_init() as this will make
it easier to move timer code to drivers/clocksource
in the future.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap2/timer.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index dcc0f032e717..b523426f38a5 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -496,6 +496,9 @@ void __init omap_sync32k_timer_init(void)
 {
 	__omap_sync32k_timer_init(1, "timer_32k_ck", "ti,timer-alwon",
 			2, "timer_sys_ck", NULL, false);
+
+	if (of_have_populated_dt())
+		clocksource_of_init();
 }
 
 #if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_SOC_AM43XX)
@@ -519,7 +522,6 @@ void __init omap3_gptimer_timer_init(void)
 void __init omap4_local_timer_init(void)
 {
 	omap_sync32k_timer_init();
-	clocksource_of_init();
 }
 #endif
 
@@ -640,10 +642,8 @@ sysclk1_based:
 
 void __init omap5_realtime_timer_init(void)
 {
-	omap_sync32k_timer_init();
 	realtime_counter_init();
-
-	clocksource_of_init();
+	omap_sync32k_timer_init();
 }
 #endif /* CONFIG_SOC_OMAP5 || CONFIG_SOC_DRA7XX */
 
-- 
2.5.3
