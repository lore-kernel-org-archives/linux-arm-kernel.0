From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 10 Dec 2013 20:16:10 +0100
Subject: [PATCH 4/6] clocksource: sunxi: Stop timer from ticking before
 enabling interrupts
In-Reply-To: <1386702972-25565-1-git-send-email-daniel.lezcano@linaro.org>
References: <52A767CB.3010501@linaro.org>
 <1386702972-25565-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1386702972-25565-4-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Zyngier <marc.zyngier@arm.com>

The sun4i timer can still be ticking when we enable the interrupt.
If another timer is actually used (A7 architected timer, for example),
odds are that the interrupt will eventually fire with the event_handler
pointer being NULL.

The obvious fix it to stop the timer before registering the interrupt.

Observed and tested on sun7i (cubietruck).

Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/sun4i_timer.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clocksource/sun4i_timer.c b/drivers/clocksource/sun4i_timer.c
index 2fb4695..a4f6119 100644
--- a/drivers/clocksource/sun4i_timer.c
+++ b/drivers/clocksource/sun4i_timer.c
@@ -179,6 +179,9 @@ static void __init sun4i_timer_init(struct device_node *node)
 	writel(TIMER_CTL_CLK_SRC(TIMER_CTL_CLK_SRC_OSC24M),
 	       timer_base + TIMER_CTL_REG(0));
 
+	/* Make sure timer is stopped before playing with interrupts */
+	sun4i_clkevt_time_stop(0);
+
 	ret = setup_irq(irq, &sun4i_timer_irq);
 	if (ret)
 		pr_warn("failed to setup irq %d\n", irq);
-- 
1.7.9.5
