From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 20 Mar 2017 12:08:17 +0000
Subject: [PATCH 6/6] arm64: KVM: Add support for VPIPT I-caches
In-Reply-To: <1489177945-8590-6-git-send-email-will.deacon@arm.com>
References: <1489177945-8590-1-git-send-email-will.deacon@arm.com>
 <1489177945-8590-6-git-send-email-will.deacon@arm.com>
Message-ID: <20170320120816.GA31213@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 10, 2017 at 08:32:25PM +0000, Will Deacon wrote:
> A VPIPT I-cache has two main properties:
> 
> 1. Lines allocated into the cache are tagged by VMID and a lookup can
>    only hit lines that were allocated with the current VMID.
> 
> 2. I-cache invalidation from EL1/0 only invalidates lines that match the
>    current VMID of the CPU doing the invalidation.
> 
> This can cause issues with non-VHE configurations, where the host runs
> at EL1 and wants to invalidate I-cache entries for a guest running with
> a different VMID. VHE is not affected, because the host runs at EL2 and
> I-cache invalidation applies as expected.
> 
> This patch solves the problem by invalidating the I-cache when unmapping
> a page at stage 2 on a system with a VPIPT I-cache but not running with
> VHE enabled. Hopefully this is an obscure enough configuration that the
> overhead isn't anything to worry about, although it does mean that the
> by-range I-cache invalidation currently performed when mapping at stage
> 2 can be elided on such systems, because the I-cache will be clean for
> the guest VMID following a rollover event.
> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm64/include/asm/kvm_mmu.h |  9 +++++----
>  arch/arm64/kvm/hyp/tlb.c         | 22 ++++++++++++++++++++++
>  2 files changed, 27 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
> index dc3624d8b9db..d2293d49f555 100644
> --- a/arch/arm64/include/asm/kvm_mmu.h
> +++ b/arch/arm64/include/asm/kvm_mmu.h
> @@ -242,12 +242,13 @@ static inline void __coherent_cache_guest_page(struct kvm_vcpu *vcpu,
>  
>  	kvm_flush_dcache_to_poc(va, size);
>  
> -	if (!icache_is_aliasing()) {		/* PIPT */
> -		flush_icache_range((unsigned long)va,
> -				   (unsigned long)va + size);
> -	} else {
> +	if (icache_is_aliasing()) {
>  		/* any kind of VIPT cache */
>  		__flush_icache_all();
> +	} else if (is_kernel_in_hyp_mode() || !icache_is_vpipt()) {
> +		/* PIPT or VPIPT at EL2 (see comment in __kvm_tlb_flush_vmid_ipa) */
> +		flush_icache_range((unsigned long)va,
> +				   (unsigned long)va + size);
>  	}
>  }
>  
> diff --git a/arch/arm64/kvm/hyp/tlb.c b/arch/arm64/kvm/hyp/tlb.c
> index e8e7ba2bc11f..f02c7e6a8db4 100644
> --- a/arch/arm64/kvm/hyp/tlb.c
> +++ b/arch/arm64/kvm/hyp/tlb.c
> @@ -46,6 +46,28 @@ void __hyp_text __kvm_tlb_flush_vmid_ipa(struct kvm *kvm, phys_addr_t ipa)
>  	dsb(ish);
>  	isb();
>  
> +	/*
> +	 * If the host is running at EL1 and we have a VPIPT I-cache,
> +	 * then we must perform I-cache maintenance at EL2 in order for
> +	 * it to have an effect on the guest. Since the guest cannot hit
> +	 * I-cache lines allocated with a different VMID, we don't need
> +	 * to worry about junk out of guest reset (we nuke the I-cache on
> +	 * VMID rollover), but we do need to be careful when remapping
> +	 * executable pages for the same guest. This can happen when KSM
> +	 * takes a CoW fault on an executable page, copies the page into
> +	 * a page that was previously mapped in the guest and then needs
> +	 * to invalidate the guest view of the I-cache for that page
> +	 * from EL1. To solve this, we invalidate the entire I-cache when
> +	 * unmapping a page from a guest if we have a VPIPT I-cache but
> +	 * the host is running at EL1. As above, we could do better if
> +	 * we had the VA.
> +	 *
> +	 * The moral of this story is: if you have a VPIPT I-cache, then
> +	 * you should be running with VHE enabled.
> +	 */
> +	if (!has_vhe() && icache_is_vpipt())
> +		__flush_icache_all();

The is_kernel_in_hyp_mode() / has_vhe() inconsistency across these two
functions is somewhat confusing.

Is there any reason __coherent_cache_guest_page() can't use has_vhe()
too?

Otherwise, this all looks sane to me.

Thanks,
Mark.
