From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 18 Dec 2015 15:18:06 +0100
Subject: [PATCH 53/69] clocksource/drivers/timer_sun5i: Replace code by
 clocksource_mmio_init
In-Reply-To: <1450448302-27429-1-git-send-email-daniel.lezcano@linaro.org>
References: <5672CB9E.7090707@linaro.org>
 <1450448302-27429-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1450448302-27429-53-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current code to initialize, register and read the clocksource is
already factored out in mmio.c via the clocksource_mmio_init function.

The only difference is the readl vs readl_relaxed.

Factor out the code with the clocksource_mmio_init function.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/clocksource/timer-sun5i.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/clocksource/timer-sun5i.c b/drivers/clocksource/timer-sun5i.c
index bca9573..24c83f9 100644
--- a/drivers/clocksource/timer-sun5i.c
+++ b/drivers/clocksource/timer-sun5i.c
@@ -152,13 +152,6 @@ static irqreturn_t sun5i_timer_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static cycle_t sun5i_clksrc_read(struct clocksource *clksrc)
-{
-	struct sun5i_timer_clksrc *cs = to_sun5i_timer_clksrc(clksrc);
-
-	return ~readl(cs->timer.base + TIMER_CNTVAL_LO_REG(1));
-}
-
 static int sun5i_rate_cb_clksrc(struct notifier_block *nb,
 				unsigned long event, void *data)
 {
@@ -217,13 +210,8 @@ static int __init sun5i_setup_clocksource(struct device_node *node,
 	writel(TIMER_CTL_ENABLE | TIMER_CTL_RELOAD,
 	       base + TIMER_CTL_REG(1));
 
-	cs->clksrc.name = node->name;
-	cs->clksrc.rating = 340;
-	cs->clksrc.read = sun5i_clksrc_read;
-	cs->clksrc.mask = CLOCKSOURCE_MASK(32);
-	cs->clksrc.flags = CLOCK_SOURCE_IS_CONTINUOUS;
-
-	ret = clocksource_register_hz(&cs->clksrc, rate);
+	ret = clocksource_mmio_init(base + TIMER_CNTVAL_LO_REG(1), node->name,
+				    rate, 340, 32, clocksource_mmio_readl_down);
 	if (ret) {
 		pr_err("Couldn't register clock source.\n");
 		goto err_remove_notifier;
-- 
1.9.1
