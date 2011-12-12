From: mel@csn.ul.ie (Mel Gorman)
Date: Mon, 12 Dec 2011 14:19:53 +0000
Subject: [PATCH 03/11] mm: mmzone: introduce zone_pfn_same_memmap()
In-Reply-To: <1321634598-16859-4-git-send-email-m.szyprowski@samsung.com>
References: <1321634598-16859-1-git-send-email-m.szyprowski@samsung.com>
 <1321634598-16859-4-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20111212141953.GD3277@csn.ul.ie>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 18, 2011 at 05:43:10PM +0100, Marek Szyprowski wrote:
> From: Michal Nazarewicz <mina86@mina86.com>
> 
> This commit introduces zone_pfn_same_memmap() function which checkes

s/checkes/checks/

> whether two PFNs within the same zone have struct pages within the
> same memmap. 

s/memmap/same sparsemem section/

> This check is needed because in general pointer
> arithmetic on struct pages may lead to invalid pointers.
> 
> On memory models that are not affected, zone_pfn_same_memmap() is
> defined as always returning true so the call should be optimised
> at compile time.
> 
> Signed-off-by: Michal Nazarewicz <mina86@mina86.com>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  include/linux/mmzone.h |   16 ++++++++++++++++
>  mm/compaction.c        |    5 ++++-
>  2 files changed, 20 insertions(+), 1 deletions(-)
> 
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 188cb2f..84e07d0 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -1166,6 +1166,22 @@ static inline int memmap_valid_within(unsigned long pfn,
>  }
>  #endif /* CONFIG_ARCH_HAS_HOLES_MEMORYMODEL */
>  
> +#if defined(CONFIG_SPARSEMEM) && !defined(CONFIG_SPARSEMEM_VMEMMAP)
> +/*
> + * Both PFNs must be from the same zone!  If this function returns

from the same sparsemem section, not the same zone. 

> + * true, pfn_to_page(pfn1) + (pfn2 - pfn1) == pfn_to_page(pfn2).
> + */
> +static inline bool zone_pfn_same_memmap(unsigned long pfn1, unsigned long pfn2)
> +{
> +	return pfn_to_section_nr(pfn1) == pfn_to_section_nr(pfn2);
> +}
> +
> +#else
> +
> +#define zone_pfn_same_memmap(pfn1, pfn2) (true)
> +
> +#endif
> +
>  #endif /* !__GENERATING_BOUNDS.H */
>  #endif /* !__ASSEMBLY__ */
>  #endif /* _LINUX_MMZONE_H */
> diff --git a/mm/compaction.c b/mm/compaction.c
> index 6afae0e..09c9702 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -111,7 +111,10 @@ skip:
>  
>  next:
>  		pfn += isolated;
> -		page += isolated;
> +		if (zone_pfn_same_memmap(pfn - isolated, pfn))
> +			page += isolated;
> +		else
> +			page = pfn_to_page(pfn);
>  	}

Is this necessary?

We are isolating pages, the largest of which is a MAX_ORDER_NR_PAGES
page. Sections are never smaller than MAX_ORDER_NR_PAGES so the end
of the free range of pages should never be in another section. That
should mean that the PFN walk will always consider the first
PFN of every section and you can implement a simplier check than
zone_pfn_same_memmap based on pfn & PAGE_SECTION_MASK and contain it
within mm/compaction.c

That said, everywhere else managed to avoid checks like this by always
scanning in units of pageblocks. Maybe this should be structured
the same way to guarantee pfn_valid is called at least per pageblock
(even though only once per MAX_ORDER_NR_PAGES is necessary).

-- 
Mel Gorman
SUSE Labs
