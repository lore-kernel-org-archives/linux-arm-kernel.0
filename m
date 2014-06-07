From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Sat, 7 Jun 2014 18:56:18 +0100
Subject: Problems booting exynos5420 with >1 CPU
In-Reply-To: <alpine.LFD.2.11.1406062340480.25775@knanqh.ubzr>
References: <CAD=FV=UX90hgyojW3k_kpT=mt8eX9=AyHr+AGjhK=MrE1hHbUA@mail.gmail.com>
 <539145B4.5000200@gmail.com>
 <CAD=FV=XqwEQNJmij-4Gh62OY+B66AjdQjZC0=f_6tbot3UfQaA@mail.gmail.com>
 <CAM4voaknx3+X4O8MUwaruUFPyquY8Opq61ucKX08xTrv8PqfLg@mail.gmail.com>
 <alpine.LFD.2.11.1406061740280.25775@knanqh.ubzr>
 <CAM4voam5KDicwLAt3EA1UC7M+EciGccrnMUKxoR-5c8xT8-zSQ@mail.gmail.com>
 <alpine.LFD.2.11.1406062340480.25775@knanqh.ubzr>
Message-ID: <20140607175618.GA25068@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 07, 2014 at 05:10:27PM +0100, Nicolas Pitre wrote:
> On Sat, 7 Jun 2014, Abhilash Kesavan wrote:
> 
> > Hi Nicolas,
> > 
> > The first man of the incoming cluster enables its snoops via the
> > power_up_setup function. During secondary boot-up, this does not occur
> > for the boot cluster. Hence, I enable the snoops for the boot cluster
> > as a one-time setup from the u-boot prompt. After secondary boot-up
> > there is no modification that I do.
> 
> OK that's good.
> 
> > Where should this be ideally done ?
> 
> If I remember correctly, the CCI can be safely activated only when the 
> cache is disabled.  So that means the CCI should ideally be turned on 
> for the boot cluster (and *only* for the boot CPU) by the bootloader.

CCI ports are enabled per-cluster, so the boot loader must turn on
CCI for all clusters before the respective CPUs have a chance to
turn on their caches. It is a secure operation, this can be overriden
and probably that's what has been done, wrongly.

True, TC2 on warm-boot reenables CCI, and that's because it runs the
kernel in secure world, and again that's _wrong_.

It must be done in firmware, and I am totally against any attempt at
papering over what looks like a messed up firmware implementation with
a bunch of hacks in the kernel, because that's what the patch below is
(soft restarting a CPU to enable CCI ? and adding generic code for that ?
what's next ?)

I understand there is an issue and lots at stake here, but I do not want the
patch below to be merged in the kernel, I am sorry, it is a tad too much.

Lorenzo

> 
> Now... If you _really_ prefer to do it from the kernel to avoid 
> difficulties with bootloader updates, then it should be possible to do 
> it from the kernel by temporarily turning the cache off.  This is not a 
> small thing but the MCPM infrastructure can be leveraged.  Here's what I 
> tried on a TC2 which might just work for you as well:
> 
> diff --git a/arch/arm/common/mcpm_entry.c b/arch/arm/common/mcpm_entry.c
> index 86fd60fefb..1cc49de308 100644
> --- a/arch/arm/common/mcpm_entry.c
> +++ b/arch/arm/common/mcpm_entry.c
> @@ -12,11 +12,13 @@
>  #include <linux/kernel.h>
>  #include <linux/init.h>
>  #include <linux/irqflags.h>
> +#include <linux/cpu_pm.h>
>  
>  #include <asm/mcpm.h>
>  #include <asm/cacheflush.h>
>  #include <asm/idmap.h>
>  #include <asm/cputype.h>
> +#include <asm/suspend.h>
>  
>  extern unsigned long mcpm_entry_vectors[MAX_NR_CLUSTERS][MAX_CPUS_PER_CLUSTER];
>  
> @@ -146,6 +148,44 @@ int mcpm_cpu_powered_up(void)
>  	return 0;
>  }
>  
> +static int go_down(unsigned long _arg)
> +{
> +	void (*cache_disable)(void) = (void *)_arg;
> +	unsigned int mpidr = read_cpuid_mpidr();
> +	unsigned int cpu = MPIDR_AFFINITY_LEVEL(mpidr, 0);
> +	unsigned int cluster = MPIDR_AFFINITY_LEVEL(mpidr, 1);
> +	phys_reset_t phys_reset;
> +
> +	mcpm_set_entry_vector(cpu, cluster, cpu_resume);
> +	setup_mm_for_reboot();
> +
> +	__mcpm_cpu_going_down(cpu, cluster);
> +	BUG_ON(!__mcpm_outbound_enter_critical(cpu, cluster));
> +	cache_disable();
> +	__mcpm_outbound_leave_critical(cluster, CLUSTER_DOWN);
> +	__mcpm_cpu_down(cpu, cluster);
> +
> +	phys_reset = (phys_reset_t)(unsigned long)virt_to_phys(cpu_reset);
> +	phys_reset(virt_to_phys(mcpm_entry_point));
> +	BUG();
> +}
> +	
> +int mcpm_loopback(void (*cache_disable)(void))
> +{
> +	int ret;
> +
> +	local_irq_disable();
> +	local_fiq_disable();
> +	ret = cpu_pm_enter();
> +	if (!ret) {
> +		ret = cpu_suspend((unsigned long)cache_disable, go_down);
> +		cpu_pm_exit();
> +	}
> +	local_fiq_enable();
> +	local_irq_enable();
> +	return ret;
> +}
> +
>  struct sync_struct mcpm_sync;
>  
>  /*
> diff --git a/arch/arm/mach-vexpress/tc2_pm.c b/arch/arm/mach-vexpress/tc2_pm.c
> index 29e7785a54..abecdd734f 100644
> --- a/arch/arm/mach-vexpress/tc2_pm.c
> +++ b/arch/arm/mach-vexpress/tc2_pm.c
> @@ -323,6 +323,26 @@ static void __naked tc2_pm_power_up_setup(unsigned int affinity_level)
>  "	b	cci_enable_port_for_self ");
>  }
>  
> +int mcpm_loopback(void (*cache_disable)(void));
> +
> +static void tc2_cache_down(void)
> +{
> +	pr_warn("TC2: disabling cache\n");
> +	if (read_cpuid_part_number() == ARM_CPU_PART_CORTEX_A15) {
> +		/*
> +		 * On the Cortex-A15 we need to disable
> +		 * L2 prefetching before flushing the cache.
> +		 */
> +		asm volatile(
> +		"mcr	p15, 1, %0, c15, c0, 3 \n\t"
> +		"isb	\n\t"
> +		"dsb	"
> +		: : "r" (0x400) );
> +	}
> +	v7_exit_coherency_flush(all);
> +	cci_disable_port_by_cpu(read_cpuid_mpidr());
> +}
> +
>  static int __init tc2_pm_init(void)
>  {
>  	int ret, irq;
> @@ -370,6 +390,7 @@ static int __init tc2_pm_init(void)
>  	ret = mcpm_platform_register(&tc2_pm_power_ops);
>  	if (!ret) {
>  		mcpm_sync_init(tc2_pm_power_up_setup);
> +		BUG_ON(mcpm_loopback(tc2_cache_down) != 0);
>  		pr_info("TC2 power management initialized\n");
>  	}
>  	return ret;
> 
> Of course it is not because I'm helping you sidestepping firmware 
> problems that I'll stop shaming those who came up with that firmware 
> design.  ;-)
> 
> 
> Nicolas
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
