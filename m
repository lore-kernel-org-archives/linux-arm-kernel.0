From: m.smarduch@samsung.com (Mario Smarduch)
Date: Thu, 24 Apr 2014 19:01:30 -0700
Subject: [PATCH v3 2/4] live migration support for initial write protect of
 VM
In-Reply-To: <20140424163928.GA15502@e103986-lin>
References: <5356F8AF.4060707@samsung.com> <20140424163928.GA15502@e103986-lin>
Message-ID: <5359C1FA.9050705@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/24/2014 09:39 AM, Steve Capper wrote:
> On Wed, Apr 23, 2014 at 12:18:07AM +0100, Mario Smarduch wrote:
>>
>>
>> Support for live migration initial write protect.
>> - moved write protect to architecture memory region prepare function. This
>>   way you can fail, abort migration without keep track of migration status.
>> - Above also allows to generalize read dirty log function with x86
>> - Added stage2_mark_pte_ro()
>> - optimized initial write protect, skip upper table lookups
>> - added stage2pmd_addr_end() to do generic 4 level table walk
>> - changed kvm_flush_remote_tlbs() to weak function
> 
> Hello Mario,
> I've taken a quick look at this and have a few suggestions below.
> (I'm not a KVM expert, but took a look at the memory manipulation).

Hi Steve,
    your suggestions are very helpful, my response inline.

Thanks.
  Mario
> 
> Future versions of this series could probably benefit from being sent
> to lakml too?
> 
> Cheers,
> --
> Steve
> 
>>
>> Signed-off-by: Mario Smarduch <m.smarduch@samsung.com>
>> ---
>>  arch/arm/include/asm/kvm_host.h |    8 ++
>>  arch/arm/kvm/arm.c              |    3 +
>>  arch/arm/kvm/mmu.c              |  163 +++++++++++++++++++++++++++++++++++++++
>>  virt/kvm/kvm_main.c             |    5 +-
>>  4 files changed, 178 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
>> index 1e739f9..9f827c8 100644
>> --- a/arch/arm/include/asm/kvm_host.h
>> +++ b/arch/arm/include/asm/kvm_host.h
>> @@ -67,6 +67,12 @@ struct kvm_arch {
>>
>>         /* Interrupt controller */
>>         struct vgic_dist        vgic;
>> +
>> +       /* Marks start of migration, used to handle 2nd stage page faults
>> +        * during migration, prevent installing huge pages and split huge pages
>> +        * to small pages.
>> +        */
>> +       int migration_in_progress;
>>  };
>>
>>  #define KVM_NR_MEM_OBJS     40
>> @@ -230,4 +236,6 @@ int kvm_arm_timer_set_reg(struct kvm_vcpu *, u64 regid, u64 value);
>>
>>  void kvm_tlb_flush_vmid(struct kvm *kvm);
>>
>> +int kvm_mmu_slot_remove_write_access(struct kvm *kvm, int slot);
>> +
>>  #endif /* __ARM_KVM_HOST_H__ */
>> diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
>> index 9a4bc10..b916478 100644
>> --- a/arch/arm/kvm/arm.c
>> +++ b/arch/arm/kvm/arm.c
>> @@ -233,6 +233,9 @@ int kvm_arch_prepare_memory_region(struct kvm *kvm,
>>                                    struct kvm_userspace_memory_region *mem,
>>                                    enum kvm_mr_change change)
>>  {
>> +       /* Request for migration issued by user, write protect memory slot */
>> +       if ((change != KVM_MR_DELETE) && (mem->flags & KVM_MEM_LOG_DIRTY_PAGES))
>> +               return kvm_mmu_slot_remove_write_access(kvm, mem->slot);
>>         return 0;
>>  }
>>
>> diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
>> index 7ab77f3..4d029a6 100644
>> --- a/arch/arm/kvm/mmu.c
>> +++ b/arch/arm/kvm/mmu.c
>> @@ -31,6 +31,11 @@
>>
>>  #include "trace.h"
>>
>> +#define stage2pud_addr_end(addr, end)                          \
>> +({     u64 __boundary = ((addr) + PUD_SIZE) & PUD_MASK;        \
>> +       (__boundary - 1 < (end) - 1) ? __boundary : (end);      \
>> +})
> 
> A matter of personal preference: can this be a static inline function
> instead? That way you could avoid ambiguity with the parameter types.
> (not an issue here, but this has bitten me in the past).

Yes good point, will change.
> 
>> +
>>  extern char  __hyp_idmap_text_start[], __hyp_idmap_text_end[];
>>
>>  static pgd_t *boot_hyp_pgd;
>> @@ -569,6 +574,15 @@ static int stage2_set_pte(struct kvm *kvm, struct kvm_mmu_memory_cache *cache,
>>         return 0;
>>  }
>>
>> +/* Write protect page */
>> +static void stage2_mark_pte_ro(pte_t *pte)
>> +{
>> +       pte_t new_pte;
>> +
>> +       new_pte = pfn_pte(pte_pfn(*pte), PAGE_S2);
>> +       *pte = new_pte;
>> +}
> 
> This isn't making the pte read only.
> It's nuking all the flags from the pte and replacing them with factory
> settings. (In this case the PAGE_S2 pgprot).
> If we had other attributes that we later wish to retain this could be
> easily overlooked. Perhaps a new name for the function?

Yes that's pretty bad, I'll clear the write protect bit only.

> 
>> +
>>  /**
>>   * kvm_phys_addr_ioremap - map a device range to guest IPA
>>   *
>> @@ -649,6 +663,155 @@ static bool transparent_hugepage_adjust(pfn_t *pfnp, phys_addr_t *ipap)
>>         return false;
>>  }
>>
>> +/**
>> + * split_pmd - splits huge pages to small pages, required to keep a dirty log of
>> + *      smaller memory granules, otherwise huge pages would need to be
>> + *      migrated. Practically an idle system has problems migrating with
>> + *      huge pages.  Called during WP of entire VM address space, done
>> + *      initially when  migration thread isses the KVM_MEM_LOG_DIRTY_PAGES
>> + *      ioctl.
>> + *      The mmu_lock is held during splitting.
>> + *
>> + * @kvm:        The KVM pointer
>> + * @pmd:        Pmd to 2nd stage huge page
>> + * @addr: `     Guest Physical Address
> Nitpick: typo `

Yes overlooked it, will delete.
> 
>> + */
>> +int split_pmd(struct kvm *kvm, pmd_t *pmd, u64 addr)
> 
> Maybe worth renaming to something like kvm_split_pmd to avoid future
> namespace collisions (either compiler or cscope/ctags)? It should also
> probably be static?

Mistake on this iteration will change it to static and rename to kvm_*

> 
>> +{
>> +       struct page *page;
>> +       pfn_t pfn = pmd_pfn(*pmd);
>> +       pte_t *pte;
>> +       int i;
>> +
>> +       page = alloc_page(GFP_KERNEL);
>> +       if (page == NULL)
>> +               return -ENOMEM;
>> +
>> +       pte = page_address(page);
>> +       /* cycle through ptes first, use pmd pfn */
>> +       for (i = 0; i < PTRS_PER_PMD; i++) {
>> +               pte[i] = pfn_pte(pfn+i, 0);
>> +               stage2_mark_pte_ro(&pte[i]);
> 
> How's about?
>                   pte[i] = pfn_pte(pfn+i, PAGE_S2);

Yes I tried to fit the function stage2_mare_pte_ro() for all
cases, but  in this case not a fit, will change it.

> 
>> +       }
>> +       kvm_clean_pte(pte);
>> +       /* After page table setup set pmd */
>> +       pmd_populate_kernel(NULL, pmd, pte);
>> +
>> +       /* get reference on pte page */
>> +       get_page(virt_to_page(pte));
>> +       return 0;
>> +}
> 
> How are the TLBs dealt with? Do they all get flushed?

After kvm_mmu_slot_remove_access() write protects entire memory
stot the TLBs are flushed.

> 
>> +
>> +/**
>> + * kvm_mmu_slot_remove_access - write protects entire VM address space.
>> + *      Called at start of migration when KVM_MEM_LOG_DIRTY_PAGES ioctl is
>> + *      issued. After this function returns all pages (minus the ones faulted
>> + *      in when mmu_lock is released) must be write protected to keep track of
>> + *      dirty pages to migrate on subsequent dirty log retrieval.
>> + *      mmu_lock is held during write protecting, released on contention.
>> + *
>> + * @kvm:        The KVM pointer
>> + * @slot:       The memory slot the dirty log is retrieved for
>> + */
>> +int kvm_mmu_slot_remove_write_access(struct kvm *kvm, int slot)
>> +{
>> +       pgd_t *pgd;
>> +       pud_t *pud;
>> +       pmd_t *pmd;
>> +       pte_t *pte;
>> +       pgd_t *pgdp = kvm->arch.pgd;
>> +       struct kvm_memory_slot *memslot = id_to_memslot(kvm->memslots, slot);
>> +       u64 start = memslot->base_gfn << PAGE_SHIFT;
>> +       u64 end = (memslot->base_gfn + memslot->npages) << PAGE_SHIFT;
>> +       u64 addr = start;
>> +       u64 pgdir_end, pud_end, pmd_end;
> 
> Is u64 the right type for these? Could we use phys_addr_t instead?

Yes will change, more indicative what variables mean.

> 
>> +       int ret;
>> +
>> +       spin_lock(&kvm->mmu_lock);
>> +       /* set start of migration, sychronize with Data Abort handler */
>> +       kvm->arch.migration_in_progress = 1;
>> +
>> +       /* Walk range, split up huge pages as needed and write protect ptes */
>> +       while (addr < end) {
>> +               pgd = pgdp + pgd_index(addr);
>> +               if (!pgd_present(*pgd)) {
>> +                       addr = pgd_addr_end(addr, end);
>> +                       continue;
>> +               }
>> +
>> +               /* On ARMv7 xxx_addr_end() - works if memory not allocated
>> +                * above 4GB.
>> +                */
> 
> What about ARMv7 systems where this is true? (like systems with >4GB of
> physical memory).
> 
> start, end, addr are all u64 and the defaults of these addr_end()
> macros are downcasting to unsigned long. Or have I missed their
> re-implementation? (Which is possible). 
That's correct these do not work above 4GB as you say the 32 bit
wraps and will give you next addr of 0x4000000 if addr is
0x1_0000_000 end  0x1_3000_0000 for example using pgd_addr_end()...
I use vexpress and that limits memory to 2GB range beyond 4GB not
possible, not sure what mach-virt does for A15. But it's likely
someone may want to put a memory device like 'ivshmem' above 4GB.
Also not sure how to reconcile this with ARMv8 there all these
will work, and from what I see both reuse this code. Provided
that GICv2 is used for A57 QEMU machine model
it should not be hard to make this work on ARMv8 FastModels,
since Christoffer added GICv2 save/restore.

> It is probably a good idea to
> explictly define IPA friendly analogues of these.

Yes I added the stage2pud_addr_end() to do a 4-level table walk
can add ones for pgd, pmd as well. What is good place to put these
for the time being arch/arm/kvm/mmu.c is the only one that
needs them?

Also the underlying mmu notifiers needs these changes as well.

> 
>> +               pgdir_end = pgd_addr_end(addr, end);
>> +               while (addr < pgdir_end) {
>> +                       /* give up CPU if mmu_lock is needed by other vCPUs */
>> +                       if (need_resched() || spin_needbreak(&kvm->mmu_lock))
>> +                               cond_resched_lock(&kvm->mmu_lock);
>> +
>> +                       pud = pud_offset(pgd, addr);
>> +                       if (!pud_present(*pud)) {
>> +                               addr = stage2pud_addr_end(addr, end);
>> +                               continue;
>> +                       }
>> +
>> +                       /* Fail if PUD is huge, splitting PUDs not supported */
>> +                       if (pud_huge(*pud)) {
>> +                               spin_unlock(&kvm->mmu_lock);
>> +                               return -EFAULT;
>> +                       }
>> +
>> +                       /* By default 'nopud' is supported which fails with
>> +                        * guests larger 1GB. Technically not needed since
>> +                        * 3-level page tables are supported, but 4-level may
>> +                        * be used in the future, on 64 bit pud_addr_end() will
>> +                        * work.
>> +                        */
>> +                       pud_end = stage2pud_addr_end(addr, end);
>> +                       while (addr < pud_end) {
>> +                               if (need_resched() ||
>> +                                               spin_needbreak(&kvm->mmu_lock))
>> +                                       cond_resched_lock(&kvm->mmu_lock);
> 
> Do we not run the risk of things changing when the scheduler returns to
> us? Or is there a lock other than mmu_lock?
Upon completion of this function QEMU will migrate all pages
regardless of their status dirty/clean.

Important coming out of this functions is that all future
writes update the dirty bitmap, to get subsequent dirty page deltas

There should be two sets, pages that remain at the end of the
loop and are write protected and flushed, these will update
dirty bitmap on future writes.  2nd set are ptes that are faulted in
when lock is released, invalidated/swapped. Second set
will mark the dirty bit map eventually on a write.
So coming out of this function you may have some pages dirty
but not reflected in the bitmap.

I've ran pretty demanding migrations in some case by factor x16
of what I can achieve on x86, checksums of both images match on
source and destination.

But that doesn't mean there are no potential issues, if there
some odd case anyone is aware off I would like to test it.


> 
>> +
>> +                               pmd = pmd_offset(pud, addr);
>> +                               if (!pmd_present(*pmd)) {
>> +                                       addr = pmd_addr_end(addr, end);
>> +                                       continue;
>> +                               }
>> +
>> +                               if (kvm_pmd_huge(*pmd)) {
>> +                                       ret = split_pmd(kvm, pmd, addr);
>> +                                       if (ret < 0) {
>> +                                               /* Failed to split up huge
>> +                                                * page abort.
>> +                                                */
>> +                                               spin_unlock(&kvm->mmu_lock);
>> +                                               return ret;
>> +                                       }
>> +                                       addr = pmd_addr_end(addr, end);
>> +                                       continue;
>> +                               }
>> +
>> +                               pmd_end = pmd_addr_end(addr, end);
>> +                               while (addr < pmd_end) {
>> +                                       pte = pte_offset_kernel(pmd, addr);
>> +                                       addr += PAGE_SIZE;
>> +                                       if (!pte_present(*pte))
>> +                                               continue;
>> +                                       /* skip write protected pages */
>> +                                       if ((*pte & L_PTE_S2_RDWR) ==
>> +                                                               L_PTE_S2_RDONLY)
>> +                                               continue;
> 
> Probably worth defining a pte helper here rather than manually inspect
> the flags.

Yes will update,

> 
>> +                                       stage2_mark_pte_ro(pte);
>> +                               }
>> +                       }
>> +               }
>> +       }
>> +       /* Flush TLBs, >= ARMv7 variant uses hardware broadcast not IPIs */
>> +       kvm_flush_remote_tlbs(kvm);
>> +       spin_unlock(&kvm->mmu_lock);
>> +       return 0;
>> +}
> 
> It is probably cleaner and easier to read to have separate walkers, one
> for puds, one for pmds and one for ptes. In a similar manner to:
> unmap_page_range?

Yes will change,  too many indents.

> 
>> +
>>  static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>>                           struct kvm_memory_slot *memslot,
>>                           unsigned long fault_status)
>> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
>> index 03a0381..1d11912 100644
>> --- a/virt/kvm/kvm_main.c
>> +++ b/virt/kvm/kvm_main.c
>> @@ -184,7 +184,10 @@ static bool make_all_cpus_request(struct kvm *kvm, unsigned int req)
>>         return called;
>>  }
>>
>> -void kvm_flush_remote_tlbs(struct kvm *kvm)
>> +/* Architectures like >= ARMv7 hardware broadcast TLB invalidations and don't
>> + * use IPIs.
>> + */
>> +void __weak kvm_flush_remote_tlbs(struct kvm *kvm)
>>  {
>>         long dirty_count = kvm->tlbs_dirty;
>>
>> --
>> 1.7.9.5
>>
>> _______________________________________________
>> kvmarm mailing list
>> kvmarm at lists.cs.columbia.edu
>> https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
>>
> 
> -- IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium.  Thank you.
> 
> ARM Limited, Registered office 110 Fulbourn Road, Cambridge CB1 9NJ, Registered in England & Wales, Company No:  2557590
> ARM Holdings plc, Registered office 110 Fulbourn Road, Cambridge CB1 9NJ, Registered in England & Wales, Company No:  2548782
> 
