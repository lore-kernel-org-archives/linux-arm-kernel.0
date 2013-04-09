From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 09 Apr 2013 11:42:56 +0100
Subject: [PATCH v2 6/7] ARM: KVM: switch to a dual-step HYP init code
In-Reply-To: <20130409091813.GC24090@mudshark.cambridge.arm.com>
References: <1365435403-29265-1-git-send-email-marc.zyngier@arm.com>
 <1365435403-29265-7-git-send-email-marc.zyngier@arm.com>
 <20130409091813.GC24090@mudshark.cambridge.arm.com>
Message-ID: <5163F0B0.2000400@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/04/13 10:18, Will Deacon wrote:
> On Mon, Apr 08, 2013 at 04:36:42PM +0100, Marc Zyngier wrote:
>> Our HYP init code suffers from two major design issues:
>> - it cannot support CPU hotplug, as we tear down the idmap very early
>> - it cannot perform a TLB invalidation when switching from init to
>>   runtime mappings, as pages are manipulated from PL1 exclusively
>>
>> The hotplug problem mandates that we keep two sets of page tables
>> (boot and runtime). The TLB problem mandates that we're able to
>> transition from one PGD to another while in HYP, invalidating the TLBs
>> in the process.
>>
>> To be able to do this, we need to share a page between the two page
>> tables. A page that will have the same VA in both configurations. All we
>> need is a VA that has the following properties:
>> - This VA can't be used to represent a kernel mapping.
>> - This VA will not conflict with the physical address of the kernel text
>>
>> The vectors page seems to satisfy this requirement:
>> - The kernel never maps anything else there
>> - The kernel text being copied at the beginning of the physical memory,
>>   it is unlikely to use the last 64kB (I doubt we'll ever support KVM
>>   on a system with something like 4MB of RAM, but patches are very
>>   welcome).
>>
>> Let's call this VA the trampoline VA.
>>
>> Now, we map our init page at 3 locations:
>> - idmap in the boot pgd
>> - trampoline VA in the boot pgd
>> - trampoline VA in the runtime pgd
>>
>> The init scenario is now the following:
>> - We jump in HYP with four parameters: boot HYP pgd, runtime HYP pgd,
>>   runtime stack, runtime vectors
>> - Enable the MMU with the boot pgd
>> - Jump to a target into the trampoline page (remember, this is the same
>>   physical page!)
>> - Now switch to the runtime pgd (same VA, and still the same physical
>>   page!)
>> - Invalidate TLBs
>> - Set stack and vectors
>> - Profit! (or eret, if you only care about the code).
>>
>> Note that we keep the boot mapping permanently (it is not strictly an
>> idmap anymore) to allow for CPU hotplug in later patches.
>>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>> ---
>>  arch/arm/include/asm/kvm_host.h |  18 ++++--
>>  arch/arm/include/asm/kvm_mmu.h  |  24 +++++++-
>>  arch/arm/kvm/arm.c              |  11 ++--
>>  arch/arm/kvm/init.S             |  44 +++++++++++++-
>>  arch/arm/kvm/mmu.c              | 129 ++++++++++++++++++++++++++++------------
>>  5 files changed, 173 insertions(+), 53 deletions(-)
>>
>> diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
>> index a856cc2..9fe22ee 100644
>> --- a/arch/arm/include/asm/kvm_host.h
>> +++ b/arch/arm/include/asm/kvm_host.h
>> @@ -190,22 +190,32 @@ int kvm_arm_coproc_set_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *);
>>  int handle_exit(struct kvm_vcpu *vcpu, struct kvm_run *run,
>>                 int exception_index);
>>
>> -static inline void __cpu_init_hyp_mode(unsigned long long pgd_ptr,
>> +static inline void __cpu_init_hyp_mode(unsigned long long boot_pgd_ptr,
>> +                                      unsigned long long pgd_ptr,
>>                                        unsigned long hyp_stack_ptr,
>>                                        unsigned long vector_ptr)
>>  {
>>         unsigned long pgd_low, pgd_high;
>>
>> -       pgd_low = (pgd_ptr & ((1ULL << 32) - 1));
>> -       pgd_high = (pgd_ptr >> 32ULL);
>> +       pgd_low = (boot_pgd_ptr & ((1ULL << 32) - 1));
>> +       pgd_high = (boot_pgd_ptr >> 32ULL);
>>
>>         /*
>>          * Call initialization code, and switch to the full blown
>>          * HYP code. The init code doesn't need to preserve these registers as
>> -        * r1-r3 and r12 are already callee save according to the AAPCS.
>> +        * r1-r3 and r12 are already callee saved according to the AAPCS.
>>          * Note that we slightly misuse the prototype by casing the pgd_low to
>>          * a void *.
>> +        *
>> +        * We don't have enough registers to perform the full init in one go.
>> +        * Install the boot PGD first, and then install the runtime PGD,
>> +        * stack pointer and vectors.
>>          */
>> +       kvm_call_hyp((void *)pgd_low, pgd_high, 0, 0);
>> +
>> +       pgd_low = (pgd_ptr & ((1ULL << 32) - 1));
>> +       pgd_high = (pgd_ptr >> 32ULL);
> 
> It might be worth macro-ising the low/high extraction operations now that
> you're using them twice. Hell, you could even make them big-endian clean!

Now you're talking! ;-)

I actually wonder if we could rearrange the code to let the compiler do
the low/high split... Quickly looking through the PCS, it looks like
this would actually work.

>>         kvm_call_hyp((void *)pgd_low, pgd_high, hyp_stack_ptr, vector_ptr);
>>  }
>>
>> diff --git a/arch/arm/include/asm/kvm_mmu.h b/arch/arm/include/asm/kvm_mmu.h
>> index 92eb20d..24b767a 100644
>> --- a/arch/arm/include/asm/kvm_mmu.h
>> +++ b/arch/arm/include/asm/kvm_mmu.h
>> @@ -19,17 +19,29 @@
>>  #ifndef __ARM_KVM_MMU_H__
>>  #define __ARM_KVM_MMU_H__
>>
>> -#include <asm/cacheflush.h>
>> -#include <asm/pgalloc.h>
>> +#include <asm/memory.h>
>> +#include <asm/page.h>
>>
>>  /*
>>   * We directly use the kernel VA for the HYP, as we can directly share
>>   * the mapping (HTTBR "covers" TTBR1).
>>   */
>> -#define HYP_PAGE_OFFSET_MASK   (~0UL)
>> +#define HYP_PAGE_OFFSET_MASK   UL(~0)
>>  #define HYP_PAGE_OFFSET                PAGE_OFFSET
>>  #define KERN_TO_HYP(kva)       (kva)
>>
>> +/*
>> + * Our virtual mapping for the boot-time MMU-enable code. Must be
>> + * shared across all the page-tables. Conveniently, we use the vectors
>> + * page, where no kernel data will ever be shared with HYP.
>> + */
>> +#define TRAMPOLINE_VA          UL(CONFIG_VECTORS_BASE)
>> +
>> +#ifndef __ASSEMBLY__
>> +
>> +#include <asm/cacheflush.h>
>> +#include <asm/pgalloc.h>
>> +
>>  int create_hyp_mappings(void *from, void *to);
>>  int create_hyp_io_mappings(void *from, void *to, phys_addr_t);
>>  void free_hyp_pgds(void);
>> @@ -44,6 +56,8 @@ int kvm_handle_guest_abort(struct kvm_vcpu *vcpu, struct kvm_run *run);
>>  void kvm_mmu_free_memory_caches(struct kvm_vcpu *vcpu);
>>
>>  phys_addr_t kvm_mmu_get_httbr(void);
>> +phys_addr_t kvm_mmu_get_boot_httbr(void);
>> +phys_addr_t kvm_get_idmap_vector(void);
>>  int kvm_mmu_init(void);
>>  void kvm_clear_hyp_idmap(void);
>>
>> @@ -113,4 +127,8 @@ static inline void coherent_icache_guest_page(struct kvm *kvm, gfn_t gfn)
>>         }
>>  }
>>
>> +#define kvm_flush_dcache_to_poc(a,l)   __cpuc_flush_dcache_area((a), (l))
>> +
>> +#endif /* !__ASSEMBLY__ */
>> +
>>  #endif /* __ARM_KVM_MMU_H__ */
>> diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
>> index 8d44ef4..9010a12 100644
>> --- a/arch/arm/kvm/arm.c
>> +++ b/arch/arm/kvm/arm.c
>> @@ -796,20 +796,22 @@ long kvm_arch_vm_ioctl(struct file *filp,
>>
>>  static void cpu_init_hyp_mode(void *vector)
>>  {
>> +       unsigned long long boot_pgd_ptr;
>>         unsigned long long pgd_ptr;
>>         unsigned long hyp_stack_ptr;
>>         unsigned long stack_page;
>>         unsigned long vector_ptr;
>>
>>         /* Switch from the HYP stub to our own HYP init vector */
>> -       __hyp_set_vectors((unsigned long)vector);
>> +       __hyp_set_vectors(kvm_get_idmap_vector());
>>
>> +       boot_pgd_ptr = (unsigned long long)kvm_mmu_get_boot_httbr();
>>         pgd_ptr = (unsigned long long)kvm_mmu_get_httbr();
> 
> Strictly speaking, could you avoid using two sets of tables for this? That
> is, have code in the trampoline page which remaps the rest of the address
> space using the current tables? Not saying it's feasible, just interested.

If you do that, you loose the ability to bring in a hotplugged CPU, as
your idmap and your runtime page tables may have conflicting
translations. Or am I missing something obvious?

>>         stack_page = __get_cpu_var(kvm_arm_hyp_stack_page);
>>         hyp_stack_ptr = stack_page + PAGE_SIZE;
>>         vector_ptr = (unsigned long)__kvm_hyp_vector;
>>
>> -       __cpu_init_hyp_mode(pgd_ptr, hyp_stack_ptr, vector_ptr);
>> +       __cpu_init_hyp_mode(boot_pgd_ptr, pgd_ptr, hyp_stack_ptr, vector_ptr);
>>  }
>>
>>  /**
>> @@ -863,11 +865,6 @@ static int init_hyp_mode(void)
>>         }
>>
>>         /*
>> -        * Unmap the identity mapping
>> -        */
>> -       kvm_clear_hyp_idmap();
>> -
>> -       /*
>>          * Map the Hyp-code called directly from the host
>>          */
>>         err = create_hyp_mappings(__kvm_hyp_code_start, __kvm_hyp_code_end);
>> diff --git a/arch/arm/kvm/init.S b/arch/arm/kvm/init.S
>> index 9f37a79..0ca054f 100644
>> --- a/arch/arm/kvm/init.S
>> +++ b/arch/arm/kvm/init.S
>> @@ -21,6 +21,7 @@
>>  #include <asm/asm-offsets.h>
>>  #include <asm/kvm_asm.h>
>>  #include <asm/kvm_arm.h>
>> +#include <asm/kvm_mmu.h>
>>
>>  /********************************************************************
>>   * Hypervisor initialization
>> @@ -28,6 +29,25 @@
>>   *       r0,r1 = Hypervisor pgd pointer
>>   *       r2 = top of Hyp stack (kernel VA)
>>   *       r3 = pointer to hyp vectors
>> + *
>> + * The init scenario is:
>> + * - We jump in HYP with four parameters: boot HYP pgd, runtime HYP pgd,
>> + *   runtime stack, runtime vectors
>> + * - Enable the MMU with the boot pgd
>> + * - Jump to a target into the trampoline page (remember, this is the same
>> + *   physical page!)
>> + * - Now switch to the runtime pgd (same VA, and still the same physical
>> + *   page!)
>> + * - Invalidate TLBs
>> + * - Set stack and vectors
>> + * - Profit! (or eret, if you only care about the code).
>> + *
>> + * As we only have four registers available to pass parameters (and we
>> + * need six), we split the init in two phases:
>> + * - Phase 1: r0,r1 contain the boot PGD, r2 = 0, r3 = 0.
>> + *   Provides the basic HYP init, and enable the MMU.
>> + * - Phase 2: r0,r1 contain the runtime PGD, r2 = ToS, r3 = vectors
>> + *   Switches to the runtime PGD, set stack and vectors.
>>   */
>>
>>         .text
>> @@ -47,6 +67,9 @@ __kvm_hyp_init:
>>         W(b)    .
>>
>>  __do_hyp_init:
>> +       cmp     r2, #0                  @ We have a SP?
>> +       bne     phase2                  @ Yes, second stage init
>> +
>>         @ Set the HTTBR to point to the hypervisor PGD pointer passed
>>         mcrr    p15, 4, r0, r1, c2
>>
>> @@ -96,14 +119,31 @@ __do_hyp_init:
>>         orr     r0, r0, r1
>>         isb
>>         mcr     p15, 4, r0, c1, c0, 0   @ HSCR
>> -       isb
>>
>> -       @ Set stack pointer and return to the kernel
>> +       @ End of init phase-1
>> +       eret
>> +
>> +phase2:
>> +       @ Set stack pointer
>>         mov     sp, r2
>>
>>         @ Set HVBAR to point to the HYP vectors
>>         mcr     p15, 4, r3, c12, c0, 0  @ HVBAR
>>
>> +       @ Jump to the trampoline page
>> +       ldr     r2, =TRAMPOLINE_VA
>> +       adr     r3, target
>> +       bfi     r2, r3, #0, #PAGE_SHIFT
>> +       mov     pc, r2
>> +
>> +target:        @ We're now in the trampoline code, switch page tables
>> +       mcrr    p15, 4, r0, r1, c2
>> +       isb
>> +
>> +       @ Invalidate the old TLBs
>> +       mcr     p15, 4, r0, c8, c7, 0   @ TLBIALLH
>> +       dsb
>> +
>>         eret
>>
>>         .ltorg
>> diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
>> index c4236e4..b20eff2 100644
>> --- a/arch/arm/kvm/mmu.c
>> +++ b/arch/arm/kvm/mmu.c
>> @@ -32,9 +32,15 @@
>>
>>  extern char  __hyp_idmap_text_start[], __hyp_idmap_text_end[];
>>
>> +static pgd_t *boot_hyp_pgd;
>>  static pgd_t *hyp_pgd;
>>  static DEFINE_MUTEX(kvm_hyp_pgd_mutex);
>>
>> +static void *init_bounce_page;
>> +static unsigned long hyp_idmap_start;
>> +static unsigned long hyp_idmap_end;
>> +static phys_addr_t hyp_idmap_vector;
>> +
>>  static void kvm_tlb_flush_vmid_ipa(struct kvm *kvm, phys_addr_t ipa)
>>  {
>>         kvm_call_hyp(__kvm_tlb_flush_vmid_ipa, kvm, ipa);
>> @@ -108,9 +114,12 @@ static void free_hyp_pgd_entry(pgd_t *pgdp, unsigned long addr)
>>  /**
>>   * free_hyp_pgds - free Hyp-mode page tables
>>   *
>> - * Assumes hyp_pgd is a page table used strictly in Hyp-mode and therefore contains
>> - * either mappings in the kernel memory area (above PAGE_OFFSET), or
>> - * device mappings in the vmalloc range (from VMALLOC_START to VMALLOC_END).
>> + * Assumes hyp_pgd is a page table used strictly in Hyp-mode and
>> + * therefore contains either mappings in the kernel memory area (above
>> + * PAGE_OFFSET), or device mappings in the vmalloc range (from
>> + * VMALLOC_START to VMALLOC_END).
>> + *
>> + * boot_hyp_pgd should only map two pages for the init code.
>>   */
>>  void free_hyp_pgds(void)
>>  {
>> @@ -118,6 +127,12 @@ void free_hyp_pgds(void)
>>
>>         mutex_lock(&kvm_hyp_pgd_mutex);
>>
>> +       if (boot_hyp_pgd) {
>> +               free_hyp_pgd_entry(boot_hyp_pgd, hyp_idmap_start);
>> +               free_hyp_pgd_entry(boot_hyp_pgd, TRAMPOLINE_VA);
>> +               kfree(boot_hyp_pgd);
>> +       }
>> +
>>         if (hyp_pgd) {
>>                 for (addr = PAGE_OFFSET; virt_addr_valid(addr); addr += PGDIR_SIZE)
>>                         free_hyp_pgd_entry(hyp_pgd, KERN_TO_HYP(addr));
>> @@ -126,6 +141,7 @@ void free_hyp_pgds(void)
>>                 kfree(hyp_pgd);
>>         }
>>
>> +       kfree(init_bounce_page);
>>         mutex_unlock(&kvm_hyp_pgd_mutex);
>>  }
>>
>> @@ -718,14 +734,62 @@ phys_addr_t kvm_mmu_get_httbr(void)
>>         return virt_to_phys(hyp_pgd);
>>  }
>>
>> +phys_addr_t kvm_mmu_get_boot_httbr(void)
>> +{
>> +       VM_BUG_ON(!virt_addr_valid(boot_hyp_pgd));
> 
> Seems a bit OTT -- it's always going to be in lowmem.

Indeed.

>> +       return virt_to_phys(boot_hyp_pgd);
>> +}
>> +
>> +phys_addr_t kvm_get_idmap_vector(void)
>> +{
>> +       return hyp_idmap_vector;
>> +}
>> +
>>  int kvm_mmu_init(void)
>>  {
>> -       unsigned long hyp_idmap_start = virt_to_phys(__hyp_idmap_text_start);
>> -       unsigned long hyp_idmap_end = virt_to_phys(__hyp_idmap_text_end);
>>         int err;
>>
>> +       hyp_idmap_start = virt_to_phys(__hyp_idmap_text_start);
>> +       hyp_idmap_end = virt_to_phys(__hyp_idmap_text_end);
>> +       hyp_idmap_vector = virt_to_phys(__kvm_hyp_init);
>> +
>> +       if ((hyp_idmap_start ^ hyp_idmap_end) & PAGE_MASK) {
>> +               /*
>> +                * Our init code is crossing a page boundary. Allocate
>> +                * a bounce page, copy the code over and use that.
>> +                */
>> +               size_t len = __hyp_idmap_text_end - __hyp_idmap_text_start;
>> +               phys_addr_t phys_base;
>> +
>> +               init_bounce_page = kzalloc(PAGE_SIZE, GFP_KERNEL);
>> +               if (!init_bounce_page) {
>> +                       kvm_err("Couldn't allocate HYP init bounce page\n");
>> +                       err = -ENOMEM;
>> +                       goto out;
>> +               }
> 
> Given that you don't really need a lowmem page for the bounce page, this
> might be better expressed using alloc_page and kmap for the memcpy.

I'm a bit dubious about that. We have to make sure that the memory is
within the 4GB range, and the only flag I can spot for alloc_page is
GFP_DMA32, which is not exactly what we want, even if it may work.

And yes, we have a problem with platforms having *all* their memory
above 4GB.

> I also wonder whether or not you can eventually free the page and
> corresponding mappings if !CONFIG_HOTPLUG_CPU?

This is indeed possible, as we're sure nothing will use the boot tage
tables once all CPUs have switched to the runtime page tables.

>> +               memcpy(init_bounce_page, __hyp_idmap_text_start, len);
>> +               /*
>> +                * Warning: the code we just copied to the bounce page
>> +                * must be flushed to the point of coherency.
>> +                * Otherwise, the data may be sitting in L2, and HYP
>> +                * mode won't be able to observe it as it runs with
>> +                * caches off at that point.
>> +                */
>> +               kvm_flush_dcache_to_poc(init_bounce_page, len);
>> +
>> +               phys_base = virt_to_phys(init_bounce_page);
>> +               hyp_idmap_vector += phys_base - hyp_idmap_start;
>> +               hyp_idmap_start = phys_base;
>> +               hyp_idmap_end = phys_base + len;
>> +
>> +               kvm_info("Using HYP init bounce page @%lx\n",
>> +                        (unsigned long)phys_base);
>> +       }
>> +
>>         hyp_pgd = kzalloc(PTRS_PER_PGD * sizeof(pgd_t), GFP_KERNEL);
>> -       if (!hyp_pgd) {
>> +       boot_hyp_pgd = kzalloc(PTRS_PER_PGD * sizeof(pgd_t), GFP_KERNEL);
>> +       if (!hyp_pgd || !boot_hyp_pgd) {
>>                 kvm_err("Hyp mode PGD not allocated\n");
>>                 err = -ENOMEM;
>>                 goto out;
>> @@ -743,39 +807,30 @@ int kvm_mmu_init(void)
>>                 goto out;
>>         }
>>
>> +       /* Map the very same page at the trampoline VA */
>> +       err =   __create_hyp_mappings(boot_hyp_pgd,
>> +                                     TRAMPOLINE_VA, TRAMPOLINE_VA + PAGE_SIZE,
>> +                                     __phys_to_pfn(hyp_idmap_start),
>> +                                     PAGE_HYP);
>> +       if (err) {
>> +               kvm_err("Failed to map trampoline @%lx into boot HYP pgd\n",
>> +                       TRAMPOLINE_VA);
>> +               goto out;
>> +       }
>> +
>> +       /* Map the same page again into the runtime page tables */
>> +       err =   __create_hyp_mappings(hyp_pgd,
>> +                                     TRAMPOLINE_VA, TRAMPOLINE_VA + PAGE_SIZE,
>> +                                     __phys_to_pfn(hyp_idmap_start),
>> +                                     PAGE_HYP);
>> +       if (err) {
>> +               kvm_err("Failed to map trampoline @%lx into runtime HYP pgd\n",
>> +                       TRAMPOLINE_VA);
>> +               goto out;
>> +       }
> 
> I'm probably just missing it, but where are the updated page tables flushed
> to memory?

Mumble mumble... We have some partial flush, but clearly not enough of
it to be completely safe. Good spotting.

I'll update the series and send out a v3.

Thanks for reviewing.

	M.
-- 
Jazz is not dead. It just smells funny...
