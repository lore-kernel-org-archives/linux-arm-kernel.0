From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 7 Mar 2013 13:26:23 +0000
Subject: [PATCH] ARM: mm: clean-up in order to reduce to call
 kmap_high_get()
In-Reply-To: <1362372609-877-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1362372609-877-1-git-send-email-iamjoonsoo.kim@lge.com>
Message-ID: <20130307132623.GG17833@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 04, 2013 at 01:50:09PM +0900, Joonsoo Kim wrote:
> In kmap_atomic(), kmap_high_get() is invoked for checking already
> mapped area. In __flush_dcache_page() and dma_cache_maint_page(),
> we explicitly call kmap_high_get() before kmap_atomic()
> when cache_is_vipt(), so kmap_high_get() can be invoked twice.
> This is useless operation, so remove one.
> 
> Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> 
> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> index c7e3759..b7711be 100644
> --- a/arch/arm/mm/dma-mapping.c
> +++ b/arch/arm/mm/dma-mapping.c
> @@ -822,16 +822,16 @@ static void dma_cache_maint_page(struct page *page, unsigned long offset,
>  		if (PageHighMem(page)) {
>  			if (len + offset > PAGE_SIZE)
>  				len = PAGE_SIZE - offset;
> -			vaddr = kmap_high_get(page);
> -			if (vaddr) {
> -				vaddr += offset;
> -				op(vaddr, len, dir);
> -				kunmap_high(page);
> -			} else if (cache_is_vipt()) {
> -				/* unmapped pages might still be cached */
> +			if (cache_is_vipt()) {

This should be:
			if (cache_is_vipt_nonaliasing())

to make it _explicit_ that this technique is only for non-aliasing VIPT
caches (this doesn't work on any other of our cache types.)  Yes, I
know we don't support highmem with VIPT aliasing caches - but still,
we should ensure that this is self-documented in this code.

Same for arch/arm/mm/flush.c
