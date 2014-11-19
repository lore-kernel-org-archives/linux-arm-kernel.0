From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 19 Nov 2014 19:06:27 +0100
Subject: [PATCHv5 7/7] arm64: add better page protections to arm64
In-Reply-To: <CAKv+Gu__TZeU4z5=D-znFTv9nKZ1LJK03bkX4pL9ni=cW1tRYA@mail.gmail.com>
References: <1416272105-14787-1-git-send-email-lauraa@codeaurora.org>
 <1416272105-14787-8-git-send-email-lauraa@codeaurora.org>
 <20141119163151.GC12851@leverpostej>
 <CAKv+Gu__TZeU4z5=D-znFTv9nKZ1LJK03bkX4pL9ni=cW1tRYA@mail.gmail.com>
Message-ID: <CAKv+Gu-nxtzSRDNroaT6s5j4tcqBef0qwYdUQyDZuzmYGJwt9g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19 November 2014 18:38, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> On 19 November 2014 17:31, Mark Rutland <mark.rutland@arm.com> wrote:
>> Hi Laura,
>>
>> On Tue, Nov 18, 2014 at 12:55:05AM +0000, Laura Abbott wrote:
>>> Add page protections for arm64 similar to those in arm.
>>> This is for security reasons to prevent certain classes
>>> of exploits. The current method:
>>>
>>> - Map all memory as either RWX or RW. We round to the nearest
>>>   section to avoid creating page tables before everything is mapped
>>> - Once everything is mapped, if either end of the RWX section should
>>>   not be X, we split the PMD and remap as necessary
>>> - When initmem is to be freed, we change the permissions back to
>>>   RW (using stop machine if necessary to flush the TLB)
>>> - If CONFIG_DEBUG_RODATA is set, the read only sections are set
>>>   read only.
>>>
>>> Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
>>> ---
>>> v5:
>>>  -Dropped map_io from the alloc_init_* functions
>>>  -Fixed a bug in split_pud and cleaned it up per suggestions from Steve
>>>  -Aligned _etext up to SECTION_SIZE of DEBUG_ALIGN_RODATA is enabled to ensure
>>>   that the section mapping is actually kept and we don't leak any RWX regions
>>>  -Dropped some old ioremap code that somehow snuck in from the last rebase
>>>  -Fixed create_id_mapping to use the early mapping since efi_idmap_init is
>>>   called early
>>> ---
>>>  arch/arm64/Kconfig.debug            |  23 +++
>>>  arch/arm64/include/asm/cacheflush.h |   4 +
>>>  arch/arm64/kernel/vmlinux.lds.S     |  20 +++
>>>  arch/arm64/mm/init.c                |   1 +
>>>  arch/arm64/mm/mm.h                  |   2 +
>>>  arch/arm64/mm/mmu.c                 | 289 +++++++++++++++++++++++++++++++-----
>>>  6 files changed, 298 insertions(+), 41 deletions(-)
>>
>> Unfortuantely this is blowing up on my Juno atop of v3.18-rc5, because
>> EFI runtime services seem to get mapped as non-executable, and at boot
>> we tried to read the RTC via runtime services:
>>
>> Bad mode in Synchronous Abort handler detected, code 0x8600000d
>> CPU: 1 PID: 1 Comm: swapper/0 Not tainted 3.18.0-rc5+ #23
>> task: ffffffc9768b8000 ti: ffffffc9768c0000 task.ti: ffffffc9768c0000
>> PC is at 0xffffffc97ffaa3e4
>> LR is at virt_efi_get_time+0x60/0xa0
>> pc : [<ffffffc97ffaa3e4>] lr : [<ffffffc00044a6c8>] pstate: 800000c5
>> sp : ffffffc9768c39e0
>> x29: ffffffc9768c39e0 x28: ffffffc000723c90
>> x27: ffffffc0007b5678 x26: 0000000000000001
>> x25: ffffffc000584320 x24: ffffffc0006aaeb0
>> x23: ffffffc9768c3a60 x22: 0000000000000040
>> x21: ffffffc97ffaa3e4 x20: ffffffc0007b5a48
>> x19: ffffffc0007b5a40 x18: 0000000000000007
>> x17: 000000000000000e x16: 0000000000000001
>> x15: 0000000000000007 x14: 0ffffffffffffffe
>> x13: ffffffbe22feb720 x12: 0000000000000030
>> x11: 0000000000000003 x10: 0000000000000068
>> x9 : 0000000000000000 x8 : ffffffc97f981c00
>> x7 : 0000000000000000 x6 : 000000000000003f
>> x5 : 0000000000000040 x4 : 000000097f6c8000
>> x3 : 0000000000000000 x2 : 000000097f6c8000
>> x1 : ffffffc9768c3a50 x0 : ffffffc9768c3a60
>>
>> Ard, is this issue solved by any current series, or do we need to do
>> anything additional to ensure runtime services are mapped appropriately
>> for DEBUG_RODATA kernels?
>>
>
> This problem will just vanish with my uefi virtmap series, because
> then UEFI manages its own page tables.
> I use PXN for everything except EFI_RUNTIME_SERVICES_CODE (which
> [sadly] contains read-write data as well, due to how the PE/COFF
> loader in UEFI usually implemented, i.e., it allocates one single
> region to hold the entire static image, including .data and .bss).
> Once these changes land, the UEFI page tables will only be active
> during actual Runtime Services calls, so the attack service should be
> reduced substantially.
>

