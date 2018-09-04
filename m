From: christoffer.dall@arm.com (Christoffer Dall)
Date: Tue, 4 Sep 2018 11:03:43 +0200
Subject: [PATCH] KVM: arm/arm64: Clean dcache to PoC when changing PTE
 due to CoW
In-Reply-To: <87a7oy7amd.fsf@e105922-lin.cambridge.arm.com>
References: <20180823153342.158230-1-marc.zyngier@arm.com>
 <20180830122052.GD4029@e113682-lin.lund.arm.com>
 <87a7oy7amd.fsf@e105922-lin.cambridge.arm.com>
Message-ID: <20180904090343.GN4029@e113682-lin.lund.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 03, 2018 at 06:29:30PM +0100, Punit Agrawal wrote:
> Christoffer Dall <christoffer.dall@arm.com> writes:
> 
> > [Adding Andrea and Steve in CC]
> >
> > On Thu, Aug 23, 2018 at 04:33:42PM +0100, Marc Zyngier wrote:
> >> When triggering a CoW, we unmap the RO page via an MMU notifier
> >> (invalidate_range_start), and then populate the new PTE using another
> >> one (change_pte). In the meantime, we'll have copied the old page
> >> into the new one.
> >> 
> >> The problem is that the data for the new page is sitting in the
> >> cache, and should the guest have an uncached mapping to that page
> >> (or its MMU off), following accesses will bypass the cache.
> >> 
> >> In a way, this is similar to what happens on a translation fault:
> >> We need to clean the page to the PoC before mapping it. So let's just
> >> do that.
> >> 
> >> This fixes a KVM unit test regression observed on a HiSilicon platform,
> >> and subsequently reproduced on Seattle.
> >> 
> >> Fixes: a9c0e12ebee5 ("KVM: arm/arm64: Only clean the dcache on translation fault")
> >> Reported-by: Mike Galbraith <efault@gmx.de>
> >> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> >> ---
> >>  virt/kvm/arm/mmu.c | 9 ++++++++-
> >>  1 file changed, 8 insertions(+), 1 deletion(-)
> >> 
> >> diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
> >> index 1d90d79706bd..287c8e274655 100644
> >> --- a/virt/kvm/arm/mmu.c
> >> +++ b/virt/kvm/arm/mmu.c
> >> @@ -1811,13 +1811,20 @@ static int kvm_set_spte_handler(struct kvm *kvm, gpa_t gpa, u64 size, void *data
> >>  void kvm_set_spte_hva(struct kvm *kvm, unsigned long hva, pte_t pte)
> >>  {
> >>  	unsigned long end = hva + PAGE_SIZE;
> >> +	kvm_pfn_t pfn = pte_pfn(pte);
> >>  	pte_t stage2_pte;
> >>  
> >>  	if (!kvm->arch.pgd)
> >>  		return;
> >>  
> >>  	trace_kvm_set_spte_hva(hva);
> >> -	stage2_pte = pfn_pte(pte_pfn(pte), PAGE_S2);
> >> +
> >> +	/*
> >> +	 * We've moved a page around, probably through CoW, so let's treat
> >> +	 * just like a translation fault and clean the cache to the PoC.
> >> +	 */
> >> +	clean_dcache_guest_page(pfn, PAGE_SIZE);
> >> +	stage2_pte = pfn_pte(pfn, PAGE_S2);
> >>  	handle_hva_to_gpa(kvm, hva, end, &kvm_set_spte_handler, &stage2_pte);
> >>  }
> >
> > How does this work for pmd mappings?
> 
> kvm_set_spte_hva() isn't called for PMD mappings. But...
> 
> >
> > Are we guaranteed that a pmd mapping (hugetlbfs or THP) is split before
> > a CoW happens?
> >
> > Steve tells me that we share THP mappings on fork and that we back THPs
> > by a zero page, so CoW with THP should be possible.
> >
> 
> ...the problem seems to affect handling write permission faults for CoW
> or zero pages.
> 
> The memory gets unmapped at stage 2 due to the invalidate notifier (in
> hugetlb_cow() for hugetlbfs and do_huge_pmd_wp_page() for THP) 

So just to make sure I get this right.  For a pte CoW, Linux calls the
set_spte function to simply change the pte mapping, without doing any
unmapping at stage 2, but with pmd, we unmap and wait to take another
fault as an alternative method?

Why the two different approaches depending on the mapping size?

> while the
> cache maintenance for the newly allocated page will be skipped due to
> the !FSC_PERM. 

If the above holds, then the subsequent fault would be similar to any
other fault which should work via the normal mechanism (dcache clean +
XN on fault, icache invalidation on permission fault).

> 
> Hmm... smells like there might be a problem here. I'll try and put
> together a fix.
> 

It's not clear to me if we have a problem, or just different ways of
handling the PMD vs. PTE CoW case?


Thanks,

    Christoffer
