From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed,  1 Jun 2016 10:34:46 +0200
Subject: [PATCH 3/9] clocksource/drivers/rockchip_timer: Convert init function
 to return error
In-Reply-To: <1464770093-12667-1-git-send-email-daniel.lezcano@linaro.org>
References: <1464770093-12667-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1464770093-12667-4-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The init functions do not return any error. They behave as the following:

 - panic, thus leading to a kernel crash while another timer may work and
   make the system boot up correctly

 or

 - print an error and let the caller unaware if the state of the system

Change that by converting the init functions to return an error conforming
to the CLOCKSOURCE_OF_RET prototype.

Proper error handling (rollback, errno value) will be changed later case
by case, thus this change just return back an error or success in the init
function.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/rockchip_timer.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/clocksource/rockchip_timer.c b/drivers/clocksource/rockchip_timer.c
index b991b28..36b0209 100644
--- a/drivers/clocksource/rockchip_timer.c
+++ b/drivers/clocksource/rockchip_timer.c
@@ -106,17 +106,17 @@ static irqreturn_t rk_timer_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static void __init rk_timer_init(struct device_node *np)
+static int __init rk_timer_init(struct device_node *np)
 {
 	struct clock_event_device *ce = &bc_timer.ce;
 	struct clk *timer_clk;
 	struct clk *pclk;
-	int ret, irq;
+	int ret = -EINVAL, irq;
 
 	bc_timer.base = of_iomap(np, 0);
 	if (!bc_timer.base) {
 		pr_err("Failed to get base address for '%s'\n", TIMER_NAME);
-		return;
+		return -ENXIO;
 	}
 
 	pclk = of_clk_get_by_name(np, "pclk");
@@ -169,7 +169,7 @@ static void __init rk_timer_init(struct device_node *np)
 
 	clockevents_config_and_register(ce, bc_timer.freq, 1, UINT_MAX);
 
-	return;
+	return 0;
 
 out_irq:
 	clk_disable_unprepare(timer_clk);
@@ -177,6 +177,8 @@ out_timer_clk:
 	clk_disable_unprepare(pclk);
 out_unmap:
 	iounmap(bc_timer.base);
+
+	return ret;
 }
 
-CLOCKSOURCE_OF_DECLARE(rk_timer, "rockchip,rk3288-timer", rk_timer_init);
+CLOCKSOURCE_OF_DECLARE_RET(rk_timer, "rockchip,rk3288-timer", rk_timer_init);
-- 
1.9.1
