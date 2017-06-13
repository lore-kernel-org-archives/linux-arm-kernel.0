From: andrew@aj.id.au (Andrew Jeffery)
Date: Tue, 13 Jun 2017 15:40:46 +0930
Subject: [PATCH 2/2] drivers/clocksource/fttmr010: Implement delay timer
In-Reply-To: <20170611212617.6906-2-linus.walleij@linaro.org>
References: <20170611212617.6906-1-linus.walleij@linaro.org>
 <20170611212617.6906-2-linus.walleij@linaro.org>
Message-ID: <1497334246.11158.4.camel@aj.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2017-06-11 at 23:26 +0200, Linus Walleij wrote:
> This timer is often used on the ARM architecture, so as with so
> many siblings, we can implement delay timers, removing the need
> for the system to calibrate jiffys at boot, and potentially
> handling CPU frequency scaling on targets.
> 
> We cannot just protect the Kconfig with a "depends on ARM" because
> it is already known that different architectures are using Faraday
> IP blocks, so it is better to make things open-ended and use

Seems like we're missing the end of the sentence?

> 
> Result on boot dmesg:
> 
> Switching to timer-based delay loop, resolution 40n
> Calibrating delay loop (skipped), value calculated using
> ? timer frequency.. 50.00 BogoMIPS (lpj=250000)
> 
> This is accurately the timer frequency, 250MHz on the APB
> bus.
> 
> > Cc: Andrew Jeffery <andrew@aj.id.au>
> > Cc: Joel Stanley <joel@jms.id.au>
> > Cc: Jonas Jensen <jonas.jensen@gmail.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Tried both patches on an AST2500, everything worked as suggested.

Tested-by: Andrew Jeffery <andrew@aj.id.au>

> ---
> ?drivers/clocksource/timer-fttmr010.c | 35 ++++++++++++++++++++++++++++++++++-
> ?1 file changed, 34 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clocksource/timer-fttmr010.c b/drivers/clocksource/timer-fttmr010.c
> index 5e82469995cb..0074d89cd2ce 100644
> --- a/drivers/clocksource/timer-fttmr010.c
> +++ b/drivers/clocksource/timer-fttmr010.c
> @@ -17,6 +17,7 @@
> ?#include <linux/clk.h>
> ?#include <linux/slab.h>
> ?#include <linux/bitops.h>
> +#include <linux/delay.h>
> ?
> ?/*
> ? * Register definitions for the timers
> @@ -81,9 +82,15 @@ struct fttmr010 {
> > ?	bool count_down;
> > ?	u32 t1_enable_val;
> > ?	struct clock_event_device clkevt;
> +#ifdef CONFIG_ARM
> > +	struct delay_timer delay_timer;
> +#endif
> ?};
> ?
> -/* A local singleton used by sched_clock, which is stateless */
> +/*
> + * A local singleton used by sched_clock and delay timer reads, which are
> + * fast and stateless
> + */
> ?static struct fttmr010 *local_fttmr;
> ?
> ?static inline struct fttmr010 *to_fttmr010(struct clock_event_device *evt)
> @@ -101,6 +108,20 @@ static u64 notrace fttmr010_read_sched_clock_down(void)
> > ?	return ~readl(local_fttmr->base + TIMER2_COUNT);
> ?}
> ?
> +#ifdef CONFIG_ARM
> +
> +static unsigned long fttmr010_read_current_timer_up(void)
> +{
> > +	return readl(local_fttmr->base + TIMER2_COUNT);
> +}
> +
> +static unsigned long fttmr010_read_current_timer_down(void)
> +{
> > +	return ~readl(local_fttmr->base + TIMER2_COUNT);
> +}
> +
> +#endif
> +
> ?static int fttmr010_timer_set_next_event(unsigned long cycles,
> > ?				???????struct clock_event_device *evt)
> ?{
> @@ -349,6 +370,18 @@ static int __init fttmr010_timer_init(struct device_node *np)
> > ?					fttmr010->tick_rate,
> > ?					1, 0xffffffff);
> ?
> +#ifdef CONFIG_ARM
> > +	/* Also use this timer for delays */
> > +	if (fttmr010->count_down)
> > +		fttmr010->delay_timer.read_current_timer =
> > +			fttmr010_read_current_timer_down;
> > +	else
> > +		fttmr010->delay_timer.read_current_timer =
> > +			fttmr010_read_current_timer_up;
> > +	fttmr010->delay_timer.freq = fttmr010->tick_rate;
> > +	register_current_timer_delay(&fttmr010->delay_timer);
> +#endif
> +
> > ?	return 0;
> ?
> ?out_unmap:
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170613/6d7644bf/attachment.sig>
