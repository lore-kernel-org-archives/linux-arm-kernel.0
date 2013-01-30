From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 30 Jan 2013 16:02:06 -0500 (EST)
Subject: Commit 384a290283fde63ba8dc671fca5420111cdac19a seems to break
 11MPCore boot
In-Reply-To: <20130130203014.GU23505@n2100.arm.linux.org.uk>
References: <51093B0B.7010708@arm.com>
 <alpine.LFD.2.02.1301301050230.6300@xanadu.home>
 <20130130162132.GM23505@n2100.arm.linux.org.uk>
 <20130130164535.GN23505@n2100.arm.linux.org.uk>
 <20130130171918.GO23505@n2100.arm.linux.org.uk>
 <alpine.LFD.2.02.1301301223290.6300@xanadu.home>
 <20130130203014.GU23505@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.02.1301301556060.6300@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 30 Jan 2013, Russell King - ARM Linux wrote:

> Right... this is what my current set of patches to make things work
> again looks like... and still there's more problems to go...
> 
[...]
> diff --git a/arch/arm/common/gic.c b/arch/arm/common/gic.c
> index 36ae03a..87dfa90 100644
> --- a/arch/arm/common/gic.c
> +++ b/arch/arm/common/gic.c
> @@ -351,6 +351,25 @@ void __init gic_cascade_irq(unsigned int gic_nr, unsigned int irq)
>  	irq_set_chained_handler(irq, gic_handle_cascade_irq);
>  }
>  
> +static u8 gic_get_cpumask(struct gic_chip_data *gic)
> +{
> +	void __iomem *base = gic_data_dist_base(gic);
> +	u32 mask, i;
> +
> +	for (i = mask = 0; i < 32; i += 4) {
> +		mask = readl_relaxed(base + GIC_DIST_TARGET + i);
> +		mask |= mask >> 16;
> +		mask |= mask >> 8;
> +		if (mask)
> +			break;
> +	}
> +
> +	if (!mask)
> +		pr_crit("GIC CPU mask not found - kernel will fail to boot.\n");
> +
> +	return mask;
> +}
> +
>  static void __init gic_dist_init(struct gic_chip_data *gic)
>  {
>  	unsigned int i;
> @@ -369,7 +388,9 @@ static void __init gic_dist_init(struct gic_chip_data *gic)
>  	/*
>  	 * Set all global interrupts to this CPU only.
>  	 */
> -	cpumask = readl_relaxed(base + GIC_DIST_TARGET + 0);
> +	cpumask = gic_get_cpumask(gic);
> +	cpumask |= cpumask << 8;
> +	cpumask |= cpumask << 16;
>  	for (i = 32; i < gic_irqs; i += 4)
>  		writel_relaxed(cpumask, base + GIC_DIST_TARGET + i * 4 / 4);
>  
> @@ -400,7 +421,7 @@ static void __cpuinit gic_cpu_init(struct gic_chip_data *gic)
>  	 * Get what the GIC says our CPU mask is.
>  	 */
>  	BUG_ON(cpu >= NR_GIC_CPU_IF);
> -	cpu_mask = readl_relaxed(dist_base + GIC_DIST_TARGET + 0);
> +	cpu_mask = gic_get_cpumask(gic);
>  	gic_cpu_map[cpu] = cpu_mask;
>  
>  	/*

For the above...

Reviewed-by: Nicolas Pitre <nico@linaro.org>

I'm not familiar with Realview and the other issues being fixed.


Nicolas
