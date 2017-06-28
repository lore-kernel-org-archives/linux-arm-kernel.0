From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Wed, 28 Jun 2017 13:20:15 +0530
Subject: [PATCH] clocksource: timer-prima2: Unmap region and unprepare clk
 obtained by of_iomap/clk_prepare_enable
Message-ID: <69a66a7f59cdee90d01e30d3f8274576c1a51e27.1498636084.git.arvind.yadav.cs@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In case of error at init time, rollback iomapping and unprepare clk.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/clocksource/timer-prima2.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/clocksource/timer-prima2.c b/drivers/clocksource/timer-prima2.c
index b4122ed..46d40b3 100644
--- a/drivers/clocksource/timer-prima2.c
+++ b/drivers/clocksource/timer-prima2.c
@@ -210,13 +210,15 @@ static int __init sirfsoc_prima2_timer_init(struct device_node *np)
 
 	if (rate < PRIMA2_CLOCK_FREQ || rate % PRIMA2_CLOCK_FREQ) {
 		pr_err("Invalid clock rate\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto err_unprepare;
 	}
 
 	sirfsoc_timer_base = of_iomap(np, 0);
 	if (!sirfsoc_timer_base) {
 		pr_err("unable to map timer cpu registers\n");
-		return -ENXIO;
+		ret = -ENXIO;
+		goto err_unprepare;
 	}
 
 	sirfsoc_timer_irq.irq = irq_of_parse_and_map(np, 0);
@@ -230,7 +232,7 @@ static int __init sirfsoc_prima2_timer_init(struct device_node *np)
 	ret = clocksource_register_hz(&sirfsoc_clocksource, PRIMA2_CLOCK_FREQ);
 	if (ret) {
 		pr_err("Failed to register clocksource\n");
-		return ret;
+		goto err_iounmap;
 	}
 
 	sched_clock_register(sirfsoc_read_sched_clock, 64, PRIMA2_CLOCK_FREQ);
@@ -238,12 +240,18 @@ static int __init sirfsoc_prima2_timer_init(struct device_node *np)
 	ret = setup_irq(sirfsoc_timer_irq.irq, &sirfsoc_timer_irq);
 	if (ret) {
 		pr_err("Failed to setup irq\n");
-		return ret;
+		goto err_iounmap;
 	}
 
 	sirfsoc_clockevent_init();
 
 	return 0;
+
+err_iounmap:
+	iounmap(sirfsoc_timer_base);
+err_unprepare:
+	clk_disable_unprepare(clk);
+	return ret;
 }
 CLOCKSOURCE_OF_DECLARE(sirfsoc_prima2_timer,
 	"sirf,prima2-tick", sirfsoc_prima2_timer_init);
-- 
1.9.1
