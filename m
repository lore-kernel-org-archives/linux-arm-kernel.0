From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Fri, 18 Nov 2016 11:37:10 +0800
Subject: [PATCH next] arm64: remove "SMP: Total of %d processors
 activated." message
In-Reply-To: <20161117142213.GI22855@arm.com>
References: <1479367946-38771-1-git-send-email-wangkefeng.wang@huawei.com>
 <20161117142213.GI22855@arm.com>
Message-ID: <6d867f8f-c7b9-42e9-1764-6f802d6b1e96@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2016/11/17 22:22, Will Deacon wrote:
> On Thu, Nov 17, 2016 at 03:32:26PM +0800, Kefeng Wang wrote:
>> There is a common SMP boot message in generic code on all arches,
>> kill "SMP: Total of %d processors activated." in smp_cpus_done()
>> on arm64.
>>
>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>> ---
>> Boot message on qemu.
>> [    0.375116] smp: Brought up 1 node, 8 CPUs
>> [    0.383749] SMP: Total of 8 processors activated.
>>
>>  arch/arm64/kernel/smp.c | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
>> index cb87234..9db4a95 100644
>> --- a/arch/arm64/kernel/smp.c
>> +++ b/arch/arm64/kernel/smp.c
>> @@ -428,7 +428,6 @@ static void __init hyp_mode_check(void)
>>  
>>  void __init smp_cpus_done(unsigned int max_cpus)
>>  {
>> -	pr_info("SMP: Total of %d processors activated.\n", num_online_cpus());
>>  	setup_cpu_features();
>>  	hyp_mode_check();
>>  	apply_alternatives_all();
> 
> Why? Are you proposing the same change to other architectures? Are you paid
> per patch?

The message provides no further information than the generic code, so kill it.
Or show BogoMIPS like arm32?

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index cb87234..6bb33cd 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -428,7 +428,17 @@ static void __init hyp_mode_check(void)

 void __init smp_cpus_done(unsigned int max_cpus)
 {
-   pr_info("SMP: Total of %d processors activated.\n", num_online_cpus());
+ int cpu;
+ unsigned long bogosum = 0;
+
+ for_each_online_cpu(cpu)
+         bogosum += loops_per_jiffy;
+
+ pr_info("SMP: Total of %d processors activated "
+         "(%lu.%02lu BogoMIPS).\n",
+         num_online_cpus(),
+         bogosum / (500000/HZ),
+         (bogosum / (5000/HZ)) % 100);
        setup_cpu_features();
        hyp_mode_check();
        apply_alternatives_all()


> 
> Will
> 
> .
> 
