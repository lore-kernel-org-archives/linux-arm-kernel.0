From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 21 Mar 2017 19:00:37 +0000
Subject: [PATCH v2] arm: Fix memory attribute inconsistencies when using
 fixmap
In-Reply-To: <1490117781.3136.9.camel@linaro.org>
References: <20170321173030.7751-1-tixy@linaro.org>
 <1490117781.3136.9.camel@linaro.org>
Message-ID: <CAKv+Gu82PsyyC=fQHxUn5mrCdmQvhwK+DK342-vv8y53mLcpng@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21 March 2017 at 17:36, Jon Medhurst (Tixy) <tixy@linaro.org> wrote:
> On Tue, 2017-03-21 at 17:30 +0000, Jon Medhurst wrote:
>> To cope with the variety in ARM architectures and configurations, the
>> pagetable attributes for kernel memory are generated at runtime to match
>> the system the kernel finds itself on. This calculated value is stored
>> in pgprot_kernel.
>>
>> However, when early fixmap support was added for arm (commit
>> a5f4c561b3b1) the attributes used for mappings were hard coded because
>> pgprot_kernel is not set up early enough. Unfortunately, when fixmap is
>> used after early boot this means the memory being mapped can have
>> different attributes to existing mappings, potentially leading to
>> unpredictable behaviour. A specific problem also exists due to the hard
>> coded values not include the 'shareable' attribute which means on
>> systems where this matters (e.g. those with multiple CPU clusters) the
>> cache contents for a memory location can become inconsistent between
>> CPUs.
>>
>> To resolve these issues we change fixmap to use the same memory
>> attributes (from pgprot_kernel) that the rest of the kernel uses. To
>> enable this we need to refactor the initialisation code so
>> build_mem_type_table is called early enough. Note, that relies on early
>> param parsing for memory type overrides passed via the kernel command
>> line, so we need to make sure this call is still after
>> parse_early_params().
>>
>> Fixes: a5f4c561b3b1 ("ARM: 8415/1: early fixmap support for earlycon")
>> Cc: stable at vger.kernel.org # v4.3+
>
> Sorry, this should have...
> Signed-off-by: Jon Medhurst <tixy@linaro.org>
>

Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

UEFI boot and earlycon both still work for me, so

Tested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

It looks like nommu should be unaffected, but it is worth giving it a
spin as well


Thanks,
Ard.


>> ---
>>
>> Changes since v1:
>> - Completely rewritten based on Russell's and Ard's sugestions
>> - Subject changed from "arm: Fix cache inconsistency when using fixmap"
>>
>>
>>  arch/arm/include/asm/fixmap.h |  7 +------
>>  arch/arm/include/asm/mmu.h    |  2 ++
>>  arch/arm/kernel/setup.c       |  5 +----
>>  arch/arm/mm/mmu.c             | 12 ++++++++++--
>>  4 files changed, 14 insertions(+), 12 deletions(-)
>>
>> diff --git a/arch/arm/include/asm/fixmap.h b/arch/arm/include/asm/fixmap.h
>> index 5c17d2dec777..c54f06ace2a1 100644
>> --- a/arch/arm/include/asm/fixmap.h
>> +++ b/arch/arm/include/asm/fixmap.h
>> @@ -41,7 +41,7 @@ static const enum fixed_addresses __end_of_fixed_addresses =
>>
>>  #define FIXMAP_PAGE_COMMON   (L_PTE_YOUNG | L_PTE_PRESENT | L_PTE_XN | L_PTE_DIRTY)
>>
>> -#define FIXMAP_PAGE_NORMAL   (FIXMAP_PAGE_COMMON | L_PTE_MT_WRITEBACK)
>> +#define FIXMAP_PAGE_NORMAL   (pgprot_kernel | L_PTE_XN)
>>  #define FIXMAP_PAGE_RO               (FIXMAP_PAGE_NORMAL | L_PTE_RDONLY)
>>
>>  /* Used by set_fixmap_(io|nocache), both meant for mapping a device */
>> @@ -53,13 +53,8 @@ static const enum fixed_addresses __end_of_fixed_addresses =
>>  #ifdef CONFIG_MMU
>>
>>  void __set_fixmap(enum fixed_addresses idx, phys_addr_t phys, pgprot_t prot);
>> -void __init early_fixmap_init(void);
>>
>>  #include <asm-generic/fixmap.h>
>>
>> -#else
>> -
>> -static inline void early_fixmap_init(void) { }
>> -
>>  #endif
>>  #endif
>> diff --git a/arch/arm/include/asm/mmu.h b/arch/arm/include/asm/mmu.h
>> index a5b47421059d..920d29ca5c3b 100644
>> --- a/arch/arm/include/asm/mmu.h
>> +++ b/arch/arm/include/asm/mmu.h
>> @@ -24,6 +24,8 @@ typedef struct {
>>  #define ASID(mm)     (0)
>>  #endif
>>
>> +void early_mm_init(void);
>> +
>>  #else
>>
>>  /*
>> diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
>> index f4e54503afa9..37c59589aac3 100644
>> --- a/arch/arm/kernel/setup.c
>> +++ b/arch/arm/kernel/setup.c
>> @@ -40,7 +40,6 @@
>>  #include <asm/efi.h>
>>  #include <asm/elf.h>
>>  #include <asm/early_ioremap.h>
>> -#include <asm/fixmap.h>
>>  #include <asm/procinfo.h>
>>  #include <asm/psci.h>
>>  #include <asm/sections.h>
>> @@ -1082,12 +1081,10 @@ void __init setup_arch(char **cmdline_p)
>>       strlcpy(cmd_line, boot_command_line, COMMAND_LINE_SIZE);
>>       *cmdline_p = cmd_line;
>>
>> -     early_fixmap_init();
>> -     early_ioremap_init();
>> -
>>       parse_early_param();
>>
>>  #ifdef CONFIG_MMU
>> +     early_mm_init();
>>       early_paging_init(mdesc);
>>  #endif
>>       setup_dma_zone(mdesc);
>> diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
>> index 4e016d7f37b3..f81809e6bd10 100644
>> --- a/arch/arm/mm/mmu.c
>> +++ b/arch/arm/mm/mmu.c
>> @@ -22,6 +22,7 @@
>>  #include <asm/cputype.h>
>>  #include <asm/sections.h>
>>  #include <asm/cachetype.h>
>> +#include <asm/early_ioremap.h>
>>  #include <asm/fixmap.h>
>>  #include <asm/sections.h>
>>  #include <asm/setup.h>
>> @@ -382,7 +383,7 @@ static inline pmd_t * __init fixmap_pmd(unsigned long addr)
>>       return pmd;
>>  }
>>
>> -void __init early_fixmap_init(void)
>> +static void __init early_fixmap_init(void)
>>  {
>>       pmd_t *pmd;
>>
>> @@ -1616,7 +1617,6 @@ void __init paging_init(const struct machine_desc *mdesc)
>>  {
>>       void *zero_page;
>>
>> -     build_mem_type_table();
>>       prepare_page_table();
>>       map_lowmem();
>>       memblock_set_current_limit(arm_lowmem_limit);
>> @@ -1636,3 +1636,11 @@ void __init paging_init(const struct machine_desc *mdesc)
>>       empty_zero_page = virt_to_page(zero_page);
>>       __flush_dcache_page(NULL, empty_zero_page);
>>  }
>> +
>> +void __init early_mm_init(void)
>> +{
>> +     build_mem_type_table();
>> +
>> +     early_fixmap_init();
>> +     early_ioremap_init();
>> +}
