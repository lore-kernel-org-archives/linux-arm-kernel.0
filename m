From: bhsharma@redhat.com (Bhupesh Sharma)
Date: Wed, 31 Jan 2018 11:20:20 +0530
Subject: [PATCH] arm64: kdump: retain reserved memory regions
In-Reply-To: <CAKv+Gu-Y+Y-h8q0jW4p+ckz76NFZBYLfdhvX=qtzvTnkJWS0FA@mail.gmail.com>
References: <20180110100943.6082-1-takahiro.akashi@linaro.org>
 <5A55F87F.2080501@arm.com> <20180111113840.GF18820@linaro.org>
 <5A61D90E.1000907@arm.com> <20180129081225.GA23847@linaro.org>
 <CAKv+Gu-Y+Y-h8q0jW4p+ckz76NFZBYLfdhvX=qtzvTnkJWS0FA@mail.gmail.com>
Message-ID: <CACi5LpNyKYCouWERPMYONO09kcvfnyM06_88QSu7kS8Qa2KeuQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ard, Akashi,

On Mon, Jan 29, 2018 at 5:41 PM, Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> On 29 January 2018 at 08:12, AKASHI Takahiro <takahiro.akashi@linaro.org> wrote:
>> James,
>>
>> On Fri, Jan 19, 2018 at 11:39:58AM +0000, James Morse wrote:
>>> Hi Akashi,
>>>
>>> On 11/01/18 11:38, AKASHI Takahiro wrote:
>>> > On Wed, Jan 10, 2018 at 11:26:55AM +0000, James Morse wrote:
>>> >> On 10/01/18 10:09, AKASHI Takahiro wrote:
>>> >>> This is a fix against the issue that crash dump kernel may hang up
>>> >>> during booting, which can happen on any ACPI-based system with "ACPI
>>> >>> Reclaim Memory."
>>>
>>> >>> (diagnosis)
>>> >>> * This fault is a data abort, alignment fault (ESR=0x96000021)
>>> >>>   during reading out ACPI table.
>>> >>> * Initial ACPI tables are normally stored in system ram and marked as
>>> >>>   "ACPI Reclaim memory" by the firmware.
>>> >>> * After the commit f56ab9a5b73c ("efi/arm: Don't mark ACPI reclaim
>>> >>>   memory as MEMBLOCK_NOMAP"), those regions' attribute were changed
>>> >>>   removing NOMAP bit and they are instead "memblock-reserved".
>>> >>> * When crash dump kernel boots up, it tries to accesses ACPI tables by
>>> >>>   ioremap'ing them (through acpi_os_ioremap()).
>>> >>> * Since those regions are not included in device tree's
>>> >>>   "usable-memory-range" and so not recognized as part of crash dump
>>> >>>   kernel's system ram, ioremap() will create a non-cacheable mapping here.
>>> >>
>>> >> Ugh, because acpi_os_ioremap() looks at the efi memory map through the prism of
>>> >> what we pulled into memblock, which is different during kdump.
>>> >>
>>> >> Is an alternative to teach acpi_os_ioremap() to ask
>>> >> efi_mem_attributes() directly for the attributes to use?
>>> >> (e.g. arch_apei_get_mem_attribute())
>>> >
>>> > I didn't think of this approach.
>>> > Do you mean a change like the patch below?
>>>
>>> Yes. Aha, you can pretty much re-use the helper directly.
>>>
>>> It was just a suggestion, removing the extra abstraction that is causing the bug
>>> could be cleaner ...
>>>
>>> > (I'm still debugging this code since the kernel fails to boot.)
>>>
>>> ... but might be too fragile.
>>>
>>> There are points during boot when the EFI memory map isn't mapped.
>>
>> Right, this was a problem for my patch.
>> Attached is the revised and workable one.
>> Efi_memmap_init_late() may alternatively be called in acpi_early_init() or
>> even in acpi_os_ioremap(), but either way it looks a bit odd.
>>
>
> Akashi-san,
>
> efi_memmap_init_late() is currently being called from
> arm_enable_runtime_services(), which is an early initcall. If that is
> too late for acpi_early_init(), we could perhaps move the call
> forward, i.e., sth like
>
> ---------8<------------
> diff --git a/drivers/firmware/efi/arm-runtime.c
> b/drivers/firmware/efi/arm-runtime.c
> index 6f60d659b323..e835d3b20af6 100644
> --- a/drivers/firmware/efi/arm-runtime.c
> +++ b/drivers/firmware/efi/arm-runtime.c
> @@ -117,7 +117,7 @@ static bool __init efi_virtmap_init(void)
>   * non-early mapping of the UEFI system table and virtual mappings for all
>   * EFI_MEMORY_RUNTIME regions.
>   */
> -static int __init arm_enable_runtime_services(void)
> +void __init efi_enter_virtual_mode(void)
>  {
>         u64 mapsize;
>
> @@ -156,7 +156,6 @@ static int __init arm_enable_runtime_services(void)
>
>         return 0;
>  }
> -early_initcall(arm_enable_runtime_services);
>
>  void efi_virtmap_load(void)
>  {
> diff --git a/init/main.c b/init/main.c
> index a8100b954839..2d0927768e2d 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -674,6 +674,9 @@ asmlinkage __visible void __init start_kernel(void)
>         debug_objects_mem_init();
>         setup_per_cpu_pageset();
>         numa_policy_init();
> +       if (IS_ENABLED(CONFIG_EFI) &&
> +           (IS_ENABLED(CONFIG_ARM64) || IS_ENABLED(CONFIG_ARM)))
> +               efi_enter_virtual_mode();
>         acpi_early_init();
>         if (late_time_init)
>                 late_time_init();
> ---------8<------------
>
> would be reasonable imo. Also, I think it is justifiable to make ACPI
> depend on UEFI on arm64, which is notably different from x86.
>
> (I know 'efi_enter_virtual_mode' is not entirely accurate here, given
> that we call SetVirtualAddressMap from the UEFI stub on ARM, but it is
> still close enough, given that one could argue that EFI is not in
> 'virtual mode' until the mappings are in place)
>
>
>
>> ===8<===
>> From c88f4c8106ba7a918c835b1cdf538b1d21019863 Mon Sep 17 00:00:00 2001
>> From: AKASHI Takahiro <takahiro.akashi@linaro.org>
>> Date: Mon, 29 Jan 2018 15:07:43 +0900
>> Subject: [PATCH] arm64: kdump: make acpi_os_ioremap() more generic
>>
>> ---
>>  arch/arm64/include/asm/acpi.h | 23 ++++++++++++++++-------
>>  arch/arm64/kernel/acpi.c      |  7 ++-----
>>  init/main.c                   |  4 ++++
>>  3 files changed, 22 insertions(+), 12 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
>> index 32f465a80e4e..d53c95f4e1a9 100644
>> --- a/arch/arm64/include/asm/acpi.h
>> +++ b/arch/arm64/include/asm/acpi.h
>> @@ -12,10 +12,12 @@
>>  #ifndef _ASM_ACPI_H
>>  #define _ASM_ACPI_H
>>
>> +#include <linux/efi.h>
>>  #include <linux/memblock.h>
>>  #include <linux/psci.h>
>>
>>  #include <asm/cputype.h>
>> +#include <asm/io.h>
>>  #include <asm/smp_plat.h>
>>  #include <asm/tlbflush.h>
>>
>> @@ -29,18 +31,22 @@
>>
>>  /* Basic configuration for ACPI */
>>  #ifdef CONFIG_ACPI
>> +pgprot_t __acpi_get_mem_attribute(phys_addr_t addr);
>> +
>>  /* ACPI table mapping after acpi_permanent_mmap is set */
>>  static inline void __iomem *acpi_os_ioremap(acpi_physical_address phys,
>>                                             acpi_size size)
>>  {
>> +       /* For normal memory we already have a cacheable mapping. */
>> +       if (memblock_is_map_memory(phys))
>> +               return (void __iomem *)__phys_to_virt(phys);
>> +
>>         /*
>> -        * EFI's reserve_regions() call adds memory with the WB attribute
>> -        * to memblock via early_init_dt_add_memory_arch().
>> +        * We should still honor the memory's attribute here because
>> +        * crash dump kernel possibly excludes some ACPI (reclaim)
>> +        * regions from memblock list.
>>          */
>> -       if (!memblock_is_memory(phys))
>> -               return ioremap(phys, size);
>> -
>> -       return ioremap_cache(phys, size);
>> +       return __ioremap(phys, size, __acpi_get_mem_attribute(phys));
>>  }
>>  #define acpi_os_ioremap acpi_os_ioremap
>>
>> @@ -125,7 +131,10 @@ static inline const char *acpi_get_enable_method(int cpu)
>>   * for compatibility.
>>   */
>>  #define acpi_disable_cmcff 1
>> -pgprot_t arch_apei_get_mem_attribute(phys_addr_t addr);
>> +static inline pgprot_t arch_apei_get_mem_attribute(phys_addr_t addr)
>> +{
>> +       return __acpi_get_mem_attribute(addr);
>> +}
>>  #endif /* CONFIG_ACPI_APEI */
>>
>>  #ifdef CONFIG_ACPI_NUMA
>> diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
>> index b3162715ed78..f94bdf7be439 100644
>> --- a/arch/arm64/kernel/acpi.c
>> +++ b/arch/arm64/kernel/acpi.c
>> @@ -31,10 +31,9 @@
>>  #include <asm/cpu_ops.h>
>>  #include <asm/smp_plat.h>
>>
>> -#ifdef CONFIG_ACPI_APEI
>> +/* CONFIG_ACPI_APEI */
>>  # include <linux/efi.h>
>>  # include <asm/pgtable.h>
>> -#endif
>>
>>  int acpi_noirq = 1;            /* skip ACPI IRQ initialization */
>>  int acpi_disabled = 1;
>> @@ -239,8 +238,7 @@ void __init acpi_boot_table_init(void)
>>         }
>>  }
>>
>> -#ifdef CONFIG_ACPI_APEI
>> -pgprot_t arch_apei_get_mem_attribute(phys_addr_t addr)
>> +pgprot_t __acpi_get_mem_attribute(phys_addr_t addr)
>>  {
>>         /*
>>          * According to "Table 8 Map: EFI memory types to AArch64 memory
>> @@ -261,4 +259,3 @@ pgprot_t arch_apei_get_mem_attribute(phys_addr_t addr)
>>                 return __pgprot(PROT_NORMAL_NC);
>>         return __pgprot(PROT_DEVICE_nGnRnE);
>>  }
>> -#endif
>> diff --git a/init/main.c b/init/main.c
>> index a8100b954839..a479ece2bae9 100644
>> --- a/init/main.c
>> +++ b/init/main.c
>> @@ -674,6 +674,10 @@ asmlinkage __visible void __init start_kernel(void)
>>         debug_objects_mem_init();
>>         setup_per_cpu_pageset();
>>         numa_policy_init();
>> +#if defined(CONFIG_ARM64) && defined(CONFIG_EFI)
>> +       efi_memmap_init_late(efi.memmap.phys_map,
>> +                       efi.memmap.nr_map * efi.memmap.desc_size);
>> +#endif
>>         acpi_early_init();
>>         if (late_time_init)
>>                 late_time_init();
>> --
>> 2.15.1
>>

I tested Ard's patch (on top of Akashi's proposed changes) on the
huawei taishan machine (where I originally found the problem) and I
can confirm that I am able to boot the kdump kernel properly and also
save the crashcore dump on local disk.

Also as Ard mentioned, 'efi_enter_virtual_mode' is probably not the
best name for the proposed function as we have already called
'SetVirtualAddressMap', but I cannot think of anything better. If
there are other opinions we can consider the same, otherwise may be we
can formalize this and queue it up as crashkernel is bricked on arm64
machines which support acpi boot machines without the same (and
several kdump users are affected because of the same).

Please feel free to add:

Tested-by: Bhupesh Sharma <bhsharma@redhat.com>

Regards,
Bhupesh
