From: julien.thierry@arm.com (Julien Thierry)
Date: Wed, 18 Oct 2017 09:10:22 +0100
Subject: [PATCH v5 1/4] clocksource: stm32: convert driver to timer_of
In-Reply-To: <1508312614-27750-2-git-send-email-benjamin.gaignard@linaro.org>
References: <1508312614-27750-1-git-send-email-benjamin.gaignard@linaro.org>
 <1508312614-27750-2-git-send-email-benjamin.gaignard@linaro.org>
Message-ID: <8919cadc-2e51-4b31-2836-32c45bbfabfe@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Benjamin,

On 18/10/17 08:43, Benjamin Gaignard wrote:
> Convert driver to use timer_of helpers. This allow to remove
> custom proprietary structure.
> 
> Increase min delta value because if it is too small it could
> generate too much interrupts and the system will not be able
> to catch them all.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
> ---
>   drivers/clocksource/Kconfig       |   1 +
>   drivers/clocksource/timer-stm32.c | 162 +++++++++++++-------------------------
>   2 files changed, 57 insertions(+), 106 deletions(-)
> 
> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> index cc60620..755c0cc 100644
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig
> @@ -289,6 +289,7 @@ config CLKSRC_STM32
>   	bool "Clocksource for STM32 SoCs" if !ARCH_STM32
>   	depends on OF && ARM && (ARCH_STM32 || COMPILE_TEST)
>   	select CLKSRC_MMIO
> +	select TIMER_OF
>   
>   config CLKSRC_MPS2
>   	bool "Clocksource for MPS2 SoCs" if COMPILE_TEST
> diff --git a/drivers/clocksource/timer-stm32.c b/drivers/clocksource/timer-stm32.c
> index 8f24237..abff21c 100644
> --- a/drivers/clocksource/timer-stm32.c
> +++ b/drivers/clocksource/timer-stm32.c

[...]

> -
> -static int __init stm32_clockevent_init(struct device_node *np)
> +static int __init stm32_clockevent_init(struct device_node *node)
>   {
> -	struct stm32_clock_event_ddata *data = &clock_event_ddata;
> -	struct clk *clk;
>   	struct reset_control *rstc;
> -	unsigned long rate, max_delta;
> -	int irq, ret, bits, prescaler = 1;
> -
> -	clk = of_clk_get(np, 0);
> -	if (IS_ERR(clk)) {
> -		ret = PTR_ERR(clk);
> -		pr_err("failed to get clock for clockevent (%d)\n", ret);
> -		goto err_clk_get;
> -	}
> -
> -	ret = clk_prepare_enable(clk);
> -	if (ret) {
> -		pr_err("failed to enable timer clock for clockevent (%d)\n",
> -		       ret);
> -		goto err_clk_enable;
> -	}
> -
> -	rate = clk_get_rate(clk);
> -
> -	rstc = of_reset_control_get(np, NULL);
> +	unsigned long max_delta;
> +	int ret, bits, prescaler = 1;
> +	struct timer_of *to;
> +
> +	to = kzalloc(sizeof(*to), GFP_KERNEL);
> +	if (!to)
> +		return -ENOMEM;
> +
> +	to->flags = TIMER_OF_IRQ | TIMER_OF_CLOCK | TIMER_OF_BASE;
> +	to->clkevt.name = "stm32_clockevent";
> +	to->clkevt.rating = 200;
> +	to->clkevt.features = CLOCK_EVT_FEAT_PERIODIC;
> +	to->clkevt.set_state_shutdown = stm32_clock_event_shutdown;
> +	to->clkevt.set_state_periodic = stm32_clock_event_set_periodic;
> +	to->clkevt.set_state_oneshot = stm32_clock_event_shutdown;
> +	to->clkevt.tick_resume = stm32_clock_event_shutdown;
> +	to->clkevt.set_next_event = stm32_clock_event_set_next_event;
> +
> +	to->of_irq.handler = stm32_clock_event_handler;
> +
> +	ret = timer_of_init(node, to);
> +	if (ret)
> +		return ret;

I don't know if we should keep some "err_*" labels at the end of the 
function, but here there probably should a "kfree(to)" before returning.

Otherwise the patch looks fine to me.

Cheers,

-- 
Julien Thierry
