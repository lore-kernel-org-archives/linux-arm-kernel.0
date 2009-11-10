From: tglx@linutronix.de (Thomas Gleixner)
Date: Tue, 10 Nov 2009 18:03:40 +0100 (CET)
Subject: [PATCH] Make MIPS dynamic clocksource/clockevent clock code
	generic v2
In-Reply-To: <1256078002-27919-1-git-send-email-linus.walleij@stericsson.com>
References: <1256078002-27919-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <alpine.LFD.2.00.0911101734440.2897@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 21 Oct 2009, Linus Walleij wrote:

> This moves the clocksource_set_clock() and clockevent_set_clock()
> from the MIPS timer code into clockchips and clocksource where
> it belongs. The patch was triggered by code posted by Mikael
> Pettersson duplicating this code for the IOP ARM system. The
> function signatures where altered slightly to fit into their
> destination header files, unsigned int changed to u32 and inlined.
> 
> Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Tested-by: Mikael Pettersson <mikpe@it.uu.se>
> Reviewed-by: Ralf Baechle <ralf@linux-mips.org>
> ---
> Changes v1->v2:
> - Fixed Mikaels comments: spelling, terminology.
> - Kept the functions inline: all uses and foreseen uses
>   are once per kernel and all are in __init or __cpuinit sections.

Not entirely true. We have the ability to dynamically switch on/off
clocksources/events which might also change the clock frequency and
requires recalculation of those factors.

> - Unable to break out common code - the code is not common and
>   implementing two execution paths will be more awkward.

Come on. It's not rocket science to implement it as a common function
with two inline wrappers for clock sources and clock events.

> - Hoping the tglx likes it anyway.

I looked in more detail and I found a flaw which is already in the
MIPS implementation:

Both functions assume that the resulting shift/mult is chosen in way
that the input value to the runtime conversion functions is always
less than (1 << 32) nano seconds.

That limits NOHZ to sleeps of ~ 4 seconds. We had already discussions
about sleep times which are in the 10 to 20 seconds range and power
saving folks definitely want to extend this even further.

The tradeoff for the clock conversion is accuracy, but we don't want
to impose the maximum accuracy policy on everyone who wants to use the
runtime conversion factor setup functions.

I have a function coded which takes the maximum desired time span of
the conversion into account, but I need to think more about how we
define it. Runtime requested by the caller, some global Kconfig switch
or whatever is the best.

Thanks,

	tglx
