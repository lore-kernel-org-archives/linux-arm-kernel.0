From: marc.zyngier@arm.com (Marc Zyngier)
Date: Sat, 30 Nov 2013 12:53:15 +0000
Subject: [PATCH] ARM: sunxi: stop timer from ticking before enabling interrupts
Message-ID: <1385815995-15145-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The sun4i timer can still be ticking when we enable the interrupt.
If another timer is actually used (A7 architected timer, for example),
odds are that the interrupt will eventually fire with the event_handler
pointer being NULL.

The obvious fix it to stop the timer before registering the interrupt.

Observed and tested on sun7i (cubietruck).

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/clocksource/sun4i_timer.c | 3 +++
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
1.8.4.3
