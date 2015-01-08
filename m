From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Thu, 8 Jan 2015 12:32:21 +0100
Subject: [PATCH v15 11/11] KVM: arm/arm64: Add support to dissolve huge PUD
In-Reply-To: <54ADF2F6.8060906@samsung.com>
References: <1418628488-3696-1-git-send-email-m.smarduch@samsung.com>
 <1418628488-3696-12-git-send-email-m.smarduch@samsung.com>
 <20150107130514.GD21092@cbox> <54ADF2F6.8060906@samsung.com>
Message-ID: <20150108113221.GK21092@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 07, 2015 at 07:01:10PM -0800, Mario Smarduch wrote:
> On 01/07/2015 05:05 AM, Christoffer Dall wrote:
> > On Sun, Dec 14, 2014 at 11:28:08PM -0800, Mario Smarduch wrote:
> >> This patch adds the same support for PUD huge page as for PMD. Huge PUD is 
> >> write protected for initial memory region write protection. Code to dissolve 
> >> huge PUD is supported in user_mem_abort(). At this time this code has not been 
> >> tested, but similar approach to current ARMv8 page logging test is in work,
> >> limiting kernel memory and mapping in 1 or 2GB into Guest address space on a 
> >> 4k page/48 bit host, some host kernel test code needs to be added to detect
> >> page fault to this region and side step general processing. Also similar to 
> >> PMD case all pages in range are marked dirty when PUD entry is cleared.
> > 
> > the note about this code being untested shouldn't be part of the commit
> > message but after the '---' separater or in the cover letter I think.
> 
> Ah ok.
> > 
> >>
> >> Signed-off-by: Mario Smarduch <m.smarduch@samsung.com>
> >> ---
> >>  arch/arm/include/asm/kvm_mmu.h         |  8 +++++
> >>  arch/arm/kvm/mmu.c                     | 64 ++++++++++++++++++++++++++++++++--
> >>  arch/arm64/include/asm/kvm_mmu.h       |  9 +++++
> >>  arch/arm64/include/asm/pgtable-hwdef.h |  3 ++
> >>  4 files changed, 81 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/arch/arm/include/asm/kvm_mmu.h b/arch/arm/include/asm/kvm_mmu.h
> >> index dda0046..703d04d 100644
> >> --- a/arch/arm/include/asm/kvm_mmu.h
> >> +++ b/arch/arm/include/asm/kvm_mmu.h
> >> @@ -133,6 +133,14 @@ static inline bool kvm_s2pmd_readonly(pmd_t *pmd)
> >>  	return (pmd_val(*pmd) & L_PMD_S2_RDWR) == L_PMD_S2_RDONLY;
> >>  }
> >>  
> >> +static inline void kvm_set_s2pud_readonly(pud_t *pud)
> >> +{
> >> +}
> >> +
> >> +static inline bool kvm_s2pud_readonly(pud_t *pud)
> >> +{
> >> +	return false;
> >> +}
> >>  
> >>  /* Open coded p*d_addr_end that can deal with 64bit addresses */
> >>  #define kvm_pgd_addr_end(addr, end)					\
> >> diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
> >> index 59003df..35840fb 100644
> >> --- a/arch/arm/kvm/mmu.c
> >> +++ b/arch/arm/kvm/mmu.c
> >> @@ -109,6 +109,55 @@ void stage2_dissolve_pmd(struct kvm *kvm, phys_addr_t addr, pmd_t *pmd)
> >>  	}
> >>  }
> >>  
> >> +/**
> >> +  * stage2_find_pud() - find a PUD entry
> >> +  * @kvm:	pointer to kvm structure.
> >> +  * @addr:	IPA address
> >> +  *
> >> +  * Return address of PUD entry or NULL if not allocated.
> >> +  */
> >> +static pud_t *stage2_find_pud(struct kvm *kvm, phys_addr_t addr)
> > 
> > why can't you reuse stage2_get_pud here?
> 
> stage2_get_* allocate intermediate tables, when they're called
> you know intermediate tables are needed to install a pmd or pte.
> But currently there is no way to tell we faulted in a PUD
> region, this code just checks if a PUD is set, and not
> allocate intermediate tables along the way.

hmmm, but if we get here it means that we are faulting on an address, so
we need to map something at that address regardless, so I don't see the
problem in using stage2_get_pud.

> 
> Overall not sure if this is in preparation for a new huge page (PUD sized)?
> Besides developing a custom test, not sure how to use this
> and determine we fault in a PUD region? Generic 'gup'
> code does handle PUDs but perhaps some arch. has PUD sized
> huge pages.
> 

