From: thunder.leizhen@huawei.com (Leizhen (ThunderTown))
Date: Sat, 27 Aug 2016 16:02:07 +0800
Subject: [PATCH v7 03/14] arm64/numa: add nid check for memory block
In-Reply-To: <20160826123929.GA30302@arm.com>
References: <1472024693-12912-1-git-send-email-thunder.leizhen@huawei.com>
 <1472024693-12912-4-git-send-email-thunder.leizhen@huawei.com>
 <20160826123929.GA30302@arm.com>
Message-ID: <57C148FF.3060506@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2016/8/26 20:39, Will Deacon wrote:
> On Wed, Aug 24, 2016 at 03:44:42PM +0800, Zhen Lei wrote:
>> Use the same tactic to cpu and numa-distance nodes.
>>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> ---
>>  drivers/of/of_numa.c | 5 +++++
>>  1 file changed, 5 insertions(+)
> 
> The subject has arm64/numa, but this is clearly core OF code and
I originally added below check in arch/arm64/mm/numa.c, until Hanjun Guo
told me that it should move into drivers/of/of_numa.c

I forgot updating this.

> requires an ack from Rob.
> 
> The commit message also doesn't make much sense to me.
> 
>> diff --git a/drivers/of/of_numa.c b/drivers/of/of_numa.c
>> index 7b3fbdc..afaeb9c 100644
>> --- a/drivers/of/of_numa.c
>> +++ b/drivers/of/of_numa.c
>> @@ -75,6 +75,11 @@ static int __init of_numa_parse_memory_nodes(void)
>>  			 */
>>  			continue;
>>
>> +		if (nid >= MAX_NUMNODES) {
>> +			pr_warn("NUMA: Node id %u exceeds maximum value\n", nid);
>> +			return -EINVAL;
>> +		}
> 
> Do you really want to return from the function here? Shouldn't we at least
> of_node_put(np), i.e. by using a break; ?
Thanks for pointing out this mistake. I will change to "r = -EINVAL" in the next version.

> 
> Will
> 
> .
> 
