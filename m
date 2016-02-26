From: jszhang@marvell.com (Jisheng Zhang)
Date: Fri, 26 Feb 2016 17:45:57 +0800
Subject: [PATCH] clockevents/drivers/dw_apb_timer: Implement
 ->set_state_oneshot_stopped()
Message-ID: <1456479957-1561-1-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The dw_apb_timer only "supports PERIODIC mode and their drivers emulate
ONESHOT over that" as described in commit 8fff52fd5093 ("clockevents:
Introduce CLOCK_EVT_STATE_ONESHOT_STOPPED state").

Inspired by Viresh, I think the dw_apb_timer also needs to implement
the set_state_oneshot_stopped() which is called by the clkevt core,
when the next event is required at an expiry time of 'KTIME_MAX'. This
normally happens with NO_HZ_{IDLE|FULL} in both LOWRES/HIGHRES modes.

This patch makes the clockevent device to stop on such an event, to
avoid spurious interrupts, as explained by the above commit.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 drivers/clocksource/dw_apb_timer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clocksource/dw_apb_timer.c b/drivers/clocksource/dw_apb_timer.c
index 6334526..797505a 100644
--- a/drivers/clocksource/dw_apb_timer.c
+++ b/drivers/clocksource/dw_apb_timer.c
@@ -264,6 +264,7 @@ dw_apb_clockevent_init(int cpu, const char *name, unsigned rating,
 	dw_ced->ced.set_state_shutdown = apbt_shutdown;
 	dw_ced->ced.set_state_periodic = apbt_set_periodic;
 	dw_ced->ced.set_state_oneshot = apbt_set_oneshot;
+	dw_ced->ced.set_state_oneshot_stopped = apbt_shutdown;
 	dw_ced->ced.tick_resume = apbt_resume;
 	dw_ced->ced.set_next_event = apbt_next_event;
 	dw_ced->ced.irq = dw_ced->timer.irq;
-- 
2.7.0
