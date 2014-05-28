From: m.smarduch@samsung.com (Mario Smarduch)
Date: Wed, 28 May 2014 10:55:54 -0700
Subject: [PATCH v6 4/4] add 2nd stage page fault handling during live
 migration
In-Reply-To: <20140528080957.GH16428@lvm>
References: <1400178451-4984-1-git-send-email-m.smarduch@samsung.com>
 <1400178451-4984-5-git-send-email-m.smarduch@samsung.com>
 <20140527201945.GD16428@lvm> <53853C2F.8080003@samsung.com>
 <20140528080957.GH16428@lvm>
Message-ID: <5386232A.3050602@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/28/2014 01:09 AM, Christoffer Dall wrote:
> On Tue, May 27, 2014 at 06:30:23PM -0700, Mario Smarduch wrote:
>> On 05/27/2014 01:19 PM, Christoffer Dall wrote:
>>> On Thu, May 15, 2014 at 11:27:31AM -0700, Mario Smarduch wrote:
>>>> This patch adds support for handling 2nd stage page faults during migration,
>>>> it disables faulting in huge pages, and splits up existing huge pages.
>>>>
>>>> Signed-off-by: Mario Smarduch <m.smarduch@samsung.com>
>>>> ---
>>>>  arch/arm/kvm/mmu.c |   36 ++++++++++++++++++++++++++++++++++--
>>>>  1 file changed, 34 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
>>>> index b939312..10e7bf6 100644
>>>> --- a/arch/arm/kvm/mmu.c
>>>> +++ b/arch/arm/kvm/mmu.c
>>>> @@ -1002,6 +1002,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>>>>  	struct kvm_mmu_memory_cache *memcache = &vcpu->arch.mmu_page_cache;
>>>>  	struct vm_area_struct *vma;
>>>>  	pfn_t pfn;
>>>> +	bool migration_active;
>>>>  
>>>>  	write_fault = kvm_is_write_fault(kvm_vcpu_get_hsr(vcpu));
>>>>  	if (fault_status == FSC_PERM && !write_fault) {
>>>> @@ -1053,12 +1054,23 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>>>>  		return -EFAULT;
>>>>  
>>>>  	spin_lock(&kvm->mmu_lock);
>>>> +
>>>> +	/*
>>>> +	 * Place inside lock to prevent race condition when whole VM is being
>>>> +	 * write proteced. Prevent race of huge page install when migration is
>>>> +	 * active.
>>>> +	 */
>>>> +	migration_active = vcpu->kvm->arch.migration_in_progress;
>>>> +
>>>>  	if (mmu_notifier_retry(kvm, mmu_seq))
>>>>  		goto out_unlock;
>>>> -	if (!hugetlb && !force_pte)
>>>> +
>>>> +	/* When migrating don't spend cycles coalescing huge pages */
>>>> +	if (!hugetlb && !force_pte && !migration_active)
>>>>  		hugetlb = transparent_hugepage_adjust(&pfn, &fault_ipa);
>>>>  
>>>> -	if (hugetlb) {
>>>> +	/* During migration don't install huge pages */
>>>
>>> again, all this is not about migration per se, it's about when logging
>>> dirty pages, (which may be commonly used for migration).
>>>
>>
>> Yes that's true , I'll update but until recently (new RFC on qemu list) where
>> dirty logging is used for getting VM RSS or hot memory regions, I don't see any
>> other use case.
>>
> 
> That doesn't really matter.  KVM doesn't really know (or care) what user
> space is doing with its features; it implements a certain functionality
> behind an ABI, and that's it.  For things to be consistent and make
> sense in the kernel, you can only refer to concepts defined by KVM, not
> by how QEMU or kvmtools (or some other user space client) may use it.
> 
 
Ah yes only the exported kernel interface matters, otherwise you would
be revising forever. Got too focused on specific use case, it narrowed my 
perspective.

>>>> +	if (hugetlb && !migration_active) {
>>>>  		pmd_t new_pmd = pfn_pmd(pfn, PAGE_S2);
>>>>  		new_pmd = pmd_mkhuge(new_pmd);
>>>>  		if (writable) {
>>>> @@ -1069,6 +1081,23 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>>>>  		ret = stage2_set_pmd_huge(kvm, memcache, fault_ipa, &new_pmd);
>>>>  	} else {
>>>>  		pte_t new_pte = pfn_pte(pfn, PAGE_S2);
>>>> +
>>>> +		/*
>>>> +		 * If pmd is  mapping a huge page then split it up into
>>>> +		 * small pages, when doing live migration.
>>>> +		 */
>>>> +		if (migration_active) {
>>>> +			pmd_t *pmd;
>>>> +			if (hugetlb) {
>>>> +				pfn += pte_index(fault_ipa);
>>>> +				gfn = fault_ipa >> PAGE_SHIFT;
>>>> +			}
>>>
>>> how can you have hugetlb when we entered this else-clause conditional on
>>> having !hugetlb?
>>>
>> - if(hugetlb && !migration_active)
> 
> ah, you changed that, sorry, my bad.
> 
>>
>> forces all page faults to enter here while in migration. Huge page entries
>> are cleared and stage2_set_pte() splits the huge page, and installs the pte
>> for the fault_ipa. I placed that there since it flows with installing 
>> a pte as well as splitting a huge page. But your comment on performance
>> split up huge page vs. deferred  page faulting should move it out of here. 
>>
> 
> Why do you need to make that change?  I would think that just not
> setting hugetlb when you have dirty page logging activated should take
> care of all that you need.

During the initial write protect you occasionally release
kvm_mmu_lock you may get a write protect fault on a huge page that didn't
get cleared yet, so here the intent is to clear the pmd and let  
stage2_set_pte() create a page table and install the pte for fault_ipa.

> 
> Wrt. my comments on performance, I had a look at the x86 code, and they
> seem to take your approach.  We should probably talk more closely to
> them about their experiences.

Yes some answers are needed for that and few other issues, I'm seeing migration
on ARM complete for much higher dirty rates then x86 which is a bit fishy.

>>
>>>> +			new_pte = pfn_pte(pfn, PAGE_S2);
>>>> +			pmd = stage2_get_pmd(kvm, NULL, fault_ipa);
>>>> +			if (pmd && kvm_pmd_huge(*pmd))
>>>> +				clear_pmd_entry(kvm, pmd, fault_ipa);
>>>
>>> If we have a huge pmd entry, how did we take a fault on there?  Would
>>> that be if a different CPU inserted a huge page entry since we got here,
>>> is this what you're trying to handle?
>>>
>>> I'm confused.
>>>
>>
>> I thing this related to the above.
>>
> 
> Well, if you're taking a fault, it means that you either don't have a
> PMD or you don't have a pte.  If you have kvm_pmd_huge() you have a pmd
> and you don't need a pte, so this should never happen. Ever.
> 

So this needs to be cleared up given this is key to logging.
Cases this code handles during migration -
1. huge page fault described above - write protect fault so you breakup
   the huge page.
2. All other faults - first time access, pte write protect you again wind up in
   stage2_set_pte().

Am I missing something here?

>>>> +		}
>>>> +
>>>>  		if (writable) {
>>>>  			kvm_set_s2pte_writable(&new_pte);
>>>>  			kvm_set_pfn_dirty(pfn);
>>>> @@ -1077,6 +1106,9 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>>>>  		ret = stage2_set_pte(kvm, memcache, fault_ipa, &new_pte, false);
>>>>  	}
>>>>  
>>>> +	/* Assuming 4k pages, set one bit/page in memslot dirty_bitmap[] */
>>>
>>> Assuming? this makes me nervous.  The point is probably that it's
>>> harmless if we're not logging dirty pages, because then nobody reads teh
>>> data structure, and if we are logging, then we are mapping everything
>>> using 4K pages?
>>>
>>> It's probably clearer code-wise to condition this on whether or not we
>>> are logging dirty page, and the branch is also likely to be much faster
>>> than the function call to mark_page_dirty.
>>>
>>
>> I'm not sure I get the point. The call is always safe, you either 
>> have old copy or new copy of memory slot with dirty_bitmap set or not set.
>> The log read is done while holding kvm slots_lock.
>>
>> Is the comment related to performance, not supporting multiple page sizes,
>> or it's unsafe to call mark_page_dirty() under all circumstances, or 
>> something else? 
>>
>>
> You're always calling this, regardless if you have dirty page logging
> activated or not.  I think this is weird.

RCU is useg to set kvm->memslots, for memslot logging updates like disable 
logging you could be checking old memslot with dirty bitmap allocated or new 
one with dirty_bitmap NULL. A conditional check would not always be accurate
on the state of logging, until the srcu synchronize completes. So you may do a
few logs even after user disables logging to old memslot dirty_bitmap. But 
this way logging is stateless. 

Also to determine if memslot has logging on/off is majority
of the function, unlike user_mem_abort() some places it's called from don't
have the memslot accessed handy.

In the other direction after you turn on logging the write protect executes 
after rcu synchronize has completed. Any calls to mark_page_dirty() will be
using the newly installed memslot dirty_bitmap during and after write protect.

> 
> -Christoffer
> 
