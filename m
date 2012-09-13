From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Thu, 13 Sep 2012 12:24:19 +0200
Subject: triggering an gpio-irq on both edges
In-Reply-To: <20120913081920.GF19497@pengutronix.de>
References: <20120913081920.GF19497@pengutronix.de>
Message-ID: <1347531859.2429.241.camel@pizza.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, den 13.09.2012, 10:19 +0200 schrieb Uwe Kleine-K?nig:
> Hello,
> 
> My motivation for this mail is that currently mxs_gpio_set_irq_type
> doesn't support type=IRQ_TYPE_EDGE_RISING|IRQ_TYPE_EDGE_FALLING because
> the hardware doesn't support it.
> 
> The gpio-keys driver on the other hand wants a trigger in both
> directions.
> 
> The mxc-gpio driver implements the missing hardware functionallity in
> software (gpio_set_irq_type):
> 
> 	set_irq_type:
> 		if (both edges requested)
> 			if (current value of gpio == 0)
> 				trigger on rising edge
> 			else
> 				trigger on falling edge
> 
> 	handle_irq:
> 		if (both edges requested)
> 			trigger on other edge
> 

The ASIC3 driver in drivers/mfd/asic3.c does the same in
asic3_irq_demux, asic3_irq_flip_edge and asic3_gpio_irq_type.

> This is racy though: If there is an edge after reading out the gpio
> value and completion of the edge direction programming, you miss
> interrupts. Also just switching the direction in the irq handler is
> also wrong for the same reason.
>
> I guess there are more machines than mxc and mxs that have the same
> problem.
> 
> In my opinion this calls for a wrapper, something like:
> 
> 	int gpio_irq_emulate_both_edges_set_irq_type(struct irq_data *d,
> 		unsigned int type, int (*set_irq_type)(...),
> 		int (*get_value)(...), struct something *privdata)
> 	{
> 		...
> 	}
> 
> 	int gpio_irq_emulate_both_edges_handler(...)
> 	{
> 
> 	}
> 
> Does this sound good and possible? I didn't find something like that
> already implemented, but maybe I missed it?
> 
> Any thoughts (and be it only "The xyz driver is affected, too.") are
> welcome.

regards
Philipp
