From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 2 Feb 2010 09:04:12 +0100
Subject: [PATCH 3/8] imx: BUG in clk_disable if the clock isn't enabled
In-Reply-To: <20100202075401.GA13952@jasper.tkos.co.il>
References: <20100201155625.GA22413@pengutronix.de>
	<1265040095-31656-3-git-send-email-u.kleine-koenig@pengutronix.de>
	<20100202075401.GA13952@jasper.tkos.co.il>
Message-ID: <20100202080412.GA3048@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Baruch,

On Tue, Feb 02, 2010 at 09:54:02AM +0200, Baruch Siach wrote:
> On Mon, Feb 01, 2010 at 05:01:30PM +0100, Uwe Kleine-K?nig wrote:
> > Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> > Cc: Sascha Hauer <kernel@pengutronix.de>
> > Cc: Russell King <linux@arm.linux.org.uk>
> > ---
> >  arch/arm/plat-mxc/clock.c |    1 +
> >  1 files changed, 1 insertions(+), 0 deletions(-)
> > 
> > diff --git a/arch/arm/plat-mxc/clock.c b/arch/arm/plat-mxc/clock.c
> > index 9e8fbd5..de99681 100644
> > --- a/arch/arm/plat-mxc/clock.c
> > +++ b/arch/arm/plat-mxc/clock.c
> > @@ -56,6 +56,7 @@ static void __clk_disable(struct clk *clk)
> >  	__clk_disable(clk->parent);
> >  	__clk_disable(clk->secondary);
> >  
> > +	BUG_ON(!clk->usecount);
> >  	if (!(--clk->usecount) && clk->disable)
> >  		clk->disable(clk);
> 
> Is this necessary? Shouldn't WARN_ON be used instead?
> 
> Citing include/asm-generic/bug.h: "Don't use BUG() or BUG_ON() unless there's 
> really no way out..."
I don't care much.  AFAIK nothing grave happens if a disabled clock is
disabled again provided the disable has a balancing enable.  So the only
reason to use BUG_ON is that it hurts more :-)

I will change it,
thanks Uwe

-- 
Pengutronix e.K.                              | Uwe Kleine-K?nig            |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |
