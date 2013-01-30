From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 30 Jan 2013 12:30:06 -0500 (EST)
Subject: Commit 384a290283fde63ba8dc671fca5420111cdac19a seems to break
 11MPCore boot
In-Reply-To: <20130130171918.GO23505@n2100.arm.linux.org.uk>
References: <51093B0B.7010708@arm.com>
 <alpine.LFD.2.02.1301301050230.6300@xanadu.home>
 <20130130162132.GM23505@n2100.arm.linux.org.uk>
 <20130130164535.GN23505@n2100.arm.linux.org.uk>
 <20130130171918.GO23505@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.02.1301301223290.6300@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 30 Jan 2013, Russell King - ARM Linux wrote:

> On Wed, Jan 30, 2013 at 04:45:35PM +0000, Russell King - ARM Linux wrote:
> > What we could do is scan interrupts 0-31 for a non-zero value.  If they're
> > all zero, we should complain.  Otherwise, we use the first non-zero value
> > we find and validate it for a single bit set.
> 
> And here's a patch to do this - I've not run this but it's just built
> successfully here.  Anyone want to give it a go?
> 
> I've decided that if we do hit the mask==0 case, we should just wail
> loudly - panic'ing will bring the kernel to a halt right there and then,
> which may be before any console drivers have been initialized (and the
> kernel message buffer is no longer easy to read).  Moreover, panic()ing,
> along with the possibility of rebooting won't really fix this kind of
> error - it's rather fatal as far as that goes.  So, I think just wailing
> at CRIT level is fine for this condition that should not occur.
> 
>  arch/arm/common/gic.c |   23 +++++++++++++++++++++--
>  1 files changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/common/gic.c b/arch/arm/common/gic.c
> index 36ae03a..3bcef49 100644
> --- a/arch/arm/common/gic.c
> +++ b/arch/arm/common/gic.c
> @@ -351,6 +351,23 @@ void __init gic_cascade_irq(unsigned int gic_nr, unsigned int irq)
>  	irq_set_chained_handler(irq, gic_handle_cascade_irq);
>  }
>  
> +static u8 gic_get_cpumask(struct gic_chip_data *gic)
> +{
> +	void __iomem *base = gic_data_dist_base(gic);
> +	u8 mask, i;
> +
> +	for (i = mask = 0; i < 32; i++) {
> +		mask = readl_relaxed(base + GIC_DIST_TARGET + i);
> +		if (mask)
> +			break;
> +	}

That should probably be:

	u32 mask;

	for (i = 0; i < 32; i += 4) {
		mask = readl_relaxed(base + GIC_DIST_TARGET + i);
		mask |= (mask >> 16);
		mask |= (mask >> 8);
		if (mask)
			return mask;
	}

I know that the spec says that the GIC should accept byte sized 
accesses, but that too is known not to work on all implementations.


Nicolas
