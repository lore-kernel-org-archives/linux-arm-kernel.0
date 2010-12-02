From: tglx@linutronix.de (Thomas Gleixner)
Date: Thu, 2 Dec 2010 16:20:16 +0100 (CET)
Subject: [PATCH 06/15] ARM: mxs: Add timer support
In-Reply-To: <AANLkTi=V9he4nWQ773sQ17P+AnXqN9RVHA=nhmUc4X=s@mail.gmail.com>
References: <1290754154-9428-1-git-send-email-shawn.guo@freescale.com>
	<1290754154-9428-7-git-send-email-shawn.guo@freescale.com>
	<20101130161359.GQ20449@pengutronix.de>
	<AANLkTi=V9he4nWQ773sQ17P+AnXqN9RVHA=nhmUc4X=s@mail.gmail.com>
Message-ID: <alpine.LFD.2.00.1012021614510.2653@localhost6.localdomain6>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2 Dec 2010, Shawn Guo wrote:

> Hi Uwe,
> 
> 2010/12/1 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> > Hello Shawn,
> >
> [...]
> >> +
> >> + ? ? /* Disable interrupt in timer module */
> >> + ? ? timrot_irq_disable();
> >> +
> >> + ? ? if (mode != clockevent_mode) {
> >> + ? ? ? ? ? ? /* Set event time into far-far future */
> >> + ? ? ? ? ? ? __raw_writel(__raw_readl(timer_base +
> >> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? HW_TIMROT_RUNNING_COUNTn(0)) + 3,
> >> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? timer_base + HW_TIMROT_MATCH_COUNTn(0));
> > I don't know if this is needed, maybe there cannot be a pending event
> > when set_mode is called? ?Thomas?
> >
> Freescale BSP works well without this.  It's probably not needed.

There is no guarantee, that there is no event pending. Especially not
when we shutdown the timer. And the observation that the Fleescale
stuff did not explode yet does not prove anything.
 
> > I wonder if a shift of 10 is a bit heavy for a 16 bit timer.
> >
> I do not understand that.  The shift is used in clocksource_hz2mult() as below.
> 
> static inline u32 clocksource_hz2mult(u32 hz, u32 shift_constant)

Use clocksource_register_hz() or clocksource_register_khz() and let
the clocksource code decide the shift and mult value.

Thanks,

	tglx
