From: jpihet@mvista.com (Jean Pihet)
Date: Mon, 14 Dec 2009 17:01:20 +0100
Subject: [PATCH 1/5] arm: provide a mechanism to reserve performance
	counters
In-Reply-To: <1260799481-29951-2-git-send-email-jamie.iles@picochip.com>
References: <1260799481-29951-1-git-send-email-jamie.iles@picochip.com>
	<1260799481-29951-2-git-send-email-jamie.iles@picochip.com>
Message-ID: <1260806480.8106.35.camel@def-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I am OK with this code. It is good to have such a reservation mechanism.

Regards,
Jean

On Mon, 2009-12-14 at 14:04 +0000, Jamie Iles wrote:
> To add support for perf events and to allow the hardware
> counters to be shared with oprofile, we need a way to reserve
> access to the pmu (performance monitor unit).
> 
> Cc: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Jamie Iles <jamie.iles@picochip.com>
> ---
>  arch/arm/include/asm/pmu.h |   76 +++++++++++++++++++++++++++++++
>  arch/arm/kernel/Makefile   |    1 +
>  arch/arm/kernel/pmu.c      |  108 ++++++++++++++++++++++++++++++++++++++++++++
>  arch/arm/mm/Kconfig        |    6 +++
>  4 files changed, 191 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/include/asm/pmu.h
>  create mode 100644 arch/arm/kernel/pmu.c
> 
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
> +
> +/**
> + * reserve_pmu() - reserve the hardware performance counters
> + *
> + * Reserve the hardware performance counters in the system for exclusive use.
> + * The 'struct pmu_irqs' for the system is returned on success, ERR_PTR()
> + * encoded error on failure.
> + */
> +extern const struct pmu_irqs *
> +reserve_pmu(void);
> +
> +/**
> + * release_pmu() - Relinquish control of the performance counters
> + *
> + * Release the performance counters and allow someone else to use them.
> + * Callers must have disabled the counters and released IRQs before calling
> + * this. The 'struct pmu_irqs' returned from reserve_pmu() must be passed as
> + * a cookie.
> + */
> +extern void
> +release_pmu(const struct pmu_irqs *irqs);
> +
> +/**
> + * init_pmu() - Initialise the PMU.
> + *
> + * Initialise the system ready for PMU enabling. This should typically set the
> + * IRQ affinity and nothing else. The users (oprofile/perf events etc) will do
> + * the actual hardware initialisation.
> + */
> +extern int
> +init_pmu(void);
> +
> +#else /* CONFIG_CPU_HAS_PMU */
> +
> +static inline const struct pmu_irqs *
> +reserve_pmu(void)
> +{
> +	ERR_PTR(-ENODEV);
> +}
> +
> +static inline void
> +release_pmu(const struct pmu_irqs *irqs)
> +{
> +}
> +
> +static inline int
> +init_pmu(void)
> +{
> +	return -ENODEV;
> +}
> +
> +#endif /* CONFIG_CPU_HAS_PMU */
> +
> +#endif /* __ARM_PMU_H__ */
> diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
> index e7ccf7e..286a276 100644
> --- a/arch/arm/kernel/Makefile
> +++ b/arch/arm/kernel/Makefile
> @@ -46,6 +46,7 @@ obj-$(CONFIG_CPU_XSCALE)	+= xscale-cp0.o
>  obj-$(CONFIG_CPU_XSC3)		+= xscale-cp0.o
>  obj-$(CONFIG_CPU_MOHAWK)	+= xscale-cp0.o
>  obj-$(CONFIG_IWMMXT)		+= iwmmxt.o
> +obj-$(CONFIG_CPU_HAS_PMU)	+= pmu.o
>  AFLAGS_iwmmxt.o			:= -Wa,-mcpu=iwmmxt
>  
>  ifneq ($(CONFIG_ARCH_EBSA110),y)
> diff --git a/arch/arm/kernel/pmu.c b/arch/arm/kernel/pmu.c
> new file mode 100644
> index 0000000..881e526
> --- /dev/null
> +++ b/arch/arm/kernel/pmu.c
> @@ -0,0 +1,108 @@
> +/*
> + *  linux/arch/arm/kernel/pmu.c
> + *
> + *  Copyright (C) 2009 picoChip Designs Ltd, Jamie Iles
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/semaphore.h>
> +#include <linux/err.h>
> +#include <linux/irq.h>
> +
> +#include <asm/pmu.h>
> +#include <asm/irq.h>
> +
> +/*
> + * Define the IRQs for the system. We could use something like a platform
> + * device but that seems fairly heavyweight for this. Also, the performance
> + * counters can't be removed or hotplugged.
> + *
> + * Ordering is important: init_pmu() will use the ordering to set the affinity
> + * to the corresponding core. e.g. the first interrupt will go to cpu 0, the
> + * second goes to cpu 1 etc.
> + */
> +static const struct pmu_irqs pmu_irqs = {
> +#ifdef CONFIG_ARCH_PC3XX
> +	.irqs	    = { IRQ_NPMUIRQ },
> +	.num_irqs   = 1,
> +#elif defined(CONFIG_ARCH_OMAP2)
> +	.irqs	    = { 3 },
> +	.num_irqs   = 1,
> +#elif defined(CONFIG_ARCH_BCMRING)
> +	.irqs	    = { IRQ_PMUIRQ },
> +	.num_irqs   = 1,
> +#elif defined(CONFIG_MACH_REALVIEW_EB)
> +	.irqs	    = {
> +		[0]	= IRQ_EB11MP_PMU_CPU0,
> +		[1]	= IRQ_EB11MP_PMU_CPU1,
> +		[2]	= IRQ_EB11MP_PMU_CPU2,
> +		[3]	= IRQ_EB11MP_PMU_CPU3
> +	},
> +	.num_irqs   = 4,
> +#elif defined(CONFIG_ARCH_OMAP3)
> +	.irqs	    = { INT_34XX_BENCH_MPU_EMUL },
> +	.num_irqs   = 1,
> +#elif defined(CONFIG_ARCH_IOP32X)
> +	.irqs	    = { IRQ_IOP32X_CORE_PMU },
> +	.num_irqs   = 1,
> +#elif defined(CONFIG_ARCH_IOP33X)
> +	.irqs	    = { IRQ_IOP33X_CORE_PMU },
> +	.num_irqs   = 1,
> +#elif defined(CONFIG_ARCH_PXA)
> +	.irqs	    = { IRQ_PMU },
> +	.num_irqs   = 1,
> +#endif
> +};
> +
> +static DECLARE_MUTEX(pmu_mutex);
> +
> +const struct pmu_irqs *
> +reserve_pmu(void)
> +{
> +	int ret = down_trylock(&pmu_mutex) ? -EBUSY : 0;
> +
> +	return ret ? ERR_PTR(ret) : &pmu_irqs;
> +}
> +EXPORT_SYMBOL_GPL(reserve_pmu);
> +
> +void
> +release_pmu(const struct pmu_irqs *irqs)
> +{
> +	WARN_ON(irqs != &pmu_irqs);
> +	up(&pmu_mutex);
> +}
> +EXPORT_SYMBOL_GPL(release_pmu);
> +
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
> +
> +int
> +init_pmu(void)
> +{
> +	int i;
> +
> +	for (i = 0; i < pmu_irqs.num_irqs; ++i)
> +		set_irq_affinity(pmu_irqs.irqs[i], i);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(init_pmu);
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
> +
>  # This selects the TLB model
>  config CPU_TLB_V3
>  	bool
