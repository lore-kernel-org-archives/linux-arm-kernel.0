From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 24 Jan 2011 23:23:02 +0000
Subject: [PATCH 2/4] arch/arm/mach-at91/clock.c: Add missing IS_ERR test
In-Reply-To: <4D3DF46A.1030009@bluewatersys.com>
References: <4D3DD964.9020107@bluewatersys.com>
	<Pine.LNX.4.64.1101242058430.3167@ask.diku.dk>
	<20110124200515.GA30963@albatros>
	<4D3DDD07.1030809@bluewatersys.com>
	<Pine.LNX.4.64.1101242126570.3167@ask.diku.dk>
	<4D3DE35B.1030102@bluewatersys.com>
	<Pine.LNX.4.64.1101242200500.3167@ask.diku.dk>
	<4D3DE9CD.2040800@bluewatersys.com>
	<Pine.LNX.4.64.1101242231240.3167@ask.diku.dk>
	<4D3DF46A.1030009@bluewatersys.com>
Message-ID: <20110124232302.GQ24104@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 25, 2011 at 10:51:38AM +1300, Ryan Mallon wrote:
> You could, but it would not be helpful. Clock associations are used so
> that _different_ devices can have the same function and map to the
> correct clock. This is used when there are multiple instances of a
> single peripheral. For example, the uart clocks work like this:
> 
> 	at91_clock_associate("usart1_clk", &pdev->dev, "usart");
> 
> so then you can do this in a driver:
> 	
> 	uart_clk = clk_get(&pdev->dev, "usart");
> 
> Rather than:
> 
> 	uart_clk = clk_get(NULL, "usart1_clk");
> 
> The former will find the correct uart clock for the device. Because each
> uart is a separate device the correct clock will be selected for each uart.
> 	
> My point was that there should be no overlap between clk->name and
> clk->function otherwise clk_get will not be able to return the correct
> clock.

It would be nice if AT91 could switch over to using clkdev at some
point, which greatly helps with associating struct clk's with their
device/function names - and reduces the amount of "different" code.

You can then use clk_add_alias() to create aliases of an existing
clock.

Looking at your clk_get(), I think one way to do this would be, in
clk_register():

	struct clk_lookup *cl;

	/* create function-only entry */
	cl = clkdev_alloc(clk, clk->name, NULL);
	if (!cl)
		return -ENOMEM;
	clkdev_add(cl);

	/* not sure if you need this? */
	if (clk->dev && clk->function) {
		cl = clkdev_alloc(clk, clk->function, "%s", dev_name(clk->dev));
		if (!cl)
			return -ENOMEM;
		clkdev_add(cl);
	}

at91_clock_associate() becomes:

	err = clk_add_alias(func, dev_name(dev), id, NULL);
	return err;

Although maybe in the long run see about removing at91_clock_associate()
entirely as its just a wrapper.

The only requirement there is that 'dev' in each case is a registered
device, otherwise dev_name() won't work.

You can then use the generic clk_get()/clk_put() which clkdev provides.
