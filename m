From: m.smarduch@samsung.com (Mario Smarduch)
Date: Fri, 14 Nov 2014 10:53:01 -0800
Subject: [PATCH v14 7/7] KVM: arm: page logging 2nd stage fault handling
In-Reply-To: <546631A0.4050301@arm.com>
References: <1415930268-7674-1-git-send-email-m.smarduch@samsung.com>
 <1415930268-7674-8-git-send-email-m.smarduch@samsung.com>
 <546631A0.4050301@arm.com>
Message-ID: <54664F8D.70100@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/14/2014 08:45 AM, Marc Zyngier wrote:
> Hi Mario,
> 
> On 14/11/14 01:57, Mario Smarduch wrote:
>> This patch adds support for handling 2nd stage page faults during migration,
>> it disables faulting in huge pages, and dissolves huge pages to page tables.
>> In case migration is canceled huge pages are used again.
>>
>> Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
>> Signed-off-by: Mario Smarduch <m.smarduch@samsung.com>
>> ---
>>  arch/arm/kvm/mmu.c |   56 ++++++++++++++++++++++++++++++++++++++++++++--------
>>  1 file changed, 48 insertions(+), 8 deletions(-)
>>
>> diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
>> index 8137455..ff88e5b 100644
>> --- a/arch/arm/kvm/mmu.c
>> +++ b/arch/arm/kvm/mmu.c
>> @@ -47,6 +47,20 @@ static phys_addr_t hyp_idmap_vector;
>>  #define kvm_pmd_huge(_x)	(pmd_huge(_x) || pmd_trans_huge(_x))
>>  #define kvm_pud_huge(_x)	pud_huge(_x)
>>  
>> +#define IOMAP_ATTR		0x1
>> +#define LOGGING_ACTIVE		0x2
>> +#define SET_SPTE_FLAGS(l, i)	((l) << (LOGGING_ACTIVE - 1) | \
>> +				 (i) << (IOMAP_ATTR - 1))
> 
> I suffered a minor brain haemorrhage on this one. How about something
> that is more in line with what's done almost everywhere else:

Hope it wasn't that serious, a huge blow to the project and jazz :)

I tried to optimize a little, but I see your point I'll resend
this one thanks for the tag.

(Btw email server issues hopefully this is the only response)

