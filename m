From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon,  8 Aug 2016 15:33:51 +0200
Subject: [PATCH v2 2/4] clocksource: timer-atmel-pit: drop
 at91sam926x_pit_common_init
In-Reply-To: <1470663233-15118-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1470663233-15118-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1470663233-15118-3-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Merge at91sam926x_pit_common_init in at91sam926x_pit_dt_init as this is the
only initialization method now.

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/clocksource/timer-atmel-pit.c | 64 ++++++++++++++---------------------
 1 file changed, 26 insertions(+), 38 deletions(-)

diff --git a/drivers/clocksource/timer-atmel-pit.c b/drivers/clocksource/timer-atmel-pit.c
index db839fc99a8e..6767768a7849 100644
--- a/drivers/clocksource/timer-atmel-pit.c
+++ b/drivers/clocksource/timer-atmel-pit.c
@@ -177,11 +177,36 @@ static irqreturn_t at91sam926x_pit_interrupt(int irq, void *dev_id)
 /*
  * Set up both clocksource and clockevent support.
  */
-static int __init at91sam926x_pit_common_init(struct pit_data *data)
+static int __init at91sam926x_pit_dt_init(struct device_node *node)
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
 
 	/*
 	 * Use our actual MCK to figure out how many MCK/16 ticks per
@@ -236,42 +261,5 @@ static int __init at91sam926x_pit_common_init(struct pit_data *data)
 
 	return 0;
 }
-
-static int __init at91sam926x_pit_dt_init(struct device_node *node)
-{
-	struct pit_data *data;
-
-	data = kzalloc(sizeof(*data), GFP_KERNEL);
-	if (!data)
-		return -ENOMEM;
-
-	data->base = of_iomap(node, 0);
-	if (!data->base) {
-		pr_err("Could not map PIT address\n");
-		return -ENXIO;
-	}
-
-	data->mck = of_clk_get(node, 0);
-	if (IS_ERR(data->mck))
-		/* Fallback on clkdev for !CCF-based boards */
-		data->mck = clk_get(NULL, "mck");
-
-	if (IS_ERR(data->mck)) {
-		pr_err("Unable to get mck clk\n");
-		return PTR_ERR(data->mck);
-	}
-
-	if (clk_prepare_enable(data->mck))
-		panic(pr_fmt("Unable to enable mck\n"));
-
-	/* Get the interrupts property */
-	data->irq = irq_of_parse_and_map(node, 0);
-	if (!data->irq) {
-		pr_err("Unable to get IRQ from DT\n");
-		return -EINVAL;
-	}
-
-	return at91sam926x_pit_common_init(data);
-}
 CLOCKSOURCE_OF_DECLARE(at91sam926x_pit, "atmel,at91sam9260-pit",
 		       at91sam926x_pit_dt_init);
-- 
2.8.1
