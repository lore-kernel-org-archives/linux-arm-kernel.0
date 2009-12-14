From: will.deacon@arm.com (Will Deacon)
Date: Mon, 14 Dec 2009 14:39:59 -0000
Subject: [PATCH 1/5] arm: provide a mechanism to reserve performance
	counters
In-Reply-To: <1260799481-29951-2-git-send-email-jamie.iles@picochip.com>
References: <1260799481-29951-1-git-send-email-jamie.iles@picochip.com>
	<1260799481-29951-2-git-send-email-jamie.iles@picochip.com>
Message-ID: <000e01ca7ccb$4ff2adb0$efd80910$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Jamie Iles wrote:

> To add support for perf events and to allow the hardware
> counters to be shared with oprofile, we need a way to reserve
> access to the pmu (performance monitor unit).

Hi Jamie, this is looking good. It's nice to see the IRQ stuff moving
out of oprofile. Comments are inline.

> diff --git a/arch/arm/include/asm/pmu.h b/arch/arm/include/asm/pmu.h
> new file mode 100644
> index 0000000..d66a7cd
> --- /dev/null
> +++ b/arch/arm/include/asm/pmu.h
> @@ -0,0 +1,76 @@
> +/*
> + *  linux/arch/arm/include/asm/pmu.h
> + *
> + *  Copyright (C) 2009 picoChip Designs Ltd, Jamie Iles
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + */
> +
> +#ifndef __ARM_PMU_H__
> +#define __ARM_PMU_H__
> +
> +#ifdef CONFIG_CPU_HAS_PMU
> +
> +#define MAX_PMU_IRQS	    8
> +
> +struct pmu_irqs {
> +	int	    irqs[MAX_PMU_IRQS];
> +	unsigned    num_irqs;
> +};

Since we're populating this struct at compile time anyway, could we make it
an array and use the ARRAY_SIZE macro to get the number of irqs? This would
also mean that MAX_PMU_IRQS could be removed.

> diff --git a/arch/arm/kernel/pmu.c b/arch/arm/kernel/pmu.c
> new file mode 100644
> index 0000000..881e526
> --- /dev/null
> +++ b/arch/arm/kernel/pmu.c
<snip>
> +void
> +release_pmu(const struct pmu_irqs *irqs)
> +{
> +	WARN_ON(irqs != &pmu_irqs);
> +	up(&pmu_mutex);
> +}
> +EXPORT_SYMBOL_GPL(release_pmu);

I think it would be better to allow release to fail and do so if the irqs
don't match, otherwise a malicious oprofile module could release on behalf of
perf :).

> +static void
> +set_irq_affinity(int irq,
> +		 unsigned int cpu)
> +{
> +#ifdef CONFIG_SMP
> +	struct irq_desc *desc = irq_desc + irq;
> +	const struct cpumask *mask = cpumask_of(cpu);
> +	unsigned long flags;
> +
> +	raw_spin_lock_irqsave(&desc->lock, flags);
> +	cpumask_copy(desc->affinity, mask);
> +	desc->chip->set_affinity(irq, mask);
> +	raw_spin_unlock_irqrestore(&desc->lock, flags);
> +#endif
> +}

Why not use irq_set_affinity(irq, cpumask_of(cpu))?
This function isn't exported, but I don't envisage building the pmu
as a module.

> diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
> index dd4698c..fc5c05b 100644
> --- a/arch/arm/mm/Kconfig
> +++ b/arch/arm/mm/Kconfig
> @@ -342,6 +342,7 @@ config CPU_XSCALE
>  	select CPU_PABRT_LEGACY
>  	select CPU_CACHE_VIVT
>  	select CPU_CP15_MMU
> +	select CPU_HAS_PMU
>  	select CPU_TLB_V4WBI if MMU
> 
>  # XScale Core Version 3
> @@ -398,6 +399,7 @@ config CPU_V6
>  	select CPU_HAS_ASID if MMU
>  	select CPU_COPY_V6 if MMU
>  	select CPU_TLB_V6 if MMU
> +	select CPU_HAS_PMU
> 
>  # ARMv6k
>  config CPU_32v6K
> @@ -421,6 +423,7 @@ config CPU_V7
>  	select CPU_CACHE_V7
>  	select CPU_CACHE_VIPT
>  	select CPU_CP15_MMU
> +	select CPU_HAS_PMU
>  	select CPU_HAS_ASID if MMU
>  	select CPU_COPY_V6 if MMU
>  	select CPU_TLB_V7 if MMU
> @@ -536,6 +539,9 @@ config CPU_COPY_FA
>  config CPU_COPY_V6
>  	bool
> 
> +config CPU_HAS_PMU
> +	bool

I think all v6 cores and above have a PMU, so you could set the bool based on that
(and add the exceptional cases like xscale).

I've got a quad-core pb11mp box so once this is settled I'll give it a test in an SMP
environment.

Cheers,

Will
