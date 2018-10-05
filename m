From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Fri, 5 Oct 2018 11:09:40 +0200
Subject: [PATCH 5/5] ARM: spectre-v2: per-CPU vtables to work around
 big.Little systems
In-Reply-To: <E1g2Z6e-0003es-CI@rmk-PC.armlinux.org.uk>
References: <20180919094802.GH30658@n2100.armlinux.org.uk>
 <CGME20180919095028epcas3p3e1a927bb7e88c6891d43abfdc51603e7@epcas3p3.samsung.com>
 <E1g2Z6e-0003es-CI@rmk-PC.armlinux.org.uk>
Message-ID: <20181005090941eucas1p14031cd38d78e9d561975925bf977727d~aq0-OFZeE1866318663eucas1p1b@eucas1p1.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

On 2018-09-19 11:49, Russell King wrote:
> In big.Little systems, some CPUs require the Spectre workarounds in
> paths such as the context switch, but other CPUs do not.  In order
> to handle these differences, we need per-CPU vtables.
>
> We are unable to use the kernel's per-CPU variables to support this
> as per-CPU is not initialised at times when we need access to the
> vtables, so we have to use an array indexed by logical CPU number.
>
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>

This patch causes lots of kernel 'BUG' messages on all Samsung Exynos
boards.? It started to appear since it has been merged to linux-next
on 20181002.? I wonder if this issue is Exynos specific or there are
some patches missing in linux-next, which should fix those 'BUGS'.
If this is Exynos specific, please let us know what should be changed
in Exynos platform code to avoid this issue.

Here are some examples:

BUG: using smp_processor_id() in preemptible [00000000] code: startpar/117
caller is pgd_alloc+0x54/0x160
CPU: 3 PID: 117 Comm: startpar Not tainted 4.16.0-00029-gc6eb8a2e9190 #862
Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
[<c0111074>] (unwind_backtrace) from [<c010d64c>] (show_stack+0x10/0x14)
[<c010d64c>] (show_stack) from [<c09b5c50>] (dump_stack+0x90/0xc8)
[<c09b5c50>] (dump_stack) from [<c044b76c>]
(check_preemption_disabled+0x118/0x130)
[<c044b76c>] (check_preemption_disabled) from [<c0119edc>]
(pgd_alloc+0x54/0x160)
[<c0119edc>] (pgd_alloc) from [<c0121570>] (mm_init+0xe4/0x174)
[<c0121570>] (mm_init) from [<c01234a4>] (copy_process.part.5+0x1480/0x1a9c)
[<c01234a4>] (copy_process.part.5) from [<c0123c24>] (_do_fork+0xc4/0x7ec)
[<c0123c24>] (_do_fork) from [<c012441c>] (SyS_clone+0x24/0x2c)
[<c012441c>] (SyS_clone) from [<c0101000>] (ret_fast_syscall+0x0/0x28)

BUG: using smp_processor_id() in preemptible [00000000] code:
checkroot-bootc/686
[<c010d64c>] (show_stack) from [<c09b5c50>] (dump_stack+0x90/0xc8)
caller is pgd_alloc+0x54/0x160
[<c09b5c50>] (dump_stack) from [<c044b76c>]
(check_preemption_disabled+0x118/0x130)
[<c044b76c>] (check_preemption_disabled) from [<c025a594>]
(vmap_page_range_noflush+0x114/0x1dc)
[<c025a594>] (vmap_page_range_noflush) from [<c025a68c>]
(map_vm_area+0x30/0x64)
[<c025a68c>] (map_vm_area) from [<c025b9bc>]
(__vmalloc_node_range+0x14c/0x220)
[<c025b9bc>] (__vmalloc_node_range) from [<c025bad8>]
(__vmalloc_node+0x48/0x50)
[<c025bad8>] (__vmalloc_node) from [<c025bb14>] (vmalloc+0x34/0x3c)
[<c025bb14>] (vmalloc) from [<c04b2960>] (n_tty_open+0x10/0xc8)
[<c04b2960>] (n_tty_open) from [<c04b66d8>] (tty_ldisc_open+0x3c/0x78)
[<c04b66d8>] (tty_ldisc_open) from [<c04b6ebc>] (tty_ldisc_setup+0x14/0x58)
[<c04b6ebc>] (tty_ldisc_setup) from [<c04b11ec>] (tty_init_dev+0xa4/0x1b0)
[<c04b11ec>] (tty_init_dev) from [<c04bab78>] (ptmx_open+0x90/0x160)
[<c04bab78>] (ptmx_open) from [<c02792d8>] (chrdev_open+0x9c/0x174)
[<c02792d8>] (chrdev_open) from [<c0271524>] (do_dentry_open+0xfc/0x30c)
[<c0271524>] (do_dentry_open) from [<c02833e4>] (path_openat+0x454/0xed0)
[<c02833e4>] (path_openat) from [<c0284968>] (do_filp_open+0x60/0xb4)
[<c0284968>] (do_filp_open) from [<c0272cb8>] (do_sys_open+0x118/0x1c4)
[<c0272cb8>] (do_sys_open) from [<c0101000>] (ret_fast_syscall+0x0/0x28)


