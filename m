From: m.smarduch@samsung.com (Mario Smarduch)
Date: Mon, 24 Nov 2014 17:09:54 -0800
Subject: [RESEND PATCH v14 7/7] KVM: arm: page logging 2nd stage fault
 handling
In-Reply-To: <54738EE7.8060804@samsung.com>
References: <1416002084-9928-1-git-send-email-m.smarduch@samsung.com>
 <20141122195351.GP3401@cbox> <54738EE7.8060804@samsung.com>
Message-ID: <5473D6E2.3060401@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/24/2014 12:02 PM, Mario Smarduch wrote:
> On 11/22/2014 11:53 AM, Christoffer Dall wrote:
>> On Fri, Nov 14, 2014 at 01:54:44PM -0800, Mario Smarduch wrote:
>>> This patch adds support for handling 2nd stage page faults during migration,
>>> it disables faulting in huge pages, and dissolves huge pages to page tables.
>>> In case migration is canceled huge pages are used again.
>>>
>>> Resending to addresse Marc's comments to simplify stage2_set_pte() handling 
>>> of logging, and mapping device memory - flags.
>>>
>>> Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
>>> Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
>>> Signed-off-by: Mario Smarduch <m.smarduch@samsung.com>
>>> ---
>>>  arch/arm/kvm/mmu.c |   61 +++++++++++++++++++++++++++++++++++++++++++++-------
>>>  1 file changed, 53 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
>>> index 8137455..d29de77 100644
>>> --- a/arch/arm/kvm/mmu.c
>>> +++ b/arch/arm/kvm/mmu.c
>>> @@ -47,6 +47,18 @@ static phys_addr_t hyp_idmap_vector;
>>>  #define kvm_pmd_huge(_x)	(pmd_huge(_x) || pmd_trans_huge(_x))
>>>  #define kvm_pud_huge(_x)	pud_huge(_x)
>>>  
>>> +#define KVM_S2PTE_FLAG_IS_IOMAP		(1UL << 0)
>>> +#define KVM_S2PTE_FLAG_LOGGING_ACTIVE	(1UL << 1)
>>> +
>>> +static bool kvm_get_logging_state(struct kvm_memory_slot *memslot)
>>> +{
>>> +#ifdef CONFIG_ARM
>>> +	return !!memslot->dirty_bitmap;
>>> +#else
>>> +	return false;
>>> +#endif
>>> +}
>>> +
>>>  static void kvm_tlb_flush_vmid_ipa(struct kvm *kvm, phys_addr_t ipa)
>>>  {
>>>  	/*
>>> @@ -626,10 +638,13 @@ static int stage2_set_pmd_huge(struct kvm *kvm, struct kvm_mmu_memory_cache
>>>  }
>>>  
>>>  static int stage2_set_pte(struct kvm *kvm, struct kvm_mmu_memory_cache *cache,
>>> -			  phys_addr_t addr, const pte_t *new_pte, bool iomap)
>>> +			  phys_addr_t addr, const pte_t *new_pte,
>>> +			  unsigned long flags)
>>>  {
>>>  	pmd_t *pmd;
>>>  	pte_t *pte, old_pte;
>>> +	unsigned long iomap = flags & KVM_S2PTE_FLAG_IS_IOMAP;
>>> +	unsigned long logging_active = flags & KVM_S2PTE_FLAG_LOGGING_ACTIVE;
>>>  
>>>  	/* Create stage-2 page table mapping - Level 1 */
>>>  	pmd = stage2_get_pmd(kvm, cache, addr);
>>> @@ -641,6 +656,18 @@ static int stage2_set_pte(struct kvm *kvm, struct kvm_mmu_memory_cache *cache,
>>>  		return 0;
>>>  	}
>>>  
>>> +	/*
>>> +	 * While dirty memory logging, clear PMD entry for huge page and split
>>> +	 * into smaller pages, to track dirty memory at page granularity.
>>> +	 */
>>> +	if (logging_active && kvm_pmd_huge(*pmd)) {
>>> +		phys_addr_t ipa = pmd_pfn(*pmd) << PAGE_SHIFT;
>>
>> just noticed this: this is not an IPA is it?  pmd_pfn should give us the
>> host pfn.  I think you need to manipulate @addr instead.
>>
>> Did I manage to confuse myself?
> No you're right, a *bad mistake* on my part I broke it between v8 and
> v9. Not sure how it happened absent minded cut and paste?
> 
> Also when the pmd is cleared, should that be flushed
> to level where the pmd is visible to page table walks?
> Or am I confusing something here?

Hi Christoffer,
   disregard question, sorry for the unnecessary traffic.

> 
> Thanks.
>>
>> (Yeah, I know I said I reviewed this one already)
>>
>>> +
>>> +		pmd_clear(pmd);
>>> +		kvm_tlb_flush_vmid_ipa(kvm, ipa);
>>> +		put_page(virt_to_page(pmd));
>>> +	}
>>> +
>>>  	/* Create stage-2 page mappings - Level 2 */
>>>  	if (pmd_none(*pmd)) {
>>>  		if (!cache)
>>> @@ -693,7 +720,8 @@ int kvm_phys_addr_ioremap(struct kvm *kvm, phys_addr_t guest_ipa,
>>>  		if (ret)
>>>  			goto out;
>>>  		spin_lock(&kvm->mmu_lock);
>>> -		ret = stage2_set_pte(kvm, &cache, addr, &pte, true);
>>> +		ret = stage2_set_pte(kvm, &cache, addr, &pte,
>>> +						KVM_S2PTE_FLAG_IS_IOMAP);
>>>  		spin_unlock(&kvm->mmu_lock);
>>>  		if (ret)
>>>  			goto out;
>>> @@ -908,6 +936,10 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>>>  	struct vm_area_struct *vma;
>>>  	pfn_t pfn;
>>>  	pgprot_t mem_type = PAGE_S2;
>>> +	unsigned long logging_active = 0;
>>> +
>>> +	if (kvm_get_logging_state(memslot))
>>> +		logging_active = KVM_S2PTE_FLAG_LOGGING_ACTIVE;
>>>  
>>>  	write_fault = kvm_is_write_fault(kvm_vcpu_get_hsr(vcpu));
>>>  	if (fault_status == FSC_PERM && !write_fault) {
>>> @@ -918,7 +950,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>>>  	/* Let's check if we will get back a huge page backed by hugetlbfs */
>>>  	down_read(&current->mm->mmap_sem);
>>>  	vma = find_vma_intersection(current->mm, hva, hva + 1);
>>> -	if (is_vm_hugetlb_page(vma)) {
>>> +	if (is_vm_hugetlb_page(vma) && !logging_active) {
>>>  		hugetlb = true;
>>>  		gfn = (fault_ipa & PMD_MASK) >> PAGE_SHIFT;
>>>  	} else {
>>> @@ -964,7 +996,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>>>  	spin_lock(&kvm->mmu_lock);
>>>  	if (mmu_notifier_retry(kvm, mmu_seq))
>>>  		goto out_unlock;
>>> -	if (!hugetlb && !force_pte)
>>> +	if (!hugetlb && !force_pte && !logging_active)
>>>  		hugetlb = transparent_hugepage_adjust(&pfn, &fault_ipa);
>>>  
>>>  	if (hugetlb) {
>>> @@ -978,16 +1010,21 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>>>  		ret = stage2_set_pmd_huge(kvm, memcache, fault_ipa, &new_pmd);
>>>  	} else {
>>>  		pte_t new_pte = pfn_pte(pfn, mem_type);
>>> +		unsigned long flags = logging_active;
>>> +
>>> +		if (mem_type == PAGE_S2_DEVICE)
>>> +			flags |= KVM_S2PTE_FLAG_IS_IOMAP;
>>> +
>>>  		if (writable) {
>>>  			kvm_set_s2pte_writable(&new_pte);
>>>  			kvm_set_pfn_dirty(pfn);
>>>  		}
>>>  		coherent_cache_guest_page(vcpu, hva, PAGE_SIZE);
>>> -		ret = stage2_set_pte(kvm, memcache, fault_ipa, &new_pte,
>>> -				     mem_type == PAGE_S2_DEVICE);
>>> +		ret = stage2_set_pte(kvm, memcache, fault_ipa, &new_pte, flags);
>>>  	}
>>>  
>>> -
>>> +	if (write_fault)
>>> +		mark_page_dirty(kvm, gfn);
>>>  out_unlock:
>>>  	spin_unlock(&kvm->mmu_lock);
>>>  	kvm_release_pfn_clean(pfn);
>>> @@ -1137,7 +1174,15 @@ static void kvm_set_spte_handler(struct kvm *kvm, gpa_t gpa, void *data)
>>>  {
>>>  	pte_t *pte = (pte_t *)data;
>>>  
>>> -	stage2_set_pte(kvm, NULL, gpa, pte, false);
>>> +	/*
>>> +	 * We can always call stage2_set_pte with logging_active == false,
>>
>> this should now say without the KVM_S2PTE_FLAG_LOGGING_ACTIVE flag.
>>
>>> +	 * because MMU notifiers will have unmapped a huge PMD before calling
>>> +	 * ->change_pte() (which in turn calls kvm_set_spte_hva()) and therefore
>>> +	 * stage2_set_pte() never needs to clear out a huge PMD through this
>>> +	 * calling path.
>>> +	 */
>>> +
>>> +	stage2_set_pte(kvm, NULL, gpa, pte, 0);
>>>  }
>>>  
>>>  
>>> -- 
>>> 1.7.9.5
>>>
> 
