From: ddaney.cavm@gmail.com (David Daney)
Date: Fri, 28 Oct 2016 10:02:37 -0700
Subject: [PATCH 1/2] of, numa: Add function to disable of_node_to_nid().
In-Reply-To: <20161028101905.GA6343@arm.com>
References: <1477431061-7258-1-git-send-email-ddaney.cavm@gmail.com>
 <1477431061-7258-2-git-send-email-ddaney.cavm@gmail.com>
 <20161028101905.GA6343@arm.com>
Message-ID: <581384AD.1000309@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/28/2016 03:19 AM, Will Deacon wrote:
> On Tue, Oct 25, 2016 at 02:31:00PM -0700, David Daney wrote:
>> From: David Daney <david.daney@cavium.com>
>>
>> On arm64 NUMA kernels we can pass "numa=off" on the command line to
>> disable NUMA.  A side effect of this is that kmalloc_node() calls to
>> non-zero nodes will crash the system with an OOPS:
>>
>> [    0.000000] [<fffffc00081bba84>] __alloc_pages_nodemask+0xa4/0xe68
>> [    0.000000] [<fffffc00082163a8>] new_slab+0xd0/0x57c
>> [    0.000000] [<fffffc000821879c>] ___slab_alloc+0x2e4/0x514
>> [    0.000000] [<fffffc000823882c>] __slab_alloc+0x48/0x58
>> [    0.000000] [<fffffc00082195a0>] __kmalloc_node+0xd0/0x2e0
>> [    0.000000] [<fffffc00081119b8>] __irq_domain_add+0x7c/0x164
>> [    0.000000] [<fffffc0008b75d30>] its_probe+0x784/0x81c
>> [    0.000000] [<fffffc0008b75e10>] its_init+0x48/0x1b0
>> .
>> .
>> .
>>
>> This is caused by code like this in kernel/irq/irqdomain.c
>>
>>      domain = kzalloc_node(sizeof(*domain) + (sizeof(unsigned int) * size),
>>                    GFP_KERNEL, of_node_to_nid(of_node));
>>
>> When NUMA is disabled, the concept of a node is really undefined, so
>> of_node_to_nid() should unconditionally return NUMA_NO_NODE.
>>
>> Add __of_force_no_numa() to allow of_node_to_nid() to be forced to
>> return NUMA_NO_NODE.
>>
>> The follow on patch will call this new function from the arm64 numa
>> code.
>>
>> Reported-by: Gilbert Netzer <noname@pdc.kth.se>
>> Signed-off-by: David Daney <david.daney@cavium.com>
>> ---
>>   drivers/of/of_numa.c | 15 +++++++++++++++
>>   include/linux/of.h   |  2 ++
>>   2 files changed, 17 insertions(+)
>>
>> diff --git a/drivers/of/of_numa.c b/drivers/of/of_numa.c
>> index f63d4b0d..2212299 100644
>> --- a/drivers/of/of_numa.c
>> +++ b/drivers/of/of_numa.c
>> @@ -150,12 +150,27 @@ static int __init of_numa_parse_distance_map(void)
>>   	return ret;
>>   }
>>
>> +static bool of_force_no_numa;
>> +
>> +void __of_force_no_numa(void)
>> +{
>> +	of_force_no_numa = true;
>> +}
>> +
>>   int of_node_to_nid(struct device_node *device)
>>   {
>>   	struct device_node *np;
>>   	u32 nid;
>>   	int r = -ENODATA;
>>
>> +	/*
>> +	 * If NUMA forced off, nodes are meaningless.  Return
>> +	 * NUMA_NO_NODE so that any node specific memory allocations
>> +	 * can succeed from the default pool.
>> +	 */
>> +	if (of_force_no_numa)
>> +		return NUMA_NO_NODE;
>
> Why don't you just check if the nid you get back from the device is set in
> numa_nodes_parsed and return NUMA_NO_NODE if not?

numa_nodes_parsed is __initdata.  Perhaps node_possible_map would be better.

I will try that.

David.


>
> Will
>
