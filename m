From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 18 Nov 2010 09:24:29 +0100
Subject: [PATCH] nomadik: prevent sched_clock() wraparound v4
In-Reply-To: <1290067462-26924-1-git-send-email-linus.walleij@stericsson.com>
References: <1290067462-26924-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20101118082429.GJ8942@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Linus,

On Thu, Nov 18, 2010 at 09:04:22AM +0100, Linus Walleij wrote:
> The current implementation of sched_clock() for the Nomadik
> family is based on the clock source that will wrap around without
> any compensation. Currently on the Ux500 after 1030 seconds.
> 
> Utilize cnt32_to_63 to expand the sched_clock() counter to 63
> bits and introduce a keepwarm() timer to assure that sched clock
> and this cnt32_to_63 is called atleast once every half period.
> 
> When I print out the actual wrap-around time, and using
> a year (3600*24*365 seconds) as minumum wrap limit I get an
> actual wrap-around of:
> sched_clock: using 55 bits @ 8333125 Hz wrap in 416 days
> 
> Cc: Alessandro Rubini <rubini@unipv.it>
> Cc: Colin Cross <ccross@google.com>
> Cc: Rabin Vincent <rabin.vincent@stericsson.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: John Stultz <johnstul@us.ibm.com>
> Cc: Harald Gustafsson <harald.gustafsson@ericsson.com>
> Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
> ---
> Version 4, fixed error found by Rabin:
> 
> - Make sure sched_mult is even, multiplying out the invalid
>   bit 63 like Orion does, and loose the &= removing bit 63
> - Calculate and print the number of days until the counter wraps
>   around properly, we now get 416 days which is in the expected
>   range when we request a minumum of 365 days.
> ---
>  arch/arm/plat-nomadik/timer.c |   91 ++++++++++++++++++++++++++++++++++++-----
>  1 files changed, 81 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm/plat-nomadik/timer.c b/arch/arm/plat-nomadik/timer.c
> index aedf9c1..46a3e01 100644
> --- a/arch/arm/plat-nomadik/timer.c
> +++ b/arch/arm/plat-nomadik/timer.c
> @@ -3,6 +3,7 @@
>   *
>   * Copyright (C) 2008 STMicroelectronics
>   * Copyright (C) 2010 Alessandro Rubini
> + * Copyright (C) 2010 Linus Walleij
>   *
>   * This program is free software; you can redistribute it and/or modify
>   * it under the terms of the GNU General Public License version 2, as
> @@ -16,11 +17,13 @@
>  #include <linux/clk.h>
>  #include <linux/jiffies.h>
>  #include <linux/err.h>
> +#include <linux/cnt32_to_63.h>
> +#include <linux/timer.h>
>  #include <asm/mach/time.h>
>  
>  #include <plat/mtu.h>
>  
> -void __iomem *mtu_base; /* ssigned by machine code */
> +void __iomem *mtu_base; /* Assigned by machine code */
>  
>  /*
>   * Kernel assumes that sched_clock can be called early
> @@ -48,16 +51,82 @@ static struct clocksource nmdk_clksrc = {
>  /*
>   * Override the global weak sched_clock symbol with this
>   * local implementation which uses the clocksource to get some
> - * better resolution when scheduling the kernel. We accept that
> - * this wraps around for now, since it is just a relative time
> - * stamp. (Inspired by OMAP implementation.)
> + * better resolution when scheduling the kernel.
> + *
> + * Because the hardware timer period may be quite short
> + * (32.3 secs on the 133 MHz MTU timer selection on ux500)
> + * and because cnt32_to_63() needs to be called at least once per
> + * half period to work properly, a kernel keepwarm() timer is set up
> + * to ensure this requirement is always met.
> + *
> + * Also the sched_clock timer will wrap around at some point,
> + * here we set it to run continously for a year.
> + */
> +#define SCHED_CLOCK_MIN_WRAP 3600*24*365
> +static struct timer_list cnt32_to_63_keepwarm_timer;
> +static u32 sched_mult;
> +static u32 sched_shift;
> +
> +unsigned long long sched_clock(void)
Before your patch sched_clock was marked notrace.  Did you remove that
on purpose?

> +{
> +	u64 cycles;
> +
> +	if (unlikely(!mtu_base))
> +		return 0;
> +
> +	cycles = cnt32_to_63(-readl(mtu_base + MTU_VAL(0)));
> +	/*
> +	 * sched_mult is guaranteed to be even so will
> +	 * shift out bit 63
> +	 */
> +	return (cycles * sched_mult) >> sched_shift;
> +}
> +
> +/* Just kick sched_clock every so often */
> +static void cnt32_to_63_keepwarm(unsigned long data)
> +{
> +	mod_timer(&cnt32_to_63_keepwarm_timer, round_jiffies(jiffies + data));
> +	(void) sched_clock();
> +}
> +
> +/*
> + * Set up a timer to keep sched_clock():s 32_to_63 algorithm warm
> + * once in half a 32bit timer wrap interval.
>   */
> -unsigned long long notrace sched_clock(void)
> [...]

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
