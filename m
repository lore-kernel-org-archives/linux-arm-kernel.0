From: gpkulkarni@gmail.com (Ganapatrao Kulkarni)
Date: Mon, 24 Aug 2015 18:57:38 +0530
Subject: [PATCH] irqchip, gicv3-its, numa: Workaround for Cavium ThunderX
 erratum 23144
In-Reply-To: <55DB11F3.1070604@arm.com>
References: <20150822131050.GK1820@rric.localdomain> <55DAEF3C.5090303@arm.com>
 <CAFpQJXVVcdag7OQnCxqyEw601Y32eO2rHCmH1_bVzyvg+OPzRA@mail.gmail.com>
 <55DB11F3.1070604@arm.com>
Message-ID: <CAFpQJXUTNss=u2x7Ynd9wOObZn_ZHkcMz2+F4MKooy5jrvZ02w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 24, 2015 at 6:15 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> On 24/08/15 13:30, Ganapatrao Kulkarni wrote:
>> Hi Marc,
>>
>> thanks for the review comments.
>>
>> On Mon, Aug 24, 2015 at 3:47 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
>>> Hi Robert,
>>>
>>> Just came back from the Seattle madness, so picking up patches in
>>> reverse order... ;-)
>>>
>>> On 22/08/15 14:10, Robert Richter wrote:
>>>> The patch below adds a workaround for gicv3 in a numa environment. It
>>>> is on top of my recent gicv3 errata patch submission v4 and Ganapat's
>>>> arm64 numa patches for devicetree v5.
>>>>
>>>> Please comment.
>>>>
>>>> Thanks,
>>>>
>>>> -Robert
>>>>
>>>>
>>>>
>>>> From c432820451a46b8d1e299b8bfbfcdcb3b75340e7 Mon Sep 17 00:00:00 2001
>>>> From: Ganapatrao Kulkarni <gkulkarni@caviumnetworks.com>
>>>> Date: Wed, 19 Aug 2015 23:40:05 +0530
>>>> Subject: [PATCH] irqchip, gicv3-its, numa: Workaround for Cavium ThunderX erratum
>>>>  23144
>>>>
>>>> This implements a workaround for gicv3-its erratum 23144 applicable
>>>> for Cavium's ThunderX multinode systems.
>>>>
>>>> The erratum fixes the hang of ITS SYNC command by avoiding inter node
>>>> io and collections/cpu mapping. This fix is only applicable for
>>>> Cavium's ThunderX dual-socket platforms.
>>>
>>> Can you please elaborate on this? I can't see any reference to the SYNC
>>> command there. Is that a case of an ITS not being able to route LPIs to
>>> cores on another socket?
>> we were seeing mapc command failing when we were mapping its of node0
>> with collections of node1(vice-versa).
>
> There is no such thing as "collection of node1". There are collections
> mapped to redistributors.
ok.
>
>> we found sync was timing out, which is issued post mapc(also for mapvi
>> and movi).
>> Yes this errata limits the routing of inter-node LPIs.
>
> Please update the commit message to reflect the actual issue.
sure.
>
>>
>>>
>>> I really need more details to understand this patch (please use short
>>> sentences, I'm still in a different time zone).
>>>
>>>>
>>>> Signed-off-by: Ganapatrao Kulkarni <gkulkarni@caviumnetworks.com>
>>>> [ rric: Reworked errata code, added helper functions, updated commit
>>>>       message. ]
>>>>
>>>> Signed-off-by: Robert Richter <rrichter@cavium.com>
>>>> ---
>>>>  arch/arm64/Kconfig               | 14 +++++++++++
>>>>  drivers/irqchip/irq-gic-common.c |  5 ++--
>>>>  drivers/irqchip/irq-gic-v3-its.c | 54 ++++++++++++++++++++++++++++++++++------
>>>>  3 files changed, 64 insertions(+), 9 deletions(-)
>>>>
>>>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>>>> index 3809187ed653..b92b7b70b29b 100644
>>>> --- a/arch/arm64/Kconfig
>>>> +++ b/arch/arm64/Kconfig
>>>> @@ -421,6 +421,20 @@ config ARM64_ERRATUM_845719
>>>>
>>>>         If unsure, say Y.
>>>>
>>>> +config CAVIUM_ERRATUM_22375
>>>> +     bool "Cavium erratum 22375, 24313"
>>>> +     depends on NUMA
>>>> +     default y
>>>> +     help
>>>> +             Enable workaround for erratum 22375, 24313.
>>>> +
>>>> +config CAVIUM_ERRATUM_23144
>>>> +     bool "Cavium erratum 23144"
>>>> +     depends on NUMA
>>>> +     default y
>>>> +     help
>>>> +             Enable workaround for erratum 23144.
>>>> +
>>>>  config CAVIUM_ERRATUM_23154
>>>>       bool "Cavium erratum 23154: Access to ICC_IAR1_EL1 is not sync'ed"
>>>>       depends on ARCH_THUNDER
>>>> diff --git a/drivers/irqchip/irq-gic-common.c b/drivers/irqchip/irq-gic-common.c
>>>> index ee789b07f2d1..1dfce64dbdac 100644
>>>> --- a/drivers/irqchip/irq-gic-common.c
>>>> +++ b/drivers/irqchip/irq-gic-common.c
>>>> @@ -24,11 +24,12 @@
>>>>  void gic_check_capabilities(u32 iidr, const struct gic_capabilities *cap,
>>>>                       void *data)
>>>>  {
>>>> -     for (; cap->desc; cap++) {
>>>> +     for (; cap->init; cap++) {
>>>>               if (cap->iidr != (cap->mask & iidr))
>>>>                       continue;
>>>>               cap->init(data);
>>>> -             pr_info("%s\n", cap->desc);
>>>> +             if (cap->desc)
>>>> +                     pr_info("%s\n", cap->desc);
>>>
>>> No. I really want to see what errata are applied when I look at a kernel
>>> log.
>> sorry, did not understood your comment, it is still printed using cap->desc.
>
> Yes, but you are making desc optional, and I don't want it to be
> optional. I want the kernel to scream that we're using an erratum
> workaround so that we can understand what is happening when reading a
> kernel log.
sure, will add desc string.
>
>>>>       }
>>>>  }
>>>>
>>>> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
>>>> index 4bb135721e72..666be39f13a9 100644
>>>> --- a/drivers/irqchip/irq-gic-v3-its.c
>>>> +++ b/drivers/irqchip/irq-gic-v3-its.c
>>>> @@ -43,7 +43,8 @@
>>>>  #include "irqchip.h"
>>>>
>>>>  #define ITS_FLAGS_CMDQ_NEEDS_FLUSHING                (1ULL << 0)
>>>> -#define ITS_FLAGS_CAVIUM_THUNDERX            (1ULL << 1)
>>>> +#define ITS_WORKAROUND_CAVIUM_22375          (1ULL << 1)
>>>> +#define ITS_WORKAROUND_CAVIUM_23144          (1ULL << 2)
>>>>
>>>>  #define RDIST_FLAGS_PROPBASE_NEEDS_FLUSHING  (1 << 0)
>>>>
>>>> @@ -76,6 +77,7 @@ struct its_node {
>>>>       struct list_head        its_device_list;
>>>>       u64                     flags;
>>>>       u32                     ite_size;
>>>> +     int                     numa_node;
>>>>  };
>>>>
>>>>  #define ITS_ITT_ALIGN                SZ_256
>>>> @@ -609,11 +611,18 @@ static void its_eoi_irq(struct irq_data *d)
>>>>  static int its_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
>>>>                           bool force)
>>>>  {
>>>> -     unsigned int cpu = cpumask_any_and(mask_val, cpu_online_mask);
>>>> +     unsigned int cpu;
>>>>       struct its_device *its_dev = irq_data_get_irq_chip_data(d);
>>>>       struct its_collection *target_col;
>>>>       u32 id = its_get_event_id(d);
>>>>
>>>> +     if (its_dev->its->flags & ITS_WORKAROUND_CAVIUM_23144) {
>>>> +             cpu = cpumask_any_and(mask_val,
>>>> +                             cpumask_of_node(its_dev->its->numa_node));
>>>
>>> I suppose cpumask_of_node returns only the *online* cores of a given
>>> node, right?
>> yes.
>>>
>>>> +     } else {
>>>> +             cpu = cpumask_any_and(mask_val, cpu_online_mask);
>>>> +     }
>>>> +
>>>>       if (cpu >= nr_cpu_ids)
>>>>               return -EINVAL;
>>>>
>>>> @@ -845,7 +854,7 @@ static int its_alloc_tables(struct its_node *its)
>>>>       u64 typer;
>>>>       u32 ids;
>>>>
>>>> -     if (its->flags & ITS_FLAGS_CAVIUM_THUNDERX) {
>>>> +     if (its->flags & ITS_WORKAROUND_CAVIUM_22375) {
>>>>               /*
>>>>                * erratum 22375: only alloc 8MB table size
>>>>                * erratum 24313: ignore memory access type
>>>> @@ -1093,6 +1102,11 @@ static void its_cpu_init_lpis(void)
>>>>       dsb(sy);
>>>>  }
>>>>
>>>> +static inline int numa_node_id_early(void)
>>>> +{
>>>> +     return MPIDR_AFFINITY_LEVEL(read_cpuid_mpidr(), 2);
>>>> +}
>>>> +
>>>>  static void its_cpu_init_collection(void)
>>>>  {
>>>>       struct its_node *its;
>>>> @@ -1104,6 +1118,11 @@ static void its_cpu_init_collection(void)
>>>>       list_for_each_entry(its, &its_nodes, entry) {
>>>>               u64 target;
>>>>
>>>> +             /* avoid cross node core and its mapping */
>>>> +             if ((its->flags & ITS_WORKAROUND_CAVIUM_23144) &&
>>>> +                     its->numa_node != numa_node_id_early())
>>>> +                             continue;
>>>> +
>>>
>>> Argh. This is horrible. You really need some topology bindings to
>>> describe your system instead of hardcoding some random level of
>>> affinity. The next time someone is going to come up with a similarly
>>> broken system, they will have to reinvent that wheel.
>>  thanks for the suggestion, we will use cpu_topology[cpuid].cluster_id
>> instead of  function numa_node_id_early()
>
> Make sure you can relate the ITS to it (have a way to find out which
> node a given ITS belong to, without playing tricks with the memory map.
ok
>
>>>
>>>>               /*
>>>>                * We now have to bind each collection to its target
>>>>                * redistributor.
>>>> @@ -1372,9 +1391,15 @@ static void its_irq_domain_activate(struct irq_domain *domain,
>>>>  {
>>>>       struct its_device *its_dev = irq_data_get_irq_chip_data(d);
>>>>       u32 event = its_get_event_id(d);
>>>> +     unsigned int cpu;
>>>> +
>>>> +     if (its_dev->its->flags & ITS_WORKAROUND_CAVIUM_23144)
>>>> +             cpu = cpumask_first(cpumask_of_node(its_dev->its->numa_node));
>>>> +     else
>>>> +             cpu = cpumask_first(cpu_online_mask);
>>>
>>> Looks like this can be factored with the code you've added in set_affinity.
>> we cant issue mapvi with cross-node mapping.
>
> And? You have almost the same code twice. Surely you can devise a single
> helper that holds this code.
sure will do.
>
>>>>
>>>>       /* Bind the LPI to the first possible CPU */
>>>> -     its_dev->event_map.col_map[event] = cpumask_first(cpu_online_mask);
>>>> +     its_dev->event_map.col_map[event] = cpu;
>>>>
>>>>       /* Map the GIC IRQ and event to the device */
>>>>       its_send_mapvi(its_dev, d->hwirq, event);
>>>> @@ -1457,16 +1482,31 @@ static int its_force_quiescent(void __iomem *base)
>>>>       }
>>>>  }
>>>>
>>>> +static inline int its_get_node_thunderx(struct its_node *its)
>>>> +{
>>>> +     return (its->phys_base >> 44) & 0x3;
>>>
>>> Why 3? Is that because you have provision for 4 sockets or what?
>> yes.
>>>
>>>> +}
>>>> +
>>>>  static void its_enable_cavium_thunderx(void *data)
>>>>  {
>>>> -     struct its_node *its = data;
>>>> +     struct its_node __maybe_unused *its = data;
>>>>
>>>> -     its->flags |= ITS_FLAGS_CAVIUM_THUNDERX;
>>>> +#ifdef CONFIG_CAVIUM_ERRATUM_22375
>>>> +     its->flags |= ITS_WORKAROUND_CAVIUM_22375;
>>>> +     pr_info("ITS: Enabling workaround for 22375, 24313\n");
>>>> +#endif
>>>> +
>>>> +#ifdef CONFIG_CAVIUM_ERRATUM_23144
>>>> +     if (num_possible_nodes() > 1) {
>>>> +             its->numa_node = its_get_node_thunderx(its);
>>>
>>> I'd rather see numa_node being always initialized to something useful.
>>> If you're adding numa support, why can't this be initialized via
>>> standard topology bindings?
>> IIUC, topology defines only cpu topology.
>
> Well, welcome to a much more complex system where both your CPUs and
> your IOs have some degree of affinity. This needs to be described
> properly, and not hacked on the side.
ok, will add description for the function.
>
> Thanks,
>
>         M.
> --
> Jazz is not dead. It just smells funny...

thanks
Ganapat
