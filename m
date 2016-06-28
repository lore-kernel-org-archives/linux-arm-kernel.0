From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 28 Jun 2016 12:30:25 +0200
Subject: [PATCH 06/92] clocksource/drivers/rockchip: Add the dynamic irq flag
 to the timer
In-Reply-To: <1467109911-11060-1-git-send-email-daniel.lezcano@linaro.org>
References: <577251A4.7030508@linaro.org>
 <1467109911-11060-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1467109911-11060-6-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Huang, Tao" <huangtao@rock-chips.com>

The rockchip timer is a broadcast timer. Add the CLOCK_EVT_FEAT_DYNIRQ flag
and set the cpumask to all possible cpus to save power by avoiding
unnecessary wakeups and IPIs.

Signed-off-by: Huang Tao <huangtao@rock-chips.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Heiko Stuebner <heiko@sntech.de>
Tested-by: Jianqun Xu <jay.xu@rock-chips.com>
Signed-off-by: Caesar Wang <wxt@rock-chips.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/rockchip_timer.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/rockchip_timer.c b/drivers/clocksource/rockchip_timer.c
index b991b28..b510863 100644
--- a/drivers/clocksource/rockchip_timer.c
+++ b/drivers/clocksource/rockchip_timer.c
@@ -150,12 +150,13 @@ static void __init rk_timer_init(struct device_node *np)
 	}
 
 	ce->name = TIMER_NAME;
-	ce->features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT;
+	ce->features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT |
+		       CLOCK_EVT_FEAT_DYNIRQ;
 	ce->set_next_event = rk_timer_set_next_event;
 	ce->set_state_shutdown = rk_timer_shutdown;
 	ce->set_state_periodic = rk_timer_set_periodic;
 	ce->irq = irq;
-	ce->cpumask = cpumask_of(0);
+	ce->cpumask = cpu_possible_mask;
 	ce->rating = 250;
 
 	rk_timer_interrupt_clear(ce);
-- 
1.9.1
