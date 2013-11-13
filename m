From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Wed, 13 Nov 2013 10:16:48 +0800
Subject: [PATCH 3/4] ARM: mmp: stop using mach/timex.h
In-Reply-To: <1384292466-31725-4-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1384292466-31725-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1384292466-31725-4-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <CAN1soZzSEgy1nz4NK_R8WLLCT3=CjDucQLryDYJA55aoQKWQMw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 13, 2013 at 5:41 AM, Uwe Kleine-K?nig
<u.kleine-koenig@pengutronix.de> wrote:
> mach/timex.h is the last remaining header that is unused for multiarch
> builds but necessary for singlearch builds. To allow to get rid of it
> for singlearch builds, too, drop its usage in mmp arch code by
> substituting CLOCK_TICK_RATE by a local cpp symbol.
>
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
>  arch/arm/mach-mmp/time.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/mach-mmp/time.c b/arch/arm/mach-mmp/time.c
> index 7ac41e8..fb57d11 100644
> --- a/arch/arm/mach-mmp/time.c
> +++ b/arch/arm/mach-mmp/time.c
> @@ -39,6 +39,12 @@
>
>  #include "clock.h"
>
> +#ifdef CONFIG_CPU_MMP2
> +#define MMP_CLOCK_FREQ         6500000
> +#else
> +#define MMP_CLOCK_FREQ         3250000
> +#endif
> +
>  #define TIMERS_VIRT_BASE       TIMERS1_VIRT_BASE
>
>  #define MAX_DELTA              (0xfffffffe)
> @@ -195,14 +201,14 @@ void __init timer_init(int irq)
>  {
>         timer_config();
>
> -       setup_sched_clock(mmp_read_sched_clock, 32, CLOCK_TICK_RATE);
> +       setup_sched_clock(mmp_read_sched_clock, 32, MMP_CLOCK_FREQ);
>
>         ckevt.cpumask = cpumask_of(0);
>
>         setup_irq(irq, &timer_irq);
>
> -       clocksource_register_hz(&cksrc, CLOCK_TICK_RATE);
> -       clockevents_config_and_register(&ckevt, CLOCK_TICK_RATE,
> +       clocksource_register_hz(&cksrc, MMP_CLOCK_FREQ);
> +       clockevents_config_and_register(&ckevt, MMP_CLOCK_FREQ,
>                                         MIN_DELTA, MAX_DELTA);
>  }
>
> --
> 1.8.4.2
>

Acked-by: Haojian Zhuang <haojian.zhuang@gmail.com>
