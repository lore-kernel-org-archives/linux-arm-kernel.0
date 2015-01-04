From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Sun, 04 Jan 2015 19:00:40 +0100
Subject: [PATCH V2 9/9] clocksource: marco: rename marco to atlas7
In-Reply-To: <1420249007-8262-10-git-send-email-21cnbao@gmail.com>
References: <1420249007-8262-1-git-send-email-21cnbao@gmail.com>
 <1420249007-8262-10-git-send-email-21cnbao@gmail.com>
Message-ID: <54A97FC8.7000505@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/03/2015 02:36 AM, Barry Song wrote:
> From: Barry Song <Baohua.Song@csr.com>
>
> marco project is replaced by atlas7 and we should obliterate
> its all traces.
>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Signed-off-by: Barry Song <Baohua.Song@csr.com>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
>   drivers/clocksource/Makefile                          |  2 +-
>   drivers/clocksource/{timer-marco.c => timer-atlas7.c} | 15 +++++++--------
>   2 files changed, 8 insertions(+), 9 deletions(-)
>   rename drivers/clocksource/{timer-marco.c => timer-atlas7.c} (95%)
>
> diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
> index 94d90b2..306bc47 100644
> --- a/drivers/clocksource/Makefile
> +++ b/drivers/clocksource/Makefile
> @@ -18,7 +18,7 @@ obj-$(CONFIG_ARMADA_370_XP_TIMER)	+= time-armada-370-xp.o
>   obj-$(CONFIG_ORION_TIMER)	+= time-orion.o
>   obj-$(CONFIG_ARCH_BCM2835)	+= bcm2835_timer.o
>   obj-$(CONFIG_ARCH_CLPS711X)	+= clps711x-timer.o
> -obj-$(CONFIG_ARCH_MARCO)	+= timer-marco.o
> +obj-$(CONFIG_ARCH_ATLAS7)	+= timer-atlas7.o
>   obj-$(CONFIG_ARCH_MOXART)	+= moxart_timer.o
>   obj-$(CONFIG_ARCH_MXS)		+= mxs_timer.o
>   obj-$(CONFIG_ARCH_PXA)		+= pxa_timer.o
> diff --git a/drivers/clocksource/timer-marco.c b/drivers/clocksource/timer-atlas7.c
> similarity index 95%
> rename from drivers/clocksource/timer-marco.c
> rename to drivers/clocksource/timer-atlas7.c
> index 361a789..60f9de3 100644
> --- a/drivers/clocksource/timer-marco.c
> +++ b/drivers/clocksource/timer-atlas7.c
> @@ -38,7 +38,7 @@
>
>   #define SIRFSOC_TIMER_REG_CNT 6
>
> -static unsigned long marco_timer_rate;
> +static unsigned long atlas7_timer_rate;
>
>   static const u32 sirfsoc_timer_reg_list[SIRFSOC_TIMER_REG_CNT] = {
>   	SIRFSOC_TIMER_WATCHDOG_EN,
> @@ -195,7 +195,7 @@ static int sirfsoc_local_timer_setup(struct clock_event_device *ce)
>   	ce->rating = 200;
>   	ce->set_mode = sirfsoc_timer_set_mode;
>   	ce->set_next_event = sirfsoc_timer_set_next_event;
> -	clockevents_calc_mult_shift(ce, marco_timer_rate, 60);
> +	clockevents_calc_mult_shift(ce, atlas7_timer_rate, 60);
>   	ce->max_delta_ns = clockevent_delta2ns(-2, ce);
>   	ce->min_delta_ns = clockevent_delta2ns(2, ce);
>   	ce->cpumask = cpumask_of(cpu);
> @@ -255,9 +255,8 @@ static void __init sirfsoc_clockevent_init(void)
>   }
>
>   /* initialize the kernel jiffy timer source */
> -static void __init sirfsoc_marco_timer_init(struct device_node *np)
> +static void __init sirfsoc_atlas7_timer_init(struct device_node *np)
>   {
> -	u32 timer_div;
>   	struct clk *clk;
>
>   	clk = of_clk_get(np, 0);
> @@ -265,7 +264,7 @@ static void __init sirfsoc_marco_timer_init(struct device_node *np)
>
>   	BUG_ON(clk_prepare_enable(clk));
>
> -	marco_timer_rate = clk_get_rate(clk);
> +	atlas7_timer_rate = clk_get_rate(clk);
>
>   	/* timer dividers: 0, not divided */
>   	writel_relaxed(0, sirfsoc_timer_base + SIRFSOC_TIMER_64COUNTER_CTRL);
> @@ -283,7 +282,7 @@ static void __init sirfsoc_marco_timer_init(struct device_node *np)
>   	/* Clear all interrupts */
>   	writel_relaxed(0xFFFF, sirfsoc_timer_base + SIRFSOC_TIMER_INTR_STATUS);
>
> -	BUG_ON(clocksource_register_hz(&sirfsoc_clocksource, marco_timer_rate));
> +	BUG_ON(clocksource_register_hz(&sirfsoc_clocksource, atlas7_timer_rate));
>
>   	sirfsoc_clockevent_init();
>   }
> @@ -302,6 +301,6 @@ static void __init sirfsoc_of_timer_init(struct device_node *np)
>   	if (!sirfsoc_timer1_irq.irq)
>   		panic("No irq passed for timer1 via DT\n");
>
> -	sirfsoc_marco_timer_init(np);
> +	sirfsoc_atlas7_timer_init(np);
>   }
> -CLOCKSOURCE_OF_DECLARE(sirfsoc_marco_timer, "sirf,marco-tick", sirfsoc_of_timer_init );
> +CLOCKSOURCE_OF_DECLARE(sirfsoc_atlas7_timer, "sirf,atlas7-tick", sirfsoc_of_timer_init);
>


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
