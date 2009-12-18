From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 18 Dec 2009 16:09:24 +0000
Subject: [CFT:PATCH] Remove a seemingly unnecessary cache flush
In-Reply-To: <20091207221210.GI26821@n2100.arm.linux.org.uk>
References: <20091207221210.GI26821@n2100.arm.linux.org.uk>
Message-ID: <20091218160924.GB5527@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Could I have some Tested-by: lines for this patch please?

On Mon, Dec 07, 2009 at 10:12:10PM +0000, Russell King - ARM Linux wrote:
> While looking into the possible msync() issue (which turned out to be a
> non-issue - it's covered by clever code), I found that we're flushing
> the same page multiple times.
> 
> Normally, update_mmu_cache() would not be doing anything on architectures
> which don't have a software-loaded TLB.  However, we use this hook for
> two things:
> 
> 1. for our delayed flush_dcache_page().
> 2. to fix up multiple shared write-able mappings of the same page.
> 
> However, as of 8 years ago, I committed this patch (sorry for the
> bkbits URL):
> 
> http://linux.bkbits.net:8080/linux-2.6/?PAGE=patch&REV=3dd7c1f9DypjNd1HyQFAOsA3p7mYig
> 
> What the majority of that patch is doing is adding the user-mapping
> flushing to __flush_dcache_page() - that's fine, and it's explained in
> the changeset comments.
> 
> It also tries to merge the new __flush_dcache_page() code inside
> make_coherent() - make_coherent() is sort-of already doing most of what
> __flush_dcache_page() does, and for good measure it does a final
> flush_cache_page().
> 
> The unused addition of 'dirty' seems to suggest that this extra
> flush_cache_page should have been conditional on that.
> 
> Moreover, this final flush_cache_page() should not be needed - the whole
> "delayed flush_dcache_page" thing only happens when there are no pre-
> existing mappings of the page, and so there should be no user mappings
> to worry about.
> 
> Hence, I believe it is safe to get rid of this - but this patch will
> need some rigorous testing.  My ARM VersatilePB926 still boots without
> this additional patch - but that's not a very good test.  I can't say
> much more than that for the time being.
> 
> Note: for ARMv6 and later, flush_cache_page() is a no-op, so please
> don't bother testing this patch there.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  arch/arm/mm/fault-armv.c |    2 --
>  1 files changed, 0 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mm/fault-armv.c b/arch/arm/mm/fault-armv.c
> index 7296022..666a871 100644
> --- a/arch/arm/mm/fault-armv.c
> +++ b/arch/arm/mm/fault-armv.c
> @@ -127,8 +127,6 @@ make_coherent(struct address_space *mapping, struct vm_area_struct *vma, unsigne
>  	flush_dcache_mmap_unlock(mapping);
>  	if (aliases)
>  		adjust_pte(vma, addr);
> -	else
> -		flush_cache_page(vma, addr, pfn);
>  }
>  
>  /*
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
