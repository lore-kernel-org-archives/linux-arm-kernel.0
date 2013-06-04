From: will.deacon@arm.com (Will Deacon)
Date: Tue, 4 Jun 2013 17:01:47 +0100
Subject: [PATCH v2] ARM: mm: lazy cache flushing on non-mapped pages
In-Reply-To: <1370270680-729-1-git-send-email-ming.lei@canonical.com>
References: <1370270680-729-1-git-send-email-ming.lei@canonical.com>
Message-ID: <20130604160147.GV27516@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 03, 2013 at 03:44:39PM +0100, Ming Lei wrote:
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

>  arch/arm/mm/flush.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mm/flush.c b/arch/arm/mm/flush.c
> index 0d473cc..2ff66eb 100644
> --- a/arch/arm/mm/flush.c
> +++ b/arch/arm/mm/flush.c
> @@ -287,7 +287,7 @@ void flush_dcache_page(struct page *page)
>  	mapping = page_mapping(page);
>  
>  	if (!cache_ops_need_broadcast() &&
> -	    mapping && !mapping_mapped(mapping))
> +	    mapping && !page_mapped(page))
>  		clear_bit(PG_dcache_clean, &page->flags);
>  	else {
>  		__flush_dcache_page(mapping, page);

Looks alright to me, but a decent stretch in -next wouldn't hurt:

  Reviewed-by: Will Deacon <will.deacon@arm.com>

Will
