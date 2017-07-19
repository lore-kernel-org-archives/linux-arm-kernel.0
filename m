From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Wed, 19 Jul 2017 11:29:44 +0200
Subject: [PATCH] clocksource: Convert to using %pOF instead of full_name
In-Reply-To: <20170718214339.7774-13-robh@kernel.org>
References: <20170718214339.7774-13-robh@kernel.org>
Message-ID: <02732221-9a0c-079d-1e03-57427c7520fd@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On 07/18/2017 11:42 PM, Rob Herring wrote:
> Now that we have a custom printf format specifier, convert users of
> full_name to use %pOF instead. This is preparation to remove storing
> of the full path string for each node.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
> Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> Cc: Alexandre Torgue <alexandre.torgue@st.com>
> Cc: linux-arm-kernel at lists.infradead.org
> ---
>   drivers/clocksource/tango_xtal.c  |  6 +++---
>   drivers/clocksource/timer-of.c    | 11 +++++------
>   drivers/clocksource/timer-probe.c |  3 +--
>   drivers/clocksource/timer-stm32.c |  8 ++++----
>   4 files changed, 13 insertions(+), 15 deletions(-)

For timer-stm32:

Acked-by: Alexandre TORGUE <alexandre.torgue@st.com>

regards
Alex

> 
> diff --git a/drivers/clocksource/tango_xtal.c b/drivers/clocksource/tango_xtal.c
> index c4e1c2e6046f..6a8d9838ce33 100644
> --- a/drivers/clocksource/tango_xtal.c
> +++ b/drivers/clocksource/tango_xtal.c
> @@ -26,13 +26,13 @@ static int __init tango_clocksource_init(struct device_node *np)
> 
>   	xtal_in_cnt = of_iomap(np, 0);
>   	if (xtal_in_cnt == NULL) {
> -		pr_err("%s: invalid address\n", np->full_name);
> +		pr_err("%pOF: invalid address\n", np);
>   		return -ENXIO;
>   	}
> 
>   	clk = of_clk_get(np, 0);
>   	if (IS_ERR(clk)) {
> -		pr_err("%s: invalid clock\n", np->full_name);
> +		pr_err("%pOF: invalid clock\n", np);
>   		return PTR_ERR(clk);
>   	}
> 
> @@ -43,7 +43,7 @@ static int __init tango_clocksource_init(struct device_node *np)
>   	ret = clocksource_mmio_init(xtal_in_cnt, "tango-xtal", xtal_freq, 350,
>   				    32, clocksource_mmio_readl_up);
>   	if (ret) {
> -		pr_err("%s: registration failed\n", np->full_name);
> +		pr_err("%pOF: registration failed\n", np);
>   		return ret;
>   	}
> 
> diff --git a/drivers/clocksource/timer-of.c b/drivers/clocksource/timer-of.c
> index f6e7491c873c..a07b923d3d6e 100644
> --- a/drivers/clocksource/timer-of.c
> +++ b/drivers/clocksource/timer-of.c
> @@ -44,7 +44,7 @@ static __init int timer_irq_init(struct device_node *np,
>   	of_irq->irq = of_irq->name ? of_irq_get_byname(np, of_irq->name):
>   		irq_of_parse_and_map(np, of_irq->index);
>   	if (!of_irq->irq) {
> -		pr_err("Failed to map interrupt for %s\n", np->full_name);
> +		pr_err("Failed to map interrupt for %pOF\n", np);
>   		return -EINVAL;
>   	}
> 
> @@ -55,8 +55,7 @@ static __init int timer_irq_init(struct device_node *np,
>   			    of_irq->flags ? of_irq->flags : IRQF_TIMER,
>   			    np->full_name, clkevt);
>   	if (ret) {
> -		pr_err("Failed to request irq %d for %s\n", of_irq->irq,
> -		       np->full_name);
> +		pr_err("Failed to request irq %d for %pOF\n", of_irq->irq, np);
>   		return ret;
>   	}
> 
> @@ -80,20 +79,20 @@ static __init int timer_clk_init(struct device_node *np,
>   	of_clk->clk = of_clk->name ? of_clk_get_by_name(np, of_clk->name) :
>   		of_clk_get(np, of_clk->index);
>   	if (IS_ERR(of_clk->clk)) {
> -		pr_err("Failed to get clock for %s\n", np->full_name);
> +		pr_err("Failed to get clock for %pOF\n", np);
>   		return PTR_ERR(of_clk->clk);
>   	}
> 
>   	ret = clk_prepare_enable(of_clk->clk);
>   	if (ret) {
> -		pr_err("Failed for enable clock for %s\n", np->full_name);
> +		pr_err("Failed for enable clock for %pOF\n", np);
>   		goto out_clk_put;
>   	}
> 
>   	of_clk->rate = clk_get_rate(of_clk->clk);
>   	if (!of_clk->rate) {
>   		ret = -EINVAL;
> -		pr_err("Failed to get clock rate for %s\n", np->full_name);
> +		pr_err("Failed to get clock rate for %pOF\n", np);
>   		goto out_clk_disable;
>   	}
> 
> diff --git a/drivers/clocksource/timer-probe.c b/drivers/clocksource/timer-probe.c
> index da81e5de74fe..028075720334 100644
> --- a/drivers/clocksource/timer-probe.c
> +++ b/drivers/clocksource/timer-probe.c
> @@ -40,8 +40,7 @@ void __init timer_probe(void)
> 
>   		ret = init_func_ret(np);
>   		if (ret) {
> -			pr_err("Failed to initialize '%s': %d\n",
> -			       of_node_full_name(np), ret);
> +			pr_err("Failed to initialize '%pOF': %d\n", np, ret);
>   			continue;
>   		}
> 
> diff --git a/drivers/clocksource/timer-stm32.c b/drivers/clocksource/timer-stm32.c
> index 174d1243ea93..8f2423789ba9 100644
> --- a/drivers/clocksource/timer-stm32.c
> +++ b/drivers/clocksource/timer-stm32.c
> @@ -138,7 +138,7 @@ static int __init stm32_clockevent_init(struct device_node *np)
>   	irq = irq_of_parse_and_map(np, 0);
>   	if (!irq) {
>   		ret = -EINVAL;
> -		pr_err("%s: failed to get irq.\n", np->full_name);
> +		pr_err("%pOF: failed to get irq.\n", np);
>   		goto err_get_irq;
>   	}
> 
> @@ -168,12 +168,12 @@ static int __init stm32_clockevent_init(struct device_node *np)
>   	ret = request_irq(irq, stm32_clock_event_handler, IRQF_TIMER,
>   			"stm32 clockevent", data);
>   	if (ret) {
> -		pr_err("%s: failed to request irq.\n", np->full_name);
> +		pr_err("%pOF: failed to request irq.\n", np);
>   		goto err_get_irq;
>   	}
> 
> -	pr_info("%s: STM32 clockevent driver initialized (%d bits)\n",
> -			np->full_name, bits);
> +	pr_info("%pOF: STM32 clockevent driver initialized (%d bits)\n",
> +			np, bits);
> 
>   	return ret;
> 
> --
> 2.11.0
> 
