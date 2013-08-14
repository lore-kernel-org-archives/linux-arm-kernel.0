From: Sudeep.KarkadaNagesha@arm.com (Sudeep KarkadaNagesha)
Date: Wed, 14 Aug 2013 15:23:23 +0100
Subject: [PATCH] ARM64: KVM: Fix coherent_icache_guest_page() for host
 with external L3-cache.
In-Reply-To: <1376480832-18705-1-git-send-email-pranavkumar@linaro.org>
References: <1376480832-18705-1-git-send-email-pranavkumar@linaro.org>
Message-ID: <520B92DB.5070708@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/08/13 12:47, Pranavkumar Sawargaonkar wrote:
> Systems with large external L3-cache (few MBs), might have dirty
> content belonging to the guest page in L3-cache. To tackle this,
> we need to flush such dirty content from d-cache so that guest
> will see correct contents of guest page when guest MMU is disabled.
> 
> The patch fixes coherent_icache_guest_page() for external L3-cache.
> 

I don't understand KVM but the commit message caught my attention.

You are referring to clean the external/outer L3 cache but using
internal cache maintenance APIs. You should be using outer_cache APIs if
you really intend to do outer cache maintenance ?
Is the external/outer L3 cache not unified ?

Or did you mean to flush d-cache to the point of coherency(external L3
in your case)? If so it's not clear from the commit log.

Regards,
Sudeep

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
> +		__flush_dcache_area((void *) hva, PAGE_SIZE);
>  	} else if (!icache_is_aivivt()) {	/* non ASID-tagged VIVT */
>  		/* any kind of VIPT cache */
>  		__flush_icache_all();
> 
