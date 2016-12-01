From: will.deacon@arm.com (Will Deacon)
Date: Thu, 1 Dec 2016 16:45:39 +0000
Subject: [PATCH v2] arm64: mm: Fix memmap to be initialized for the
 entire section
In-Reply-To: <1480530091-1092-1-git-send-email-rrichter@cavium.com>
References: <1480530091-1092-1-git-send-email-rrichter@cavium.com>
Message-ID: <20161201164538.GB1236@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 30, 2016 at 07:21:31PM +0100, Robert Richter wrote:
> On ThunderX systems with certain memory configurations we see the
> following BUG_ON():
> 
>  kernel BUG at mm/page_alloc.c:1848!
> 
> This happens for some configs with 64k page size enabled. The BUG_ON()
> checks if start and end page of a memmap range belongs to the same
> zone.
> 
> The BUG_ON() check fails if a memory zone contains NOMAP regions. In
> this case the node information of those pages is not initialized. This
> causes an inconsistency of the page links with wrong zone and node
> information for that pages. NOMAP pages from node 1 still point to the
> mem zone from node 0 and have the wrong nid assigned.
> 
> The reason for the mis-configuration is a change in pfn_valid() which
> reports pages marked NOMAP as invalid:
> 
>  68709f45385a arm64: only consider memblocks with NOMAP cleared for linear mapping
> 
> This causes pages marked as nomap being no long reassigned to the new
> zone in memmap_init_zone() by calling __init_single_pfn().
> 
> Fixing this by restoring the old behavior of pfn_valid() to use
> memblock_is_memory(). Also changing users of pfn_valid() in arm64 code
> to use memblock_is_map_memory() where necessary. This only affects
> code in ioremap.c. The code in mmu.c still can use the new version of
> pfn_valid().
> 
> As a consequence, pfn_valid() can not be used to check if a physical
> page is RAM. It just checks if there is an underlying memmap with a
> valid struct page. Moreover, for performance reasons the whole memmap
> (with pageblock_nr_pages number of pages) has valid pfns (SPARSEMEM
> config). The memory range is extended to fit the alignment of the
> memmap. Thus, pfn_valid() may return true for pfns that do not map to
> physical memory. Those pages are simply not reported to the mm, they
> are not marked reserved nor added to the list of free pages. Other
> functions such a page_is_ram() or memblock_is_map_ memory() must be
> used to check for memory and if the page can be mapped with the linear
> mapping.
> 
> Since NOMAP mem ranges may need to be mapped with different mem
> attributes (e.g. read-only or non-caching) we can not use linear
> mapping here. The use of memblock_is_memory() in pfn_valid() may not
> break this behaviour. Since commit:
> 
>  e7cd190385d1 arm64: mark reserved memblock regions explicitly in iomem
> 
> NOMAP mem resources are no longer marked as system RAM (IORESOURCE_
> SYSTEM_RAM). Now page_is_ram() and region_intersects() (see
> memremap()) do not detect NOMAP mem as system ram and NOMAP mem is not
> added to the linear mapping as system RAM is.
> 
> v2:
> 
>  * Added Ack
>  * updated description to reflect the discussion
> 
> Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Signed-off-by: Robert Richter <rrichter@cavium.com>
> ---
>  arch/arm64/mm/init.c    | 2 +-
>  arch/arm64/mm/ioremap.c | 5 +++--
>  2 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 212c4d1e2f26..166911f4a2e6 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -147,7 +147,7 @@ static void __init zone_sizes_init(unsigned long min, unsigned long max)
>  #ifdef CONFIG_HAVE_ARCH_PFN_VALID
>  int pfn_valid(unsigned long pfn)
>  {
> -	return memblock_is_map_memory(pfn << PAGE_SHIFT);
> +	return memblock_is_memory(pfn << PAGE_SHIFT);
>  }
>  EXPORT_SYMBOL(pfn_valid);
>  #endif
> diff --git a/arch/arm64/mm/ioremap.c b/arch/arm64/mm/ioremap.c
> index 01e88c8bcab0..c17c220b0c48 100644
> --- a/arch/arm64/mm/ioremap.c
> +++ b/arch/arm64/mm/ioremap.c
> @@ -21,6 +21,7 @@
>   */
>  
>  #include <linux/export.h>
> +#include <linux/memblock.h>
>  #include <linux/mm.h>
>  #include <linux/vmalloc.h>
>  #include <linux/io.h>
> @@ -55,7 +56,7 @@ static void __iomem *__ioremap_caller(phys_addr_t phys_addr, size_t size,
>  	/*
>  	 * Don't allow RAM to be mapped.
>  	 */
> -	if (WARN_ON(pfn_valid(__phys_to_pfn(phys_addr))))
> +	if (WARN_ON(memblock_is_map_memory(phys_addr)))
>  		return NULL;
>  
>  	area = get_vm_area_caller(size, VM_IOREMAP, caller);
> @@ -96,7 +97,7 @@ EXPORT_SYMBOL(__iounmap);
>  void __iomem *ioremap_cache(phys_addr_t phys_addr, size_t size)
>  {
>  	/* For normal memory we already have a cacheable mapping. */
> -	if (pfn_valid(__phys_to_pfn(phys_addr)))
> +	if (memblock_is_map_memory(phys_addr))
>  		return (void __iomem *)__phys_to_virt(phys_addr);

Thanks for sending out the new patch. Whilst I'm still a bit worried about
changing pfn_valid like this, I guess we'll just have to fix up any callers
which suffer from this change.

Acked-by: Will Deacon <will.deacon@arm.com>

I'd like to see this sit in -next for a bit before we send it further.

Will
