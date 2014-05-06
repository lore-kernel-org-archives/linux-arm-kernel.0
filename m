From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 6 May 2014 11:04:48 -0700
Subject: [PATCH 2/2] ARM: KVM: user_mem_abort: support stage 2 MMIO page
 mapping
In-Reply-To: <1395785294-2545-2-git-send-email-kim.phillips@linaro.org>
References: <1395785294-2545-1-git-send-email-kim.phillips@linaro.org>
 <1395785294-2545-2-git-send-email-kim.phillips@linaro.org>
Message-ID: <20140506180448.GH3066@lvm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 25, 2014 at 05:08:14PM -0500, Kim Phillips wrote:
> Use the correct memory type for device MMIO mappings: PAGE_S2_DEVICE.
> 
> Signed-off-by: Kim Phillips <kim.phillips@linaro.org>
> ---
>  arch/arm/kvm/mmu.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
> index 7789857..a354610 100644
> --- a/arch/arm/kvm/mmu.c
> +++ b/arch/arm/kvm/mmu.c
> @@ -652,6 +652,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>  	struct kvm_mmu_memory_cache *memcache = &vcpu->arch.mmu_page_cache;
>  	struct vm_area_struct *vma;
>  	pfn_t pfn;
> +	pgprot_t mem_type = PAGE_S2;
>  
>  	write_fault = kvm_is_write_fault(kvm_vcpu_get_hsr(vcpu));
>  	if (fault_status == FSC_PERM && !write_fault) {
> @@ -702,6 +703,9 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>  	if (is_error_pfn(pfn))
>  		return -EFAULT;
>  
> +	if (kvm_is_mmio_pfn(pfn))
> +		mem_type = PAGE_S2_DEVICE;
> +
>  	spin_lock(&kvm->mmu_lock);
>  	if (mmu_notifier_retry(kvm, mmu_seq))
>  		goto out_unlock;
> @@ -709,7 +713,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>  		hugetlb = transparent_hugepage_adjust(&pfn, &fault_ipa);
>  
>  	if (hugetlb) {
> -		pmd_t new_pmd = pfn_pmd(pfn, PAGE_S2);
> +		pmd_t new_pmd = pfn_pmd(pfn, mem_type);
>  		new_pmd = pmd_mkhuge(new_pmd);
>  		if (writable) {
>  			kvm_set_s2pmd_writable(&new_pmd);
> @@ -718,13 +722,14 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>  		coherent_icache_guest_page(kvm, hva & PMD_MASK, PMD_SIZE);
>  		ret = stage2_set_pmd_huge(kvm, memcache, fault_ipa, &new_pmd);
>  	} else {
> -		pte_t new_pte = pfn_pte(pfn, PAGE_S2);
> +		pte_t new_pte = pfn_pte(pfn, mem_type);
>  		if (writable) {
>  			kvm_set_s2pte_writable(&new_pte);
>  			kvm_set_pfn_dirty(pfn);
>  		}
>  		coherent_icache_guest_page(kvm, hva, PAGE_SIZE);
> -		ret = stage2_set_pte(kvm, memcache, fault_ipa, &new_pte, false);
> +		ret = stage2_set_pte(kvm, memcache, fault_ipa, &new_pte,
> +				     mem_type == PAGE_S2_DEVICE);
>  	}
>  
>  
> -- 
> 1.9.1
> 

I think this looks reasonable.

Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
