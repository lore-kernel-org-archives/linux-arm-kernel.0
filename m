From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon,  6 Jul 2015 15:39:19 +0530
Subject: [PATCH 2/2] clockevents/drivers/timer-sp804: Migrate to new
 'set-state' interface
In-Reply-To: <cover.1436177111.git.viresh.kumar@linaro.org>
References: <cover.1436177111.git.viresh.kumar@linaro.org>
Message-ID: <124d673f1f2fbcb8c5e0955eab94f0dc138980ac.1436177111.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Migrate timer-sp driver to the new 'set-state' interface provided by
clockevents core, the earlier 'set-mode' interface is marked obsolete
now.

This also enables us to implement callbacks for new states of clockevent
devices, for example: ONESHOT_STOPPED.

There are few more changes worth noticing:

- The clockevent device was disabled by writing: 'TIMER_CTRL_32BIT |
  TIMER_CTRL_IE' to ctrl register earlier. i.e. by un-setting the
  TIMER_CTRL_ENABLE bit. Its done by writing zero now and should have
  the same effect.

- For shutdown and resume we were writing the same value twice to the
  register (to disable the timer), which is fixed now.

- Switching to oneshot mode was divided into two parts earlier:
  - Firstly set_mode() was writing:
    'TIMER_CTRL_32BIT | TIMER_CTRL_IE | TIMER_CTRL_ONESHOT'
    to ctrl register (device not enabled yet)
  - Then sp804_set_next_event() was enabling the device by writing
    'readl(ctrl) | TIMER_CTRL_ENABLE' to the ctrl register. This was
    unnecessarily complicated.
  - Change this to: Stop device on set_state_oneshot and configure it in
    sp804_set_next_event().

Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Olof Johansson <olof@lixom.net>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/clocksource/timer-sp804.c | 54 +++++++++++++++++++--------------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/drivers/clocksource/timer-sp804.c b/drivers/clocksource/timer-sp804.c
index ca02503f17d1..5f45b9adef60 100644
--- a/drivers/clocksource/timer-sp804.c
+++ b/drivers/clocksource/timer-sp804.c
@@ -133,50 +133,50 @@ static irqreturn_t sp804_timer_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static void sp804_set_mode(enum clock_event_mode mode,
-	struct clock_event_device *evt)
+static inline void timer_shutdown(struct clock_event_device *evt)
 {
-	unsigned long ctrl = TIMER_CTRL_32BIT | TIMER_CTRL_IE;
+	writel(0, clkevt_base + TIMER_CTRL);
+}
 
-	writel(ctrl, clkevt_base + TIMER_CTRL);
+static int sp804_shutdown(struct clock_event_device *evt)
+{
+	timer_shutdown(evt);
+	return 0;
+}
 
-	switch (mode) {
-	case CLOCK_EVT_MODE_PERIODIC:
-		writel(clkevt_reload, clkevt_base + TIMER_LOAD);
-		ctrl |= TIMER_CTRL_PERIODIC | TIMER_CTRL_ENABLE;
-		break;
-
-	case CLOCK_EVT_MODE_ONESHOT:
-		/* period set, and timer enabled in 'next_event' hook */
-		ctrl |= TIMER_CTRL_ONESHOT;
-		break;
-
-	case CLOCK_EVT_MODE_UNUSED:
-	case CLOCK_EVT_MODE_SHUTDOWN:
-	default:
-		break;
-	}
+static int sp804_set_periodic(struct clock_event_device *evt)
+{
+	unsigned long ctrl = TIMER_CTRL_32BIT | TIMER_CTRL_IE |
+			     TIMER_CTRL_PERIODIC | TIMER_CTRL_ENABLE;
 
+	timer_shutdown(evt);
+	writel(clkevt_reload, clkevt_base + TIMER_LOAD);
 	writel(ctrl, clkevt_base + TIMER_CTRL);
+	return 0;
 }
 
 static int sp804_set_next_event(unsigned long next,
 	struct clock_event_device *evt)
 {
-	unsigned long ctrl = readl(clkevt_base + TIMER_CTRL);
+	unsigned long ctrl = TIMER_CTRL_32BIT | TIMER_CTRL_IE |
+			     TIMER_CTRL_ONESHOT | TIMER_CTRL_ENABLE;
 
 	writel(next, clkevt_base + TIMER_LOAD);
-	writel(ctrl | TIMER_CTRL_ENABLE, clkevt_base + TIMER_CTRL);
+	writel(ctrl, clkevt_base + TIMER_CTRL);
 
 	return 0;
 }
 
 static struct clock_event_device sp804_clockevent = {
-	.features       = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT |
-		CLOCK_EVT_FEAT_DYNIRQ,
-	.set_mode	= sp804_set_mode,
-	.set_next_event	= sp804_set_next_event,
-	.rating		= 300,
+	.features		= CLOCK_EVT_FEAT_PERIODIC |
+				  CLOCK_EVT_FEAT_ONESHOT |
+				  CLOCK_EVT_FEAT_DYNIRQ,
+	.set_state_shutdown	= sp804_shutdown,
+	.set_state_periodic	= sp804_set_periodic,
+	.set_state_oneshot	= sp804_shutdown,
+	.tick_resume		= sp804_shutdown,
+	.set_next_event		= sp804_set_next_event,
+	.rating			= 300,
 };
 
 static struct irqaction sp804_timer_irq = {
-- 
2.4.0
