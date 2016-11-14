From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 14 Nov 2016 16:30:57 +0000
Subject: [PATCH RFC 3/2] ARM: improve arch_irq_work_has_interrupt()
In-Reply-To: <20161114153630.GN1041@n2100.armlinux.org.uk>
References: <E1c6GpW-0008DO-BD@rmk-PC.armlinux.org.uk>
 <20161114153630.GN1041@n2100.armlinux.org.uk>
Message-ID: <2e14b943-e3a5-6993-48c7-68200c8b08a2@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On 14/11/16 15:36, Russell King - ARM Linux wrote:
> Following on from the previous patch, I think this makes more sense to
> determine whether we can support IRQ work interrupts.
> 
> Whether we can support them or not depends on two things:
> 
> (a) whether the kernel has support for receiving IPIs
> (b) whether it's possible to send an IPI to CPUs including the raising CPU.
> 
> (a) is a function of how the kernel is built - and in the case of ARM, it
> depends whether the kernel is built with SMP enabled or not.
> (b) is a property of the interrupt controller.
> 
> It hasn't ever been a function of the CPU or architecture.
> 
> Commit 059e232089e4 ("irqchip/gic: Allow self-SGIs for SMP on UP
> configurations") changes the GIC IPI code such that we can raise
> SGIs on uniprocessor systems running on a SMP kernel, which means
> we can support IRQ work interrupts here as well.
> 
> So, we shouldn't be using cpu_smp() (or its previous is_smp() here
> at all.  Use a flag to indicate whether we can IPI and use that to
> indicate whether we support irq work interrupts.
> 
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> --- 
>  arch/arm/include/asm/irq_work.h | 11 +++++++++--
>  arch/arm/kernel/irq.c           |  0
>  arch/arm/kernel/smp.c           |  3 +++
>  drivers/irqchip/irq-gic.c       | 17 +++++++++++++----
>  4 files changed, 25 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/include/asm/irq_work.h b/arch/arm/include/asm/irq_work.h
> index 2dc8d7995b48..d7262a3c2f2e 100644
> --- a/arch/arm/include/asm/irq_work.h
> +++ b/arch/arm/include/asm/irq_work.h
> @@ -1,11 +1,18 @@
>  #ifndef __ASM_ARM_IRQ_WORK_H
>  #define __ASM_ARM_IRQ_WORK_H
>  
> -#include <asm/smp_plat.h>
> +extern bool irq_controller_can_ipi;
> +#define irq_controller_can_ipi irq_controller_can_ipi
>  
>  static inline bool arch_irq_work_has_interrupt(void)
>  {
> -	return cpu_smp();
> +#ifdef CONFIG_SMP
> +	/* This depends on the IRQ controller */
> +	return irq_controller_can_ipi;
> +#else
> +	/* The kernel is not built to support IPIs */
> +	return false;
> +#endif
>  }
>  
>  #endif /* _ASM_ARM_IRQ_WORK_H */
> diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
> index 7dd14e8395e6..1fa9412cc4aa 100644
> --- a/arch/arm/kernel/smp.c
> +++ b/arch/arm/kernel/smp.c
> @@ -473,6 +473,9 @@ void __init set_smp_cross_call(void (*fn)(const struct cpumask *, unsigned int))
>  		__smp_cross_call = fn;
>  }
>  
> +/* This indicates whether the IRQ controller can IPI (including self-IPI) */
> +bool irq_controller_can_ipi;

We probably need to initialize this to false, since we have at least 4
other users of set_smp_cross_call() in the tree.

> +
>  static const char *ipi_types[NR_IPI] __tracepoint_string = {
>  #define S(x,s)	[x] = s
>  	S(IPI_WAKEUP, "CPU wakeup interrupts"),
> diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
> index d6c404b3584d..abe8d5807c0f 100644
> --- a/drivers/irqchip/irq-gic.c
> +++ b/drivers/irqchip/irq-gic.c
> @@ -1187,9 +1187,6 @@ static int __init __gic_init_bases(struct gic_chip_data *gic,
>  		 */
>  		for (i = 0; i < NR_GIC_CPU_IF; i++)
>  			gic_cpu_map[i] = 0xff;
> -#ifdef CONFIG_SMP
> -		set_smp_cross_call(gic_raise_softirq);
> -#endif
>  		cpuhp_setup_state_nocalls(CPUHP_AP_IRQ_GIC_STARTING,
>  					  "AP_IRQ_GIC_STARTING",
>  					  gic_starting_cpu, NULL);
> @@ -1207,8 +1204,20 @@ static int __init __gic_init_bases(struct gic_chip_data *gic,
>  	}
>  
>  	ret = gic_init_bases(gic, irq_start, handle);
> -	if (ret)
> +	if (ret) {
>  		kfree(name);
> +		return ret;
> +	}
> +
> +	if (gic == &gic_data[0]) {
> +#ifdef CONFIG_SMP
> +		set_smp_cross_call(gic_raise_softirq);
> +#ifdef irq_controller_can_ipi
> +		if (nr_cpu_ids == 1 || hweight8(gic_cpu_map[0]) == 1)
> +			irq_controller_can_ipi = true;

Am I missing something, or is there any sane configuration where this 
isn't true? Also, maybe it would make some sense to have a more 
streamlined interface to the architecture code. Something along the 
lines of:

diff --git a/arch/arm/include/asm/smp.h b/arch/arm/include/asm/smp.h
index 3d6dc8b..45612d2 100644
--- a/arch/arm/include/asm/smp.h
+++ b/arch/arm/include/asm/smp.h
@@ -48,6 +48,16 @@ extern void smp_init_cpus(void);
  */
 extern void set_smp_cross_call(void (*)(const struct cpumask *, unsigned int));
 
+#ifdef CONFIG_SMP
+#define setup_smp_ipi(f,i)			\
+	do {					\
+		set_smp_cross_call(f);		\
+		irq_controller_can_ipi = (i);	\
+	} while(0)
+#else
+#define setup_smp_ipi(f,i)	do { } while (0)
+#endif
+
 /*
  * Called from platform specific assembly code, this is the
  * secondary CPU entry point.

with the similar entry point for arm64?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
