From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 20 May 2014 10:42:01 +0100
Subject: [PATCH v6 03/15] irq: gic: support hip04 gic
In-Reply-To: <CAD6h2NSBvvL8+LHBF9o9BooH6eErSwRx25Hg0HXxXw8dn-tMBw@mail.gmail.com>
 (Haojian Zhuang's message of "Tue, 20 May 2014 10:35:42 +0100")
References: <1399795571-17231-1-git-send-email-haojian.zhuang@linaro.org>
 <1399795571-17231-4-git-send-email-haojian.zhuang@linaro.org>
 <53748A2B.9050304@arm.com>
 <CAD6h2NSksfsOZOG4mjH2M5037mDp9H3s=12adsYAF00YHfpmzw@mail.gmail.com>
 <871tvo4ybs.fsf@approximate.cambridge.arm.com>
 <CAD6h2NSBvvL8+LHBF9o9BooH6eErSwRx25Hg0HXxXw8dn-tMBw@mail.gmail.com>
Message-ID: <87iop03hxy.fsf@approximate.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 20 2014 at 10:35:42 am BST, Haojian Zhuang <haojian.zhuang@linaro.org> wrote:
> On 20 May 2014 17:02, Marc Zyngier <marc.zyngier@arm.com> wrote:
>> On Tue, May 20 2014 at 4:24:08 am BST, Haojian Zhuang
>> <haojian.zhuang@linaro.org> wrote:
>>> On 15 May 2014 17:34, Marc Zyngier <marc.zyngier@arm.com> wrote:
>>>> On 11/05/14 09:05, Haojian Zhuang wrote:
>>>>>
>>>>> +static inline bool gic_is_standard(struct gic_chip_data *gic)
>>>>
>>>> Please loose all of the inlines. The compiler can do this by itself.
>>>>
>>> Since others also agree on inline, I'll keep to use it.
>>>
>>>>> -static u8 gic_get_cpumask(struct gic_chip_data *gic)
>>>>> +static u16 gic_get_cpumask(struct gic_chip_data *gic)
>>>>>  {
>>>>>         void __iomem *base = gic_data_dist_base(gic);
>>>>>         u32 mask, i;
>>>>>
>>>>> -       for (i = mask = 0; i < 32; i += 4) {
>>>>> -               mask = readl_relaxed(base + GIC_DIST_TARGET + i);
>>>>> -               mask |= mask >> 16;
>>>>> -               mask |= mask >> 8;
>>>>> +       /*
>>>>> +        * ARM GIC uses 8 registers for interrupt 0-31,
>>>>> +        * HiP04 GIC uses 16 registers for interrupt 0-31.
>>>>> +        */
>>>>> +       for (i = mask = 0; i < 32; i += gic_irqs_per_target_reg(gic)) {
>>>>> +               if (gic_is_standard(gic)) {
>>>>> +                       mask = readl_relaxed(base + GIC_DIST_TARGET + i);
>>>>> +                       mask |= mask >> 16;
>>>>> +                       mask |= mask >> 8;
>>>>> +               } else {                        /* HiP04 GIC */
>>>>> +                       mask = readl_relaxed(base + GIC_DIST_TARGET + i * 2);
>>>>> +                       mask |= mask >> 16;
>>>>> +               }
>>>>
>>>> You have irq_to_target_reg now, and you can rewrite most of this without
>>>> duplication (see my previous review comment).
>>>>
>>>
>>> At here, the offset from GIC_DIST_TARGET is got directly.
>>> In irq_to_target_reg(), the parameter is struct irq_data. These two
>>> cases are different.
>>>
>>> How could I reuse the irq_to_target_reg() at here?
>>
>> By using your imagination, and redefining irq_to_target_reg to this:
>>
>> static inline u32 irq_to_target_reg(struct gic_chip_data *gic, int irq)
>> {
>>        if (!gic_is_standard(gic))
>>                i *= 2;
>>        irq &= ~3U;
>>        return (i + GIC_DIST_TARGET);
>> }
>>
>> You could then try modifying the only existing caller, and then rewrite
>> the above hunk as such:
>>
>>        for (i = mask = 0; i < 32; i += gic_irqs_per_target_reg(gic)) {
>>                mask = readl_relaxed(base + irq_to_target_reg(gic, i));
>>                mask |= mask >> 16;
>>                if (gic_is_standard(gic))
>>                        mask |= mask >> 8;
>>        }
>>
>
> But why should I name it as irq_to_target_reg()? There's nothing related
> to irq at here.

What do you think the second parameter is? If the name troubles you,
feel free to suggest one you find more suitable.

> So I'll append a new function to handle it.

There is no need for that.

	M.
-- 
Jazz is not dead. It just smells funny.
