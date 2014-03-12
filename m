From: preeti@linux.vnet.ibm.com (Preeti U Murthy)
Date: Wed, 12 Mar 2014 10:12:28 +0530
Subject: [RFC 4/6] sched: powerpc: create a dedicated topology table
In-Reply-To: <CAKfTPtCJEX7qknTb85FqJfuT03oNFN3rTOncy5Df37w65+GX8Q@mail.gmail.com>
References: <1394003906-11630-1-git-send-email-vincent.guittot@linaro.org>
 <1394003906-11630-5-git-send-email-vincent.guittot@linaro.org>
 <531EE087.7050707@linux.vnet.ibm.com>
 <CAKfTPtCJEX7qknTb85FqJfuT03oNFN3rTOncy5Df37w65+GX8Q@mail.gmail.com>
Message-ID: <531FE5B4.6090502@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/11/2014 06:48 PM, Vincent Guittot wrote:
> On 11 March 2014 11:08, Preeti U Murthy <preeti@linux.vnet.ibm.com> wrote:
>> Hi Vincent,
>>
>> On 03/05/2014 12:48 PM, Vincent Guittot wrote:
>>> Create a dedicated topology table for handling asymetric feature.
>>> The current proposal creates a new level which describes which groups of CPUs
>>> take adavantge of SD_ASYM_PACKING. The useless level will be removed during the
>>> build of the sched_domain topology.
>>>
>>> Another solution would be to set SD_ASYM_PACKING in the sd_flags of SMT level
>>> during the boot sequence and before the build of the sched_domain topology.
>>
>> Is the below what you mean as the other solution? If it is so, I would
>> strongly recommend this approach rather than adding another level to the
>> topology level to represent the asymmetric behaviour.
>>
>> +static struct sched_domain_topology_level powerpc_topology[] = {
>> +#ifdef CONFIG_SCHED_SMT
>> +       { cpu_smt_mask, SD_SHARE_CPUPOWER | SD_SHARE_PKG_RESOURCES,
>> SD_INIT_NAME(SMT) | arch_sd_sibling_asym_packing() },
>> +#endif
>> +       { cpu_cpu_mask, SD_INIT_NAME(DIE) },
>> +       { NULL, },
>> +};
> 
> Not exactly like that but something like below
> 
> +static struct sched_domain_topology_level powerpc_topology[] = {
> +#ifdef CONFIG_SCHED_SMT
> + { cpu_smt_mask, SD_SHARE_CPUPOWER | SD_SHARE_PKG_RESOURCES,
> SD_INIT_NAME(SMT) },
> +#endif
> + { cpu_cpu_mask, SD_INIT_NAME(DIE) },
> + { NULL, },
> +};
> +
> +static void __init set_sched_topology(void)
> +{
> +#ifdef CONFIG_SCHED_SMT
> + powerpc_topology[0].sd_flags |= arch_sd_sibling_asym_packing();
> +#endif
> + sched_domain_topology = powerpc_topology;
> +}

I think we can set it in powerpc_topology[] and not bother about setting
additional flags outside of this array. It is clearer this way.

On an additional note, on powerpc we would want to clear the
SD_SHARE_POWERDOMAIN flag at the CPU domain. On Power8, considering we
have 8 threads per core, we would want to consolidate tasks atleast upto
4 threads without significant performance impact before spilling over to
the other cores. By doing so, besides making use of the higher power of
the core we could do cpuidle management at the core level for the
remaining idle cores as a result of this consolidation.

So the powerpc_topology[] would be something like the below:

+static struct sched_domain_topology_level powerpc_topology[] = {
+#ifdef CONFIG_SCHED_SMT
+       { cpu_smt_mask, SD_SHARE_CPUPOWER | SD_SHARE_PKG_RESOURCES,
SD_INIT_NAME(SMT) | arch_sd_sibling_asym_packing() | SD_SHARE_POWERDOMAIN },
+#endif
+       { cpu_cpu_mask, SD_INIT_NAME(DIE) },
+       { NULL, },
+};

The amount of consolidation to the threads in a core, we will probably
take care of it in cpu capacity or a similar parameter, but the above
topology level would be required to request the scheduler to try
consolidating tasks to cores till the cpu capacity(3/4/5 threads) has
exceeded.

Regards
Preeti U Murthy
