From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 17 Jul 2013 00:19:34 +0100
Subject: [PATCH] bcm53xx: initial support for the BCM5301/BCM470X SoC
 with ARM CPU
In-Reply-To: <20130716172023.64337690@skate>
References: <1373982727-5492-1-git-send-email-hauke@hauke-m.de>
 <20130716172023.64337690@skate>
Message-ID: <20130716231934.GH24642@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 16, 2013 at 05:20:23PM +0200, Thomas Petazzoni wrote:
> Dear Hauke Mehrtens,
> 
> On Tue, 16 Jul 2013 15:52:07 +0200, Hauke Mehrtens wrote:
> > +static int bcm53xx_abort_handler(unsigned long addr, unsigned int fsr,
> > +				 struct pt_regs *regs)
> > +{
> > +	/*
> > +	 * These happen for no good reason
> > +	 * possibly left over from CFE
> 
> CFE ?
> 
> > +	 */
> > +	pr_warn("External imprecise Data abort at addr=%#lx, fsr=%#x ignored.\n",
> > +		addr, fsr);
> > +
> > +	/* Returning non-zero causes fault display and panic */
> > +	return 0;
> > +}
> > +
> > +static void bcm53xx_aborts_enable(void)
> > +{
> > +	/* Install our hook */
> > +	hook_fault_code(16 + 6, bcm53xx_abort_handler, SIGBUS, 0,
> > +			"imprecise external abort");
> > +}
> > +
> > +static void __init bcm53xx_timer_init(void)
> > +{
> > +	of_clk_init(NULL);
> > +	clocksource_of_init();
> > +}
> > +
> > +void __init bcm53xx_map_io(void)
> > +{
> > +	debug_ll_io_init();
> > +	bcm53xx_aborts_enable();
> > +}
> 
> That's a nitpick, but I personally tend to like when callbacks are
> ordered as they are called, i.e ->map_io() first, and then
> ->init_time().

A more important nitpick is... it would be better to have the call to
the aborts enable function in the init_early() callback, not the map_io()
callback.  Too often people overload stuff into these specific callbacks
which makes maintanence of non-platform code pain in the butt.

The init_early() callback was specifically added by me to remove this
kind of crappage of map_io().  Please use it.  Thanks.
