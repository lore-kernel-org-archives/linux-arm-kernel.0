From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Tue, 20 May 2014 11:24:08 +0800
Subject: [PATCH v6 03/15] irq: gic: support hip04 gic
In-Reply-To: <53748A2B.9050304@arm.com>
References: <1399795571-17231-1-git-send-email-haojian.zhuang@linaro.org>
 <1399795571-17231-4-git-send-email-haojian.zhuang@linaro.org>
 <53748A2B.9050304@arm.com>
Message-ID: <CAD6h2NSksfsOZOG4mjH2M5037mDp9H3s=12adsYAF00YHfpmzw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15 May 2014 17:34, Marc Zyngier <marc.zyngier@arm.com> wrote:
> On 11/05/14 09:05, Haojian Zhuang wrote:
>>
>> +static inline bool gic_is_standard(struct gic_chip_data *gic)
>
> Please loose all of the inlines. The compiler can do this by itself.
>
Since others also agree on inline, I'll keep to use it.

>> -static u8 gic_get_cpumask(struct gic_chip_data *gic)
>> +static u16 gic_get_cpumask(struct gic_chip_data *gic)
>>  {
>>         void __iomem *base = gic_data_dist_base(gic);
>>         u32 mask, i;
>>
>> -       for (i = mask = 0; i < 32; i += 4) {
>> -               mask = readl_relaxed(base + GIC_DIST_TARGET + i);
>> -               mask |= mask >> 16;
>> -               mask |= mask >> 8;
>> +       /*
>> +        * ARM GIC uses 8 registers for interrupt 0-31,
>> +        * HiP04 GIC uses 16 registers for interrupt 0-31.
>> +        */
>> +       for (i = mask = 0; i < 32; i += gic_irqs_per_target_reg(gic)) {
>> +               if (gic_is_standard(gic)) {
>> +                       mask = readl_relaxed(base + GIC_DIST_TARGET + i);
>> +                       mask |= mask >> 16;
>> +                       mask |= mask >> 8;
>> +               } else {                        /* HiP04 GIC */
>> +                       mask = readl_relaxed(base + GIC_DIST_TARGET + i * 2);
>> +                       mask |= mask >> 16;
>> +               }
>
> You have irq_to_target_reg now, and you can rewrite most of this without
> duplication (see my previous review comment).
>

At here, the offset from GIC_DIST_TARGET is got directly.
In irq_to_target_reg(), the parameter is struct irq_data. These two
cases are different.

How could I reuse the irq_to_target_reg() at here?


>> @@ -392,10 +452,17 @@ static void __init gic_dist_init(struct gic_chip_data *gic)
>>          * Set all global interrupts to this CPU only.
>>          */
>>         cpumask = gic_get_cpumask(gic);
>> -       cpumask |= cpumask << 8;
>> +       if (gic_is_standard(gic))
>> +               cpumask |= cpumask << 8;
>>         cpumask |= cpumask << 16;
>> -       for (i = 32; i < gic_irqs; i += 4)
>> -               writel_relaxed(cpumask, base + GIC_DIST_TARGET + i * 4 / 4);
>> +       for (i = 32; i < gic_irqs; i += gic_irqs_per_target_reg(gic)) {
>> +               if (gic_is_standard(gic))
>> +                       writel_relaxed(cpumask,
>> +                                      base + GIC_DIST_TARGET + i / 4 * 4);
>> +               else
>> +                       writel_relaxed(cpumask,
>> +                                      base + GIC_DIST_TARGET + i / 2 * 4);
>> +       }
>
> Same here.
>
Same reason that I can't use irq_to_target_reg(). There's no struct
irq_data at here.

Regards
Haojian
