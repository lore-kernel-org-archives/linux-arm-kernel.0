From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue,  5 Jul 2016 00:12:32 +0200
Subject: [PATCH 1/3] clocksource: timer-atmel-pit: drop
 at91sam926x_pit_common_init
In-Reply-To: <1467670354-12987-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1467670354-12987-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1467670354-12987-2-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Merge at91sam926x_pit_common_init in at91sam926x_pit_dt_init as this is the
only initialization method now.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/clocksource/timer-atmel-pit.c | 59 ++++++++++++++++-------------------
 1 file changed, 27 insertions(+), 32 deletions(-)

diff --git a/drivers/clocksource/timer-atmel-pit.c b/drivers/clocksource/timer-atmel-pit.c
index fcc97711cd79..87659b8734d5 100644
--- a/drivers/clocksource/timer-atmel-pit.c
+++ b/drivers/clocksource/timer-atmel-pit.c
@@ -177,11 +177,37 @@ static irqreturn_t at91sam926x_pit_interrupt(int irq, void *dev_id)
 /*
  * Set up both clocksource and clockevent support.
  */
-static void __init at91sam926x_pit_common_init(struct pit_data *data)
+static void __init at91sam926x_pit_dt_init(struct device_node *node)
 {
 	unsigned long	pit_rate;
 	unsigned	bits;
 	int		ret;
+	struct pit_data *data;
+
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
+	if (clk_prepare_enable(data->mck))
+		panic(pr_fmt("Unable to enable mck\n"));
+
+	/* Get the interrupts property */
+	data->irq = irq_of_parse_and_map(node, 0);
+	if (!data->irq)
+		panic(pr_fmt("Unable to get IRQ from DT\n"));
+
 
 	/*
 	 * Use our actual MCK to figure out how many MCK/16 ticks per
@@ -227,36 +253,5 @@ static void __init at91sam926x_pit_common_init(struct pit_data *data)
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
-	if (clk_prepare_enable(data->mck))
-		panic(pr_fmt("Unable to enable mck\n"));
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
2.8.1
