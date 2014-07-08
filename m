From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Tue, 08 Jul 2014 18:07:53 +0800
Subject: [PATCH 2/4] ACPI: Don't use acpi_lapic in ACPI core code
In-Reply-To: <2058650.s5vKv1ibCp@vostro.rjw.lan>
References: <1404290847-7671-1-git-send-email-hanjun.guo@linaro.org>
 <1404290847-7671-3-git-send-email-hanjun.guo@linaro.org>
 <2058650.s5vKv1ibCp@vostro.rjw.lan>
Message-ID: <53BBC2F9.4070808@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014?07?08? 05:08, Rafael J. Wysocki wrote:
> On Wednesday, July 02, 2014 04:47:24 PM Hanjun Guo wrote:
>> From: Graeme Gregory <graeme.gregory@linaro.org>
>>
>> Now ARM64 support is being added to ACPI so architecture specific
>> values can not be used in core ACPI code.
>>
>> Following on the patch "ACPI / processor: Check if LAPIC is present
>> during initialization" which uses acpi_lapic in acpi_processor.c,
>> on ARM64 platform, GIC is used instead of local APIC, so acpi_lapic
>> is not a suitable value for ARM64.
>>
>> What is actually important at this point is the SMPness of the system,
>> so introduce acpi_arch_is_smp() to be arch specific and generic.
>>
>> Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>> ---
>>  arch/ia64/include/asm/acpi.h  |    5 +++++
>>  arch/x86/include/asm/acpi.h   |    5 +++++
>>  drivers/acpi/acpi_processor.c |    2 +-
>>  3 files changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/ia64/include/asm/acpi.h b/arch/ia64/include/asm/acpi.h
>> index 75dc59a..2fc0757 100644
>> --- a/arch/ia64/include/asm/acpi.h
>> +++ b/arch/ia64/include/asm/acpi.h
>> @@ -40,6 +40,11 @@ extern int acpi_lapic;
>>  #define acpi_noirq 0	/* ACPI always enabled on IA64 */
>>  #define acpi_pci_disabled 0 /* ACPI PCI always enabled on IA64 */
>>  #define acpi_strict 1	/* no ACPI spec workarounds on IA64 */
>> +
>> +static inline bool acpi_arch_is_smp(void)
> Why this name?  In particular, local APIC being present doesn't imply SMP.

Hmm, agreed. How about acpi_has_cpu_in_madt()? As we know,
Local APIC/SAPIC in MADT stands for CPU in the system, how about
the function name above?

>
>> +{
>> +	return acpi_lapic;
> Also
>
> 	return !!acpi_lapic;
>
> would be cleaner IMO.
>

I will update it as you suggested.

Thanks
Hanjun
