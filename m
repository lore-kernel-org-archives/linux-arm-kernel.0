From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Tue, 20 Sep 2016 22:12:42 +0800
Subject: [PATCH] arm64, numa: Add cpu_to_node() implementation.
In-Reply-To: <20160920133813.GR25086@rric.localdomain>
References: <1474310970-21264-1-git-send-email-ddaney.cavm@gmail.com>
 <20160920104348.GP25086@rric.localdomain> <57E11E52.8060303@linaro.org>
 <20160920133813.GR25086@rric.localdomain>
Message-ID: <57E143DA.5030602@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/20/2016 09:38 PM, Robert Richter wrote:
> On 20.09.16 19:32:34, Hanjun Guo wrote:
>> On 09/20/2016 06:43 PM, Robert Richter wrote:
>
>>> Instead we need to make sure the set_*numa_node() functions are called
>>> earlier before secondary cpus are booted. My suggested change for that
>>> is this:
>>>
>>>
>>> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
>>> index d93d43352504..952365c2f100 100644
>>> --- a/arch/arm64/kernel/smp.c
>>> +++ b/arch/arm64/kernel/smp.c
>>> @@ -204,7 +204,6 @@ int __cpu_up(unsigned int cpu, struct task_struct *idle)
>>>   static void smp_store_cpu_info(unsigned int cpuid)
>>>   {
>>>   	store_cpu_topology(cpuid);
>>> -	numa_store_cpu_info(cpuid);
>>>   }
>>>
>>>   /*
>>> @@ -719,6 +718,7 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
>>>   			continue;
>>>
>>>   		set_cpu_present(cpu, true);
>>> +		numa_store_cpu_info(cpu);
>>>   	}
>>>   }
>>
>> We tried a similar approach which add numa_store_cpu_info() in
>> early_map_cpu_to_node(), and remove it from smp_store_cpu_info,
>> but didn't work for us, we will try your approach to see if works.

And it works :)

>
> Calling it in early_map_cpu_to_node() is probably too early since
> setup_node_to_cpumask_map() is called in numa_init() afterwards
> overwriting it again.
>
> Actually, early_map_cpu_to_node() is used to temporarily store the
> mapping until it can be setup in numa_store_cpu_info().

Thanks for the clarify, let's wait for David's reply on this one.

Thanks
Hanjun
