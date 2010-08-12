From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 12 Aug 2010 07:39:05 +0200
Subject: [PATCH] mx35: Fix boot ROM hang in internal boot mode
In-Reply-To: <20100811232013.GA6411@local>
References: <20100811001931.GA4626@local>
	<20100811052749.GA7803@pengutronix.de>
	<20100811232013.GA6411@local>
Message-ID: <20100812053905.GA9763@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Hans,

On Thu, Aug 12, 2010 at 01:20:14AM +0200, Hans J. Koch wrote:
> > > diff --git a/arch/arm/mach-mx3/clock-imx35.c b/arch/arm/mach-mx3/clock-imx35.c
> > > index d3af0fd..671acb6 100644
> > > --- a/arch/arm/mach-mx3/clock-imx35.c
> > > +++ b/arch/arm/mach-mx3/clock-imx35.c
> > > @@ -485,7 +485,7 @@ static struct clk_lookup lookups[] = {
> > >  
> > >  int __init mx35_clocks_init()
> > >  {
> > > -	unsigned int ll = 0;
> > > +	unsigned int ll = 0, cgr2, cgr3;
> > >  
> > >  #if defined(CONFIG_DEBUG_LL) && !defined(CONFIG_DEBUG_ICEDCC)
> > >  	ll = (3 << 16);
> > > @@ -499,8 +499,22 @@ int __init mx35_clocks_init()
> > >  	__raw_writel((3 << 18), CCM_BASE + CCM_CGR0);
> > >  	__raw_writel((3 << 2) | (3 << 4) | (3 << 6) | (3 << 8) | (3 << 16),
> > >  			CCM_BASE + CCM_CGR1);
> > > -	__raw_writel((3 << 26) | ll, CCM_BASE + CCM_CGR2);
> > > -	__raw_writel(0, CCM_BASE + CCM_CGR3);
> > > +
> > > +	/* Check if we came up in internal boot mode. If yes, we need some
> > <nitpick> /* on an extra line please. </nitpick>
> 
> alright, if you like it...
> 
> > 
> > > +	 * extra clocks turned on, otherwise the MX35 boot ROM code will
> > > +	 * hang after a watchdog reset.
> > > +	 */
> > Better move the comment into the else branch below.
> 
> There's no else branch anymore. Before the "if" the comment says what's
> being checked, and in the if branch the comment says what's being done.
> 
> > 
> > > +	if (__raw_readl(CCM_BASE + CCM_RCSR) & (3 << 10)) {
> > Can you please introduce a symbol for (3 << 10)?.
> 
> I just wanted to follow the style of the rest of the file ;-)
:-)

> Since you say you've got those #defines on your todo list, I better
> leave that to you.
> 
> > 
> > > +		cgr2 = (3 << 26);
> > > +		cgr3 = 0;
> > > +	} else {
> > > +		/* Additionally turn on UART1, SCC, and IIM clocks */
> > really UART1?
> 
> Well, stupid reference manual. They name the UARTs 1,2,3 instead of 0,1,2.
> That also leads to lines like:
> 
> _REGISTER_CLOCK("imx-uart.0", NULL, uart1_clk)
> 
> I renamed it UART0 in the comment to make it more clear.
Actually I already thought about fixing that.  (On the software side
obviously.)  There are only little problems and one bigger to make them
match.  The bigger one is that it breaks people's kernel commandlines
that usually say:

	console=ttymxc0...

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
