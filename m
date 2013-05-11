From: gmbnomis@gmail.com (Simon Baatz)
Date: Sat, 11 May 2013 08:27:19 +0200
Subject: [PATCH V3 2/2] ARM: Handle user space mapped pages in
 flush_kernel_dcache_page
In-Reply-To: <CACVXFVPOuabwAa1VDmSnfDG=M-1Df02_kpbm0UVAVctCAB-U4Q@mail.gmail.com>
References: <20130418135104.GA18616@arm.com>
 <20130421220629.GA25571@schnuecks.de>
 <20130430112225.GD29766@arm.com>
 <20130430210403.GA18076@schnuecks.de>
 <20130501142206.GB17387@arm.com>
 <20130501190441.GA22227@schnuecks.de>
 <20130502095431.GA20730@arm.com>
 <20130502193835.GA29144@schnuecks.de>
 <20130503100242.GB29962@arm.com>
 <CACVXFVPOuabwAa1VDmSnfDG=M-1Df02_kpbm0UVAVctCAB-U4Q@mail.gmail.com>
Message-ID: <20130511062719.GA10643@schnuecks.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 04, 2013 at 04:21:27PM +0800, Ming Lei wrote:
> On Fri, May 3, 2013 at 6:02 PM, Catalin Marinas <catalin.marinas@arm.com> wrote:
> >>
> >> I assume that you inhibited the call to flush_dcache_page() in
> >> __get_user_pages() for anon pages.  Otherwise, you will be flooded
> >> with warnings.
> >
> > I haven't done any stress testing so I don't think I hit this code path,
> > so no warning. But yes, it should have triggered. Anyway, in this case
> > flush_dcache_page() should have just ignored (clearing PG_arch_1 is
> > harmless anyway if we also ignore this bit in __sync_icache_dcache for
> > non-aliasing caches).
> 
> Yes, maybe we can do a little optimization for O_DIRECT since no
> dcache alias and I/D coherency problem in this case on ARMv7, how
> about below change?
> 
> diff --git a/arch/arm/mm/flush.c b/arch/arm/mm/flush.c
> index 1c8f7f5..962a657 100644
> --- a/arch/arm/mm/flush.c
> +++ b/arch/arm/mm/flush.c
> @@ -287,6 +287,8 @@ void flush_dcache_page(struct page *page)
>  	    mapping && !mapping_mapped(mapping))
>  		clear_bit(PG_dcache_clean, &page->flags);
>  	else {
> +		if (!mapping && cache_is_vipt_nonaliasing())
> +			return;
>  		__flush_dcache_page(mapping, page);
>  		if (mapping && cache_is_vivt())
>  			__flush_dcache_aliases(mapping, page);
> 

Yes, this should not be needed. However, I seem to get funny pixel
errors on an Exynos 5 based Chromebook when not flushing in this
case.  Strange.  This is not on a mainline kernel, I will need to
have a look what happens here.


- Simon
