From: kevin.wells@nxp.com (Kevin Wells)
Date: Tue, 9 Feb 2010 20:18:02 +0100
Subject: [PATCH 03/14] ARM: LPC32XX: Clock driver
In-Reply-To: <20100209103918.GD2284@pengutronix.de>
References: <1265674295-23996-1-git-send-email-wellsk40@gmail.com>
	<1265674295-23996-4-git-send-email-wellsk40@gmail.com>
	<20100209103918.GD2284@pengutronix.de>
Message-ID: <083DF309106F364B939360100EC290F805C8C7550C@eu1rdcrdc1wx030.exi.nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > +
> > +/*
> > + * Post divider values for PLLs based on selected register value
> > + */
> > +const u32 pll_postdivs[4] = {1, 2, 4, 8};
> make this static, too?
> 

This object is used in 2 files/functions for PLL rate computation and
PLL rate generation and is externally defined in common.h. I should
be able to move the other function that references this into clock.c,
it's a clock function too, and make things a little more simpler.

> > +static void local_clk_disable(struct clk *clk)
> > +{
> > +	/* Don't attempt to disable clock if it has no users */
> WARN_ON(clk->usecount <= 0)?
> 
> > +	if (clk->usecount > 0) {
> > +		clk->usecount--;
> > +
> > +		/* Only disable clock when it has no more users */
> > +		if ((clk->usecount == 0) && (clk->enable))
> > +			clk->enable(clk, 0);
> > +
> > +		/* Check parent clocks, they may need to be disabled too */
> > +		if (clk->parent)
> > +			local_clk_disable(clk->parent);
> > +	}
> > +}
> > +
> > +static int local_clk_enable(struct clk *clk)
> > +{
> > +	int ret = 0;
> > +
> > +	if (clk->usecount == 0) {
> > +		/* Enable parent clocks first */
> > +		if (clk->parent)
> > +			ret = local_clk_enable(clk->parent);
> > +
> > +		/* Enable clock on first use */
> > +		if ((ret == 0) && (clk->enable)) {
> > +			ret = clk->enable(clk, 1);
> > +			clk->usecount++;
> > +		}
> > +
> > +		/* Back out use counters if enable fails */
> > +		if (ret < 0)
> > +			local_clk_disable(clk);
> if enable failed there is no need to disable, is it?
> 
> And I think the reference counting is broken.
> 
> After
> 
> 	clk_enable(aclk);
> 	clk_enable(aclk);
> 	clk_disable(aclk);
> 
> aclk is disabled because usecount isn't increased if it is already >0!?
> 

Yes, this does seem broken. I will review and fix.
