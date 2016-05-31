From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 31 May 2016 10:24:02 +0200
Subject: [PATCH 2/4] clocksource: sp804: introduce helper
 sp804_load_mode_set()
In-Reply-To: <1464428033-52106-3-git-send-email-wangkefeng.wang@huawei.com>
References: <1464428033-52106-1-git-send-email-wangkefeng.wang@huawei.com>
 <1464428033-52106-3-git-send-email-wangkefeng.wang@huawei.com>
Message-ID: <574D4A22.703@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/28/2016 11:33 AM, Kefeng Wang wrote:
> Introduce helper sp804_load_mode_set(), and use it, prepare for 64bit
> mode timer support.

More verbose please.

> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>   drivers/clocksource/timer-sp804.c | 27 +++++++++++++--------------
>   1 file changed, 13 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/clocksource/timer-sp804.c b/drivers/clocksource/timer-sp804.c
> index 362e5d0..b8848e5 100644
> --- a/drivers/clocksource/timer-sp804.c
> +++ b/drivers/clocksource/timer-sp804.c
> @@ -73,6 +73,15 @@ static long __init sp804_get_clock_rate(struct clk *clk, const char *name)
>   	return rate;
>   }
>
> +static inline void sp804_load_mode_set(void __iomem *base, unsigned long load, int mode)
> +{
> +	unsigned long ctrl = TIMER_CTRL_32BIT | TIMER_CTRL_IE |
> +			     mode | TIMER_CTRL_ENABLE;
> +
> +	writel(load, base + TIMER_LOAD);
> +	writel(ctrl, base + TIMER_CTRL);
> +}
> +
>   static void __iomem *sched_clock_base;
>
>   static u64 notrace sp804_read(void)
> @@ -97,10 +106,8 @@ void __init __sp804_clocksource_and_sched_clock_init(void __iomem *base,
>
>   	/* setup timer 0 as free-running clocksource */
>   	writel(0, base + TIMER_CTRL);
> -	writel(0xffffffff, base + TIMER_LOAD);
>   	writel(0xffffffff, base + TIMER_VALUE);
> -	writel(TIMER_CTRL_32BIT | TIMER_CTRL_ENABLE | TIMER_CTRL_PERIODIC,
> -		base + TIMER_CTRL);
> +	sp804_load_mode_set(base, 0xffffffff, TIMER_CTRL_PERIODIC & ~TIMER_CTRL_IE);

Can you explain this change ?

>   	clocksource_mmio_init(base + TIMER_VALUE, name,
>   		rate, 200, 32, clocksource_mmio_readl_down);
> @@ -143,24 +150,16 @@ static int sp804_shutdown(struct clock_event_device *evt)
>
>   static int sp804_set_periodic(struct clock_event_device *evt)
>   {
> -	unsigned long ctrl = TIMER_CTRL_32BIT | TIMER_CTRL_IE |
> -			     TIMER_CTRL_PERIODIC | TIMER_CTRL_ENABLE;
> -
>   	timer_shutdown(evt);
> -	writel(clkevt_reload, clkevt_base + TIMER_LOAD);
> -	writel(ctrl, clkevt_base + TIMER_CTRL);
> +	sp804_load_mode_set(clkevt_base, clkevt_reload, TIMER_CTRL_PERIODIC);
>   	return 0;
>   }
>
>   static int sp804_set_next_event(unsigned long next,
> -	struct clock_event_device *evt)
> +				struct clock_event_device *evt)
>   {
> -	unsigned long ctrl = TIMER_CTRL_32BIT | TIMER_CTRL_IE |
> -			     TIMER_CTRL_ONESHOT | TIMER_CTRL_ENABLE;
> -
> -	writel(next, clkevt_base + TIMER_LOAD);
> -	writel(ctrl, clkevt_base + TIMER_CTRL);
>
> +	sp804_load_mode_set(clkevt_base, next, TIMER_CTRL_ONESHOT);
>   	return 0;
>   }
>
>


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
