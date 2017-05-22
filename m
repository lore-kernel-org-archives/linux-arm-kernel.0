From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 22 May 2017 22:25:51 +0800
Subject: [linux-sunxi] Re: [PATCH v6 2/9] irqchip/sunxi-nmi: add support
 for the NMI in A64 R_INTC
In-Reply-To: <98014597-29BA-4D02-8137-4E399955F4FD@aosc.io>
References: <20170518071653.36561-1-icenowy@aosc.io>
 <20170518071653.36561-3-icenowy@aosc.io>
 <ed99d87b-86eb-cf8a-8614-51d59fa00c8c@arm.com>
 <98014597-29BA-4D02-8137-4E399955F4FD@aosc.io>
Message-ID: <CAGb2v66NY49OL0J3C64CKzngri5-Na6uPBizj-BNJW3vNkFUQw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 22, 2017 at 5:41 PM, Icenowy Zheng <icenowy@aosc.io> wrote:
>
>
> ? 2017?5?22? GMT+08:00 ??5:39:22, Marc Zyngier <marc.zyngier@arm.com> ??:
>>On 18/05/17 08:16, Icenowy Zheng wrote:
>>> Add support for the newly imported compatible for the A64 R_INTC in
>>> irq-sunxi-nmi driver.
>>>
>>> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
>>> ---
>>> Changes in v5:
>>> - Fix A64 R_INTC compatible.
>>>
>>>  drivers/irqchip/irq-sunxi-nmi.c | 13 +++++++++++++
>>>  1 file changed, 13 insertions(+)
>>>
>>> diff --git a/drivers/irqchip/irq-sunxi-nmi.c
>>b/drivers/irqchip/irq-sunxi-nmi.c
>>> index 668730c5cb66..5559c1d593bf 100644
>>> --- a/drivers/irqchip/irq-sunxi-nmi.c
>>> +++ b/drivers/irqchip/irq-sunxi-nmi.c
>>> @@ -56,6 +56,12 @@ static struct sunxi_sc_nmi_reg_offs sun9i_reg_offs
>>= {
>>>      .enable = 0x04,
>>>  };
>>>
>>> +static struct sunxi_sc_nmi_reg_offs sun50i_reg_offs = {
>>> +    .ctrl   = 0x0c,
>>> +    .pend   = 0x10,
>>> +    .enable = 0x40,
>>> +};
>>> +
>>
>>Magic values? Even if no #define is provided, a pointer to the
>>corresponding documentation would be appreciated (assuming
>>documentation
>>exists).
>
> No documents is available for A64 R_INTC.

No code either. In Allwinner's BSP, the interrupts for the PMICs go
through the (closed source) OpenRISC firmware, so there's no driver
for it in the kernel.

The registers line up with the old interrupt controller from the A10,
but it seems only the NMI interrupt is wired up.

ChenYu

>>
>>>  static inline void sunxi_sc_nmi_write(struct irq_chip_generic *gc,
>>u32 off,
>>>                                    u32 val)
>>>  {
>>> @@ -220,3 +226,10 @@ static int __init sun9i_nmi_irq_init(struct
>>device_node *node,
>>>      return sunxi_sc_nmi_irq_init(node, &sun9i_reg_offs);
>>>  }
>>>  IRQCHIP_DECLARE(sun9i_nmi, "allwinner,sun9i-a80-nmi",
>>sun9i_nmi_irq_init);
>>> +
>>> +static int __init sun50i_nmi_irq_init(struct device_node *node,
>>> +                                 struct device_node *parent)
>>> +{
>>> +    return sunxi_sc_nmi_irq_init(node, &sun50i_reg_offs);
>>> +}
>>> +IRQCHIP_DECLARE(sun50i_nmi, "allwinner,sun50i-a64-r-intc",
>>sun50i_nmi_irq_init);
>>>
>>
>>Apart from the above:
>>
>>Acked-by: Marc Zyngier <marc.zyngier@arm.com>
>>
>>Let me know how you want this to be merged.
>
> I think it can just go via IRQ subsystem.
>
>>
>>Thanks,
>>
>>       M.
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe at googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.
