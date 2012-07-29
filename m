From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Mon, 30 Jul 2012 00:13:50 +0800
Subject: [PATCH v2 4/7] ARM: pxa: add devicetree code for irq handling
In-Reply-To: <501551E4.6020806@gmail.com>
References: <1343330187-20049-1-git-send-email-zonque@gmail.com>
 <1343330187-20049-5-git-send-email-zonque@gmail.com>
 <CAN1soZwGp=OKsyAy=iL7ZUvxG+VPBm-d==8Q-AiPqNUMoiPz-w@mail.gmail.com>
 <5013B750.6060608@gmail.com>
 <CAN1soZxgw-pu3OQ357Be9Nuk_Ln7B9EjkVWeh5gEXB_y6tO7ig@mail.gmail.com>
 <501551E4.6020806@gmail.com>
Message-ID: <CAN1soZxiBdkdrBfgxmLwY5EgXyAGr0=FCCGq5VP=PYT_LGA+Aw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 29, 2012 at 11:08 PM, Daniel Mack <zonque@gmail.com> wrote:
> Hi Haojian,
>
> On 28.07.2012 17:42, Haojian Zhuang wrote:
>> On Sat, Jul 28, 2012 at 5:56 PM, Daniel Mack <zonque@gmail.com> wrote:
>>> On 28.07.2012 09:17, Haojian Zhuang wrote:
>>>> On Fri, Jul 27, 2012 at 3:16 AM, Daniel Mack <zonque@gmail.com> wrote:
>>>>> Properly register on-chip interrupt using the irqdomain logic. The
>>>>> number of interrupts is taken from the devicetree node.
>>>>>
>>>>> Signed-off-by: Daniel Mack <zonque@gmail.com>
>>>>> ---
>>>>>  arch/arm/mach-pxa/irq.c    | 73 ++++++++++++++++++++++++++++++++++++++++++++++
>>>>>  arch/arm/mach-pxa/pxa3xx.c | 17 +++++++++--
>>>>>  2 files changed, 88 insertions(+), 2 deletions(-)
>>>>>
>>>>> +#ifdef CONFIG_OF
>>>>> +static struct irq_domain *pxa_irq_domain;
>>>>> +
>>>>> +static int pxa_irq_map(struct irq_domain *h, unsigned int virq,
>>>>> +                      irq_hw_number_t hw)
>>>>> +{
>>>>> +       int irq, i = hw % 32;
>>>>> +       void __iomem *base = irq_base(hw / 32);
>>>>> +
>>>>> +       /* initialize interrupt priority */
>>>>> +       if (cpu_has_ipr())
>>>>> +               __raw_writel(i | IPR_VALID, IRQ_BASE + IPR(i));
>>>> Since we have DT support at here. Could we use property for interrupt priority?
>>>
>>> Not sure what you mean here. Can you elaborate? I couldn't find any
>>> reference to IRQ priorities in other platforms either.
>>>
>>> Maybe we can also add that in a separate patch, which would also help in
>>> tracking possible regressions du to such a change?
>>>
>> cpu_has_ipr() returns true if CPU isn't PXA25x.
>> My point is that we can avoid to use cpu_is_xxx() while DT is used. We only need
>> to append a property "marvell,intc-priority" is DTS. So the code could
>> be changed
>> in below.
>> if (of_find_property(np, "marvell,intc-priority", NULL))
>>            __raw_writel(i | IPR_VALID, IRQ_BASE + IPR(i));
>>
>
> Please see the attached patch. Does that look better to you? I removed
> the cpu_has_ipr() inline function and made it a variable that is used
> and initalized from both the DT and the legacy code.
>
>
> Daniel
>

Don't forget to append this property into .dtsi file. Only PXA25x don't support
this property.

Regards
Haojian
