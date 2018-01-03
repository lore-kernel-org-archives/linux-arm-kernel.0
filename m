From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 3 Jan 2018 10:13:12 +0000
Subject: [PATCH] irqchip/gic-v3-its: Add workaround for ThunderX2 erratum
 #174
In-Reply-To: <CAKTKpr444LU_RuDYoYydSht2JsLHdViibOKLA6ykgGL-_FKtCQ@mail.gmail.com>
References: <20180103063224.9965-1-ganapatrao.kulkarni@cavium.com>
 <410d1cf1-c2f4-53a9-77e5-24323a960739@arm.com>
 <CAKTKpr444LU_RuDYoYydSht2JsLHdViibOKLA6ykgGL-_FKtCQ@mail.gmail.com>
Message-ID: <da5b60cf-2ede-720e-b957-4e88325a7810@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/01/18 09:35, Ganapatrao Kulkarni wrote:
> Hi Marc,
> 
> On Wed, Jan 3, 2018 at 2:17 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
>> On 03/01/18 06:32, Ganapatrao Kulkarni wrote:
>>> When an interrupt is moved across node collections on ThunderX2
>>
>> node collections?
> 
> ok, i will rephrase it.
>  i was intended to say cross NUMA node collection/cpu affinity change.
> 
>>
>>> multi Socket platform, an interrupt stops routed to new collection
>>> and results in loss of interrupts.
>>>
>>> Adding workaround to issue INV after MOVI for cross-node collection
>>> move to flush out the cached entry.
>>>
>>> Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
>>> ---
>>>  Documentation/arm64/silicon-errata.txt |  1 +
>>>  arch/arm64/Kconfig                     | 11 +++++++++++
>>>  drivers/irqchip/irq-gic-v3-its.c       | 24 ++++++++++++++++++++++++
>>>  3 files changed, 36 insertions(+)
>>>
>>> diff --git a/Documentation/arm64/silicon-errata.txt b/Documentation/arm64/silicon-errata.txt
>>> index fc1c884..fb27cb5 100644
>>> --- a/Documentation/arm64/silicon-errata.txt
>>> +++ b/Documentation/arm64/silicon-errata.txt
>>> @@ -63,6 +63,7 @@ stable kernels.
>>>  | Cavium         | ThunderX Core   | #27456          | CAVIUM_ERRATUM_27456        |
>>>  | Cavium         | ThunderX Core   | #30115          | CAVIUM_ERRATUM_30115        |
>>>  | Cavium         | ThunderX SMMUv2 | #27704          | N/A                         |
>>> +| Cavium         | ThunderX2 ITS   | #174            | CAVIUM_ERRATUM_174          |
>>>  | Cavium         | ThunderX2 SMMUv3| #74             | N/A                         |
>>>  | Cavium         | ThunderX2 SMMUv3| #126            | N/A                         |
>>>  |                |                 |                 |                             |
>>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>>> index c9a7e9e..71a7e30 100644
>>> --- a/arch/arm64/Kconfig
>>> +++ b/arch/arm64/Kconfig
>>> @@ -461,6 +461,17 @@ config ARM64_ERRATUM_843419
>>>
>>>         If unsure, say Y.
>>>
>>> +config CAVIUM_ERRATUM_174
>>> +     bool "Cavium ThunderX2 erratum 174"
>>> +     depends on NUMA
>>
>> Why? This system will be affected no matter whether NUMA is selected or not.
> 
> it does not makes sense to enable on non-NUMA/single socket platforms.
> By default NUMA is enabled on ThunderX2 dual socket platforms.

<quote>
config ARCH_THUNDER2
        bool "Cavium ThunderX2 Server Processors"
        select GPIOLIB
        help
          This enables support for Cavium's ThunderX2 CN99XX family of
          server processors.
</quote>

Do you see any NUMA here? I can perfectly compile a kernel with both
sockets, and not using NUMA. NUMA has to do with memory, and not interrupts.

> 
>>
>>> +     default y
>>> +     help
>>> +       LPI stops routed to redistributors after inter node collection
>>> +       move in ITS. Enable workaround to invalidate ITS entry after
>>> +       inter-node collection move.
>>
>> That's a very terse description. Nobody knows what an LPI, a
>> redistributor or a collection is. Please explain what the erratum is in
>> layman's terms (Cavium ThunderX2 systems may loose interrupts on
>> affinity change) so that people understand whether or not they are affected.
> 
> ok, i will rephrase it in next version.
>>
>>> +
>>> +       If unsure, say Y.
>>> +
>>>  config CAVIUM_ERRATUM_22375
>>>       bool "Cavium erratum 22375, 24313"
>>>       default y
>>> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
>>> index 06f025f..d8b9c96 100644
>>> --- a/drivers/irqchip/irq-gic-v3-its.c
>>> +++ b/drivers/irqchip/irq-gic-v3-its.c
>>> @@ -46,6 +46,7 @@
>>>  #define ITS_FLAGS_CMDQ_NEEDS_FLUSHING                (1ULL << 0)
>>>  #define ITS_FLAGS_WORKAROUND_CAVIUM_22375    (1ULL << 1)
>>>  #define ITS_FLAGS_WORKAROUND_CAVIUM_23144    (1ULL << 2)
>>> +#define ITS_FLAGS_WORKAROUND_CAVIUM_174              (1ULL << 3)
>>>
>>>  #define RDIST_FLAGS_PROPBASE_NEEDS_FLUSHING  (1 << 0)
>>>
>>> @@ -1119,6 +1120,12 @@ static int its_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
>>>       if (cpu != its_dev->event_map.col_map[id]) {
>>>               target_col = &its_dev->its->collections[cpu];
>>>               its_send_movi(its_dev, target_col, id);
>>> +             if (its_dev->its->flags & ITS_FLAGS_WORKAROUND_CAVIUM_174) {
>>> +                     /* Issue INV for cross node collection move. */
>>> +                     if (cpu_to_node(cpu) !=
>>> +                             cpu_to_node(its_dev->event_map.col_map[id]))
>>> +                             its_send_inv(its_dev, id);
>>> +             }
>>
>> What happens if an interrupt happens after the MOV, but before the INV?
> 
> there can be drop,  if interrupt happens before INV, however, it is
> highly unlikely that we will hit the issue since MOVI and INV are
> executed back to back. this workaround fixed issue seen on couple of
> IOs.

Really? So this doesn't fix anything, and the device may just wait
forever for the CPU to service an LPI that was never delivered. I'm
sorry, but that's not an acceptable workaround.

I can see two solutions:
1) you inject an interrupt after the INV as you may have lost at least one
2) you restrict the affinity of LPIs to a single socket

(1) will generate spurious interrupts, but will be safe. (2) will result
in an unbalanced system. Pick your poison...

You may be able to achieve something by disabling the LPI before
performing the MOVI/INV sequence, and reenable it afterwards, but only
you can tell if this could work with your HW.

In any case, I won't take a workaround that leaves any chance of loosing
an interrupt.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
