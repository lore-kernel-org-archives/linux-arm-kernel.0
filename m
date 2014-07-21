From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 21 Jul 2014 12:18:37 +0200
Subject: [PATCH resend v2] arm64: dmi: Add SMBIOS/DMI support
In-Reply-To: <20140721100304.GB12817@arm.com>
References: <1405079210-30044-1-git-send-email-ard.biesheuvel@linaro.org>
 <20140721100304.GB12817@arm.com>
Message-ID: <CAKv+Gu9dfw7+URK+YG6D9_gUiFn17abUk2MUw5Jj5+5BwgrVbA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21 July 2014 12:03, Catalin Marinas <catalin.marinas@arm.com> wrote:
> Ard,
>
> I have some technical questions below before merging this patch.
>
> On Fri, Jul 11, 2014 at 12:46:50PM +0100, Ard Biesheuvel wrote:
>> --- /dev/null
>> +++ b/arch/arm64/include/asm/dmi.h
>> @@ -0,0 +1,41 @@
> [...]
>> +static inline void __iomem *dmi_remap(u64 phys, u64 size)
>> +{
>> +     void __iomem *p = efi_lookup_mapped_addr(phys);
>
> When are dmi_remap/dmi_early_remap() called? A quick grep through the
> kernel shows that it is at least called once from dmi_scan_machine().
> The latter is a device_initcall() in this patch. However, the comments
> for efi_lookup_mapped_addr() state that it should only be called between
> efi_enter_virtual_mode and efi_free_boot_services. The latter is invoked
> from an early_initcall(). Could you please clarify which part is wrong
> here?
>

The comment about efi_lookup_mapped_addr() is wrong. Those mappings
are always available.
As the comment is in shared code, I will propose a patch to Matt
Fleming to clarify it.

>> +
>> +     /*
>> +      * If the mapping spans multiple pages, do a minimal check to ensure
>> +      * that the mapping returned by efi_lookup_mapped_addr() covers the
>> +      * whole requested range (but ignore potential holes)
>> +      */
>> +     if ((phys & ~PAGE_MASK) + size > PAGE_SIZE
>> +         && (p + size - 1) != efi_lookup_mapped_addr(phys + size - 1))
>> +             return NULL;
>> +     return p;
>> +}
>> +
>> +/* Reuse existing UEFI mappings for DMI */
>> +#define dmi_alloc(l)                 kzalloc(l, GFP_KERNEL)
>> +#define dmi_early_remap(x, l)                dmi_remap(x, l)
>> +#define dmi_early_unmap(x, l)
>> +#define dmi_unmap(x)
>
> Same questions as above, when are these functions called? Can we not
> just use early_ioremap/ioremap like x86?
>

x86 uses DMI for quirks handling, so there the call to
dmi_scan_machine() needs to occur very early, hence the early versions
of map/unmap.
In our case, DMI/SMBIOS is UEFI only and not executed early, so we can
just reuse the mappings that have already been set up for UEFI by
arm64_enter_virtual_mode().

-- 
Ard.
