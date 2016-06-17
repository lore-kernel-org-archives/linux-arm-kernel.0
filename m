From: james.morse@arm.com (James Morse)
Date: Fri, 17 Jun 2016 17:48:35 +0100
Subject: [PATCH 1/2] arm64: smp: Add function to determine if cpus are
 stuck in the kernel
In-Reply-To: <5763DC2B.5030705@arm.com>
References: <1466156097-20028-1-git-send-email-james.morse@arm.com>
 <1466156097-20028-2-git-send-email-james.morse@arm.com>
 <20160617102713.GA14524@leverpostej> <5763DC2B.5030705@arm.com>
Message-ID: <576429E3.3010206@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Suzuki,

On 17/06/16 12:16, Suzuki K Poulose wrote:
> On 17/06/16 11:27, Mark Rutland wrote:
>> On Fri, Jun 17, 2016 at 10:34:56AM +0100, James Morse wrote:
>>> kernel/smp.c has a fancy counter that keeps track of the number of CPUs
>>> it marked as not-present and left in cpu_park_loop(). If there are any
>>> CPUs spinning in here, features like kexec or hibernate may release them
>>> by overwriting this memory.
>>>
>>> This problem also occurs on machines using spin-tables to release
>>> secondary cores.
>>> After commit 44dbcc93ab67 ("arm64: Fix behavior of maxcpus=N")
>>> we bring all known cpus into the secondary holding pen, but may not bring
>>> them up depending on 'maxcpus'. This memory can't be re-used by kexec
>>> or hibernate.
>>>
>>> Add a function cpus_are_stuck_in_kernel() to determine if either of these
>>> cases have occurred.

>> It might also be stuck in __no_granule_support, if it never made it to C
>> code. In that case, the CPU in charge of bringing up that new CPU will
>> increment the counter in __cpu_up.
> 
> Just to clarify, *in all the cases*, the CPU in charge of bringing up updates
> the cpus_stuck_in_kernel.

Ah, my mistake. I will switch it for Mark's suggestion.


>>> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
>>> index 678e0842cb3b..e197502f94fd 100644
>>> --- a/arch/arm64/kernel/smp.c
>>> +++ b/arch/arm64/kernel/smp.c
>>> @@ -909,3 +909,16 @@ int setup_profiling_timer(unsigned int multiplier)
>>>   {
>>>       return -EINVAL;
>>>   }
>>> +
>>> +bool cpus_are_stuck_in_kernel(void)
>>> +{
>>> +    bool ret = !!cpus_stuck_in_kernel;
>>> +#ifdef CONFIG_HOTPLUG_CPU
>>> +    int any_cpu = raw_smp_processor_id();
>>> +
>>> +    if (num_possible_cpus() > 1 && !cpu_ops[any_cpu]->cpu_die)
>>> +        ret = true;
>>> +#endif
> 
> Minor nit: Moving the cpu_die check to a static inline function with
> an obvious name might make the code look better.
> 
>     return !!cpus_stuck_in_kernel || !have_cpu_die() ?
> 

That would be better!


> Eitherway,
> 
> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Thanks,

James
