From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Wed, 28 Jun 2017 14:15:23 +0530
Subject: [PATCH] clocksource: timer-digicolor: Fix resource leaks in error
 paths.
Message-ID: <bdf445789302505768066e0c3b56f39dff81e363.1498639341.git.arvind.yadav.cs@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Handle return value of clk_prepare_enable. In case of error at init time,
rollback iomapping and unprepare clk.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/clocksource/timer-digicolor.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/clocksource/timer-digicolor.c b/drivers/clocksource/timer-digicolor.c
index 94a161e..9360b46 100644
--- a/drivers/clocksource/timer-digicolor.c
+++ b/drivers/clocksource/timer-digicolor.c
@@ -168,15 +168,20 @@ static int __init digicolor_timer_init(struct device_node *node)
 	irq = irq_of_parse_and_map(node, dc_timer_dev.timer_id);
 	if (irq <= 0) {
 		pr_err("Can't parse IRQ\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto err_iounmap;
 	}
 
 	clk = of_clk_get(node, 0);
 	if (IS_ERR(clk)) {
 		pr_err("Can't get timer clock\n");
-		return PTR_ERR(clk);
+		ret = PTR_ERR(clk);
+		goto err_iounmap;
 	}
-	clk_prepare_enable(clk);
+	ret = clk_prepare_enable(clk);
+	if (ret)
+		goto err_clk_put;
+
 	rate = clk_get_rate(clk);
 	dc_timer_dev.ticks_per_jiffy = DIV_ROUND_UP(rate, HZ);
 
@@ -193,7 +198,7 @@ static int __init digicolor_timer_init(struct device_node *node)
 			  &dc_timer_dev.ce);
 	if (ret) {
 		pr_warn("request of timer irq %d failed (%d)\n", irq, ret);
-		return ret;
+		goto err_unprepare;
 	}
 
 	dc_timer_dev.ce.cpumask = cpu_possible_mask;
@@ -202,6 +207,13 @@ static int __init digicolor_timer_init(struct device_node *node)
 	clockevents_config_and_register(&dc_timer_dev.ce, rate, 0, 0xffffffff);
 
 	return 0;
+err_unprepare:
+	clk_disable_unprepare(clk);
+err_clk_put:
+	clk_put(clk);
+err_iounmap:
+	iounmap(dc_timer_dev.base);
+	return ret;
 }
 CLOCKSOURCE_OF_DECLARE(conexant_digicolor, "cnxt,cx92755-timer",
 		       digicolor_timer_init);
-- 
1.9.1
