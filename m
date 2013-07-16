From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 16 Jul 2013 15:52:26 +0200
Subject: [PATCH v7] ARM: clocksource: add support for MOXA ART SoCs
In-Reply-To: <1373024773-24574-1-git-send-email-jonas.jensen@gmail.com>
References: <1373018653-18421-1-git-send-email-jonas.jensen@gmail.com>
 <1373024773-24574-1-git-send-email-jonas.jensen@gmail.com>
Message-ID: <51E5501A.6070403@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/05/2013 01:46 PM, Jonas Jensen wrote:
> This patch adds an clocksource driver for the main timer(s)
> found on MOXA ART SoCs.
> 
> Signed-off-by: Jonas Jensen <jonas.jensen@gmail.com>
> ---
> 
> Notes:
>     Applies to next-20130703
>     
>     Changes since v6:
>     
>     1. remove TIMER_CR read back
>     2. set TIMER_CR from constants
> 

Except for the few comments below, it looks ok for me.

[ ... ]

> + */
> +#define TIMEREG_CR_1_ENABLE	(1 << 0)
> +#define TIMEREG_CR_1_CLOCK	(1 << 1)
> +#define TIMEREG_CR_1_INT	(1 << 2)
> +#define TIMEREG_CR_2_ENABLE	(1 << 3)
> +#define TIMEREG_CR_2_CLOCK	(1 << 4)
> +#define TIMEREG_CR_2_INT	(1 << 5)
> +#define TIMEREG_CR_3_ENABLE	(1 << 6)
> +#define TIMEREG_CR_3_CLOCK	(1 << 7)
> +#define TIMEREG_CR_3_INT	(1 << 8)
> +#define TIMEREG_CR_COUNT_UP	(1 << 9)
> +#define TIMEREG_CR_COUNT_DOWN	(0 << 9)

Could you replace this by the BIT macro ?

[ ... ]

> +
> +	irq = irq_of_parse_and_map(node, 0);
> +	if (irq <= 0)
> +		panic("%s: irq_of_parse_and_map failed\n", node->full_name);
> +
> +	ret = setup_irq(irq, &moxart_timer_irq);
> +	if (ret)
> +		panic("%s: setup_irq failed\n", node->full_name);
> +
> +	clk = of_clk_get(node, 0);
> +	if (IS_ERR(clk))
> +		panic("%s: of_clk_get failed\n", node->full_name);
> +
> +	pclk = clk_get_rate(clk);
> +
> +	if (clocksource_mmio_init(base + TIMER2_BASE + REG_COUNT,
> +				  "moxart_timer", pclk, 200, 32,
> +				  clocksource_mmio_readl_down))
> +		panic("%s: clocksource_mmio_init failed\n", node->full_name);
> +
> +	clock_count_per_tick = DIV_ROUND_CLOSEST(pclk, HZ);
> +
> +	writel(~0, base + TIMER2_BASE + REG_LOAD);
> +	writel(TIMEREG_CR_2_ENABLE, base + TIMER_CR);
> +
> +	moxart_clockevent.cpumask = cpumask_of(0);

	moxart_clockevent.irq = irq;

> +
> +	/*
> +	 * documentation is not publicly available:
> +	 * min_delta / max_delta obtained by trial-and-error,
> +	 * max_delta 0xfffffffe should be ok because count
> +	 * register size is u32
> +	 */
> +	clockevents_config_and_register(&moxart_clockevent, pclk,
> +					0x4, 0xfffffffe);
> +}
> +CLOCKSOURCE_OF_DECLARE(moxart, "moxa,moxart-timer", moxart_timer_init);


Thanks
  -- Daniel


-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
