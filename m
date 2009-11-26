From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 26 Nov 2009 11:18:22 +0100
Subject: [PATCH] [ARM] IMX: don't disable the uart clock if DEBUG_LL
	uses it
In-Reply-To: <20091113094035.GA26215@pengutronix.de>
References: <1258062989-14493-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<20091113075210.GF30179@pengutronix.de>
	<20091113094035.GA26215@pengutronix.de>
Message-ID: <20091126101822.GB3529@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hallo Sascha,

> On Fri, Nov 13, 2009 at 08:52:10AM +0100, Sascha Hauer wrote:
> > On Thu, Nov 12, 2009 at 10:56:29PM +0100, Uwe Kleine-K?nig wrote:
> > > Before the clock was left enabled only for DEBUG_LL_CONSOLE which
> > > requires an additional patch to exist at all.  With this patch applied
> > > DEBUG_LL_CONSOLE depends on DEBUG_LL, so this doesn't break.
> > > 
> > > Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> > > Cc: Sascha Hauer <s.hauer@pengutronix.de>
> > > ---
> > >  arch/arm/mach-mx2/clock_imx21.c |    2 +-
> > >  arch/arm/mach-mx2/clock_imx27.c |    2 +-
> > >  arch/arm/mach-mx3/clock-imx35.c |    2 +-
> > >  3 files changed, 3 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/arch/arm/mach-mx2/clock_imx21.c b/arch/arm/mach-mx2/clock_imx21.c
> > > index eede798..91901b5 100644
> > > --- a/arch/arm/mach-mx2/clock_imx21.c
> > > +++ b/arch/arm/mach-mx2/clock_imx21.c
> > > @@ -1000,7 +1000,7 @@ int __init mx21_clocks_init(unsigned long lref, unsigned long href)
> > >  	clk_enable(&per_clk[0]);
> > >  	clk_enable(&gpio_clk);
> > >  
> > > -#ifdef CONFIG_DEBUG_LL_CONSOLE
> > > +#if defined(CONFIG_DEBUG_LL) && !defined(CONFIG_DEBUG_ICEDCC)
> > 
> > If Catalins/my early printk patch goes in, wouldn't it be better to do
> > a
> > 
> > #if defined(CONFIG_EARLY_PRINTK) && !defined(CONFIG_DEBUG_ICEDCC)
> > 
> > here?
> No, after applying that patch[1] DEBUG_LL still works without
> EARLY_PRINTK and the latter depends on the former, so
> defined(CONFIG_DEBUG_LL) && !defined(CONFIG_DEBUG_ICEDCC) is the right
> thing.
ping

Best regards
Uwe
 
> [1] http://mid.gmane.org/20091105123448.27637.97119.stgit at pc1117.cambridge.arm.com

-- 
Pengutronix e.K.                              | Uwe Kleine-K?nig            |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |
