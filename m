From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 11 Mar 2015 08:05:58 +0100
Subject: [PATCH 2/5] arm64: use fixmap region for permanent FDT mapping
In-Reply-To: <CAL_JsqLdFS_nGuLTxrEZPCQv8MtW0s5jQ9Od1qj41yoqX40ONQ@mail.gmail.com>
References: <1425380630-3684-1-git-send-email-ard.biesheuvel@linaro.org>
 <1425380630-3684-3-git-send-email-ard.biesheuvel@linaro.org>
 <CAL_JsqLdFS_nGuLTxrEZPCQv8MtW0s5jQ9Od1qj41yoqX40ONQ@mail.gmail.com>
Message-ID: <CAKv+Gu8xrb0QqeFCfbqOb2sxFPyT8cVaq_RkhiD5jrr8L0zYzA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10 March 2015 at 22:37, Rob Herring <robh@kernel.org> wrote:
> On Tue, Mar 3, 2015 at 5:03 AM, Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
>> Currently, the FDT blob needs to be in the same naturally aligned
>> 512 MB region as the kernel, so that it can be mapped into the
>> kernel virtual memory space very early on using a minimal set of
>> statically allocated translation tables.
>>
>> Now that we have early fixmap support, we can relax this restriction,
>> by moving the permanent FDT mapping to the fixmap region instead.
>> This way, the FDT blob may be anywhere in memory.
>>
>> This also moves the vetting of the FDT to setup.c, since the early
>> init code in head.S does not handle mapping of the FDT anymore.
>> At the same time, fix up some comments in head.S that have gone stale.
>>
>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> ---
>>  Documentation/arm64/booting.txt |  7 ++---
>>  arch/arm64/include/asm/fixmap.h |  9 ++++++
>>  arch/arm64/kernel/Makefile      |  1 +
>>  arch/arm64/kernel/head.S        | 38 +------------------------
>>  arch/arm64/kernel/setup.c       | 62 +++++++++++++++++++++++++++++++++++++----
>>  5 files changed, 70 insertions(+), 47 deletions(-)
>>
>> diff --git a/Documentation/arm64/booting.txt b/Documentation/arm64/booting.txt
>> index f3c05b5f9f08..bdc35fc97ac8 100644
>> --- a/Documentation/arm64/booting.txt
>> +++ b/Documentation/arm64/booting.txt
>> @@ -45,10 +45,9 @@ sees fit.)
>>
>>  Requirement: MANDATORY
>>
>> -The device tree blob (dtb) must be placed on an 8-byte boundary within
>> -the first 512 megabytes from the start of the kernel image and must not
>> -cross a 2-megabyte boundary. This is to allow the kernel to map the
>> -blob using a single section mapping in the initial page tables.
>> +The device tree blob (dtb) must be placed on an 8-byte boundary and must
>> +not cross a 2-megabyte boundary. This is to allow the kernel to map the
>> +blob using a single section mapping in the fixmap region.
>>
>>
>>  3. Decompress the kernel image
>> diff --git a/arch/arm64/include/asm/fixmap.h b/arch/arm64/include/asm/fixmap.h
>> index defa0ff98250..4ad240a60898 100644
>> --- a/arch/arm64/include/asm/fixmap.h
>> +++ b/arch/arm64/include/asm/fixmap.h
>> @@ -32,6 +32,15 @@
>>   */
>>  enum fixed_addresses {
>>         FIX_HOLE,
>> +
>> +       /*
>> +        * Reserve 2 MB of virtual space for the FDT at the top of the fixmap
>> +        * region. Keep this at the top so it remains 2 MB aligned.
>> +        */
>
> We should not fix a location restriction by creating a size
> restriction. You could embed firmware images within a DTB (which I
> think PPC does).
>

The size restriction existed on arm64 before this patch, so I didn't
think twice about it.
So what would be a reasonable upper bound? We could go up to ~256 MB
without much trouble, but I guess that's a bit excessive, no?


>> +#define FIX_FDT_SIZE           SZ_2M
>> +       FIX_FDT_END,
>> +       FIX_FDT = FIX_FDT_END + FIX_FDT_SIZE / PAGE_SIZE - 1,
>> +
>>         FIX_EARLYCON_MEM_BASE,
>>         __end_of_permanent_fixed_addresses,
>>
>> diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
>> index 5ee07eee80c2..e60885766936 100644
>> --- a/arch/arm64/kernel/Makefile
>> +++ b/arch/arm64/kernel/Makefile
>> @@ -6,6 +6,7 @@ CPPFLAGS_vmlinux.lds    := -DTEXT_OFFSET=$(TEXT_OFFSET)
>>  AFLAGS_head.o          := -DTEXT_OFFSET=$(TEXT_OFFSET)
>>  CFLAGS_efi-stub.o      := -DTEXT_OFFSET=$(TEXT_OFFSET)
>>  CFLAGS_armv8_deprecated.o := -I$(src)
>> +CFLAGS_setup.o         := -I$(srctree)/scripts/dtc/libfdt/
>>
>>  CFLAGS_REMOVE_ftrace.o = -pg
>>  CFLAGS_REMOVE_insn.o = -pg
>> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
>> index 8ce88e08c030..66675d27fea3 100644
>> --- a/arch/arm64/kernel/head.S
>> +++ b/arch/arm64/kernel/head.S
>> @@ -255,7 +255,6 @@ ENTRY(stext)
>>         cbnz    x23, 1f                         // invalid processor (x23=0)?
>>         b       __error_p
>>  1:
>> -       bl      __vet_fdt
>>         bl      __create_page_tables            // x25=TTBR0, x26=TTBR1
>>         /*
>>          * The following calls CPU specific code in a position independent
>> @@ -274,24 +273,6 @@ ENTRY(stext)
>>  ENDPROC(stext)
>>
>>  /*
>> - * Determine validity of the x21 FDT pointer.
>> - * The dtb must be 8-byte aligned and live in the first 512M of memory.
>> - */
>> -__vet_fdt:
>> -       tst     x21, #0x7
>> -       b.ne    1f
>> -       cmp     x21, x24
>> -       b.lt    1f
>> -       mov     x0, #(1 << 29)
>> -       add     x0, x0, x24
>> -       cmp     x21, x0
>> -       b.ge    1f
>> -       ret
>> -1:
>> -       mov     x21, #0
>> -       ret
>> -ENDPROC(__vet_fdt)
>> -/*
>>   * Macro to create a table entry to the next page.
>>   *
>>   *     tbl:    page table address
>> @@ -352,8 +333,7 @@ ENDPROC(__vet_fdt)
>>   * required to get the kernel running. The following sections are required:
>>   *   - identity mapping to enable the MMU (low address, TTBR0)
>>   *   - first few MB of the kernel linear mapping to jump to once the MMU has
>> - *     been enabled, including the FDT blob (TTBR1)
>> - *   - pgd entry for fixed mappings (TTBR1)
>> + *     been enabled
>>   */
>>  __create_page_tables:
>>         pgtbl   x25, x26, x28                   // idmap_pg_dir and swapper_pg_dir addresses
>> @@ -404,22 +384,6 @@ __create_page_tables:
>>         create_block_map x0, x7, x3, x5, x6
>>
>>         /*
>> -        * Map the FDT blob (maximum 2MB; must be within 512MB of
>> -        * PHYS_OFFSET).
>> -        */
>> -       mov     x3, x21                         // FDT phys address
>> -       and     x3, x3, #~((1 << 21) - 1)       // 2MB aligned
>> -       mov     x6, #PAGE_OFFSET
>> -       sub     x5, x3, x24                     // subtract PHYS_OFFSET
>> -       tst     x5, #~((1 << 29) - 1)           // within 512MB?
>> -       csel    x21, xzr, x21, ne               // zero the FDT pointer
>> -       b.ne    1f
>> -       add     x5, x5, x6                      // __va(FDT blob)
>> -       add     x6, x5, #1 << 21                // 2MB for the FDT blob
>> -       sub     x6, x6, #1                      // inclusive range
>> -       create_block_map x0, x7, x3, x5, x6
>> -1:
>> -       /*
>>          * Since the page tables have been populated with non-cacheable
>>          * accesses (MMU disabled), invalidate the idmap and swapper page
>>          * tables again to remove any speculatively loaded cache lines.
>> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
>> index e8420f635bd4..5c675a09116e 100644
>> --- a/arch/arm64/kernel/setup.c
>> +++ b/arch/arm64/kernel/setup.c
>> @@ -45,6 +45,7 @@
>>  #include <linux/of_platform.h>
>>  #include <linux/efi.h>
>>  #include <linux/personality.h>
>> +#include <linux/libfdt.h>
>>
>>  #include <asm/fixmap.h>
>>  #include <asm/cpu.h>
>> @@ -307,14 +308,63 @@ static void __init setup_processor(void)
>>  #endif
>>  }
>>
>> +static unsigned long const dt_virt_base = __fix_to_virt(FIX_FDT);
>> +static phys_addr_t dt_phys_base;
>> +
>> +phys_addr_t __init fdt_virt_to_phys(void *virt)
>> +{
>> +       return (phys_addr_t)virt - dt_virt_base + dt_phys_base;
>> +}
>> +
>> +static void *__init fixmap_remap_fdt(phys_addr_t dt_phys)
>> +{
>> +       dt_phys_base = dt_phys & ~(FIX_FDT_SIZE - 1);
>> +
>> +       /*
>> +        * Make sure that the FDT region can be mapped without the need to
>> +        * allocate additional translation table pages, so that it is safe
>> +        * to call create_pgd_mapping() this early.
>> +        * On 4k pages, we'll use a section mapping for the 2 MB region so we
>> +        * only have to be in the same PUD as the rest of the fixmap.
>> +        * On 64k pages, we need to be in the same PMD as well, as the region
>> +        * will be mapped using PTEs.
>> +        */
>> +       BUILD_BUG_ON(dt_virt_base & (FIX_FDT_SIZE - 1));
>> +
>> +       if (IS_ENABLED(CONFIG_ARM64_64K_PAGES))
>> +               BUILD_BUG_ON(dt_virt_base >> PMD_SHIFT !=
>> +                            __fix_to_virt(FIX_BTMAP_BEGIN) >> PMD_SHIFT);
>> +       else
>> +               BUILD_BUG_ON(dt_virt_base >> PUD_SHIFT !=
>> +                            __fix_to_virt(FIX_BTMAP_BEGIN) >> PUD_SHIFT);
>> +
>> +       create_pgd_mapping(&init_mm, dt_phys_base, dt_virt_base, FIX_FDT_SIZE,
>> +                          PAGE_KERNEL);
>> +
>> +       return (void *)(dt_virt_base + dt_phys - dt_phys_base);
>> +}
>> +
>>  static void __init setup_machine_fdt(phys_addr_t dt_phys)
>>  {
>> -       if (!dt_phys || !early_init_dt_scan(phys_to_virt(dt_phys))) {
>> +       void *dt_virt = NULL;
>> +
>> +       if (dt_phys && (dt_phys & 7) == 0)
>> +               dt_virt = fixmap_remap_fdt(dt_phys);
>> +
>> +       /*
>> +        * Before passing the dt_virt pointer to early_init_dt_scan(), we have
>> +        * to ensure that the FDT size as reported in the FDT itself does not
>> +        * exceed the 2 MB window we just mapped for it.
>> +        */
>> +       if (!dt_virt ||
>> +           fdt_check_header(dt_virt) != 0 ||
>> +           (dt_phys & (SZ_2M - 1)) + fdt_totalsize(dt_virt) > SZ_2M ||
>> +           !early_init_dt_scan(dt_virt)) {
>>                 early_print("\n"
>>                         "Error: invalid device tree blob at physical address 0x%p (virtual address 0x%p)\n"
>> -                       "The dtb must be 8-byte aligned and passed in the first 512MB of memory\n"
>> +                       "The dtb must be 8-byte aligned and must not cross a 2 MB alignment boundary\n"
>>                         "\nPlease check your bootloader.\n",
>> -                       dt_phys, phys_to_virt(dt_phys));
>> +                       dt_phys, dt_virt);
>>
>>                 while (true)
>>                         cpu_relax();
>> @@ -357,6 +407,9 @@ void __init setup_arch(char **cmdline_p)
>>  {
>>         setup_processor();
>>
>> +       early_fixmap_init();
>> +       early_ioremap_init();
>> +
>>         setup_machine_fdt(__fdt_pointer);
>>
>>         init_mm.start_code = (unsigned long) _text;
>> @@ -366,9 +419,6 @@ void __init setup_arch(char **cmdline_p)
>>
>>         *cmdline_p = boot_command_line;
>>
>> -       early_fixmap_init();
>> -       early_ioremap_init();
>> -
>>         parse_early_param();
>>
>>         /*
>> --
>> 1.8.3.2
>>
