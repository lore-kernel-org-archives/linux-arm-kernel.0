From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Fri, 25 Apr 2014 10:52:46 +0800
Subject: [PATCH v3 05/13] irq: gic: support hip04 gic
In-Reply-To: <87tx9lvdxl.fsf@approximate.cambridge.arm.com>
References: <1397801156-25682-1-git-send-email-haojian.zhuang@linaro.org>
 <1397801156-25682-6-git-send-email-haojian.zhuang@linaro.org>
 <87tx9lvdxl.fsf@approximate.cambridge.arm.com>
Message-ID: <CAD6h2NQFwveFN-K9XAN-9vwWycT6Oa0usaN7j2pdaBRN9V0akQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22 April 2014 18:47, Marc Zyngier <marc.zyngier@arm.com> wrote:
> Hi Haojian,
>
> On Fri, Apr 18 2014 at  7:05:48 am BST, Haojian Zhuang <haojian.zhuang@linaro.org> wrote:
>> There's a little difference between ARM GIC and HiP04 GIC.
>>
>> * HiP04 GIC could support 16 cores at most, and ARM GIC could support
>> 8 cores at most. So the difination on GIC_DIST_SGIR,
>                           definitions of
>> GIC_DIST_SGI_PENDING_SET, GIC_DIST_SGI_PENDING_CLEAR
>> & GIC_DIST_TARGET registers are different since CPU interfaces are
>> increased from 8-bit to 16-bit.
>>
>> * HiP04 GIC could support 510 interrupts at most, and ARM GIC could
>> support 1020 interrupts at most.
>>
>> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
>> ---
>>  drivers/irqchip/irq-gic.c | 153 +++++++++++++++++++++++++++++++++-------------
>>  1 file changed, 109 insertions(+), 44 deletions(-)
>>
>> diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
>> index 8fd27bf..18f3d56 100644
>> --- a/drivers/irqchip/irq-gic.c
>> +++ b/drivers/irqchip/irq-gic.c
>> @@ -68,6 +68,8 @@ struct gic_chip_data {
>>  #ifdef CONFIG_GIC_NON_BANKED
>>         void __iomem *(*get_base)(union gic_base *);
>>  #endif
>> +       u32 nr_cpu_if;
>> +       u32 nr_if_per_reg;
>
> Which register? Surely you can compute that at runtime.

Yes, I can compute it at runtime. I'll change it.
>
>>  };
>>
>>  static DEFINE_RAW_SPINLOCK(irq_controller_lock);
>> @@ -76,9 +78,14 @@ static DEFINE_RAW_SPINLOCK(irq_controller_lock);
>>   * The GIC mapping of CPU interfaces does not necessarily match
>>   * the logical CPU numbering.  Let's use a mapping as returned
>>   * by the GIC itself.
>> + *
>> + * Hisilicon HiP04 extends the number of CPU interface from 8 to 16.
>>   */
>> -#define NR_GIC_CPU_IF 8
>> -static u8 gic_cpu_map[NR_GIC_CPU_IF] __read_mostly;
>> +#define NR_GIC_CPU_IF  16
>> +static u16 gic_cpu_map[NR_GIC_CPU_IF] __read_mostly;
>> +
>> +/* GIC register is always 32-bit long whatever it's in ARM64 or ARM32 */
>> +#define GIC_REG_BITS   32
>
> What doesn this buy us? I'm not sure we gain much from it.

OK. I'll remove it.
>
>>  /*
>>   * Supported arch specific GIC irq extension.
>> @@ -242,19 +249,50 @@ static int gic_retrigger(struct irq_data *d)
>>  }
>>
>>  #ifdef CONFIG_SMP
>> +static inline u32 irq_to_core_offset(u32 i, u32 nr_cpu_if)
>> +{
>
> Make this function take an irq_data pointer, and use the accessor to
> find out about the number of CPU interfaces.

Oh. No problem.
>
>> +       if (nr_cpu_if == 8) {
>> +               /* ARM GIC, i / 4 * 4 */
>> +               return ((i >> 2) << 2);
>
> Why does the comment has one expression and the code another? I know
> they give the same result, but this is pretty useless.
>
Yes, I'll do.

