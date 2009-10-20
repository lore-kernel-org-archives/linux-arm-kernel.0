From: tglx@linutronix.de (Thomas Gleixner)
Date: Tue, 20 Oct 2009 05:50:21 +0200 (CEST)
Subject: [PATCH] Make MIPS dynamic clocksource/clockevent clock code
	generic
In-Reply-To: <1255819715-19763-1-git-send-email-linus.walleij@stericsson.com>
References: <1255819715-19763-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <alpine.LFD.2.00.0910200454300.2863@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 18 Oct 2009, Linus Walleij wrote:
> This moves the clocksource_set_clock() and clockevent_set_clock()
> from the MIPS timer code into clockchips and clocksource where
> it belongs. The patch was triggered by code posted by Mikael
> Pettersson duplicating this code for the IOP ARM system. The
> function signatures where altered slightly to fit into their
> destination header files, unsigned int changed to u32 and inlined.
> 
> Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Mikael Pettersson <mikpe@it.uu.se>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> ---
> Ralf has stated in earlier conversation that this should be moved,
> now we risk duplicating code so let's move it.

Please do not make that functions inline. They are too large and there
is no benefit of inlining them.

> +/**
> + * clockevent_set_clock - dynamically calculates an appropriate shift
> + *			  and mult value for a clocksource given a
> + *			  known clock frequency
> + * @dev:	Clockevent device to initialize
> + * @hz:		Clockevent clock frequency in Hz
> + */
> +static inline void clockevent_set_clock(struct clock_event_device *dev, u32 hz)
> +{
> +	u64 temp;
> +	u32 shift;
> +
> +	/* Find a shift value */
> +	for (shift = 32; shift > 0; shift--) {
> +		temp = (u64) hz << shift;
> +		do_div(temp, NSEC_PER_SEC);
> +		if ((temp >> 32) == 0)
> +			break;
> +	}
> +	dev->shift = shift;
> +	dev->mult = (u32) temp;
> +}
> +
> +
> +static inline void clocksource_set_clock(struct clocksource *cs, u32 hz)
> +{
> +	u64 temp;
> +	u32 shift;
> +
> +	/* Find a shift value */
> +	for (shift = 32; shift > 0; shift--) {
> +		temp = (u64) NSEC_PER_SEC << shift;
> +		do_div(temp, hz);
> +		if ((temp >> 32) == 0)
> +			break;
> +	}
> +	cs->shift = shift;
> +	cs->mult = (u32) temp;
> +}
> +

So that's the same function twice, right ? The reason for it are the
different data structures. So could you please do something like:

void calc_shift_mult(u32 *shift, u32 *mult, u32 hz)
{
	do the magic math
}

and have wrapper inline functions for clocksource and clockevents
around it.

Thanks,

	tglx