> ---
>  arch/arm/include/asm/proc-fns.h | 14 ++++++++++++++
>  arch/arm/kernel/setup.c         |  5 +++++
>  arch/arm/kernel/smp.c           | 31 +++++++++++++++++++++++++++++++
>  arch/arm/mm/proc-v7-bugs.c      | 17 ++---------------
>  4 files changed, 52 insertions(+), 15 deletions(-)
>
> diff --git a/arch/arm/include/asm/proc-fns.h b/arch/arm/include/asm/proc-fns.h
> index 571a1346245b..ddbb25cb8968 100644
> --- a/arch/arm/include/asm/proc-fns.h
> +++ b/arch/arm/include/asm/proc-fns.h
> @@ -104,11 +104,25 @@ extern void cpu_do_resume(void *);
>  #else
>  
>  extern struct processor processor;
> +#if defined(CONFIG_BIG_LITTLE) && defined(CONFIG_HARDEN_BRANCH_PREDICTOR)
> +#include <linux/smp.h>
> +/*
> + * This can't be a per-cpu variable because we need to access it before
> + * per-cpu has been initialised.
> + */
> +extern struct processor *cpu_vtable[];
> +#define PROC_VTABLE(f)			cpu_vtable[smp_processor_id()]->f
> +static inline void init_proc_vtable(const struct processor *p)
> +{
> +	*cpu_vtable[smp_processor_id()] = *p;
> +}
> +#else
>  #define PROC_VTABLE(f)			processor.f
>  static inline void init_proc_vtable(const struct processor *p)
>  {
>  	processor = *p;
>  }
> +#endif
>  
>  #define cpu_proc_init			PROC_VTABLE(_proc_init)
>  #define cpu_check_bugs			PROC_VTABLE(check_bugs)
> diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
> index c214bd14a1fe..cd46a595422c 100644
> --- a/arch/arm/kernel/setup.c
> +++ b/arch/arm/kernel/setup.c
> @@ -115,6 +115,11 @@ EXPORT_SYMBOL(elf_hwcap2);
>  
>  #ifdef MULTI_CPU
>  struct processor processor __ro_after_init;
> +#if defined(CONFIG_BIG_LITTLE) && defined(CONFIG_HARDEN_BRANCH_PREDICTOR)
> +struct processor *cpu_vtable[NR_CPUS] = {
> +	[0] = &processor,
> +};
> +#endif
>  #endif
>  #ifdef MULTI_TLB
>  struct cpu_tlb_fns cpu_tlb __ro_after_init;
> diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
> index 5ad0b67b9e33..82b879db32ee 100644
> --- a/arch/arm/kernel/smp.c
> +++ b/arch/arm/kernel/smp.c
> @@ -42,6 +42,7 @@
>  #include <asm/mmu_context.h>
>  #include <asm/pgtable.h>
>  #include <asm/pgalloc.h>
> +#include <asm/procinfo.h>
>  #include <asm/processor.h>
>  #include <asm/sections.h>
>  #include <asm/tlbflush.h>
> @@ -102,6 +103,30 @@ static unsigned long get_arch_pgd(pgd_t *pgd)
>  #endif
>  }
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
>  int __cpu_up(unsigned int cpu, struct task_struct *idle)
>  {
>  	int ret;
> @@ -109,6 +134,10 @@ int __cpu_up(unsigned int cpu, struct task_struct *idle)
>  	if (!smp_ops.smp_boot_secondary)
>  		return -ENOSYS;
>  
> +	ret = secondary_biglittle_prepare(cpu);
> +	if (ret)
> +		return ret;
> +
>  	/*
>  	 * We need to tell the secondary core where to find
>  	 * its stack and the page tables.
> @@ -360,6 +389,8 @@ asmlinkage void secondary_start_kernel(void)
>  	struct mm_struct *mm = &init_mm;
>  	unsigned int cpu;
>  
> +	secondary_biglittle_init();
> +
>  	/*
>  	 * The identity mapping is uncached (strongly ordered), so
>  	 * switch away from it before attempting any exclusive accesses.
> diff --git a/arch/arm/mm/proc-v7-bugs.c b/arch/arm/mm/proc-v7-bugs.c
> index 5544b82a2e7a..9a07916af8dd 100644
> --- a/arch/arm/mm/proc-v7-bugs.c
> +++ b/arch/arm/mm/proc-v7-bugs.c
> @@ -52,8 +52,6 @@ static void cpu_v7_spectre_init(void)
>  	case ARM_CPU_PART_CORTEX_A17:
>  	case ARM_CPU_PART_CORTEX_A73:
>  	case ARM_CPU_PART_CORTEX_A75:
> -		if (processor.switch_mm != cpu_v7_bpiall_switch_mm)
> -			goto bl_error;
>  		per_cpu(harden_branch_predictor_fn, cpu) =
>  			harden_branch_predictor_bpiall;
>  		spectre_v2_method = "BPIALL";
> @@ -61,8 +59,6 @@ static void cpu_v7_spectre_init(void)
>  
>  	case ARM_CPU_PART_CORTEX_A15:
>  	case ARM_CPU_PART_BRAHMA_B15:
> -		if (processor.switch_mm != cpu_v7_iciallu_switch_mm)
> -			goto bl_error;
>  		per_cpu(harden_branch_predictor_fn, cpu) =
>  			harden_branch_predictor_iciallu;
>  		spectre_v2_method = "ICIALLU";
> @@ -88,11 +84,9 @@ static void cpu_v7_spectre_init(void)
>  					  ARM_SMCCC_ARCH_WORKAROUND_1, &res);
>  			if ((int)res.a0 != 0)
>  				break;
> -			if (processor.switch_mm != cpu_v7_hvc_switch_mm && cpu)
> -				goto bl_error;
>  			per_cpu(harden_branch_predictor_fn, cpu) =
>  				call_hvc_arch_workaround_1;
> -			processor.switch_mm = cpu_v7_hvc_switch_mm;
> +			cpu_do_switch_mm = cpu_v7_hvc_switch_mm;
>  			spectre_v2_method = "hypervisor";
>  			break;
>  
> @@ -101,11 +95,9 @@ static void cpu_v7_spectre_init(void)
>  					  ARM_SMCCC_ARCH_WORKAROUND_1, &res);
>  			if ((int)res.a0 != 0)
>  				break;
> -			if (processor.switch_mm != cpu_v7_smc_switch_mm && cpu)
> -				goto bl_error;
>  			per_cpu(harden_branch_predictor_fn, cpu) =
>  				call_smc_arch_workaround_1;
> -			processor.switch_mm = cpu_v7_smc_switch_mm;
> +			cpu_do_switch_mm = cpu_v7_smc_switch_mm;
>  			spectre_v2_method = "firmware";
>  			break;
>  
> @@ -119,11 +111,6 @@ static void cpu_v7_spectre_init(void)
>  	if (spectre_v2_method)
>  		pr_info("CPU%u: Spectre v2: using %s workaround\n",
>  			smp_processor_id(), spectre_v2_method);
> -	return;
> -
> -bl_error:
> -	pr_err("CPU%u: Spectre v2: incorrect context switching function, system vulnerable\n",
> -		cpu);
>  }
>  #else
>  static void cpu_v7_spectre_init(void)

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
