From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Mon, 20 Jan 2014 22:13:55 +0800
Subject: [PATCH 06/20] ARM64 / ACPI: Introduce some PCI functions when
 PCI is enabled
In-Reply-To: <4387274.ri38HmFxAV@wuerfel>
References: <1389961514-13562-1-git-send-email-hanjun.guo@linaro.org>
 <201401171504.24525.arnd@arndb.de> <52DCD961.70303@linaro.org>
 <4387274.ri38HmFxAV@wuerfel>
Message-ID: <52DD2F23.2010109@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014?01?20? 16:20, Arnd Bergmann wrote:
> On Monday 20 January 2014 16:08:01 Hanjun Guo wrote:
>>>> diff --git a/drivers/acpi/plat/arm-core.c b/drivers/acpi/plat/arm-core.c
>>>> index 3c8521d..1835b21 100644
>>>> --- a/drivers/acpi/plat/arm-core.c
>>>> +++ b/drivers/acpi/plat/arm-core.c
>>>> @@ -100,6 +100,25 @@ int acpi_gsi_to_irq(u32 gsi, unsigned int *irq)
>>>>   }
>>>>   EXPORT_SYMBOL_GPL(acpi_gsi_to_irq);
>>>>   
>>>> +int acpi_isa_irq_to_gsi(unsigned isa_irq, u32 *gsi)
>>>> +{
>>>> +    return -1;
>>>> +}
>>>> +
>>>> +int acpi_register_ioapic(acpi_handle handle, u64 phys_addr, u32 gsi_base)
>>>> +{
>>>> +    /* TBD */
>>>> +    return -EINVAL;
>>>> +}
>>>> +EXPORT_SYMBOL(acpi_register_ioapic);
>>>> +
>>>> +int acpi_unregister_ioapic(acpi_handle handle, u32 gsi_base)
>>>> +{
>>>> +    /* TBD */
>>>> +    return -EINVAL;
>>>> +}
>>>> +EXPORT_SYMBOL(acpi_unregister_ioapic);
>>>> +
>>> My feeling is that these are better handled in the ACPI code by not
>>> calling them on architectures that have no ISA or no IOAPIC support.
>>>
>>> We have configuration symbols for both, so you don't have to make
>>> it depend on CONFIG_ARM64 or CONFIG_X86.
>> Do you mean introduce a stub function when there is no ISA support?
> Do you anticipate ISA devices on ARM64? I hope not ;-)

me too :)

>
> My guess is that whatever code calls this function should be disabled
> in reduced hw mode.

ok, that would be make sense, will update it in next version.

>
>> acpi_register_ioapic()/acpi_unregister_ioapic() will be used for IOAPIC
>> hotplug and GIC distributor is something like IOAPIC on x86, so I think
>> these two functions can be reserved for future use.
> But GIC is not hotplugged, is it? It still sounds x86 specific to me.

Well, if we want to do physical CPU hotplug on ARM/ARM64 (maybe years 
later?),
then GIC add/remove is needed because we have to remove GIC
on the SoC too when we remove the physical CPU.

Thanks
Hanjun
