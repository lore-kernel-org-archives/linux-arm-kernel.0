From: tglx@linutronix.de (Thomas Gleixner)
Date: Fri, 20 May 2011 15:25:24 +0200 (CEST)
Subject: [PATCH 1/4] clk: Add a generic clock infrastructure
In-Reply-To: <20110520115936.GA10931@pengutronix.de>
References: <1305876469.325655.313573683829.0.gpush@pororo>
	<1305876469.326305.518470530485.1.gpush@pororo>
	<20110520115936.GA10931@pengutronix.de>
Message-ID: <alpine.LFD.2.02.1105201521560.3078@ionos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 20 May 2011, Sascha Hauer wrote:

> Hi Jeremy,
> 
> Nice to see progress in this area :)
> 
> On Fri, May 20, 2011 at 03:27:49PM +0800, Jeremy Kerr wrote:
> > +
> > +struct clk *clk_register(struct clk_hw_ops *ops, struct clk_hw *hw,
> > +		const char *name)
> > +{
> > +	struct clk *clk;
> > +
> > +	clk = kzalloc(sizeof(*clk), GFP_KERNEL);
> > +	if (!clk)
> > +		return NULL;
> > +
> > +	clk->name = name;
> > +	clk->ops = ops;
> > +	clk->hw = hw;
> > +	hw->clk = clk;
> 
> is it worth to add a CLK_REGISTERED flag here? Up to now clocks do not
> have to be registered at all and the registering might be forgotten for
> some clocks. I suppose funny things can happen when we operate on
> unregistered clocks.

No, because not registered clocks are not accessible :)

 > +
> > +	/* Query the hardware for parent and initial rate */
> > +
> > +	if (clk->ops->get_parent)
> > +		/* We don't to lock against prepare/enable here, as
> > +		 * the clock is not yet accessible from anywhere */
> > +		clk->parent = clk->ops->get_parent(clk->hw);
> > +
> > +	if (clk->ops->recalc_rate)
> > +		clk->rate = clk->ops->recalc_rate(clk->hw);
> 
> This implicitely requires that we never register a clock before its
> parent is registered. This makes perfect sense but I think we should
> catch it here when the user tries to register a clock with a not yet
> registered parent.

We can agree on that, but we can make it more clever than that.
 
> > +
> > +
> > +	return clk;
> > +}
> > +EXPORT_SYMBOL_GPL(clk_register);
> 
> BTW we planned to let the linker do the job of registering static
> clocks, but this is only convenience and can be added later.

Right, you just need a helper function which runs through the list of
static stuff.
