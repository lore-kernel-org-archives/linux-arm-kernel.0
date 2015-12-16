From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 16 Dec 2015 11:39:21 +0000
Subject: [PATCH v3 2/2] arm64: Use PoU cache instr for I/D coherency
In-Reply-To: <1450260690-5431-3-git-send-email-ashoks@broadcom.com>
References: <1450260690-5431-1-git-send-email-ashoks@broadcom.com>
 <1450260690-5431-3-git-send-email-ashoks@broadcom.com>
Message-ID: <20151216113920.GC2765@mbp>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 16, 2015 at 02:11:30AM -0800, Ashok Kumar wrote:
> @@ -74,13 +79,11 @@ void __sync_icache_dcache(pte_t pte, unsigned long addr)
>  	if (!page_mapping(page))
>  		return;
>  
> -	if (!test_and_set_bit(PG_dcache_clean, &page->flags)) {
> -		__flush_dcache_area(page_address(page),
> -				PAGE_SIZE << compound_order(page));
> +	if (!test_and_set_bit(PG_dcache_clean, &page->flags))
> +		sync_icache_aliases(page_address(page),
> +				    PAGE_SIZE << compound_order(page));
> +	else if (icache_is_aivivt())
>  		__flush_icache_all();
> -	} else if (icache_is_aivivt()) {
> -		__flush_icache_all();
> -	}
>  }

You changed the original code path slightly here. We had a
__flush_icache_all() even for non-aliasing VIPT but it now does the
I-cache invalidation per page. It may be an improvement, I can't tell
without benchmarks but you should at least mention this in the commit
log so that we remember in the future. Apart from this:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
