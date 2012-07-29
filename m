From: zonque@gmail.com (Daniel Mack)
Date: Sun, 29 Jul 2012 17:08:20 +0200
Subject: [PATCH v2 4/7] ARM: pxa: add devicetree code for irq handling
In-Reply-To: <CAN1soZxgw-pu3OQ357Be9Nuk_Ln7B9EjkVWeh5gEXB_y6tO7ig@mail.gmail.com>
References: <1343330187-20049-1-git-send-email-zonque@gmail.com>
 <1343330187-20049-5-git-send-email-zonque@gmail.com>
 <CAN1soZwGp=OKsyAy=iL7ZUvxG+VPBm-d==8Q-AiPqNUMoiPz-w@mail.gmail.com>
 <5013B750.6060608@gmail.com>
 <CAN1soZxgw-pu3OQ357Be9Nuk_Ln7B9EjkVWeh5gEXB_y6tO7ig@mail.gmail.com>
Message-ID: <501551E4.6020806@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Haojian,

On 28.07.2012 17:42, Haojian Zhuang wrote:
> On Sat, Jul 28, 2012 at 5:56 PM, Daniel Mack <zonque@gmail.com> wrote:
>> On 28.07.2012 09:17, Haojian Zhuang wrote:
>>> On Fri, Jul 27, 2012 at 3:16 AM, Daniel Mack <zonque@gmail.com> wrote:
>>>> Properly register on-chip interrupt using the irqdomain logic. The
>>>> number of interrupts is taken from the devicetree node.
>>>>
>>>> Signed-off-by: Daniel Mack <zonque@gmail.com>
>>>> ---
>>>>  arch/arm/mach-pxa/irq.c    | 73 ++++++++++++++++++++++++++++++++++++++++++++++
>>>>  arch/arm/mach-pxa/pxa3xx.c | 17 +++++++++--
>>>>  2 files changed, 88 insertions(+), 2 deletions(-)
>>>>
>>>> +#ifdef CONFIG_OF
>>>> +static struct irq_domain *pxa_irq_domain;
>>>> +
>>>> +static int pxa_irq_map(struct irq_domain *h, unsigned int virq,
>>>> +                      irq_hw_number_t hw)
>>>> +{
>>>> +       int irq, i = hw % 32;
>>>> +       void __iomem *base = irq_base(hw / 32);
>>>> +
>>>> +       /* initialize interrupt priority */
>>>> +       if (cpu_has_ipr())
>>>> +               __raw_writel(i | IPR_VALID, IRQ_BASE + IPR(i));
>>> Since we have DT support at here. Could we use property for interrupt priority?
>>
>> Not sure what you mean here. Can you elaborate? I couldn't find any
>> reference to IRQ priorities in other platforms either.
>>
>> Maybe we can also add that in a separate patch, which would also help in
>> tracking possible regressions du to such a change?
>>
> cpu_has_ipr() returns true if CPU isn't PXA25x.
> My point is that we can avoid to use cpu_is_xxx() while DT is used. We only need
> to append a property "marvell,intc-priority" is DTS. So the code could
> be changed
> in below.
> if (of_find_property(np, "marvell,intc-priority", NULL))
>            __raw_writel(i | IPR_VALID, IRQ_BASE + IPR(i));
> 
>>>> +       irq = PXA_IRQ(virq);
>>> #ifdef CONFIG_PXA_HAVE_ISA_IRQS
>>> #define PXA_ISA_IRQ(x)  (x)
>>> #define PXA_ISA_IRQ_NUM (16)
>>> #else
>>> #define PXA_ISA_IRQ_NUM (0)
>>> #endif
>>>
>>> Could we avoid to use PXA_IRQ() at here? We can make use of
>>> NR_IRQS_LEGACY that is 16. Since you already use irq_alloc_descs()
>>> to allocate irqs that virtual irq number starts from 16. So you needn't
>>> use PXA_IRQ() any more.
>>
>> Ok, I changed this. Note that there's still need to subtract
>> NR_IRQS_LEGACY from the virq that is passed in to the .map function,
>> because early_irq_init() in kernel/irq/irqdesc.c will pre-allocate the
>> IRQs the platform claims to have natively, which defaults to 16 on PXA,
>> unless the machine descriptor sets nr_irqs, which it doesn't in case of DT.
>>
> You needn't subtract NR_IRQS_LEGACY. PXA25x hwirq starts from
> 16 & PXA27x/PXA3xx hwirq starts from 0. While DT is used, irq_alloc_descs()
> allocates virq from NR_IRQS_LEGACY. For PXA25x, there's exactly match.
> For PXA27x/PXA3xx, there's a little different. But it doesn't matter. We needn't
> force virq starting from 0 on PXA27x/PXA3xx. The first virq starts from 16 is
> also OK.

Ok, now I got you. By simply ignoring the virq passed in and only taking
into account the hw irq, this is of course possible.

Please see the attached patch. Does that look better to you? I removed
the cpu_has_ipr() inline function and made it a variable that is used
and initalized from both the DT and the legacy code.


Daniel

-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-ARM-pxa-add-devicetree-code-for-irq-handling.patch
Type: text/x-patch
Size: 5704 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120729/89129869/attachment.bin>
