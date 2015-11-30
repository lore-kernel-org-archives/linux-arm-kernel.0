From: tony@atomide.com (Tony Lindgren)
Date: Mon, 30 Nov 2015 08:26:28 -0800
Subject: [PATCH 1/2] ARM: OMAP2+: Initialize timers later with late_time_init
In-Reply-To: <1448900789-4034-1-git-send-email-tony@atomide.com>
References: <1448900789-4034-1-git-send-email-tony@atomide.com>
Message-ID: <1448900789-4034-2-git-send-email-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We don't need timers right away and initializing them later gives us few
nice things like interrupts and kmalloc. As the timers have a dependency
to the clock framework, we're better off initializing things later rather
than early if things go wrong. And this allows us to make the mux clock
driver needed for system timers into early_platform drivers.

Note that smp_prepare_cpus() will get called later on during the init so
we just need to local_irq_enable/disable for clocksource_probe().

Cc: Felipe Balbi <balbi@ti.com>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/timer.c | 46 +++++++++++++++++++++++++++++++++++++++------
 1 file changed, 40 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index b18ebbe..68bf482 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -478,36 +478,56 @@ static void __init __omap_sync32k_timer_init(int clkev_nr, const char *clkev_src
 	omap2_gp_clockevent_init(clkev_nr, clkev_src, clkev_prop);
 
 	/* Enable the use of clocksource="gp_timer" kernel parameter */
+	local_irq_disable();
 	if (use_gptimer_clksrc || gptimer)
 		omap2_gptimer_clocksource_init(clksrc_nr, clksrc_src,
 						clksrc_prop);
 	else
 		omap2_sync32k_clocksource_init();
+	local_irq_enable();
 }
 
-void __init omap_init_time(void)
+static void __init omap_init_time_late(void)
 {
 	__omap_sync32k_timer_init(1, "timer_32k_ck", "ti,timer-alwon",
 			2, "timer_sys_ck", NULL, false);
 
-	if (of_have_populated_dt())
+	if (of_have_populated_dt()) {
+		local_irq_disable();
 		clocksource_probe();
+		local_irq_enable();
+	}
+}
+
+void __init omap_init_time(void)
+{
+	late_time_init = omap_init_time_late;
 }
 
 #if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_SOC_AM43XX)
-void __init omap3_secure_sync32k_timer_init(void)
+static void __init omap3_secure_sync32k_timer_late_init(void)
 {
 	__omap_sync32k_timer_init(12, "secure_32k_fck", "ti,timer-secure",
 			2, "timer_sys_ck", NULL, false);
 }
+
+void __init omap3_secure_sync32k_timer_init(void)
+{
+	late_time_init = omap3_secure_sync32k_timer_late_init;
+}
 #endif /* CONFIG_ARCH_OMAP3 */
 
 #if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_SOC_AM33XX)
-void __init omap3_gptimer_timer_init(void)
+static void __init omap3_gptimer_late_init(void)
 {
 	__omap_sync32k_timer_init(2, "timer_sys_ck", NULL,
 			1, "timer_sys_ck", "ti,timer-alwon", true);
 }
+
+void __init omap3_gptimer_timer_init(void)
+{
+	late_time_init = omap3_gptimer_late_init;
+}
 #endif
 
 #if defined(CONFIG_ARCH_OMAP4) || defined(CONFIG_SOC_OMAP5) ||		\
@@ -518,10 +538,17 @@ static void __init omap4_sync32k_timer_init(void)
 			2, "sys_clkin_ck", NULL, false);
 }
 
-void __init omap4_local_timer_init(void)
+static void __init omap4_local_timer_late_init(void)
 {
 	omap4_sync32k_timer_init();
+	local_irq_disable();
 	clocksource_probe();
+	local_irq_enable();
+}
+
+void __init omap4_local_timer_init(void)
+{
+	late_time_init = omap4_local_timer_late_init;
 }
 #endif
 
@@ -640,12 +667,19 @@ sysclk1_based:
 #endif
 }
 
-void __init omap5_realtime_timer_init(void)
+static void __init omap5_realtime_timer_late_init(void)
 {
 	omap4_sync32k_timer_init();
 	realtime_counter_init();
 
+	local_irq_disable();
 	clocksource_probe();
+	local_irq_enable();
+}
+
+void __init omap5_realtime_timer_init(void)
+{
+	late_time_init = omap5_realtime_timer_late_init;
 }
 #endif /* CONFIG_SOC_OMAP5 || CONFIG_SOC_DRA7XX */
 
-- 
2.6.2
