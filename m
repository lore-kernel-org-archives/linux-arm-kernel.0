From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 13 May 2010 12:32:15 +0100
Subject: [RFC PATCH 1/3] ARM: Use lazy cache flushing on ARMv7 SMP systems
In-Reply-To: <20100513111555.21178.63776.stgit@e102109-lin.cambridge.arm.com>
References: <20100513110609.21178.39630.stgit@e102109-lin.cambridge.arm.com>
	<20100513111555.21178.63776.stgit@e102109-lin.cambridge.arm.com>
Message-ID: <20100513113215.GA13001@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 13, 2010 at 12:15:55PM +0100, Catalin Marinas wrote:
> diff --git a/arch/arm/mm/fault-armv.c b/arch/arm/mm/fault-armv.c
> index 0d414c2..a415dc0 100644
> --- a/arch/arm/mm/fault-armv.c
> +++ b/arch/arm/mm/fault-armv.c
> @@ -170,10 +170,8 @@ void update_mmu_cache(struct vm_area_struct *vma, unsigned long addr,
>  		return;
>  
>  	mapping = page_mapping(page);
> -#ifndef CONFIG_SMP
>  	if (test_and_clear_bit(PG_dcache_dirty, &page->flags))
>  		__flush_dcache_page(mapping, page);
> -#endif
>  	if (mapping) {
>  		if (cache_is_vivt())
>  			make_coherent(mapping, vma, addr, ptep, pfn);
> diff --git a/arch/arm/mm/flush.c b/arch/arm/mm/flush.c
> index c6844cb..5ad8711 100644
> --- a/arch/arm/mm/flush.c
> +++ b/arch/arm/mm/flush.c
> @@ -17,6 +17,7 @@
>  #include <asm/smp_plat.h>
>  #include <asm/system.h>
>  #include <asm/tlbflush.h>
> +#include <asm/smp_plat.h>
>  
>  #include "mm.h"
>  
> @@ -93,12 +94,10 @@ void flush_cache_page(struct vm_area_struct *vma, unsigned long user_addr, unsig
>  #define flush_pfn_alias(pfn,vaddr)	do { } while (0)
>  #endif
>  
> -#ifdef CONFIG_SMP
>  static void flush_ptrace_access_other(void *args)
>  {
>  	__flush_icache_all();
>  }
> -#endif
>  
>  static
>  void flush_ptrace_access(struct vm_area_struct *vma, struct page *page,
> @@ -122,11 +121,9 @@ void flush_ptrace_access(struct vm_area_struct *vma, struct page *page,
>  	if (vma->vm_flags & VM_EXEC) {
>  		unsigned long addr = (unsigned long)kaddr;
>  		__cpuc_coherent_kern_range(addr, addr + len);
> -#ifdef CONFIG_SMP
>  		if (cache_ops_need_broadcast())
>  			smp_call_function(flush_ptrace_access_other,
>  					  NULL, 1);
> -#endif

Err.  __cpuc_coherent_kern_range() makes the cache lines coherent between
the data and instruction threads.  So what you're doing is:

1. flush the D and I caches for the affected cache lines on the local
   processor
2. flush the entire I cache on the local processor

Why?

This has absolutely nothing to do with the rest of the patch.
