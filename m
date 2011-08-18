From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 18 Aug 2011 09:02:26 -0400 (EDT)
Subject: [PATCH 01/12] ARM: Add init_consistent_dma_size()
In-Reply-To: <1312813712-22808-2-git-send-email-tixy@yxit.co.uk>
References: <1312813712-22808-1-git-send-email-tixy@yxit.co.uk>
	<1312813712-22808-2-git-send-email-tixy@yxit.co.uk>
Message-ID: <alpine.LFD.2.00.1108180857540.20358@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 8 Aug 2011, Jon Medhurst wrote:

> This function can be called during boot to increase the size of the consistent
> DMA region above it's default value of 2MB. It must be called before the memory
> allocator is initialised, i.e. before any core_initcall.
> 
> Signed-off-by: Jon Medhurst <tixy@yxit.co.uk>

I'd add a comment above the declaration for init_consistent_dma_size() 
repeating the above commit message so it is clearer what this call does 
without having to look up the git history log.  Otherwise you can add:

Acked-by: Nicolas Pitre <nicolas.pitre@linaro.org>

> ---
>  arch/arm/include/asm/dma-mapping.h |    3 ++
>  arch/arm/include/asm/memory.h      |    9 ------
>  arch/arm/mm/dma-mapping.c          |   49 +++++++++++++++++++++++++++--------
>  arch/arm/mm/init.c                 |    9 ------
>  4 files changed, 41 insertions(+), 29 deletions(-)
> 
> diff --git a/arch/arm/include/asm/dma-mapping.h b/arch/arm/include/asm/dma-mapping.h
> index 7a21d0b..328416b 100644
> --- a/arch/arm/include/asm/dma-mapping.h
> +++ b/arch/arm/include/asm/dma-mapping.h
> @@ -206,6 +206,9 @@ int dma_mmap_writecombine(struct device *, struct vm_area_struct *,
>  		void *, dma_addr_t, size_t);
>  
>  
> +extern void __init init_consistent_dma_size(unsigned long size);
> +
> +
>  #ifdef CONFIG_DMABOUNCE
>  /*
>   * For SA-1111, IXP425, and ADI systems  the dma-mapping functions are "magic"
> diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
> index b8de516..652fccc 100644
> --- a/arch/arm/include/asm/memory.h
> +++ b/arch/arm/include/asm/memory.h
> @@ -77,16 +77,7 @@
>   */
>  #define IOREMAP_MAX_ORDER	24
>  
> -/*
> - * Size of DMA-consistent memory region.  Must be multiple of 2M,
> - * between 2MB and 14MB inclusive.
> - */
> -#ifndef CONSISTENT_DMA_SIZE
> -#define CONSISTENT_DMA_SIZE 	SZ_2M
> -#endif
> -
>  #define CONSISTENT_END		(0xffe00000UL)
> -#define CONSISTENT_BASE		(CONSISTENT_END - CONSISTENT_DMA_SIZE)
>  
>  #else /* CONFIG_MMU */
>  
> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> index 0a0a1e7..5b59ce5 100644
> --- a/arch/arm/mm/dma-mapping.c
> +++ b/arch/arm/mm/dma-mapping.c
> @@ -18,12 +18,14 @@
>  #include <linux/device.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/highmem.h>
> +#include <linux/slab.h>
>  
>  #include <asm/memory.h>
>  #include <asm/highmem.h>
>  #include <asm/cacheflush.h>
>  #include <asm/tlbflush.h>
>  #include <asm/sizes.h>
> +#include <asm/mach/arch.h>
>  
>  #include "mm.h"
>  
> @@ -117,26 +119,41 @@ static void __dma_free_buffer(struct page *page, size_t size)
>  }
>  
>  #ifdef CONFIG_MMU
> -/* Sanity check size */
> -#if (CONSISTENT_DMA_SIZE % SZ_2M)
> -#error "CONSISTENT_DMA_SIZE must be multiple of 2MiB"
> -#endif
>  
> -#define CONSISTENT_OFFSET(x)	(((unsigned long)(x) - CONSISTENT_BASE) >> PAGE_SHIFT)
> -#define CONSISTENT_PTE_INDEX(x) (((unsigned long)(x) - CONSISTENT_BASE) >> PGDIR_SHIFT)
> -#define NUM_CONSISTENT_PTES (CONSISTENT_DMA_SIZE >> PGDIR_SHIFT)
> +
> +#define CONSISTENT_OFFSET(x)	(((unsigned long)(x) - consistent_base) >> PAGE_SHIFT)
> +#define CONSISTENT_PTE_INDEX(x) (((unsigned long)(x) - consistent_base) >> PGDIR_SHIFT)
>  
>  /*
>   * These are the page tables (2MB each) covering uncached, DMA consistent allocations
>   */
> -static pte_t *consistent_pte[NUM_CONSISTENT_PTES];
> +static pte_t **consistent_pte;
> +
> +#ifdef CONSISTENT_DMA_SIZE
> +#define DEFAULT_CONSISTENT_DMA_SIZE CONSISTENT_DMA_SIZE
> +#else
> +#define DEFAULT_CONSISTENT_DMA_SIZE SZ_2M
> +#endif
> +
> +unsigned long consistent_base = CONSISTENT_END - DEFAULT_CONSISTENT_DMA_SIZE;
> +
> +void __init init_consistent_dma_size(unsigned long size)
> +{
> +	unsigned long base = CONSISTENT_END - ALIGN(size, SZ_2M);
> +
> +	BUG_ON(consistent_pte); /* Check we're called before DMA region init */
> +	BUG_ON(base < VMALLOC_END);
> +
> +	/* Grow region to accommodate specified size  */
> +	if (base < consistent_base)
> +		consistent_base = base;
> +}
>  
>  #include "vmregion.h"
>  
>  static struct arm_vmregion_head consistent_head = {
>  	.vm_lock	= __SPIN_LOCK_UNLOCKED(&consistent_head.vm_lock),
>  	.vm_list	= LIST_HEAD_INIT(consistent_head.vm_list),
> -	.vm_start	= CONSISTENT_BASE,
>  	.vm_end		= CONSISTENT_END,
>  };
>  
> @@ -155,7 +172,17 @@ static int __init consistent_init(void)
>  	pmd_t *pmd;
>  	pte_t *pte;
>  	int i = 0;
> -	u32 base = CONSISTENT_BASE;
> +	unsigned long base = consistent_base;
> +	unsigned long num_ptes = (CONSISTENT_END - base) >> PGDIR_SHIFT;
> +
> +	consistent_pte = kmalloc(num_ptes * sizeof(pte_t), GFP_KERNEL);
> +	if (!consistent_pte) {
> +		pr_err("%s: no memory\n", __func__);
> +		return -ENOMEM;
> +	}
> +
> +	pr_debug("DMA memory: 0x%08lx - 0x%08lx:\n", base, CONSISTENT_END);
> +	consistent_head.vm_start = base;
>  
>  	do {
>  		pgd = pgd_offset(&init_mm, base);
> @@ -198,7 +225,7 @@ __dma_alloc_remap(struct page *page, size_t size, gfp_t gfp, pgprot_t prot)
>  	size_t align;
>  	int bit;
>  
> -	if (!consistent_pte[0]) {
> +	if (!consistent_pte) {
>  		printk(KERN_ERR "%s: not initialised\n", __func__);
>  		dump_stack();
>  		return NULL;
> diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
> index 2fee782..2a7c173 100644
> --- a/arch/arm/mm/init.c
> +++ b/arch/arm/mm/init.c
> @@ -653,9 +653,6 @@ void __init mem_init(void)
>  			"    ITCM    : 0x%08lx - 0x%08lx   (%4ld kB)\n"
>  #endif
>  			"    fixmap  : 0x%08lx - 0x%08lx   (%4ld kB)\n"
> -#ifdef CONFIG_MMU
> -			"    DMA     : 0x%08lx - 0x%08lx   (%4ld MB)\n"
> -#endif
>  			"    vmalloc : 0x%08lx - 0x%08lx   (%4ld MB)\n"
>  			"    lowmem  : 0x%08lx - 0x%08lx   (%4ld MB)\n"
>  #ifdef CONFIG_HIGHMEM
> @@ -674,9 +671,6 @@ void __init mem_init(void)
>  			MLK(ITCM_OFFSET, (unsigned long) itcm_end),
>  #endif
>  			MLK(FIXADDR_START, FIXADDR_TOP),
> -#ifdef CONFIG_MMU
> -			MLM(CONSISTENT_BASE, CONSISTENT_END),
> -#endif
>  			MLM(VMALLOC_START, VMALLOC_END),
>  			MLM(PAGE_OFFSET, (unsigned long)high_memory),
>  #ifdef CONFIG_HIGHMEM
> @@ -699,9 +693,6 @@ void __init mem_init(void)
>  	 * be detected at build time already.
>  	 */
>  #ifdef CONFIG_MMU
> -	BUILD_BUG_ON(VMALLOC_END			> CONSISTENT_BASE);
> -	BUG_ON(VMALLOC_END				> CONSISTENT_BASE);
> -
>  	BUILD_BUG_ON(TASK_SIZE				> MODULES_VADDR);
>  	BUG_ON(TASK_SIZE 				> MODULES_VADDR);
>  #endif
> -- 
> 1.7.2.5
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
