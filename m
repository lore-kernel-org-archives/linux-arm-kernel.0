From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 30 Dec 2013 11:19:20 +0100
Subject: [PATCH 01/20] clockevent: sun4i: Fill the irq field in the clockevent
 structure
In-Reply-To: <52C1479E.80808@linaro.org>
References: <52C1479E.80808@linaro.org>
Message-ID: <1388398779-11222-1-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Maxime Ripard <maxime.ripard@free-electrons.com>

The clock event structure irq field was not filled previously to the
interrupt we're using.

This was resulting in the timer not being used at all when using a
configuration with SMP enabled on a system with several CPUs, and with
the cpumask set to the cpu_possible_mask.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/clocksource/sun4i_timer.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clocksource/sun4i_timer.c b/drivers/clocksource/sun4i_timer.c
index 2fb4695..a7f492e 100644
--- a/drivers/clocksource/sun4i_timer.c
+++ b/drivers/clocksource/sun4i_timer.c
@@ -188,6 +188,7 @@ static void __init sun4i_timer_init(struct device_node *node)
 	writel(val | TIMER_IRQ_EN(0), timer_base + TIMER_IRQ_EN_REG);
 
 	sun4i_clockevent.cpumask = cpumask_of(0);
+	sun4i_clockevent.irq = irq;
 
 	clockevents_config_and_register(&sun4i_clockevent, rate,
 					TIMER_SYNC_TICKS, 0xffffffff);
-- 
1.7.9.5
