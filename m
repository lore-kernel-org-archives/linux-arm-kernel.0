From: eric.y.miao@gmail.com (Eric)
Date: Tue, 26 Apr 2011 00:25:45 +0800 (CST)
Subject: [patch 08/16] arm: pxa: Use clocksource based sched_clock
In-Reply-To: <20110423205132.325774191@linutronix.de>
References: <20110423205036.795894921@linutronix.de>
	<20110423205132.325774191@linutronix.de>
Message-ID: <alpine.DEB.2.00.1104260023080.27645@localhost6.localdomain6>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Sat, 23 Apr 2011, Thomas Gleixner wrote:

> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
> arch/arm/mach-pxa/time.c |   31 +++----------------------------

I think we need to remove HAVE_SCHED_CLOCK from ARCH_PXA in
arch/arm/Kconfig as well.

Didn't look into other sub-arch, but should be applicable to those
selecting HAVE_SCHED_CLOCK.

> 1 file changed, 3 insertions(+), 28 deletions(-)
>
> Index: linux-2.6-tip/arch/arm/mach-pxa/time.c
> ===================================================================
> --- linux-2.6-tip.orig/arch/arm/mach-pxa/time.c
> +++ linux-2.6-tip/arch/arm/mach-pxa/time.c
> @@ -21,31 +21,8 @@
> #include <asm/div64.h>
> #include <asm/mach/irq.h>
> #include <asm/mach/time.h>
> -#include <asm/sched_clock.h>
> -#include <mach/regs-ost.h>
> -
> -/*
> - * This is PXA's sched_clock implementation. This has a resolution
> - * of at least 308 ns and a maximum value of 208 days.
> - *
> - * The return value is guaranteed to be monotonic in that range as
> - * long as there is always less than 582 seconds between successive
> - * calls to sched_clock() which should always be the case in practice.
> - */
> -static DEFINE_CLOCK_DATA(cd);
> -
> -unsigned long long notrace sched_clock(void)
> -{
> -	u32 cyc = OSCR;
> -	return cyc_to_sched_clock(&cd, cyc, (u32)~0);
> -}
> -
> -static void notrace pxa_update_sched_clock(void)
> -{
> -	u32 cyc = OSCR;
> -	update_sched_clock(&cd, cyc, (u32)~0);
> -}
>
> +#include <mach/regs-ost.h>
>
> #define MIN_OSCR_DELTA 16
>
> @@ -105,7 +82,7 @@ static struct clock_event_device ckevt_p
> 	.set_mode	= pxa_osmr0_set_mode,
> };
>
> -static cycle_t pxa_read_oscr(struct clocksource *cs)
> +static cycle_t notrace pxa_read_oscr(struct clocksource *cs)
> {
> 	return OSCR;
> }
> @@ -115,7 +92,7 @@ static struct clocksource cksrc_pxa_oscr
> 	.rating         = 200,
> 	.read           = pxa_read_oscr,
> 	.mask           = CLOCKSOURCE_MASK(32),
> -	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
> +	.flags		= CLOCK_SOURCE_IS_CONTINUOUS | CLOCK_SOURCE_SCHED_CLOCK,
> };
>
> static struct irqaction pxa_ost0_irq = {
> @@ -132,8 +109,6 @@ static void __init pxa_timer_init(void)
> 	OIER = 0;
> 	OSSR = OSSR_M0 | OSSR_M1 | OSSR_M2 | OSSR_M3;
>
> -	init_sched_clock(&cd, pxa_update_sched_clock, 32, clock_tick_rate);
> -
> 	clocksource_calc_mult_shift(&cksrc_pxa_oscr0, clock_tick_rate, 4);
> 	clockevents_calc_mult_shift(&ckevt_pxa_osmr0, clock_tick_rate, 4);
> 	ckevt_pxa_osmr0.max_delta_ns =
>
>
>
