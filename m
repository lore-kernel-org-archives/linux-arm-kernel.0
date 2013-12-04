From: robherring2@gmail.com (Rob Herring)
Date: Wed, 4 Dec 2013 09:40:04 -0600
Subject: [RFC part2 PATCH 2/9] ARM64 / ACPI: Prefill cpu possible/present
 maps and map logical cpu id to APIC id
In-Reply-To: <529F3A57.7010306@linaro.org>
References: <1386088753-2850-1-git-send-email-hanjun.guo@linaro.org>
 <1386088753-2850-3-git-send-email-hanjun.guo@linaro.org>
 <20131203165755.37b07796@alan.etchedpixels.co.uk>
 <529F3A57.7010306@linaro.org>
Message-ID: <CAL_JsqLGkxS13NAGJfqExFii-RcF3xRsvucjQbFoHeP5zoRkxA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 4, 2013 at 8:21 AM, Hanjun Guo <hanjun.guo@linaro.org> wrote:
> On 2013?12?04? 00:57, One Thousand Gnomes wrote:
>>>
>>> diff --git a/drivers/acpi/plat/arm-core.c b/drivers/acpi/plat/arm-core.c
>>> index 45ff625..8527ecc 100644
>>> --- a/drivers/acpi/plat/arm-core.c
>>> +++ b/drivers/acpi/plat/arm-core.c
>>> @@ -58,6 +58,13 @@ EXPORT_SYMBOL(acpi_pci_disabled);
>>>    */
>>>   static u64 acpi_lapic_addr __initdata;
>>>   +/* available_cpus here means enabled cpu in MADT */
>>> +int available_cpus;
>>> +
>>> +/* Map logic cpu id to physical GIC id. */
>>> +int arm_cpu_to_apicid[NR_CPUS] = { [0 ... NR_CPUS-1] = -1 };
>>> +int boot_cpu_apic_id = -1;
>>> +
>>
>> static ?
>>
>> Really shouldn't be leaking names like "available_cpus" out of ACPI into
>> the global namespace
>
>
> Ok, will update in next version.
>
>
>
>>> +#ifdef CONFIG_SMP
>>> +       if (available_cpus == 0) {
>>> +               pr_info(PREFIX "Found 0 CPUs; assuming 1\n");
>>> +               /* FIXME: should be the real GIC id read from hardware */
>>> +               arm_cpu_to_apicid[available_cpus] = 0;
>>> +               available_cpus = 1;     /* We've got at least one of
>>> these */
>>> +       }
>>> +#endif
>>
>> Isn't this true uniprocessor (by definition in fact)
>
>
> This code is intend to handle some buggy firmware I think.

Really? We have production firmware already that we need to
work-around? That's impressive given there is no production h/w.

Rob
