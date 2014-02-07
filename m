From: arnab.basu@freescale.com (Arnab Basu)
Date: Fri, 7 Feb 2014 08:59:21 +0000 (UTC)
Subject: [PATCH 01/18] arm64: initial support for GICv3
References: <1391607050-540-1-git-send-email-marc.zyngier@arm.com>
 <1391607050-540-2-git-send-email-marc.zyngier@arm.com>
Message-ID: <loom.20140207T065340-308@post.gmane.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc

Marc Zyngier <marc.zyngier <at> arm.com> writes:

> +
> +static inline void __iomem *gic_dist_base(struct irq_data *d)

I would suggest that this function be renamed (something like
gic_base_for_irq?) since it returns dist or redist sgi base address. The
name suggests it always returns the dist base address.

> +{
> +	if (d->hwirq < 32)	/* SGI+PPI -> SGI_base for this CPU */
> +		return gic_data_rdist_sgi_base();
> +
> +	if (d->hwirq <= 1023)	/* SPI -> dist_base */
> +		return gic_data.dist_base;
> +
> +	if (d->hwirq >= 8192)
> +		BUG();		/* LPI Detected!!! */
> +
> +	return NULL;
> +}
> +
> +static inline unsigned int gic_irq(struct irq_data *d)
> +{
> +	return d->hwirq;
> +}
> +
> +static void gic_do_wait_for_rwp(void __iomem *base)
> +{
> +	u32 val;
> +
> +	do {
> +		val = readl_relaxed(base + GICD_CTLR);

Maybe rename GICD_CTLR to GICx_CTLR since it is being used for both the
distributor and the redistributor.

> +		cpu_relax();
> +	} while (val & GICD_CTLR_RWP);

Similar to above GICx_CTLR_RWP


> +
> +static int gic_irq_domain_xlate(struct irq_domain *d,
> +				struct device_node *controller,
> +				const u32 *intspec, unsigned int intsize,
> +				unsigned long *out_hwirq, unsigned int *out_type)
> +{
> +	if (d->of_node != controller)
> +		return -EINVAL;
> +	if (intsize < 3)
> +		return -EINVAL;
> +
> +	switch(intspec[0]) {
> +	case 0:			/* SPI */
> +		*out_hwirq = intspec[1] + 32;
> +		break;
> +	case 1:			/* PPI */
> +		*out_hwirq = intspec[1] + 16;
> +		break;

I wonder if there is any value to syncing these with the defines in
"include/dt-bindings/interrupt-controller/arm-gic.h" somehow.

Thanks
Arnab
