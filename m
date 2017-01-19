From: jeremy.linton@arm.com (Jeremy Linton)
Date: Thu, 19 Jan 2017 11:17:57 -0600
Subject: [PATCH v13 1/7] arm64: Rename the common MADT parse routine
In-Reply-To: <c9056b99-7a32-3c91-eb8a-5b44a182c140@linaro.org>
References: <1484686210-7211-1-git-send-email-jeremy.linton@arm.com>
 <1484686210-7211-2-git-send-email-jeremy.linton@arm.com>
 <c9056b99-7a32-3c91-eb8a-5b44a182c140@linaro.org>
Message-ID: <5aa277bd-b9ce-1adf-c1e9-3e76fd241175@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Thanks for taking a look at this!

On 01/18/2017 09:51 PM, Hanjun Guo wrote:
> Hi Jeremy,
>
> On 2017/1/18 4:50, Jeremy Linton wrote:
>> The MADT parser in smp.c is now being used to parse
>> out NUMA, PMU and ACPI parking protocol information as
>> well as the GIC information for which it was originally
>> created. Rename it to avoid a misleading name.
>>
>> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
>> ---
>>  arch/arm64/kernel/smp.c | 13 +++++++------
>>  1 file changed, 7 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
>> index cb87234..8ea244c 100644
>> --- a/arch/arm64/kernel/smp.c
>> +++ b/arch/arm64/kernel/smp.c
>> @@ -517,13 +517,14 @@ static unsigned int cpu_count = 1;
>>
>>  #ifdef CONFIG_ACPI
>>  /*
>> - * acpi_map_gic_cpu_interface - parse processor MADT entry
>> + * acpi_verify_and_map_madt - parse processor MADT entry
>>   *
>>   * Carry out sanity checks on MADT processor entry and initialize
>> - * cpu_logical_map on success
>> + * cpu_logical_map, the ACPI parking protocol, NUMA mapping
>> + * and the PMU interrupts on success
>>   */
>>  static void __init
>> -acpi_map_gic_cpu_interface(struct acpi_madt_generic_interrupt
>> *processor)
>> +acpi_verify_and_map_madt(struct acpi_madt_generic_interrupt *processor)
>
> Nit, MADT is a table includes multi type of table entries, we just
> need to map the the processor type, how about updating it to
> acpi_verify_and_map_madt_processor()?

The rename was originally proposed in a previous review comment because 
the thought was that the code is now parsing more than just the GIC->CPU 
information. That is even though the subtable type its parsing is 
described as the "GIC CPU interface" in the ACPI specification.

So, in a way, I think the original gic_cpu_interface() name is more 
descriptive than acpi_verify_and_map_madt_processor(), but I'm pretty 
agnostic about what the name is. Particularly, since MADT itself is 
misleading.

So, I don't see a need to respin this, simply to rename it, unless 
someone has a strong opinion one way or the other. Primary, because I 
would like to get this set merged and the right decision might just be 
to drop this patch.


Thanks,
