From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 13 Feb 2014 15:28:30 +0000
Subject: [PATCH 01/18] arm64: initial support for GICv3
In-Reply-To: <loom.20140207T065340-308@post.gmane.org>
References: <1391607050-540-1-git-send-email-marc.zyngier@arm.com>
 <1391607050-540-2-git-send-email-marc.zyngier@arm.com>
 <loom.20140207T065340-308@post.gmane.org>
Message-ID: <52FCE49E.70800@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnab,

Please do not trim the CC list. I missed this email (lost in the
traffic), and contributors to the other MLs may also have comments.

On 07/02/14 08:59, Arnab Basu wrote:
> Hi Marc
> 
> Marc Zyngier <marc.zyngier <at> arm.com> writes:
> 
>> +
>> +static inline void __iomem *gic_dist_base(struct irq_data *d)
> 
> I would suggest that this function be renamed (something like
> gic_base_for_irq?) since it returns dist or redist sgi base address. The
> name suggests it always returns the dist base address.

I may rename it to gic_get_irq_base.

>> +{
>> +	if (d->hwirq < 32)	/* SGI+PPI -> SGI_base for this CPU */
>> +		return gic_data_rdist_sgi_base();
>> +
>> +	if (d->hwirq <= 1023)	/* SPI -> dist_base */
>> +		return gic_data.dist_base;
>> +
>> +	if (d->hwirq >= 8192)
>> +		BUG();		/* LPI Detected!!! */
>> +
>> +	return NULL;
>> +}
>> +
>> +static inline unsigned int gic_irq(struct irq_data *d)
>> +{
>> +	return d->hwirq;
>> +}
>> +
>> +static void gic_do_wait_for_rwp(void __iomem *base)
>> +{
>> +	u32 val;
>> +
>> +	do {
>> +		val = readl_relaxed(base + GICD_CTLR);
> 
> Maybe rename GICD_CTLR to GICx_CTLR since it is being used for both the
> distributor and the redistributor.

I really hate the "GICx" bit. I think instead, I'll add a comment so
people don't get confuse about the name.

>> +		cpu_relax();
>> +	} while (val & GICD_CTLR_RWP);
> 
> Similar to above GICx_CTLR_RWP
> 
> 
>> +
>> +static int gic_irq_domain_xlate(struct irq_domain *d,
>> +				struct device_node *controller,
>> +				const u32 *intspec, unsigned int intsize,
>> +				unsigned long *out_hwirq, unsigned int *out_type)
>> +{
>> +	if (d->of_node != controller)
>> +		return -EINVAL;
>> +	if (intsize < 3)
>> +		return -EINVAL;
>> +
>> +	switch(intspec[0]) {
>> +	case 0:			/* SPI */
>> +		*out_hwirq = intspec[1] + 32;
>> +		break;
>> +	case 1:			/* PPI */
>> +		*out_hwirq = intspec[1] + 16;
>> +		break;
> 
> I wonder if there is any value to syncing these with the defines in
> "include/dt-bindings/interrupt-controller/arm-gic.h" somehow.

I'd expect the whole DTS stuff to vanish from the kernel some day, so
I'm keen on not depending on it.

Thanks for the review,

	M.
-- 
Jazz is not dead. It just smells funny...
