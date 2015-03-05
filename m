From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu,  5 Mar 2015 11:20:52 +0100
Subject: [PATCH v3 1/5] clocksource: sun5i: Switch to request_irq
In-Reply-To: <1425550856-12928-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1425550856-12928-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1425550856-12928-2-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current code uses setup_irq, while it could perfectly use the much simpler
request_irq. Switch to that.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/clocksource/timer-sun5i.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/clocksource/timer-sun5i.c b/drivers/clocksource/timer-sun5i.c
index 02268448dc85..836f92ac0ffd 100644
--- a/drivers/clocksource/timer-sun5i.c
+++ b/drivers/clocksource/timer-sun5i.c
@@ -130,13 +130,6 @@ static irqreturn_t sun5i_timer_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static struct irqaction sun5i_timer_irq = {
-	.name = "sun5i_timer0",
-	.flags = IRQF_TIMER | IRQF_IRQPOLL,
-	.handler = sun5i_timer_interrupt,
-	.dev_id = &sun5i_clockevent,
-};
-
 static u64 sun5i_timer_sched_read(void)
 {
 	return ~readl(timer_base + TIMER_CNTVAL_LO_REG(1));
@@ -178,7 +171,8 @@ static void __init sun5i_timer_init(struct device_node *node)
 
 	ticks_per_jiffy = DIV_ROUND_UP(rate, HZ);
 
-	ret = setup_irq(irq, &sun5i_timer_irq);
+	ret = request_irq(irq, sun5i_timer_interrupt, IRQF_TIMER | IRQF_IRQPOLL,
+			  "sun5i_timer0", &sun5i_clockevent);
 	if (ret)
 		pr_warn("failed to setup irq %d\n", irq);
 
-- 
2.3.0
