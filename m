From: julien.thierry@arm.com (Julien Thierry)
Date: Wed, 7 Nov 2018 17:42:58 +0000
Subject: [PATCH v2 5/5] ARM: spectre-v2: per-CPU vtables to work around
 big.Little systems
In-Reply-To: <E1gK0dU-0007Mp-4h@rmk-PC.armlinux.org.uk>
References: <20181106123700.GA30658@n2100.armlinux.org.uk>
 <E1gK0dU-0007Mp-4h@rmk-PC.armlinux.org.uk>
Message-ID: <ad561d7d-deed-068e-7048-cdf746f1c6d4@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russel,

On 06/11/18 12:39, Russell King wrote:
> In big.Little systems, some CPUs require the Spectre workarounds in
> paths such as the context switch, but other CPUs do not.  In order
> to handle these differences, we need per-CPU vtables.
> 
> We are unable to use the kernel's per-CPU variables to support this
> as per-CPU is not initialised at times when we need access to the
> vtables, so we have to use an array indexed by logical CPU number.
> 
> We use an array-of-pointers to avoid having function pointers in
> the kernel's read/write .data section.
> 
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> ---
>   arch/arm/include/asm/proc-fns.h | 20 ++++++++++++++++++++
>   arch/arm/kernel/setup.c         |  5 +++++
>   arch/arm/kernel/smp.c           | 31 +++++++++++++++++++++++++++++++
>   arch/arm/mm/proc-v7-bugs.c      | 17 ++---------------
>   4 files changed, 58 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/arm/include/asm/proc-fns.h b/arch/arm/include/asm/proc-fns.h
> index c259cc49c641..fe58fb3c4b4e 100644
> --- a/arch/arm/include/asm/proc-fns.h
> +++ b/arch/arm/include/asm/proc-fns.h
> @@ -104,12 +104,32 @@ extern void cpu_do_resume(void *);
>   #else
>   
>   extern struct processor processor;
> +#if defined(CONFIG_BIG_LITTLE) && defined(CONFIG_HARDEN_BRANCH_PREDICTOR)
> +#include <linux/smp.h>
> +/*
> + * This can't be a per-cpu variable because we need to access it before
> + * per-cpu has been initialised.
> + */
> +extern struct processor *cpu_vtable[];
> +#define PROC_VTABLE(f)			cpu_vtable[smp_processor_id()]->f
> +#define PROC_TABLE(f)			cpu_vtable[0]->f

I feel it would be worth to have a comment to explain why we need the 
distinction between PROC_TABLE and PROC_VTABLE. I currently understand 
thanks to the commit message (of the previous patch), but just reading 
the code I probably would be very confused.

Otherwise things look good to me:

Reviewed-by: Julien Thierry <julien.thierry@arm.com>

Thanks,

Julien

