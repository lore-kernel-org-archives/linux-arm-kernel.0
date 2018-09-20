From: julien.thierry@arm.com (Julien Thierry)
Date: Thu, 20 Sep 2018 10:07:39 +0100
Subject: [PATCH 4/5] ARM: add PROC_VTABLE macro
In-Reply-To: <E1g2Z6Z-0003el-5M@rmk-PC.armlinux.org.uk>
References: <20180919094802.GH30658@n2100.armlinux.org.uk>
 <E1g2Z6Z-0003el-5M@rmk-PC.armlinux.org.uk>
Message-ID: <cd30b9d1-169f-40db-8b07-71c0302a6de8@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On 19/09/18 10:49, Russell King wrote:
> Allow the way we access members of the processor vtable to be changed
> at compile time.  We will need to move to per-CPU vtables to fix the
> Spectre variant 2 issues on big.Little systems.
> 

Reviewed-by: Julien Thierry <julien.thierry@arm.com>

> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> ---
>   arch/arm/include/asm/proc-fns.h | 36 ++++++++++++++++++++++++------------
>   arch/arm/kernel/setup.c         |  4 +---
>   2 files changed, 25 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/arm/include/asm/proc-fns.h b/arch/arm/include/asm/proc-fns.h
> index 30c499146320..571a1346245b 100644
> --- a/arch/arm/include/asm/proc-fns.h
> +++ b/arch/arm/include/asm/proc-fns.h
> @@ -23,7 +23,7 @@ struct mm_struct;
>   /*
>    * Don't change this structure - ASM code relies on it.
>    */
> -extern struct processor {
> +struct processor {
>   	/* MISC
>   	 * get data abort address/flags
>   	 */
> @@ -79,9 +79,13 @@ extern struct processor {
>   	unsigned int suspend_size;
>   	void (*do_suspend)(void *);
>   	void (*do_resume)(void *);
> -} processor;
> +};
>   
>   #ifndef MULTI_CPU
> +static inline void init_proc_vtable(const struct processor *p)
> +{
> +}
> +
>   extern void cpu_proc_init(void);
>   extern void cpu_proc_fin(void);
>   extern int cpu_do_idle(void);
> @@ -98,18 +102,26 @@ extern void cpu_reset(unsigned long addr, bool hvc) __attribute__((noreturn));
>   extern void cpu_do_suspend(void *);
>   extern void cpu_do_resume(void *);
>   #else
> -#define cpu_proc_init			processor._proc_init
> -#define cpu_check_bugs			processor.check_bugs
> -#define cpu_proc_fin			processor._proc_fin
> -#define cpu_reset			processor.reset
> -#define cpu_do_idle			processor._do_idle
> -#define cpu_dcache_clean_area		processor.dcache_clean_area
> -#define cpu_set_pte_ext			processor.set_pte_ext
> -#define cpu_do_switch_mm		processor.switch_mm
> +
> +extern struct processor processor;
> +#define PROC_VTABLE(f)			processor.f
> +static inline void init_proc_vtable(const struct processor *p)
> +{
> +	processor = *p;
> +}
> +
> +#define cpu_proc_init			PROC_VTABLE(_proc_init)
> +#define cpu_check_bugs			PROC_VTABLE(check_bugs)
> +#define cpu_proc_fin			PROC_VTABLE(_proc_fin)
> +#define cpu_reset			PROC_VTABLE(reset)
> +#define cpu_do_idle			PROC_VTABLE(_do_idle)
> +#define cpu_dcache_clean_area		PROC_VTABLE(dcache_clean_area)
> +#define cpu_set_pte_ext			PROC_VTABLE(set_pte_ext)
> +#define cpu_do_switch_mm		PROC_VTABLE(switch_mm)
>   
>   /* These three are private to arch/arm/kernel/suspend.c */
> -#define cpu_do_suspend			processor.do_suspend
> -#define cpu_do_resume			processor.do_resume
> +#define cpu_do_suspend			PROC_VTABLE(do_suspend)
> +#define cpu_do_resume			PROC_VTABLE(do_resume)
>   #endif
>   
>   extern void cpu_resume(void);
> diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
> index 05a4eb6b0d01..c214bd14a1fe 100644
> --- a/arch/arm/kernel/setup.c
> +++ b/arch/arm/kernel/setup.c
> @@ -693,9 +693,7 @@ static void __init setup_processor(void)
>   	cpu_name = list->cpu_name;
>   	__cpu_architecture = __get_cpu_architecture();
>   
> -#ifdef MULTI_CPU
> -	processor = *list->proc;
> -#endif
> +	init_proc_vtable(list->proc);
>   #ifdef MULTI_TLB
>   	cpu_tlb = *list->tlb;
>   #endif
> 

-- 
Julien Thierry
