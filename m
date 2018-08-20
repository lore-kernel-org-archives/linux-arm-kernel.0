From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 20 Aug 2018 15:16:10 +0100
Subject: [PATCH v4 06/14] irqchip/irq-mvebu-icu: support ICU subnodes
In-Reply-To: <20180705124011.7661-7-miquel.raynal@bootlin.com>
References: <20180705124011.7661-1-miquel.raynal@bootlin.com>
 <20180705124011.7661-7-miquel.raynal@bootlin.com>
Message-ID: <89b63f34-3e0c-9d89-d7c0-5740e2aa4f4b@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/07/18 13:40, Miquel Raynal wrote:
> The ICU can handle several type of interrupt, each of them being handled
> differently on AP side. On CP side, the ICU should be able to make the
> distinction between each interrupt group by pointing to the right parent.
> 
> This is done through the introduction of new bindings, presenting the ICU
> node as the parent of multiple ICU sub-nodes, each of them being an
> interrupt type with a different interrupt parent. ICU interrupt 'clients'
> now directly point to the right sub-node, avoiding the need for the extra
> ICU_GRP_* parameter.
> 
> ICU subnodes are probed automatically with devm_platform_populate(). If
> the node as no child, the probe function for NSRs will still be called
> 'manually' in order to preserve backward compatibility with DT using the
> old binding.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  drivers/irqchip/irq-mvebu-icu.c | 70 +++++++++++++++++++++++++++++++++--------
>  1 file changed, 57 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-mvebu-icu.c b/drivers/irqchip/irq-mvebu-icu.c
> index d09f220a2701..bb4f06833d17 100644
> --- a/drivers/irqchip/irq-mvebu-icu.c
> +++ b/drivers/irqchip/irq-mvebu-icu.c
> @@ -40,6 +40,7 @@ struct mvebu_icu {
>  	struct irq_chip irq_chip;
>  	void __iomem *base;
>  	struct device *dev;
> +	bool is_legacy;
>  	atomic_t initialized;
>  };
>  
> @@ -105,24 +106,28 @@ mvebu_icu_irq_domain_translate(struct irq_domain *d, struct irq_fwspec *fwspec,
>  			       unsigned long *hwirq, unsigned int *type)
>  {
>  	struct mvebu_icu *icu = platform_msi_get_host_data(d);
> -	unsigned int icu_group;
> +	unsigned int param_count = icu->is_legacy ? 3 : 2;
>  
>  	/* Check the count of the parameters in dt */
> -	if (WARN_ON(fwspec->param_count < 3)) {
> +	if (WARN_ON(fwspec->param_count != param_count)) {
>  		dev_err(icu->dev, "wrong ICU parameter count %d\n",
>  			fwspec->param_count);
>  		return -EINVAL;
>  	}
>  
> -	/* Only ICU group type is handled */
> -	icu_group = fwspec->param[0];
> -	if (icu_group != ICU_GRP_NSR && icu_group != ICU_GRP_SR &&
> -	    icu_group != ICU_GRP_SEI && icu_group != ICU_GRP_REI) {
> -		dev_err(icu->dev, "wrong ICU group type %x\n", icu_group);
> -		return -EINVAL;
> +	if (icu->is_legacy) {
> +		*hwirq = fwspec->param[1];
> +		*type = fwspec->param[2];
> +		if (fwspec->param[0] != ICU_GRP_NSR) {
> +			dev_err(icu->dev, "wrong ICU group type %x\n",
> +				fwspec->param[0]);
> +			return -EINVAL;
> +		}
> +	} else {
> +		*hwirq = fwspec->param[0];
> +		*type = fwspec->param[1];
>  	}
>  
> -	*hwirq = fwspec->param[1];
>  	if (*hwirq >= ICU_MAX_IRQS) {
>  		dev_err(icu->dev, "invalid interrupt number %ld\n", *hwirq);
>  		return -EINVAL;
> @@ -155,7 +160,10 @@ mvebu_icu_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
>  		goto free_irqd;
>  	}
>  
> -	icu_irqd->icu_group = fwspec->param[0];
> +	if (icu->is_legacy)
> +		icu_irqd->icu_group = fwspec->param[0];
> +	else
> +		icu_irqd->icu_group = ICU_GRP_NSR;
>  	icu_irqd->icu = icu;
>  
>  	err = platform_msi_domain_alloc(domain, virq, nr_irqs);
> @@ -203,6 +211,13 @@ static const struct irq_domain_ops mvebu_icu_domain_ops = {
>  	.free      = mvebu_icu_irq_domain_free,
>  };
>  
> +static const struct of_device_id mvebu_icu_subset_of_match[] = {
> +	{
> +		.compatible = "marvell,cp110-icu-nsr",
> +	},
> +	{},
> +};
> +
>  static int mvebu_icu_subset_probe(struct platform_device *pdev)
>  {
>  	struct device_node *msi_parent_dn;
> @@ -210,7 +225,14 @@ static int mvebu_icu_subset_probe(struct platform_device *pdev)
>  	struct irq_domain *irq_domain;
>  	struct mvebu_icu *icu;
>  
> -	icu = dev_get_drvdata(dev);
> +	/*
> +	 * Device data being populated means we are using the legacy bindings.
> +	 * Using the parent device data means we are using the new bindings.
> +	 */
> +	if (dev_get_drvdata(dev))
> +		icu = dev_get_drvdata(dev);
> +	else
> +		icu = dev_get_drvdata(dev->parent);
>  
>  	dev->msi_domain = of_msi_get_domain(dev, dev->of_node,
>  					    DOMAIN_BUS_PLATFORM_MSI);
> @@ -233,6 +255,15 @@ static int mvebu_icu_subset_probe(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +static struct platform_driver mvebu_icu_subset_driver = {
> +	.probe  = mvebu_icu_subset_probe,
> +	.driver = {
> +		.name = "mvebu-icu-subset",
> +		.of_match_table = mvebu_icu_subset_of_match,
> +	},
> +};
> +builtin_platform_driver(mvebu_icu_subset_driver);
> +
>  static int mvebu_icu_probe(struct platform_device *pdev)
>  {
>  	struct mvebu_icu *icu;
> @@ -259,6 +290,15 @@ static int mvebu_icu_probe(struct platform_device *pdev)
>  	if (!icu->irq_chip.name)
>  		return -ENOMEM;
>  
> +	/*
> +	 * Legacy bindings: ICU is one node with one MSI parent: force manually
> +	 *                  the probe of the NSR interrupts side.
> +	 * New bindings: ICU node has children, one per interrupt controller
> +	 *               having its own MSI parent: call platform_populate().
> +	 */
> +	if (!of_get_child_count(pdev->dev.of_node))
> +		icu->is_legacy = true;

I keep coming back to this issue because it really irks me to have such
conditional code everywhere.

Since we know at probe time whether we have a legacy or a modern
binding, can't we just flip a global static key and have two distinct
paths that do not depend on a data structure? It doesn't change much for
the readability of the code, but at least it doesn't give the impression
that we can support some ICUs using the legacy binding and some others
using the modern one.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
