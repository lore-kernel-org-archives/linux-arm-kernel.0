From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 31 Mar 2015 12:12:23 +0200
Subject: [PATCH 2/5] clocksource/drivers/sun5i: Switch to request_irq
In-Reply-To: <1427796746-373-1-git-send-email-daniel.lezcano@linaro.org>
References: <551A72B6.7030106@linaro.org>
 <1427796746-373-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1427796746-373-2-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Maxime Ripard <maxime.ripard@free-electrons.com>

The current code uses setup_irq, while it could perfectly use the much simpler
request_irq. Switch to that.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Conflicts:
	drivers/clocksource/timer-sun5i.c
---
 drivers/clocksource/timer-sun5i.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/clocksource/timer-sun5i.c b/drivers/clocksource/timer-sun5i.c
index 58597fb..03f04d8 100644
--- a/drivers/clocksource/timer-sun5i.c
+++ b/drivers/clocksource/timer-sun5i.c
@@ -129,13 +129,6 @@ static irqreturn_t sun5i_timer_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static struct irqaction sun5i_timer_irq = {
-	.name = "sun5i_timer0",
-	.flags = IRQF_TIMER | IRQF_IRQPOLL,
-	.handler = sun5i_timer_interrupt,
-	.dev_id = &sun5i_clockevent,
-};
-
 static void __init sun5i_timer_init(struct device_node *node)
 {
 	struct reset_control *rstc;
@@ -181,7 +174,8 @@ static void __init sun5i_timer_init(struct device_node *node)
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
