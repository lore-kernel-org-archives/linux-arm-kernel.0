From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 12 Jan 2015 18:49:27 +0100
Subject: [PATCH RESEND v15 07/10] KVM: arm: page logging 2nd stage fault
 handling
In-Reply-To: <54B3F5D7.4010501@samsung.com>
References: <1420863441-32592-1-git-send-email-m.smarduch@samsung.com>
 <20150111140003.GA2722@cbox> <54B3F5D7.4010501@samsung.com>
Message-ID: <20150112174927.GM3868@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 12, 2015 at 08:27:03AM -0800, Mario Smarduch wrote:
> On 01/11/2015 06:00 AM, Christoffer Dall wrote:
> > On Fri, Jan 09, 2015 at 08:17:20PM -0800, Mario Smarduch wrote:
> >> This patch adds support for 2nd stage page fault handling while dirty page
> >> logging. On huge page faults, huge pages are dissolved to normal pages, and
> >> rebuilding of 2nd stage huge pages is blocked. In case migration is 
> >> canceled this restriction is removed and huge pages may be rebuilt again.
> >>
> >> This patch applies cleanly on top of patch series posted Dec. 15'th:
> >> https://lists.cs.columbia.edu/pipermail/kvmarm/2014-December/012826.html
> > 
> > In the future such information should also go under the ---
> > separator.
> > 
> >>
> >> Patch #11 has been dropped, and should not be applied.
> > 
> > this should go under the '---' separator too.
> Ok will keep that in mind.

basically, think of everything above the '---' separator as the commit
message you will find in 'git log' when you are trying to understand a
piece of code or bisecting an issue or the like.  For those purposes you
don't care about the mechanics of how a patch was applied, how many
iterations of the patch there were, what changed between the iterations
and so on.

