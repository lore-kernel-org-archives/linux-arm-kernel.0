From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 17 Jan 2017 10:13:58 +0100
Subject: [PATCH] tcb_clksrc: Use 32 bit tcb as sched_clock
In-Reply-To: <20170111135059.21318-1-david.engraf@sysgo.com>
References: <20170111135059.21318-1-david.engraf@sysgo.com>
Message-ID: <e9fa8375-70e9-e621-954e-48c3190171ad@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/01/2017 14:50, David Engraf wrote:
> On newer boards the TC can be read as single 32 bit value without locking.
> Thus the clock can be used as reference for sched_clock which is much more
> accurate than the jiffies implementation.
> 
> Tested on a Atmel SAMA5D2 board.

Is this change backward compatible ?

> Signed-off-by: David Engraf <david.engraf@sysgo.com>
> ---
>  drivers/clocksource/tcb_clksrc.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clocksource/tcb_clksrc.c b/drivers/clocksource/tcb_clksrc.c
> index d4ca996..745844e 100644
> --- a/drivers/clocksource/tcb_clksrc.c
> +++ b/drivers/clocksource/tcb_clksrc.c
> @@ -10,6 +10,7 @@
>  #include <linux/io.h>
>  #include <linux/platform_device.h>
>  #include <linux/atmel_tc.h>
> +#include <linux/sched_clock.h>
>  
>  
>  /*
> @@ -56,11 +57,16 @@ static u64 tc_get_cycles(struct clocksource *cs)
>  	return (upper << 16) | lower;
>  }
>  
> -static u64 tc_get_cycles32(struct clocksource *cs)
> +static u32 tc_get_cv32(void)
>  {
>  	return __raw_readl(tcaddr + ATMEL_TC_REG(0, CV));
>  }
>  
> +static u64 tc_get_cycles32(struct clocksource *cs)
> +{
> +	return tc_get_cv32();
> +}
> +
>  static struct clocksource clksrc = {
>  	.name           = "tcb_clksrc",
>  	.rating         = 200,
> @@ -69,6 +75,11 @@ static struct clocksource clksrc = {
>  	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
>  };
>  
> +static u64 notrace tc_read_sched_clock(void)
> +{
> +	return tc_get_cv32();
> +}
> +
>  #ifdef CONFIG_GENERIC_CLOCKEVENTS
>  
>  struct tc_clkevt_device {
> @@ -339,6 +350,9 @@ static int __init tcb_clksrc_init(void)
>  		clksrc.read = tc_get_cycles32;
>  		/* setup ony channel 0 */
>  		tcb_setup_single_chan(tc, best_divisor_idx);
> +
> +		/* register sched_clock on chips with single 32 bit counter */
> +		sched_clock_register(tc_read_sched_clock, 32, divided_rate);
>  	} else {
>  		/* tclib will give us three clocks no matter what the
>  		 * underlying platform supports.
> 


-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
