From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 23 Dec 2015 16:59:13 +0530
Subject: [PATCH 2/3] clockevents/arm_global_timer: Implement
 ->set_state_oneshot_stopped()
In-Reply-To: <cover.1450869375.git.viresh.kumar@linaro.org>
References: <cover.1450869375.git.viresh.kumar@linaro.org>
Message-ID: <e50fc01132e229071993d674c22e55cc14e30ffa.1450869375.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

set_state_oneshot_stopped() is called by the clkevt core, when the next
event is required at an expiry time of 'KTIME_MAX'. This normally
happens with NO_HZ_{IDLE|FULL} in both LOWRES/HIGHRES modes.

This patch makes the clockevent device to stop on such an event, to
avoid spurious interrupts, as explained by: commit 8fff52fd5093
("clockevents: Introduce CLOCK_EVT_STATE_ONESHOT_STOPPED state").

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/clocksource/arm_global_timer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clocksource/arm_global_timer.c b/drivers/clocksource/arm_global_timer.c
index a2cb6fae9295..801cfe5833c1 100644
--- a/drivers/clocksource/arm_global_timer.c
+++ b/drivers/clocksource/arm_global_timer.c
@@ -174,6 +174,7 @@ static int gt_clockevents_init(struct clock_event_device *clk)
 	clk->set_state_shutdown = gt_clockevent_shutdown;
 	clk->set_state_periodic = gt_clockevent_set_periodic;
 	clk->set_state_oneshot = gt_clockevent_shutdown;
+	clk->set_state_oneshot_stopped = gt_clockevent_shutdown;
 	clk->set_next_event = gt_clockevent_set_next_event;
 	clk->cpumask = cpumask_of(cpu);
 	clk->rating = 300;
-- 
2.7.0.rc1.186.g94414c4
