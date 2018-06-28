From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 28 Jun 2018 17:15:39 +0200
Subject: [PATCH v5 1/6] ARM: at91: add TCB registers definitions
In-Reply-To: <20180619211929.22908-2-alexandre.belloni@bootlin.com>
References: <20180619211929.22908-1-alexandre.belloni@bootlin.com>
 <20180619211929.22908-2-alexandre.belloni@bootlin.com>
Message-ID: <1bc64ccb-1e22-364c-e08c-fa86692783ff@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/06/2018 23:19, Alexandre Belloni wrote:
> Add registers and bits definitions for the timer counter blocks found on
> Atmel ARM SoCs.
> 
> Tested-by: Alexander Dahl <ada@thorsis.com>
> Tested-by: Andras Szemzo <szemzo.andras@gmail.com>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>  include/soc/at91/atmel_tcb.h | 216 +++++++++++++++++++++++++++++++++++

Is the header necessary ? Can it be moved in the .c ?

>  1 file changed, 216 insertions(+)
>  create mode 100644 include/soc/at91/atmel_tcb.h
> 
> diff --git a/include/soc/at91/atmel_tcb.h b/include/soc/at91/atmel_tcb.h
> new file mode 100644
> index 000000000000..3ed66031fc76
> --- /dev/null

[ ... ]

> +static inline struct clk *tcb_clk_get(struct device_node *node, int channel)
> +{
> +	struct clk *clk;
> +	char clk_name[] = "t0_clk";
> +
> +	clk_name[1] += channel;

clever :)

> +	clk = of_clk_get_by_name(node->parent, clk_name);
> +	if (!IS_ERR(clk))
> +		return clk;
> +
> +	return of_clk_get_by_name(node->parent, "t0_clk");

Why do you want to return clk from t0_clk if another channel is
requested ? This is prone to error.

I would clarify that at the caller level, if tcb_clk_get fails then try
with channel zero.

> +}
> +
> +static inline int tcb_irq_get(struct device_node *node, int channel)

no inline

> +{
> +	int irq;
> +
> +	irq = of_irq_get(node->parent, channel);
> +	if (irq > 0)
> +		return irq;
> +
> +	return of_irq_get(node->parent, 0);

Same comment than above.

> +}
> +
> +static const u8 atmel_tc_divisors[5] = { 2, 8, 32, 128, 0, };
> +
> +struct atmel_tcb_info {
> +	int bits;
> +};
> +
> +static const struct atmel_tcb_info atmel_tcb_infos[] = {
> +	{ .bits = 16 },
> +	{ .bits = 32 },
> +};

Structuring the code with structure is a good practice. However, this is
too much :)

> +static const struct of_device_id atmel_tcb_dt_ids[] = {
> +	{
> +		.compatible = "atmel,at91rm9200-tcb",
> +		.data = &atmel_tcb_infos[0],

		.data = (void *)16;

> +	}, {
> +		.compatible = "atmel,at91sam9x5-tcb",
> +		.data = &atmel_tcb_infos[1],
> +	}, {
> +		/* sentinel */
> +	}
> +};
> +



> +#endif /* __SOC_ATMEL_TCB_H */
> 


-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
