From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 30 Dec 2013 11:19:21 +0100
Subject: [PATCH 02/20] clocksource: sun4i: Change CPU mask to cpu_possible_mask
In-Reply-To: <1388398779-11222-1-git-send-email-daniel.lezcano@linaro.org>
References: <52C1479E.80808@linaro.org>
 <1388398779-11222-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1388398779-11222-2-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Maxime Ripard <maxime.ripard@free-electrons.com>

The interrupt for the timer is a shared processor interrupt, so any CPU
found in the system can handle it. Switch to our cpumask to
cpu_possible_mask instead of cpumask_of(0).

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/clocksource/sun4i_timer.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/sun4i_timer.c b/drivers/clocksource/sun4i_timer.c
index a7f492e..6a76b4e 100644
--- a/drivers/clocksource/sun4i_timer.c
+++ b/drivers/clocksource/sun4i_timer.c
@@ -187,7 +187,7 @@ static void __init sun4i_timer_init(struct device_node *node)
 	val = readl(timer_base + TIMER_IRQ_EN_REG);
 	writel(val | TIMER_IRQ_EN(0), timer_base + TIMER_IRQ_EN_REG);
 
-	sun4i_clockevent.cpumask = cpumask_of(0);
+	sun4i_clockevent.cpumask = cpu_possible_mask;
 	sun4i_clockevent.irq = irq;
 
 	clockevents_config_and_register(&sun4i_clockevent, rate,
-- 
1.7.9.5
