From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Mon, 8 Aug 2016 19:28:03 +0800
Subject: [PATCH v2] arm64: Support hard limit of cpu count by nr_cpus
In-Reply-To: <06f0b566-3482-0223-ce22-ef7532414c7f@arm.com>
References: <02d77415-9eb0-92f4-7cb6-9b941cda9a4d@arm.com>
 <1470636316-24552-1-git-send-email-wangkefeng.wang@huawei.com>
 <06f0b566-3482-0223-ce22-ef7532414c7f@arm.com>
Message-ID: <b8afb29f-d831-ef99-bf11-af1a9d439879@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2016/8/8 18:50, Suzuki K Poulose wrote:
> On 08/08/16 07:05, Kefeng Wang wrote:
>> Enable the hard limit of cpu count by set boot options nr_cpus=x
>> on arm64, and show a better warning when cpu number exceeds the limit.
>>
>> Reported-by: Shiyuan Hu <hushiyuan@huawei.com>
>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>> ---
>>
>> Changed since v1:
>> - clip cpu number in smp_init_cpus suggested-by Will and Suzuki, and update
>>   the warning.
>>
>>  arch/arm64/kernel/smp.c | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
>> index 76a6d92..cbfc31c 100644
>> --- a/arch/arm64/kernel/smp.c
>> +++ b/arch/arm64/kernel/smp.c
>> @@ -661,9 +661,9 @@ void __init smp_init_cpus(void)
>>          acpi_table_parse_madt(ACPI_MADT_TYPE_GENERIC_INTERRUPT,
>>                        acpi_parse_gic_cpu_interface, 0);
>>
>> -    if (cpu_count > NR_CPUS)
>> -        pr_warn("no. of cores (%d) greater than configured maximum of %d - clipping\n",
>> -            cpu_count, NR_CPUS);
>> +    if (cpu_count > nr_cpu_ids)
>> +        pr_warn("%d cores exceeds configured maximum of %d - clipping\n",
>> +            cpu_count, nr_cpu_ids);
> 
> I think we should leave the message as it was, and is better than what you have
> changed it to.

The old message is OF only and the old logic shows message when the first cpu number greater than NR_CPUS.
But now the cpu_count is the total cpu counts(get from DT or ACPI), so I change the message.


> 
> 
> With that change,
> 
> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> 
> 
> .
> 
