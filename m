From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 28 Apr 2011 20:22:37 +0100
Subject: [PATCH] at91: switch to CLKDEV_LOOKUP
In-Reply-To: <20110420081624.GT31131@pengutronix.de>
References: <1303271969-9794-1-git-send-email-plagnioj@jcrosoft.com>
	<20110420081624.GT31131@pengutronix.de>
Message-ID: <20110428192237.GP17290@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 20, 2011 at 10:16:24AM +0200, Uwe Kleine-K?nig wrote:
> Hello Jean-Christophe,
> 
> On Wed, Apr 20, 2011 at 05:59:29AM +0200, Jean-Christophe PLAGNIOL-VILLARD wrote:
> >  /*
> >   * The five programmable clocks.
> >   * You must configure pin multiplexing to bring these signals out.
> > @@ -234,6 +265,13 @@ static struct clk pck3 = {
> >  	.id		= 3,
> >  };
> >  
> > +static struct clk_lookup program_clocks_lookups[] = {
> > +	CLKDEV_CON_ID("pck0", &pck0),
> > +	CLKDEV_CON_ID("pck1", &pck1),
> > +	CLKDEV_CON_ID("pck2", &pck2),
> > +	CLKDEV_CON_ID("pck3", &pck3),
> > +};
> > +
> >  static struct clk mAgicV_mem_clk = {
> >  	.name		= "mAgicV_mem_clk",
> >  	.pmc_mask	= AT91_PMC_PCK4,
> > @@ -241,6 +279,9 @@ static struct clk mAgicV_mem_clk = {
> >  	.id		= 4,
> >  };
> >  
> > +static struct clk_lookup mAgicV_mem_clk_lookup =
> > +	CLKDEV_CON_ID("mAgicV_mem_clk", &mAgicV_mem_clk);
> > +
> >  /* HClocks */
> >  static struct clk hck0 = {
> >  	.name		= "hck0",
> > @@ -255,6 +296,11 @@ static struct clk hck1 = {
> >  	.id		= 1,
> >  };
> >  
> > +static struct clk_lookup hc_clocks_lookups[] = {
> > +	CLKDEV_CON_ID("hck0", &hck0),
> > +	CLKDEV_CON_ID("hck1", &hck1),
> > +};
> > +
> >  static void __init at572d940hf_register_clocks(void)
> >  {
> >  	int i;
> > @@ -262,14 +308,32 @@ static void __init at572d940hf_register_clocks(void)
> >  	for (i = 0; i < ARRAY_SIZE(periph_clocks); i++)
> >  		clk_register(periph_clocks[i]);
> >  
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
> 
> ? (The locking isn't optimal here, but I think you get the point.)

Err no.  clk_register() has nothing to do with clkdev, and actually
clkdev has no business knowing about clk_register() at all.  Note
that clk_register() is not part of the clk API but a private
function to the implementation.
