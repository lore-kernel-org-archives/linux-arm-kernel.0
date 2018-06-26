From: gregory.clement@bootlin.com (Gregory CLEMENT)
Date: Tue, 26 Jun 2018 16:26:20 +0200
Subject: [PATCH v2] pinctrl: armada-37xx: add suspend/resume support
In-Reply-To: <20180626140613.13908-1-miquel.raynal@bootlin.com> (Miquel
 Raynal's message of "Tue, 26 Jun 2018 16:06:13 +0200")
References: <20180626140613.13908-1-miquel.raynal@bootlin.com>
Message-ID: <87k1qlaak3.fsf@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Miquel,
 
 On mar., juin 26 2018, Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> Add suspend/resume hooks in pinctrl driver to handle S2RAM operations.
>
> Beyond the traditional register save/restore operations, these hooks
> also keep the GPIOs used for both-edge IRQ synchronized between their
> level (low/high) and expected IRQ polarity (falling/rising edge).
>
> Since pinctrl is an infrastructure module, its resume should be issued
> prior to other IO drivers. The pinctrl PM operations are requested at
> early/late stages for this reason.
>
> Suggested-by: Ken Ma <make@marvell.com>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks for your change,

Reviewed-by: Gregory CLEMENT <gregory.clement@bootlin.com>

Gregory

> ---
>
> Changes since v1:
> =================
> * Removed the syscore-level operations and used
>   .suspend_late/.resume_early() to give this driver more priority.
> * Created an ARMADA_37XX_DEV_PM_OPS definition to avoid a couple of
>   #if defined/#endif macros in the platform driver structure around the
>   .pm entry.
> * Removed the global node list (previously used by the syscore
>   operations, not needed anymore).
>
>
>  drivers/pinctrl/mvebu/pinctrl-armada-37xx.c | 118 ++++++++++++++++++++++++++++
>  1 file changed, 118 insertions(+)
>
> diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c b/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
> index 53cf800688e9..aa48b3f23c7f 100644
> --- a/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
> +++ b/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
> @@ -80,6 +80,18 @@ struct armada_37xx_pmx_func {
>  	unsigned int		ngroups;
>  };
>  
> +struct armada_37xx_pm_state {
> +	u32 out_en_l;
> +	u32 out_en_h;
> +	u32 out_val_l;
> +	u32 out_val_h;
> +	u32 irq_en_l;
> +	u32 irq_en_h;
> +	u32 irq_pol_l;
> +	u32 irq_pol_h;
> +	u32 selection;
> +};
> +
>  struct armada_37xx_pinctrl {
>  	struct regmap			*regmap;
>  	void __iomem			*base;
> @@ -94,6 +106,7 @@ struct armada_37xx_pinctrl {
>  	unsigned int			ngroups;
>  	struct armada_37xx_pmx_func	*funcs;
>  	unsigned int			nfuncs;
> +	struct armada_37xx_pm_state	pm;
>  };
>  
>  #define PIN_GRP(_name, _start, _nr, _mask, _func1, _func2)	\
> @@ -996,6 +1009,110 @@ static int armada_37xx_pinctrl_register(struct platform_device *pdev,
>  	return 0;
>  }
>  
> +#if defined(CONFIG_PM)
> +static int armada_3700_pinctrl_suspend(struct device *dev)
> +{
> +	struct armada_37xx_pinctrl *info = dev_get_drvdata(dev);
> +
> +	/* Save GPIO state */
> +	regmap_read(info->regmap, OUTPUT_EN, &info->pm.out_en_l);
> +	regmap_read(info->regmap, OUTPUT_EN + sizeof(u32), &info->pm.out_en_h);
> +	regmap_read(info->regmap, OUTPUT_VAL, &info->pm.out_val_l);
> +	regmap_read(info->regmap, OUTPUT_VAL + sizeof(u32),
> +		    &info->pm.out_val_h);
> +
> +	info->pm.irq_en_l = readl(info->base + IRQ_EN);
> +	info->pm.irq_en_h = readl(info->base + IRQ_EN + sizeof(u32));
> +	info->pm.irq_pol_l = readl(info->base + IRQ_POL);
> +	info->pm.irq_pol_h = readl(info->base + IRQ_POL + sizeof(u32));
> +
> +	/* Save pinctrl state */
> +	regmap_read(info->regmap, SELECTION, &info->pm.selection);
> +
> +	return 0;
> +}
> +
> +static int armada_3700_pinctrl_resume(struct device *dev)
> +{
> +	struct armada_37xx_pinctrl *info = dev_get_drvdata(dev);
> +	struct gpio_chip *gc;
> +	struct irq_domain *d;
> +	int i;
> +
> +	/* Restore GPIO state */
> +	regmap_write(info->regmap, OUTPUT_EN, info->pm.out_en_l);
> +	regmap_write(info->regmap, OUTPUT_EN + sizeof(u32),
> +		     info->pm.out_en_h);
> +	regmap_write(info->regmap, OUTPUT_VAL, info->pm.out_val_l);
> +	regmap_write(info->regmap, OUTPUT_VAL + sizeof(u32),
> +		     info->pm.out_val_h);
> +
> +	/*
> +	 * Input levels may change during suspend, which is not monitored at
> +	 * that time. GPIOs used for both-edge IRQs may not be synchronized
> +	 * anymore with their polarities (rising/falling edge) and must be
> +	 * re-configured manually.
> +	 */
> +	gc = &info->gpio_chip;
> +	d = gc->irq.domain;
> +	for (i = 0; i < gc->ngpio; i++) {
> +		u32 irq_bit = BIT(i % GPIO_PER_REG);
> +		u32 mask, *irq_pol, input_reg, virq, type, level;
> +
> +		if (i < GPIO_PER_REG) {
> +			mask = info->pm.irq_en_l;
> +			irq_pol = &info->pm.irq_pol_l;
> +			input_reg = INPUT_VAL;
> +		} else {
> +			mask = info->pm.irq_en_h;
> +			irq_pol = &info->pm.irq_pol_h;
> +			input_reg = INPUT_VAL + sizeof(u32);
> +		}
> +
> +		if (!(mask & irq_bit))
> +			continue;
> +
> +		virq = irq_find_mapping(d, i);
> +		type = irq_get_trigger_type(virq);
> +
> +		/*
> +		 * Synchronize level and polarity for both-edge irqs:
> +		 *     - a high input level expects a falling edge,
> +		 *     - a low input level exepects a rising edge.
> +		 */
> +		if ((type & IRQ_TYPE_SENSE_MASK) ==
> +		    IRQ_TYPE_EDGE_BOTH) {
> +			regmap_read(info->regmap, input_reg, &level);
> +			if ((*irq_pol ^ level) & irq_bit)
> +				*irq_pol ^= irq_bit;
> +		}
> +	}
> +
> +	writel(info->pm.irq_en_l, info->base + IRQ_EN);
> +	writel(info->pm.irq_en_h, info->base + IRQ_EN + sizeof(u32));
> +	writel(info->pm.irq_pol_l, info->base + IRQ_POL);
> +	writel(info->pm.irq_pol_h, info->base + IRQ_POL + sizeof(u32));
> +
> +	/* Restore pinctrl state */
> +	regmap_write(info->regmap, SELECTION, info->pm.selection);
> +
> +	return 0;
> +}
> +
> +/*
> + * Since pinctrl is an infrastructure module, its resume should be issued prior
> + * to other IO drivers.
> + */
> +static const struct dev_pm_ops armada_3700_pinctrl_pm_ops = {
> +	.suspend_late = armada_3700_pinctrl_suspend,
> +	.resume_early = armada_3700_pinctrl_resume,
> +};
> +
> +#define PINCTRL_ARMADA_37XX_DEV_PM_OPS (&armada_3700_pinctrl_pm_ops)
> +#else
> +#define PINCTRL_ARMADA_37XX_DEV_PM_OPS NULL
> +#endif /* CONFIG_PM */
> +
>  static const struct of_device_id armada_37xx_pinctrl_of_match[] = {
>  	{
>  		.compatible = "marvell,armada3710-sb-pinctrl",
> @@ -1049,6 +1166,7 @@ static struct platform_driver armada_37xx_pinctrl_driver = {
>  	.driver = {
>  		.name = "armada-37xx-pinctrl",
>  		.of_match_table = armada_37xx_pinctrl_of_match,
> +		.pm = PINCTRL_ARMADA_37XX_DEV_PM_OPS,
>  	},
>  };
>  
> -- 
> 2.14.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Gregory Clement, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
