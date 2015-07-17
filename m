From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 17 Jul 2015 21:33:27 +0200
Subject: [PATCH 2/3] clocksource: atmel-pit: drop at91sam926x_pit_common_init
In-Reply-To: <1437161608-26782-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1437161608-26782-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1437161608-26782-3-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Merge at91sam926x_pit_common_init in at91sam926x_pit_dt_init as there is no
other initialization (e.g. platform data) anymore.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/clocksource/timer-atmel-pit.c | 52 ++++++++++++++++-------------------
 1 file changed, 23 insertions(+), 29 deletions(-)

diff --git a/drivers/clocksource/timer-atmel-pit.c b/drivers/clocksource/timer-atmel-pit.c
index 58753223585b..e64af62a186c 100644
--- a/drivers/clocksource/timer-atmel-pit.c
+++ b/drivers/clocksource/timer-atmel-pit.c
@@ -177,12 +177,34 @@ static irqreturn_t at91sam926x_pit_interrupt(int irq, void *dev_id)
 /*
  * Set up both clocksource and clockevent support.
  */
-static void __init at91sam926x_pit_common_init(struct pit_data *data)
+static void __init at91sam926x_pit_dt_init(struct device_node *node)
 {
+	struct pit_data *data;
 	unsigned long	pit_rate;
 	unsigned	bits;
 	int		ret;
 
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
+	if (!data)
+		panic(pr_fmt("Unable to allocate memory\n"));
+
+	data->base = of_iomap(node, 0);
+	if (!data->base)
+		panic(pr_fmt("Could not map PIT address\n"));
+
+	data->mck = of_clk_get(node, 0);
+	if (IS_ERR(data->mck))
+		/* Fallback on clkdev for !CCF-based boards */
+		data->mck = clk_get(NULL, "mck");
+
+	if (IS_ERR(data->mck))
+		panic(pr_fmt("Unable to get mck clk\n"));
+
+	/* Get the interrupts property */
+	data->irq = irq_of_parse_and_map(node, 0);
+	if (!data->irq)
+		panic(pr_fmt("Unable to get IRQ from DT\n"));
+
 	/*
 	 * Use our actual MCK to figure out how many MCK/16 ticks per
 	 * 1/HZ period (instead of a compile-time constant LATCH).
@@ -227,33 +249,5 @@ static void __init at91sam926x_pit_common_init(struct pit_data *data)
 	data->clkevt.suspend = at91sam926x_pit_suspend;
 	clockevents_register_device(&data->clkevt);
 }
-
-static void __init at91sam926x_pit_dt_init(struct device_node *node)
-{
-	struct pit_data *data;
-
-	data = kzalloc(sizeof(*data), GFP_KERNEL);
-	if (!data)
-		panic(pr_fmt("Unable to allocate memory\n"));
-
-	data->base = of_iomap(node, 0);
-	if (!data->base)
-		panic(pr_fmt("Could not map PIT address\n"));
-
-	data->mck = of_clk_get(node, 0);
-	if (IS_ERR(data->mck))
-		/* Fallback on clkdev for !CCF-based boards */
-		data->mck = clk_get(NULL, "mck");
-
-	if (IS_ERR(data->mck))
-		panic(pr_fmt("Unable to get mck clk\n"));
-
-	/* Get the interrupts property */
-	data->irq = irq_of_parse_and_map(node, 0);
-	if (!data->irq)
-		panic(pr_fmt("Unable to get IRQ from DT\n"));
-
-	at91sam926x_pit_common_init(data);
-}
 CLOCKSOURCE_OF_DECLARE(at91sam926x_pit, "atmel,at91sam9260-pit",
 		       at91sam926x_pit_dt_init);
-- 
2.1.4