- Mario
> 
> #define KVM_S2PTE_FLAG_IS_IOMAP		(1UL << 0)
> #define KVM_S2PTE_FLAG_LOGGING_ACTIVE	(1UL << 1)
> 
>> +static bool kvm_get_logging_state(struct kvm_memory_slot *memslot)
>> +{
>> +#ifdef CONFIG_ARM
>> +	return !!memslot->dirty_bitmap;
>> +#else
>> +	return false;
>> +#endif
>> +}
>> +
>>  static void kvm_tlb_flush_vmid_ipa(struct kvm *kvm, phys_addr_t ipa)
>>  {
>>  	/*
>> @@ -626,10 +640,13 @@ static int stage2_set_pmd_huge(struct kvm *kvm, struct kvm_mmu_memory_cache
>>  }
>>  
>>  static int stage2_set_pte(struct kvm *kvm, struct kvm_mmu_memory_cache *cache,
>> -			  phys_addr_t addr, const pte_t *new_pte, bool iomap)
>> +			  phys_addr_t addr, const pte_t *new_pte,
>> +			  unsigned long flags)
>>  {
>>  	pmd_t *pmd;
>>  	pte_t *pte, old_pte;
>> +	bool iomap = flags & IOMAP_ATTR;
>> +	bool logging_active = flags & LOGGING_ACTIVE;
> 
> If you convert these two variables to be 'unsigned long'...
> 
>>  
>>  	/* Create stage-2 page table mapping - Level 1 */
>>  	pmd = stage2_get_pmd(kvm, cache, addr);
>> @@ -641,6 +658,18 @@ static int stage2_set_pte(struct kvm *kvm, struct kvm_mmu_memory_cache *cache,
>>  		return 0;
>>  	}
>>  
>> +	/*
>> +	 * While dirty memory logging, clear PMD entry for huge page and split
>> +	 * into smaller pages, to track dirty memory at page granularity.
>> +	 */
>> +	if (logging_active && kvm_pmd_huge(*pmd)) {
>> +		phys_addr_t ipa = pmd_pfn(*pmd) << PAGE_SHIFT;
>> +
>> +		pmd_clear(pmd);
>> +		kvm_tlb_flush_vmid_ipa(kvm, ipa);
>> +		put_page(virt_to_page(pmd));
>> +	}
>> +
>>  	/* Create stage-2 page mappings - Level 2 */
>>  	if (pmd_none(*pmd)) {
>>  		if (!cache)
>> @@ -693,7 +722,7 @@ int kvm_phys_addr_ioremap(struct kvm *kvm, phys_addr_t guest_ipa,
>>  		if (ret)
>>  			goto out;
>>  		spin_lock(&kvm->mmu_lock);
>> -		ret = stage2_set_pte(kvm, &cache, addr, &pte, true);
>> +		ret = stage2_set_pte(kvm, &cache, addr, &pte, IOMAP_ATTR);
>>  		spin_unlock(&kvm->mmu_lock);
>>  		if (ret)
>>  			goto out;
>> @@ -908,6 +937,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>>  	struct vm_area_struct *vma;
>>  	pfn_t pfn;
>>  	pgprot_t mem_type = PAGE_S2;
>> +	bool logging_active = kvm_get_logging_state(memslot);
> 
> and this to be:
> 	unsigned long logging_active = 0;
> 	if (kvm_get_logging_state(memslot))
> 		logging_active = KVM_S2PTE_FLAG_LOGGING_ACTIVE;
> 
>>  
>>  	write_fault = kvm_is_write_fault(kvm_vcpu_get_hsr(vcpu));
>>  	if (fault_status == FSC_PERM && !write_fault) {
>> @@ -918,7 +948,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>>  	/* Let's check if we will get back a huge page backed by hugetlbfs */
>>  	down_read(&current->mm->mmap_sem);
>>  	vma = find_vma_intersection(current->mm, hva, hva + 1);
>> -	if (is_vm_hugetlb_page(vma)) {
>> +	if (is_vm_hugetlb_page(vma) && !logging_active) {
>>  		hugetlb = true;
>>  		gfn = (fault_ipa & PMD_MASK) >> PAGE_SHIFT;
>>  	} else {
>> @@ -964,7 +994,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>>  	spin_lock(&kvm->mmu_lock);
>>  	if (mmu_notifier_retry(kvm, mmu_seq))
>>  		goto out_unlock;
>> -	if (!hugetlb && !force_pte)
>> +	if (!hugetlb && !force_pte && !logging_active)
>>  		hugetlb = transparent_hugepage_adjust(&pfn, &fault_ipa);
>>  
>>  	if (hugetlb) {
>> @@ -978,16 +1008,18 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>>  		ret = stage2_set_pmd_huge(kvm, memcache, fault_ipa, &new_pmd);
>>  	} else {
>>  		pte_t new_pte = pfn_pte(pfn, mem_type);
>> +		unsigned long flags = SET_SPTE_FLAGS(logging_active,
>> +				mem_type == PAGE_S2_DEVICE);
> 
> ... you can convert this to:
> 
> 		unsigned long flags = logging_active;
> 		if (mem_type == PAGE_S2_DEVICE)
> 			flags |= KVM_S2PTE_FLAG_IS_IOMAP;
> 
> Yes, this is more verbose, but I can decipher it without any effort.
> Call me lazy! ;-)
> 
>>  		if (writable) {
>>  			kvm_set_s2pte_writable(&new_pte);
>>  			kvm_set_pfn_dirty(pfn);
>>  		}
>>  		coherent_cache_guest_page(vcpu, hva, PAGE_SIZE);
>> -		ret = stage2_set_pte(kvm, memcache, fault_ipa, &new_pte,
>> -				     mem_type == PAGE_S2_DEVICE);
>> +		ret = stage2_set_pte(kvm, memcache, fault_ipa, &new_pte, flags);
>>  	}
>>  
>> -
>> +	if (write_fault)
>> +		mark_page_dirty(kvm, gfn);
>>  out_unlock:
>>  	spin_unlock(&kvm->mmu_lock);
>>  	kvm_release_pfn_clean(pfn);
>> @@ -1137,7 +1169,15 @@ static void kvm_set_spte_handler(struct kvm *kvm, gpa_t gpa, void *data)
>>  {
>>  	pte_t *pte = (pte_t *)data;
>>  
>> -	stage2_set_pte(kvm, NULL, gpa, pte, false);
>> +	/*
>> +	 * We can always call stage2_set_pte with logging_active == false,
>> +	 * because MMU notifiers will have unmapped a huge PMD before calling
>> +	 * ->change_pte() (which in turn calls kvm_set_spte_hva()) and therefore
>> +	 * stage2_set_pte() never needs to clear out a huge PMD through this
>> +	 * calling path.
>> +	 */
>> +
>> +	stage2_set_pte(kvm, NULL, gpa, pte, 0);
>>  }
> 
> 
> Other than this:
> 
> Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
> 
> Thanks,
> 
> 	M.
> 
