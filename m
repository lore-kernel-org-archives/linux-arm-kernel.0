From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 19 Feb 2010 10:21:54 +0100
Subject: [PATCH 03/14] ARM: LPC32XX: Clock driver
In-Reply-To: <083DF309106F364B939360100EC290F805CCD42BF8@eu1rdcrdc1wx030.exi.nxp.com>
References: <1265674295-23996-1-git-send-email-wellsk40@gmail.com>
	<1265674295-23996-4-git-send-email-wellsk40@gmail.com>
	<20100209103918.GD2284@pengutronix.de>
	<083DF309106F364B939360100EC290F805CCD42BF8@eu1rdcrdc1wx030.exi.nxp.com>
Message-ID: <20100219092154.GA13068@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Kevin,

On Fri, Feb 19, 2010 at 01:42:30AM +0100, Kevin Wells wrote:
> > > +
> > > +static inline void clk_unlock(void)
> > > +{
> > > +	mutex_unlock(&clkm_lock);
> > > +}
> > > +
> > > +static void local_clk_disable(struct clk *clk)
> > > +{
> > > +	/* Don't attempt to disable clock if it has no users */
> > WARN_ON(clk->usecount <= 0)?
> 
> Is the expectation that the driver will always enable a clock
> prior to disabling it and balance each disable with a previous
> enable?
Quoting include/linux/clk.h:

	 * Implementation detail: if the clock source is shared between
	 * multiple drivers, clk_enable() calls must be balanced by the
	 * same number of clk_disable() calls for the clock source to be
	 * disabled.
	 */

This doesn't answer your complete question, but yes, a driver that
havn't enabled a clk must not disable it.

>         I'm seeing a specific case of disable first, some
> register accesses, and then clock enable on the amba clcd
> driver (the warning fires on the first disable before enable).
> 
> [<c002b098>] (clk_disable+0x0/0x34) from [<c014555c>] (clcdfb_disable+0xa8/0xb0)
>  r5:00000000 r4:c3c10400
> [<c01454b4>] (clcdfb_disable+0x0/0xb0) from [<c014570c>] (clcdfb_set_par+0x50/0xe8)
>  r6:00000028 r5:c3c10400 r4:c3c10400
> [<c01456bc>] (clcdfb_set_par+0x0/0xe8) from [<c0140884>] (fbcon_init+0x2f4/0x42c)
So yes, this is a bug.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
