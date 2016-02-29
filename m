From: ddaney.cavm@gmail.com (David Daney)
Date: Mon, 29 Feb 2016 15:42:58 -0800
Subject: [PATCH v12 4/5] arm64, numa: Add NUMA support for arm64 platforms.
In-Reply-To: <20160229173446.GG31343@rric.localdomain>
References: <1456192703-2274-1-git-send-email-ddaney.cavm@gmail.com>
 <1456192703-2274-5-git-send-email-ddaney.cavm@gmail.com>
 <20160229173446.GG31343@rric.localdomain>
Message-ID: <56D4D782.3010503@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/29/2016 09:34 AM, Robert Richter wrote:
> On 22.02.16 17:58:22, David Daney wrote:
>> From: Ganapatrao Kulkarni <gkulkarni@caviumnetworks.com>
>>
>> Attempt to get the memory and CPU NUMA node via of_numa.  If that
>> fails, default the dummy NUMA node and map all memory and CPUs to node
>> 0.
>>
>> Tested-by: Shannon Zhao <shannon.zhao@linaro.org>
>> Reviewed-by: Robert Richter <rrichter@cavium.com>
>> Signed-off-by: Ganapatrao Kulkarni <gkulkarni@caviumnetworks.com>
>> Signed-off-by: David Daney <david.daney@cavium.com>
>> ---
>>   arch/arm64/Kconfig                |  26 +++
>>   arch/arm64/include/asm/mmzone.h   |  12 ++
>>   arch/arm64/include/asm/numa.h     |  45 +++++
>>   arch/arm64/include/asm/topology.h |  10 +
>>   arch/arm64/kernel/pci.c           |  10 +
>>   arch/arm64/kernel/setup.c         |   4 +
>>   arch/arm64/kernel/smp.c           |   4 +
>>   arch/arm64/mm/Makefile            |   1 +
>>   arch/arm64/mm/init.c              |  34 +++-
>>   arch/arm64/mm/mmu.c               |   1 +
>>   arch/arm64/mm/numa.c              | 403 ++++++++++++++++++++++++++++++++++++++
>>   11 files changed, 545 insertions(+), 5 deletions(-)
>>   create mode 100644 arch/arm64/include/asm/mmzone.h
>>   create mode 100644 arch/arm64/include/asm/numa.h
>>   create mode 100644 arch/arm64/mm/numa.c
>
>> +static int __init numa_init(int (*init_func)(void))
>> +{
>> +	int ret;
>> +
>> +	nodes_clear(numa_nodes_parsed);
>> +	nodes_clear(node_possible_map);
>> +	nodes_clear(node_online_map);
>> +	numa_free_distance();

         ^^^^^^^^^^^^^
      Cleanup for any previous numa_alloc_distance()

>> +
>> +	ret = numa_alloc_distance();
>> +	if (ret < 0)
>> +		return ret;
>
> If you move this before the remaining initializers, you will need to
> clean this up on error.

Yes, we do this.  See above.

> So better move it back after
> numa_register_nodes() as it was in v10. This should work since
> distances are used not earlier than numa is enabled.

I moved it here for a reason.

The init_func (of_numa_init() in this case) makes callbacks that use the 
numa_distance object.  We need to allocate it before using it. 
Allocating it after calling the init_func() is too late.


>
> -Robert
>
>> +
>> +	ret = init_func();
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	if (nodes_empty(numa_nodes_parsed))
>> +		return -EINVAL;
>> +
>> +	ret = numa_register_nodes();
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	setup_node_to_cpumask_map();
>> +
>> +	/* init boot processor */
>> +	cpu_to_node_map[0] = 0;
>> +	map_cpu_to_node(0, 0);
>> +
>> +	return 0;
>> +}
