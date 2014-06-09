From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 9 Jun 2014 20:09:38 +0200
Subject: [PATCH v7 2/4] arm: dirty page logging inital mem region write
 protect (w/no huge PUD support)
In-Reply-To: <5395F5BA.8080400@samsung.com>
References: <1401837567-5527-1-git-send-email-m.smarduch@samsung.com>
 <1401837567-5527-3-git-send-email-m.smarduch@samsung.com>
 <20140608120514.GF3279@lvm> <5395F5BA.8080400@samsung.com>
Message-ID: <20140609180938.GD1388@lvm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 09, 2014 at 10:58:18AM -0700, Mario Smarduch wrote:
> On 06/08/2014 05:05 AM, Christoffer Dall wrote:
> > On Tue, Jun 03, 2014 at 04:19:25PM -0700, Mario Smarduch wrote:
> >> Patch adds memslot support for initial write protection and split up of huge
> >> pages. This patch series assumes that huge PUDs will not be used to map VM
> >> memory. This patch depends on the unmap_range() patch, it needs to be applied
> >> first.
> >>
> >> Signed-off-by: Mario Smarduch <m.smarduch@samsung.com>
> >> ---
> >>  arch/arm/include/asm/kvm_host.h       |    2 +
> >>  arch/arm/include/asm/kvm_mmu.h        |   20 ++++++
> >>  arch/arm/include/asm/pgtable-3level.h |    1 +
> >>  arch/arm/kvm/arm.c                    |    6 ++
> >>  arch/arm/kvm/mmu.c                    |  114 +++++++++++++++++++++++++++++++++
> >>  5 files changed, 143 insertions(+)
> >>
> >> diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
> >> index 193ceaf..59565f5 100644
> >> --- a/arch/arm/include/asm/kvm_host.h
> >> +++ b/arch/arm/include/asm/kvm_host.h
> >> @@ -231,4 +231,6 @@ int kvm_perf_teardown(void);
> >>  u64 kvm_arm_timer_get_reg(struct kvm_vcpu *, u64 regid);
> >>  int kvm_arm_timer_set_reg(struct kvm_vcpu *, u64 regid, u64 value);
> >>  
> >> +void kvm_mmu_wp_memory_region(struct kvm *kvm, int slot);
> >> +
> >>  #endif /* __ARM_KVM_HOST_H__ */
> >> diff --git a/arch/arm/include/asm/kvm_mmu.h b/arch/arm/include/asm/kvm_mmu.h
> >> index 5cc0b0f..08ab5e8 100644
> >> --- a/arch/arm/include/asm/kvm_mmu.h
> >> +++ b/arch/arm/include/asm/kvm_mmu.h
> >> @@ -114,6 +114,26 @@ static inline void kvm_set_s2pmd_writable(pmd_t *pmd)
> >>  	pmd_val(*pmd) |= L_PMD_S2_RDWR;
> >>  }
> >>  
> >> +static inline void kvm_set_s2pte_readonly(pte_t *pte)
> >> +{
> >> +	pte_val(*pte) = (pte_val(*pte) & ~L_PTE_S2_RDWR) | L_PTE_S2_RDONLY;
> >> +}
> >> +
> >> +static inline bool kvm_s2pte_readonly(pte_t *pte)
> >> +{
> >> +	return (pte_val(*pte) & L_PTE_S2_RDWR) == L_PTE_S2_RDONLY;
> >> +}
> >> +
> >> +static inline void kvm_set_s2pmd_readonly(pmd_t *pmd)
> >> +{
> >> +	pmd_val(*pmd) = (pmd_val(*pmd) & ~L_PMD_S2_RDWR) | L_PMD_S2_RDONLY;
> >> +}
> >> +
> >> +static inline bool kvm_s2pmd_readonly(pmd_t *pmd)
> >> +{
> >> +	return (pmd_val(*pmd) & L_PMD_S2_RDWR) == L_PMD_S2_RDONLY;
> >> +}
> >> +
> > 
> > not crazy about the names, how about kvm_set_s2_pte_readonly etc.?
> > 
> So kvm_set_s2pte_writable(pte_t *pte) was there already just following
> that convention.
> 

ah, ok, no problem then.

