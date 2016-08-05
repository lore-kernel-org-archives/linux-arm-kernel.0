From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Fri, 5 Aug 2016 17:58:51 +0800
Subject: [PATCH] arm64: Support hard limit of cpu count by nr_cpus
In-Reply-To: <20160805083238.GA13272@arm.com>
References: <1470377035-1591-1-git-send-email-wangkefeng.wang@huawei.com>
 <20160805083238.GA13272@arm.com>
Message-ID: <e2f3ee03-24e7-fd28-4172-ff0c87f9f539@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2016/8/5 16:32, Will Deacon wrote:
> On Fri, Aug 05, 2016 at 02:03:55PM +0800, Kefeng Wang wrote:
>> Enable the hard limit of cpu count by nr_cpus on arm64.
>> The code is borrowed from MIPS.
>>
>> Reported-by: Shiyuan Hu <hushiyuan@huawei.com>
>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>> ---
>>  arch/arm64/kernel/setup.c | 16 ++++++++++++++++
>>  1 file changed, 16 insertions(+)
>>
>> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
>> index 536dce2..597b777 100644
>> --- a/arch/arm64/kernel/setup.c
>> +++ b/arch/arm64/kernel/setup.c
>> @@ -224,6 +224,21 @@ static void __init request_standard_resources(void)
>>  
>>  u64 __cpu_logical_map[NR_CPUS] = { [0 ... NR_CPUS-1] = INVALID_HWID };
>>  
>> +static void __init prefill_possible_map(void)
>> +{
>> +	int i, possible = num_possible_cpus();
>> +
>> +	if (possible > nr_cpu_ids)
>> +		possible = nr_cpu_ids;
>> +
>> +	for (i = 0; i < possible; i++)
>> +		set_cpu_possible(i, true);
>> +	for (; i < NR_CPUS; i++)
>> +		set_cpu_possible(i, false);
>> +
>> +	nr_cpu_ids = possible;
>> +}
> 
> Shouldn't we just avoid marking those CPUs as possible in smp_cpu_setup,
> rather than rewriting things later on?

How about this one,

>From 0965eebecbc5aea0473df0cb45d32b2fccf72a9a Mon Sep 17 00:00:00 2001
From: Kefeng Wang <wangkefeng.wang@huawei.com>
Date: Fri, 5 Aug 2016 17:44:33 +0800
Subject: [PATCH v2] arm64: Support hard limit of cpu count by nr_cpus

Enable the hard limit of cpu count by set boot options nr_cpus=x
on arm64.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/arm64/kernel/smp.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 76a6d92..0ac3ff5 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -496,7 +496,10 @@ static int __init smp_cpu_setup(int cpu)
 	if (cpu_ops[cpu]->cpu_init(cpu))
 		return -ENODEV;

-	set_cpu_possible(cpu, true);
+	if (cpu < nr_cpu_ids)
+		set_cpu_possible(cpu, true);
+	else
+		return -EINVAL;

 	return 0;
 }
-- 
1.7.12.4


> 
> Also, can you explain exactly what functionality is missing at the moment,
> please? I assume it's the nr_cpus= option not working correctly?

Yes. they use same bootargs nr_cpus=1 on both arm64 and x86, but find it can't work in arm64.

> 
> Will
> 
> .
> 
