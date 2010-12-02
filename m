From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 2 Dec 2010 17:48:06 +0100
Subject: [PATCH 06/15] ARM: mxs: Add timer support
In-Reply-To: <AANLkTi=V9he4nWQ773sQ17P+AnXqN9RVHA=nhmUc4X=s@mail.gmail.com>
References: <1290754154-9428-1-git-send-email-shawn.guo@freescale.com>
	<1290754154-9428-7-git-send-email-shawn.guo@freescale.com>
	<20101130161359.GQ20449@pengutronix.de>
	<AANLkTi=V9he4nWQ773sQ17P+AnXqN9RVHA=nhmUc4X=s@mail.gmail.com>
Message-ID: <20101202164806.GT32355@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Shawn (and Thomas),

On Thu, Dec 02, 2010 at 10:44:06PM +0800, Shawn Guo wrote:
> >> +
> >> +static struct clocksource clocksource_mxs = {
> >> + ? ? .name ? ? ? ? ? = "mxs_timer",
> >> + ? ? .rating ? ? ? ? = 200,
> >> + ? ? .read ? ? ? ? ? = timrot_get_cycles,
> >> + ? ? .mask ? ? ? ? ? = CLOCKSOURCE_MASK(32),
> >> + ? ? .shift ? ? ? ? ?= 10,
> >> + ? ? .flags ? ? ? ? ?= CLOCK_SOURCE_IS_CONTINUOUS,
> >> +};
> >> +
> >> +static int __init mxs_clocksource_init(struct clk *timer_clk)
> >> +{
> >> + ? ? unsigned int c = clk_get_rate(timer_clk);
> >> +
> >> + ? ? if (timrot_is_v1())
> >> + ? ? ? ? ? ? clocksource_mxs.mask = CLOCKSOURCE_MASK(16);
> > I wonder if a shift of 10 is a bit heavy for a 16 bit timer.
> >
> I do not understand that.  The shift is used in clocksource_hz2mult() as below.
> 
> static inline u32 clocksource_hz2mult(u32 hz, u32 shift_constant)
> {
>         /*  hz = cyc/(Billion ns)
>          *  mult/2^shift  = ns/cyc
>          *  mult = ns/cyc * 2^shift
>          *  mult = 1Billion/hz * 2^shift
>          *  mult = 1000000000 * 2^shift / hz
>          *  mult = (1000000000<<shift) / hz
>          */
>         u64 tmp = ((u64)1000000000) << shift_constant;
> 
>         tmp += hz/2; /* round for do_div */
>         do_div(tmp, hz);
> 
>         return (u32)tmp;
> }
> 
> The shift is working against the timers frequency (hz).  Should hz be
> the thing concerned here instead of timer bit width?  Since both MX23
> and MX28 timer are running at 32K, so shift value 10 is picked here.
Might be, it's some time ago that I dealt with the clock code.  After
rechecking I think you're right, but now I think 10 is too low :-)

In general a bigger shift increases accuracy at the cost of the range of
values that can be converted (from ticks to ns).  As a 16 bit counter
has a very limited range anyhow you can at least use a high accuracy
without loosing anything.

With shift=10 and tickrate=32k you get mult=0x1e84800, so the maximal
value that (theoretically) occurs is 0xffff * 0x1e84800 = 0x1e84617b800
which is far away from using the available 64 bits.  So (unless I'm
mistaken) the shift value using most of the 64 would be 33 but that
would overflow mult (which is only 32bit wide).  So I'd recommend 17
(resulting in mult=0xf4240000) for both the 16 and the 32 bit case.

Thomas, does this make sense?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
