From: gpkulkarni@gmail.com (Ganapatrao Kulkarni)
Date: Fri, 19 Aug 2016 09:30:03 +0530
Subject: [PATCH] mm, numa: boot cpu should bound to the node0 when
 node_off enable
In-Reply-To: <57B667CA.5060905@huawei.com>
References: <1471525766-12803-1-git-send-email-zhongjiang@huawei.com>
 <20160818160437.GA21343@e104818-lin.cambridge.arm.com>
 <CAFpQJXUYxPsTArMkv27r2u19v92APjjNF5W0bMNqQKGqNUin5g@mail.gmail.com>
 <57B667CA.5060905@huawei.com>
Message-ID: <CAFpQJXVzr0uvV00vtQkrAxzezW=QRpL9EKPL+4yqhmKE5GdXKA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 19, 2016 at 7:28 AM, zhong jiang <zhongjiang@huawei.com> wrote:
> On 2016/8/19 1:45, Ganapatrao Kulkarni wrote:
>> On Thu, Aug 18, 2016 at 9:34 PM, Catalin Marinas
>> <catalin.marinas@arm.com> wrote:
>>> On Thu, Aug 18, 2016 at 09:09:26PM +0800, zhongjiang wrote:
>>>> At present, boot cpu will bound to a node from device tree when node_off enable.
>>>> if the node is not initialization, it will lead to a following problem.
>>>>
>>>>  next_zones_zonelist+0x18/0x80
>>>>  __build_all_zonelists+0x1e0/0x288
>>>>  build_all_zonelists_init+0x10/0x1c
>>>>  build_all_zonelists+0x114/0x128
>>>>  start_kernel+0x1a0/0x414
>>> I think this "problem" is missing a lot of information. Is this supposed
>>> to be a kernel panic?
>>>
>>>> The patch fix it by fallback to node 0. therefore, the cpu will bound to the node
>>>> correctly.
>>>>
>>>> Signed-off-by: zhongjiang <zhongjiang@huawei.com>
>>>> ---
>>>>  arch/arm64/mm/numa.c | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/arch/arm64/mm/numa.c b/arch/arm64/mm/numa.c
>>>> index 4dcd7d6..1f8f5da 100644
>>>> --- a/arch/arm64/mm/numa.c
>>>> +++ b/arch/arm64/mm/numa.c
>>>> @@ -119,7 +119,7 @@ void numa_store_cpu_info(unsigned int cpu)
>>>>  void __init early_map_cpu_to_node(unsigned int cpu, int nid)
>>>>  {
>>>>       /* fallback to node 0 */
>>>> -     if (nid < 0 || nid >= MAX_NUMNODES)
>>>> +     if (nid < 0 || nid >= MAX_NUMNODES || numa_off)
>> i  did not understood how this line change fixes the issue that you
>> have mentioned (i too not understood fully the issue description)
>> this array used while mapping node id when secondary cores comes up
>> when numa_off is set the cpu_to_node_map[cpu] is not used and set to
>> node0 always( refer function numa_store_cpu_info)..
>> please provide more details to understand the issue you are facing.
>> /*
>>  *  Set the cpu to node and mem mapping
>>  */
>> void numa_store_cpu_info(unsigned int cpu)
>> {
>>         map_cpu_to_node(cpu, numa_off ? 0 : cpu_to_node_map[cpu]);
>> }
>>
>> thanks
>> Ganapat
> The issue comes up when we test the kdump. it will leads to kernel crash.
> when I debug the issue, I find boot cpu actually bound to the node1. while
> node1 is not real existence when numa_off enable.

boot cpu is default mapped to node0
are you running with any other patches?
>
> __build_all_zonelists will call the cpu_to_node[cpu], but orresponding relation
> will be obtained from the devicetree. therefore, the issue will come up.

when numa_off, all cpus are mapped to node0( refer
numa_store_cpu_info) and device tree mapping is ignored.
> The corresponding message is as follows when kdump start. it is obvious that mem
> range points to the node1 in the devicetree.
>
> Early memory node ranges
> node   0: [mem 0x0000005fe0000000-0x0000005fffffffff]
> Initmem setup node 0 [mem 0x0000005fe0000000-0x0000005fffffffff]
>
> Unable to handle kernel paging request at virtual address 00001690
> pgd = ffff800001226000
> [00001690] *pgd=0000000000000000
> Internal error: Oops: 96000004 [#1] SMP
>  Modules linked in:
> CPU: 0 PID: 0 Comm: swapper Not tainted 4.1.27-vhulk3.6.5.aarch64 #1
> Hardware name: Hisilicon Hi1612 Development Board (DT)
>  task: ffff80000102b730 ti: ffff800001018000 task.ti: ffff800001018000
> PC is at next_zones_zonelist+0x18/0x80
>  LR is at __build_all_zonelists+0x1e0/0x288
> next_zones_zonelist+0x18/0x80
>  __build_all_zonelists+0x1e0/0x288
> build_all_zonelists_init+0x10/0x1c
>  build_all_zonelists+0x114/0x128
>  start_kernel+0x1a0/0x414
>>>>               nid = 0;
>>>>
>>>>       cpu_to_node_map[cpu] = nid;
>>> The patch looks fine (slight inconsistence from the map_cpu_to_node()
>>> callers but I guess we don't want to expose numa_off outside this file).
>>> I would however like to see an Ack from Ganapat (cc'ed).
>>>
>>> --
>>> Catalin
>>>
>>> _______________________________________________
>>> linux-arm-kernel mailing list
>>> linux-arm-kernel at lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>> .
>>
>
>
