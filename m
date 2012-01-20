From: nico@fluxnic.net (Nicolas Pitre)
Date: Fri, 20 Jan 2012 16:27:25 -0500 (EST)
Subject: [PATCH] ARM: earlier initialization of vectors page
In-Reply-To: <E1RoBIx-0005U9-Bs@rmk-PC.arm.linux.org.uk>
References: <E1RoBIx-0005U9-Bs@rmk-PC.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.02.1201201620580.19587@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 20 Jan 2012, Russell King - ARM Linux wrote:

> Initialize the contents of the vectors page immediately after we
> allocate the page, but before we map it.  This avoids any possible
> aliases with other mappings which may need to be flushed after the
> page has been mapped irrespective of the cache type.
> 
> We follow this later with a flush_cache_all() after all static memory
> mappings have been initialized, which ensures that this is safe from
> any cache effects.
> 
> Tested-by: Catalin Marinas <catalin.marinas@arm.com>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by: Nicolas Pitre <nico@linaro.org>

Having the data abort handlers available early will certainly help my 
patch to allow debugging across devicemaps_init().

> ---
>  arch/arm/include/asm/traps.h |    2 +-
>  arch/arm/kernel/setup.c      |    1 -
>  arch/arm/kernel/traps.c      |   10 ++++------
>  arch/arm/mm/mmu.c            |    7 +++++--
>  4 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm/include/asm/traps.h b/arch/arm/include/asm/traps.h
> index 5b29a66..f555bb3 100644
> --- a/arch/arm/include/asm/traps.h
> +++ b/arch/arm/include/asm/traps.h
> @@ -46,7 +46,7 @@ static inline int in_exception_text(unsigned long ptr)
>  	return in ? : __in_irqentry_text(ptr);
>  }
>  
> -extern void __init early_trap_init(void);
> +extern void __init early_trap_init(void *);
>  extern void dump_backtrace_entry(unsigned long where, unsigned long from, unsigned long frame);
>  extern void ptrace_break(struct task_struct *tsk, struct pt_regs *regs);
>  
> diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
> index 129fbd5..9b65cb4 100644
> --- a/arch/arm/kernel/setup.c
> +++ b/arch/arm/kernel/setup.c
> @@ -961,7 +961,6 @@ void __init setup_arch(char **cmdline_p)
>  	conswitchp = &dummy_con;
>  #endif
>  #endif
> -	early_trap_init();
>  
>  	if (mdesc->init_early)
>  		mdesc->init_early();
> diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
> index 99a5727..be15daf 100644
> --- a/arch/arm/kernel/traps.c
> +++ b/arch/arm/kernel/traps.c
> @@ -781,18 +781,16 @@ static void __init kuser_get_tls_init(unsigned long vectors)
>  		memcpy((void *)vectors + 0xfe0, (void *)vectors + 0xfe8, 4);
>  }
>  
> -void __init early_trap_init(void)
> +void __init early_trap_init(void *vectors_base)
>  {
> -#if defined(CONFIG_CPU_USE_DOMAINS)
> -	unsigned long vectors = CONFIG_VECTORS_BASE;
> -#else
> -	unsigned long vectors = (unsigned long)vectors_page;
> -#endif
> +	unsigned long vectors = (unsigned long)vectors_base;
>  	extern char __stubs_start[], __stubs_end[];
>  	extern char __vectors_start[], __vectors_end[];
>  	extern char __kuser_helper_start[], __kuser_helper_end[];
>  	int kuser_sz = __kuser_helper_end - __kuser_helper_start;
>  
> +	vectors_page = vectors_base;
> +
>  	/*
>  	 * Copy the vectors, stubs and kuser helpers (in entry-armv.S)
>  	 * into the vector page, mapped at 0xffff0000, and ensure these
> diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
> index 94c5a0c..c1263ad 100644
> --- a/arch/arm/mm/mmu.c
> +++ b/arch/arm/mm/mmu.c
> @@ -997,11 +997,14 @@ static void __init devicemaps_init(struct machine_desc *mdesc)
>  {
>  	struct map_desc map;
>  	unsigned long addr;
> +	void *vectors;
>  
>  	/*
>  	 * Allocate the vector page early.
>  	 */
> -	vectors_page = early_alloc(PAGE_SIZE);
> +	vectors = early_alloc(PAGE_SIZE);
> +
> +	early_trap_init(vectors);
>  
>  	for (addr = VMALLOC_START; addr; addr += PMD_SIZE)
>  		pmd_clear(pmd_off_k(addr));
> @@ -1041,7 +1044,7 @@ static void __init devicemaps_init(struct machine_desc *mdesc)
>  	 * location (0xffff0000).  If we aren't using high-vectors, also
>  	 * create a mapping at the low-vectors virtual address.
>  	 */
> -	map.pfn = __phys_to_pfn(virt_to_phys(vectors_page));
> +	map.pfn = __phys_to_pfn(virt_to_phys(vectors));
>  	map.virtual = 0xffff0000;
>  	map.length = PAGE_SIZE;
>  	map.type = MT_HIGH_VECTORS;
> -- 
> 1.7.4.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
