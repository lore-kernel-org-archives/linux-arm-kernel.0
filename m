From: kevin.wells@nxp.com (Kevin Wells)
Date: Wed, 3 Feb 2010 19:51:36 +0100
Subject: [PATCH 08/13] ARM: LPC32XX: clock tree support
In-Reply-To: <20100203163259.GJ11354@pengutronix.de>
References: <1264643011-17390-1-git-send-email-wellsk40@gmail.com>
	<1264643011-17390-9-git-send-email-wellsk40@gmail.com>
	<20100203163259.GJ11354@pengutronix.de>
Message-ID: <083DF309106F364B939360100EC290F805C8B78796@eu1rdcrdc1wx030.exi.nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > +/*
> > + * clk_get_rate - obtain the current clock rate (in Hz) for a clock
> source
> > + */
> > +unsigned long clk_get_rate(struct clk *clk)
> > +{
> > +	if (clk->get_rate)
> > +		return (clk->get_rate)(clk);
> > +
> > +	/* If a clocks rate is 0, it uses the parent's rate instead. */
> > +	while (clk->rate == 0)
> > +		clk = clk->parent;
> > +
> > +	return clk->rate;
> > +}
> > +EXPORT_SYMBOL(clk_get_rate);
> doesn't that need locking to protect against a race with clk_set_rate?
> Hmmm, you never need to call get_rate for a parent clock?
> 

I'll add a lock for this, its needed. The get_rate() function will just
continue to fall back to the first non-0Hz parent clock (all clocks
eventually go to a non-0Hz parent clock). Most clocks don't even have
a get_rate() function.