> > the fact that these don't exist for arm64 makes me think it may break
> > the build for arm64 as well...
> 
> Yes will address it.
> > 
> >>  /* Open coded p*d_addr_end that can deal with 64bit addresses */
> >>  #define kvm_pgd_addr_end(addr, end)					\
> >>  ({	u64 __boundary = ((addr) + PGDIR_SIZE) & PGDIR_MASK;		\
> >> diff --git a/arch/arm/include/asm/pgtable-3level.h b/arch/arm/include/asm/pgtable-3level.h
> >> index 85c60ad..d8bb40b 100644
> >> --- a/arch/arm/include/asm/pgtable-3level.h
> >> +++ b/arch/arm/include/asm/pgtable-3level.h
> >> @@ -129,6 +129,7 @@
> >>  #define L_PTE_S2_RDONLY			(_AT(pteval_t, 1) << 6)   /* HAP[1]   */
> >>  #define L_PTE_S2_RDWR			(_AT(pteval_t, 3) << 6)   /* HAP[2:1] */
> >>  
> >> +#define L_PMD_S2_RDONLY			(_AT(pteval_t, 1) << 6)   /* HAP[1]   */
> >>  #define L_PMD_S2_RDWR			(_AT(pmdval_t, 3) << 6)   /* HAP[2:1] */
> >>  
> >>  /*
> >> diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
> >> index 3c82b37..dfd63ac 100644
> >> --- a/arch/arm/kvm/arm.c
> >> +++ b/arch/arm/kvm/arm.c
> >> @@ -242,6 +242,12 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
> >>  				   const struct kvm_memory_slot *old,
> >>  				   enum kvm_mr_change change)
> >>  {
> >> +	/*
> >> +	 * At this point memslot has been committed and the there is an
> >> +	 * allocated dirty_bitmap[] so marking of diryt pages works now on.
> > 
> > s/diryt/dirty/
> > 
> > "works now on" ?
> Ok

I don't understand what "works now on" means, so you need to clarify.

> > 
> >> +	 */
> >> +	if ((change != KVM_MR_DELETE) && (mem->flags & KVM_MEM_LOG_DIRTY_PAGES))
> >> +		kvm_mmu_wp_memory_region(kvm, mem->slot);
> >>  }
> >>  
> >>  void kvm_arch_flush_shadow_all(struct kvm *kvm)
> >> diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
> >> index ef29540..e5dff85 100644
> >> --- a/arch/arm/kvm/mmu.c
> >> +++ b/arch/arm/kvm/mmu.c
> >> @@ -760,6 +760,120 @@ static bool transparent_hugepage_adjust(pfn_t *pfnp, phys_addr_t *ipap)
> >>  	return false;
> >>  }
> >>  
> >> +
> >> +/**
> >> + * stage2_wp_pte_range - write protect PTE range
> >> + * @pmd:	pointer to pmd entry
> >> + * @addr:	range start address
> >> + * @end:	range end address
> >> + */
> >> +static void stage2_wp_pte_range(pmd_t *pmd, phys_addr_t addr, phys_addr_t end)
> >> +{
> >> +	pte_t *pte;
> >> +
> >> +	pte = pte_offset_kernel(pmd, addr);
> >> +	do {
> >> +		if (!pte_none(*pte)) {
> >> +			if (!kvm_s2pte_readonly(pte))
> >> +				kvm_set_s2pte_readonly(pte);
> > 
> > do you need the test before setting readonly?
> Probably not.
> 
> Some memory regions have hardly any pages present and sometimes
> not dirty. Was thinking of couple enhancements not to flush if
> there are no dirty pages or few dirty pages then just flush by IPA.
> But currently not doing anything with this info, leave it for
> future.
> 

hmmh, yeah, maybe it's better to keep it the way you have it now for
cache purposes, not sure.

> > 
> >> +		}
> >> +	} while (pte++, addr += PAGE_SIZE, addr != end);
> >> +}
> >> +
> >> +/**
> >> + * stage2_wp_pmd_range - write protect PMD range
> >> + * @pud:	pointer to pud entry
> >> + * @addr:	range start address
> >> + * @end:	range end address
> >> + */
> >> +static void stage2_wp_pmd_range(pud_t *pud, phys_addr_t addr, phys_addr_t end)
> >> +{
> >> +	pmd_t *pmd;
> >> +	phys_addr_t next;
> >> +
> >> +	pmd = pmd_offset(pud, addr);
> >> +
> >> +	do {
> >> +		next = kvm_pmd_addr_end(addr, end);
> >> +		if (!pmd_none(*pmd)) {
> >> +			if (kvm_pmd_huge(*pmd)) {
> >> +				/*
> >> +				 * Write Protect the PMD, give user_mem_abort()
> >> +				 * a choice to clear and fault on demand or
> >> +				 * break up the huge page.
> >> +				 */
> > 
> > I think this comment here is unnecessary.  If this function is used for
> > other purposes, it will be misleading.
> 
> Ok.
> > 
> >> +				if (!kvm_s2pmd_readonly(pmd))
> >> +					kvm_set_s2pmd_readonly(pmd);
> > 
> > same as above
> > 
> >> +			} else
> >> +				stage2_wp_pte_range(pmd, addr, next);
> >> +
> >> +		}
> >> +	} while (pmd++, addr = next, addr != end);
> >> +}
> >> +
> >> +/**
> >> + * stage2_wp_pud_range - write protect PUD range
> >> + * @kvm:	pointer to kvm structure
> >> + * @pud:	pointer to pgd entry
> >> + * @addr:	range start address
> >> + * @end:	range end address
> >> + *
> >> + * While walking the PUD range huge PUD pages are ignored, in the future this
> >> + * may need to be revisited. Determine how to handle huge PUDs when logging
> >> + * of dirty pages is enabled.
> >> + */
> >> +static void  stage2_wp_pud_range(struct kvm *kvm, pgd_t *pgd,
> >> +				phys_addr_t addr, phys_addr_t end)
> >> +{
> >> +	pud_t *pud;
> >> +	phys_addr_t next;
> >> +
> >> +	pud = pud_offset(pgd, addr);
> >> +	do {
> >> +		/* Check for contention every PUD range and release CPU */
> >> +		if (need_resched() || spin_needbreak(&kvm->mmu_lock)
> > 
> > Why do we need this here?
> > 
> >> +			cond_resched_lock(&kvm->mmu_lock);
> > 
> > is this really safe?  This will unlock the mmu_lock and all sorts of
> > stuff could happen, in between.  For example, couldn't the compiler have
> > cached the pud value here?  It feels extremely dicy.
> 
> During testing either DETECT_HUNG_TASK, LOCK_DETECTOR, LOCK_DEP I don't
> recall paniced the system with lockup detected I think the
> thread was running longer then 5s this was for a 2GB memory region. Back
> then I was splitting pages in the initial write protect. In addition
> you also starve the other vCPUs. But if you have huge VM with a huge
> memory region it can cause problems.

hmm, ok, fair enough.

> 
> But code does have a bug it relies on a stale value of the pud entry.
> need to move up where PGDs are walked and recheck the value
> of the pgd after you emerge cond_resched_lock(), will reassess.
> 

yeah, you need to check it after you've come back and taken the lock.
With 4-level page tables doing this at the pud level will probably
break, I think.

> > 
> > 
> >> +
> >> +		next = kvm_pud_addr_end(addr, end);
> >> +		/* TODO: huge PUD not supported, revisit later */
> > 
> > BUG_ON(kvm_pud_huge(*pud))  ?
> > 
> >> +		if (!pud_none(*pud))
> >> +			stage2_wp_pmd_range(pud, addr, next);
> >> +	} while (pud++, addr = next, addr != end);
> >> +}
> >> +
> >> +/**
> >> + * kvm_mmu_wp_memory_region() - initial write protected of memory region slot
> > 
> > I think this should be:
> > 
> > ... - write protect stage 2 entries for memory slot
> 
> sure.
> > 
> >> + * @kvm:	The KVM pointer
> >> + * @slot:	The memory slot to write protect
> >> + *
> >> + * Called to start logging dirty pages after memory region
> >> + * KVM_MEM_LOG_DIRTY_PAGES operation is called. After this function returns
> >> + * all present PMD and PTEs are write protected in the memory region.
> >> + * Afterwards read of dirty page log can be called. Pages not present are
> >> + * write protected on future access in user_mem_abort().
> >> + *
> >> + * Acquires kvm_mmu_lock. Called with kvm->slots_lock mutex acquired,
> >> + * serializing operations for VM memory regions.
> >> + */
> >> +void kvm_mmu_wp_memory_region(struct kvm *kvm, int slot)
> >> +{
> >> +	pgd_t *pgd;
> >> +	struct kvm_memory_slot *memslot = id_to_memslot(kvm->memslots, slot);
> >> +	phys_addr_t addr = memslot->base_gfn << PAGE_SHIFT;
> >> +	phys_addr_t end = (memslot->base_gfn + memslot->npages) << PAGE_SHIFT;
> >> +	phys_addr_t next;
> >> +
> >> +	spin_lock(&kvm->mmu_lock);
> >> +	pgd = kvm->arch.pgd + pgd_index(addr);
> >> +	do {
> >> +		next = kvm_pgd_addr_end(addr, end);
> >> +		if (pgd_present(*pgd))
> >> +			stage2_wp_pud_range(kvm, pgd, addr, next);
> >> +	} while (pgd++, addr = next, addr != end);
> > 
> > you probably want to factor out everything beginnign with pgd = (and the
> > variable declarations) into stage2_wp_range(kvm, start, end).
> 
> So I understand define another function stage2_wp_range()?
> If that's it that's fine.

yes, take the spinlock etc. in this function, but when it comes to
actually walking the tables etc. do this in a separate function - this
can then be reused for other purposes.

> > 
> >> +	kvm_flush_remote_tlbs(kvm);
> >> +	spin_unlock(&kvm->mmu_lock);
> >> +}
> >> +
> >>  static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
> >>  			  struct kvm_memory_slot *memslot,
> >>  			  unsigned long fault_status)
> >> -- 
> >> 1.7.9.5
> >>
> > 
> > This is moving in the right direction.
> > 
