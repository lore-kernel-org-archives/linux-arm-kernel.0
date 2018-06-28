From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Thu, 28 Jun 2018 19:12:19 +0200
Subject: [PATCH v3 12/17] irqchip/irq-mvebu-icu: add support for System
 Error Interrupts (SEI)
In-Reply-To: <1bf99f2c-6cff-f5ee-4aa9-b122d1b4437a@arm.com>
References: <20180622151432.1566-1-miquel.raynal@bootlin.com>
 <20180622151432.1566-13-miquel.raynal@bootlin.com>
 <1bf99f2c-6cff-f5ee-4aa9-b122d1b4437a@arm.com>
Message-ID: <20180628191219.51c84ecd@xps13>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

Marc Zyngier <marc.zyngier@arm.com> wrote on Thu, 28 Jun 2018 17:49:55
+0100:

> On 22/06/18 16:14, Miquel Raynal wrote:
> > An SEI driver provides an MSI domain through which it is possible to
> > raise SEIs.
> > 
> > Handle the NSR probe function in a more generic way to support other
> > type of interrupts (ie. the SEIs).
> > 
> > For clarity we do not use tree IRQ domains for now but linear ones
> > instead, allocating the 207 ICU lines for each interrupt group.  
> 
> Is that still the truth? or just a stale comment?

Stale comment, will remove it.

