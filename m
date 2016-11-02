From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 2 Nov 2016 10:40:39 -0600
Subject: flush_dcache_page() in ARM vs ARM64
In-Reply-To: <20161102132714.GA1326@lnxartpec.se.axis.com>
References: <20161102132714.GA1326@lnxartpec.se.axis.com>
Message-ID: <20161102164039.oddouqv3wwtm357t@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 02, 2016 at 02:27:14PM +0100, Rabin Vincent wrote:
> ARMv7-A and ARMv8-A are, as far as I can see, identical in which cache
> behaviours they support.  The data cache has to behave as PIPT while for
> the instruction cache, PIPT, VIPT, and ASIC-tagged VIVT behaviours are
> supported.  See section B3.11 of the ARMv7-A ARM and section D4.9 of the
> ARMv8-A ARM.
> 
> Both ARMv7-A with Multiprocessing Extensions and ARMv8-A broadcast cache
> maintenance operations to other cores.  See B2.2.5 of the ARMv7-A ARM
> and D7.2.57 of the ARMv8-A ARM.
> 
> Both arch/arm/ (for ARMv6+) and arch/arm64/ define PG_arch_1 to be
> PG_dcache_clean and use it to postpone flushing from flush_dcache_page()
> to set_pte_at().  See arch/{arm,arm64}/mm/flush.c.
> 
> However, arch/arm64/'s flush_dcache_page() is implemented like this:
> 
> 	void flush_dcache_page(struct page *page)
> 	{
> 		if (test_bit(PG_dcache_clean, &page->flags))
> 			clear_bit(PG_dcache_clean, &page->flags);
> 	}

arm64 had a similar implementation to arm until commit b5b6c9e9149d
("arm64: Avoid cache flushing in flush_dcache_page()").

> Why does arch/arm/ flush the data cache area in flush_dcache_page() for
> the (!mapping || page_mapcount(page)) case even on ARMv7+ME, while
> arch/arm64/ doesn't for ARMv8?

IIRC, the reason was D-cache aliases which have disappeared from ARMv7.

> Why does arch/arm/ invalidate the instruction cache in
> flush_dcache_page() for the (mapping && page_count(page)) case even for
> ARMv7+ME, while arch/arm64/ doesn't for ARMv8?

I guess no-one updated it for non-aliasing caches.

> What would break with the following patch?
> 
> diff --git a/arch/arm/mm/flush.c b/arch/arm/mm/flush.c
> index 3cced84..f1e6190 100644
> --- a/arch/arm/mm/flush.c
> +++ b/arch/arm/mm/flush.c
> @@ -327,6 +327,12 @@ void flush_dcache_page(struct page *page)
>  	if (page == ZERO_PAGE(0))
>  		return;
>  
> +	if (!cache_ops_need_broadcast() && cache_is_vipt_nonaliasing()) {
> +		if (test_bit(PG_dcache_clean, &page->flags))
> +			clear_bit(PG_dcache_clean, &page->flags);
> +		return;
> +	}
> +
>  	mapping = page_mapping(page);
>  
>  	if (!cache_ops_need_broadcast() &&

This should work. Note that the test_bit() is just an optimisation I
borrowed from powerpc, not sure it has any noticeable impact (you could
as well just do the clear_bit()).

-- 
Catalin
