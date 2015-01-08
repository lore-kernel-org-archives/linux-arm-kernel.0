From: m.smarduch@samsung.com (Mario Smarduch)
Date: Wed, 07 Jan 2015 19:01:10 -0800
Subject: [PATCH v15 11/11] KVM: arm/arm64: Add support to dissolve huge PUD
In-Reply-To: <20150107130514.GD21092@cbox>
References: <1418628488-3696-1-git-send-email-m.smarduch@samsung.com>
 <1418628488-3696-12-git-send-email-m.smarduch@samsung.com>
 <20150107130514.GD21092@cbox>
Message-ID: <54ADF2F6.8060906@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/07/2015 05:05 AM, Christoffer Dall wrote:
> On Sun, Dec 14, 2014 at 11:28:08PM -0800, Mario Smarduch wrote:
>> This patch adds the same support for PUD huge page as for PMD. Huge PUD is 
>> write protected for initial memory region write protection. Code to dissolve 
>> huge PUD is supported in user_mem_abort(). At this time this code has not been 
>> tested, but similar approach to current ARMv8 page logging test is in work,
>> limiting kernel memory and mapping in 1 or 2GB into Guest address space on a 
>> 4k page/48 bit host, some host kernel test code needs to be added to detect
>> page fault to this region and side step general processing. Also similar to 
>> PMD case all pages in range are marked dirty when PUD entry is cleared.
> 
> the note about this code being untested shouldn't be part of the commit
> message but after the '---' separater or in the cover letter I think.

Ah ok.
> 
>>
>> Signed-off-by: Mario Smarduch <m.smarduch@samsung.com>
>> ---
>>  arch/arm/include/asm/kvm_mmu.h         |  8 +++++
>>  arch/arm/kvm/mmu.c                     | 64 ++++++++++++++++++++++++++++++++--
>>  arch/arm64/include/asm/kvm_mmu.h       |  9 +++++
>>  arch/arm64/include/asm/pgtable-hwdef.h |  3 ++
>>  4 files changed, 81 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/arm/include/asm/kvm_mmu.h b/arch/arm/include/asm/kvm_mmu.h
>> index dda0046..703d04d 100644
>> --- a/arch/arm/include/asm/kvm_mmu.h
>> +++ b/arch/arm/include/asm/kvm_mmu.h
>> @@ -133,6 +133,14 @@ static inline bool kvm_s2pmd_readonly(pmd_t *pmd)
>>  	return (pmd_val(*pmd) & L_PMD_S2_RDWR) == L_PMD_S2_RDONLY;
>>  }
>>  
>> +static inline void kvm_set_s2pud_readonly(pud_t *pud)
>> +{
>> +}
>> +
>> +static inline bool kvm_s2pud_readonly(pud_t *pud)
>> +{
>> +	return false;
>> +}
>>  
>>  /* Open coded p*d_addr_end that can deal with 64bit addresses */
>>  #define kvm_pgd_addr_end(addr, end)					\
>> diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
>> index 59003df..35840fb 100644
>> --- a/arch/arm/kvm/mmu.c
>> +++ b/arch/arm/kvm/mmu.c
>> @@ -109,6 +109,55 @@ void stage2_dissolve_pmd(struct kvm *kvm, phys_addr_t addr, pmd_t *pmd)
>>  	}
>>  }
>>  
>> +/**
>> +  * stage2_find_pud() - find a PUD entry
>> +  * @kvm:	pointer to kvm structure.
>> +  * @addr:	IPA address
>> +  *
>> +  * Return address of PUD entry or NULL if not allocated.
>> +  */
>> +static pud_t *stage2_find_pud(struct kvm *kvm, phys_addr_t addr)
> 
> why can't you reuse stage2_get_pud here?

stage2_get_* allocate intermediate tables, when they're called
you know intermediate tables are needed to install a pmd or pte.
But currently there is no way to tell we faulted in a PUD
region, this code just checks if a PUD is set, and not
allocate intermediate tables along the way.

Overall not sure if this is in preparation for a new huge page (PUD sized)?
Besides developing a custom test, not sure how to use this
and determine we fault in a PUD region? Generic 'gup'
code does handle PUDs but perhaps some arch. has PUD sized
huge pages.

