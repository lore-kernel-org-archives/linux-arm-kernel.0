From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 13 Aug 2010 12:25:05 +0200
Subject: [PATCH v2] mx35: Fix boot ROM hang in internal boot mode
In-Reply-To: <20100813100429.GB22619@local>
References: <20100811233721.GB6411@local>
	<20100812055753.GB9763@pengutronix.de>
	<20100812112938.GB8670@local> <20100812121504.GC8670@local>
	<20100813081720.GA23898@pengutronix.de>
	<20100813100429.GB22619@local>
Message-ID: <20100813102505.GA10658@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Hans,

On Fri, Aug 13, 2010 at 12:04:29PM +0200, Hans J. Koch wrote:
> On Fri, Aug 13, 2010 at 10:17:20AM +0200, Uwe Kleine-K?nig wrote:
> > On Thu, Aug 12, 2010 at 02:15:04PM +0200, Hans J. Koch wrote:
> > > On Thu, Aug 12, 2010 at 01:29:40PM +0200, Hans J. Koch wrote:
> > > > On Thu, Aug 12, 2010 at 07:57:53AM +0200, Uwe Kleine-K?nig wrote:
> > > > > > +	}
> > > > > > +
> > > > > > +	__raw_writel(cgr2, CCM_BASE + CCM_CGR2);
> > > > > > +	__raw_writel(cgr3, CCM_BASE + CCM_CGR3);
> > > > > Note that my question concerning the UART clock was less about UART1 vs
> > > > > UART0 but more if the ROM really needs a UART clock.
> > > > 
> > > > In my tests on an mx35pdk board, I found these three clocks being the
> > > > minimum set of additional clocks that need to be turned on. That means,
> > > > if you turn off any of the three, it won't boot anymore.
> > > 
> > > For my tests, I didn't fully boot the kernel but inserted a while(1) after
> > > the clock init sequence. I had the wachdog already initialized in the
> > > bootloader, so after a few seconds it would boot again - or not.
> > > 
> > > If you fully boot the kernel, then the driver will probably switch on
> > > the UART1 clock, so you don't notice the effect anymore. But the kernel
> > > can hang _before_ drivers come up, and it should still work. That's
> > > what hardware watchdogs are for.
> > > 
> > > As a sidenote, it should be clear that this patch is a workaround for
> > > a serious chip bug of the MX35.
> > From the things you wrote up to now it's possible that this is a
> > bootloader issue, isn't it.
> 
> I discussed that with John. It's at least very unlikely. Given the fact
> that it works in external boot mode, a bootloader bug had to be in the
> code path that's different for the two modes. That code path is very
> small, and there's no hint that the clocks in question are used there.
> 
> > 
> > I don't know exactly what "internal boot mode" means, but assuming the
> > ROM code doesn't make any output to UART1 at least this clock smells
> > like a bootloader problem.
> 
> No. When the bootloader uses the UART for the first time it is already
> in code that's identical for both boot modes.
> 
> > If you're conviced this is a chip problem,
> > did you consider to contact FSL about it?
> 
> Yes, of course. John does that at the moment.
OK, great.

Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
