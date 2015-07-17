From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 17 Jul 2015 10:40:55 +0530
Subject: [PATCH 01/18] ARM/smp_twd: Migrate to new 'set-state' interface
In-Reply-To: <cover.1437101996.git.viresh.kumar@linaro.org>
References: <cover.1437101996.git.viresh.kumar@linaro.org>
Message-ID: <5e2535710ee3fa2807406ea75eb4381f85b29b0b.1437101996.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Migrate smp_twd driver to the new 'set-state' interface provided by
clockevents core, the earlier 'set-mode' interface is marked obsolete
now.

This also enables us to implement callbacks for new states of clockevent
devices, for example: ONESHOT_STOPPED.

Cc: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm/kernel/smp_twd.c | 48 +++++++++++++++++++++++++----------------------
 1 file changed, 26 insertions(+), 22 deletions(-)

diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
index 172c6a05d27f..e9035cda1485 100644
--- a/arch/arm/kernel/smp_twd.c
+++ b/arch/arm/kernel/smp_twd.c
@@ -36,29 +36,30 @@ static DEFINE_PER_CPU(bool, percpu_setup_called);
 static struct clock_event_device __percpu *twd_evt;
 static int twd_ppi;
 
-static void twd_set_mode(enum clock_event_mode mode,
-			struct clock_event_device *clk)
+static int twd_shutdown(struct clock_event_device *clk)
 {
-	unsigned long ctrl;
-
-	switch (mode) {
-	case CLOCK_EVT_MODE_PERIODIC:
-		ctrl = TWD_TIMER_CONTROL_ENABLE | TWD_TIMER_CONTROL_IT_ENABLE
-			| TWD_TIMER_CONTROL_PERIODIC;
-		writel_relaxed(DIV_ROUND_CLOSEST(twd_timer_rate, HZ),
-			twd_base + TWD_TIMER_LOAD);
-		break;
-	case CLOCK_EVT_MODE_ONESHOT:
-		/* period set, and timer enabled in 'next_event' hook */
-		ctrl = TWD_TIMER_CONTROL_IT_ENABLE | TWD_TIMER_CONTROL_ONESHOT;
-		break;
-	case CLOCK_EVT_MODE_UNUSED:
-	case CLOCK_EVT_MODE_SHUTDOWN:
-	default:
-		ctrl = 0;
-	}
+	writel_relaxed(0, twd_base + TWD_TIMER_CONTROL);
+	return 0;
+}
 
+static int twd_set_oneshot(struct clock_event_device *clk)
+{
+	/* period set, and timer enabled in 'next_event' hook */
+	writel_relaxed(TWD_TIMER_CONTROL_IT_ENABLE | TWD_TIMER_CONTROL_ONESHOT,
+		       twd_base + TWD_TIMER_CONTROL);
+	return 0;
+}
+
+static int twd_set_periodic(struct clock_event_device *clk)
+{
+	unsigned long ctrl = TWD_TIMER_CONTROL_ENABLE |
+			     TWD_TIMER_CONTROL_IT_ENABLE |
+			     TWD_TIMER_CONTROL_PERIODIC;
+
+	writel_relaxed(DIV_ROUND_CLOSEST(twd_timer_rate, HZ),
+		       twd_base + TWD_TIMER_LOAD);
 	writel_relaxed(ctrl, twd_base + TWD_TIMER_CONTROL);
+	return 0;
 }
 
 static int twd_set_next_event(unsigned long evt,
@@ -94,7 +95,7 @@ static void twd_timer_stop(void)
 {
 	struct clock_event_device *clk = raw_cpu_ptr(twd_evt);
 
-	twd_set_mode(CLOCK_EVT_MODE_UNUSED, clk);
+	twd_shutdown(clk);
 	disable_percpu_irq(clk->irq);
 }
 
@@ -296,7 +297,10 @@ static void twd_timer_setup(void)
 	clk->features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT |
 			CLOCK_EVT_FEAT_C3STOP;
 	clk->rating = 350;
-	clk->set_mode = twd_set_mode;
+	clk->set_state_shutdown = twd_shutdown;
+	clk->set_state_periodic = twd_set_periodic;
+	clk->set_state_oneshot = twd_set_oneshot;
+	clk->tick_resume = twd_shutdown;
 	clk->set_next_event = twd_set_next_event;
 	clk->irq = twd_ppi;
 	clk->cpumask = cpumask_of(cpu);
-- 
2.4.0
