From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 13 Jun 2016 16:35:02 +0200
Subject: [PATCH v2 1/2] clocksource: Add Oxford Semiconductor RPS Dual
 Timer
In-Reply-To: <1465315452-20599-2-git-send-email-narmstrong@baylibre.com>
References: <1465315452-20599-1-git-send-email-narmstrong@baylibre.com>
 <1465315452-20599-2-git-send-email-narmstrong@baylibre.com>
Message-ID: <20160613143502.GD10634@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 07, 2016 at 06:04:11PM +0200, Neil Armstrong wrote:
> Add clocksource and clockevent driver from dual RPS timer.
> The HW provides a dual one-shot or periodic 24bit timers,
> the drivers set the first one as tick event source and the
> second as a continuous scheduler clock source.
> The timer can use 1, 16 or 256 as pre-dividers, thus the
> clocksource uses 16 by default.
> 
> CC: Ma Haijun <mahaijuns@gmail.com>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  drivers/clocksource/Kconfig           |   6 +
>  drivers/clocksource/Makefile          |   1 +
>  drivers/clocksource/timer-oxnas-rps.c | 270 ++++++++++++++++++++++++++++++++++
>  3 files changed, 277 insertions(+)
>  create mode 100644 drivers/clocksource/timer-oxnas-rps.c
> 
> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> index 47352d2..7e382c5 100644
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig
> @@ -293,6 +293,12 @@ config VF_PIT_TIMER
>  	help
>  	  Support for Period Interrupt Timer on Freescale Vybrid Family SoCs.
>  
> +config OXNAS_RPS_TIMER

   config OXNAS_RPS_TIMER "bla bla" if COMPILE_TEST

> +	bool
> +	select CLKSRC_MMIO
> +	help
> +	  This enables support for the Oxford Semiconductor OXNAS RPS timers.
> +
> @@ -0,0 +1,270 @@
> +/*
> + * drivers/clocksource/timer-oxnas-rps.c
> + *
> + * Copyright (C) 2009 Oxford Semiconductor Ltd
> + * Copyright (C) 2013 Ma Haijun <mahaijuns@gmail.com>

What are these two copyrights ?

[ ... ]

> +static void __init oxnas_rps_timer_init(struct device_node *np)
> +{
> +	struct oxnas_rps_timer *rps;
> +	void __iomem *base;
> +	int ret;
> +
> +	rps = kzalloc(sizeof(*rps), GFP_KERNEL);
> +	if (WARN_ON(!rps))

It is pointless to add a WARN_ON, kzalloc already does that on failure.

> +		return;
> +
> +	rps->clk = of_clk_get(np, 0);
> +	if (WARN_ON(IS_ERR(rps->clk)))
> +		return;
> +
> +	if (WARN_ON(clk_prepare_enable(rps->clk)))
> +		goto err;
> +
> +	base = of_iomap(np, 0);
> +	if (WARN_ON(!base))
> +		goto err;
> +
> +
> +	rps->irq = irq_of_parse_and_map(np, 0);
> +	if (WARN_ON(rps->irq < 0))
> +		goto err;
> +
> +	rps->clkevt_base = base + TIMER1_REG_OFFSET;
> +	rps->clksrc_base = base + TIMER2_REG_OFFSET;
> +
> +	/* Disable timers */
> +	writel_relaxed(0, rps->clkevt_base + TIMER_CTRL_REG);
> +	writel_relaxed(0, rps->clksrc_base + TIMER_CTRL_REG);
> +	writel_relaxed(0, rps->clkevt_base + TIMER_LOAD_REG);
> +	writel_relaxed(0, rps->clksrc_base + TIMER_LOAD_REG);
> +	writel_relaxed(0, rps->clkevt_base + TIMER_CLRINT_REG);
> +	writel_relaxed(0, rps->clksrc_base + TIMER_CLRINT_REG);
> +
> +	ret = request_irq(rps->irq, oxnas_rps_timer_irq,
> +			  IRQF_TIMER | IRQF_IRQPOLL,
> +			  "rps-timer", rps);
> +	if (WARN_ON(ret))
> +		goto err;
> +
> +	oxnas_rps_clockevent_init(rps);
> +	oxnas_rps_clocksource_init(rps);
> +
> +	return;

err_iounmap:
	iounmap(base);

err_clk_unprepare:
	clk_unprepare(rps->clk)

err_clk_put:
> +	clk_put(rps->clk);
> +	kfree(rps);
> +}

Regarding the current work I am doing to change the init function to return 
an error in case of failure, can you do proper error handling in this 
function and rollback ?

1. replace WARN_ON by a pr_err
2. make oxnas_rps_clockevent_init and oxnas_rps_clocksource_init to return 
an error code
3. rollback clockevent or clocksource if one fails.

Thanks !

  -- Daniel

> +
> +CLOCKSOURCE_OF_DECLARE(ox810se_rps,
> +		       "oxsemi,ox810se-rps-timer", oxnas_rps_timer_init);
> -- 
> 1.9.1
> 