>
>> +       u32 mask;
>> +       /* ARM GIC, nr_cpu_if == 8; HiP04 GIC, nr_cpu_if == 16 */
>> +       mask = (1 << nr_cpu_if) - 1;
>> +       return (mask << irq_to_core_shift(i, nr_cpu_if));
>> +}
>> +
>>  static int gic_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
>>                             bool force)
>>  {
>> -       void __iomem *reg = gic_dist_base(d) + GIC_DIST_TARGET + (gic_irq(d) & ~3);
>> -       unsigned int shift = (gic_irq(d) % 4) * 8;
>> +       void __iomem *reg;
>> +       unsigned int i = gic_irq(d);
>> +       unsigned int shift = irq_to_core_shift(i, gic_data[0].nr_cpu_if);
>>         unsigned int cpu = cpumask_any_and(mask_val, cpu_online_mask);
>>         u32 val, mask, bit;
>> -
>> -       if (cpu >= NR_GIC_CPU_IF || cpu >= nr_cpu_ids)
>> +       if (cpu >= gic_data[0].nr_cpu_if || cpu >= nr_cpu_ids)
>>                 return -EINVAL;
>>
>> +       reg = gic_dist_base(d) + GIC_DIST_TARGET +
>> +             irq_to_core_offset(i, gic_data[0].nr_cpu_if);
>> +
>>         raw_spin_lock(&irq_controller_lock);
>> -       mask = 0xff << shift;
>> +       mask = irq_to_core_mask(i, gic_data[0].nr_cpu_if);
>>         bit = gic_cpu_map[cpu] << shift;
>>         val = readl_relaxed(reg) & ~mask;
>>         writel_relaxed(val | bit, reg);
>> @@ -354,15 +392,16 @@ void __init gic_cascade_irq(unsigned int gic_nr, unsigned int irq)
>>         irq_set_chained_handler(irq, gic_handle_cascade_irq);
>>  }
>>
>> -static u8 gic_get_cpumask(struct gic_chip_data *gic)
>> +static u16 gic_get_cpumask(struct gic_chip_data *gic)
>>  {
>>         void __iomem *base = gic_data_dist_base(gic);
>> -       u32 mask, i;
>> +       u32 mask, i, j, nr_if = gic->nr_if_per_reg;
>>
>> -       for (i = mask = 0; i < 32; i += 4) {
>> -               mask = readl_relaxed(base + GIC_DIST_TARGET + i);
>> -               mask |= mask >> 16;
>> -               mask |= mask >> 8;
>> +       /* get the number of CPU fields in GIC_DIST_TARGET register */
>> +       for (i = mask = 0; i < DIV_ROUND_UP(32, nr_if); i++) {
>> +               mask = readl_relaxed(base + GIC_DIST_TARGET + i * 4);
>> +               for (j = GIC_REG_BITS >> 1; j >= gic->nr_cpu_if; j >>= 1)
>> +                       mask |= mask >> j;
>>                 if (mask)
>>                         break;
>>         }
>
> This looks incredibly convoluted. How about something like the code
> below, which is way simpler and doesn't involve changing so much stuff
> (completely untested, of course):
>
> int nr_target_regs = 32 / (gic->nr_cpu_if == 8 ? 4 : 2);
> for (i = mask = 0; i < nr_target_regs; i++) {
>         mask = readl_relaxed(base + GIC_DIST_TARGET + i * 4);
>         mask |= mask >> 16;
>         if (gic->nr_cpu_if == 8)
>                 mask |= mask >> 8;
>
>         if (mask)
>                 break;
> }
I'll change it.

>
>> @@ -370,12 +409,16 @@ static u8 gic_get_cpumask(struct gic_chip_data *gic)
>>         if (!mask)
>>                 pr_crit("GIC CPU mask not found - kernel will fail to boot.\n");
>>
>> +       /* ARM GIC needs 8-bit cpu mask, HiP04 GIC needs 16-bit cpu mask. */
>> +       if (gic->nr_cpu_if == 8)
>> +               mask &= 0xff;
>> +
>>         return mask;
>>  }
>>
>>  static void __init gic_dist_init(struct gic_chip_data *gic)
>>  {
>> -       unsigned int i;
>> +       unsigned int i, nr_if = gic->nr_if_per_reg;
>>         u32 cpumask;
>>         unsigned int gic_irqs = gic->gic_irqs;
>>         void __iomem *base = gic_data_dist_base(gic);
>> @@ -392,23 +435,25 @@ static void __init gic_dist_init(struct gic_chip_data *gic)
>>          * Set all global interrupts to this CPU only.
>>          */
>>         cpumask = gic_get_cpumask(gic);
>> -       cpumask |= cpumask << 8;
>> -       cpumask |= cpumask << 16;
>> -       for (i = 32; i < gic_irqs; i += 4)
>> -               writel_relaxed(cpumask, base + GIC_DIST_TARGET + i * 4 / 4);
>> +       for (i = gic->nr_cpu_if; i < GIC_REG_BITS; i <<= 1)
>> +               cpumask |= cpumask << i;
>
> Really, you should stop adding bit arithmetics all over the
> place. You're just making a simple problem way too complex. What is
> wrong with:
>
>         if (gic->nr_cpu_if == 8)
>                 cpumask |= cpumask << 8;
>
> ?
I'll use simple way to express it.

>
>> +       for (i = 32 / nr_if; i < DIV_ROUND_UP(gic_irqs, nr_if); i++)
>> +               writel_relaxed(cpumask, base + GIC_DIST_TARGET + i * 4);
>
> Why do you need to DIV_ROUND_UP? GIC interrupts are always a multiple of
> 32.
>
OK. I'll remove it.

>>         /*
>>          * Set priority on all global interrupts.
>>          */
>> -       for (i = 32; i < gic_irqs; i += 4)
>> -               writel_relaxed(0xa0a0a0a0, base + GIC_DIST_PRI + i * 4 / 4);
>> +       for (i = 32 / nr_if; i < DIV_ROUND_UP(gic_irqs, 4); i++)
>> +               writel_relaxed(0xa0a0a0a0, base + GIC_DIST_PRI + i * 4);
>>
>>         /*
>>          * Disable all interrupts.  Leave the PPI and SGIs alone
>>          * as these enables are banked registers.
>>          */
>> -       for (i = 32; i < gic_irqs; i += 32)
>> -               writel_relaxed(0xffffffff, base + GIC_DIST_ENABLE_CLEAR + i * 4 / 32);
>> +       i = 32 / GIC_REG_BITS;
>
> I predict this value to be the grand total of one.
>
>> +       for (; i < DIV_ROUND_UP(gic_irqs, GIC_REG_BITS); i++)
>> +               writel_relaxed(0xffffffff,
>> +                              base + GIC_DIST_ENABLE_CLEAR + i * 4);
>>
>>         writel_relaxed(1, base + GIC_DIST_CTRL);
>>  }
>> @@ -423,7 +468,7 @@ static void gic_cpu_init(struct gic_chip_data *gic)
>>         /*
>>          * Get what the GIC says our CPU mask is.
>>          */
>> -       BUG_ON(cpu >= NR_GIC_CPU_IF);
>> +       BUG_ON(cpu >= gic->nr_cpu_if);
>>         cpu_mask = gic_get_cpumask(gic);
>>         gic_cpu_map[cpu] = cpu_mask;
>>
>> @@ -431,7 +476,7 @@ static void gic_cpu_init(struct gic_chip_data *gic)
>>          * Clear our mask from the other map entries in case they're
>>          * still undefined.
>>          */
>> -       for (i = 0; i < NR_GIC_CPU_IF; i++)
>> +       for (i = 0; i < gic->nr_cpu_if; i++)
>>                 if (i != cpu)
>>                         gic_cpu_map[i] &= ~cpu_mask;
>>
>> @@ -445,8 +490,8 @@ static void gic_cpu_init(struct gic_chip_data *gic)
>>         /*
>>          * Set priority on PPI and SGI interrupts
>>          */
>> -       for (i = 0; i < 32; i += 4)
>> -               writel_relaxed(0xa0a0a0a0, dist_base + GIC_DIST_PRI + i * 4 / 4);
>> +       for (i = 0; i < DIV_ROUND_UP(32, 4); i++)
>> +               writel_relaxed(0xa0a0a0a0, dist_base + GIC_DIST_PRI + i * 4);
>>
>>         writel_relaxed(0xf0, base + GIC_CPU_PRIMASK);
>>         writel_relaxed(1, base + GIC_CPU_CTRL);
>> @@ -467,7 +512,7 @@ void gic_cpu_if_down(void)
>>   */
>>  static void gic_dist_save(unsigned int gic_nr)
>>  {
>> -       unsigned int gic_irqs;
>> +       unsigned int gic_irqs, nr_if = gic_data[gic_nr].nr_if_per_reg;
>>         void __iomem *dist_base;
>>         int i;
>>
>> @@ -484,7 +529,7 @@ static void gic_dist_save(unsigned int gic_nr)
>>                 gic_data[gic_nr].saved_spi_conf[i] =
>>                         readl_relaxed(dist_base + GIC_DIST_CONFIG + i * 4);
>>
>> -       for (i = 0; i < DIV_ROUND_UP(gic_irqs, 4); i++)
>> +       for (i = 0; i < DIV_ROUND_UP(gic_irqs, nr_if); i++)
>>                 gic_data[gic_nr].saved_spi_target[i] =
>>                         readl_relaxed(dist_base + GIC_DIST_TARGET + i * 4);
>>
>> @@ -502,7 +547,7 @@ static void gic_dist_save(unsigned int gic_nr)
>>   */
>>  static void gic_dist_restore(unsigned int gic_nr)
>>  {
>> -       unsigned int gic_irqs;
>> +       unsigned int gic_irqs, nr_if = gic_data[gic_nr].nr_if_per_reg;
>>         unsigned int i;
>>         void __iomem *dist_base;
>>
>> @@ -525,7 +570,7 @@ static void gic_dist_restore(unsigned int gic_nr)
>>                 writel_relaxed(0xa0a0a0a0,
>>                         dist_base + GIC_DIST_PRI + i * 4);
>>
>> -       for (i = 0; i < DIV_ROUND_UP(gic_irqs, 4); i++)
>> +       for (i = 0; i < DIV_ROUND_UP(gic_irqs, nr_if); i++)
>>                 writel_relaxed(gic_data[gic_nr].saved_spi_target[i],
>>                         dist_base + GIC_DIST_TARGET + i * 4);
>>
>> @@ -665,9 +710,15 @@ static void gic_raise_softirq(const struct cpumask *mask, unsigned int irq)
>>          */
>>         dmb(ishst);
>>
>> -       /* this always happens on GIC0 */
>> -       writel_relaxed(map << 16 | irq, gic_data_dist_base(&gic_data[0]) + GIC_DIST_SOFTINT);
>> -
>> +       /*
>> +        * CPUTargetList -- bit[23:16] in GIC_DIST_SOFTINT in ARM GIC.
>> +        *                  bit[23:8] in HIP04_GIC_DIST_SOFTINT in HiP04 GIC.
>> +        * NSATT -- bit[15] in GIC_DIST_SOFTINT in ARM GIC.
>> +        *          bit[7] in HIP04_GIC_DIST_SOFTINT in HiP04 GIC.
>> +        * this always happens on GIC0
>> +        */
>> +       writel_relaxed(map << (16 + 8 - gic_data[0].nr_cpu_if) | irq,
>> +                      gic_data_dist_base(&gic_data[0]) + GIC_DIST_SOFTINT);
>
> Make this two cases. This bit arithmetic makes it unreadable. Also, why
> does the comment makes the GIC_DIST_SOFTINT/HIP04_GIC_DIST_SOFTINT
> distinction, while the code only refers to GIC_DIST_SOFTINT?

OK. I'll make it simpler.

>
>>         raw_spin_unlock_irqrestore(&irq_controller_lock, flags);
>>  }
>>  #endif
>> @@ -681,10 +732,11 @@ static void gic_raise_softirq(const struct cpumask *mask, unsigned int irq)
>>   */
>>  void gic_send_sgi(unsigned int cpu_id, unsigned int irq)
>>  {
>> -       BUG_ON(cpu_id >= NR_GIC_CPU_IF);
>> +       BUG_ON(cpu_id >= gic_data[0].nr_cpu_if);
>>         cpu_id = 1 << cpu_id;
>>         /* this always happens on GIC0 */
>> -       writel_relaxed((cpu_id << 16) | irq, gic_data_dist_base(&gic_data[0]) + GIC_DIST_SOFTINT);
>> +       writel_relaxed((cpu_id << (16 + 8 - gic_data[0].nr_cpu_if)) | irq,
>> +                      gic_data_dist_base(&gic_data[0]) + GIC_DIST_SOFTINT);
>
> Same here.
>
>>  }
>>
>>  /*
>> @@ -700,7 +752,7 @@ int gic_get_cpu_id(unsigned int cpu)
>>  {
>>         unsigned int cpu_bit;
>>
>> -       if (cpu >= NR_GIC_CPU_IF)
>> +       if (cpu >= gic_data[0].nr_cpu_if)
>>                 return -1;
>>         cpu_bit = gic_cpu_map[cpu];
>>         if (cpu_bit & (cpu_bit - 1))
>> @@ -771,10 +823,10 @@ void gic_migrate_target(unsigned int new_cpu_id)
>>          */
>>         for (i = 0; i < 16; i += 4) {
>>                 int j;
>> -               val = readl_relaxed(dist_base + GIC_DIST_SGI_PENDING_SET + i);
>> +               val = readl_relaxed(dist_base + GIC_DIST_PENDING_SET + i);
>>                 if (!val)
>>                         continue;
>> -               writel_relaxed(val, dist_base + GIC_DIST_SGI_PENDING_CLEAR + i);
>> +               writel_relaxed(val, dist_base + GIC_DIST_PENDING_CLEAR + i);
>
> What? Hell no. This is the SGI sources we're dealing with. And I'd
> expect your implementation to be quite different.
>
>>                 for (j = i; j < i + 4; j++) {
>>                         if (val & 0xff)
>>                                 writel_relaxed((1 << (new_cpu_id + 16)) | j,
>> @@ -931,7 +983,7 @@ void __init gic_init_bases(unsigned int gic_nr, int irq_start,
>>         irq_hw_number_t hwirq_base;
>>         struct gic_chip_data *gic;
>>         int gic_irqs, irq_base, i;
>> -       int nr_routable_irqs;
>> +       int nr_routable_irqs, max_nr_irq;
>>
>>         BUG_ON(gic_nr >= MAX_GIC_NR);
>>
>> @@ -967,12 +1019,23 @@ void __init gic_init_bases(unsigned int gic_nr, int irq_start,
>>                 gic_set_base_accessor(gic, gic_get_common_base);
>>         }
>>
>> +       if (of_device_is_compatible(node, "hisilicon,hip04-gic")) {
>> +               /* HiP04 GIC supports 16 CPUs at most */
>> +               gic->nr_cpu_if = 16;
>> +               max_nr_irq = 510;
>> +       } else {
>> +               /* ARM/Qualcomm GIC supports 8 CPUs at most */
>> +               gic->nr_cpu_if = 8;
>> +               max_nr_irq = 1020;
>> +       }
>> +       gic->nr_if_per_reg = GIC_REG_BITS / gic->nr_cpu_if;
>> +
>
> Loose this last line, and do the explicit computation. where needed. I
> don't this this adds anything.

OK.
>
>>         /*
>>          * Initialize the CPU interface map to all CPUs.
>>          * It will be refined as each CPU probes its ID.
>>          */
>> -       for (i = 0; i < NR_GIC_CPU_IF; i++)
>> -               gic_cpu_map[i] = 0xff;
>> +       for (i = 0; i < gic->nr_cpu_if; i++)
>> +               gic_cpu_map[i] = (1 << gic->nr_cpu_if) - 1;
>>
>>         /*
>>          * For primary GICs, skip over SGIs.
>> @@ -988,12 +1051,13 @@ void __init gic_init_bases(unsigned int gic_nr, int irq_start,
>>
>>         /*
>>          * Find out how many interrupts are supported.
>> -        * The GIC only supports up to 1020 interrupt sources.
>> +        * The ARM/Qualcomm GIC only supports up to 1020 interrupt sources.
>> +        * The HiP04 GIC only supports up to 510 interrupt sources.
>>          */
>>         gic_irqs = readl_relaxed(gic_data_dist_base(gic) + GIC_DIST_CTR) & 0x1f;
>>         gic_irqs = (gic_irqs + 1) * 32;
>> -       if (gic_irqs > 1020)
>> -               gic_irqs = 1020;
>> +       if (gic_irqs > max_nr_irq)
>> +               gic_irqs = max_nr_irq;
>>         gic->gic_irqs = gic_irqs;
>>
>>         gic_irqs -= hwirq_base; /* calculate # of irqs to allocate */
>> @@ -1069,6 +1133,7 @@ gic_of_init(struct device_node *node, struct device_node *parent)
>>  }
>>  IRQCHIP_DECLARE(cortex_a15_gic, "arm,cortex-a15-gic", gic_of_init);
>>  IRQCHIP_DECLARE(cortex_a9_gic, "arm,cortex-a9-gic", gic_of_init);
>> +IRQCHIP_DECLARE(hip04_gic, "hisilicon,hip04-gic", gic_of_init);
>>  IRQCHIP_DECLARE(msm_8660_qgic, "qcom,msm-8660-qgic", gic_of_init);
>>  IRQCHIP_DECLARE(msm_qgic2, "qcom,msm-qgic2", gic_of_init);
>
> Overall, there is still some work required to make this patch
> acceptable. The whole change could be much simpler and less
> controvertial if you didn't obfuscate the handling of the 16 CPU-IF case
> with so much bit arithmetic. Most of this code is on a slow path anyway,
> so you're not even optimizing anything that would be performance
> critical.
>
> Cheers,
>
>         M.
> --
> Jazz is not dead. It just smells funny.
