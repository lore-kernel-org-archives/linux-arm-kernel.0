From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 20 Aug 2018 16:21:19 +0100
Subject: [PATCH v4 09/14] irqchip/irq-mvebu-icu: add support for System
 Error Interrupts (SEI)
In-Reply-To: <20180705124011.7661-10-miquel.raynal@bootlin.com>
References: <20180705124011.7661-1-miquel.raynal@bootlin.com>
 <20180705124011.7661-10-miquel.raynal@bootlin.com>
Message-ID: <a88f62c0-7d7c-71da-fa45-487f7573dbb1@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/07/18 13:40, Miquel Raynal wrote:
> An SEI driver provides an MSI domain through which it is possible to
> raise SEIs.

Is that really relevant to this patch? It is about the ICU driver, and I
would expect you to explain how the ICU so far only handled NSR
interrupts through GICP, but now can also generate SEIs by routing MSIs
through the SEI block.

> 
> Handle the NSR probe function in a more generic way to support other
> type of interrupts (ie. the SEIs).
> 
> Each interrupt domain is a tree domain because of maximum 207 entries.
> Reallocating an ICU slot is prevented by the use of an ICU-wide bitmap.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  drivers/irqchip/irq-mvebu-icu.c | 148 +++++++++++++++++++++++++++++++++-------
>  1 file changed, 123 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-mvebu-icu.c b/drivers/irqchip/irq-mvebu-icu.c
> index bb4f06833d17..0cf741dd0f51 100644
> --- a/drivers/irqchip/irq-mvebu-icu.c
> +++ b/drivers/irqchip/irq-mvebu-icu.c
> @@ -26,6 +26,10 @@
>  #define ICU_SETSPI_NSR_AH	0x14
>  #define ICU_CLRSPI_NSR_AL	0x18
>  #define ICU_CLRSPI_NSR_AH	0x1c
> +#define ICU_SET_SEI_AL		0x50
> +#define ICU_SET_SEI_AH		0x54
> +#define ICU_CLR_SEI_AL		0x58
> +#define ICU_CLR_SEI_AH		0x5C
>  #define ICU_INT_CFG(x)          (0x100 + 4 * (x))
>  #define   ICU_INT_ENABLE	BIT(24)
>  #define   ICU_IS_EDGE		BIT(28)
> @@ -36,12 +40,28 @@
>  #define ICU_SATA0_ICU_ID	109
>  #define ICU_SATA1_ICU_ID	107
>  
> +struct mvebu_icu_subset_data {
> +	unsigned int icu_group;
> +	unsigned int offset_set_ah;
> +	unsigned int offset_set_al;
> +	unsigned int offset_clr_ah;
> +	unsigned int offset_clr_al;
> +};
> +
>  struct mvebu_icu {
>  	struct irq_chip irq_chip;
>  	void __iomem *base;
>  	struct device *dev;
>  	bool is_legacy;
> +	/* Lock on interrupt allocations/releases */
> +	struct mutex msi_lock;
> +	DECLARE_BITMAP(msi_bitmap, ICU_MAX_IRQS);
> +};
> +
> +struct mvebu_icu_msi_data {
> +	struct mvebu_icu *icu;
>  	atomic_t initialized;
> +	const struct mvebu_icu_subset_data *subset_data;
>  };
>  
>  struct mvebu_icu_irq_data {
> @@ -50,28 +70,38 @@ struct mvebu_icu_irq_data {
>  	unsigned int type;
>  };
>  
> -static void mvebu_icu_init(struct mvebu_icu *icu, struct msi_msg *msg)
> +static void mvebu_icu_init(struct mvebu_icu *icu,
> +			   struct mvebu_icu_msi_data *msi_data,
> +			   struct msi_msg *msg)
>  {
> -	if (atomic_cmpxchg(&icu->initialized, false, true))
> +	const struct mvebu_icu_subset_data *subset = msi_data->subset_data;
> +
> +	if (atomic_cmpxchg(&msi_data->initialized, false, true))
> +		return;
> +
> +	/* Set 'SET' ICU SPI message address in AP */
> +	writel_relaxed(msg[0].address_hi, icu->base + subset->offset_set_ah);
> +	writel_relaxed(msg[0].address_lo, icu->base + subset->offset_set_al);
> +
> +	if (subset->icu_group != ICU_GRP_NSR)
>  		return;
>  
> -	/* Set Clear/Set ICU SPI message address in AP */
> -	writel_relaxed(msg[0].address_hi, icu->base + ICU_SETSPI_NSR_AH);
> -	writel_relaxed(msg[0].address_lo, icu->base + ICU_SETSPI_NSR_AL);
> -	writel_relaxed(msg[1].address_hi, icu->base + ICU_CLRSPI_NSR_AH);
> -	writel_relaxed(msg[1].address_lo, icu->base + ICU_CLRSPI_NSR_AL);
> +	/* Set 'CLEAR' ICU SPI message address in AP (level-MSI only) */
> +	writel_relaxed(msg[1].address_hi, icu->base + subset->offset_clr_ah);
> +	writel_relaxed(msg[1].address_lo, icu->base + subset->offset_clr_al);
>  }
>  
>  static void mvebu_icu_write_msg(struct msi_desc *desc, struct msi_msg *msg)
>  {
>  	struct irq_data *d = irq_get_irq_data(desc->irq);
> +	struct mvebu_icu_msi_data *msi_data = platform_msi_get_host_data(d->domain);
>  	struct mvebu_icu_irq_data *icu_irqd = d->chip_data;
>  	struct mvebu_icu *icu = icu_irqd->icu;
>  	unsigned int icu_int;
>  
>  	if (msg->address_lo || msg->address_hi) {
> -		/* One off initialization */
> -		mvebu_icu_init(icu, msg);
> +		/* One off initialization per domain */
> +		mvebu_icu_init(icu, msi_data, msg);
>  		/* Configure the ICU with irq number & type */
>  		icu_int = msg->data | ICU_INT_ENABLE;
>  		if (icu_irqd->type & IRQ_TYPE_EDGE_RISING)
> @@ -105,7 +135,8 @@ static int
>  mvebu_icu_irq_domain_translate(struct irq_domain *d, struct irq_fwspec *fwspec,
>  			       unsigned long *hwirq, unsigned int *type)
>  {
> -	struct mvebu_icu *icu = platform_msi_get_host_data(d);
> +	struct mvebu_icu_msi_data *msi_data = platform_msi_get_host_data(d);
> +	struct mvebu_icu *icu = msi_data->icu;
>  	unsigned int param_count = icu->is_legacy ? 3 : 2;
>  
>  	/* Check the count of the parameters in dt */
> @@ -117,7 +148,7 @@ mvebu_icu_irq_domain_translate(struct irq_domain *d, struct irq_fwspec *fwspec,
>  
>  	if (icu->is_legacy) {
>  		*hwirq = fwspec->param[1];
> -		*type = fwspec->param[2];
> +		*type = fwspec->param[2] & IRQ_TYPE_SENSE_MASK;
>  		if (fwspec->param[0] != ICU_GRP_NSR) {
>  			dev_err(icu->dev, "wrong ICU group type %x\n",
>  				fwspec->param[0]);
> @@ -125,7 +156,7 @@ mvebu_icu_irq_domain_translate(struct irq_domain *d, struct irq_fwspec *fwspec,
>  		}
>  	} else {
>  		*hwirq = fwspec->param[0];
> -		*type = fwspec->param[1];
> +		*type = fwspec->param[1] & IRQ_TYPE_SENSE_MASK;

Shouldn't this change (and the one just above) be moved to another patch
(such as patch #6)? They feel oddly out of place here.

>  	}
>  
>  	if (*hwirq >= ICU_MAX_IRQS) {
> @@ -133,12 +164,36 @@ mvebu_icu_irq_domain_translate(struct irq_domain *d, struct irq_fwspec *fwspec,
>  		return -EINVAL;
>  	}
>  
> -	/* Mask the type to prevent wrong DT configuration */
> -	*type = fwspec->param[2] & IRQ_TYPE_SENSE_MASK;
> +	/*
> +	 * The ICU receives level-interrupts. MSI SEI are
> +	 * edge-interrupts while MSI NSR are level-interrupts. Update the type
> +	 * accordingly for the parent irqchip.
> +	 */
> +	if (msi_data->subset_data->icu_group == ICU_GRP_SEI)
> +		*type = IRQ_TYPE_EDGE_RISING;

That's interesting. How is the resampling done here?

>  
>  	return 0;
>  }
>  
> +static int mvebu_icu_msi_bitmap_region_alloc(struct mvebu_icu *icu, int hwirq)
> +{
> +	int ret;
> +
> +	mutex_lock(&icu->msi_lock);
> +	ret = bitmap_allocate_region(icu->msi_bitmap, hwirq, 0);

See my earlier comment about the use of find_first_free/set_bit.

> +	mutex_unlock(&icu->msi_lock);
> +
> +	return ret;
> +}
> +
> +static void mvebu_icu_msi_bitmap_region_release(struct mvebu_icu *icu,
> +						int hwirq)
> +{
> +	mutex_lock(&icu->msi_lock);
> +	bitmap_release_region(icu->msi_bitmap, hwirq, 0);
> +	mutex_unlock(&icu->msi_lock);
> +}
> +
>  static int
>  mvebu_icu_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
>  			   unsigned int nr_irqs, void *args)
> @@ -146,7 +201,9 @@ mvebu_icu_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
>  	int err;
>  	unsigned long hwirq;
>  	struct irq_fwspec *fwspec = args;
> -	struct mvebu_icu *icu = platform_msi_get_host_data(domain);
> +	struct mvebu_icu_msi_data *msi_data =
> +		platform_msi_get_host_data(domain);

On a single line, please.

> +	struct mvebu_icu *icu = msi_data->icu;
>  	struct mvebu_icu_irq_data *icu_irqd;
>  
>  	icu_irqd = kmalloc(sizeof(*icu_irqd), GFP_KERNEL);
> @@ -160,16 +217,20 @@ mvebu_icu_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
>  		goto free_irqd;
>  	}
>  
> +	err = mvebu_icu_msi_bitmap_region_alloc(icu, hwirq);
> +	if (err)
> +		goto free_irqd;
> +
>  	if (icu->is_legacy)
>  		icu_irqd->icu_group = fwspec->param[0];
>  	else
> -		icu_irqd->icu_group = ICU_GRP_NSR;
> +		icu_irqd->icu_group = msi_data->subset_data->icu_group;
>  	icu_irqd->icu = icu;
>  
>  	err = platform_msi_domain_alloc(domain, virq, nr_irqs);
>  	if (err) {
>  		dev_err(icu->dev, "failed to allocate ICU interrupt in parent domain\n");
> -		goto free_irqd;
> +		goto free_bitmap;
>  	}
>  
>  	/* Make sure there is no interrupt left pending by the firmware */
> @@ -188,6 +249,8 @@ mvebu_icu_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
>  
>  free_msi:
>  	platform_msi_domain_free(domain, virq, nr_irqs);
> +free_bitmap:
> +	mvebu_icu_msi_bitmap_region_release(icu, hwirq);
>  free_irqd:
>  	kfree(icu_irqd);
>  	return err;
> @@ -197,12 +260,17 @@ static void
>  mvebu_icu_irq_domain_free(struct irq_domain *domain, unsigned int virq,
>  			  unsigned int nr_irqs)
>  {
> +	struct mvebu_icu_msi_data *msi_data =
> +		platform_msi_get_host_data(domain);

Single line.


> +	struct mvebu_icu *icu = msi_data->icu;
>  	struct irq_data *d = irq_get_irq_data(virq);
>  	struct mvebu_icu_irq_data *icu_irqd = d->chip_data;
>  
>  	kfree(icu_irqd);
>  
>  	platform_msi_domain_free(domain, virq, nr_irqs);
> +
> +	mvebu_icu_msi_bitmap_region_release(icu, d->hwirq);
>  }
>  
>  static const struct irq_domain_ops mvebu_icu_domain_ops = {
> @@ -211,28 +279,54 @@ static const struct irq_domain_ops mvebu_icu_domain_ops = {
>  	.free      = mvebu_icu_irq_domain_free,
>  };
>  
> +static const struct mvebu_icu_subset_data mvebu_icu_nsr_subset_data = {
> +	.icu_group = ICU_GRP_NSR,
> +	.offset_set_ah = ICU_SETSPI_NSR_AH,
> +	.offset_set_al = ICU_SETSPI_NSR_AL,
> +	.offset_clr_ah = ICU_CLRSPI_NSR_AH,
> +	.offset_clr_al = ICU_CLRSPI_NSR_AL,
> +};
> +
> +static const struct mvebu_icu_subset_data mvebu_icu_sei_subset_data = {
> +	.icu_group = ICU_GRP_SEI,
> +	.offset_set_ah = ICU_SET_SEI_AH,
> +	.offset_set_al = ICU_SET_SEI_AL,
> +};
> +
>  static const struct of_device_id mvebu_icu_subset_of_match[] = {
>  	{
>  		.compatible = "marvell,cp110-icu-nsr",
> +		.data = &mvebu_icu_nsr_subset_data,
> +	},
> +	{
> +		.compatible = "marvell,cp110-icu-sei",
> +		.data = &mvebu_icu_sei_subset_data,
>  	},
>  	{},
>  };
>  
>  static int mvebu_icu_subset_probe(struct platform_device *pdev)
>  {
> +	struct mvebu_icu_msi_data *msi_data;
>  	struct device_node *msi_parent_dn;
>  	struct device *dev = &pdev->dev;
>  	struct irq_domain *irq_domain;
> -	struct mvebu_icu *icu;
> +
> +	msi_data = devm_kzalloc(dev, sizeof(*msi_data), GFP_KERNEL);
> +	if (!msi_data)
> +		return -ENOMEM;
>  
>  	/*
>  	 * Device data being populated means we are using the legacy bindings.
>  	 * Using the parent device data means we are using the new bindings.
>  	 */
> -	if (dev_get_drvdata(dev))
> -		icu = dev_get_drvdata(dev);
> -	else
> -		icu = dev_get_drvdata(dev->parent);
> +	if (dev_get_drvdata(dev)) {
> +		msi_data->icu = dev_get_drvdata(dev);
> +		msi_data->subset_data = &mvebu_icu_nsr_subset_data;
> +	} else {
> +		msi_data->icu = dev_get_drvdata(dev->parent);
> +		msi_data->subset_data = of_device_get_match_data(dev);
> +	}
>  
>  	dev->msi_domain = of_msi_get_domain(dev, dev->of_node,
>  					    DOMAIN_BUS_PLATFORM_MSI);
> @@ -246,7 +340,7 @@ static int mvebu_icu_subset_probe(struct platform_device *pdev)
>  	irq_domain = platform_msi_create_device_tree_domain(dev, ICU_MAX_IRQS,
>  							    mvebu_icu_write_msg,
>  							    &mvebu_icu_domain_ops,
> -							    icu);
> +							    msi_data);
>  	if (!irq_domain) {
>  		dev_err(dev, "Failed to create ICU MSI domain\n");
>  		return -ENOMEM;
> @@ -284,6 +378,8 @@ static int mvebu_icu_probe(struct platform_device *pdev)
>  		return PTR_ERR(icu->base);
>  	}
>  
> +	mutex_init(&icu->msi_lock);
> +
>  	icu->irq_chip.name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
>  					    "ICU.%x",
>  					    (unsigned int)res->start);
> @@ -308,7 +404,7 @@ static int mvebu_icu_probe(struct platform_device *pdev)
>  #endif
>  
>  	/*
> -	 * Clean all ICU interrupts with type SPI_NSR, required to
> +	 * Clean all ICU interrupts of type NSR and SEI, required to
>  	 * avoid unpredictable SPI assignments done by firmware.
>  	 */
>  	for (i = 0 ; i < ICU_MAX_IRQS ; i++) {
> @@ -331,7 +427,9 @@ static int mvebu_icu_probe(struct platform_device *pdev)
>  }
>  
>  static const struct of_device_id mvebu_icu_of_match[] = {
> -	{ .compatible = "marvell,cp110-icu", },
> +	{
> +		.compatible = "marvell,cp110-icu",
> +	},

Pointless change?

>  	{},
>  };
>  
> 

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
