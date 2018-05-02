From: thomas.petazzoni@bootlin.com (Thomas Petazzoni)
Date: Wed, 2 May 2018 10:13:00 +0200
Subject: [PATCH 09/17] irqchip/irq-mvebu-icu: support ICU subnodes
In-Reply-To: <20180421135537.24716-10-miquel.raynal@bootlin.com>
References: <20180421135537.24716-1-miquel.raynal@bootlin.com>
 <20180421135537.24716-10-miquel.raynal@bootlin.com>
Message-ID: <20180502101300.49cc3623@windsurf.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Miqu?l,

On Sat, 21 Apr 2018 15:55:29 +0200, Miquel Raynal wrote:
> Introduce new bindings for the ICU.

Perhaps this should explain *why* we need new bindings.

> Each DT subnode of the ICU represents a type of interrupt that should
> be handled separately. Add the possibility for the ICU to have subnodes
> and probe each of them automatically with devm_platform_populate(). If
> the node as no child, the probe function for NSRs will still be called
> 'manually'.

 ... in order to preserve backward compatibility with Device Trees
 using the old binding.

> +static struct mvebu_icu *mvebu_dev_get_drvdata(struct platform_device *pdev)

The function should be prefixed by mvebu_icu_, not just mvebu_.

> +{
> +	struct mvebu_icu *icu;
> +
> +	icu = dev_get_drvdata(&pdev->dev);
> +	if (icu) {
> +		/* Legacy bindings: get the device data */

I find this comment weird, because it doesn't document what the test
just below is doing.

> +		if (!icu->legacy_bindings)
> +			return ERR_PTR(-EINVAL);
> +	} else {
> +		/* New bindings: get the parent device (ICU) data */
> +		icu = dev_get_drvdata(pdev->dev.parent);
> +		if (!icu)
> +			return ERR_PTR(-ENODEV);
> +		if (icu->legacy_bindings)
> +			return ERR_PTR(-EINVAL);
> +	}


> @@ -144,7 +170,10 @@ mvebu_icu_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
>  		goto free_irqd;
>  	}
>  
> -	icu_irqd->icu_group = fwspec->param[0];
> +	if (icu->legacy_bindings)
> +		icu_irqd->icu_group = fwspec->param[0];
> +	else
> +		icu_irqd->icu_group = ICU_GRP_NSR;

In practice here fwspec->param[0] is always going to be equal to
ICU_GRP_NSR, but OK, the test makes sense as in a future commit, the
"else" case will be changed to support SEIs.

> +static const struct of_device_id mvebu_icu_nsr_of_match[] = {
> +	{ .compatible = "marvell,cp110-icu-nsr", },
> +	{},
> +};
> +
> +static struct platform_driver mvebu_icu_nsr_driver = {
> +	.probe  = mvebu_icu_nsr_probe,
> +	.driver = {
> +		.name = "mvebu-icu-nsr",
> +		.of_match_table = mvebu_icu_nsr_of_match,
> +	},
> +};
> +builtin_platform_driver(mvebu_icu_nsr_driver);

I'm not sure why you call this icu_nsr here, and change it later to
icu_subset. Wouldn't it make sense to call it right away with the final
name ? Note that this is not a very strong request to change this
aspect, I'm fine with how it's done today, it's just that I would have
done it differently.

Other than that, looks good to me.

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
