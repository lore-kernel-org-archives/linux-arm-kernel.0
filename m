From: balbi@ti.com (Felipe Balbi)
Date: Tue, 6 Oct 2015 12:01:58 -0500
Subject: [PATCH 02/11] arm: omap2: timer: add a gptimer argument to
 sync32k_timer_init()
In-Reply-To: <1444150927-14771-1-git-send-email-balbi@ti.com>
References: <1444150927-14771-1-git-send-email-balbi@ti.com>
Message-ID: <1444150927-14771-3-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

as it turns out, __omap_gptimer_init() and
__omap_sync32k_timer_init() are essentially
the same thing, but __omap_gptimer_init() wants
to always use gptimer.

Instead of forcing all those devices to pass
a use_gptimer cmdline argument, we add a new
function argument to __omap_sync32k_timer_init()
in preparation to deleting __omap_gptimer_init().

On a follow-up patch, we will remove uses of
__omap_gptimer_init() and replace them with
__omap_sync32k_timer_init() and pass the last
argument as true.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap2/timer.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index 23e58ea6a171..f53ed049d710 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -604,14 +604,14 @@ static void __init __omap_gptimer_init(int clkev_nr, const char *clkev_src,
 
 static void __init __omap_sync32k_timer_init(int clkev_nr, const char *clkev_src,
 		const char *clkev_prop, int clksrc_nr, const char *clksrc_src,
-		const char *clksrc_prop)
+		const char *clksrc_prop, bool gptimer)
 {
 	omap_clk_init();
 	omap_dmtimer_init();
 	omap2_gp_clockevent_init(clkev_nr, clkev_src, clkev_prop);
 
 	/* Enable the use of clocksource="gp_timer" kernel parameter */
-	if (use_gptimer_clksrc)
+	if (use_gptimer_clksrc || gptimer)
 		omap2_gptimer_clocksource_init(clksrc_nr, clksrc_src,
 						clksrc_prop);
 	else
@@ -622,7 +622,7 @@ static void __init __omap_sync32k_timer_init(int clkev_nr, const char *clkev_src
 void __init omap2_sync32k_timer_init(void)
 {
 	__omap_sync32k_timer_init(1, "timer_32k_ck", "ti,timer-alwon",
-			2, "timer_sys_ck", NULL);
+			2, "timer_sys_ck", NULL, false);
 }
 #endif /* CONFIG_ARCH_OMAP2 */
 
@@ -630,13 +630,13 @@ void __init omap2_sync32k_timer_init(void)
 void __init omap3_sync32k_timer_init(void)
 {
 	__omap_sync32k_timer_init(1, "timer_32k_ck", "ti,timer-alwon",
-			2, "timer_sys_ck", NULL);
+			2, "timer_sys_ck", NULL, false);
 }
 
 void __init omap3_secure_sync32k_timer_init(void)
 {
 	__omap_sync32k_timer_init(12, "secure_32k_fck", "ti,timer-secure",
-			2, "timer_sys_ck", NULL);
+			2, "timer_sys_ck", NULL, false);
 }
 #endif /* CONFIG_ARCH_OMAP3 */
 
@@ -653,7 +653,7 @@ void __init omap3_gptimer_timer_init(void)
 static void __init omap4_sync32k_timer_init(void)
 {
 	__omap_sync32k_timer_init(1, "timer_32k_ck", "ti,timer-alwon",
-			       2, "sys_clkin_ck", NULL);
+			2, "sys_clkin_ck", NULL, false);
 }
 
 void __init omap4_local_timer_init(void)
-- 
2.5.3
