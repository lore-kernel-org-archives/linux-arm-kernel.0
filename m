From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 19 Aug 2014 10:47:00 +0100
Subject: [PATCH v2 02/18] ARM64 / ACPI: Get RSDP and ACPI boot-time tables
In-Reply-To: <53F31A6D.5090104@linaro.org>
References: <1407166105-17675-1-git-send-email-hanjun.guo@linaro.org>
 <1407166105-17675-3-git-send-email-hanjun.guo@linaro.org>
 <53F24632.7030903@arm.com> <53F31A6D.5090104@linaro.org>
Message-ID: <53F31D14.70006@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 19/08/14 10:35, Hanjun Guo wrote:
> On 2014-8-19 2:30, Sudeep Holla wrote:
>> On 04/08/14 16:28, Hanjun Guo wrote:
>>> From: Al Stone <al.stone@linaro.org>
>>>
>>> As we want to get ACPI tables to parse and then use the information
>>> for system initialization, we should get the RSDP (Root System
>>> Description Pointer) first, it then locates Extended Root Description
>>> Table (XSDT) which contains all the 64-bit physical address that
>>> pointer to other boot-time tables.
>>>
>>> Introduce acpi.c and its related head file in this patch to provide
>>> fundamental needs of extern variables and functions for ACPI core,
>>> and then get boot-time tables as needed.
>>>     - asm/cpu.h need for ACPI core and will be updated in the future to
>>>       add definitions for arch_(un)register_cpu which are required for
>>>       ACPI based physical CPU hotplug;
>>

[...]

>>> +/*
>>> + * acpi_boot_table_init() called from setup_arch(), always.
>>> + *    1. find RSDP and get its address, and then find XSDT
>>> + *    2. extract all tables and checksums them all
>>> + *
>>> + * We can parse ACPI boot-time tables such as FADT, MADT after
>>> + * this function is called.
>>> + */
>>> +void __init acpi_boot_table_init(void)
>>> +{
>>> +    /* If acpi_disabled, bail out */
>>> +    if (acpi_disabled)
>>> +        return;
>>> +
>>> +    /* Initialize the ACPI boot-time table parser. */
>>> +    if (acpi_table_init()) {
>>
>> Can't we call acpi_table_init directly in setup ?
>> IIUC x86 has acpi_boot_table_init as it parses Boot Flags
>> table(ACPI_SIG_BOOT)
>
> Yes, we can. But I think it not a big deal to dot that, if that
> makes the code more readable, I will update it.
>

I agree, but I actually wanted to check if we ever have to use/parse
Simple Boot Flag Table on ARM64 which is reserved but not part of ACPI
spec. I assume x86 use either for Legacy reason or firmware expects it.

Regards,
Sudeep
