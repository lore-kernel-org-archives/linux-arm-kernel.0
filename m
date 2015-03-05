From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 05 Mar 2015 15:30:27 +0100
Subject: [PATCH v3 4/5] clocksource: sun5i: Refactor the current code
In-Reply-To: <1425550856-12928-5-git-send-email-maxime.ripard@free-electrons.com>
References: <1425550856-12928-1-git-send-email-maxime.ripard@free-electrons.com>
 <1425550856-12928-5-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <54F86883.7080208@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/05/2015 11:20 AM, Maxime Ripard wrote:
> Refactor the code in order to remove the global variables and split the clock
> source and clock events registration in order to ease the addition of the clock
> notifiers needed to handle the parent clock rate changes.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

FYI, that will conflict with the sun5i fix when setup_irq is registered 
before clockevents_config_and_register.

> +	/* Enable timer0 interrupt */
> +	val = readl(base + TIMER_IRQ_EN_REG);
> +	writel(val | TIMER_IRQ_EN(0), base + TIMER_IRQ_EN_REG);
> +
> +	ret = request_irq(irq, sun5i_timer_interrupt, IRQF_TIMER | IRQF_IRQPOLL,
> +			  "sun5i_timer0", ce);
> +	if (ret) {
> +		pr_err("Unable to register interrupt\n");
> +		goto err_disable_clk;
> +	}
> +
> +	clockevents_config_and_register(&ce->clkevt, rate,
> +					TIMER_SYNC_TICKS, 0xffffffff);
> +
> +	return 0;
> +
> +err_disable_clk:
> +	clk_disable_unprepare(clk);
> +err_free:
> +	kfree(ce);
> +	return ret;
> +}
> +
>   static void __init sun5i_timer_init(struct device_node *node)
>   {
>   	struct reset_control *rstc;
> -	unsigned long rate;
> +	void __iomem *timer_base;
>   	struct clk *clk;
> -	int ret, irq;
> -	u32 val;
> +	int irq;
>
>   	timer_base = of_io_request_and_map(node, 0,
>   					   of_node_full_name(node));
> @@ -150,36 +274,13 @@ static void __init sun5i_timer_init(struct device_node *node)
>   	clk = of_clk_get(node, 0);
>   	if (IS_ERR(clk))
>   		panic("Can't get timer clock");
> -	clk_prepare_enable(clk);
> -	rate = clk_get_rate(clk);
>
>   	rstc = of_reset_control_get(node, NULL);
>   	if (!IS_ERR(rstc))
>   		reset_control_deassert(rstc);
>
> -	writel(~0, timer_base + TIMER_INTVAL_LO_REG(1));
> -	writel(TIMER_CTL_ENABLE | TIMER_CTL_RELOAD,
> -	       timer_base + TIMER_CTL_REG(1));
> -
> -	clocksource_mmio_init(timer_base + TIMER_CNTVAL_LO_REG(1), node->name,
> -			      rate, 340, 32, clocksource_mmio_readl_down);
> -
> -	ticks_per_jiffy = DIV_ROUND_UP(rate, HZ);
> -
> -	ret = request_irq(irq, sun5i_timer_interrupt, IRQF_TIMER | IRQF_IRQPOLL,
> -			  "sun5i_timer0", &sun5i_clockevent);
> -	if (ret)
> -		pr_warn("failed to setup irq %d\n", irq);
> -
> -	/* Enable timer0 interrupt */
> -	val = readl(timer_base + TIMER_IRQ_EN_REG);
> -	writel(val | TIMER_IRQ_EN(0), timer_base + TIMER_IRQ_EN_REG);
> -
> -	sun5i_clockevent.cpumask = cpu_possible_mask;
> -	sun5i_clockevent.irq = irq;
> -
> -	clockevents_config_and_register(&sun5i_clockevent, rate,
> -					TIMER_SYNC_TICKS, 0xffffffff);
> +	sun5i_setup_clocksource(node, timer_base, clk, irq);
> +	sun5i_setup_clockevent(node, timer_base, clk, irq);
>   }
>   CLOCKSOURCE_OF_DECLARE(sun5i_a13, "allwinner,sun5i-a13-hstimer",
>   		       sun5i_timer_init);
>


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
