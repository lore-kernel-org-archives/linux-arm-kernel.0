From: will.deacon@arm.com (Will Deacon)
Date: Thu, 1 Nov 2018 15:17:03 +0000
Subject: [PATCH v2] arm64/mm: unmap the linear alias of module allocations
In-Reply-To: <20180711170426.11133-1-ard.biesheuvel@linaro.org>
References: <20180711170426.11133-1-ard.biesheuvel@linaro.org>
Message-ID: <20181101151702.GF15788@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ard,

Remember writing this patch? ;)

On Wed, Jul 11, 2018 at 07:04:26PM +0200, Ard Biesheuvel wrote:
> When CONFIG_STRICT_KERNEL_RWX=y [which is the default on arm64], we
> take great care to ensure that the mappings of modules in the vmalloc
> space are locked down as much as possible, i.e., executable code is
> mapped read-only, read-only data is mapped read-only and non-executable,
> and read-write data is mapped non-executable as well.
> 
> However, due to the way we map the linear region [aka the kernel direct
> mapping], those module regions are aliased by read-write mappings, and
> it is possible for an attacker to modify code or data that was assumed
> to be immutable in this configuration.
> 
> So let's ensure that the linear alias of module memory is remapped
> read-only upon allocation and remapped read-write when it is freed. The
> latter requires some special handling involving a workqueue due to the
> fact that it may be called in softirq context at which time calling
> find_vm_area() is unsafe.
> 
> Note that this requires the entire linear region to be mapped down to
> pages, which may result in a performance regression in some hardware
> configurations.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
> Changes since RFC/v1:
> - remap linear alias read-only rather than invalid
> - honour rodata_enabled, i.e., 'rodata=off' will disable this functionality
> - use VMA nr_pages field rather than size to obtain the number of pages to
>   remap
> 
>  arch/arm64/include/asm/module.h |  6 +++
>  arch/arm64/kernel/module.c      | 42 ++++++++++++++++++++
>  arch/arm64/mm/mmu.c             |  2 +-
>  arch/arm64/mm/pageattr.c        | 19 +++++++++
>  4 files changed, 68 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/module.h b/arch/arm64/include/asm/module.h
> index 97d0ef12e2ff..f16f0073642b 100644
> --- a/arch/arm64/include/asm/module.h
> +++ b/arch/arm64/include/asm/module.h
> @@ -91,4 +91,10 @@ static inline bool plt_entries_equal(const struct plt_entry *a,
>  	       a->mov2 == b->mov2;
>  }
>  
> +#ifdef CONFIG_STRICT_KERNEL_RWX
> +void remap_linear_module_alias(void *module_region, bool ro);
> +#else
> +static inline void remap_linear_module_alias(void *module_region, bool ro) {}
> +#endif
> +
>  #endif /* __ASM_MODULE_H */
> diff --git a/arch/arm64/kernel/module.c b/arch/arm64/kernel/module.c
> index f0f27aeefb73..2b61ca0285eb 100644
> --- a/arch/arm64/kernel/module.c
> +++ b/arch/arm64/kernel/module.c
> @@ -26,10 +26,51 @@
>  #include <linux/mm.h>
>  #include <linux/moduleloader.h>
>  #include <linux/vmalloc.h>
> +#include <linux/workqueue.h>
>  #include <asm/alternative.h>
>  #include <asm/insn.h>
>  #include <asm/sections.h>
>  
> +#ifdef CONFIG_STRICT_KERNEL_RWX
> +
> +static struct workqueue_struct *module_free_wq;
> +
> +static int init_workqueue(void)
> +{
> +	module_free_wq = alloc_ordered_workqueue("module_free_wq", 0);
> +	WARN_ON(!module_free_wq);
> +
> +	return 0;
> +}
> +pure_initcall(init_workqueue);
> +
> +static void module_free_wq_worker(struct work_struct *work)
> +{
> +	remap_linear_module_alias(work, false);
> +	vfree(work);
> +}
> +
> +void module_memfree(void *module_region)
> +{
> +	struct work_struct *work;
> +
> +	if (!module_region)
> +		return;
> +
> +	/*
> +	 * At this point, module_region is a pointer to an allocation of at
> +	 * least PAGE_SIZE bytes that is mapped read-write. So instead of
> +	 * allocating memory for a data structure containing a work_struct
> +	 * instance and a copy of the value of module_region, just reuse the
> +	 * allocation directly.
> +	 */
> +	work = module_region;
> +	INIT_WORK(work, module_free_wq_worker);
> +	queue_work(module_free_wq, work);
> +}

Whilst I can see that this works, it's a bit grotty because we're
duplicating much of the hoop-jumping that vfree() also has to go through.
Given that we allocate the module memory in the arch code, could we grab
the pages at alloc time and stash them in the mod_arch_specific field?

> +#endif
> +
>  void *module_alloc(unsigned long size)
>  {
>  	gfp_t gfp_mask = GFP_KERNEL;
> @@ -65,6 +106,7 @@ void *module_alloc(unsigned long size)
>  		return NULL;
>  	}
>  
> +	remap_linear_module_alias(p, true);
>  	return p;
>  }
>  
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 493ff75670ff..5492b691aafd 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -432,7 +432,7 @@ static void __init map_mem(pgd_t *pgdp)
>  	struct memblock_region *reg;
>  	int flags = 0;
>  
> -	if (debug_pagealloc_enabled())
> +	if (rodata_enabled || debug_pagealloc_enabled())
>  		flags = NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;

I suppose this is the most contentious part of the patch. Perhaps a
better solution would be to tweak CONFIG_STRICT_MODULE_RWX so that it's
structured more like CONFIG_STACKPROTECTOR. That way, your patch here
could be the "strong" version, which comes with more of a performance
cost.

> diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
> index a56359373d8b..cc04be572660 100644
> --- a/arch/arm64/mm/pageattr.c
> +++ b/arch/arm64/mm/pageattr.c
> @@ -138,6 +138,25 @@ int set_memory_valid(unsigned long addr, int numpages, int enable)
>  					__pgprot(PTE_VALID));
>  }
>  
> +#ifdef CONFIG_STRICT_KERNEL_RWX

CONFIG_STRICT_MODULE_RWX instead?

> +void remap_linear_module_alias(void *module_region, bool ro)
> +{
> +	struct vm_struct *vm;
> +	int i;
> +
> +	if (!rodata_enabled)
> +		return;
> +
> +	vm = find_vm_area(module_region);
> +	WARN_ON(!vm || !vm->pages);
> +
> +	for (i = 0; i < vm->nr_pages; i++)
> +		__change_memory_common((u64)page_address(vm->pages[i]), PAGE_SIZE,
> +				ro ? __pgprot(PTE_RDONLY) : __pgprot(PTE_WRITE),
> +				ro ? __pgprot(PTE_WRITE) : __pgprot(PTE_RDONLY));
> +}
> +#endif

I think it would be cleaner just to have two wrapper functions for this:

  remap_linear_module_alias_ro
  remap_linear_module_alias_rw

so we can drop the bool parameter from the API and just pass the set/clear
attributes directly to something like __remap_linear_module_alias.

Will
