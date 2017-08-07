From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 7 Aug 2017 14:36:31 +0100
Subject: [PATCH] irqchip: uniphier-aidet: add UniPhier AIDET irqchip driver
In-Reply-To: <CAK7LNAR=t2=6LbmFKUhSD-ttfxVcyOy6Qy=kj7hsFftDFWqmzQ@mail.gmail.com>
References: <1501758910-3488-1-git-send-email-yamada.masahiro@socionext.com>
 <cae2ec7d-5f57-3e4f-7688-5a1523c66b82@arm.com>
 <CAK7LNAR=t2=6LbmFKUhSD-ttfxVcyOy6Qy=kj7hsFftDFWqmzQ@mail.gmail.com>
Message-ID: <43777e45-c002-95b8-3b15-d57680f320ec@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/08/17 12:59, Masahiro Yamada wrote:
> Hi Marc,
> 
> Thanks for your comments.
> 
> 
> 2017-08-07 19:43 GMT+09:00 Marc Zyngier <marc.zyngier@arm.com>:
>> On 03/08/17 12:15, Masahiro Yamada wrote:
>>> UniPhier SoCs contain AIDET (ARM Interrupt Detector).  This is intended
>>> to provide additional features that are not covered by GIC.  The main
>>> purpose is to provide logic inverter to support low level and falling
>>> edge trigger type for interrupt lines from on-board devices.
>>>
>>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>>> ---
>>>
>>>  .../socionext,uniphier-aidet.txt                   |  32 +++
>>>  MAINTAINERS                                        |   1 +
>>>  drivers/irqchip/Kconfig                            |   5 +
>>>  drivers/irqchip/Makefile                           |   1 +
>>>  drivers/irqchip/irq-uniphier-aidet.c               | 252 +++++++++++++++++++++
>>>  5 files changed, 291 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/socionext,uniphier-aidet.txt
>>>  create mode 100644 drivers/irqchip/irq-uniphier-aidet.c
>>>
>>> diff --git a/Documentation/devicetree/bindings/interrupt-controller/socionext,uniphier-aidet.txt b/Documentation/devicetree/bindings/interrupt-controller/socionext,uniphier-aidet.txt
>>> new file mode 100644
>>> index 000000000000..af57fbccd234
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/interrupt-controller/socionext,uniphier-aidet.txt
>>> @@ -0,0 +1,32 @@
>>> +UniPhier AIDET
>>> +
>>> +UniPhier AIDET (ARM Interrupt Detector) is an add-on block for ARM GIC (Generic
>>> +Interrupt Controller).  GIC itself can handle only high level and rising edge
>>> +interrupts.  The AIDET provides logic inverter to support low level and falling
>>> +edge interrupts.
>>> +
>>> +Required properties:
>>> +- compatible: Should be one of the following:
>>> +    "socionext,uniphier-ld4-aidet"  - for LD4 SoC
>>> +    "socionext,uniphier-pro4-aidet" - for Pro4 SoC
>>> +    "socionext,uniphier-sld8-aidet" - for sLD8 SoC
>>> +    "socionext,uniphier-pro5-aidet" - for Pro5 SoC
>>> +    "socionext,uniphier-pxs2-aidet" - for PXs2/LD6b SoC
>>> +    "socionext,uniphier-ld11-aidet" - for LD11 SoC
>>> +    "socionext,uniphier-ld20-aidet" - for LD20 SoC
>>> +    "socionext,uniphier-pxs3-aidet" - for PXs3 SoC
>>> +- reg: Specifies offset and length of the register set for the device.
>>> +- interrupt-controller: Identifies the node as an interrupt controller
>>> +- #interrupt-cells : Specifies the number of cells needed to encode an interrupt
>>> +  source.  The value should be 2.  The first cell defines the interrupt number.
>>> +  The second cell specifies the trigger type as defined in interrupts.txt in
>>> +  this directory.
>>
>> "interrupt number" is a pretty vague concept. You probably want to
>> explain how it relates to the GIC (is that the INTID? or the SPI number?
>> What about PPIs?).
> 
> I do not know the term "INITD".

That's the interrupt number as exposed by the GIC HW (see the GICv3
specification).

> 
> As far as I understood from the register bit arrangements,
> this hardware block seems to want to count IRQ numbers starting from SGI/PPI.
> 
> reg_offset 0x00:  for IRQ 0 - 31       (SGI/PPI)
> reg_offset 0x04:  for IRQ 32 - 63      (SPI 0-31)
> reg_offset 0x08:  for IRQ 64 - 95      (SPI 32-63)
> reg_offset 0x0c:  for IRQ 96 - 127     (SPI 64-95)
>    ...
> 
> 
> The reg_offset 0x00 corresponds to PPI of GIC,
> but never supported by this hardware.  So, reg_offset 0x00 is never used.
> 
> This hardware only supports SPI, and
> the reg_offset 0x04 corresponds to the start of SPI.
> 
> Perhaps, DT binding can describe
> "The first cell defines the interrupt number (SPI + 32)".