*surface*

> For now, i guess adding a set_memory_x() in remap_region() for
> EFI_RUNTIME_SERVICES_CODE should suffice?
>
> --
> Ard.
>
>
>>> diff --git a/arch/arm64/Kconfig.debug b/arch/arm64/Kconfig.debug
>>> index 0a12933..867fe6f1 100644
>>> --- a/arch/arm64/Kconfig.debug
>>> +++ b/arch/arm64/Kconfig.debug
>>> @@ -54,4 +54,27 @@ config DEBUG_SET_MODULE_RONX
>>>            against certain classes of kernel exploits.
>>>            If in doubt, say "N".
>>>
>>> +config DEBUG_RODATA
>>> +       bool "Make kernel text and rodata read-only"
>>> +       help
>>> +         If this is set, kernel text and rodata will be made read-only. This
>>> +         is to help catch accidental or malicious attempts to change the
>>> +         kernel's executable code. Additionally splits rodata from kernel
>>> +         text so it can be made explicitly non-executable.
>>> +
>>> +          If in doubt, say Y
>>> +
>>> +config DEBUG_ALIGN_RODATA
>>> +       depends on DEBUG_RODATA && !ARM64_64K_PAGES
>>> +       bool "Align linker sections up to SECTION_SIZE"
>>> +       help
>>> +         If this option is enabled, sections that may potentially be marked as
>>> +         read only or non-executable will be aligned up to the section size of
>>> +         the kernel. This prevents sections from being split into pages and
>>> +         avoids a potential TLB penalty. The downside is an increase in
>>> +         alignment and potentially wasted space. Turn on this option if
>>> +         performance is more important than memory pressure.
>>> +
>>> +         If in doubt, say N
>>> +
>>>  endmenu
>>> diff --git a/arch/arm64/include/asm/cacheflush.h b/arch/arm64/include/asm/cacheflush.h
>>> index 689b637..0014207 100644
>>> --- a/arch/arm64/include/asm/cacheflush.h
>>> +++ b/arch/arm64/include/asm/cacheflush.h
>>> @@ -152,4 +152,8 @@ int set_memory_ro(unsigned long addr, int numpages);
>>>  int set_memory_rw(unsigned long addr, int numpages);
>>>  int set_memory_x(unsigned long addr, int numpages);
>>>  int set_memory_nx(unsigned long addr, int numpages);
>>> +
>>> +#ifdef CONFIG_DEBUG_RODATA
>>> +void mark_rodata_ro(void);
>>> +#endif
>>>  #endif
>>> diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
>>> index 2d7e20a..405820d 100644
>>> --- a/arch/arm64/kernel/vmlinux.lds.S
>>> +++ b/arch/arm64/kernel/vmlinux.lds.S
>>> @@ -8,6 +8,7 @@
>>>  #include <asm/thread_info.h>
>>>  #include <asm/memory.h>
>>>  #include <asm/page.h>
>>> +#include <asm/pgtable.h>
>>>
>>>  #include "image.h"
>>>
>>> @@ -54,6 +55,9 @@ SECTIONS
>>>                 _text = .;
>>>                 HEAD_TEXT
>>>         }
>>> +#ifdef CONFIG_DEBUG_ALIGN_RODATA
>>> +       . = ALIGN(1<<SECTION_SHIFT);
>>> +#endif
>>
>> Could we have macros defined once above, something like:
>>
>> #ifdef CONFIG_DEBUG_ALIGN_RODATA
>> #define ALIGN_DEBUG_RO                  . = ALIGN(1<<SECTION_SHIFT);
>> #define ALIGN_DEBUG_RO_MIN(min)         ALIGN_DEBUG_RO
>> #else
>> #define ALIGN_DEBUG_RO
>> #define ALIGN_DEBUG_RO_MIN(min)         . = ALIGN(min)
>> #endif
>>
>> Then we can avoid all the ifdefs below.
>>
>>>         .text : {                       /* Real text segment            */
>>>                 _stext = .;             /* Text and read-only data      */
>>>                         *(.latehead.text)
>>> @@ -71,19 +75,35 @@ SECTIONS
>>>                 *(.got)                 /* Global offset table          */
>>>         }
>>>
>>> +#ifdef CONFIG_DEBUG_ALIGN_RODATA
>>> +       . = ALIGN(1<<SECTION_SHIFT);
>>> +#endif
>>>         RO_DATA(PAGE_SIZE)
>>>         EXCEPTION_TABLE(8)
>>>         NOTES
>>> +#ifdef CONFIG_DEBUG_ALIGN_RODATA
>>> +       . = ALIGN(1<<SECTION_SHIFT);
>>> +#endif
>>>         _etext = .;                     /* End of text and rodata section */
>>>
>>> +#ifdef CONFIG_DEBUG_ALIGN_RODATA
>>> +       . = ALIGN(1<<SECTION_SHIFT);
>>> +#else
>>>         . = ALIGN(PAGE_SIZE);
>>> +#endif
>>>         __init_begin = .;
>>>
>>>         INIT_TEXT_SECTION(8)
>>>         .exit.text : {
>>>                 ARM_EXIT_KEEP(EXIT_TEXT)
>>>         }
>>> +
>>> +#ifdef CONFIG_DEBUG_ALIGN_RODATA
>>> +       . = ALIGN(1<<SECTION_SHIFT);
>>> +       __init_data_begin = .;
>>
>> Is this used anywhere? we seem to have left __init_end after this, and
>> haven't introduced an __init_data_end.
>>
>>> +#else
>>>         . = ALIGN(16);
>>> +#endif
>>>         .init.data : {
>>>                 INIT_DATA
>>>                 INIT_SETUP(16)
>>> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
>>> index 494297c..61f44c7 100644
>>> --- a/arch/arm64/mm/init.c
>>> +++ b/arch/arm64/mm/init.c
>>> @@ -324,6 +324,7 @@ void __init mem_init(void)
>>>
>>>  void free_initmem(void)
>>>  {
>>> +       fixup_init();
>>>         free_initmem_default(0);
>>>  }
>>>
>>> diff --git a/arch/arm64/mm/mm.h b/arch/arm64/mm/mm.h
>>> index d519f4f..82347d8 100644
>>> --- a/arch/arm64/mm/mm.h
>>> +++ b/arch/arm64/mm/mm.h
>>> @@ -1,2 +1,4 @@
>>>  extern void __init bootmem_init(void);
>>>  extern void __init arm64_swiotlb_init(void);
>>> +
>>> +void fixup_init(void);
>>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>>> index 6032f3e..dafde8e 100644
>>> --- a/arch/arm64/mm/mmu.c
>>> +++ b/arch/arm64/mm/mmu.c
>>> @@ -26,6 +26,7 @@
>>>  #include <linux/memblock.h>
>>>  #include <linux/fs.h>
>>>  #include <linux/io.h>
>>> +#include <linux/stop_machine.h>
>>>
>>>  #include <asm/cputype.h>
>>>  #include <asm/fixmap.h>
>>> @@ -137,17 +138,55 @@ static void __init *early_alloc(unsigned long sz)
>>>         return ptr;
>>>  }
>>>
>>> -static void __init alloc_init_pte(pmd_t *pmd, unsigned long addr,
>>> +/*
>>> + * remap a PMD into pages
>>> + */
>>> +static noinline void __ref split_pmd(pmd_t *pmd, bool early)
>>> +{
>>> +       pte_t *pte, *start_pte;
>>> +       unsigned long pfn;
>>> +       int i = 0;
>>> +
>>> +       if (early)
>>> +               start_pte = pte = early_alloc(PTRS_PER_PTE*sizeof(pte_t));
>>> +       else
>>> +               start_pte = pte = (pte_t *)__get_free_page(PGALLOC_GFP);
>>> +
>>> +       BUG_ON(!pte);
>>> +
>>> +       pfn = pmd_pfn(*pmd);
>>> +
>>> +       do {
>>> +               /*
>>> +                * Need to have the least restrictive permissions available
>>> +                * permissions will be fixed up later
>>> +                */
>>> +               set_pte(pte, pfn_pte(pfn, PAGE_KERNEL_EXEC));
>>> +               pfn++;
>>> +       } while (pte++, i++, i < PTRS_PER_PTE);
>>> +
>>> +
>>> +       __pmd_populate(pmd, __pa(start_pte), PMD_TYPE_TABLE);
>>> +       flush_tlb_all();
>>> +}
>>> +
>>> +static void __ref alloc_init_pte(pmd_t *pmd, unsigned long addr,
>>>                                   unsigned long end, unsigned long pfn,
>>> -                                 pgprot_t prot)
>>> +                                 pgprot_t prot, bool early)
>>>  {
>>>         pte_t *pte;
>>>
>>>         if (pmd_none(*pmd)) {
>>> -               pte = early_alloc(PTRS_PER_PTE * sizeof(pte_t));
>>> +               if (early)
>>> +                       pte = early_alloc(PTRS_PER_PTE * sizeof(pte_t));
>>> +               else
>>> +                       pte = (pte_t *)__get_free_page(PGALLOC_GFP);
>>> +               BUG_ON(!pte);
>>>                 __pmd_populate(pmd, __pa(pte), PMD_TYPE_TABLE);
>>>         }
>>> -       BUG_ON(pmd_bad(*pmd));
>>> +
>>> +       if (pmd_bad(*pmd))
>>> +               split_pmd(pmd, early);
>>>
>>>         pte = pte_offset_kernel(pmd, addr);
>>>         do {
>>> @@ -156,29 +195,44 @@ static void __init alloc_init_pte(pmd_t *pmd, unsigned long addr,
>>>         } while (pte++, addr += PAGE_SIZE, addr != end);
>>>  }
>>>
>>> -static void __init alloc_init_pmd(pud_t *pud, unsigned long addr,
>>> +void __ref split_pud(pud_t *old_pud, pmd_t *pmd)
>>> +{
>>> +       unsigned long addr = pud_pfn(*old_pud) << PAGE_SHIFT;
>>> +       pgprot_t prot = __pgprot(pud_val(*old_pud) ^ pud_pfn(*old_pud));
>>> +       int i = 0;
>>> +
>>> +       do {
>>> +               set_pmd(pmd, __pmd(addr | prot));
>>> +               addr += PMD_SIZE;
>>> +       } while (pmd++, i++, i < PTRS_PER_PMD);
>>> +}
>>
>> As far as I can see only the functions which call early_alloc
>> (split_pmd, alloc_init_pte, alloc_init_pmd) need the __ref annotation,
>> so we can drop it heere and elsewhere.
>>
>> It would be nice if we could avoid the mismatch entirely. Perhaps we
>> could pass an allocator function down instead of the early parameter?
>> Something like:
>>
>> static void *late_alloc(unsigned long sz)
>> {
>>         BUG_ON(PAGE_SIZE < sz);
>>         return (void *)__get_free_page(PGALLOC_GFP);
>> }
>>
>> which we could pass down from create_mapping_late in place of
>> early_alloc for create_id_mapping and create_mapping.
>>
>> Thanks,
>> Mark.