> 
>> +{
>> +	pgd_t *pgd;
>> +
>> +	pgd = kvm->arch.pgd + pgd_index(addr);
>> +	if (pgd_none(*pgd))
>> +		return NULL;
>> +
>> +	return pud_offset(pgd, addr);
>> +}
>> +
>> +/**
>> + * stage2_dissolve_pud() - clear and flush huge PUD entry
>> + * @kvm:	pointer to kvm structure.
>> + * @addr	IPA
>> + *
>> + * Function clears a PUD entry, flushes addr 1st and 2nd stage TLBs. Marks all
>> + * pages in the range dirty.
>> + */
>> +void stage2_dissolve_pud(struct kvm *kvm, phys_addr_t addr)
>> +{
>> +	pud_t *pud;
>> +	gfn_t gfn;
>> +	long i;
>> +
>> +	pud = stage2_find_pud(kvm, addr);
>> +	if (pud && !pud_none(*pud) && kvm_pud_huge(*pud)) {
> 
> I'm just thinking here, why do we need to check if we get a valid pud
> back here, but we don't need the equivalent check in dissolve_pmd from
> patch 7?

kvm_pud_huge() doesn't check bit 0 for invalid entry, but
pud_none() is not the right way to check either, maybe pud_bad()
first. Nothing is done in patch 7 since the pmd is retrieved from
stage2_get_pmd().

> 
> I think the rationale is that it should never happen because we never
> call these functions with the logging and iomap flags at the same
> time...

I'm little lost here, not sure how it's related to above.
But I think a VFIO device will have a memslot and
it would be possible to enable logging. But to what
end I'm not sure.

> 
>> +		pud_clear(pud);
>> +		kvm_tlb_flush_vmid_ipa(kvm, addr);
>> +		put_page(virt_to_page(pud));
>> +#ifdef CONFIG_SMP
>> +		gfn = (addr & PUD_MASK) >> PAGE_SHIFT;
>> +		/*
>> +		 * Mark all pages in PUD range dirty, in case other
>> +		 * CPUs are  writing to it.
>> +		 */
>> +		for (i = 0; i < PTRS_PER_PUD * PTRS_PER_PMD; i++)
>> +			mark_page_dirty(kvm, gfn + i);
>> +#endif
>> +	}
>> +}
>> +
>>  static int mmu_topup_memory_cache(struct kvm_mmu_memory_cache *cache,
>>  				  int min, int max)
>>  {
>> @@ -761,6 +810,13 @@ static int stage2_set_pte(struct kvm *kvm, struct kvm_mmu_memory_cache *cache,
>>  	unsigned long iomap = flags & KVM_S2PTE_FLAG_IS_IOMAP;
>>  	unsigned long logging_active = flags & KVM_S2PTE_FLAG_LOGGING_ACTIVE;
>>  
>> +	/*
>> +	 * While dirty page logging - dissolve huge PUD, then continue on to
>> +	 * allocate page.
>> +	 */
>> +	if (logging_active)
>> +		stage2_dissolve_pud(kvm, addr);
>> +
> 
> I know I asked for this, but what's the purpose really when we never set
> a huge stage-2 pud, shouldn't we just WARN/BUG if we encounter one?
> 
> Marc, you may have some thoughts here...

Not sure myself what's the vision for PUD support.

> 
>>  	/* Create stage-2 page table mapping - Levels 0 and 1 */
>>  	pmd = stage2_get_pmd(kvm, cache, addr);
>>  	if (!pmd) {
>> @@ -964,9 +1020,11 @@ static void  stage2_wp_puds(pgd_t *pgd, phys_addr_t addr, phys_addr_t end)
>>  	do {
>>  		next = kvm_pud_addr_end(addr, end);
>>  		if (!pud_none(*pud)) {
>> -			/* TODO:PUD not supported, revisit later if supported */
>> -			BUG_ON(kvm_pud_huge(*pud));
>> -			stage2_wp_pmds(pud, addr, next);
>> +			if (kvm_pud_huge(*pud)) {
>> +				if (!kvm_s2pud_readonly(pud))
>> +					kvm_set_s2pud_readonly(pud);
> 
> I guess the same question that I had above applies here as well (sorry
> for making you go rounds on this one).
> 
>> +			} else
>> +				stage2_wp_pmds(pud, addr, next);
>>  		}
>>  	} while (pud++, addr = next, addr != end);
>>  }
>> diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
>> index f925e40..3b692c5 100644
>> --- a/arch/arm64/include/asm/kvm_mmu.h
>> +++ b/arch/arm64/include/asm/kvm_mmu.h
>> @@ -137,6 +137,15 @@ static inline bool kvm_s2pmd_readonly(pmd_t *pmd)
>>  	return (pmd_val(*pmd) & PMD_S2_RDWR) == PMD_S2_RDONLY;
>>  }
>>  
>> +static inline void kvm_set_s2pud_readonly(pud_t *pud)
>> +{
>> +	pud_val(*pud) = (pud_val(*pud) & ~PUD_S2_RDWR) | PUD_S2_RDONLY;
>> +}
>> +
>> +static inline bool kvm_s2pud_readonly(pud_t *pud)
>> +{
>> +	return (pud_val(*pud) & PUD_S2_RDWR) == PUD_S2_RDONLY;
>> +}
>>  
>>  #define kvm_pgd_addr_end(addr, end)	pgd_addr_end(addr, end)
>>  #define kvm_pud_addr_end(addr, end)	pud_addr_end(addr, end)
>> diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
>> index 5f930cc..1714c84 100644
>> --- a/arch/arm64/include/asm/pgtable-hwdef.h
>> +++ b/arch/arm64/include/asm/pgtable-hwdef.h
>> @@ -122,6 +122,9 @@
>>  #define PMD_S2_RDONLY		(_AT(pmdval_t, 1) << 6)   /* HAP[2:1] */
>>  #define PMD_S2_RDWR		(_AT(pmdval_t, 3) << 6)   /* HAP[2:1] */
>>  
>> +#define PUD_S2_RDONLY		(_AT(pudval_t, 1) << 6)   /* HAP[2:1] */
>> +#define PUD_S2_RDWR		(_AT(pudval_t, 3) << 6)   /* HAP[2:1] */
>> +
>>  /*
>>   * Memory Attribute override for Stage-2 (MemAttr[3:0])
>>   */
>> -- 
>> 1.9.1
>>
