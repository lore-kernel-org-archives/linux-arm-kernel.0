From: yang.shi@linaro.org (Shi, Yang)
Date: Wed, 18 Nov 2015 10:54:08 -0800
Subject: [PATCH] arm64: restore bogomips information in /proc/cpuinfo
In-Reply-To: <20151118184736.GM1588@arm.com>
References: <1447870505-19319-1-git-send-email-yang.shi@linaro.org>
 <20151118184736.GM1588@arm.com>
Message-ID: <564CC950.30009@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/18/2015 10:47 AM, Will Deacon wrote:
> Hello,
>
> On Wed, Nov 18, 2015 at 10:15:05AM -0800, Yang Shi wrote:
>> As what Pavel Machek reported [1], some userspace applications depend on
>> bogomips showed by /proc/cpuinfo.
>>
>> Although there is much less legacy impact on aarch64 than arm, but it does
>> break libvirt.
>>
>> Basically, this patch reverts commit 326b16db9f69fd0d279be873c6c00f88c0a4aad5
>> ("arm64: delay: don't bother reporting bogomips in /proc/cpuinfo"), but with
>> some tweak due to context change.
>>
>> [1] https://lkml.org/lkml/2015/1/4/132
>
> I lost this argument last time around, so I won't re-tread that path this
> time around. I do, however, have some comments on the patch.
>
>>
>> Signed-off-by: Yang Shi <yang.shi@linaro.org>
>> ---
>>   arch/arm64/kernel/cpuinfo.c | 5 +++++
>>   arch/arm64/kernel/smp.c     | 7 ++++++-
>>   2 files changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
>> index 706679d..8d4ba77 100644
>> --- a/arch/arm64/kernel/cpuinfo.c
>> +++ b/arch/arm64/kernel/cpuinfo.c
>> @@ -30,6 +30,7 @@
>>   #include <linux/seq_file.h>
>>   #include <linux/sched.h>
>>   #include <linux/smp.h>
>> +#include <linux/delay.h>
>>
>>   /*
>>    * In case the boot CPU is hotpluggable, we record its initial state and
>> @@ -112,6 +113,10 @@ static int c_show(struct seq_file *m, void *v)
>>   		 */
>>   		seq_printf(m, "processor\t: %d\n", i);
>>
>> +		seq_printf(m, "BogoMIPS\t: %lu.%02lu\n\n",
>
> This double newline makes /proc/cpuinfo looks really odd. Can we just
> have one, please?
>
>> +			   loops_per_jiffy / (500000UL/HZ),
>> +			   loops_per_jiffy / (5000UL/HZ) % 100);
>> +
>>   		/*
>>   		 * Dump out the common processor features in a single line.
>>   		 * Userspace should read the hwcaps with getauxval(AT_HWCAP)
>> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
>> index b1adc51..1bed772 100644
>> --- a/arch/arm64/kernel/smp.c
>> +++ b/arch/arm64/kernel/smp.c
>> @@ -326,7 +326,12 @@ static void __init hyp_mode_check(void)
>>
>>   void __init smp_cpus_done(unsigned int max_cpus)
>>   {
>> -	pr_info("SMP: Total of %d processors activated.\n", num_online_cpus());
>> +	unsigned long bogosum = loops_per_jiffy * num_online_cpus();
>> +
>> +	pr_info("SMP: Total of %d processors activated (%lu.%02lu BogoMIPS).\n",
>> +		num_online_cpus(), bogosum / (500000/HZ),
>> +		(bogosum / (5000/HZ)) % 100);
>
> Can we drop this hunk? I don't see a pressing need to print this in
> dmesg.

Sure, will solve them in v2.

Thanks,
Yang

>
> With those two changes:
>
>    Acked-by: Will Deacon <will.deacon@arm.com>
>
> I guess this needs Cc'ing to stable, too.
>
> Thanks,
>
> Will
>
