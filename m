From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 22 Aug 2016 15:28:34 +0100
Subject: [PATCH] mm, numa: boot cpu should bound to the node0 when
 node_off enable
In-Reply-To: <57B82533.9010507@huawei.com>
References: <1471525766-12803-1-git-send-email-zhongjiang@huawei.com>
 <20160818160437.GA21343@e104818-lin.cambridge.arm.com>
 <CAFpQJXUYxPsTArMkv27r2u19v92APjjNF5W0bMNqQKGqNUin5g@mail.gmail.com>
 <57B667CA.5060905@huawei.com>
 <CAFpQJXVzr0uvV00vtQkrAxzezW=QRpL9EKPL+4yqhmKE5GdXKA@mail.gmail.com>
 <CAFpQJXXXAhQQxr9=SmW2-bHmAYQMyn93zFiYZiBqbjgyZg2oJw@mail.gmail.com>
 <57B82533.9010507@huawei.com>
Message-ID: <20160822142833.GE26494@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 20, 2016 at 05:38:59PM +0800, zhong jiang wrote:
> On 2016/8/19 12:11, Ganapatrao Kulkarni wrote:
> > On Fri, Aug 19, 2016 at 9:30 AM, Ganapatrao Kulkarni
> > <gpkulkarni@gmail.com> wrote:
> >> On Fri, Aug 19, 2016 at 7:28 AM, zhong jiang <zhongjiang@huawei.com> wrote:
> >>> On 2016/8/19 1:45, Ganapatrao Kulkarni wrote:
> >>>> On Thu, Aug 18, 2016 at 9:34 PM, Catalin Marinas
> >>>> <catalin.marinas@arm.com> wrote:
> >>>>> On Thu, Aug 18, 2016 at 09:09:26PM +0800, zhongjiang wrote:
> >>>>>> At present, boot cpu will bound to a node from device tree when node_off enable.
> >>>>>> if the node is not initialization, it will lead to a following problem.
[...]
> >>>>>> --- a/arch/arm64/mm/numa.c
> >>>>>> +++ b/arch/arm64/mm/numa.c
> >>>>>> @@ -119,7 +119,7 @@ void numa_store_cpu_info(unsigned int cpu)
> >>>>>>  void __init early_map_cpu_to_node(unsigned int cpu, int nid)
> >>>>>>  {
> >>>>>>       /* fallback to node 0 */
> >>>>>> -     if (nid < 0 || nid >= MAX_NUMNODES)
> >>>>>> +     if (nid < 0 || nid >= MAX_NUMNODES || numa_off)
> >>>>
> >>>> i  did not understood how this line change fixes the issue that you
> >>>> have mentioned (i too not understood fully the issue description)
> >>>> this array used while mapping node id when secondary cores comes up
> >>>> when numa_off is set the cpu_to_node_map[cpu] is not used and set to
> >>>> node0 always( refer function numa_store_cpu_info)..
> >>>> please provide more details to understand the issue you are facing.
> >>>> /*
> >>>>  *  Set the cpu to node and mem mapping
> >>>>  */
> >>>> void numa_store_cpu_info(unsigned int cpu)
> >>>> {
> >>>>         map_cpu_to_node(cpu, numa_off ? 0 : cpu_to_node_map[cpu]);
> >>>> }
> >>>
> >>> The issue comes up when we test the kdump. it will leads to kernel crash.
> >>> when I debug the issue, I find boot cpu actually bound to the node1. while
> >>> node1 is not real existence when numa_off enable.
> >>
> >> boot cpu is default mapped to node0
> >> are you running with any other patches?
> >
> > if you added any patch to change this code
> >   /* init boot processor */
> >         cpu_to_node_map[0] = 0;
> >         map_cpu_to_node(0, 0);
> >
> > then adding code to take-care numa_off here might solve your issue.
> 
>  but in of_smp_init_cpus, boot cpu will call early_map_cpu_to_node[] to get
>  the relation node. and the node is from devicetree.
> 
>  you points to the code will be covered with another node. therefore, it is
>  possible that cpu_to_node[cpu] will leads to the incorrect results. therefore,
>  The crash will come up.

I think I get Ganapat's point. The cpu_to_node_map[0] may be incorrectly
set by early_map_cpu_to_node() when called from smp_init_cpus() ->
of_parse_and_init_cpus(). However, the cpu_to_node_map[] array is *only*
read by numa_store_cpu_info(). This latter function calls
map_cpu_to_node() and, if numa_off, will only ever pass 0 as the nid.

Given that the cpu_to_node_map[] array is static, I don't see how any
non-zero value could leak outside the arch/arm64/mm/numa.c file.

So please give more details of any additional patches you have on top of
mainline or whether you reproduced this issue with the vanilla kernel
(since you mentioned kdump, that's not in mainline yet).

-- 
Catalin
