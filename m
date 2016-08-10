From: thunder.leizhen@huawei.com (Leizhen (ThunderTown))
Date: Wed, 10 Aug 2016 11:42:19 +0800
Subject: [PATCH v5 03/14] arm64/numa: add nid check for memory block
In-Reply-To: <57AA8D9B.7010102@huawei.com>
References: <1470647899-6324-1-git-send-email-thunder.leizhen@huawei.com>
 <1470647899-6324-4-git-send-email-thunder.leizhen@huawei.com>
 <57AA8D9B.7010102@huawei.com>
Message-ID: <57AAA29B.9060608@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2016/8/10 10:12, Hanjun Guo wrote:
> On 2016/8/8 17:18, Zhen Lei wrote:
>> Use the same tactic to cpu and numa-distance nodes.
>>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> ---
>>  arch/arm64/mm/numa.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/arch/arm64/mm/numa.c b/arch/arm64/mm/numa.c
>> index c7fe3ec..2601660 100644
>> --- a/arch/arm64/mm/numa.c
>> +++ b/arch/arm64/mm/numa.c
>> @@ -141,6 +141,11 @@ int __init numa_add_memblk(int nid, u64 start, u64 end)
>>  {
>>  	int ret;
>>
>> +	if (nid >= MAX_NUMNODES) {
>> +		pr_warn("NUMA: Node id %u exceeds maximum value\n", nid);
>> +		return -EINVAL;
>> +	}
> 
> I think this check should be added to of_numa_parse_memory_nodes(), which before
> the numa_add_memblk() called, it's the same logic in of_numa_parse_cpu_nodes() and
> the node id is checked before calling numa_add_memblk() in ACPI.

Yes, you are right. This check is arch independent.

> 
> Thanks
> Hanjun
> 
> 
> 
> .
> 
