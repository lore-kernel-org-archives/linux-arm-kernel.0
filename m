From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed, 20 Apr 2011 12:44:03 +0200
Subject: [PATCH] at91: switch to CLKDEV_LOOKUP
In-Reply-To: <20110420081624.GT31131@pengutronix.de>
References: <1303271969-9794-1-git-send-email-plagnioj@jcrosoft.com>
	<20110420081624.GT31131@pengutronix.de>
Message-ID: <20110420104403.GH4204@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > +	clkdev_add_table(periph_clocks_lookups,
> > +			 ARRAY_SIZE(periph_clocks_lookups));
> > +
> Does it make sense to add a (maybe global) helper function ? la:
> 
> 	void __init clkdev_register_and_add_table(struct clk_lookup *cl, size_t num)
> 	{
> 		while (num--) {
> 			clk_register(&cl->clk);
> 			clkdev_add(cl);
> 			++cl;
> 		}
> 	}
agreed
> 
> ? (The locking isn't optimal here, but I think you get the point.)
> 
> 
> > +static struct clk_lookup usart_clocks_lookups[] = {
> > +	CLKDEV_CON_DEV_ID("usart", "atmel_usart.0", &mck),
> > +	CLKDEV_CON_DEV_ID("usart", "atmel_usart.1", &usart0_clk),
> > +	CLKDEV_CON_DEV_ID("usart", "atmel_usart.2", &usart1_clk),
> > +	CLKDEV_CON_DEV_ID("usart", "atmel_usart.3", &usart2_clk),
> > +	CLKDEV_CON_DEV_ID("usart", "atmel_usart.4", &usart3_clk),
> > +};
> > [...]
> > +struct clk* __init at91sam9rl_get_uart_clock(int id)
> > +{
> > +	if (id >= ARRAY_SIZE(usart_clocks_lookups))
> > +		return NULL;
> > +	return usart_clocks_lookups[id].clk;
> Who is using this function? If the caller has access to the
> atmel_usart.<id> device, just using clk_get looks better.
no unfortunatly

the current device is not well done in the atmel_usart
I'm preparing the switch to the early_plaform_device
to drop this
so this is a workarround (The chicken or the egg causality dilemma)

I need to switch to the clkdev before switch early platform device and I need
the early platform device to drop this :)

And I need to update the clkdev lookup for early device too
Patch will come soon

Best Regards,
J.
