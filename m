From: robherring2@gmail.com (Rob Herring)
Date: Thu, 07 Jun 2012 19:52:09 -0500
Subject: [PATCH v7 10/12] ARM: SoC: convert highbank to SoC descriptor
In-Reply-To: <1339085369-26073-11-git-send-email-marc.zyngier@arm.com>
References: <1339085369-26073-1-git-send-email-marc.zyngier@arm.com>
 <1339085369-26073-11-git-send-email-marc.zyngier@arm.com>
Message-ID: <4FD14CB9.5040109@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/07/2012 11:09 AM, Marc Zyngier wrote:
> Convert the highbank platform to use the SoC descriptor to provide
> its SMP and CPU hotplug operations.
> 
> Cc: Rob Herring <rob.herring@calxeda.com>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---

Acked-by: Rob Herring <rob.herring@calxeda.com>

>  arch/arm/mach-highbank/core.h     |    8 ++++++++
>  arch/arm/mach-highbank/highbank.c |    7 +++++++
>  arch/arm/mach-highbank/hotplug.c  |    6 +++---
>  arch/arm/mach-highbank/platsmp.c  |   19 +++++++++++++++----
>  4 files changed, 33 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm/mach-highbank/core.h b/arch/arm/mach-highbank/core.h
> index d8e2d0b..d1fd356 100644
> --- a/arch/arm/mach-highbank/core.h
> +++ b/arch/arm/mach-highbank/core.h
> @@ -1,3 +1,5 @@
> +#include <asm/soc.h>
> +
>  extern void highbank_set_cpu_jump(int cpu, void *jump_addr);
>  extern void highbank_clocks_init(void);
>  extern void highbank_restart(char, const char *);
> @@ -8,3 +10,9 @@ extern void highbank_lluart_map_io(void);
>  static inline void highbank_lluart_map_io(void) {}
>  #endif
>  
> +extern int highbank_cpu_kill(unsigned int cpu);
> +extern void highbank_cpu_die(unsigned int cpu);
> +extern int highbank_cpu_disable(unsigned int cpu);
> +
> +extern struct arm_soc_smp_init_ops	highbank_soc_smp_init_ops;
> +extern struct arm_soc_smp_ops		highbank_soc_smp_ops;
> diff --git a/arch/arm/mach-highbank/highbank.c b/arch/arm/mach-highbank/highbank.c
> index 410a112..2dcfd8c 100644
> --- a/arch/arm/mach-highbank/highbank.c
> +++ b/arch/arm/mach-highbank/highbank.c
> @@ -140,7 +140,14 @@ static const char *highbank_match[] __initconst = {
>  	NULL,
>  };
>  
> +static struct arm_soc_desc highbank_soc_desc __initdata = {
> +	.name	= "Calxeda Highbank",
> +	soc_smp_init_ops(highbank_soc_smp_init_ops)
> +	soc_smp_ops(highbank_soc_smp_ops)
> +};
> +
>  DT_MACHINE_START(HIGHBANK, "Highbank")
> +	.soc		= &highbank_soc_desc,
>  	.map_io		= highbank_map_io,
>  	.init_irq	= highbank_init_irq,
>  	.timer		= &highbank_timer,
> diff --git a/arch/arm/mach-highbank/hotplug.c b/arch/arm/mach-highbank/hotplug.c
> index 977cebb..7c25d49 100644
> --- a/arch/arm/mach-highbank/hotplug.c
> +++ b/arch/arm/mach-highbank/hotplug.c
> @@ -24,7 +24,7 @@
>  
>  extern void secondary_startup(void);
>  
> -int platform_cpu_kill(unsigned int cpu)
> +int highbank_cpu_kill(unsigned int cpu)
>  {
>  	return 1;
>  }
> @@ -33,7 +33,7 @@ int platform_cpu_kill(unsigned int cpu)
>   * platform-specific code to shutdown a CPU
>   *
>   */
> -void platform_cpu_die(unsigned int cpu)
> +void highbank_cpu_die(unsigned int cpu)
>  {
>  	flush_cache_all();
>  
> @@ -46,7 +46,7 @@ void platform_cpu_die(unsigned int cpu)
>  	panic("highbank: cpu %d unexpectedly exit from shutdown\n", cpu);
>  }
>  
> -int platform_cpu_disable(unsigned int cpu)
> +int highbank_cpu_disable(unsigned int cpu)
>  {
>  	/*
>  	 * CPU0 should not be shut down via hotplug.  cpu_idle can WFI
> diff --git a/arch/arm/mach-highbank/platsmp.c b/arch/arm/mach-highbank/platsmp.c
> index d01364c..b0e5cd3 100644
> --- a/arch/arm/mach-highbank/platsmp.c
> +++ b/arch/arm/mach-highbank/platsmp.c
> @@ -25,12 +25,12 @@
>  
>  extern void secondary_startup(void);
>  
> -void __cpuinit platform_secondary_init(unsigned int cpu)
> +static void __cpuinit highbank_secondary_init(unsigned int cpu)
>  {
>  	gic_secondary_init(0);
>  }
>  
> -int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
> +static int __cpuinit highbank_boot_secondary(unsigned int cpu, struct task_struct *idle)
>  {
>  	gic_raise_softirq(cpumask_of(cpu), 0);
>  	return 0;
> @@ -40,7 +40,7 @@ int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
>   * Initialise the CPU possible map early - this describes the CPUs
>   * which may be present or become present in the system.
>   */
> -void __init smp_init_cpus(void)
> +static void __init highbank_smp_init_cpus(void)
>  {
>  	unsigned int i, ncores;
>  
> @@ -61,7 +61,7 @@ void __init smp_init_cpus(void)
>  	set_smp_cross_call(gic_raise_softirq);
>  }
>  
> -void __init platform_smp_prepare_cpus(unsigned int max_cpus)
> +static void __init highbank_smp_prepare_cpus(unsigned int max_cpus)
>  {
>  	int i;
>  
> @@ -76,3 +76,14 @@ void __init platform_smp_prepare_cpus(unsigned int max_cpus)
>  	for (i = 1; i < max_cpus; i++)
>  		highbank_set_cpu_jump(i, secondary_startup);
>  }
> +
> +struct arm_soc_smp_init_ops highbank_soc_smp_init_ops __initdata = {
> +	.smp_init_cpus		= highbank_smp_init_cpus,
> +	.smp_prepare_cpus	= highbank_smp_prepare_cpus,
> +};
> +
> +struct arm_soc_smp_ops highbank_soc_smp_ops __initdata = {
> +	.smp_secondary_init	= highbank_secondary_init,
> +	.smp_boot_secondary	= highbank_boot_secondary,
> +	soc_hotplug_ops(highbank)
> +};