> 
> > Reallocating an ICU slot is prevented by the use of an ICU-wide bitmap.
> > 
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > ---
> >  drivers/irqchip/irq-mvebu-icu.c | 152 ++++++++++++++++++++++++++++++++++------
> >  1 file changed, 129 insertions(+), 23 deletions(-)
> > 
> > diff --git a/drivers/irqchip/irq-mvebu-icu.c b/drivers/irqchip/irq-mvebu-icu.c
> > index f7c2ede9c222..bec506f0b1a9 100644
> > --- a/drivers/irqchip/irq-mvebu-icu.c
> > +++ b/drivers/irqchip/irq-mvebu-icu.c
> > @@ -28,6 +28,10 @@
> >  #define ICU_SETSPI_NSR_AH	0x14
> >  #define ICU_CLRSPI_NSR_AL	0x18
> >  #define ICU_CLRSPI_NSR_AH	0x1c
> > +#define ICU_SET_SEI_AL		0x50
> > +#define ICU_SET_SEI_AH		0x54
> > +#define ICU_CLR_SEI_AL		0x58
> > +#define ICU_CLR_SEI_AH		0x5C
> >  #define ICU_INT_CFG(x)          (0x100 + 4 * (x))
> >  #define   ICU_INT_ENABLE	BIT(24)
> >  #define   ICU_IS_EDGE		BIT(28)
> > @@ -38,12 +42,28 @@
> >  #define ICU_SATA0_ICU_ID	109
> >  #define ICU_SATA1_ICU_ID	107
> >  
> > +struct mvebu_icu_subset_data {
> > +	unsigned int icu_group;
> > +	unsigned int offset_set_ah;
> > +	unsigned int offset_set_al;
> > +	unsigned int offset_clr_ah;
> > +	unsigned int offset_clr_al;
> > +};
> > +
> >  struct mvebu_icu {
> >  	struct irq_chip irq_chip;
> >  	struct regmap *regmap;
> >  	struct device *dev;
> > -	atomic_t initialized;
> >  	bool legacy_bindings;
> > +	/* Lock on interrupt allocations/releases */
> > +	struct mutex msi_lock;
> > +	DECLARE_BITMAP(msi_bitmap, ICU_MAX_IRQS);
> > +};
> > +
> > +struct mvebu_icu_msi_data {
> > +	struct mvebu_icu *icu;
> > +	atomic_t initialized;
> > +	const struct mvebu_icu_subset_data *subset_data;  
> 
> I'm a bit lost here. Can you have more than a single mvebu_icu_msi_data
> per subset_data? I though you'd only have one. If so, what's the benefit
> of having a separate structure? Am I missing something?

The reason for having a pointer on another structure is because I use
of_device_get_match_data() to retrieve a different structure per compatible
 (ie. per subset).

> 
> >  };
> >  
> >  struct mvebu_icu_irq_data {
> > @@ -76,16 +96,25 @@ static struct mvebu_icu *mvebu_icu_dev_get_drvdata(struct platform_device *pdev)
> >  	return icu;
> >  }
> >  
> > -static void mvebu_icu_init(struct mvebu_icu *icu, struct msi_msg *msg)
> > +static void mvebu_icu_init(struct mvebu_icu *icu, struct irq_domain *d,
> > +			   struct msi_msg *msg)
> >  {
> > -	if (atomic_cmpxchg(&icu->initialized, false, true))
> > +	struct mvebu_icu_msi_data *msi_data = platform_msi_get_host_data(d);
> > +	const struct mvebu_icu_subset_data *subset = msi_data->subset_data;  
> 
> Since you don't use the domain for anything else than obtaining the
> subset_data, why don't you directly pass that subset_data as a
> parameter? Here, you are mixing two different abstraction levels, and
> that makes the whole thing really bizarre.

Indeed. Will edit this.

> 
> > +
> > +	if (atomic_cmpxchg(&msi_data->initialized, false, true))
> > +		return;
> > +
> > +	/* Set 'SET' ICU SPI message address in AP */
> > +	regmap_write(icu->regmap, subset->offset_set_ah, msg[0].address_hi);
> > +	regmap_write(icu->regmap, subset->offset_set_al, msg[0].address_lo);
> > +
> > +	if (subset->icu_group != ICU_GRP_NSR)
> >  		return;
> >  
> > -	/* Set Clear/Set ICU SPI message address in AP */
> > -	regmap_write(icu->regmap, ICU_SETSPI_NSR_AH, msg[0].address_hi);
> > -	regmap_write(icu->regmap, ICU_SETSPI_NSR_AL, msg[0].address_lo);
> > -	regmap_write(icu->regmap, ICU_CLRSPI_NSR_AH, msg[1].address_hi);
> > -	regmap_write(icu->regmap, ICU_CLRSPI_NSR_AL, msg[1].address_lo);
> > +	/* Set 'CLEAR' ICU SPI message address in AP (level-MSI only) */
> > +	regmap_write(icu->regmap, subset->offset_clr_ah, msg[1].address_hi);
> > +	regmap_write(icu->regmap, subset->offset_clr_al, msg[1].address_lo);
> >  }
> >  
> >  static void mvebu_icu_write_msg(struct msi_desc *desc, struct msi_msg *msg)
> > @@ -96,8 +125,8 @@ static void mvebu_icu_write_msg(struct msi_desc *desc, struct msi_msg *msg)
> >  	unsigned int icu_int;
> >  
> >  	if (msg->address_lo || msg->address_hi) {
> > -		/* One off initialization */
> > -		mvebu_icu_init(icu, msg);
> > +		/* One off initialization per domain */
> > +		mvebu_icu_init(icu, d->domain, msg);
> >  		/* Configure the ICU with irq number & type */
> >  		icu_int = msg->data | ICU_INT_ENABLE;
> >  		if (icu_irqd->type & IRQ_TYPE_EDGE_RISING)
> > @@ -131,7 +160,8 @@ static int
> >  mvebu_icu_irq_domain_translate(struct irq_domain *d, struct irq_fwspec *fwspec,
> >  			       unsigned long *hwirq, unsigned int *type)
> >  {
> > -	struct mvebu_icu *icu = platform_msi_get_host_data(d);
> > +	struct mvebu_icu_msi_data *msi_data = platform_msi_get_host_data(d);
> > +	struct mvebu_icu *icu = msi_data->icu;
> >  	unsigned int param_count = icu->legacy_bindings ? 3 : 2;
> >  
> >  	/* Check the count of the parameters in dt */
> > @@ -143,7 +173,7 @@ mvebu_icu_irq_domain_translate(struct irq_domain *d, struct irq_fwspec *fwspec,
> >  
> >  	if (icu->legacy_bindings) {
> >  		*hwirq = fwspec->param[1];
> > -		*type = fwspec->param[2];
> > +		*type = fwspec->param[2] & IRQ_TYPE_SENSE_MASK;
> >  		if (fwspec->param[0] != ICU_GRP_NSR) {
> >  			dev_err(icu->dev, "wrong ICU group type %x\n",
> >  				fwspec->param[0]);
> > @@ -151,7 +181,7 @@ mvebu_icu_irq_domain_translate(struct irq_domain *d, struct irq_fwspec *fwspec,
> >  		}
> >  	} else {
> >  		*hwirq = fwspec->param[0];
> > -		*type = fwspec->param[1];
> > +		*type = fwspec->param[1] & IRQ_TYPE_SENSE_MASK;
> >  	}
> >  
> >  	if (*hwirq >= ICU_MAX_IRQS) {
> > @@ -159,12 +189,36 @@ mvebu_icu_irq_domain_translate(struct irq_domain *d, struct irq_fwspec *fwspec,
> >  		return -EINVAL;
> >  	}
> >  
> > -	/* Mask the type to prevent wrong DT configuration */
> > -	*type = fwspec->param[2] & IRQ_TYPE_SENSE_MASK;
> > +	/*
> > +	 * The ICU receives level-interrupts. MSI SEI are
> > +	 * edge-interrupts while MSI NSR are level-interrupts. Update the type
> > +	 * accordingly for the parent irqchip.
> > +	 */
> > +	if (msi_data->subset_data->icu_group == ICU_GRP_SEI)
> > +		*type = IRQ_TYPE_EDGE_RISING;
> >  
> >  	return 0;
> >  }
> >  
> > +static int mvebu_icu_msi_bitmap_region_alloc(struct mvebu_icu *icu, int hwirq)
> > +{
> > +	int ret;
> > +
> > +	mutex_lock(&icu->msi_lock);
> > +	ret = bitmap_allocate_region(icu->msi_bitmap, hwirq, 0);
> > +	mutex_unlock(&icu->msi_lock);
> > +
> > +	return ret;
> > +}
> > +
> > +static void mvebu_icu_msi_bitmap_region_release(struct mvebu_icu *icu,
> > +						int hwirq)
> > +{
> > +	mutex_lock(&icu->msi_lock);
> > +	bitmap_release_region(icu->msi_bitmap, hwirq, 0);
> > +	mutex_unlock(&icu->msi_lock);
> > +}
> > +
> >  static int
> >  mvebu_icu_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
> >  			   unsigned int nr_irqs, void *args)
> > @@ -172,7 +226,9 @@ mvebu_icu_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
> >  	int err;
> >  	unsigned long hwirq;
> >  	struct irq_fwspec *fwspec = args;
> > -	struct mvebu_icu *icu = platform_msi_get_host_data(domain);
> > +	struct mvebu_icu_msi_data *msi_data =
> > +		platform_msi_get_host_data(domain);
> > +	struct mvebu_icu *icu = msi_data->icu;
> >  	struct mvebu_icu_irq_data *icu_irqd;
> >  
> >  	icu_irqd = kmalloc(sizeof(*icu_irqd), GFP_KERNEL);
> > @@ -186,16 +242,20 @@ mvebu_icu_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
> >  		goto free_irqd;
> >  	}
> >  
> > +	err = mvebu_icu_msi_bitmap_region_alloc(icu, hwirq);
> > +	if (err)
> > +		goto free_irqd;
> > +
> >  	if (icu->legacy_bindings)
> >  		icu_irqd->icu_group = fwspec->param[0];
> >  	else
> > -		icu_irqd->icu_group = ICU_GRP_NSR;
> > +		icu_irqd->icu_group = msi_data->subset_data->icu_group;
> >  	icu_irqd->icu = icu;
> >  
> >  	err = platform_msi_domain_alloc(domain, virq, nr_irqs);
> >  	if (err) {
> >  		dev_err(icu->dev, "failed to allocate ICU interrupt in parent domain\n");
> > -		goto free_irqd;
> > +		goto free_bitmap;
> >  	}
> >  
> >  	/* Make sure there is no interrupt left pending by the firmware */
> > @@ -214,6 +274,8 @@ mvebu_icu_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
> >  
> >  free_msi:
> >  	platform_msi_domain_free(domain, virq, nr_irqs);
> > +free_bitmap:
> > +	mvebu_icu_msi_bitmap_region_release(icu, hwirq);
> >  free_irqd:
> >  	kfree(icu_irqd);
> >  	return err;
> > @@ -223,12 +285,17 @@ static void
> >  mvebu_icu_irq_domain_free(struct irq_domain *domain, unsigned int virq,
> >  			  unsigned int nr_irqs)
> >  {
> > +	struct mvebu_icu_msi_data *msi_data =
> > +		platform_msi_get_host_data(domain);
> > +	struct mvebu_icu *icu = msi_data->icu;
> >  	struct irq_data *d = irq_get_irq_data(virq);
> >  	struct mvebu_icu_irq_data *icu_irqd = d->chip_data;
> >  
> >  	kfree(icu_irqd);
> >  
> >  	platform_msi_domain_free(domain, virq, nr_irqs);
> > +
> > +	mvebu_icu_msi_bitmap_region_release(icu, d->hwirq);
> >  }
> >  
> >  static const struct irq_domain_ops mvebu_icu_domain_ops = {
> > @@ -239,14 +306,29 @@ static const struct irq_domain_ops mvebu_icu_domain_ops = {
> >  
> >  static int mvebu_icu_subset_probe(struct platform_device *pdev)
> >  {
> > +	const struct mvebu_icu_subset_data *subset;
> > +	struct mvebu_icu_msi_data *msi_data;
> >  	struct device_node *msi_parent_dn;
> >  	struct irq_domain *irq_domain;
> >  	struct mvebu_icu *icu;
> >  
> > +	msi_data = devm_kzalloc(&pdev->dev, sizeof(*msi_data), GFP_KERNEL);
> > +	if (!msi_data)
> > +		return -ENOMEM;
> > +
> >  	icu = mvebu_icu_dev_get_drvdata(pdev);
> >  	if (IS_ERR(icu))
> >  		return PTR_ERR(icu);
> >  
> > +	subset = of_device_get_match_data(&pdev->dev);
> > +	if (!subset) {
> > +		dev_err(&pdev->dev, "Could not retrieve subset data\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	msi_data->icu = icu;
> > +	msi_data->subset_data = subset;
> > +
> >  	pdev->dev.msi_domain = of_msi_get_domain(&pdev->dev, pdev->dev.of_node,
> >  						 DOMAIN_BUS_PLATFORM_MSI);
> >  	if (!pdev->dev.msi_domain)
> > @@ -256,10 +338,10 @@ static int mvebu_icu_subset_probe(struct platform_device *pdev)
> >  	if (!msi_parent_dn)
> >  		return -ENODEV;
> >  
> > -	irq_domain = platform_msi_create_device_domain(&pdev->dev, ICU_MAX_IRQS,
> > +	irq_domain = platform_msi_create_device_domain(&pdev->dev, 0,
> >  						       mvebu_icu_write_msg,
> >  						       &mvebu_icu_domain_ops,
> > -						       icu);
> > +						       msi_data);
> >  	if (!irq_domain) {
> >  		dev_err(&pdev->dev, "Failed to create ICU MSI domain\n");
> >  		return -ENOMEM;
> > @@ -268,9 +350,28 @@ static int mvebu_icu_subset_probe(struct platform_device *pdev)
> >  	return 0;
> >  }
> >  
> > +static const struct mvebu_icu_subset_data mvebu_icu_nsr_subset_data = {
> > +	.icu_group = ICU_GRP_NSR,
> > +	.offset_set_ah = ICU_SETSPI_NSR_AH,
> > +	.offset_set_al = ICU_SETSPI_NSR_AL,
> > +	.offset_clr_ah = ICU_CLRSPI_NSR_AH,
> > +	.offset_clr_al = ICU_CLRSPI_NSR_AL,
> > +};
> > +
> > +static const struct mvebu_icu_subset_data mvebu_icu_sei_subset_data = {
> > +	.icu_group = ICU_GRP_SEI,
> > +	.offset_set_ah = ICU_SET_SEI_AH,
> > +	.offset_set_al = ICU_SET_SEI_AL,
> > +};
> > +
> >  static const struct of_device_id mvebu_icu_subset_of_match[] = {
> >  	{
> >  		.compatible = "marvell,cp110-icu-nsr",
> > +		.data = &mvebu_icu_nsr_subset_data,
> > +	},
> > +	{
> > +		.compatible = "marvell,cp110-icu-sei",
> > +		.data = &mvebu_icu_sei_subset_data,
> >  	},
> >  	{},
> >  };
> > @@ -317,6 +418,8 @@ static int mvebu_icu_probe(struct platform_device *pdev)
> >  	if (IS_ERR(icu->regmap))
> >  		return PTR_ERR(icu->regmap);
> >  
> > +	mutex_init(&icu->msi_lock);
> > +
> >  	icu->irq_chip.name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
> >  					    "ICU.%x",
> >  					    (unsigned int)res->start);
> > @@ -341,7 +444,7 @@ static int mvebu_icu_probe(struct platform_device *pdev)
> >  #endif
> >  
> >  	/*
> > -	 * Clean all ICU interrupts with type SPI_NSR, required to
> > +	 * Clean all ICU interrupts of type NSR and SEI, required to
> >  	 * avoid unpredictable SPI assignments done by firmware.
> >  	 */
> >  	for (i = 0 ; i < ICU_MAX_IRQS ; i++) {
> > @@ -350,7 +453,8 @@ static int mvebu_icu_probe(struct platform_device *pdev)
> >  		regmap_read(icu->regmap, ICU_INT_CFG(i), &icu_int);
> >  		icu_grp = icu_int >> ICU_GROUP_SHIFT;
> >  
> > -		if (icu_grp == ICU_GRP_NSR)
> > +		if (icu_grp == ICU_GRP_NSR ||
> > +		    (icu_grp == ICU_GRP_SEI && !icu->legacy_bindings))
> >  			regmap_write(icu->regmap, ICU_INT_CFG(i), 0);
> >  	}
> >  
> > @@ -363,7 +467,9 @@ static int mvebu_icu_probe(struct platform_device *pdev)
> >  }
> >  
> >  static const struct of_device_id mvebu_icu_of_match[] = {
> > -	{ .compatible = "marvell,cp110-icu", },
> > +	{
> > +		.compatible = "marvell,cp110-icu",
> > +	},
> >  	{},
> >  };
> >  
> >   
> 
> I'm close to loosing the plot with this driver, so I'll stop here and
> see what you have to say... ;-)

I'll check your previous comments tomorrow, I'll probably have a few
questions. Thanks for reviewing :-)

Regards,
Miqu?l
