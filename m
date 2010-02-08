From: GKing@nvidia.com (Gary King)
Date: Mon, 8 Feb 2010 13:57:22 -0800
Subject: race between kmap shootdown and cache maintenance
In-Reply-To: <20100207153045.GA30457@n2100.arm.linux.org.uk>
References: <A0A1E7539300DF49AA383E614C7827BC048DB1096B@HQMAIL01.nvidia.com>
	<20100207153045.GA30457@n2100.arm.linux.org.uk>
Message-ID: <A0A1E7539300DF49AA383E614C7827BC048DB10979@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fixed version attached.


-----Original Message-----
From: Russell King - ARM Linux [mailto:linux at arm.linux.org.uk] 
Sent: Sunday, February 07, 2010 7:31 AM
To: Gary King
Cc: 'linux-arm-kernel at lists.infradead.org'
Subject: Re: race between kmap shootdown and cache maintenance

On Fri, Feb 05, 2010 at 10:13:03AM -0800, Gary King wrote:
> for highmem pages, flush_dcache_page must pin the kmap mapping in-place
> using kmap_high_get, to ensure that the cache maintenance does not race
> with another context calling kunmap_high on the same page and causing the
> PTE to be zapped.

You need to sign off on patches you send.

> ---
>  arch/arm/mm/flush.c |   18 +++++++++++++++---
>  1 files changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mm/flush.c b/arch/arm/mm/flush.c
> index 6f3a4b7..69ee285 100644
> --- a/arch/arm/mm/flush.c
> +++ b/arch/arm/mm/flush.c
> @@ -117,7 +117,7 @@ void flush_ptrace_access(struct vm_area_struct *vma, struct page *page,
>  
>  void __flush_dcache_page(struct address_space *mapping, struct page *page)
>  {
> -	void *addr = page_address(page);
> +	void *addr = NULL;

You shouldn't need an initializer here - the address will always be
initialized, either by kmap_high_get() or page_address().

>  
>  	/*
>  	 * Writeback any data associated with the kernel mapping of this
> @@ -127,10 +127,17 @@ void __flush_dcache_page(struct address_space *mapping, struct page *page)
>  #ifdef CONFIG_HIGHMEM
>  	/*
>  	 * kmap_atomic() doesn't set the page virtual address, and
> -	 * kunmap_atomic() takes care of cache flushing already.
> +	 * kunmap_atomic() takes care of cache flushing already; however,
> +	 * the kmap must be pinned locally to ensure that no other context
> +	 * unmaps it during the cache maintenance
>  	 */
> -	if (addr)
> +	if (PageHighMem(page))
> +		addr = kmap_high_get(page);
> +	else
>  #endif
> +		addr = page_address(page);
> +
> +	if (addr)
>  		__cpuc_flush_dcache_area(addr, PAGE_SIZE);
>  
>  	/*
> @@ -141,6 +148,11 @@ void __flush_dcache_page(struct address_space *mapping, struct page *page)
>  	if (mapping && cache_is_vipt_aliasing())
>  		flush_pfn_alias(page_to_pfn(page),
>  				page->index << PAGE_CACHE_SHIFT);
> +
> +#ifdef CONFIG_HIGHMEM
> +	if (PageHighMem(page) && addr)
> +		kunmap_high(page);
> +#endif

You don't need to hold on to the highmem kmap this long - the only thing
that it'd matter for is the __cpuc_flush_dcache_area() call.  You can
combine this conditional with the test for __cpuc_flush_dcache_area()
as well.

-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001--ARM-highmem-fix-race-between-cache-flush-and-kmap.patch
Type: application/octet-stream
Size: 1827 bytes
Desc: 0001--ARM-highmem-fix-race-between-cache-flush-and-kmap.patch
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100208/62c50b30/attachment.obj>
