From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Wed, 21 Sep 2016 23:03:57 +0530
Subject: [PATCH] clocksource: bcm2835_timer: Unmap region obtained by of_iomap
Message-ID: <1474479237-10356-1-git-send-email-arvind.yadav.cs@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Free memory mapping, if bcm2835_timer_init is not successful.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/clocksource/bcm2835_timer.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/clocksource/bcm2835_timer.c b/drivers/clocksource/bcm2835_timer.c
index e71acf2..f2f29d2 100644
--- a/drivers/clocksource/bcm2835_timer.c
+++ b/drivers/clocksource/bcm2835_timer.c
@@ -96,7 +96,7 @@ static int __init bcm2835_timer_init(struct device_node *node)
 	ret = of_property_read_u32(node, "clock-frequency", &freq);
 	if (ret) {
 		pr_err("Can't read clock-frequency");
-		return ret;
+		goto err_iounmap;
 	}
 
 	system_clock = base + REG_COUNTER_LO;
@@ -108,13 +108,15 @@ static int __init bcm2835_timer_init(struct device_node *node)
 	irq = irq_of_parse_and_map(node, DEFAULT_TIMER);
 	if (irq <= 0) {
 		pr_err("Can't parse IRQ");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto err_iounmap;
 	}
 
 	timer = kzalloc(sizeof(*timer), GFP_KERNEL);
 	if (!timer) {
 		pr_err("Can't allocate timer struct\n");
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto err_iounmap;
 	}
 
 	timer->control = base + REG_CONTROL;
@@ -133,7 +135,7 @@ static int __init bcm2835_timer_init(struct device_node *node)
 	ret = setup_irq(irq, &timer->act);
 	if (ret) {
 		pr_err("Can't set up timer IRQ\n");
-		return ret;
+		goto err_iounmap;
 	}
 
 	clockevents_config_and_register(&timer->evt, freq, 0xf, 0xffffffff);
@@ -141,6 +143,10 @@ static int __init bcm2835_timer_init(struct device_node *node)
 	pr_info("bcm2835: system timer (irq = %d)\n", irq);
 
 	return 0;
+
+err_iounmap:
+	iounmap(base);
+	return ret;
 }
 CLOCKSOURCE_OF_DECLARE(bcm2835, "brcm,bcm2835-system-timer",
 			bcm2835_timer_init);
-- 
2.7.4
