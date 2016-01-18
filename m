From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Mon, 18 Jan 2016 18:25:22 +0100
Subject: [PATCH 4.4-rt2] fix
 arm-at91-pit-remove-irq-handler-when-clock-is-unused.patch
In-Reply-To: <1452997394-8554-2-git-send-email-alexandre.belloni@free-electrons.com>
References: <1452997394-8554-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1452997394-8554-2-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <20160118172522.GB12309@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Alexandre Belloni | 2016-01-17 03:23:14 [+0100]:

>index 80d74c4adcbe..43b50634d640 100644
>--- a/drivers/clocksource/timer-atmel-pit.c
>+++ b/drivers/clocksource/timer-atmel-pit.c
>@@ -96,11 +96,44 @@ static int pit_clkevt_shutdown(struct clock_event_device *dev)
> 
> 	/* disable irq, leaving the clocksource active */
> 	pit_write(data->base, AT91_PIT_MR, (data->cycle - 1) | AT91_PIT_PITEN);
>-	free_irq(atmel_pit_irq, data);
>+	if (!clockevent_state_detached(dev))
>+		free_irq(data->irq, data);

I did it in the meantime without clockevent_state_detached(). From what
it looks, it first sets the state and then invokes
pit_clkevt_shutdown(). Any particular reason for this?

> 	return 0;
> }
> 
> /*
>+ * IRQ handler for the timer.
>+ */
>+static irqreturn_t at91sam926x_pit_interrupt(int irq, void *dev_id)

this is just here to avoid to forward declaration.
?
>diff --git a/drivers/clocksource/timer-atmel-st.c b/drivers/clocksource/timer-atmel-st.c
>index ea37afc26e1b..11ce404d0791 100644
>--- a/drivers/clocksource/timer-atmel-st.c
>+++ b/drivers/clocksource/timer-atmel-st.c
>@@ -229,15 +229,15 @@ static void __init atmel_st_timer_init(struct device_node *node)
> 	regmap_read(regmap_st, AT91_ST_SR, &val);
> 
> 	/* Get the interrupts property */
>-	irq  = irq_of_parse_and_map(node, 0);
>-	if (!irq)
>+	atmel_st_irq  = irq_of_parse_and_map(node, 0);
>+	if (!atmel_st_irq)
> 		panic(pr_fmt("Unable to get IRQ from DT\n"));
> 
> 	sclk = of_clk_get(node, 0);
> 	if (IS_ERR(sclk))
> 		panic(pr_fmt("Unable to get slow clock\n"));
> 
>-	clk_prepare_enable(sclk);
>+	ret = clk_prepare_enable(sclk);
this piece applies to upstream v4.4.

> 	if (ret)
> 		panic(pr_fmt("Could not enable slow clock\n"));
> 

Sebastian
