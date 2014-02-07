From: cov@codeaurora.org (Christopher Covington)
Date: Fri, 07 Feb 2014 08:52:12 -0500
Subject: [PATCH 01/18] arm64: initial support for GICv3
In-Reply-To: <loom.20140207T065340-308@post.gmane.org>
References: <1391607050-540-1-git-send-email-marc.zyngier@arm.com>
 <1391607050-540-2-git-send-email-marc.zyngier@arm.com>
 <loom.20140207T065340-308@post.gmane.org>
Message-ID: <52F4E50C.9050503@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/07/2014 03:59 AM, Arnab Basu wrote:
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
> 
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

GICx_ makes it sound relevant for GIC CPU interfaces (GICC) as well. Unless it
is, maybe something more like GICDR_ for Generic Interrupt Controller
Distributor/Redistributor would be best?

Christopher

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by the Linux Foundation.
