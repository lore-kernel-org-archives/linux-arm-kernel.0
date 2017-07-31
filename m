From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 31 Jul 2017 16:29:13 +0200
Subject: [PATCH V4 2/2] timer: imx-tpm: add imx tpm timer support
In-Reply-To: <1499222112-9988-3-git-send-email-aisheng.dong@nxp.com>
References: <1499222112-9988-1-git-send-email-aisheng.dong@nxp.com>
 <1499222112-9988-3-git-send-email-aisheng.dong@nxp.com>
Message-ID: <d10c57c3-3174-3dbf-c784-ef1ff94cb06e@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/07/2017 04:35, Dong Aisheng wrote:
> IMX Timer/PWM Module (TPM) supports both timer and pwm function while
> this patch only adds the timer support. PWM would be added later.
> 
> The TPM counter, compare and capture registers are clocked by an
> asynchronous clock that can remain enabled in low power modes.
> 
> NOTE: We observed in a very small probability, the bus fabric
> contention between GPU and A7 may results a few cycles delay
> of writing CNT registers which may cause the min_delta event got
> missed, so we need add a ETIME check here in case it happened.
> 
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Anson Huang <Anson.Huang@nxp.com>
> Cc: Bai Ping <ping.bai@nxp.com>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> 
> ---
> ChangeLog:
> v3->v4: 
>  * also add ETIME explanation in function
> v2->v3:
>  * address all comments from Daniel Lezcano
>  * add more explaination on ETIME check in commit message
> v1->v2:
>  * change to readl/writel from __raw_readl/writel according to Arnd's
>    suggestion to avoid endian issue
>  * add help information in Kconfig
>  * add more error checking
> ---
>  drivers/clocksource/Kconfig         |   8 ++
>  drivers/clocksource/Makefile        |   1 +
>  drivers/clocksource/timer-imx-tpm.c | 239 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 248 insertions(+)
>  create mode 100644 drivers/clocksource/timer-imx-tpm.c

[ ... ]

> +static struct irqaction tpm_timer_irq = {
> +	.name		= "i.MX7ULP TPM Timer",
> +	.flags		= IRQF_TIMER | IRQF_IRQPOLL,
> +	.handler	= tpm_timer_interrupt,
> +	.dev_id		= &clockevent_tpm,
> +};
>

Please remove the structure above and use request_irq instead of
setup_irq below + return code checking.

> +static int __init tpm_clockevent_init(unsigned long rate, int irq)
> +{
> +	setup_irq(irq, &tpm_timer_irq);
> +
> +	clockevent_tpm.cpumask = cpumask_of(0);
> +	clockevent_tpm.irq = irq;
> +	clockevents_config_and_register(&clockevent_tpm,
> +					rate, 300, 0xfffffffe);
> +
> +	return 0;
> +}
> +
> +static int __init tpm_timer_init(struct device_node *np)
> +{

[ ... ]

> +	rate = clk_get_rate(per) >> 3;

Why ?

> +	tpm_clocksource_init(rate);
> +	tpm_clockevent_init(rate, irq);

Check.

> +	return 0;
> +
> +err_per_clk_enable:
> +	clk_disable_unprepare(ipg);
> +err_ipg_clk_enable:

No need to add an extra label.

> +err_clk_get:
> +	clk_put(per);
> +	clk_put(ipg);
> +err_iomap:
> +	iounmap(timer_base);
> +	return ret;
> +}
> +CLOCKSOURCE_OF_DECLARE(imx7ulp, "fsl,imx7ulp-tpm", tpm_timer_init);

CLOCKSOURCE_OF_DECLARE is renamed to TIMER_OF_DECLARE.

Thanks!

  -- Daniel


-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
