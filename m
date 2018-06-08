From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Fri, 8 Jun 2018 15:08:08 +0200
Subject: [PATCH v2 11/16] irqchip/irq-mvebu-icu: add support for System
 Error Interrupts (SEI)
In-Reply-To: <cd000f57-e01f-e5b9-77f6-baf4e8f45551@arm.com>
References: <20180522094042.24770-1-miquel.raynal@bootlin.com>
 <20180522094042.24770-12-miquel.raynal@bootlin.com>
 <cd000f57-e01f-e5b9-77f6-baf4e8f45551@arm.com>
Message-ID: <20180608150808.7af98f18@xps13>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

Thank you for the review.

On Wed, 23 May 2018 15:23:48 +0100, Marc Zyngier <marc.zyngier@arm.com>
wrote:

> On 22/05/18 10:40, Miquel Raynal wrote:
> > An SEI driver provides an MSI domain through which it is possible to
> > raise SEIs.
> > 
> > Handle the NSR probe function in a more generic way to support other
> > type of interrupts (ie. the SEIs).
> > 
> > For clarity we do not use tree IRQ domains for now but linear ones
> > instead, allocating the 207 ICU lines for each interrupt group.  
> 
> What's the rational for not using trees? Because that's effectively a
> 100% overhead...

There is none.

I had a look at how to do it.

In the ICU driver I would like to just drop the nvec parameter (number
of interrupts in the domain) when calling
platform_msi_create_device_domain().

The above function would call irq_domain_create_hierarchy() which would
create a tree domain instead of a linear one because of nvec being 0.

However, there is a check in platform_msi_alloc_priv_data() (also
called by platform_msi_create_device_domain()) that will error out if
nvec is null.

I'm not 100% sure this is safe but I don't see the point of
prohibiting nvec to be null here. So would you accept this
change?

--- a/drivers/base/platform-msi.c
+++ b/drivers/base/platform-msi.c
@@ -203,7 +203,7 @@ platform_msi_alloc_priv_data(struct device *dev,
unsigned int nvec,
         * accordingly (which would impact the max number of MSI
         * capable devices).
         */
-       if (!dev->msi_domain || !write_msi_msg || !nvec || nvec > MAX_DEV_MSIS)
+       if (!dev->msi_domain || !write_msi_msg || nvec > MAX_DEV_MSIS)
                return ERR_PTR(-EINVAL);
 
        if (dev->msi_domain->bus_token != DOMAIN_BUS_PLATFORM_MSI) {

> 
> > Reallocating an ICU slot is prevented by the use of an ICU-wide bitmap.
> > 
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > ---

[...]

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
> > @@ -172,7 +202,9 @@ mvebu_icu_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
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
> > @@ -186,16 +218,22 @@ mvebu_icu_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
> >  		goto free_irqd;
> >  	}
> >  
> > +	spin_lock(&icu->msi_lock);
> > +	err = bitmap_allocate_region(icu->msi_bitmap, hwirq, 0);
> > +	spin_unlock(&icu->msi_lock);  
> 
> This (and the freeing counterpart) could deserve a couple of helpers.

Sure.

> 
> > +	if (err < 0)
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

[...]

> > @@ -268,9 +332,30 @@ static int mvebu_icu_subset_probe(struct platform_device *pdev)
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
> > +	.offset_clr_ah = ICU_CLR_SEI_AH,
> > +	.offset_clr_al = ICU_CLR_SEI_AL,  
> 
> I thought SEI was edge only, given what you do in mvebu_icu_init.
> Confused...

AFAIK, the ICU can produce both level and edge MSI. Currently,
when it comes to SEI, we don't use the .offset_clr_a[hl] entries
because the SEI block expects edge-MSIs, but I thought useful to fill
them anyway. I will remove them both to avoid the confusion.

Thanks,
Miqu?l
