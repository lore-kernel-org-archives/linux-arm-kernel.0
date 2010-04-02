From: mel@csn.ul.ie (Mel Gorman)
Date: Fri, 2 Apr 2010 10:56:33 +0100
Subject: [PATCH 2/3] arm: Add config option for HOLES_IN_ZONE
In-Reply-To: <1270167649-17824-2-git-send-email-mbohan@codeaurora.org>
References: <1270167649-17824-1-git-send-email-mbohan@codeaurora.org>
	<1270167649-17824-2-git-send-email-mbohan@codeaurora.org>
Message-ID: <20100402095633.GB12886@csn.ul.ie>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 01, 2010 at 05:20:48PM -0700, Michael Bohan wrote:
> From: Michael Bohan <mbohan@quicinc.com>
> 
> This option is for FLATMEM configurations with multiple memory
> banks that have end addresses not aligned to MAX_ORDER_NR_PAGES.
> 
> To save memory, ARM frees memmap regions for pfns associated with
> gaps in the address map. When the VM code migrates pages, it will
> assume that the memmap entries are valid.
> 
> This option adds extra checking with pfn_valid() to
> ensure the memmap entries are valid. It may adversely impact
> performance.
> 

It will impact performance although not necessarily in a way that's easy to
detect because the biggest impact is on page-allocator-intensive-loads.

Have you managed to trigger this problem? I am assuming you are not
referring to page migration as such but more likely when pages shuffle
between lists in move_freepages(). To trigger a problem there, I think
you would have to have a memory layout that had an
max-order-unaligned-hole in the middle of a zone. Is that happening?

If so, another possibility you may want to consider (if you haven't
already) is to ensure in free_memmap() that if holes are being punched
in the middle of a zone that they are only max-order aligned. This would
avoid corruption problems without taking a performance hit.

> Change-Id: I48d8afb69db25b1f44d698f1a7da106911b4be1c
> Signed-off-by: Michael Bohan <mbohan@quicinc.com>
> Signed-off-by: Michael Bohan <mbohan@codeaurora.org>
> ---
>  arch/arm/Kconfig |   14 ++++++++++++++
>  1 files changed, 14 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index c5408bf..8dadce9 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1233,6 +1233,20 @@ config OABI_COMPAT
>  config ARCH_HAS_HOLES_MEMORYMODEL
>  	bool
>  
> +config HOLES_IN_ZONE
> +	bool "Memory map has holes ending within MAX_ORDER_NR_PAGES"
> +	default n
> +	depends on FLATMEM
> +	help
> +	  Say 'y' here if you have multiple memory banks where the bank
> +	  end addresses coresponding to the holes are not MAX_ORDER_NR_PAGES
> +	  aligned. Failure to enable this in those circumstances will result
> +	  in the VM code assuming ownership of pages with no memmap memory
> +	  allocated for them. This option could impact performance as it
> +	  performs extra checks in the VM code. As alternative, consider
> +	  aligning end addresses to MAX_ORDER_NR_PAGES or changing MAX_ORDER
> +	  to compensate for your alignment requirements.
> +
>  # Discontigmem is deprecated
>  config ARCH_DISCONTIGMEM_ENABLE
>  	bool
> -- 
> 1.6.2.3
> 

-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab
