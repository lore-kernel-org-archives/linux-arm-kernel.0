From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 30 Mar 2015 22:17:04 +0200
Subject: [PATCH 02/11] clocksource: sun5i: Switch to request_irq
In-Reply-To: <1427746633-9137-1-git-send-email-daniel.lezcano@linaro.org>
References: <5519AEB2.8050306@linaro.org>
 <1427746633-9137-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1427746633-9137-2-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Maxime Ripard <maxime.ripard@free-electrons.com>

The current code uses setup_irq, while it could perfectly use the much simpler
request_irq. Switch to that.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-sun5i.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/clocksource/timer-sun5i.c b/drivers/clocksource/timer-sun5i.c
index 5dcbf90..5320846 100644
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
@@ -188,7 +181,8 @@ static void __init sun5i_timer_init(struct device_node *node)
 	clockevents_config_and_register(&sun5i_clockevent, rate,
 					TIMER_SYNC_TICKS, 0xffffffff);
 
-	ret = setup_irq(irq, &sun5i_timer_irq);
+	ret = request_irq(irq, sun5i_timer_interrupt, IRQF_TIMER | IRQF_IRQPOLL,
+			  "sun5i_timer0", &sun5i_clockevent);
 	if (ret)
 		pr_warn("failed to setup irq %d\n", irq);
 }
-- 
1.9.1
