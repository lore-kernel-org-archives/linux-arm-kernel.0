From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 13 Jan 2012 18:28:41 +0000
Subject: [PATCH v2 14/15] ARM: local timers: convert MSM to runtime
 registration interface
In-Reply-To: <1326479322-6033-1-git-send-email-marc.zyngier@arm.com>
References: <1326479322-6033-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1326479322-6033-15-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert the MSM timers to the runtime registration interface.

Cc: Stephen Boyd <sboyd@codeaurora.org>
Tested-by: David Brown <davidb@codeaurora.org>
Acked-by: David Brown <davidb@codeaurora.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/mach-msm/timer.c |   79 +++++++++++++++++++++++++--------------------
 1 files changed, 44 insertions(+), 35 deletions(-)

diff --git a/arch/arm/mach-msm/timer.c b/arch/arm/mach-msm/timer.c
index 11d0d8f..0b13bec 100644
--- a/arch/arm/mach-msm/timer.c
+++ b/arch/arm/mach-msm/timer.c
@@ -127,6 +127,45 @@ static struct clocksource msm_clocksource = {
 	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
 };
 
+#ifdef CONFIG_LOCAL_TIMERS
+static int __cpuinit msm_local_timer_setup(struct clock_event_device *evt)
+{
+	/* Use existing clock_event for cpu 0 */
+	if (!smp_processor_id())
+		return 0;
+
+	writel_relaxed(0, event_base + TIMER_ENABLE);
+	writel_relaxed(0, event_base + TIMER_CLEAR);
+	writel_relaxed(~0, event_base + TIMER_MATCH_VAL);
+	evt->irq = msm_clockevent.irq;
+	evt->name = "local_timer";
+	evt->features = msm_clockevent.features;
+	evt->rating = msm_clockevent.rating;
+	evt->set_mode = msm_timer_set_mode;
+	evt->set_next_event = msm_timer_set_next_event;
+	evt->shift = msm_clockevent.shift;
+	evt->mult = div_sc(GPT_HZ, NSEC_PER_SEC, evt->shift);
+	evt->max_delta_ns = clockevent_delta2ns(0xf0000000, evt);
+	evt->min_delta_ns = clockevent_delta2ns(4, evt);
+
+	*__this_cpu_ptr(msm_evt.percpu_evt) = evt;
+	clockevents_register_device(evt);
+	enable_percpu_irq(evt->irq, 0);
+	return 0;
+}
+
+static void msm_local_timer_stop(struct clock_event_device *evt)
+{
+	evt->set_mode(CLOCK_EVT_MODE_UNUSED, evt);
+	disable_percpu_irq(evt->irq);
+}
+
+static struct local_timer_ops msm_local_timer_ops __initdata = {
+	.setup	= msm_local_timer_setup,
+	.stop	= msm_local_timer_stop,
+};
+#endif /* CONFIG_LOCAL_TIMERS */
+
 static void __init msm_timer_init(void)
 {
 	struct clock_event_device *ce = &msm_clockevent;
@@ -173,8 +212,12 @@ static void __init msm_timer_init(void)
 		*__this_cpu_ptr(msm_evt.percpu_evt) = ce;
 		res = request_percpu_irq(ce->irq, msm_timer_interrupt,
 					 ce->name, msm_evt.percpu_evt);
-		if (!res)
+		if (!res) {
 			enable_percpu_irq(ce->irq, 0);
+#ifdef CONFIG_LOCAL_TIMERS
+			local_timer_register(&msm_local_timer_ops);
+#endif
+		}
 	} else {
 		msm_evt.evt = ce;
 		res = request_irq(ce->irq, msm_timer_interrupt,
@@ -191,40 +234,6 @@ err:
 		pr_err("clocksource_register failed\n");
 }
 
-#ifdef CONFIG_LOCAL_TIMERS
-int __cpuinit local_timer_setup(struct clock_event_device *evt)
-{
-	/* Use existing clock_event for cpu 0 */
-	if (!smp_processor_id())
-		return 0;
-
-	writel_relaxed(0, event_base + TIMER_ENABLE);
-	writel_relaxed(0, event_base + TIMER_CLEAR);
-	writel_relaxed(~0, event_base + TIMER_MATCH_VAL);
-	evt->irq = msm_clockevent.irq;
-	evt->name = "local_timer";
-	evt->features = msm_clockevent.features;
-	evt->rating = msm_clockevent.rating;
-	evt->set_mode = msm_timer_set_mode;
-	evt->set_next_event = msm_timer_set_next_event;
-	evt->shift = msm_clockevent.shift;
-	evt->mult = div_sc(GPT_HZ, NSEC_PER_SEC, evt->shift);
-	evt->max_delta_ns = clockevent_delta2ns(0xf0000000, evt);
-	evt->min_delta_ns = clockevent_delta2ns(4, evt);
-
-	*__this_cpu_ptr(msm_evt.percpu_evt) = evt;
-	clockevents_register_device(evt);
-	enable_percpu_irq(evt->irq, 0);
-	return 0;
-}
-
-void local_timer_stop(struct clock_event_device *evt)
-{
-	evt->set_mode(CLOCK_EVT_MODE_UNUSED, evt);
-	disable_percpu_irq(evt->irq);
-}
-#endif /* CONFIG_LOCAL_TIMERS */
-
 struct sys_timer msm_timer = {
 	.init = msm_timer_init
 };
-- 
1.7.7.1
