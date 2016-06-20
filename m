From: jeremy.linton@arm.com (Jeremy Linton)
Date: Mon, 20 Jun 2016 16:44:31 -0500
Subject: [PATCH 7/8] arm64: pmu: Enable multiple PMUs in an ACPI system
In-Reply-To: <87h9cn6ckw.fsf@e105922-lin.cambridge.arm.com>
References: <1465511013-10742-1-git-send-email-jeremy.linton@arm.com>
 <1465511013-10742-8-git-send-email-jeremy.linton@arm.com>
 <87h9cn6ckw.fsf@e105922-lin.cambridge.arm.com>
Message-ID: <576863BF.6040800@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Punit,

On 06/20/2016 11:37 AM, Punit Agrawal wrote:
> Jeremy Linton <jeremy.linton@arm.com> writes:
>
>> Its possible that an ACPI system has multiple CPU types in it
>> with differing PMU counters. Use the newly provided acpi_pmu routines
>> to detect that case, and instantiate more than one set of counters.
>>
>> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
>> ---
>>   drivers/perf/arm_pmu.c      |  7 +++-
>>   drivers/perf/arm_pmu_acpi.c | 98 ++++++++++++++++++++-------------------------
>>   2 files changed, 50 insertions(+), 55 deletions(-)
>>
>
> [...]
>
>> diff --git a/drivers/perf/arm_pmu_acpi.c b/drivers/perf/arm_pmu_acpi.c
>> index a257fc0..8f9bea3 100644
>> --- a/drivers/perf/arm_pmu_acpi.c
>> +++ b/drivers/perf/arm_pmu_acpi.c
>> @@ -35,6 +35,11 @@ struct pmu_types {
>>
>>   static struct pmu_irq pmu_irqs[NR_CPUS] __initdata;
>>
>> +/*
>> + * Called from acpi_map_gic_cpu_interface()'s MADT parsing during boot.
>> + * This routine saves off the GSI's and their trigger state for use when we are
>> + * ready to build the PMU platform device.
>> +*/
>>   void __init arm_pmu_parse_acpi(int cpu, struct acpi_madt_generic_interrupt *gic)
>>   {
>>   	pmu_irqs[cpu].gsi = gic->performance_interrupt;
>
>
> This hunk should be in Patch 3.


Ok...

>
>> @@ -47,7 +52,7 @@ void __init arm_pmu_parse_acpi(int cpu, struct acpi_madt_generic_interrupt *gic)
>>   }
>>
>>   /* Count number and type of CPU cores in the system. */
>> -void __init arm_pmu_acpi_determine_cpu_types(struct pmu_types *pmus)
>> +static void __init arm_pmu_acpi_determine_cpu_types(struct pmu_types *pmus)
>>   {
>>   	int i, j;
>>
>
> Please move this and the following two hunks to the previous patch where you
> introduce the functions.


Oh, I did this on purpose to avoid:

"warning: 'xxx' defined but not used" messages.



>
>> @@ -74,7 +79,7 @@ void __init arm_pmu_acpi_determine_cpu_types(struct pmu_types *pmus)
>>    * Registers the group of PMU interfaces which corrispond to the 'last_cpu_id'.
>>    * This group utlizes 'count' resources in the 'res'.
>>    */
>> -int __init arm_pmu_acpi_register_pmu(int count, struct resource *res,
>> +static int __init arm_pmu_acpi_register_pmu(int count, struct resource *res,
