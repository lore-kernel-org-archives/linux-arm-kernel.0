From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 14 Aug 2013 10:37:53 -0700
Subject: [PATCH] ARM64: KVM: Fix coherent_icache_guest_page() for host
 with external L3-cache.
In-Reply-To: <1376480832-18705-1-git-send-email-pranavkumar@linaro.org>
References: <1376480832-18705-1-git-send-email-pranavkumar@linaro.org>
Message-ID: <20130814173753.GE11390@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 14, 2013 at 05:17:12PM +0530, Pranavkumar Sawargaonkar wrote:
> Systems with large external L3-cache (few MBs), might have dirty
> content belonging to the guest page in L3-cache. To tackle this,
> we need to flush such dirty content from d-cache so that guest
> will see correct contents of guest page when guest MMU is disabled.
> 
> The patch fixes coherent_icache_guest_page() for external L3-cache.
> 
> Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
> Signed-off-by: Anup Patel <anup.patel@linaro.org>
> ---
>  arch/arm64/include/asm/kvm_mmu.h |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
> index efe609c..5129038 100644
> --- a/arch/arm64/include/asm/kvm_mmu.h
> +++ b/arch/arm64/include/asm/kvm_mmu.h
> @@ -123,6 +123,8 @@ static inline void coherent_icache_guest_page(struct kvm *kvm, gfn_t gfn)
>  	if (!icache_is_aliasing()) {		/* PIPT */
>  		unsigned long hva = gfn_to_hva(kvm, gfn);
>  		flush_icache_range(hva, hva + PAGE_SIZE);
> +		/* Flush d-cache for systems with external caches. */

This comment is nowhere near explanatory enough for someone who comes by
later and tries to figure out why we're flushing the dcache on every
page we swap in under given circumstances.  Yes, you can do git blame,
until you modify the line for some other reason and it just becomes a
pain.

> +		__flush_dcache_area((void *) hva, PAGE_SIZE);

eh, why is this only relevant for a non-aliasing icache?  In fact, this
does not seem to be icache related at all, but rather instruction-stream
to dcache related, which would warrant either a rename of the function
to something more generic or a separate function.

>  	} else if (!icache_is_aivivt()) {	/* non ASID-tagged VIVT */
>  		/* any kind of VIPT cache */
>  		__flush_icache_all();
> -- 
> 1.7.9.5
> 
> _______________________________________________
> kvmarm mailing list
> kvmarm at lists.cs.columbia.edu
> https://lists.cs.columbia.edu/cucslists/listinfo/kvmarm
