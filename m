From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 11 Jun 2014 08:58:48 +0200
Subject: [PATCH v7 4/4] arm: dirty page logging 2nd stage page fault
 handling support
In-Reply-To: <53974D15.3070508@samsung.com>
References: <1401837567-5527-1-git-send-email-m.smarduch@samsung.com>
 <1401837567-5527-5-git-send-email-m.smarduch@samsung.com>
 <20140608120530.GH3279@lvm> <53974D15.3070508@samsung.com>
Message-ID: <20140611065848.GB24286@lvm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 10, 2014 at 11:23:17AM -0700, Mario Smarduch wrote:
> On 06/08/2014 05:05 AM, Christoffer Dall wrote:
> > On Tue, Jun 03, 2014 at 04:19:27PM -0700, Mario Smarduch wrote:
> >> This patch adds support for handling 2nd stage page faults during migration,
> >> it disables faulting in huge pages, and disolves huge pages to page tables.
> > 
> > s/disolves/dissolves/g
> Will do.
> > 
> >> In case migration is canceled huge pages will be used again.
> >>
> >> Signed-off-by: Mario Smarduch <m.smarduch@samsung.com>
> >> ---
> >>  arch/arm/kvm/mmu.c |   36 ++++++++++++++++++++++++++++++++++--
> >>  1 file changed, 34 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
> >> index 1c546c9..aca4fbf 100644
> >> --- a/arch/arm/kvm/mmu.c
> >> +++ b/arch/arm/kvm/mmu.c
> >> @@ -966,6 +966,8 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
> >>  	struct kvm_mmu_memory_cache *memcache = &vcpu->arch.mmu_page_cache;
> >>  	struct vm_area_struct *vma;
> >>  	pfn_t pfn;
> >> +	/* Get logging status, if dirty_bitmap is not NULL then logging is on */
> >> +	bool logging_active = !!memslot->dirty_bitmap;
> > 
> >>  
> >>  	write_fault = kvm_is_write_fault(kvm_vcpu_get_hsr(vcpu));
> >>  	if (fault_status == FSC_PERM && !write_fault) {
> >> @@ -1019,10 +1021,16 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
> >>  	spin_lock(&kvm->mmu_lock);
> >>  	if (mmu_notifier_retry(kvm, mmu_seq))
> >>  		goto out_unlock;
> >> -	if (!hugetlb && !force_pte)
> >> +
> >> +	/* When logging don't spend cycles to check for huge pages */
> > 
> > drop the comment: either explain the entire clause (which would be too
> > long) or don't explain anything.
> > 
> Ok.
> >> +	if (!hugetlb && !force_pte && !logging_active)
> > 
> > instead of having all this, can't you just change 
> > 
> > if (is_vm_hugetlb_page(vma)) to
> > if (is_vm_hugetlb_page(vma) && !logging_active)
> > 
> > then you're also not mucking around with the gfn etc.
> 
> I didn't want to modify this function too much, but if that's ok that 
> simplifies things a lot.
> 

Don't worry about the changes as much as the resulting code.  If
something requires a lot of refactoring, usually that can be handled by
splitting up renames, factoring out functions, etc. into multiple
smaller patches.

> > 
> >>  		hugetlb = transparent_hugepage_adjust(&pfn, &fault_ipa);
> >>  
> >> -	if (hugetlb) {
> >> +	/*
> >> +	 * Force all not present/perm faults to PTE handling, address both
> >> +	 * PMD and PTE faults
> >> +	 */
> > 
> > I don't understand this comment?  In which case does this apply?
> > 
> The cases I see here -
> - huge page permission fault is forced into page table code while logging
> - pte permission/not present handled by page table code as before.

Hmm, the wording doesn't really work for me.  I don't think this comment
adds anything or is required, when getting this deep into the fault
handler etc., one better understand what's going on.

The most suitable place for a comment in this work is probably in
stage2_set_pte() where you can now detect a kvm_pmd_huge(), when you add
that, you may want to add a small comment that this only happens when
logging dirty pages.

> >> +	if (hugetlb && !logging_active) {
> >>  		pmd_t new_pmd = pfn_pmd(pfn, PAGE_S2);
> >>  		new_pmd = pmd_mkhuge(new_pmd);
> >>  		if (writable) {
> >> @@ -1034,6 +1042,22 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
> >>  	} else {
> >>  		pte_t new_pte = pfn_pte(pfn, PAGE_S2);
> >>  		if (writable) {
> >> +			/*
> >> +			 * If pmd is  mapping a huge page then clear it and let
> >> +			 * stage2_set_pte() create a pte table. At the sametime
> >> +			 * you write protect the pte (PAGE_S2 pgprot_t).
> >> +			 */
> >> +			if (logging_active) {
> >> +				pmd_t *pmd;
> >> +				if (hugetlb) {
> >> +					pfn += pte_index(fault_ipa);
> >> +					gfn = fault_ipa >> PAGE_SHIFT;
> >> +					new_pte = pfn_pte(pfn, PAGE_S2);
> >> +				}
> >> +				pmd = stage2_get_pmd(kvm, NULL, fault_ipa);
> >> +				if (pmd && kvm_pmd_huge(*pmd))
> >> +					clear_pmd_entry(kvm, pmd, fault_ipa);
> >> +			}
> > 
> > now instead of all this, you just need to check for kvm_pmd_huge() in
> > stage2_set_pte() and if that's true, you clear it, and then then install
> > your new pte.
> 
> Yes this really simplifies things!
> 
> > 
> >>  			kvm_set_s2pte_writable(&new_pte);
> >>  			kvm_set_pfn_dirty(pfn);
> >>  		}
> >> @@ -1041,6 +1065,14 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
> >>  		ret = stage2_set_pte(kvm, memcache, fault_ipa, &new_pte, false);
> >>  	}
> >>  
> >> +	/*
> >> +	 * Log the dirty page in dirty_bitmap[], call regardless if logging is
> >> +	 * disabled or enabled both cases handled safely.
> >> +	 * TODO: for larger page size mark mulitple dirty page bits for each
> >> +	 *       4k page.
> >> +	 */
> >> +	if (writable)
> >> +		mark_page_dirty(kvm, gfn);
> > 
> > what if you just faulted in a page on a read which wasn't present
> > before but it happens to belong to a writeable memslot, is that page
> > then dirty? hmmm.
> > 
> A bug, must also check if it was a write fault not just that we're dealing with
> a writable region. This one could be pretty bad on performance, not to mention
> in accurate. It will be interesting to see new test results, glad you caught
> that.
> 
ok, please fix.

Thanks,
-Christoffer
