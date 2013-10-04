From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 04 Oct 2013 09:57:02 +0100
Subject: [PATCH v2 2/2] KVM: ARM: Transparent huge page (THP) support
In-Reply-To: <1380832591-4789-3-git-send-email-christoffer.dall@linaro.org>
References: <1380832591-4789-1-git-send-email-christoffer.dall@linaro.org>
 <1380832591-4789-3-git-send-email-christoffer.dall@linaro.org>
Message-ID: <524E82DE.1080806@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/10/13 21:36, Christoffer Dall wrote:
> Support transparent huge pages in KVM/ARM and KVM/ARM64.  The
> transparent_hugepage_adjust is not very pretty, but this is also how
> it's solved on x86 and seems to be simply an artifact on how THPs
> behave.  This should eventually be shared across architectures if
> possible, but that can always be changed down the road.
> 
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
> 
> ---
> Changelog[v2]:
>  - THP handling moved into separate patch.
>  - Minor changes and clarified comment in transparent_hugepage_adjust
>    from Marc Z's review.
> ---
>  arch/arm/kvm/mmu.c |   45 ++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 44 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
> index cab031b..0a856a0 100644
> --- a/arch/arm/kvm/mmu.c
> +++ b/arch/arm/kvm/mmu.c
> @@ -42,7 +42,7 @@ static unsigned long hyp_idmap_start;
>  static unsigned long hyp_idmap_end;
>  static phys_addr_t hyp_idmap_vector;
>  
> -#define kvm_pmd_huge(_x)	(pmd_huge(_x))
> +#define kvm_pmd_huge(_x)	(pmd_huge(_x) || pmd_trans_huge(_x))
>  
>  static void kvm_tlb_flush_vmid_ipa(struct kvm *kvm, phys_addr_t ipa)
>  {
> @@ -576,6 +576,47 @@ out:
>  	return ret;
>  }
>  
> +static bool transparent_hugepage_adjust(pfn_t *pfnp, phys_addr_t *ipap)
> +{
> +	pfn_t pfn = *pfnp;
> +	gfn_t gfn = *ipap >> PAGE_SHIFT;
> +
> +	if (PageTransCompound(pfn_to_page(pfn))) {
> +		unsigned long mask;
> +		/*
> +		 * The address we faulted on is backed by a transparent huge
> +		 * page.  However, because we map the compound huge page and
> +		 * not the individual tail page, we need to transfer the
> +		 * refcount to the head page.  We have to be careful that the
> +		 * THP doesn't start to split while we are adjusting the
> +		 * refcounts.
> +		 *
> +		 * We are sure this doesn't happen, because mmu_notifier_retry
> +		 * was succesful and we are holding the mmu_lock, so if this

successful

> +		 * THP is trying to split, it will be blocked in the mmu
> +		 * notifier before touching any of the pages, specifically
> +		 * before being able to call __split_huge_page_refcount().
> +		 *
> +		 * We can therefore safely transfer the refcount from PG_tail
> +		 * to PG_head and switch the pfn from a tail page to the head
> +		 * page accordingly.
> +		 */
> +		mask = PTRS_PER_PMD - 1;
> +		VM_BUG_ON((gfn & mask) != (pfn & mask));
> +		if (pfn & mask) {
> +			*ipap &= PMD_MASK;
> +			kvm_release_pfn_clean(pfn);
> +			pfn &= ~mask;
> +			kvm_get_pfn(pfn);
> +			*pfnp = pfn;
> +		}
> +
> +		return true;
> +	}
> +
> +	return false;
> +}
> +
>  static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>  			  struct kvm_memory_slot *memslot,
>  			  unsigned long fault_status)
> @@ -632,6 +673,8 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>  	spin_lock(&kvm->mmu_lock);
>  	if (mmu_notifier_retry(kvm, mmu_seq))
>  		goto out_unlock;
> +	if (!hugetlb && !force_pte)
> +		hugetlb = transparent_hugepage_adjust(&pfn, &fault_ipa);
>  
>  	if (hugetlb) {
>  		pmd_t new_pmd = pfn_pmd(pfn, PAGE_S2);
> 

Looks good. I think that if you fix the minor issues I have with the
previous patch, this is good to go.

	M.
-- 
Jazz is not dead. It just smells funny...
