From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Tue, 20 Sep 2016 19:32:34 +0800
Subject: [PATCH] arm64, numa: Add cpu_to_node() implementation.
In-Reply-To: <20160920104348.GP25086@rric.localdomain>
References: <1474310970-21264-1-git-send-email-ddaney.cavm@gmail.com>
 <20160920104348.GP25086@rric.localdomain>
Message-ID: <57E11E52.8060303@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+Cc Yisheng,

On 09/20/2016 06:43 PM, Robert Richter wrote:
> David,
>
> On 19.09.16 11:49:30, David Daney wrote:
>> Fix by supplying a cpu_to_node() implementation that returns correct
>> node mappings.
>
>> +int cpu_to_node(int cpu)
>> +{
>> +	int nid;
>> +
>> +	/*
>> +	 * Return 0 for unknown mapping so that we report something
>> +	 * sensible if firmware doesn't supply a proper mapping.
>> +	 */
>> +	if (cpu < 0 || cpu >= NR_CPUS)
>> +		return 0;
>> +
>> +	nid = cpu_to_node_map[cpu];
>> +	if (nid == NUMA_NO_NODE)
>> +		nid = 0;
>> +	return nid;
>> +}
>> +EXPORT_SYMBOL(cpu_to_node);
>
> this implementation fixes the per-cpu workqueue initialization, but I
> don't think a cpu_to_node() implementation private to arm64 is the
> proper solution.
>
> Apart from better using generic code, the cpu_to_node() function is
> called in the kernel's fast path. I think your implementation is too
> expensive and also does not consider per-cpu data access for the
> lookup as the generic code does. Secondly, numa_off is not considered
> at all.
>
> Instead we need to make sure the set_*numa_node() functions are called
> earlier before secondary cpus are booted. My suggested change for that
> is this:
>
>
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index d93d43352504..952365c2f100 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -204,7 +204,6 @@ int __cpu_up(unsigned int cpu, struct task_struct *idle)
>   static void smp_store_cpu_info(unsigned int cpuid)
>   {
>   	store_cpu_topology(cpuid);
> -	numa_store_cpu_info(cpuid);
>   }
>
>   /*
> @@ -719,6 +718,7 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
>   			continue;
>
>   		set_cpu_present(cpu, true);
> +		numa_store_cpu_info(cpu);
>   	}
>   }

We tried a similar approach which add numa_store_cpu_info() in
early_map_cpu_to_node(), and remove it from smp_store_cpu_info,
but didn't work for us, we will try your approach to see if works.

>
>
> I have tested the code and it properly sets up all per-cpu workqueues.
>
> Unfortunately either your nor my code does fix the BUG_ON() I see with
> the numa kernel:
>
>   kernel BUG at mm/page_alloc.c:1848!
>
> See below for the core dump. It looks like this happens due to moving
> a mem block where first and last page are mapped to different numa
> nodes, thus, triggering the BUG_ON().

Didn't triggered it on our NUMA hardware, could you provide your
config then we can have a try?

Thanks
Hanjun
