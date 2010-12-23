From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 23 Dec 2010 16:42:52 +0100
Subject: bug in PL011 console
In-Reply-To: <20101223150841.GP3636@n2100.arm.linux.org.uk>
References: <20101223150234.GW14221@pengutronix.de>
	<20101223150841.GP3636@n2100.arm.linux.org.uk>
Message-ID: <20101223154252.GX14221@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 23, 2010 at 03:08:41PM +0000, Russell King - ARM Linux wrote:
> On Thu, Dec 23, 2010 at 04:02:34PM +0100, Uwe Kleine-K?nig wrote:
> > Steven told me on irc that sleeping was not allowed in the console write
> > callback.  Maybe this didn't show up earlier because not all clk
> > implementations sleep as mxs' does.
> > 
> > I think the only possible fix is to do the clk_enable in the setup
> > callback instead of per-write.
> > 
> > Will send a patch as follow up.
> 
> We really need to sort out what's expected from the CLK API.  The drivers
> I write assume that it's absolutely fine to call clk_enable/clk_disable
> from IRQ context, and for the platforms I implemented the CLK API for,
> that's absolutely true.
The common struct clk patch[1] by Jeremy Kerr sleeps, too.  And I think
most people who commented to this series thought that this is the right
behaviour.

> I'd lobby for it because it allows for proper power saving management of
> clocks for devices - PL011 only enables the clock when either the port is
> open or it's actually sending data out the port.  So it's doing absolutely
> the best power management that can be done with UARTs.
Yeah, that makes fine-grained clk enabling harder/impossible.  So
ideally we'd have something that only makes clk_enable sleep iff
that's sensible for that clk.  And if you have a clock that can be
enabled "fast" it would not sleep.

Don't know if that works, maybe something like that:

	int clk_enable(struct clk *clk)
	{
		spin_lock(something);
		if (clk->flags & (SOME|FLAGS))
			goto out_busy;
		clk->flags |= ENABLING;
		spin_unlock(something);

		ret = clk->really_enable(...);

		spin_lock(something);
		clk->flags &= ~ENABLING;
		spin_unlock(something);
	}

Some things that need careful consideration are:

	- clk->flags already has ENABLING when clk_enable is entered.
	  (needs to sleep/poll then?)
	- clk->usecount already > 0
	  (early return unless clk->flags & DISABLING)
	- do we need the irqsaving spinlock variants?
	  (I assume yes)

Probably there are more.

Best regards
Uwe

[1] last submission: http://thread.gmane.org/gmane.linux.kernel/1073751

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
