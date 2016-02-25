From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 25 Feb 2016 14:37:10 +0100
Subject: [PATCH 2/9] clocksource/drivers/rockchip: Add err handle for
 rk_timer_init
In-Reply-To: <1456407438-6131-1-git-send-email-daniel.lezcano@linaro.org>
References: <56CF00F6.9010301@linaro.org>
 <1456407438-6131-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1456407438-6131-2-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shawn Lin <shawn.lin@rock-chips.com>

Currently rockchip_timer doesn't do some basic cleanup work when
failing to init the timer. Let's add err handle routine to deal
with all the err cases.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/rockchip_timer.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/clocksource/rockchip_timer.c b/drivers/clocksource/rockchip_timer.c
index 8c77a52..b991b28 100644
--- a/drivers/clocksource/rockchip_timer.c
+++ b/drivers/clocksource/rockchip_timer.c
@@ -122,23 +122,23 @@ static void __init rk_timer_init(struct device_node *np)
 	pclk = of_clk_get_by_name(np, "pclk");
 	if (IS_ERR(pclk)) {
 		pr_err("Failed to get pclk for '%s'\n", TIMER_NAME);
-		return;
+		goto out_unmap;
 	}
 
 	if (clk_prepare_enable(pclk)) {
 		pr_err("Failed to enable pclk for '%s'\n", TIMER_NAME);
-		return;
+		goto out_unmap;
 	}
 
 	timer_clk = of_clk_get_by_name(np, "timer");
 	if (IS_ERR(timer_clk)) {
 		pr_err("Failed to get timer clock for '%s'\n", TIMER_NAME);
-		return;
+		goto out_timer_clk;
 	}
 
 	if (clk_prepare_enable(timer_clk)) {
 		pr_err("Failed to enable timer clock\n");
-		return;
+		goto out_timer_clk;
 	}
 
 	bc_timer.freq = clk_get_rate(timer_clk);
@@ -146,7 +146,7 @@ static void __init rk_timer_init(struct device_node *np)
 	irq = irq_of_parse_and_map(np, 0);
 	if (!irq) {
 		pr_err("Failed to map interrupts for '%s'\n", TIMER_NAME);
-		return;
+		goto out_irq;
 	}
 
 	ce->name = TIMER_NAME;
@@ -164,10 +164,19 @@ static void __init rk_timer_init(struct device_node *np)
 	ret = request_irq(irq, rk_timer_interrupt, IRQF_TIMER, TIMER_NAME, ce);
 	if (ret) {
 		pr_err("Failed to initialize '%s': %d\n", TIMER_NAME, ret);
-		return;
+		goto out_irq;
 	}
 
 	clockevents_config_and_register(ce, bc_timer.freq, 1, UINT_MAX);
+
+	return;
+
+out_irq:
+	clk_disable_unprepare(timer_clk);
+out_timer_clk:
+	clk_disable_unprepare(pclk);
+out_unmap:
+	iounmap(bc_timer.base);
 }
 
 CLOCKSOURCE_OF_DECLARE(rk_timer, "rockchip,rk3288-timer", rk_timer_init);
-- 
1.9.1