> +static inline void init_proc_vtable(const struct processor *p)
> +{
> +	unsigned int cpu = smp_processor_id();
> +	*cpu_vtable[cpu] = *p;
> +	WARN_ON_ONCE(cpu_vtable[cpu]->dcache_clean_area !=
> +		     cpu_vtable[0]->dcache_clean_area);
> +	WARN_ON_ONCE(cpu_vtable[cpu]->set_pte_ext !=
> +		     cpu_vtable[0]->set_pte_ext);
> +}
> +#else
>   #define PROC_VTABLE(f)			processor.f
>   #define PROC_TABLE(f)			processor.f
>   static inline void init_proc_vtable(const struct processor *p)
>   {
>   	processor = *p;
>   }
> +#endif
>   
>   #define cpu_proc_init			PROC_VTABLE(_proc_init)
>   #define cpu_check_bugs			PROC_VTABLE(check_bugs)
> diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
> index c214bd14a1fe..cd46a595422c 100644
> --- a/arch/arm/kernel/setup.c
> +++ b/arch/arm/kernel/setup.c
> @@ -115,6 +115,11 @@ EXPORT_SYMBOL(elf_hwcap2);
>   
>   #ifdef MULTI_CPU
>   struct processor processor __ro_after_init;
> +#if defined(CONFIG_BIG_LITTLE) && defined(CONFIG_HARDEN_BRANCH_PREDICTOR)
> +struct processor *cpu_vtable[NR_CPUS] = {
> +	[0] = &processor,
> +};
> +#endif
>   #endif
>   #ifdef MULTI_TLB
>   struct cpu_tlb_fns cpu_tlb __ro_after_init;
> diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
> index 5ad0b67b9e33..82b879db32ee 100644
> --- a/arch/arm/kernel/smp.c
> +++ b/arch/arm/kernel/smp.c
> @@ -42,6 +42,7 @@
>   #include <asm/mmu_context.h>
>   #include <asm/pgtable.h>
>   #include <asm/pgalloc.h>
> +#include <asm/procinfo.h>
>   #include <asm/processor.h>
>   #include <asm/sections.h>
>   #include <asm/tlbflush.h>
> @@ -102,6 +103,30 @@ static unsigned long get_arch_pgd(pgd_t *pgd)
>   #endif
>   }
>   
> +#if defined(CONFIG_BIG_LITTLE) && defined(CONFIG_HARDEN_BRANCH_PREDICTOR)
> +static int secondary_biglittle_prepare(unsigned int cpu)
> +{
> +	if (!cpu_vtable[cpu])
> +		cpu_vtable[cpu] = kzalloc(sizeof(*cpu_vtable[cpu]), GFP_KERNEL);
> +
> +	return cpu_vtable[cpu] ? 0 : -ENOMEM;
> +}
> +
> +static void secondary_biglittle_init(void)
> +{
> +	init_proc_vtable(lookup_processor(read_cpuid_id())->proc);
> +}
> +#else
> +static int secondary_biglittle_prepare(unsigned int cpu)
> +{
> +	return 0;
> +}
> +
> +static void secondary_biglittle_init(void)
> +{
> +}
> +#endif
> +
>   int __cpu_up(unsigned int cpu, struct task_struct *idle)
>   {
>   	int ret;
> @@ -109,6 +134,10 @@ int __cpu_up(unsigned int cpu, struct task_struct *idle)
>   	if (!smp_ops.smp_boot_secondary)
>   		return -ENOSYS;
>   
> +	ret = secondary_biglittle_prepare(cpu);
> +	if (ret)
> +		return ret;
> +
>   	/*
>   	 * We need to tell the secondary core where to find
>   	 * its stack and the page tables.
> @@ -360,6 +389,8 @@ asmlinkage void secondary_start_kernel(void)
>   	struct mm_struct *mm = &init_mm;
>   	unsigned int cpu;
>   
> +	secondary_biglittle_init();
> +
>   	/*
>   	 * The identity mapping is uncached (strongly ordered), so
>   	 * switch away from it before attempting any exclusive accesses.
> diff --git a/arch/arm/mm/proc-v7-bugs.c b/arch/arm/mm/proc-v7-bugs.c
> index 5544b82a2e7a..9a07916af8dd 100644
> --- a/arch/arm/mm/proc-v7-bugs.c
> +++ b/arch/arm/mm/proc-v7-bugs.c
> @@ -52,8 +52,6 @@ static void cpu_v7_spectre_init(void)
>   	case ARM_CPU_PART_CORTEX_A17:
>   	case ARM_CPU_PART_CORTEX_A73:
>   	case ARM_CPU_PART_CORTEX_A75:
> -		if (processor.switch_mm != cpu_v7_bpiall_switch_mm)
> -			goto bl_error;
>   		per_cpu(harden_branch_predictor_fn, cpu) =
>   			harden_branch_predictor_bpiall;
>   		spectre_v2_method = "BPIALL";
> @@ -61,8 +59,6 @@ static void cpu_v7_spectre_init(void)
>   
>   	case ARM_CPU_PART_CORTEX_A15:
>   	case ARM_CPU_PART_BRAHMA_B15:
> -		if (processor.switch_mm != cpu_v7_iciallu_switch_mm)
> -			goto bl_error;
>   		per_cpu(harden_branch_predictor_fn, cpu) =
>   			harden_branch_predictor_iciallu;
>   		spectre_v2_method = "ICIALLU";
> @@ -88,11 +84,9 @@ static void cpu_v7_spectre_init(void)
>   					  ARM_SMCCC_ARCH_WORKAROUND_1, &res);
>   			if ((int)res.a0 != 0)
>   				break;
> -			if (processor.switch_mm != cpu_v7_hvc_switch_mm && cpu)
> -				goto bl_error;
>   			per_cpu(harden_branch_predictor_fn, cpu) =
>   				call_hvc_arch_workaround_1;
> -			processor.switch_mm = cpu_v7_hvc_switch_mm;
> +			cpu_do_switch_mm = cpu_v7_hvc_switch_mm;
>   			spectre_v2_method = "hypervisor";
>   			break;
>   
> @@ -101,11 +95,9 @@ static void cpu_v7_spectre_init(void)
>   					  ARM_SMCCC_ARCH_WORKAROUND_1, &res);
>   			if ((int)res.a0 != 0)
>   				break;
> -			if (processor.switch_mm != cpu_v7_smc_switch_mm && cpu)
> -				goto bl_error;
>   			per_cpu(harden_branch_predictor_fn, cpu) =
>   				call_smc_arch_workaround_1;
> -			processor.switch_mm = cpu_v7_smc_switch_mm;
> +			cpu_do_switch_mm = cpu_v7_smc_switch_mm;
>   			spectre_v2_method = "firmware";
>   			break;
>   
> @@ -119,11 +111,6 @@ static void cpu_v7_spectre_init(void)
>   	if (spectre_v2_method)
>   		pr_info("CPU%u: Spectre v2: using %s workaround\n",
>   			smp_processor_id(), spectre_v2_method);
> -	return;
> -
> -bl_error:
> -	pr_err("CPU%u: Spectre v2: incorrect context switching function, system vulnerable\n",
> -		cpu);
>   }
>   #else
>   static void cpu_v7_spectre_init(void)
> 

-- 
Julien Thierry
