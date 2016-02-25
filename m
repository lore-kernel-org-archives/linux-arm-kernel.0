From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 25 Feb 2016 14:37:17 +0100
Subject: [PATCH 9/9] clockevents/drivers/exynos_mct: Implement
 ->set_state_oneshot_stopped()
In-Reply-To: <1456407438-6131-1-git-send-email-daniel.lezcano@linaro.org>
References: <56CF00F6.9010301@linaro.org>
 <1456407438-6131-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1456407438-6131-9-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Viresh Kumar <viresh.kumar@linaro.org>

set_state_oneshot_stopped() is called by the clkevt core, when the next
event is required at an expiry time of 'KTIME_MAX'. This normally
happens with NO_HZ_{IDLE|FULL} in both LOWRES/HIGHRES modes.

This patch makes the clockevent device to stop on such an event, to
avoid spurious interrupts, as explained by: commit 8fff52fd5093
("clockevents: Introduce CLOCK_EVT_STATE_ONESHOT_STOPPED state").

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/exynos_mct.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
index ff44082..be09bc0 100644
--- a/drivers/clocksource/exynos_mct.c
+++ b/drivers/clocksource/exynos_mct.c
@@ -313,6 +313,7 @@ static struct clock_event_device mct_comp_device = {
 	.set_state_periodic	= mct_set_state_periodic,
 	.set_state_shutdown	= mct_set_state_shutdown,
 	.set_state_oneshot	= mct_set_state_shutdown,
+	.set_state_oneshot_stopped = mct_set_state_shutdown,
 	.tick_resume		= mct_set_state_shutdown,
 };
 
@@ -452,6 +453,7 @@ static int exynos4_local_timer_setup(struct mct_clock_event_device *mevt)
 	evt->set_state_periodic = set_state_periodic;
 	evt->set_state_shutdown = set_state_shutdown;
 	evt->set_state_oneshot = set_state_shutdown;
+	evt->set_state_oneshot_stopped = set_state_shutdown;
 	evt->tick_resume = set_state_shutdown;
 	evt->features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT;
 	evt->rating = 450;
-- 
1.9.1
