From: jeremy.kerr@canonical.com (Jeremy Kerr)
Date: Fri, 7 Jan 2011 08:10:20 +0800
Subject: [PATCH 1/2] Add a common struct clk
In-Reply-To: <20110106201137.GY25121@pengutronix.de>
References: <1294199462.347935.472473715866.0.gpush@pororo>
	<20110106160752.GA2775@riccoc20.at.omicron.at>
	<20110106201137.GY25121@pengutronix.de>
Message-ID: <201101070810.21398.jeremy.kerr@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Richard,

> > > +struct clk {
> > > +	const struct clk_ops	*ops;
> > > +	unsigned int		enable_count;
> > > +	int			flags;
> > > +	union {
> > > +		struct mutex	mutex;
> > > +		spinlock_t	spinlock;
> > > +	} lock;
> > > +};
> > 
> > Here you have a "polymorphic" lock, where the clock instance knows
> > which type it is supposed to be.  I got flak from David Miller and
> > 
> > others trying to do the same thing with the mdio_bus:
> >    http://kerneltrap.org/mailarchive/linux-netdev/2010/7/6/6280618
> > 
> > The criticism, applied to your case, is that the clk_enable() caller
> > cannot know whether it is safe to make the call or not. I was told,
> > "there has got to be a better way."
> 
> Note that this is not "new".  Currently there is no convention available
> if clk_enable sleeps or not.  See e.g.
> http://thread.gmane.org/gmane.linux.ports.arm.kernel/100744

As Uwe says, the common clock does not change these semantics; I would prefer 
to keep the driver API changes at a minimum with these patches.

But yes, it would be a good idea to:

 * introduce clk_enable_atomic, which requires clk->flags & CLK_ATOMIC

 * add might_sleep to clk_enable(), encouraging clk uses in atomic contexts
   to switch to clk_enable_atomic.

We'd still be able to handle CLK_ATOMIC clocks in clk_enable(), so the 
enforcement only needs to be one-way.

However, I think these would be better as separate changes.

Cheers,


Jeremy
