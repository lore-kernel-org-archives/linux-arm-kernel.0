From: m.smarduch@samsung.com (Mario Smarduch)
Date: Thu, 15 May 2014 15:51:04 -0700
Subject: [PATCH v5 2/4] live migration support for initial write protect of
 VM
In-Reply-To: <20140515185312.GA6159@lvm>
References: <1399509616-4632-1-git-send-email-m.smarduch@samsung.com>
 <1399509616-4632-3-git-send-email-m.smarduch@samsung.com>
 <20140515185312.GA6159@lvm>
Message-ID: <537544D8.2030005@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/15/2014 11:53 AM, Christoffer Dall wrote:
> 
> [I know you sent out a newer version but I already reviewed some of this
> patch on the plane today but couldn't send it out before I got home.
> Anyway, here it is:]
> 
> On Wed, May 07, 2014 at 05:40:14PM -0700, Mario Smarduch wrote:
>> Patch adds support for live migration initial split up of huge pages
>> in memory slot and write protection of all pages in memory slot.
>>
>> Signed-off-by: Mario Smarduch <m.smarduch@samsung.com>
>> ---
>>  arch/arm/include/asm/kvm_host.h |    7 ++
>>  arch/arm/include/asm/kvm_mmu.h  |   16 +++-
>>  arch/arm/kvm/arm.c              |    3 +
>>  arch/arm/kvm/mmu.c              |  179 +++++++++++++++++++++++++++++++++++++++
>>  virt/kvm/kvm_main.c             |    6 +-
>>  5 files changed, 209 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
>> index ac3bb65..91744c3 100644
>> --- a/arch/arm/include/asm/kvm_host.h
>> +++ b/arch/arm/include/asm/kvm_host.h
>> @@ -67,6 +67,11 @@ struct kvm_arch {
>>  
>>  	/* Interrupt controller */
>>  	struct vgic_dist	vgic;
>> +	/* Marks start of migration, used to handle 2nd stage page faults
>> +	 * during migration, prevent installing huge pages and split huge pages
>> +	 * to small pages.
>> +	 */
> 
> commenting style
> 
> this is a bit verbose for a field in a struct, perhaps moving the longer
> version to where you set this?
Will do.
> 
>> +	int migration_in_progress;
>>  };
>>  
>>  #define KVM_NR_MEM_OBJS     40
>> @@ -233,4 +238,6 @@ int kvm_arm_timer_set_reg(struct kvm_vcpu *, u64 regid, u64 value);
>>  
>>  void kvm_tlb_flush_vmid(struct kvm *kvm);
>>  
>> +int kvm_mmu_slot_remove_write_access(struct kvm *kvm, int slot);
>> +
>>  #endif /* __ARM_KVM_HOST_H__ */
>> diff --git a/arch/arm/include/asm/kvm_mmu.h b/arch/arm/include/asm/kvm_mmu.h
>> index 5c7aa3c..b339fa9 100644
>> --- a/arch/arm/include/asm/kvm_mmu.h
>> +++ b/arch/arm/include/asm/kvm_mmu.h
>> @@ -114,13 +114,27 @@ static inline void kvm_set_s2pmd_writable(pmd_t *pmd)
>>  	pmd_val(*pmd) |= L_PMD_S2_RDWR;
>>  }
>>  
>> +static inline void kvm_set_s2pte_readonly(pte_t *pte)
>> +{
>> +	pte_val(*pte) &= ~(L_PTE_S2_RDONLY ^ L_PTE_S2_RDWR);
> 
> This relies on the pte already having been set as RDONLY or RDWR, if you
> are creating a new pte and calling this function it could be easy to
> miss that distinction, I would prefer:
> 
> pte_val(*pte) &= L_PTE_S2_RDWR;
> pte_val(*pte) |= L_PTE_S2_RDONLY;

Currently it's called only on set, or live pte's, I'll change
it so it's applicate to all cases. 
> 
>> +}
>> +
>> +static inline bool kvm_s2pte_readonly(pte_t *pte)
>> +{
>> +	return (pte_val(*pte) & L_PTE_S2_RDWR) == L_PTE_S2_RDONLY;
>> +}
>> +
>>  /* Open coded p*d_addr_end that can deal with 64bit addresses */
>>  #define kvm_pgd_addr_end(addr, end)					\
>>  ({	u64 __boundary = ((addr) + PGDIR_SIZE) & PGDIR_MASK;		\
>>  	(__boundary - 1 < (end) - 1)? __boundary: (end);		\
>>  })
>>  
>> -#define kvm_pud_addr_end(addr,end)		(end)
>> +/* For - 4-level table walk return PUD range end if end > 1GB */
> 
> not sure you need this comment, the scheme is very common all over the
> kernel.
Yes.
> 
>> +#define kvm_pud_addr_end(addr, end)					\
>> +({	u64 __boundary = ((addr) + PUD_SIZE) & PUD_MASK;		\
>> +	(__boundary - 1 < (end) - 1) ? __boundary : (end);		\
>> +})
> 
> why do we need this?  We should only ever have 3 levels of page tables,
> right?

