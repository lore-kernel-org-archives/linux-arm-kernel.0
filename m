From: jszhang@marvell.com (Jisheng Zhang)
Date: Fri, 3 Jul 2015 22:30:47 +0800
Subject: [PATCH] clocksource: dw_apb_timer: add dynamic irq flag to the timer
Message-ID: <1435933847-2069-1-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit d2348fb6fdc6 ("tick: Dynamically set broadcast irq affinity")
adds one execllent feature CLOCK_EVT_FEAT_DYNIRQ to let the core set the
interrupt affinity of the broadcast interrupt to the cpu which has the
earliest expiry time. This patch adds CLOCK_EVT_FEAT_DYNIRQ flag to
avoid unnecessary wakeups and IPIs when the dw_apb_timer is used as
broadcast timer.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 drivers/clocksource/dw_apb_timer.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/dw_apb_timer.c b/drivers/clocksource/dw_apb_timer.c
index 35a8809..3381644 100644
--- a/drivers/clocksource/dw_apb_timer.c
+++ b/drivers/clocksource/dw_apb_timer.c
@@ -232,7 +232,8 @@ dw_apb_clockevent_init(int cpu, const char *name, unsigned rating,
 						       &dw_ced->ced);
 	dw_ced->ced.min_delta_ns = clockevent_delta2ns(5000, &dw_ced->ced);
 	dw_ced->ced.cpumask = cpumask_of(cpu);
-	dw_ced->ced.features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT;
+	dw_ced->ced.features = CLOCK_EVT_FEAT_PERIODIC |
+			       CLOCK_EVT_FEAT_ONESHOT | CLOCK_EVT_FEAT_DYNIRQ;
 	dw_ced->ced.set_mode = apbt_set_mode;
 	dw_ced->ced.set_next_event = apbt_next_event;
 	dw_ced->ced.irq = dw_ced->timer.irq;
-- 
2.1.4
