From: james.morse@arm.com (James Morse)
Date: Wed, 09 Nov 2016 18:14:21 +0000
Subject: [PATCH] arm64: acpi: arch_apei_get_mem_attributes() should use
 memblock
In-Reply-To: <CAKv+Gu9+T0TYqk+uTUWa5K0E49WXDBpUK4Px_q=52jR0ON1zGA@mail.gmail.com>
References: <20161108102714.29931-1-james.morse@arm.com>
 <CAKv+Gu9+T0TYqk+uTUWa5K0E49WXDBpUK4Px_q=52jR0ON1zGA@mail.gmail.com>
Message-ID: <5823677D.3050803@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ard,

On 09/11/16 12:12, Ard Biesheuvel wrote:
> On 8 November 2016 at 10:27, James Morse <james.morse@arm.com> wrote:
>> arm64's arch_apei_get_mem_attributes() tries to use
>> efi_mem_attributes() to read the memory attributes from the efi
>> memory map.
>>
>> drivers/firmware/efi/arm-init.c:efi_init() calls efi_memmap_unmap(),
>> which clears the EFI_MEMMAP bit from efi.flags once efi_init() has
>> finished with the memory map. This causes efi_mem_attributes() to
>> return 0 meaning PROT_DEVICE_nGnRnE is the chosen memory type for
>> all ACPI APEI mappings.
>>
>> APEI may call this from NMI context, so we can't re-map the EFI
>> memory map as this may need to allocate virtual address space.
>> 'ghes_ioremap_area' is APEIs cache of virtual address space to
>> access the buffer once we tell it the memory attributes.
>>
>> Do as acpi_os_ioremap() does, and consult memblock to learn if
>> the provided address is memory, or not.

>> diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c

>> @@ -241,22 +238,13 @@ void __init acpi_boot_table_init(void)
>>  pgprot_t arch_apei_get_mem_attribute(phys_addr_t addr)
>>  {
>>         /*
>> -        * According to "Table 8 Map: EFI memory types to AArch64 memory
>> -        * types" of UEFI 2.5 section 2.3.6.1, each EFI memory type is
>> -        * mapped to a corresponding MAIR attribute encoding.
>> -        * The EFI memory attribute advises all possible capabilities
>> -        * of a memory region. We use the most efficient capability.
>> +        * The EFI memmap isn't mapped, instead read the version exported
>> +        * into memblock. EFI's reserve_regions() call adds memory with the
>> +        * WB attribute to memblock via early_init_dt_add_memory_arch().
>>          */
>> +       if (!memblock_is_memory(addr))
>> +               return __pgprot(PROT_DEVICE_nGnRnE);
>>
>> -       u64 attr;
>> -
>> -       attr = efi_mem_attributes(addr);
>> -       if (attr & EFI_MEMORY_WB)
>> -               return PAGE_KERNEL;
>> -       if (attr & EFI_MEMORY_WT)
>> -               return __pgprot(PROT_NORMAL_WT);
>> -       if (attr & EFI_MEMORY_WC)
>> -               return __pgprot(PROT_NORMAL_NC);
>> -       return __pgprot(PROT_DEVICE_nGnRnE);
>> +       return PAGE_KERNEL;
> 
> As you know, we recently applied [0] to ensure that memory regions
> that are marked by UEFI was write-through cacheable (WT) or
> write-combining (WC) are not misidentified by the kernel as having
> strongly ordered semantics.

Ah, I'd forgotten all about that...


> This means that in this case, you may be returning PAGE_KERNEL for
> regions that are lacking the EFI_MEMORY_WB attribute, which kind of
> defeats the purpose of this function (AIUI), to align the kernel's
> view of the region's attributes with the view of the firmware. I would
> expect that, for use cases like this one, the burden is on the
> firmware to ensure that only a single EFI_MEMORY_xx attribute is set
> if any kind of coherency between UEFI and the kernel is expected. If
> that single attribute is WT or WC, PAGE_KERNEL is most certainly
> wrong.

I've been trying to test some of the APEI code using some hacks on top of
kvmtool. (actually, quite a lot of hacks).

When I trigger an event, I see efi_mem_attributes() always return 0 because the
EFI memory map isn't mapped. This turns out to be because I have 'efi=noruntime'
on the command line. I stopped digging when I found this previously-dead code,
but should have gone further.

If this is an expected interaction, we can ignore this as a bug in my test
setup. (and I have to work out how to get efi runtime services going...)

If not, I can try always mapping the EFI memory map in
arm_enable_runtime_services() if we booted via ACPI, as in this case runtime
services isn't the only user of the memory map.


My intention here was to just mirror acpi_os_ioremap(), which will call
ioremap_cache() for WB/WC/WT regions, which (also) ends up using PROT_NORMAL. We
may get away with this, but you're right, we are less likely to here.



Thanks,

James
