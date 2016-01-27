From: zhaoshenglong@huawei.com (Shannon Zhao)
Date: Wed, 27 Jan 2016 16:57:19 +0800
Subject: [PATCH v3 12/17] ARM64: ACPI: Check if it runs on Xen to enable
 or disable ACPI
In-Reply-To: <56A87F77.8070506@linaro.org>
References: <1453519184-11908-1-git-send-email-zhaoshenglong@huawei.com>
 <1453519184-11908-13-git-send-email-zhaoshenglong@huawei.com>
 <56A87F77.8070506@linaro.org>
Message-ID: <56A8866F.5060302@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2016/1/27 16:27, Hanjun Guo wrote:
> Hi Shannon,
> 
> On 2016/1/23 11:19, Shannon Zhao wrote:
>> From: Shannon Zhao <shannon.zhao@linaro.org>
>>
>> When it's a Xen domain0 booting with ACPI, it will supply a /chosen and
>> a /hypervisor node in DT. So check if it needs to enable ACPI.
>>
>> Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
>> ---
>> CC: Hanjun Guo <hanjun.guo@linaro.org>
>> ---
>>   arch/arm64/kernel/acpi.c | 12 ++++++++----
>>   1 file changed, 8 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
>> index d1ce8e2..4e92be0 100644
>> --- a/arch/arm64/kernel/acpi.c
>> +++ b/arch/arm64/kernel/acpi.c
>> @@ -67,10 +67,13 @@ static int __init dt_scan_depth1_nodes(unsigned
>> long node,
>>   {
>>       /*
>>        * Return 1 as soon as we encounter a node at depth 1 that is
>> -     * not the /chosen node.
>> +     * not the /chosen node, or /hypervisor node when running on Xen.
> 
> The comment is bit misleading, we need to specify two mode, running on
> Xen or not, if not on xen, then /chosen node is enough.
> 
Ok, will rephrase it.

>>        */
>> -    if (depth == 1 && (strcmp(uname, "chosen") != 0))
>> -        return 1;
>> +    if (depth == 1 && (strcmp(uname, "chosen") != 0)) {
>> +        if (!xen_initial_domain() || (strcmp(uname, "hypervisor") != 0))
>> +            return 1;
>> +    }
>> +
>>       return 0;
>>   }
>>
>> @@ -184,7 +187,8 @@ void __init acpi_boot_table_init(void)
>>       /*
>>        * Enable ACPI instead of device tree unless
>>        * - ACPI has been disabled explicitly (acpi=off), or
>> -     * - the device tree is not empty (it has more than just a
>> /chosen node)
>> +     * - the device tree is not empty (it has more than just a
>> /chosen node,
>> +     *   and a /hypervisor node when running on Xen)
> 
> and here too.
> 
> if that is addressed,
> 
> Acked-by: Hanjun Guo <hanjun.guo@linaro.org>
Thanks!

-- 
Shannon
