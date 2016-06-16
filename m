From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 16 Jun 2016 23:27:21 +0200
Subject: [PATCH V2 62/63] clocksource/drivers/oxnas-rps: Convert init function
 to return error
In-Reply-To: <1466112442-31105-1-git-send-email-daniel.lezcano@linaro.org>
References: <1466112442-31105-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1466112442-31105-63-git-send-email-daniel.lezcano@linaro.org>
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
 drivers/clocksource/timer-oxnas-rps.c | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/drivers/clocksource/timer-oxnas-rps.c b/drivers/clocksource/timer-oxnas-rps.c
index c002e99..0d99f40 100644
--- a/drivers/clocksource/timer-oxnas-rps.c
+++ b/drivers/clocksource/timer-oxnas-rps.c
@@ -220,32 +220,37 @@ static int __init oxnas_rps_clocksource_init(struct oxnas_rps_timer *rps)
 	return 0;
 }
 
-static void __init oxnas_rps_timer_init(struct device_node *np)
+static int __init oxnas_rps_timer_init(struct device_node *np)
 {
 	struct oxnas_rps_timer *rps;
 	void __iomem *base;
 	int ret;
 
 	rps = kzalloc(sizeof(*rps), GFP_KERNEL);
-	if (!rps) {
-		pr_err("Failed to allocate rps structure\n");
-		return;
-	}
+	if (!rps)
+		return -ENOMEM;
 
 	rps->clk = of_clk_get(np, 0);
-	if (WARN_ON(IS_ERR(rps->clk)))
+	if (IS_ERR(rps->clk)) {
+		ret = PTR_ERR(rps->clk);
 		goto err_alloc;
+	}
 
-	if (WARN_ON(clk_prepare_enable(rps->clk)))
+	ret = clk_prepare_enable(rps->clk);
+	if (ret)
 		goto err_clk;
 
 	base = of_iomap(np, 0);
-	if (WARN_ON(!base))
+	if (!base) {
+		ret = -ENXIO;
 		goto err_clk_prepare;
+	}
 
 	rps->irq = irq_of_parse_and_map(np, 0);
-	if (WARN_ON(rps->irq < 0))
+	if (rps->irq < 0) {
+		ret = -EINVAL;
 		goto err_iomap;
+	}
 
 	rps->clkevt_base = base + TIMER1_REG_OFFSET;
 	rps->clksrc_base = base + TIMER2_REG_OFFSET;
@@ -261,7 +266,7 @@ static void __init oxnas_rps_timer_init(struct device_node *np)
 	ret = request_irq(rps->irq, oxnas_rps_timer_irq,
 			  IRQF_TIMER | IRQF_IRQPOLL,
 			  "rps-timer", rps);
-	if (WARN_ON(ret))
+	if (ret)
 		goto err_iomap;
 
 	ret = oxnas_rps_clocksource_init(rps);
@@ -272,7 +277,7 @@ static void __init oxnas_rps_timer_init(struct device_node *np)
 	if (ret)
 		goto err_irqreq;
 
-	return;
+	return 0;
 
 err_irqreq:
 	free_irq(rps->irq, rps);
@@ -284,7 +289,9 @@ err_clk:
 	clk_put(rps->clk);
 err_alloc:
 	kfree(rps);
+
+	return ret;
 }
 
-CLOCKSOURCE_OF_DECLARE(ox810se_rps,
-		       "oxsemi,ox810se-rps-timer", oxnas_rps_timer_init);
+CLOCKSOURCE_OF_DECLARE_RET(ox810se_rps,
+			   "oxsemi,ox810se-rps-timer", oxnas_rps_timer_init);
-- 
1.9.1
