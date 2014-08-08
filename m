From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 8 Aug 2014 11:54:34 -0400 (EDT)
Subject: [PATCH] ARM: expand fixmap region to 3MB
In-Reply-To: <1407511404-11997-1-git-send-email-robherring2@gmail.com>
References: <1407511404-11997-1-git-send-email-robherring2@gmail.com>
Message-ID: <alpine.LFD.2.11.1408081153470.6061@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 8 Aug 2014, Rob Herring wrote:

> From: Rob Herring <robh@kernel.org>
> 
> With commit a05e54c103b0b8 "ARM: 8031/2: change fixmap mapping region to
> support 32 CPUs", the fixmap region was expanded to 2MB, but it
> precluded any other uses of the fixmap region in order to support up to
> 32 CPUs. In order to support other uses the fixmap region needs to be
> expanded beyond 2MB. Fortunately, the adjacent 1MB range
> 0xffe00000-0xfff00000 is availabe to use.
> 
> Remove fixmap_page_table ptr and lookup the page table via the virtual
> address so that the fixmap region can span more that one pmd. The 2nd
> pmd is already created since it is shared with the vector page.
> 
> Cc: Leif Lindholm <leif.lindholm@linaro.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Russell King <linux@arm.linux.org.uk>
> Signed-off-by: Rob Herring <robh@kernel.org>

Acked-by: Nicolas Pitre <nico@linaro.org>


> ---
> 
> This patch can come before or after the generic fixmap.h. There's a 
> single line conflict with the ending address 
> 
> This worked for earlycon, but I've not done any highmem specific 
> testing. My full series is available here:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git fixmap
> 
> Rob
> 
>  Documentation/arm/memory.txt  |  2 +-
>  arch/arm/include/asm/fixmap.h |  2 +-
>  arch/arm/mm/highmem.c         | 15 ++++++++-------
>  arch/arm/mm/mmu.c             |  2 +-
>  4 files changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/arm/memory.txt b/Documentation/arm/memory.txt
> index 38dc06d..4178ebd 100644
> --- a/Documentation/arm/memory.txt
> +++ b/Documentation/arm/memory.txt
> @@ -41,7 +41,7 @@ fffe8000	fffeffff	DTCM mapping area for platforms with
>  fffe0000	fffe7fff	ITCM mapping area for platforms with
>  				ITCM mounted inside the CPU.
>  
> -ffc00000	ffdfffff	Fixmap mapping region.  Addresses provided
> +ffc00000	ffefffff	Fixmap mapping region.  Addresses provided
>  				by fix_to_virt() will be located here.
>  
>  fee00000	feffffff	Mapping of PCI I/O space. This is a static
> diff --git a/arch/arm/include/asm/fixmap.h b/arch/arm/include/asm/fixmap.h
> index 74124b0..cb50cee 100644
> --- a/arch/arm/include/asm/fixmap.h
> +++ b/arch/arm/include/asm/fixmap.h
> @@ -2,7 +2,7 @@
>  #define _ASM_FIXMAP_H
>  
>  #define FIXADDR_START		0xffc00000UL
> -#define FIXADDR_TOP		0xffe00000UL
> +#define FIXADDR_TOP		0xfff00000UL
>  #define FIXADDR_SIZE		(FIXADDR_TOP - FIXADDR_START)
>  
>  #define FIX_KMAP_NR_PTES	(FIXADDR_SIZE >> PAGE_SHIFT)
> diff --git a/arch/arm/mm/highmem.c b/arch/arm/mm/highmem.c
> index 45aeaac..ac2938f 100644
> --- a/arch/arm/mm/highmem.c
> +++ b/arch/arm/mm/highmem.c
> @@ -18,19 +18,20 @@
>  #include <asm/tlbflush.h>
>  #include "mm.h"
>  
> -pte_t *fixmap_page_table;
> -
>  static inline void set_fixmap_pte(int idx, pte_t pte)
>  {
>  	unsigned long vaddr = __fix_to_virt(idx);
> -	set_pte_ext(fixmap_page_table + idx, pte, 0);
> +	pte_t *ptep = pte_offset_kernel(pmd_off_k(vaddr), vaddr);
> +
> +	set_pte_ext(ptep, pte, 0);
>  	local_flush_tlb_kernel_page(vaddr);
>  }
>  
>  static inline pte_t get_fixmap_pte(unsigned long vaddr)
>  {
> -	unsigned long idx = __virt_to_fix(vaddr);
> -	return *(fixmap_page_table + idx);
> +	pte_t *ptep = pte_offset_kernel(pmd_off_k(vaddr), vaddr);
> +
> +	return *ptep;
>  }
>  
>  void *kmap(struct page *page)
> @@ -84,7 +85,7 @@ void *kmap_atomic(struct page *page)
>  	 * With debugging enabled, kunmap_atomic forces that entry to 0.
>  	 * Make sure it was indeed properly unmapped.
>  	 */
> -	BUG_ON(!pte_none(*(fixmap_page_table + idx)));
> +	BUG_ON(!pte_none(*get_fixmap_pte(vaddr)));
>  #endif
>  	/*
>  	 * When debugging is off, kunmap_atomic leaves the previous mapping
> @@ -134,7 +135,7 @@ void *kmap_atomic_pfn(unsigned long pfn)
>  	idx = type + KM_TYPE_NR * smp_processor_id();
>  	vaddr = __fix_to_virt(idx);
>  #ifdef CONFIG_DEBUG_HIGHMEM
> -	BUG_ON(!pte_none(*(fixmap_page_table + idx)));
> +	BUG_ON(!pte_none(*get_fixmap_pte(vaddr)));
>  #endif
>  	set_fixmap_pte(idx, pfn_pte(pfn, kmap_prot));
>  
> diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
> index 8348ed6..5e5d0ba 100644
> --- a/arch/arm/mm/mmu.c
> +++ b/arch/arm/mm/mmu.c
> @@ -1327,7 +1327,7 @@ static void __init kmap_init(void)
>  	pkmap_page_table = early_pte_alloc(pmd_off_k(PKMAP_BASE),
>  		PKMAP_BASE, _PAGE_KERNEL_TABLE);
>  
> -	fixmap_page_table = early_pte_alloc(pmd_off_k(FIXADDR_START),
> +	early_pte_alloc(pmd_off_k(FIXADDR_START),
>  		FIXADDR_START, _PAGE_KERNEL_TABLE);
>  #endif
>  }
> -- 
> 1.9.1
> 
> 