I removed in v6 patch.
> 
>>  
>>  #define kvm_pmd_addr_end(addr, end)					\
>>  ({	u64 __boundary = ((addr) + PMD_SIZE) & PMD_MASK;		\
>> diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
>> index 3c82b37..1055266 100644
>> --- a/arch/arm/kvm/arm.c
>> +++ b/arch/arm/kvm/arm.c
>> @@ -234,6 +234,9 @@ int kvm_arch_prepare_memory_region(struct kvm *kvm,
>>  				   struct kvm_userspace_memory_region *mem,
>>  				   enum kvm_mr_change change)
>>  {
>> +	/* Request for migration issued by user, write protect memory slot */
> 
> Does this necessarily only happen when there's a request for migration?
> Isn't it just a log call that could be used for other things
> (potentially)?


>From QEMU view migration thread calls KVM memory listener kvm_log_global_start
and that kicks off dirty log tracking for each memslot. There are other operations 
like region add (kvm_region_add)  that starts kvm_log_start for that memslot, 
or other odd case if you add a region that overlaps regions you may start logging
the whole region.
 
But in either case it appears you're migrating already. 

But no I don't see any other feature that triggers this.

> 
>> +	if ((change != KVM_MR_DELETE) && (mem->flags & KVM_MEM_LOG_DIRTY_PAGES))
>> +		return kvm_mmu_slot_remove_write_access(kvm, mem->slot);
>>  	return 0;
>>  }
>>  
>> diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
>> index 95c172a..85145d8 100644
>> --- a/arch/arm/kvm/mmu.c
>> +++ b/arch/arm/kvm/mmu.c
>> @@ -743,6 +743,185 @@ static bool transparent_hugepage_adjust(pfn_t *pfnp, phys_addr_t *ipap)
>>  	return false;
>>  }
>>  
>> +/* kvm_split_pmd - splits huge pages to small pages, required to keep a dirty
>> + *	log of smaller memory granules, otherwise huge pages would need to be
>> + *	migrated. Practically an idle system has problems migrating with
> 
> This seems abrupt.  Why can't we just represent a 2M huge page as 512 4K
> bits and write protect the huge pages, if you take a write fault on a 2M
> page, then split it then.

That's one alternative the one I put into v6 is clear the PMD
and force user_mem_abort() to fault in 4k pages, and mark the
dirty_bitmap[] for that page, reuse the current code. Have not
checked the impact on performance, it takes few seconds longer
to converge for the tests I'm running. 

> 
> If your use case is HA, then you will be doing this a lot, and you don't
> want to hurt performance of your main live system more than necessary.

> 
>> + *	huge pages.  Called during WP of entire VM address space, done
> 
> s/WP/write protect/
Ok.
> 
>> + *	initially when  migration thread isses the KVM_MEM_LOG_DIRTY_PAGES
> 
> "migration thread"?  I don't think this is a KVM term.  Please keep
> documentation to concepts that can be understood from the KVM
> perspective without knowing anything specific about user space
> implementation.
Ok.
> 
>> + *	ioctl.
> 
> This is not an ioctl but a flag in an ioctl.  There's another ioctl to
> get the dirty log.
Ok.
> 
>> + *	The mmu_lock is held during splitting.
>> + *
>> + * @kvm:        The KVM pointer
>> + * @pmd:        Pmd to 2nd stage huge page
>> + * @addr:       Guest Physical Address
>> + */
> 
> Thanks for commenting the function, however, a few nits:
> 
> again, check the commenting style, checkpatch should complain, kdocs
> usually look like this:

checkpatch didn't complain, kdocs seemed to describe this, will
check again.

> 
> /*
>  * kvm_split_pmd - <one line description of function>
>  *
>  * Some more description of the function which can be on multiple lines.
>  */
> 
>  can you also comment on the return value?

Ok.
> 
>> +static int kvm_split_pmd(struct kvm *kvm, pmd_t *pmd, u64 addr)
>> +{
>> +	struct page *page;
>> +	pfn_t pfn = pmd_pfn(*pmd);
>> +	pte_t *pte;
>> +	int i;
>> +
>> +	page = alloc_page(GFP_KERNEL);
>> +	if (page == NULL)
>> +		return -ENOMEM;
>> +
>> +	pte = page_address(page);
>> +	/* cycle through ptes first, use pmd pfn */
>> +	for (i = 0; i < PTRS_PER_PMD; i++)
>> +		pte[i] = pfn_pte(pfn+i, PAGE_S2);
>> +
>> +	kvm_clean_pte(pte);
>> +	/* After page table setup set pmd */
>> +	pmd_populate_kernel(NULL, pmd, pte);
>> +
>> +	/* get reference on pte page */
>> +	get_page(virt_to_page(pte));
>> +	return 0;
>> +}
>> +
>> +/* Walks PMD page table range and write protects it. Called with
>> + * 'kvm->mmu_lock' * held
>> + */
>> +static void stage2_wp_pmd_range(phys_addr_t addr, phys_addr_t end, pmd_t *pmd)
>> +{
>> +	pte_t *pte;
>> +
>> +	while (addr < end) {
>> +		pte = pte_offset_kernel(pmd, addr);
>> +		addr += PAGE_SIZE;
>> +		if (!pte_present(*pte))
>> +			continue;
>> +		/* skip write protected pages */
>> +		if (kvm_s2pte_readonly(pte))
>> +			continue;
>> +		kvm_set_s2pte_readonly(pte);
>> +	}
>> +}
>> +
>> +/* Walks PUD  page table range to write protects it , if necessary spluts up
>> + * huge pages to small pages. Called with 'kvm->mmu_lock' held.
>> + */
>> +static int stage2_wp_pud_range(struct kvm *kvm, phys_addr_t addr,
>> +				phys_addr_t end, pud_t *pud)
>> +{
>> +	pmd_t *pmd;
>> +	phys_addr_t pmd_end;
>> +	int ret;
>> +
>> +	while (addr < end) {
>> +		/* If needed give up CPU during PUD page table walk */
>> +		if (need_resched() || spin_needbreak(&kvm->mmu_lock))
>> +			cond_resched_lock(&kvm->mmu_lock);
>> +
>> +		pmd = pmd_offset(pud, addr);
>> +		if (!pmd_present(*pmd)) {
>> +			addr = kvm_pmd_addr_end(addr, end);
>> +			continue;
>> +		}
>> +
>> +		if (kvm_pmd_huge(*pmd)) {
>> +			ret = kvm_split_pmd(kvm, pmd, addr);
>> +			/* Failed to split up huge  page abort. */
>> +			if (ret < 0)
>> +				return ret;
>> +
>> +			addr = kvm_pmd_addr_end(addr, end);
>> +			continue;
>> +		}
>> +
>> +		pmd_end = kvm_pmd_addr_end(addr, end);
>> +		stage2_wp_pmd_range(addr, pmd_end, pmd);
>> +		addr = pmd_end;
>> +	}
>> +	return 0;
>> +}
>> +
>> +/* Walks PGD page table range to write protect it. Called with 'kvm->mmu_lock'
>> + * held.
>> + */
>> +static int stage2_wp_pgd_range(struct kvm *kvm, phys_addr_t addr,
>> +				phys_addr_t end, pgd_t *pgd)
>> +{
>> +	phys_addr_t pud_end;
>> +	pud_t *pud;
>> +	int ret;
>> +
>> +	while (addr < end) {
>> +		/* give up CPU if mmu_lock is needed by other vCPUs */
>> +		if (need_resched() || spin_needbreak(&kvm->mmu_lock))
>> +			cond_resched_lock(&kvm->mmu_lock);
>> +
>> +		pud = pud_offset(pgd, addr);
>> +		if (!pud_present(*pud)) {
>> +			addr = kvm_pud_addr_end(addr, end);
>> +			continue;
>> +		}
>> +
>> +		/* Fail if PUD is huge, splitting PUDs not supported */
>> +		if (pud_huge(*pud))
>> +			return -EFAULT;
>> +
>> +		/* By default 'nopud' is supported which fails with guests
>> +		 * larger then 1GB. Added to support 4-level page tables.
>> +		 */
>> +		pud_end = kvm_pud_addr_end(addr, end);
>> +		ret = stage2_wp_pud_range(kvm, addr, pud_end, pud);
>> +		if (ret < 0)
>> +			return ret;
>> +		addr = pud_end;
>> +	}
>> +	return 0;
>> +}
>> +
>> +/**
>> + * kvm_mmu_slot_remove_access - write protects entire memslot address space.
>> + *      Called at start of migration when KVM_MEM_LOG_DIRTY_PAGES ioctl is
>> + *      issued. After this function returns all pages (minus the ones faulted
>> + *      in or released when mmu_lock is give nup) must be write protected to
>> + *	keep track of dirty pages to migrate on subsequent dirty log read.
>> + *      mmu_lock is held during write protecting, released on contention.
>> + *
>> + * @kvm:        The KVM pointer
>> + * @slot:       The memory slot the dirty log is retrieved for
>> + */
> 
> your indentation is weird here and you also need a new line after the
> first description.  Also missing return value.
Ok
> 
>> +int kvm_mmu_slot_remove_write_access(struct kvm *kvm, int slot)
>> +{
>> +	pgd_t *pgd;
>> +	pgd_t *pgdp = kvm->arch.pgd;
>> +	struct kvm_memory_slot *memslot = id_to_memslot(kvm->memslots, slot);
>> +	phys_addr_t addr = memslot->base_gfn << PAGE_SHIFT;
>> +	phys_addr_t end = (memslot->base_gfn + memslot->npages) << PAGE_SHIFT;
>> +	phys_addr_t pgdir_end;
>> +	int ret = -ENOMEM;
>> +
>> +	spin_lock(&kvm->mmu_lock);
>> +	/* set start of migration, sychronize with Data Abort handler */
> 
> s/sychronize/synchronize/
Ok
> 
> What is Data Abort handler?  user_mem_abort()?  Can you use a concrete
> function name?
Yes user_mem_abort() will change.
> 
>> +	kvm->arch.migration_in_progress = 1;
>> +
>> +	/* Walk range, split up huge pages as needed and write protect ptes */
>> +	while (addr < end) {
> 
> I think this should be rewritten to use the scheme used in
> stage2_flush_memslot, I will submit a patch one of these days that
> changes unmap_range() as well, you can wait for that and take a look.

Yes I saw you're unmap_range() and Marcs approach, will change it.
> 
>> +		pgd = pgdp + pgd_index(addr);
>> +		if (!pgd_present(*pgd)) {
>> +			addr = kvm_pgd_addr_end(addr, end);
>> +			continue;
>> +		}
>> +
>> +		pgdir_end = kvm_pgd_addr_end(addr, end);
>> +		ret = stage2_wp_pgd_range(kvm, addr, pgdir_end, pgd);
>> +		/* Failed to WP a pgd range abort */
>> +		if (ret < 0)
>> +			goto out;
>> +		addr = pgdir_end;
>> +	}
>> +	ret = 0;
>> +	/* Flush TLBs, >= ARMv7 variant uses hardware broadcast not IPIs */
>> +	kvm_flush_remote_tlbs(kvm);
>> +out:
>> +	spin_unlock(&kvm->mmu_lock);
>> +	return ret;
>> +}
>> +
>>  static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>>  			  struct kvm_memory_slot *memslot,
>>  			  unsigned long fault_status)
>> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
>> index fa70c6e..e49f976 100644
>> --- a/virt/kvm/kvm_main.c
>> +++ b/virt/kvm/kvm_main.c
>> @@ -184,7 +184,11 @@ static bool make_all_cpus_request(struct kvm *kvm, unsigned int req)
>>  	return called;
>>  }
>>  
>> -void kvm_flush_remote_tlbs(struct kvm *kvm)
>> +/*
>> + * Architectures like >= ARMv7 hardware broadcast TLB invalidations and don't
>> + * use IPIs, to flush TLBs.
>> + */
> 
> I don't think this comment is appropriate in generic code.  If you want
> to say anything here, you should say that arch code can override this
> function.
Ok.
> 
>> +void __weak kvm_flush_remote_tlbs(struct kvm *kvm)
>>  {
>>  	long dirty_count = kvm->tlbs_dirty;
>>  
>> -- 
>> 1.7.9.5
>>
