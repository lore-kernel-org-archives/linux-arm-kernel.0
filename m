From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 17 Jul 2015 10:41:09 +0530
Subject: [PATCH 15/18] ARM/SPEAr/time: Migrate to new 'set-state' interface
In-Reply-To: <cover.1437101996.git.viresh.kumar@linaro.org>
References: <cover.1437101996.git.viresh.kumar@linaro.org>
Message-ID: <7639c0b8b3d5e061253936ed5279ff674be238cb.1437101996.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Migrate SPEAr driver to the new 'set-state' interface provided by
clockevents core, the earlier 'set-mode' interface is marked obsolete
now.

This also enables us to implement callbacks for new states of clockevent
devices, for example: ONESHOT_STOPPED.

Also kill the unnecessary forward declaration of set-mode routine by
moving 'struct clock_event_device clkevt' towards the bottom of the file.

Cc: Shiraz Hashim <shiraz.linux.kernel@gmail.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm/mach-spear/time.c | 89 ++++++++++++++++++++++++++--------------------
 1 file changed, 50 insertions(+), 39 deletions(-)

diff --git a/arch/arm/mach-spear/time.c b/arch/arm/mach-spear/time.c
index 26fda4ed4d51..94342a0966e3 100644
--- a/arch/arm/mach-spear/time.c
+++ b/arch/arm/mach-spear/time.c
@@ -66,8 +66,6 @@
 static __iomem void *gpt_base;
 static struct clk *gpt_clk;
 
-static void clockevent_set_mode(enum clock_event_mode mode,
-				struct clock_event_device *clk_event_dev);
 static int clockevent_next_event(unsigned long evt,
 				 struct clock_event_device *clk_event_dev);
 
@@ -95,54 +93,67 @@ static void __init spear_clocksource_init(void)
 		200, 16, clocksource_mmio_readw_up);
 }
 
-static struct clock_event_device clkevt = {
-	.name = "tmr0",
-	.features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
-	.set_mode = clockevent_set_mode,
-	.set_next_event = clockevent_next_event,
-	.shift = 0,	/* to be computed */
-};
+static inline void timer_shutdown(struct clock_event_device *evt)
+{
+	u16 val = readw(gpt_base + CR(CLKEVT));
+
+	/* stop the timer */
+	val &= ~CTRL_ENABLE;
+	writew(val, gpt_base + CR(CLKEVT));
+}
+
+static int spear_shutdown(struct clock_event_device *evt)
+{
+	timer_shutdown(evt);
+
+	return 0;
+}
+
+static int spear_set_oneshot(struct clock_event_device *evt)
+{
+	u16 val;
 
-static void clockevent_set_mode(enum clock_event_mode mode,
-				struct clock_event_device *clk_event_dev)
+	/* stop the timer */
+	timer_shutdown(evt);
+
+	val = readw(gpt_base + CR(CLKEVT));
+	val |= CTRL_ONE_SHOT;
+	writew(val, gpt_base + CR(CLKEVT));
+
+	return 0;
+}
+
+static int spear_set_periodic(struct clock_event_device *evt)
 {
 	u32 period;
 	u16 val;
 
 	/* stop the timer */
+	timer_shutdown(evt);
+
+	period = clk_get_rate(gpt_clk) / HZ;
+	period >>= CTRL_PRESCALER16;
+	writew(period, gpt_base + LOAD(CLKEVT));
+
 	val = readw(gpt_base + CR(CLKEVT));
-	val &= ~CTRL_ENABLE;
+	val &= ~CTRL_ONE_SHOT;
+	val |= CTRL_ENABLE | CTRL_INT_ENABLE;
 	writew(val, gpt_base + CR(CLKEVT));
 
-	switch (mode) {
-	case CLOCK_EVT_MODE_PERIODIC:
-		period = clk_get_rate(gpt_clk) / HZ;
-		period >>= CTRL_PRESCALER16;
-		writew(period, gpt_base + LOAD(CLKEVT));
-
-		val = readw(gpt_base + CR(CLKEVT));
-		val &= ~CTRL_ONE_SHOT;
-		val |= CTRL_ENABLE | CTRL_INT_ENABLE;
-		writew(val, gpt_base + CR(CLKEVT));
-
-		break;
-	case CLOCK_EVT_MODE_ONESHOT:
-		val = readw(gpt_base + CR(CLKEVT));
-		val |= CTRL_ONE_SHOT;
-		writew(val, gpt_base + CR(CLKEVT));
-
-		break;
-	case CLOCK_EVT_MODE_UNUSED:
-	case CLOCK_EVT_MODE_SHUTDOWN:
-	case CLOCK_EVT_MODE_RESUME:
-
-		break;
-	default:
-		pr_err("Invalid mode requested\n");
-		break;
-	}
+	return 0;
 }
 
+static struct clock_event_device clkevt = {
+	.name = "tmr0",
+	.features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
+	.set_state_shutdown = spear_shutdown,
+	.set_state_periodic = spear_set_periodic,
+	.set_state_oneshot = spear_set_oneshot,
+	.tick_resume = spear_shutdown,
+	.set_next_event = clockevent_next_event,
+	.shift = 0,	/* to be computed */
+};
+
 static int clockevent_next_event(unsigned long cycles,
 				 struct clock_event_device *clk_event_dev)
 {
-- 
2.4.0
