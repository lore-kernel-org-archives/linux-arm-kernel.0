From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 12 Aug 2014 11:50:45 +0200
Subject: [PATCH v9 4/4] arm: ARMv7 dirty page logging 2nd stage page
 fault handling support
In-Reply-To: <53E96CF1.6040806@samsung.com>
References: <1406249768-25315-1-git-send-email-m.smarduch@samsung.com>
 <1406249768-25315-5-git-send-email-m.smarduch@samsung.com>
 <20140811191315.GI10550@cbox> <53E96CF1.6040806@samsung.com>
Message-ID: <20140812095045.GN10550@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 11, 2014 at 06:25:05PM -0700, Mario Smarduch wrote:
> On 08/11/2014 12:13 PM, Christoffer Dall wrote:
> > On Thu, Jul 24, 2014 at 05:56:08PM -0700, Mario Smarduch wrote:
> >> This patch adds support for handling 2nd stage page faults during migration,
> >> it disables faulting in huge pages, and dissolves huge pages to page tables.
> >> In case migration is canceled huge pages will be used again.
> >>
> >> Signed-off-by: Mario Smarduch <m.smarduch@samsung.com>
> >> ---
> >>  arch/arm/kvm/mmu.c |   31 +++++++++++++++++++++++++------
> >>  1 file changed, 25 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
> >> index ca84331..a17812a 100644
> >> --- a/arch/arm/kvm/mmu.c
> >> +++ b/arch/arm/kvm/mmu.c
> >> @@ -642,7 +642,8 @@ static int stage2_set_pmd_huge(struct kvm *kvm, struct kvm_mmu_memory_cache
> >>  }
> >>  
> >>  static int stage2_set_pte(struct kvm *kvm, struct kvm_mmu_memory_cache *cache,
> >> -			  phys_addr_t addr, const pte_t *new_pte, bool iomap)
> >> +			  phys_addr_t addr, const pte_t *new_pte, bool iomap,
> >> +			  bool logging_active)
> >>  {
> >>  	pmd_t *pmd;
> >>  	pte_t *pte, old_pte;
> >> @@ -657,6 +658,15 @@ static int stage2_set_pte(struct kvm *kvm, struct kvm_mmu_memory_cache *cache,
> >>  		return 0;
> >>  	}
> >>  
> >> +	/*
> >> +	 * While dirty memory logging, clear PMD entry for huge page and split
> >> +	 * into smaller pages, to track dirty memory at page granularity.
> >> +	 */
> >> +	if (logging_active && kvm_pmd_huge(*pmd)) {
> >> +		phys_addr_t ipa = pmd_pfn(*pmd) << PAGE_SHIFT;
> >> +		clear_pmd_entry(kvm, pmd, ipa);
> > 
> > clear_pmd_entry has a VM_BUG_ON(kvm_pmd_huge(*pmd)) so that is
> > definitely not the right thing to call.
> 
> I don't see that in 3.15rc1/rc4 -
> 
> static void clear_pmd_entry(struct kvm *kvm, pmd_t *pmd, phys_addr_t addr)
> {
>         if (kvm_pmd_huge(*pmd)) {
>                 pmd_clear(pmd);
>                 kvm_tlb_flush_vmid_ipa(kvm, addr);
>         } else {
>                   [....]
> }
> 
> I thought the purpose of this function was to clear PMD entry. Also
> ran hundreds of tests no problems. Hmmm confused.
> 

You need to rebase on kvm/next or linus/master, something that contains:

4f853a7 arm/arm64: KVM: Fix and refactor unmap_range

> > 
> >> +	}
> >> +
> >>  	/* Create stage-2 page mappings - Level 2 */
> >>  	if (pmd_none(*pmd)) {
> >>  		if (!cache)
> >> @@ -709,7 +719,7 @@ int kvm_phys_addr_ioremap(struct kvm *kvm, phys_addr_t guest_ipa,
> >>  		if (ret)
> >>  			goto out;
> >>  		spin_lock(&kvm->mmu_lock);
> >> -		ret = stage2_set_pte(kvm, &cache, addr, &pte, true);
> >> +		ret = stage2_set_pte(kvm, &cache, addr, &pte, true, false);
> >>  		spin_unlock(&kvm->mmu_lock);
> >>  		if (ret)
> >>  			goto out;
> >> @@ -926,6 +936,12 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
> >>  	struct kvm_mmu_memory_cache *memcache = &vcpu->arch.mmu_page_cache;
> >>  	struct vm_area_struct *vma;
> >>  	pfn_t pfn;
> >> +	/* Get logging status, if dirty_bitmap is not NULL then logging is on */
> >> +	#ifdef CONFIG_ARM
> >> +		bool logging_active = !!memslot->dirty_bitmap;
> >> +	#else
> >> +		bool logging_active = false;
> >> +	#endif
> > 
> > can you make this an inline in the header files for now please?
> 
> Yes definitely.
> 
> > 
> >>  
> >>  	write_fault = kvm_is_write_fault(kvm_vcpu_get_hsr(vcpu));
> >>  	if (fault_status == FSC_PERM && !write_fault) {
> >> @@ -936,7 +952,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
> >>  	/* Let's check if we will get back a huge page backed by hugetlbfs */
> >>  	down_read(&current->mm->mmap_sem);
> >>  	vma = find_vma_intersection(current->mm, hva, hva + 1);
> >> -	if (is_vm_hugetlb_page(vma)) {
> >> +	if (is_vm_hugetlb_page(vma) && !logging_active) {
> >>  		hugetlb = true;
> >>  		gfn = (fault_ipa & PMD_MASK) >> PAGE_SHIFT;
> >>  	} else {
> >> @@ -979,7 +995,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
> >>  	spin_lock(&kvm->mmu_lock);
> >>  	if (mmu_notifier_retry(kvm, mmu_seq))
> >>  		goto out_unlock;
> >> -	if (!hugetlb && !force_pte)
> >> +	if (!hugetlb && !force_pte && !logging_active)
> >>  		hugetlb = transparent_hugepage_adjust(&pfn, &fault_ipa);
> >>  
> >>  	if (hugetlb) {
> >> @@ -998,9 +1014,12 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
> >>  			kvm_set_pfn_dirty(pfn);
> >>  		}
> >>  		coherent_cache_guest_page(vcpu, hva, PAGE_SIZE);
> >> -		ret = stage2_set_pte(kvm, memcache, fault_ipa, &new_pte, false);
> >> +		ret = stage2_set_pte(kvm, memcache, fault_ipa, &new_pte, false,
> >> +					logging_active);
> >>  	}
> >>  
> >> +	if (write_fault)
> >> +		mark_page_dirty(kvm, gfn);
> >>  
> >>  out_unlock:
> >>  	spin_unlock(&kvm->mmu_lock);
> >> @@ -1151,7 +1170,7 @@ static void kvm_set_spte_handler(struct kvm *kvm, gpa_t gpa, void *data)
> >>  {
> >>  	pte_t *pte = (pte_t *)data;
> >>  
> >> -	stage2_set_pte(kvm, NULL, gpa, pte, false);
> >> +	stage2_set_pte(kvm, NULL, gpa, pte, false, false);
> > 
> > why is logging never active if we are called from MMU notifiers?
> 
> mmu notifiers update sptes, but I don't see how these updates
> can result in guest dirty pages. Also guest pages are marked dirty
> from 2nd stage page fault handlers (searching through the code).
> 
Ok, then add:

/*
 * We can always call stage2_set_pte with logging_active == false,
 * because MMU notifiers will have unmapped a huge PMD before calling
 * ->change_pte() (which in turn calls kvm_set_spte_hva()) and therefore
 * stage2_set_pte() never needs to clear out a huge PMD through this
 * calling path.
 */

Thanks,
-Christoffer
