From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Thu, 17 Jul 2014 10:01:36 +0100
Subject: [PATCH v8 0/4] arm: KGDB NMI/FIQ support
In-Reply-To: <CAB5oZtAt0ZWJB1FOmzaFphM2Y566U73=U+HniPLTm9c1suVqNg@mail.gmail.com>
References: <1404118391-3850-1-git-send-email-daniel.thompson@linaro.org>	<1404979427-12943-1-git-send-email-daniel.thompson@linaro.org>	<CAB5oZtCk5NwBJF+dBESKGhYabti=EWWtF2jJYK7HdyNHM46nTw@mail.gmail.com>	<53C4F745.3070701@linaro.org>	<CAB5oZtBSZJVqyO8GKdKqh0+3=GDkCyuqrAOQhMRxN0JFBnmZ6w@mail.gmail.com>	<53C54042.2030507@linaro.org>	<CAB5oZtDy=TDz12_6ua_M3g=bQ+zB6cJTH3bUT9oA8snLDRBMTw@mail.gmail.com>	<53C5600C.1080004@linaro.org>
 <CAB5oZtAt0ZWJB1FOmzaFphM2Y566U73=U+HniPLTm9c1suVqNg@mail.gmail.com>
Message-ID: <53C790F0.7050409@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/07/14 18:15, Harro Haan wrote:
>> Anyhow I've put together a new version of my earlier patch that I think
>> will retrigger all interrupts except SGIs (I'll look at SGIs and
>> compatibility with non-Freescale parts only if this improved approach
>> works).
>>
>> Reported-by: Harro Haan <hrhaan@gmail.com>
>> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
>> ---
>>  drivers/irqchip/irq-gic.c | 31 ++++++++++++++++++++++++++++++-
>>  1 file changed, 30 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
>> index 73ae896..88f92e6 100644
>> --- a/drivers/irqchip/irq-gic.c
>> +++ b/drivers/irqchip/irq-gic.c
>> @@ -303,6 +303,33 @@ static int gic_set_wake(struct irq_data *d,
>> unsigned int on)
>>  #define gic_set_wake   NULL
>>  #endif
>>
>> +/* This is a software emulation of the Aliased Interrupt Acknowledge
>> Register
>> + * (GIC_AIAR) found in GICv2+.
>> + */
>> +static u32 gic_handle_spurious_group_0(struct gic_chip_data *gic, u32
>> irqstat)
>> +{
>> +       u32 irqnr = irqstat & GICC_IAR_INT_ID_MASK;
>> +       void __iomem *dist_base = gic_data_dist_base(gic);
>> +       u32 offset, mask;
>> +
>> +       if (!gic_data_fiq_enable(gic) || irqnr >= 1021)
>> +               return irqnr;
>> +
>> +       offset = irqnr / 32 * 4;
>> +       mask = 1 << (irqnr % 32);
>> +       if (readl_relaxed(dist_base + GIC_DIST_IGROUP + offset) & mask)
>> +               return irqnr;
>> +
>> +       /* this interrupt must be taken as a FIQ so put it back into the
>> +        * pending state and end our own servicing of it.
>> +        */
>> +       writel_relaxed(mask, dist_base + GIC_DIST_PENDING_SET + offset);
>> +       readl_relaxed(dist_base + GIC_DIST_PENDING_SET + offset);
>> +       writel_relaxed(irqstat, gic_data_cpu_base(gic) + GIC_CPU_EOI);
>> +
>> +       return 1023;
>> +}
>> +
>>  static void __exception_irq_entry gic_handle_irq(struct pt_regs *regs)
>>  {
>>         u32 irqstat, irqnr;
>> @@ -310,8 +337,10 @@ static void __exception_irq_entry
>> gic_handle_irq(struct pt_regs *regs)
>>         void __iomem *cpu_base = gic_data_cpu_base(gic);
>>
>>         do {
>> +               local_fiq_disable();
>>                 irqstat = readl_relaxed(cpu_base + GIC_CPU_INTACK);
>> -               irqnr = irqstat & GICC_IAR_INT_ID_MASK;
>> +               irqnr = gic_handle_spurious_group_0(gic, irqstat);
>> +               local_fiq_enable();
>>
>>                 if (likely(irqnr > 15 && irqnr < 1021)) {
>>                         irqnr = irq_find_mapping(gic->domain, irqnr);
>> --
>> 1.9.3
>>
>>
>>
> 
> I just tested the above code. This approach also works as expected for
> edge sensitive interrupts.

Awesome [and also a personal relief to get it right this time around ;-) ].

So we have two completely different confirmed-as-working workarounds!
