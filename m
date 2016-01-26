From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 26 Jan 2016 14:34:31 +0000
Subject: [PATCH v2 21/21] arm64: Panic when VHE and non VHE CPUs coexist
In-Reply-To: <56A781E7.2050408@arm.com>
References: <1453737235-16522-1-git-send-email-marc.zyngier@arm.com>
 <1453737235-16522-22-git-send-email-marc.zyngier@arm.com>
 <56A781E7.2050408@arm.com>
Message-ID: <56A783F7.7050301@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26/01/16 14:25, Suzuki K. Poulose wrote:
> On 25/01/16 15:53, Marc Zyngier wrote:
>> Having both VHE and non-VHE capable CPUs in the same system
>> is likely to be a recipe for disaster.
> 
> 
>> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
>> index b1adc51..bc7650a 100644
>> --- a/arch/arm64/kernel/smp.c
>> +++ b/arch/arm64/kernel/smp.c
>> @@ -113,6 +113,9 @@ int __cpu_up(unsigned int cpu, struct task_struct *idle)
>>   			pr_crit("CPU%u: failed to come online\n", cpu);
>>   			ret = -EIO;
>>   		}
>> +
>> +		if (is_kernel_mode_mismatched())
>> +			panic("CPU%u: incompatible execution level", cpu);
> 
> 
> fyi,
> 
> I have a series which tries to perform some checks for early CPU features,
> like this at [1] and adds support for early CPU boot failures, passing the error
> status back to the master. May be we could move this check there(once it settles),
> and fail the CPU boot with CPU_PANIC_KERNEL status.
> 
> 
> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-January/401727.html

Definitely, there is room for consolidation in this area...

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