> > 
> >>
> >> Signed-off-by: Mario Smarduch <m.smarduch@samsung.com>
> >> ---
> >>
> >> Change Log since last RESEND v1 --> v2:
> >> - Disallow dirty page logging of IO region - fail for initial write protect
> >>   and disable logging code in 2nd stage page fault handler.
> >> - Fixed auto spell correction errors
> >>
> >> Change Log RESEND v0 --> v1:
> >> - fixed bug exposed by new generic __get_user_pages_fast(), when region is 
> >>   writable, prevent write protection of pte on read fault
> >> - Removed marking entire huge page dirty on initial access
> >> - don't dissolve huge pages of non-writable regions
> >> - Made updates based on Christoffers comments
> >>   - renamed logging status function to memslot_is_logging()
> >>   - changed few values to bool from longs
> >>   - streamlined user_mem_abort() to eliminate extra conditional checks
> >> ---
> >>  arch/arm/kvm/mmu.c |  113 ++++++++++++++++++++++++++++++++++++++++++++++++----
> >>  1 file changed, 105 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
> >> index 73d506f..b878236 100644
> >> --- a/arch/arm/kvm/mmu.c
> >> +++ b/arch/arm/kvm/mmu.c
> >> @@ -47,6 +47,18 @@ static phys_addr_t hyp_idmap_vector;
> >>  #define kvm_pmd_huge(_x)	(pmd_huge(_x) || pmd_trans_huge(_x))
> >>  #define kvm_pud_huge(_x)	pud_huge(_x)
> >>  
> >> +#define KVM_S2PTE_FLAG_IS_IOMAP		(1UL << 0)
> >> +#define KVM_S2PTE_FLAG_LOGGING_ACTIVE	(1UL << 1)
> >> +
> >> +static bool memslot_is_logging(struct kvm_memory_slot *memslot)
> >> +{
> >> +#ifdef CONFIG_ARM
> >> +	return !!memslot->dirty_bitmap;
> >> +#else
> >> +	return false;
> >> +#endif
> >> +}
> >> +
> >>  static void kvm_tlb_flush_vmid_ipa(struct kvm *kvm, phys_addr_t ipa)
> >>  {
> >>  	/*
> >> @@ -59,6 +71,25 @@ static void kvm_tlb_flush_vmid_ipa(struct kvm *kvm, phys_addr_t ipa)
> >>  		kvm_call_hyp(__kvm_tlb_flush_vmid_ipa, kvm, ipa);
> >>  }
> >>  
> >> +/**
> >> + * stage2_dissolve_pmd() - clear and flush huge PMD entry
> >> + * @kvm:	pointer to kvm structure.
> >> + * @addr:	IPA
> >> + * @pmd:	pmd pointer for IPA
> >> + *
> >> + * Function clears a PMD entry, flushes addr 1st and 2nd stage TLBs. Marks all
> >> + * pages in the range dirty.
> >> + */
> >> +static void stage2_dissolve_pmd(struct kvm *kvm, phys_addr_t addr, pmd_t *pmd)
> >> +{
> >> +	if (!kvm_pmd_huge(*pmd))
> >> +		return;
> >> +
> >> +	pmd_clear(pmd);
> >> +	kvm_tlb_flush_vmid_ipa(kvm, addr);
> >> +	put_page(virt_to_page(pmd));
> >> +}
> >> +
> >>  static int mmu_topup_memory_cache(struct kvm_mmu_memory_cache *cache,
> >>  				  int min, int max)
> >>  {
> >> @@ -703,10 +734,13 @@ static int stage2_set_pmd_huge(struct kvm *kvm, struct kvm_mmu_memory_cache
> >>  }
> >>  
> >>  static int stage2_set_pte(struct kvm *kvm, struct kvm_mmu_memory_cache *cache,
> >> -			  phys_addr_t addr, const pte_t *new_pte, bool iomap)
> >> +			  phys_addr_t addr, const pte_t *new_pte,
> >> +			  unsigned long flags)
> >>  {
> >>  	pmd_t *pmd;
> >>  	pte_t *pte, old_pte;
> >> +	bool iomap = flags & KVM_S2PTE_FLAG_IS_IOMAP;
> >> +	bool logging_active = flags & KVM_S2PTE_FLAG_LOGGING_ACTIVE;
> >>  
> >>  	/* Create stage-2 page table mapping - Levels 0 and 1 */
> >>  	pmd = stage2_get_pmd(kvm, cache, addr);
> >> @@ -718,6 +752,13 @@ static int stage2_set_pte(struct kvm *kvm, struct kvm_mmu_memory_cache *cache,
> >>  		return 0;
> >>  	}
> >>  
> >> +	/*
> >> +	 * While dirty page logging - dissolve huge PMD, then continue on to
> >> +	 * allocate page.
> >> +	 */
> >> +	if (logging_active)
> >> +		stage2_dissolve_pmd(kvm, addr, pmd);
> >> +
> >>  	/* Create stage-2 page mappings - Level 2 */
> >>  	if (pmd_none(*pmd)) {
> >>  		if (!cache)
> >> @@ -774,7 +815,8 @@ int kvm_phys_addr_ioremap(struct kvm *kvm, phys_addr_t guest_ipa,
> >>  		if (ret)
> >>  			goto out;
> >>  		spin_lock(&kvm->mmu_lock);
> >> -		ret = stage2_set_pte(kvm, &cache, addr, &pte, true);
> >> +		ret = stage2_set_pte(kvm, &cache, addr, &pte,
> >> +						KVM_S2PTE_FLAG_IS_IOMAP);
> >>  		spin_unlock(&kvm->mmu_lock);
> >>  		if (ret)
> >>  			goto out;
> >> @@ -1002,6 +1044,8 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
> >>  	pfn_t pfn;
> >>  	pgprot_t mem_type = PAGE_S2;
> >>  	bool fault_ipa_uncached;
> >> +	bool can_set_pte_rw = true;
> >> +	unsigned long set_pte_flags = 0;
> >>  
> >>  	write_fault = kvm_is_write_fault(vcpu);
> >>  	if (fault_status == FSC_PERM && !write_fault) {
> >> @@ -1009,6 +1053,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
> >>  		return -EFAULT;
> >>  	}
> >>  
> >> +
> > 
> > stray whitespace change?
> Got it.
> > 
> >>  	/* Let's check if we will get back a huge page backed by hugetlbfs */
> >>  	down_read(&current->mm->mmap_sem);
> >>  	vma = find_vma_intersection(current->mm, hva, hva + 1);
> >> @@ -1059,12 +1104,35 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
> >>  	if (is_error_pfn(pfn))
> >>  		return -EFAULT;
> >>  
> >> -	if (kvm_is_device_pfn(pfn))
> >> +	if (kvm_is_device_pfn(pfn)) {
> >>  		mem_type = PAGE_S2_DEVICE;
> >> +		set_pte_flags = KVM_S2PTE_FLAG_IS_IOMAP;
> >> +	}
> >>  
> >>  	spin_lock(&kvm->mmu_lock);
> >>  	if (mmu_notifier_retry(kvm, mmu_seq))
> >>  		goto out_unlock;
> >> +
> >> +	/*
> >> +	 * When logging is enabled general page fault handling changes:
> >> +	 * -  Writable huge pages are dissolved on a read or write fault.
> > 
> > why dissolve huge pages on a read fault?
> 
> What I noticed on write you would dissolve, on read you
> rebuild THPs, flip back and forth like that, performance
> & convergence was really bad.

ah, that makes sense, we should probably indicate that reasoning
somehow.  In fact, what threw me off was the use of the word "dissolve
huge pages" which is not really what you're doing on a read fault, there
you are just never adjusting to huge pages.

I'm wondering why that would slow things down much though, the only cost
would be the extra tlb invalidation and replacing the PMD on a
subsequent write fault, but I trust your numbers nevertheless.

> > 
> >> +	 * -  pte's are not allowed write permission on a read fault to
> >> +	 *    writable region so future writes can be marked dirty
> > 
> > new line
> ok.
> > 
> >> +	 * Access to non-writable region is unchanged, and logging of IO
> >> +	 * regions is not allowed.
> >> +	 */
> >> +	if (memslot_is_logging(memslot) && writable) {
> >> +		set_pte_flags = KVM_S2PTE_FLAG_LOGGING_ACTIVE;
> >> +		if (hugetlb) {
> >> +			gfn += pte_index(fault_ipa);
> >> +			pfn += pte_index(fault_ipa);
> >> +			hugetlb = false;
> >> +		}
> >> +		force_pte = true;
> > 
> > uh, not this is not what I meant, see my example (untested, partial)
> > patch in the end of this mail.
> I put some comments on your patch.
> > 
> >> +		if (!write_fault)
> >> +			can_set_pte_rw = false;
> >> +	}
> >> +
> >>  	if (!hugetlb && !force_pte)
> >>  		hugetlb = transparent_hugepage_adjust(&pfn, &fault_ipa);
> >>  
> >> @@ -1082,16 +1150,23 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
> >>  		ret = stage2_set_pmd_huge(kvm, memcache, fault_ipa, &new_pmd);
> >>  	} else {
> >>  		pte_t new_pte = pfn_pte(pfn, mem_type);
> >> -		if (writable) {
> >> +
> >> +		/*
> >> +		 * Don't set write permission, for non-writable region, and
> >> +		 * for read fault to writable region while logging.
> >> +		 */
> >> +		if (writable && can_set_pte_rw) {
> >>  			kvm_set_s2pte_writable(&new_pte);
> >>  			kvm_set_pfn_dirty(pfn);
> >>  		}
> >>  		coherent_cache_guest_page(vcpu, hva, PAGE_SIZE,
> >>  					  fault_ipa_uncached);
> >>  		ret = stage2_set_pte(kvm, memcache, fault_ipa, &new_pte,
> >> -			pgprot_val(mem_type) == pgprot_val(PAGE_S2_DEVICE));
> >> +							set_pte_flags);
> >>  	}
> >>  
> >> +	if (write_fault)
> >> +		mark_page_dirty(kvm, gfn);
> >>  
> >>  out_unlock:
> >>  	spin_unlock(&kvm->mmu_lock);
> >> @@ -1242,7 +1317,14 @@ static void kvm_set_spte_handler(struct kvm *kvm, gpa_t gpa, void *data)
> >>  {
> >>  	pte_t *pte = (pte_t *)data;
> >>  
> >> -	stage2_set_pte(kvm, NULL, gpa, pte, false);
> >> +	/*
> >> +	 * We can always call stage2_set_pte with KVM_S2PTE_FLAG_LOGGING_ACTIVE
> >> +	 * flag clear because MMU notifiers will have unmapped a huge PMD before
> >> +	 * calling ->change_pte() (which in turn calls kvm_set_spte_hva()) and
> >> +	 * therefore stage2_set_pte() never needs to clear out a huge PMD
> >> +	 * through this calling path.
> >> +	 */
> >> +	stage2_set_pte(kvm, NULL, gpa, pte, 0);
> >>  }
> >>  
> >>  
> >> @@ -1396,7 +1478,13 @@ int kvm_arch_prepare_memory_region(struct kvm *kvm,
> >>  	bool writable = !(mem->flags & KVM_MEM_READONLY);
> >>  	int ret = 0;
> >>  
> >> -	if (change != KVM_MR_CREATE && change != KVM_MR_MOVE)
> >> +	/*
> >> +	 * Let - enable of dirty page logging through, later check if it's for
> >> +	 * an IO region and fail.
> >> +	 */
> > 
> > I don't understand this comment or find it helpful.
> Will remove.
> > 
> >> +	if (change != KVM_MR_CREATE && change != KVM_MR_MOVE &&
> >> +		change == KVM_MR_FLAGS_ONLY &&
> >> +		!(memslot->flags & KVM_MEM_LOG_DIRTY_PAGES))
> > 
> > this looks wrong, because you can now remove all the other checks of
> > change != and you are not returning early for KVM_MR_DELETE.
> > 
> > I think you want to add a check simply for 'change != KVM_MR_FLAGS_ONLY'
> > and then after the 'return 0' check the subconditions for change ==
> > KVM_MR_FLAGS_ONLY.
> Yeah, oh boy time to get a new batch of brown bags.
> 
> I was trying to limit conditional down to add, remap and
> dirty page flag only in case some other flags get toggled
> often and waste time walking through VMAs.
> > 
> >>  		return 0;
> >>  
> >>  	/*
> >> @@ -1447,15 +1535,24 @@ int kvm_arch_prepare_memory_region(struct kvm *kvm,
> >>  			phys_addr_t pa = (vma->vm_pgoff << PAGE_SHIFT) +
> >>  					 vm_start - vma->vm_start;
> >>  
> >> -			ret = kvm_phys_addr_ioremap(kvm, gpa, pa,
> >> +			if (change != KVM_MR_FLAGS_ONLY)
> >> +				ret = kvm_phys_addr_ioremap(kvm, gpa, pa,
> >>  						    vm_end - vm_start,
> >>  						    writable);
> >> +			else
> >> +				/* IO region dirty page logging not allowed */
> >> +				return -EINVAL;
> >> +
> > 
> > this whole thing also looks weird.  I think you just need to add a check
> > before kvm_phys_addr_ioremap() for flags & KVM_MEM_LOG_DIRTY_PAGES and
> > return an error in that case (you've identified a user attempting to set
> > dirty page logging on something that points to device memory, it doesn't
> > matter at this point through which 'change' it is done).
> 
> Yes explicitly using KVM_MEM_LOG_DIRTY_PAGES is more clear.
> 
> > 
> >>  			if (ret)
> >>  				break;
> >>  		}
> >>  		hva = vm_end;
> >>  	} while (hva < reg_end);
> >>  
> >> +	/* Anything after here doesn't apply to memslot flag changes */
> >> +	if (change == KVM_MR_FLAGS_ONLY)
> >> +		return ret;
> >> +
> >>  	spin_lock(&kvm->mmu_lock);
> >>  	if (ret)
> >>  		unmap_stage2_range(kvm, mem->guest_phys_addr, mem->memory_size);
> >> -- 
> > 
> > 
> > What I meant last time around concerning user_mem_abort was more
> > something like this:
> > 
> > diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
> > index 1dc9778..38ea58e 100644
> > --- a/arch/arm/kvm/mmu.c
> > +++ b/arch/arm/kvm/mmu.c
> > @@ -935,7 +935,14 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
> >  		return -EFAULT;
> >  	}
> >  
> > -	if (is_vm_hugetlb_page(vma)) {
> > +	/*
> > +	 * Writes to pages in a memslot with logging enabled are always logged
> > +	 * on a singe page-by-page basis.
> > +	 */
> > +	if (memslot_is_logging(memslot) && write_fault)
> > +		force_pte = true;
> 
> If it's a write you take the pte route and
> dissolves huge page, if it's a read you reconstruct the
> THP that seems to yield pretty bad results.

ok, then remove the ' && write_fault' part of the clause.

> > +
> > +	if (is_vm_hugetlb_page(vma) && !force_pte) {
> >  		hugetlb = true;
> >  		gfn = (fault_ipa & PMD_MASK) >> PAGE_SHIFT;
> >  	} else {
> > @@ -976,6 +983,9 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
> >  	if (is_error_pfn(pfn))
> >  		return -EFAULT;
> >  
> > +	if (memslot_is_logging(memslot) && !write_fault)
> > +		writable = false;
> Ok reusing writable is better.
> > +
> >  	if (kvm_is_device_pfn(pfn))
> >  		mem_type = PAGE_S2_DEVICE;
> >  
> > @@ -998,15 +1008,23 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
> >  					  fault_ipa_uncached);
> >  		ret = stage2_set_pmd_huge(kvm, memcache, fault_ipa, &new_pmd);
> >  	} else {
> > +		unsigned long flags = 0;
> >  		pte_t new_pte = pfn_pte(pfn, mem_type);
> > +
> >  		if (writable) {
> >  			kvm_set_s2pte_writable(&new_pte);
> >  			kvm_set_pfn_dirty(pfn);
> >  		}
> >  		coherent_cache_guest_page(vcpu, hva, PAGE_SIZE,
> >  					  fault_ipa_uncached);
> > -		ret = stage2_set_pte(kvm, memcache, fault_ipa, &new_pte,
> > -			pgprot_val(mem_type) == pgprot_val(PAGE_S2_DEVICE));
> > +
> > +		if (pgprot_val(mem_type) == pgprot_val(PAGE_S2_DEVICE))
> > +			flags |= KVM_S2PTE_FLAG_IS_IOMAP;
> > +
> > +		if (memslot_is_logging(memslot))
> > +			flags |= KVM_S2_FLAG_LOGGING_ACTIVE;
> Now that it either IOMAP or LOGGING_ACTIVE do we need to acumulate flags?
> Although we don't know if device mappings will be handled here.
> 

so forget all I said about this in the past, I confused the code
checking for !cache with the iomap flag.

So, I think you can always safeful assume that stage2_get_pmd() gives you
something valid back when you have the LOGGING flag set, because you
always call the function with a valid cache when the LOGGING flag is
set.  It could be worth adding the following to stage2_set_pte():

VM_BUG_ON((flags & KVM_S2_FLAG_LOGGING_ACTIVE) && !cache)

As for this code, the IOMAP flag's only effect is that we return -EFAULT
if we are seeing an existing PTE for the faulting address.  This would
no longer be valid if we allow logging dirty device memory pages, so we
really need to think about if there's any conceivable use case for this?

It doesn't really make sense to me, so I would suggest that we never
enable logging for pages that return kvm_is_device_pfn().

Thanks,
-Christoffer
