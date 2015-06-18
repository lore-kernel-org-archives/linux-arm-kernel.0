From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 18 Jun 2015 16:24:17 +0530
Subject: [PATCH 03/41] clocksource: clps711x: Migrate to new 'set-state'
 interface
In-Reply-To: <cover.1434622147.git.viresh.kumar@linaro.org>
References: <cover.1434622147.git.viresh.kumar@linaro.org>
Message-ID: <1d4c008b44c41c5ee8f124a93e520e566b621503.1434622147.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Migrate clps711x driver to the new 'set-state' interface provided by
clockevents core, the earlier 'set-mode' interface is marked obsolete
now.

This also enables us to implement callbacks for new states of clockevent
devices, for example: ONESHOT_STOPPED.

We weren't doing anything in the ->set_mode() callback. So, this patch
doesn't provide any set-state callbacks.

Cc: Alexander Shiyan <shc_work@mail.ru>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/clocksource/clps711x-timer.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/clocksource/clps711x-timer.c b/drivers/clocksource/clps711x-timer.c
index d83ec1f2fddc..cdd86e3525bb 100644
--- a/drivers/clocksource/clps711x-timer.c
+++ b/drivers/clocksource/clps711x-timer.c
@@ -61,11 +61,6 @@ static irqreturn_t clps711x_timer_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static void clps711x_clockevent_set_mode(enum clock_event_mode mode,
-					 struct clock_event_device *evt)
-{
-}
-
 static int __init _clps711x_clkevt_init(struct clk *clock, void __iomem *base,
 					unsigned int irq)
 {
@@ -91,7 +86,6 @@ static int __init _clps711x_clkevt_init(struct clk *clock, void __iomem *base,
 	clkevt->name = "clps711x-clockevent";
 	clkevt->rating = 300;
 	clkevt->features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_C3STOP;
-	clkevt->set_mode = clps711x_clockevent_set_mode;
 	clkevt->cpumask = cpumask_of(0);
 	clockevents_config_and_register(clkevt, HZ, 0, 0);
 
-- 
2.4.0
