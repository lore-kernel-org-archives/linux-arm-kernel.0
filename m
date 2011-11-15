From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 15 Nov 2011 14:16:10 +0000
Subject: [PATCH v3] ARM: gic: allow GIC to support non-banked setups
In-Reply-To: <4EC26B02.8000604@gmail.com>
References: <1321359452-22821-1-git-send-email-marc.zyngier@arm.com>
 <4EC26B02.8000604@gmail.com>
Message-ID: <4EC2742A.3050301@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On 15/11/11 13:37, Rob Herring wrote:
> Marc,
> 
> On 11/15/2011 06:17 AM, Marc Zyngier wrote:
>> The GIC support code is heavily using the fact that hardware
>> implementations are exposing banked registers. Unfortunately, it
>> looks like at least one GIC implementation (EXYNOS) offers both
>> the distributor and the CPU interfaces at different addresses,
>> depending on the CPU.
>>
>> This problem is solved by allowing the distributor and CPU interface
>> addresses to be per-cpu variables for the platforms that require it.
>> The EXYNOS code is updated not to mess with the GIC internals while
>> handling interrupts, and struct gic_chip_data is back to being private.
>> The DT binding for the gic is updated to allow an optional "cpu-offset"
>> value, which is used to compute the various base addresses.
>>
>> Finally, a new config option (GIC_NON_BANKED) is used to control this
>> feature, so the overhead is only present on kernels compiled with
>> support for EXYNOS.
>>
>> Tested on Origen (EXYNOS4) and Panda (OMAP4).
>>
>> Cc: Kukjin Kim <kgene.kim@samsung.com>
>> Cc: Rob Herring <robherring2@gmail.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Cc: Thomas Abraham <thomas.abraham@linaro.org>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>> ---
>> This is a minor update on the previous version, simply adding a
>> config option so that normal platforms don't have to pay the
>> price of the get_base() indirection.
>>
>> Any comment is welcome, specially on the DT binding update.
>>
>>  Documentation/devicetree/bindings/arm/gic.txt |    4 +
>>  arch/arm/common/Kconfig                       |    3 +
>>  arch/arm/common/gic.c                         |  133 +++++++++++++++++++++----
>>  arch/arm/include/asm/hardware/gic.h           |   24 ++---
>>  arch/arm/mach-exynos/cpu.c                    |   16 +---
>>  arch/arm/mach-exynos/platsmp.c                |   28 +-----
>>  arch/arm/plat-s5p/Kconfig                     |    1 +
>>  7 files changed, 132 insertions(+), 77 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/gic.txt b/Documentation/devicetree/bindings/arm/gic.txt
>> index 52916b4..9b4b82a 100644
>> --- a/Documentation/devicetree/bindings/arm/gic.txt
>> +++ b/Documentation/devicetree/bindings/arm/gic.txt
>> @@ -42,6 +42,10 @@ Optional
>>  - interrupts : Interrupt source of the parent interrupt controller. Only
>>    present on secondary GICs.
>>
>> +- cpu-offset : per-cpu offset within the distributor and cpu interface
>> +  regions, used when the GIC doesn't have banked registers. The offset is
>> +  cpu-offset * cpu-nr.
>> +
>>  Example:
>>
>>       intc: interrupt-controller at fff11000 {
>> diff --git a/arch/arm/common/Kconfig b/arch/arm/common/Kconfig
>> index 74df9ca..a3beda1 100644
>> --- a/arch/arm/common/Kconfig
>> +++ b/arch/arm/common/Kconfig
>> @@ -2,6 +2,9 @@ config ARM_GIC
>>       select IRQ_DOMAIN
>>       bool
>>
>> +config GIC_NON_BANKED
>> +     bool
>> +
>>  config ARM_VIC
>>       bool
>>
>> diff --git a/arch/arm/common/gic.c b/arch/arm/common/gic.c
>> index 0e6ae47..43cb6f1 100644
>> --- a/arch/arm/common/gic.c
>> +++ b/arch/arm/common/gic.c
>> @@ -43,6 +43,31 @@
>>  #include <asm/mach/irq.h>
>>  #include <asm/hardware/gic.h>
>>
>> +union gic_base {
>> +     void __iomem *common_base;
>> +     void __percpu __iomem **percpu_base;
>> +};
>> +
>> +struct gic_chip_data {
>> +     unsigned int irq_offset;
>> +     union gic_base dist_base;
>> +     union gic_base cpu_base;
>> +#ifdef CONFIG_CPU_PM
>> +     u32 saved_spi_enable[DIV_ROUND_UP(1020, 32)];
>> +     u32 saved_spi_conf[DIV_ROUND_UP(1020, 16)];
>> +     u32 saved_spi_target[DIV_ROUND_UP(1020, 4)];
>> +     u32 __percpu *saved_ppi_enable;
>> +     u32 __percpu *saved_ppi_conf;
>> +#endif
>> +#ifdef CONFIG_IRQ_DOMAIN
> 
> You can remove this ifdef now. It was just to fix msm build when gic.h
> was included, but not enabled.

Right, I'll clean that up.

>> +     struct irq_domain domain;
>> +#endif
>> +     unsigned int gic_irqs;
>> +#ifdef CONFIG_GIC_NON_BANKED
>> +     void __iomem *(*get_base)(union gic_base *);
>> +#endif
>> +};
>> +
>>  static DEFINE_RAW_SPINLOCK(irq_controller_lock);
>>
>>  /* Address of GIC 0 CPU interface */
>> @@ -67,16 +92,48 @@ struct irq_chip gic_arch_extn = {
>>
>>  static struct gic_chip_data gic_data[MAX_GIC_NR] __read_mostly;
>>
>> +#ifdef CONFIG_GIC_NON_BANKED
>> +static void __iomem *gic_get_percpu_base(union gic_base *base)
>> +{
>> +     return *__this_cpu_ptr(base->percpu_base);
>> +}
>> +
>> +static void __iomem *gic_get_common_base(union gic_base *base)
>> +{
>> +     return base->common_base;
>> +}
>> +
>> +static inline void __iomem *gic_data_dist_base(struct gic_chip_data *data)
>> +{
>> +     return data->get_base(&data->dist_base);
>> +}
>> +
>> +static inline void __iomem *gic_data_cpu_base(struct gic_chip_data *data)
>> +{
>> +     return data->get_base(&data->cpu_base);
>> +}
>> +
>> +static inline void gic_set_base_accessor(struct gic_chip_data *data,
>> +                                      void __iomem *(*f)(union gic_base *))
>> +{
>> +     data->get_base = f;
>> +}
>> +#else
>> +#define gic_data_dist_base(d)        ((d)->dist_base.common_base)
>> +#define gic_data_cpu_base(d) ((d)->cpu_base.common_base)
>> +#define gic_set_base_accessor(d,f)
>> +#endif
>> +
>>  static inline void __iomem *gic_dist_base(struct irq_data *d)
>>  {
>>       struct gic_chip_data *gic_data = irq_data_get_irq_chip_data(d);
>> -     return gic_data->dist_base;
>> +     return gic_data_dist_base(gic_data);
>>  }
>>
>>  static inline void __iomem *gic_cpu_base(struct irq_data *d)
>>  {
>>       struct gic_chip_data *gic_data = irq_data_get_irq_chip_data(d);
>> -     return gic_data->cpu_base;
>> +     return gic_data_cpu_base(gic_data);
>>  }
>>
>>  static inline unsigned int gic_irq(struct irq_data *d)
>> @@ -225,7 +282,7 @@ static void gic_handle_cascade_irq(unsigned int irq, struct irq_desc *desc)
>>       chained_irq_enter(chip, desc);
>>
>>       raw_spin_lock(&irq_controller_lock);
>> -     status = readl_relaxed(chip_data->cpu_base + GIC_CPU_INTACK);
>> +     status = readl_relaxed(gic_data_cpu_base(chip_data) + GIC_CPU_INTACK);
>>       raw_spin_unlock(&irq_controller_lock);
>>
>>       gic_irq = (status & 0x3ff);
>> @@ -270,7 +327,7 @@ static void __init gic_dist_init(struct gic_chip_data *gic)
>>       u32 cpumask;
>>       unsigned int gic_irqs = gic->gic_irqs;
>>       struct irq_domain *domain = &gic->domain;
>> -     void __iomem *base = gic->dist_base;
>> +     void __iomem *base = gic_data_dist_base(gic);
>>       u32 cpu = 0;
>>
>>  #ifdef CONFIG_SMP
>> @@ -330,8 +387,8 @@ static void __init gic_dist_init(struct gic_chip_data *gic)
>>
>>  static void __cpuinit gic_cpu_init(struct gic_chip_data *gic)
>>  {
>> -     void __iomem *dist_base = gic->dist_base;
>> -     void __iomem *base = gic->cpu_base;
>> +     void __iomem *dist_base = gic_data_dist_base(gic);
>> +     void __iomem *base = gic_data_cpu_base(gic);
>>       int i;
>>
>>       /*
>> @@ -368,7 +425,7 @@ static void gic_dist_save(unsigned int gic_nr)
>>               BUG();
>>
>>       gic_irqs = gic_data[gic_nr].gic_irqs;
>> -     dist_base = gic_data[gic_nr].dist_base;
>> +     dist_base = gic_data_dist_base(&gic_data[gic_nr]);
>>
>>       if (!dist_base)
>>               return;
>> @@ -403,7 +460,7 @@ static void gic_dist_restore(unsigned int gic_nr)
>>               BUG();
>>
>>       gic_irqs = gic_data[gic_nr].gic_irqs;
>> -     dist_base = gic_data[gic_nr].dist_base;
>> +     dist_base = gic_data_dist_base(&gic_data[gic_nr]);
>>
>>       if (!dist_base)
>>               return;
>> @@ -439,8 +496,8 @@ static void gic_cpu_save(unsigned int gic_nr)
>>       if (gic_nr >= MAX_GIC_NR)
>>               BUG();
>>
>> -     dist_base = gic_data[gic_nr].dist_base;
>> -     cpu_base = gic_data[gic_nr].cpu_base;
>> +     dist_base = gic_data_dist_base(&gic_data[gic_nr]);
>> +     cpu_base = gic_data_cpu_base(&gic_data[gic_nr]);
>>
>>       if (!dist_base || !cpu_base)
>>               return;
>> @@ -465,8 +522,8 @@ static void gic_cpu_restore(unsigned int gic_nr)
>>       if (gic_nr >= MAX_GIC_NR)
>>               BUG();
>>
>> -     dist_base = gic_data[gic_nr].dist_base;
>> -     cpu_base = gic_data[gic_nr].cpu_base;
>> +     dist_base = gic_data_dist_base(&gic_data[gic_nr]);
>> +     cpu_base = gic_data_cpu_base(&gic_data[gic_nr]);
>>
>>       if (!dist_base || !cpu_base)
>>               return;
>> @@ -491,6 +548,11 @@ static int gic_notifier(struct notifier_block *self, unsigned long cmd,  void *v)
>>       int i;
>>
>>       for (i = 0; i < MAX_GIC_NR; i++) {
>> +#ifdef CONFIG_GIC_NON_BANKED
>> +             /* Skip over unused GICs */
>> +             if (!gic_data[i].get_base)
>> +                     continue;
>> +#endif
>>               switch (cmd) {
>>               case CPU_PM_ENTER:
>>                       gic_cpu_save(i);
>> @@ -563,8 +625,9 @@ const struct irq_domain_ops gic_irq_domain_ops = {
>>  #endif
>>  };
>>
>> -void __init gic_init(unsigned int gic_nr, int irq_start,
>> -     void __iomem *dist_base, void __iomem *cpu_base)
>> +void __init gic_init_bases(unsigned int gic_nr, int irq_start,
>> +                        void __iomem *dist_base, void __iomem *cpu_base,
>> +                        u32 percpu_offset)
>>  {
>>       struct gic_chip_data *gic;
>>       struct irq_domain *domain;
>> @@ -574,8 +637,36 @@ void __init gic_init(unsigned int gic_nr, int irq_start,
>>
>>       gic = &gic_data[gic_nr];
>>       domain = &gic->domain;
>> -     gic->dist_base = dist_base;
>> -     gic->cpu_base = cpu_base;
>> +#ifdef CONFIG_GIC_NON_BANKED
>> +     if (percpu_offset) { /* Frankein-GIC without banked registers... */
>> +             unsigned int cpu;
>> +
>> +             gic->dist_base.percpu_base = alloc_percpu(void __iomem *);
>> +             gic->cpu_base.percpu_base = alloc_percpu(void __iomem *);
>> +             if (WARN_ON(!gic->dist_base.percpu_base ||
>> +                         !gic->cpu_base.percpu_base)) {
>> +                     free_percpu(gic->dist_base.percpu_base);
>> +                     free_percpu(gic->cpu_base.percpu_base);
>> +                     return;
>> +             }
>> +
>> +             for_each_possible_cpu(cpu) {
>> +                     unsigned long offset = percpu_offset * cpu_logical_map(cpu);
>> +                     *per_cpu_ptr(gic->dist_base.percpu_base, cpu) = dist_base + offset;
>> +                     *per_cpu_ptr(gic->cpu_base.percpu_base, cpu) = cpu_base + offset;
>> +             }
>> +
>> +             gic_set_base_accessor(gic, gic_get_percpu_base);
>> +     } else
>> +#endif
>> +     {                       /* Normal, sane GIC... */
>> +             WARN(percpu_offset,
>> +                  "GIC_NON_BANKED not enabled, ignoring %08x offset!",
>> +                  percpu_offset);
>> +             gic->dist_base.common_base = dist_base;
>> +             gic->cpu_base.common_base = cpu_base;
>> +             gic_set_base_accessor(gic, gic_get_common_base);
>> +     }
>>
>>       /*
>>        * For primary GICs, skip over SGIs.
>> @@ -593,7 +684,7 @@ void __init gic_init(unsigned int gic_nr, int irq_start,
>>        * Find out how many interrupts are supported.
>>        * The GIC only supports up to 1020 interrupt sources.
>>        */
>> -     gic_irqs = readl_relaxed(dist_base + GIC_DIST_CTR) & 0x1f;
>> +     gic_irqs = readl_relaxed(gic_data_dist_base(gic) + GIC_DIST_CTR) & 0x1f;
>>       gic_irqs = (gic_irqs + 1) * 32;
>>       if (gic_irqs > 1020)
>>               gic_irqs = 1020;
>> @@ -641,7 +732,7 @@ void gic_raise_softirq(const struct cpumask *mask, unsigned int irq)
>>       dsb();
>>
>>       /* this always happens on GIC0 */
>> -     writel_relaxed(map << 16 | irq, gic_data[0].dist_base + GIC_DIST_SOFTINT);
>> +     writel_relaxed(map << 16 | irq, gic_data_dist_base(&gic_data[0]) + GIC_DIST_SOFTINT);
>>  }
>>  #endif
>>
>> @@ -652,6 +743,7 @@ int __init gic_of_init(struct device_node *node, struct device_node *parent)
>>  {
>>       void __iomem *cpu_base;
>>       void __iomem *dist_base;
>> +     u32 percpu_offset;
>>       int irq;
>>       struct irq_domain *domain = &gic_data[gic_cnt].domain;
>>
>> @@ -664,9 +756,12 @@ int __init gic_of_init(struct device_node *node, struct device_node *parent)
>>       cpu_base = of_iomap(node, 1);
>>       WARN(!cpu_base, "unable to map gic cpu registers\n");
>>
>> +     if (of_property_read_u32(node, "cpu-offset", &percpu_offset))
>> +             percpu_offset = 0;
>> +
> 
> What are the chances of not having a simple offset you can index into?

Very slim, I think. It would make the hardware insane. Oh wait... ;-)

> If you add a new property, then you need to add documentation.

I think I added two lines to gic.txt (see first hunk of the patch).

> You need to ioremap the secondary addresses. For that reason, adding to
> the regs property may be simpler.

My idea was to have two big regions (one for the CPU interface, one for
the distributor interface), encompassing the need of all CPUs. In the
Samsung case, it's 64kB per region (only the cpu offset changes between
2 and 4 core versions).

	M.
-- 
Jazz is not dead. It just smells funny...