When Marc and I discussed this we came to the conclusion that we wanted
code to support this code path for when huge PUDs were suddently used,
but now when I see the code, I am realizing that adding huge PUD support
on the Stage-2 level requires a lot of changes to this file, so I really
don't think we need to handle it at the point after all.

> > 
> >> +{
> >> +	pgd_t *pgd;
> >> +
> >> +	pgd = kvm->arch.pgd + pgd_index(addr);
> >> +	if (pgd_none(*pgd))
> >> +		return NULL;
> >> +
> >> +	return pud_offset(pgd, addr);
> >> +}
> >> +
> >> +/**
> >> + * stage2_dissolve_pud() - clear and flush huge PUD entry
> >> + * @kvm:	pointer to kvm structure.
> >> + * @addr	IPA
> >> + *
> >> + * Function clears a PUD entry, flushes addr 1st and 2nd stage TLBs. Marks all
> >> + * pages in the range dirty.
> >> + */
> >> +void stage2_dissolve_pud(struct kvm *kvm, phys_addr_t addr)
> >> +{
> >> +	pud_t *pud;
> >> +	gfn_t gfn;
> >> +	long i;
> >> +
> >> +	pud = stage2_find_pud(kvm, addr);
> >> +	if (pud && !pud_none(*pud) && kvm_pud_huge(*pud)) {
> > 
> > I'm just thinking here, why do we need to check if we get a valid pud
> > back here, but we don't need the equivalent check in dissolve_pmd from
> > patch 7?
> 
> kvm_pud_huge() doesn't check bit 0 for invalid entry, but
> pud_none() is not the right way to check either, maybe pud_bad()
> first. Nothing is done in patch 7 since the pmd is retrieved from
> stage2_get_pmd().
> 

hmmm, but stage2_get_pmd() can return a NULL pointer if you have the
IOMAP flag set...

> > 
> > I think the rationale is that it should never happen because we never
> > call these functions with the logging and iomap flags at the same
> > time...
> 
> I'm little lost here, not sure how it's related to above.
> But I think a VFIO device will have a memslot and
> it would be possible to enable logging. But to what
> end I'm not sure.
> 

As I said above, if you call the set_s2pte function with the IOMAP and
LOGGING flags set, then you'll end up in a situation where you can get a
NULL pointer back from stage2_get_pmd() but you're never checking
against that.

Now, this raises an interesting point, we have now added code that
prevents faults from ever happening on device maps, but introducing a
path here where the user can set logging on a memslot with device memory
regions, which introduces write faults on such regions.  My gut feeling
is that we should avoid that from ever happening, and not allow this
function to be called with both flags set.

> > 
> >> +		pud_clear(pud);
> >> +		kvm_tlb_flush_vmid_ipa(kvm, addr);
> >> +		put_page(virt_to_page(pud));
> >> +#ifdef CONFIG_SMP
> >> +		gfn = (addr & PUD_MASK) >> PAGE_SHIFT;
> >> +		/*
> >> +		 * Mark all pages in PUD range dirty, in case other
> >> +		 * CPUs are  writing to it.
> >> +		 */
> >> +		for (i = 0; i < PTRS_PER_PUD * PTRS_PER_PMD; i++)
> >> +			mark_page_dirty(kvm, gfn + i);
> >> +#endif
> >> +	}
> >> +}
> >> +
> >>  static int mmu_topup_memory_cache(struct kvm_mmu_memory_cache *cache,
> >>  				  int min, int max)
> >>  {
> >> @@ -761,6 +810,13 @@ static int stage2_set_pte(struct kvm *kvm, struct kvm_mmu_memory_cache *cache,
> >>  	unsigned long iomap = flags & KVM_S2PTE_FLAG_IS_IOMAP;
> >>  	unsigned long logging_active = flags & KVM_S2PTE_FLAG_LOGGING_ACTIVE;
> >>  
> >> +	/*
> >> +	 * While dirty page logging - dissolve huge PUD, then continue on to
> >> +	 * allocate page.
> >> +	 */
> >> +	if (logging_active)
> >> +		stage2_dissolve_pud(kvm, addr);
> >> +
> > 
> > I know I asked for this, but what's the purpose really when we never set
> > a huge stage-2 pud, shouldn't we just WARN/BUG if we encounter one?
> > 
> > Marc, you may have some thoughts here...
> 
> Not sure myself what's the vision for PUD support.
> 

with 4-level paging on aarch64, we use PUDs but we haven't added any
code to insert huge PUDs (only regular ones) on the stage-2 page tables,
even if the host kernel happens to suddenly support huge PUDs for the
stage-1 page tables, which is what I think we were trying to address.


So I really think we can drop this whole patch.  As I said, really sorry
about this one!

-Christoffer
