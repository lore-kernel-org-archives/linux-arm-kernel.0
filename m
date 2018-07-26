From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 26 Jul 2018 12:15:24 +0200
Subject: [PATCH 1/7] clocksource/drivers: Set clockevent device cpumask to
 cpu_possible_mask
In-Reply-To: <014f94f9-54d4-1ee0-aa89-67ca5d221989@free.fr>
References: <014f94f9-54d4-1ee0-aa89-67ca5d221989@free.fr>
Message-ID: <1532600131-28168-1-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sudeep Holla <sudeep.holla@arm.com>

Currently, quite a few clockevent devices have cpumask set to
cpu_all_mask which should be fine. However, cpu_possible_mask is more
accurate and if there are any other clockevent devices in the system
which have cpumask set to cpu_possible_mask, then having cpu_all_mask
may result in issues (mostly boot hang with forever loops in
clockevents_notify_released).

So, lets replace all the clockevent device cpu_all_mask to
cpu_possible_mask in order to prevent above mentioned possible issue.

Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>
Cc: Santosh Shilimkar <ssantosh@kernel.org>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/tegra20_timer.c   | 2 +-
 drivers/clocksource/timer-atcpit100.c | 2 +-
 drivers/clocksource/timer-keystone.c  | 2 +-
 drivers/clocksource/zevio-timer.c     | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clocksource/tegra20_timer.c b/drivers/clocksource/tegra20_timer.c
index c337a81..dabf0a1 100644
--- a/drivers/clocksource/tegra20_timer.c
+++ b/drivers/clocksource/tegra20_timer.c
@@ -230,7 +230,7 @@ static int __init tegra20_init_timer(struct device_node *np)
 		return ret;
 	}
 
-	tegra_clockevent.cpumask = cpu_all_mask;
+	tegra_clockevent.cpumask = cpu_possible_mask;
 	tegra_clockevent.irq = tegra_timer_irq.irq;
 	clockevents_config_and_register(&tegra_clockevent, 1000000,
 					0x1, 0x1fffffff);
diff --git a/drivers/clocksource/timer-atcpit100.c b/drivers/clocksource/timer-atcpit100.c
index 5e23d7b..b4bd2f5 100644
--- a/drivers/clocksource/timer-atcpit100.c
+++ b/drivers/clocksource/timer-atcpit100.c
@@ -185,7 +185,7 @@ static struct timer_of to = {
 		.set_state_oneshot = atcpit100_clkevt_set_oneshot,
 		.tick_resume = atcpit100_clkevt_shutdown,
 		.set_next_event = atcpit100_clkevt_next_event,
-		.cpumask = cpu_all_mask,
+		.cpumask = cpu_possible_mask,
 	},
 
 	.of_irq = {
diff --git a/drivers/clocksource/timer-keystone.c b/drivers/clocksource/timer-keystone.c
index 0eee032..f5b2eda 100644
--- a/drivers/clocksource/timer-keystone.c
+++ b/drivers/clocksource/timer-keystone.c
@@ -211,7 +211,7 @@ static int __init keystone_timer_init(struct device_node *np)
 	event_dev->set_state_shutdown = keystone_shutdown;
 	event_dev->set_state_periodic = keystone_set_periodic;
 	event_dev->set_state_oneshot = keystone_shutdown;
-	event_dev->cpumask = cpu_all_mask;
+	event_dev->cpumask = cpu_possible_mask;
 	event_dev->owner = THIS_MODULE;
 	event_dev->name = TIMER_NAME;
 	event_dev->irq = irq;
diff --git a/drivers/clocksource/zevio-timer.c b/drivers/clocksource/zevio-timer.c
index a6a0338..f746893 100644
--- a/drivers/clocksource/zevio-timer.c
+++ b/drivers/clocksource/zevio-timer.c
@@ -162,7 +162,7 @@ static int __init zevio_timer_add(struct device_node *node)
 		timer->clkevt.set_state_oneshot = zevio_timer_set_oneshot;
 		timer->clkevt.tick_resume	= zevio_timer_set_oneshot;
 		timer->clkevt.rating		= 200;
-		timer->clkevt.cpumask		= cpu_all_mask;
+		timer->clkevt.cpumask		= cpu_possible_mask;
 		timer->clkevt.features		= CLOCK_EVT_FEAT_ONESHOT;
 		timer->clkevt.irq		= irqnr;
 
-- 
2.7.4
