From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Tue, 2 Oct 2018 10:18:22 +0200
Subject: [PATCH v6 09/14] irqchip/irq-mvebu-icu: add support for System
 Error Interrupts (SEI)
In-Reply-To: <86in2lvbmb.wl-marc.zyngier@arm.com>
References: <20181001141358.31508-1-miquel.raynal@bootlin.com>
 <20181001141358.31508-10-miquel.raynal@bootlin.com>
 <86in2lvbmb.wl-marc.zyngier@arm.com>
Message-ID: <20181002101822.107c2016@xps13>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

Marc Zyngier <marc.zyngier@arm.com> wrote on Mon, 01 Oct 2018 18:07:56
+0100:

> On Mon, 01 Oct 2018 15:13:53 +0100,
> Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> > 
> > So far the ICU only handled NSR interrupts through GICP. An SEI driver
> > provides an MSI domain through which it is possible to raise SEI, so
> > let's add SEI support to the ICU driver.
> > 
> > Handle the NSR probe function in a more generic way to support other
> > type of interrupts.
> > 
> > Each interrupt domain is a tree domain to avoid allocation the 207
> > entries each time. Instead an ICU-wide bitmap is used to follow ICU
> > slot allocations.
> > 
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > ---
> >  drivers/irqchip/irq-mvebu-icu.c | 173 +++++++++++++++++++++++++-------
> >  1 file changed, 139 insertions(+), 34 deletions(-)
> > 
> > diff --git a/drivers/irqchip/irq-mvebu-icu.c b/drivers/irqchip/irq-mvebu-icu.c
> > index c79d2cb787a0..21e7c5830fcc 100644
> > --- a/drivers/irqchip/irq-mvebu-icu.c
> > +++ b/drivers/irqchip/irq-mvebu-icu.c
> > @@ -27,6 +27,10 @@
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
> > @@ -37,11 +41,27 @@
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
> > -	struct irq_chip irq_chip;
> >  	void __iomem *base;
> >  	struct device *dev;
> > +
> > +	/* Lock on interrupt allocations/releases */
> > +	struct mutex msi_lock;
> > +	DECLARE_BITMAP(msi_bitmap, ICU_MAX_IRQS);
> > +};
> > +
> > +struct mvebu_icu_msi_data {
> > +	struct mvebu_icu *icu;
> >  	atomic_t initialized;
> > +	const struct mvebu_icu_subset_data *subset_data;
> >  };
> >  
> >  struct mvebu_icu_irq_data {
> > @@ -52,28 +72,38 @@ struct mvebu_icu_irq_data {
> >  
> >  DEFINE_STATIC_KEY_FALSE(legacy_bindings);
> >  
> > -static void mvebu_icu_init(struct mvebu_icu *icu, struct msi_msg *msg)
> > +static void mvebu_icu_init(struct mvebu_icu *icu,
> > +			   struct mvebu_icu_msi_data *msi_data,
> > +			   struct msi_msg *msg)
> >  {
> > -	if (atomic_cmpxchg(&icu->initialized, false, true))
> > +	const struct mvebu_icu_subset_data *subset = msi_data->subset_data;
> > +
> > +	if (atomic_cmpxchg(&msi_data->initialized, false, true))
> > +		return;
> > +
> > +	/* Set 'SET' ICU SPI message address in AP */
> > +	writel_relaxed(msg[0].address_hi, icu->base + subset->offset_set_ah);
> > +	writel_relaxed(msg[0].address_lo, icu->base + subset->offset_set_al);
> > +
> > +	if (subset->icu_group != ICU_GRP_NSR)
> >  		return;
> >  
> > -	/* Set Clear/Set ICU SPI message address in AP */
> > -	writel_relaxed(msg[0].address_hi, icu->base + ICU_SETSPI_NSR_AH);
> > -	writel_relaxed(msg[0].address_lo, icu->base + ICU_SETSPI_NSR_AL);
> > -	writel_relaxed(msg[1].address_hi, icu->base + ICU_CLRSPI_NSR_AH);
> > -	writel_relaxed(msg[1].address_lo, icu->base + ICU_CLRSPI_NSR_AL);
> > +	/* Set 'CLEAR' ICU SPI message address in AP (level-MSI only) */
> > +	writel_relaxed(msg[1].address_hi, icu->base + subset->offset_clr_ah);
> > +	writel_relaxed(msg[1].address_lo, icu->base + subset->offset_clr_al);
> >  }
> >  
> >  static void mvebu_icu_write_msg(struct msi_desc *desc, struct msi_msg *msg)
> >  {
> >  	struct irq_data *d = irq_get_irq_data(desc->irq);
> > +	struct mvebu_icu_msi_data *msi_data = platform_msi_get_host_data(d->domain);
> >  	struct mvebu_icu_irq_data *icu_irqd = d->chip_data;
> >  	struct mvebu_icu *icu = icu_irqd->icu;
> >  	unsigned int icu_int;
> >  
> >  	if (msg->address_lo || msg->address_hi) {
> > -		/* One off initialization */
> > -		mvebu_icu_init(icu, msg);
> > +		/* One off initialization per domain */
> > +		mvebu_icu_init(icu, msi_data, msg);
> >  		/* Configure the ICU with irq number & type */
> >  		icu_int = msg->data | ICU_INT_ENABLE;
> >  		if (icu_irqd->type & IRQ_TYPE_EDGE_RISING)
> > @@ -103,10 +133,29 @@ static void mvebu_icu_write_msg(struct msi_desc *desc, struct msi_msg *msg)
> >  	}
> >  }
> >  
> > +static struct irq_chip mvebu_icu_nsr_chip = {
> > +	.name			= "ICU-NSR",
> > +	.irq_mask		= irq_chip_mask_parent,
> > +	.irq_unmask		= irq_chip_unmask_parent,
> > +	.irq_eoi		= irq_chip_eoi_parent,
> > +	.irq_set_type		= irq_chip_set_type_parent,
> > +	.irq_set_affinity	= irq_chip_set_affinity_parent,
> > +};
> > +
> > +static struct irq_chip mvebu_icu_sei_chip = {
> > +	.name			= "ICU-SEI",
> > +	.irq_ack		= irq_chip_ack_parent,
> > +	.irq_mask		= irq_chip_mask_parent,
> > +	.irq_unmask		= irq_chip_unmask_parent,
> > +	.irq_set_type		= irq_chip_set_type_parent,
> > +	.irq_set_affinity	= irq_chip_set_affinity_parent,
> > +};
> > +
> >  static int
> >  mvebu_icu_irq_domain_translate(struct irq_domain *d, struct irq_fwspec *fwspec,
> >  			       unsigned long *hwirq, unsigned int *type)
> >  {
> > +	struct mvebu_icu_msi_data *msi_data = platform_msi_get_host_data(d);
> >  	struct mvebu_icu *icu = platform_msi_get_host_data(d);
> >  	unsigned int param_count = static_branch_unlikely(&legacy_bindings) ? 3 : 2;
> >  
> > @@ -128,6 +177,14 @@ mvebu_icu_irq_domain_translate(struct irq_domain *d, struct irq_fwspec *fwspec,
> >  	} else {
> >  		*hwirq = fwspec->param[0];
> >  		*type = fwspec->param[1] & IRQ_TYPE_SENSE_MASK;
> > +
> > +		/*
> > +		 * The ICU receives level interrupts. While the NSR are also
> > +		 * level interrupts, SEI are edge interrupts. Force the type
> > +		 * here in this case.
> > +		 */
> > +		if (msi_data->subset_data->icu_group == ICU_GRP_SEI)
> > +			*type = IRQ_TYPE_EDGE_RISING;  
> 
> Please add a comment indicating that this makes the interrupt handling
> unreliable. I really don't want anyone to think that this kind of hack
> is to be relied upon (interrupt fires, driver ignores the interrupt
> and legitimately expects it to fire again, interrupts doesn't fire,
> device is dead).

Done. Added the mention:

    "Note that this makes the interrupt handling unreliable."

> 
> >  	}
> >  
> >  	if (*hwirq >= ICU_MAX_IRQS) {
> > @@ -138,6 +195,25 @@ mvebu_icu_irq_domain_translate(struct irq_domain *d, struct irq_fwspec *fwspec,
> >  	return 0;
> >  }
> >  
> > +static int mvebu_icu_msi_bitmap_region_alloc(struct mvebu_icu *icu, int hwirq)
> > +{
> > +	int ret;
> > +
> > +	mutex_lock(&icu->msi_lock);
> > +	ret = test_and_set_bit(hwirq, icu->msi_bitmap);
> > +	mutex_unlock(&icu->msi_lock);  
> 
> test_and_set_bit is atomic. Why do we have a mutex to guard it?

Mutexes removed, that's right we don't need them anymore since we
passed to test_and_set_bit().

> More importantly, what is it used for? You only seem to use it as some
> paranoid check to validate the DT, which makes no sense to me.

I'm not sure if this test is really paranoid as, in theory, we might
have more interrupts than available slots in the ICU and I feel good
warning the user if an ICU slot is re-used. Anyway, if you prefer not
to check that, I will simply get rid of the whole bitmap which then
makes no more sense.

Thanks,
Miqu?l
