From: will.deacon@arm.com (Will Deacon)
Date: Thu, 30 May 2013 16:40:47 +0100
Subject: [PATCH V1] ARM: mm: lazy cache flushing on non-mapped pages
In-Reply-To: <1369839416-27817-1-git-send-email-ming.lei@canonical.com>
References: <1369839416-27817-1-git-send-email-ming.lei@canonical.com>
Message-ID: <20130530154047.GW7483@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 29, 2013 at 03:56:56PM +0100, Ming Lei wrote:
> Currently flush_dcache_page() thinks pages as non-mapped if
> mapping_mapped(mapping) return false. This approach is very
> coase:
> 	- mmap on part of file may cause all pages backed on
> 	the file being thought as mmaped
> 
> 	- file-backed pages aren't mapped into user space actually
> 	if the memory mmaped on the file isn't accessed
> 
> This patch uses page_mapped() to decide if the page has been
> mapped.

[...]

> diff --git a/arch/arm/mm/flush.c b/arch/arm/mm/flush.c
> index 0d473cc..008af99 100644
> --- a/arch/arm/mm/flush.c
> +++ b/arch/arm/mm/flush.c
> @@ -286,8 +286,8 @@ void flush_dcache_page(struct page *page)
>  
>  	mapping = page_mapping(page);
>  
> -	if (!cache_ops_need_broadcast() &&
> -	    mapping && !mapping_mapped(mapping))
> +	if (!cache_ops_need_broadcast() && mapping &&
> +		(!mapping_mapped(mapping) || !page_mapped(page)))
>  		clear_bit(PG_dcache_clean, &page->flags);
>  	else {
>  		__flush_dcache_page(mapping, page);

Does the page_mapped test make the mapping_mapped test redundant? It sounds
strange if it's possible to get a non-zero mapcount for a page when its
address space isn't mapped.

Will
