From: b32955@freescale.com (Huang Shijie)
Date: Mon, 17 Jun 2013 10:44:05 +0800
Subject: [PATCH 1/2] ARM: mmu: fix the hang when we steal a section
 unaligned size memory
In-Reply-To: <1371113826-1231-1-git-send-email-b32955@freescale.com>
References: <1371113826-1231-1-git-send-email-b32955@freescale.com>
Message-ID: <51BE77F5.1090103@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2013?06?13? 16:57, Huang Shijie ??:
> If we want to steal 128K memory in the machine_desc->reserve() hook, we
> will hang up immediately.
>
> The hang reason is like this:
>
>   [1] Stealing 128K makes the left memory is not aligned with the SECTION_SIZE.
>
>   [2] So when the map_lowmem() tries to maps the lowmem memory banks,
>       it will call the memblock_alloc(in early_alloc_aligned()) to allocate
>       a page to store the pte. This pte page is in the unaligned region
>       which is not mapped yet.
>
>   [3] And when we use the memset() in the early_alloc_aligned(), we will hang
>       right now.
>
>   [4] The hang only occurs in the map_lowmem(). After the map_lowmem(), we have
>       setup the PTE mappings. So in the later places, such as
>       dma_contiguous_remap(), the hang will never occurs,
>
> This patch adds a global variable, in_map_lowmem, to check if we are in
> the map_lowmem() or not. If we are in the map_lowmem(), and we steal
> a SECTION_SIZE unaligned memory, we will use the memblock_alloc_base()
> to allocate the pte page. The @max_addr for memblock_alloc_base() is the
> last mapped address.
>
> Signed-off-by: Huang Shijie <b32955@freescale.com>
> ---
>  arch/arm/mm/mmu.c |   34 ++++++++++++++++++++++++++++++----
>  1 files changed, 30 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
> index faa36d7..56d1a22 100644
> --- a/arch/arm/mm/mmu.c
> +++ b/arch/arm/mm/mmu.c
> @@ -113,6 +113,8 @@ static struct cachepolicy cache_policies[] __initdata = {
>  	}
>  };
>  
> +static bool in_map_lowmem __initdata;
> +
>  #ifdef CONFIG_CPU_CP15
>  /*
>   * These are useful for identifying cache coherency
> @@ -595,10 +597,32 @@ static void __init *early_alloc(unsigned long sz)
>  	return early_alloc_aligned(sz, sz);
>  }
>  
> -static pte_t * __init early_pte_alloc(pmd_t *pmd, unsigned long addr, unsigned long prot)
> +static void __init *early_alloc_max_addr(unsigned long sz, phys_addr_t maddr)
> +{
> +	void *ptr;
> +
> +	if (maddr == MEMBLOCK_ALLOC_ACCESSIBLE)
> +		return early_alloc_aligned(sz, sz);
> +
> +	ptr = __va(memblock_alloc_base(sz, sz, maddr));
> +	memset(ptr, 0, sz);
> +	return ptr;
> +}
> +
> +static pte_t * __init early_pte_alloc(pmd_t *pmd, unsigned long addr,
> +				unsigned long end, unsigned long prot)
>  {
>  	if (pmd_none(*pmd)) {
> -		pte_t *pte = early_alloc(PTE_HWTABLE_OFF + PTE_HWTABLE_SIZE);
> +		pte_t *pte;
> +		phys_addr_t maddr = MEMBLOCK_ALLOC_ACCESSIBLE;
> +
> +		if (in_map_lowmem && (end & SECTION_MASK)) {
> +			end &= PGDIR_MASK;
> +			BUG_ON(!end);
> +			maddr = __virt_to_phys(end);
> +		}
> +		pte = early_alloc_max_addr(PTE_HWTABLE_OFF + PTE_HWTABLE_SIZE,
> +					maddr);
>  		__pmd_populate(pmd, __pa(pte), prot);
>  	}
>  	BUG_ON(pmd_bad(*pmd));
> @@ -609,7 +633,7 @@ static void __init alloc_init_pte(pmd_t *pmd, unsigned long addr,
>  				  unsigned long end, unsigned long pfn,
>  				  const struct mem_type *type)
>  {
> -	pte_t *pte = early_pte_alloc(pmd, addr, type->prot_l1);
> +	pte_t *pte = early_pte_alloc(pmd, addr, end, type->prot_l1);
>  	do {
>  		set_pte_ext(pte, pfn_pte(pfn, __pgprot(type->prot_pte)), 0);
>  		pfn++;
> @@ -1253,7 +1277,7 @@ static void __init kmap_init(void)
>  {
>  #ifdef CONFIG_HIGHMEM
>  	pkmap_page_table = early_pte_alloc(pmd_off_k(PKMAP_BASE),
> -		PKMAP_BASE, _PAGE_KERNEL_TABLE);
> +		PKMAP_BASE, 0, _PAGE_KERNEL_TABLE);
>  #endif
>  }
>  
> @@ -1261,6 +1285,7 @@ static void __init map_lowmem(void)
>  {
>  	struct memblock_region *reg;
>  
> +	in_map_lowmem = 1;
>  	/* Map all the lowmem memory banks. */
>  	for_each_memblock(memory, reg) {
>  		phys_addr_t start = reg->base;
> @@ -1279,6 +1304,7 @@ static void __init map_lowmem(void)
>  
>  		create_mapping(&map);
>  	}
> +	in_map_lowmem = 0;
>  }
>  
>  /*
just a ping.