Something like that. Or you could make it easy for whoever is writing
the DT and adopt the same convention as the GIC itself, exposing the SPI
number on its own.

> 
> 
> 
>>> +     spin_lock_irqsave(&priv->lock, flags);
>>> +     tmp = readl(priv->reg_base + reg);
>>> +     tmp &= ~mask;
>>> +     tmp |= mask & val;
>>> +     writel(tmp, priv->reg_base + reg);
>>
>> Given that these accesses do not seem to rely on anything making it into
>> memory before the access, consider using the _relaxed accessors (no need
>> for two DSBs here).
> 
> Will fix.
> 
> 
> 
>>> +     spin_unlock_irqrestore(&priv->lock, flags);
>>> +}
>>> +
>>> +static void uniphier_aidet_detconf_update(struct uniphier_aidet_priv *priv,
>>> +                                       unsigned long index, unsigned int val)
>>> +{
>>> +     unsigned int reg;
>>> +     u32 mask;
>>> +
>>> +     reg = UNIPHIER_AIDET_DETCONF + index / 32 * 4;
>>
>> What is the purpose of UNIPHIER_AIDET_DETCONF here, which is always 0?
> 
> I saw a little more registers in the hardware spec, but
> DETCONF was the only register base I thought useful for the Linux driver.
> 
> I can remove this macro if desired.

The convention for these register offsets is to write something like:

	writel_relaxed(val, base + REG_OFFSET + reg);

which makes it clear what this offset is. I'm happy for you to keep it
around if you write it in a similar way.

> 
> 
> 
>>> +static int uniphier_aidet_irq_set_type(struct irq_data *data, unsigned int type)
>>> +{
>>> +     struct uniphier_aidet_priv *priv = data->chip_data;
>>> +     unsigned int val = 0;
>>> +
>>> +     /* enable inverter for active low triggers */
>>> +     switch (type) {
>>> +     case IRQ_TYPE_EDGE_RISING:
>>> +     case IRQ_TYPE_LEVEL_HIGH:
>>
>> Nit: consider moving the "val" assignment here so that the symmetry
>> between the two cases becomes obvious.
> 
> Will update.
> 
> 
> 
>>> +
>>> +             /* parent is GIC */
>>> +             parent_fwspec.fwnode = domain->parent->fwnode;
>>> +             parent_fwspec.param_count = 3;
>>> +             parent_fwspec.param[0] = 0;             /* SPI */
>>> +             parent_fwspec.param[1] = hwirq - 32;
>>> +             parent_fwspec.param[2] = IRQ_TYPE_LEVEL_HIGH;
>>
>> So this is SPI only? And your first line starts at 32? So what is in the
>> 32bit register?
> 
> 
> As mentioned above, reg_offset 0 is never used, but I guess
> the developer of this hardware block wanted to match the register bit
> and hwirq number.
> 
> So, I respect that and hwirq 32 of this hardware corresponds to the
> start of SPI.

Fair enough.

> 
> 
> 
> 
>>> +
>>> +             ret = irq_domain_alloc_irqs_parent(domain, virq, 1,
>>> +                                                &parent_fwspec);
>>> +             if (ret)
>>> +                     return ret;
>>> +
>>> +             virq++;
>>> +             hwirq++;
>>> +     }
>>
>> Two things here: is there any case where you actually have nr_irqs not
>> being 1? As far as I know, this is only used for Multi-MSI, and nothing
>> else. And if you do need it, then you should probably have a slightly
>> better error handling (you're leaking interrupts on error here).
> 
> 
> I always expect nr_irqs == 1.
> 
> I did not now how to handle cases where nr_irqs is greater than 1.
> How should I change it?
> 
> If nr_irqs is not 1, error out immediately?
> 
>        if (nr_irqs != 1)
>                return -EINVAL;

That'd be fine indeed.

> 
> 
> 
>>> +     priv->domain = irq_domain_add_hierarchy(parent_domain, 0,
>>> +                                             UNIPHIER_AIDET_NR_IRQS,
>>> +                                             dev->of_node,
>>> +                                             &uniphier_aidet_domain_ops,
>>> +                                             priv);
>>
>> You seem to be able to handle multiple AIDET devices, and yet your DT
>> description doesn't specify a base/span for the interrupt lines that are
>> covered by this device. Is that something you intend to support?
> 
> 
> I expect only one instance of this hardware in the system.
> 
> If desired, I can allocate struct irq_chip statically:
> 
> 
> static struct irq_chip uniphier_aidet_irq_chip = {
>       .name = "UniPhier AIDET",
>       .irq_mask = ...,
>       .irq_unmask = ...,
> 
>      ..
> };

I think that would indeed make it obvious that you do not intend to
support multiple of these. And maybe simplify the name to "AIDET", as
"UniPhier AIDET" is quite large in /proc/interrupts...

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
