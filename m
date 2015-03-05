From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu,  5 Mar 2015 11:20:54 +0100
Subject: [PATCH v3 3/5] clocksource: sun5i: Remove sched_clock
In-Reply-To: <1425550856-12928-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1425550856-12928-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1425550856-12928-4-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It's not possible to remove a sched_clock once it has been added, nor is it
possible to change its rate.

Since we will need to support a rate change, and that we have other
sched_clocks in the system anyway, remove it.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/clocksource/timer-sun5i.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/clocksource/timer-sun5i.c b/drivers/clocksource/timer-sun5i.c
index 2f70ed528174..295bb5e1010c 100644
--- a/drivers/clocksource/timer-sun5i.c
+++ b/drivers/clocksource/timer-sun5i.c
@@ -130,11 +130,6 @@ static irqreturn_t sun5i_timer_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static u64 sun5i_timer_sched_read(void)
-{
-	return ~readl(timer_base + TIMER_CNTVAL_LO_REG(1));
-}
-
 static void __init sun5i_timer_init(struct device_node *node)
 {
 	struct reset_control *rstc;
@@ -166,7 +161,6 @@ static void __init sun5i_timer_init(struct device_node *node)
 	writel(TIMER_CTL_ENABLE | TIMER_CTL_RELOAD,
 	       timer_base + TIMER_CTL_REG(1));
 
-	sched_clock_register(sun5i_timer_sched_read, 32, rate);
 	clocksource_mmio_init(timer_base + TIMER_CNTVAL_LO_REG(1), node->name,
 			      rate, 340, 32, clocksource_mmio_readl_down);
 
-- 
2.3.0
