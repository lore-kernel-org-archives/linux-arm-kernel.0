From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 20 Nov 2018 11:32:52 +0100
Subject: [PATCH 12/16] clocksource: Add clock driver for RDA8810PL SoC
In-Reply-To: <20181119170939.19153-13-manivannan.sadhasivam@linaro.org>
References: <20181119170939.19153-1-manivannan.sadhasivam@linaro.org>
 <20181119170939.19153-13-manivannan.sadhasivam@linaro.org>
Message-ID: <0df98ec5-1189-7297-b58d-8c0f5cbfa2ac@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Manivannan,


On 19/11/2018 18:09, Manivannan Sadhasivam wrote:
> Add clock driver for RDA Micro RDA8810PL SoC supporting OSTIMER
> and HWTIMER.

As it is a new driver, can you elaborate the log and describe the timer.

> Signed-off-by: Andreas F?rber <afaerber@suse.de>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---

[ ... ]

> +static int __init rda_timer_init(struct device_node *node)
> +{
> +	unsigned long rate = 2000000;
> +	int ostimer_irq, ret;
> +
> +	rda_timer_base = of_io_request_and_map(node, 0, "rda-timer");
> +	if (IS_ERR(rda_timer_base)) {
> +		pr_err("Can't map timer registers");
> +		return PTR_ERR(rda_timer_base);
> +	}
> +
> +	ostimer_irq = of_irq_get_byname(node, "ostimer");
> +	if (ostimer_irq <= 0) {
> +		pr_err("Can't parse ostimer IRQ");
> +		return -EINVAL;
> +	}
> +
> +	clocksource_register_hz(&rda_clocksource, rate);
> +
> +	ret = request_irq(ostimer_irq, rda_ostimer_interrupt, IRQF_TIMER,
> +			  "rda-ostimer", &rda_clockevent);
> +	if (ret) {
> +		pr_err("failed to request irq %d\n", ostimer_irq);
> +		return ret;
> +	}
> +

Use the timer-of API.

> +
> +TIMER_OF_DECLARE(rda8810pl, "rda,8810pl-timer", rda_timer_init);


Thanks

  -- Daniel


-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
