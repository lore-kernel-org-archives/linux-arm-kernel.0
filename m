From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 29 Jul 2014 09:49:10 +0100
Subject: [PATCH 01/19] ARM64 / ACPI: Get RSDP and ACPI boot-time tables
In-Reply-To: <53D6D391.8090907@linaro.org>
References: <1406206825-15590-1-git-send-email-hanjun.guo@linaro.org>
 <1406206825-15590-2-git-send-email-hanjun.guo@linaro.org>
 <53D69678.20002@arm.com> <53D6D391.8090907@linaro.org>
Message-ID: <53D76006.4040105@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 28/07/14 23:49, Graeme Gregory wrote:
>
> On 28/07/2014 19:29, Sudeep Holla wrote:
>>
>>
>> On 24/07/14 14:00, Hanjun Guo wrote:
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
>>>     - asm/acenv.h for arch specific ACPICA environments and
>>>       implementation;
>>>     - asm/acpi.h for arch specific variables and functions needed by
>>>       ACPI driver core;
>>>     - acpi.c for ARM64 related ACPI implementation for ACPI driver
>>>       core;
>>>
>>> acpi_boot_table_init() is introduced to get RSDP and boot-time tables,
>>> it will be called in setup_arch() before paging_init(), so we should
>>> use eary_memremap() mechanism here to get the RSDP and all the table
>>> pointers.
>>>
>>> Signed-off-by: Al Stone <al.stone@linaro.org>
>>> Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
>>> Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
>>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>>> ---
>>>    arch/arm64/include/asm/acenv.h |   18 ++++++++++
>>>    arch/arm64/include/asm/acpi.h  |   41 ++++++++++++++++++++++
>>>    arch/arm64/include/asm/cpu.h   |   11 ++++++
>>>    arch/arm64/kernel/Makefile     |    1 +
>>>    arch/arm64/kernel/acpi.c       |   76
>>> ++++++++++++++++++++++++++++++++++++++++
>>>    arch/arm64/kernel/setup.c      |    4 +++
>>>    6 files changed, 151 insertions(+)
>>>    create mode 100644 arch/arm64/include/asm/acenv.h
>>>    create mode 100644 arch/arm64/include/asm/acpi.h
>>>    create mode 100644 arch/arm64/include/asm/cpu.h
>>>    create mode 100644 arch/arm64/kernel/acpi.c
>>>

[...]

>>> +
>>> +/*
>>> + * MADT must provide at least one GICC structure
>>> + * for GIC initialization, so CPU will be
>>> + * always available in MADT on ARM64
>>> + */
>>> +static inline bool acpi_has_cpu_in_madt(void)
>>> +{
>>> +       return 1;
>>> +}
>>> +
>>
>> I don't see the user of this function in the series, it's better to
>> remove. Moreover the comment is so misleading. We will have CPU UID
>> not the CPU itself in MADT.
>>
> This is actually required for a patch that is now upstreamed. Comment
> should actually say that its checking for the posibility that the CPU
> can be initialised from the MADT. Its used from core in crash kernel
> case where boot CPU is not necessarily CPU0 like spec demands.
>

Ah OK, I now see that in Rafael's linux-pm/linux-next. Sorry I might have
missed to notice that and I assumed this series is based on mainline.

Regards,
Sudeep
