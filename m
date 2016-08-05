From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Fri, 5 Aug 2016 11:19:12 +0100
Subject: [PATCH] arm64: Support hard limit of cpu count by nr_cpus
In-Reply-To: <e2f3ee03-24e7-fd28-4172-ff0c87f9f539@huawei.com>
References: <1470377035-1591-1-git-send-email-wangkefeng.wang@huawei.com>
 <20160805083238.GA13272@arm.com>
 <e2f3ee03-24e7-fd28-4172-ff0c87f9f539@huawei.com>
Message-ID: <02d77415-9eb0-92f4-7cb6-9b941cda9a4d@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/08/16 10:58, Kefeng Wang wrote:
>
>
> On 2016/8/5 16:32, Will Deacon wrote:
>> On Fri, Aug 05, 2016 at 02:03:55PM +0800, Kefeng Wang wrote:
>>> Enable the hard limit of cpu count by nr_cpus on arm64.
>>> The code is borrowed from MIPS.
>>>
>>> Reported-by: Shiyuan Hu <hushiyuan@huawei.com>
>>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>>> ---
>>>  arch/arm64/kernel/setup.c | 16 ++++++++++++++++
>>>  1 file changed, 16 insertions(+)
>>>
>>> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
>>> index 536dce2..597b777 100644
>>> --- a/arch/arm64/kernel/setup.c
>>> +++ b/arch/arm64/kernel/setup.c
>>> @@ -224,6 +224,21 @@ static void __init request_standard_resources(void)
>>>
>>>  u64 __cpu_logical_map[NR_CPUS] = { [0 ... NR_CPUS-1] = INVALID_HWID };
>>>
>>> +static void __init prefill_possible_map(void)
>>> +{
>>> +	int i, possible = num_possible_cpus();
>>> +
>>> +	if (possible > nr_cpu_ids)
>>> +		possible = nr_cpu_ids;
>>> +
>>> +	for (i = 0; i < possible; i++)
>>> +		set_cpu_possible(i, true);
>>> +	for (; i < NR_CPUS; i++)
>>> +		set_cpu_possible(i, false);
>>> +
>>> +	nr_cpu_ids = possible;
>>> +}
>>
>> Shouldn't we just avoid marking those CPUs as possible in smp_cpu_setup,
>> rather than rewriting things later on?
>
> How about this one,
>
> From 0965eebecbc5aea0473df0cb45d32b2fccf72a9a Mon Sep 17 00:00:00 2001
> From: Kefeng Wang <wangkefeng.wang@huawei.com>
> Date: Fri, 5 Aug 2016 17:44:33 +0800
> Subject: [PATCH v2] arm64: Support hard limit of cpu count by nr_cpus
>
> Enable the hard limit of cpu count by set boot options nr_cpus=x
> on arm64.
>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  arch/arm64/kernel/smp.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index 76a6d92..0ac3ff5 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -496,7 +496,10 @@ static int __init smp_cpu_setup(int cpu)
>  	if (cpu_ops[cpu]->cpu_init(cpu))
>  		return -ENODEV;
>
> -	set_cpu_possible(cpu, true);
> +	if (cpu < nr_cpu_ids)
> +		set_cpu_possible(cpu, true);
> +	else
> +		return -EINVAL;
>
>  	return 0;
>  }
>

Or is this even better ?

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 490db85..dbd6a5e 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -659,9 +659,9 @@ void __init smp_init_cpus(void)
                 acpi_table_parse_madt(ACPI_MADT_TYPE_GENERIC_INTERRUPT,
                                       acpi_parse_gic_cpu_interface, 0);
  
-       if (cpu_count > NR_CPUS)
+       if (cpu_count > nr_cpu_ids)
                 pr_warn("no. of cores (%d) greater than configured maximum of %d - clipping\n",
-                       cpu_count, NR_CPUS);
+                       cpu_count, nr_cpu_ids);
  
         if (!bootcpu_valid) {
                 pr_err("missing boot CPU MPIDR, not enabling secondaries\n");
@@ -675,7 +675,7 @@ void __init smp_init_cpus(void)
          * with entries in cpu_logical_map while initializing the cpus.
          * If the cpu set-up fails, invalidate the cpu_logical_map entry.
          */
-       for (i = 1; i < NR_CPUS; i++) {
+       for (i = 1; i < nr_cpu_ids; i++) {
                 if (cpu_logical_map(i) != INVALID_HWID) {
                         if (smp_cpu_setup(i))
                                 cpu_logical_map(i) = INVALID_HWID;


Cheers
Suzuki
