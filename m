From: gpkulkarni@gmail.com (Ganapatrao Kulkarni)
Date: Thu, 18 Aug 2016 23:15:41 +0530
Subject: [PATCH] mm, numa: boot cpu should bound to the node0 when
 node_off enable
In-Reply-To: <20160818160437.GA21343@e104818-lin.cambridge.arm.com>
References: <1471525766-12803-1-git-send-email-zhongjiang@huawei.com>
 <20160818160437.GA21343@e104818-lin.cambridge.arm.com>
Message-ID: <CAFpQJXUYxPsTArMkv27r2u19v92APjjNF5W0bMNqQKGqNUin5g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 18, 2016 at 9:34 PM, Catalin Marinas
<catalin.marinas@arm.com> wrote:
> On Thu, Aug 18, 2016 at 09:09:26PM +0800, zhongjiang wrote:
>> At present, boot cpu will bound to a node from device tree when node_off enable.
>> if the node is not initialization, it will lead to a following problem.
>>
>>  next_zones_zonelist+0x18/0x80
>>  __build_all_zonelists+0x1e0/0x288
>>  build_all_zonelists_init+0x10/0x1c
>>  build_all_zonelists+0x114/0x128
>>  start_kernel+0x1a0/0x414
>
> I think this "problem" is missing a lot of information. Is this supposed
> to be a kernel panic?
>
>> The patch fix it by fallback to node 0. therefore, the cpu will bound to the node
>> correctly.
>>
>> Signed-off-by: zhongjiang <zhongjiang@huawei.com>
>> ---
>>  arch/arm64/mm/numa.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/mm/numa.c b/arch/arm64/mm/numa.c
>> index 4dcd7d6..1f8f5da 100644
>> --- a/arch/arm64/mm/numa.c
>> +++ b/arch/arm64/mm/numa.c
>> @@ -119,7 +119,7 @@ void numa_store_cpu_info(unsigned int cpu)
>>  void __init early_map_cpu_to_node(unsigned int cpu, int nid)
>>  {
>>       /* fallback to node 0 */
>> -     if (nid < 0 || nid >= MAX_NUMNODES)
>> +     if (nid < 0 || nid >= MAX_NUMNODES || numa_off)

i  did not understood how this line change fixes the issue that you
have mentioned (i too not understood fully the issue description)
this array used while mapping node id when secondary cores comes up
when numa_off is set the cpu_to_node_map[cpu] is not used and set to
node0 always( refer function numa_store_cpu_info)..
please provide more details to understand the issue you are facing.
/*
 *  Set the cpu to node and mem mapping
 */
void numa_store_cpu_info(unsigned int cpu)
{
        map_cpu_to_node(cpu, numa_off ? 0 : cpu_to_node_map[cpu]);
}

thanks
Ganapat
>>               nid = 0;
>>
>>       cpu_to_node_map[cpu] = nid;
>
> The patch looks fine (slight inconsistence from the map_cpu_to_node()
> callers but I guess we don't want to expose numa_off outside this file).
> I would however like to see an Ack from Ganapat (cc'ed).
>
> --
> Catalin
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
