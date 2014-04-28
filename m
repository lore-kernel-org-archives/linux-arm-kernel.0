From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 28 Apr 2014 11:25:13 +0100
Subject: [PATCH v4 05/14] irq: gic: support hip04 gic
In-Reply-To: <1398668032-8335-6-git-send-email-haojian.zhuang@linaro.org>
 (Haojian Zhuang's message of "Mon, 28 Apr 2014 07:53:43 +0100")
References: <1398668032-8335-1-git-send-email-haojian.zhuang@linaro.org>
 <1398668032-8335-6-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <877g69vjhy.fsf@approximate.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Haojian,

On Mon, Apr 28 2014 at  7:53:43 am BST, Haojian Zhuang <haojian.zhuang@linaro.org> wrote:
> There's a little difference between ARM GIC and HiP04 GIC.
>
> * HiP04 GIC could support 16 cores at most, and ARM GIC could support
> 8 cores at most. So the difination on GIC_DIST_SGIR,
> GIC_DIST_SGI_PENDING_SET, GIC_DIST_SGI_PENDING_CLEAR
> & GIC_DIST_TARGET registers are different since CPU interfaces are
> increased from 8-bit to 16-bit.
>
> * HiP04 GIC could support 510 interrupts at most, and ARM GIC could
> support 1020 interrupts at most.
>
> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
> ---
>  drivers/irqchip/irq-gic.c | 155 ++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 122 insertions(+), 33 deletions(-)
>
> diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
> index 8fd27bf..793b4fe 100644
> --- a/drivers/irqchip/irq-gic.c
> +++ b/drivers/irqchip/irq-gic.c
> @@ -68,6 +68,7 @@ struct gic_chip_data {
>  #ifdef CONFIG_GIC_NON_BANKED
>         void __iomem *(*get_base)(union gic_base *);
>  #endif
> +       u32 nr_cpu_if;
>  };
>
>  static DEFINE_RAW_SPINLOCK(irq_controller_lock);
> @@ -76,9 +77,11 @@ static DEFINE_RAW_SPINLOCK(irq_controller_lock);
>   * The GIC mapping of CPU interfaces does not necessarily match
>   * the logical CPU numbering.  Let's use a mapping as returned
>   * by the GIC itself.
> + *
> + * Hisilicon HiP04 extends the number of CPU interface from 8 to 16.
>   */
> -#define NR_GIC_CPU_IF 8
> -static u8 gic_cpu_map[NR_GIC_CPU_IF] __read_mostly;
> +#define NR_GIC_CPU_IF  16
> +static u16 gic_cpu_map[NR_GIC_CPU_IF] __read_mostly;
>
>  /*
>   * Supported arch specific GIC irq extension.
> @@ -242,19 +245,55 @@ static int gic_retrigger(struct irq_data *d)
>  }
>
>  #ifdef CONFIG_SMP
> +static inline u32 irq_to_core_offset(struct irq_data *d)

I've come to realize that this function name isn't very meaningful. What
you're actually computing is the offset from GICD_TARGETR0.

How about renaming it to "irq_to_target_reg" and return the absolute
offset of the register? This would make the following code much simpler
(see examples below).

> +{
> +       struct gic_chip_data *gic_data = irq_data_get_irq_chip_data(d);
> +       unsigned int i = gic_irq(d);
> +
> +       /* ARM GIC */
> +       if (gic_data->nr_cpu_if == 8)

Given how often this is use throughout the code, I'd suggest having an
inline function such as:

static inline bool gic_is_standard(struct gic_chip_data *gic)
{
	return gic->nr_cpu_if == 8;
}

> +               return ((i >> 2) << 2);

If you want to mask out some bits, just use (i & ~3U).

> +       /* HiP04 GIC (nr_cpu_if == 16) */
> +       return ((i >> 1) << 2);

Same here: (i & ~1U).

> +}
> +
> +static inline u32 irq_to_core_shift(struct irq_data *d)
> +{
> +       struct gic_chip_data *gic_data = irq_data_get_irq_chip_data(d);
> +       unsigned int i = gic_irq(d);
> +
> +       /* ARM GIC */
> +       if (gic_data->nr_cpu_if == 8)
> +               return ((i % 4) << 3);
> +       /* HiP04 GIC (nr_cpu_if == 16) */
> +       return ((i % 2) << 4);
> +}
> +
> +static inline u32 irq_to_core_mask(struct irq_data *d)
> +{
> +       struct gic_chip_data *gic_data = irq_data_get_irq_chip_data(d);
> +       u32 mask;
> +       /* ARM GIC, nr_cpu_if == 8; HiP04 GIC, nr_cpu_if == 16 */
> +       mask = (1 << gic_data->nr_cpu_if) - 1;
> +       return (mask << irq_to_core_shift(d));
> +}
> +
>  static int gic_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
>                             bool force)
>  {
> -       void __iomem *reg = gic_dist_base(d) + GIC_DIST_TARGET + (gic_irq(d) & ~3);
> -       unsigned int shift = (gic_irq(d) % 4) * 8;
> +       void __iomem *reg;
> +       struct gic_chip_data *gic_data = irq_data_get_irq_chip_data(d);
> +       unsigned int shift = irq_to_core_shift(d);
>         unsigned int cpu = cpumask_any_and(mask_val, cpu_online_mask);
>         u32 val, mask, bit;
>
> -       if (cpu >= NR_GIC_CPU_IF || cpu >= nr_cpu_ids)
> +       if (cpu >= gic_data->nr_cpu_if || cpu >= nr_cpu_ids)
>                 return -EINVAL;
>
> +       reg = gic_dist_base(d) + GIC_DIST_TARGET + irq_to_core_offset(d);
> +

See my remark above about this code. You can rewrite it as:
	reg = gic_dist_base(d) + irq_to_target_reg(d);

>         raw_spin_lock(&irq_controller_lock);
> -       mask = 0xff << shift;
> +       mask = irq_to_core_mask(d);
>         bit = gic_cpu_map[cpu] << shift;
>         val = readl_relaxed(reg) & ~mask;
>         writel_relaxed(val | bit, reg);
> @@ -354,15 +393,24 @@ void __init gic_cascade_irq(unsigned int gic_nr, unsigned int irq)
>         irq_set_chained_handler(irq, gic_handle_cascade_irq);
>  }
>
> -static u8 gic_get_cpumask(struct gic_chip_data *gic)
> +static u16 gic_get_cpumask(struct gic_chip_data *gic)
>  {
>         void __iomem *base = gic_data_dist_base(gic);
>         u32 mask, i;
>
> -       for (i = mask = 0; i < 32; i += 4) {
> -               mask = readl_relaxed(base + GIC_DIST_TARGET + i);
> -               mask |= mask >> 16;
> -               mask |= mask >> 8;
> +       /*
> +        * ARM GIC uses 8 registers for interrupt 0-31,
> +        * HiP04 GIC uses 16 registers for interrupt 0-31.
> +        */
> +       for (i = mask = 0; i < 32; i += 32 / gic->nr_cpu_if) {
> +               if (gic->nr_cpu_if == 8) {      /* ARM GIC */
> +                       mask = readl_relaxed(base + GIC_DIST_TARGET + i);
> +                       mask |= mask >> 16;
> +                       mask |= mask >> 8;
> +               } else {                        /* HiP04 GIC */
> +                       mask = readl_relaxed(base + GIC_DIST_TARGET + i * 2);
> +                       mask |= mask >> 16;
> +               }

With the above change, you can rewrite it as:

		mask = readl_relaxed(base + irq_to_target_reg(i));
                mask |= mask >> 16;
                if (gic_is_standard(gic))
                	mask |= mask >> 8;

which I think is a bit nicer.

>                 if (mask)
>                         break;
>         }
> @@ -370,6 +418,10 @@ static u8 gic_get_cpumask(struct gic_chip_data *gic)
>         if (!mask)
>                 pr_crit("GIC CPU mask not found - kernel will fail to boot.\n");
>
> +       /* ARM GIC needs 8-bit cpu mask, HiP04 GIC needs 16-bit cpu mask. */
> +       if (gic->nr_cpu_if == 8)
> +               mask &= 0xff;
> +
>         return mask;
>  }
>
> @@ -392,10 +444,20 @@ static void __init gic_dist_init(struct gic_chip_data *gic)
>          * Set all global interrupts to this CPU only.
>          */
>         cpumask = gic_get_cpumask(gic);
> -       cpumask |= cpumask << 8;
> -       cpumask |= cpumask << 16;
> -       for (i = 32; i < gic_irqs; i += 4)
> -               writel_relaxed(cpumask, base + GIC_DIST_TARGET + i * 4 / 4);
> +       if (gic->nr_cpu_if == 8) {      /* ARM GIC */
> +               cpumask |= cpumask << 8;
> +               cpumask |= cpumask << 16;
> +       } else {                        /* HiP04 GIC */
> +               cpumask |= cpumask << 16;
> +       }

Move the "cpumask |= cpumask << 16;" out of the if block.

> +       for (i = 32; i < gic_irqs; i += 32 / gic->nr_cpu_if) {

Have an inline function that computes this:
static inline gic_irqs_per_target_reg(struct gic_chip_data *gic)
{
	return 32 / gic->nr_cpu_if;
}

and use it once outside of the loop. You can reuse it in gic_get_cpumask
and gic_dist_{save,restore}.

> +               if (gic->nr_cpu_if == 8)
> +                       writel_relaxed(cpumask,
> +                                      base + GIC_DIST_TARGET + i / 4 * 4);
> +               else
> +                       writel_relaxed(cpumask,
> +                                      base + GIC_DIST_TARGET + i / 2 * 4);

Change this whole block to:
		writel_relaxed(cpumask, base + irq_to_target_reg(i));

> +       }
>
>         /*
>          * Set priority on all global interrupts.
> @@ -423,7 +485,7 @@ static void gic_cpu_init(struct gic_chip_data *gic)
>         /*
>          * Get what the GIC says our CPU mask is.
>          */
> -       BUG_ON(cpu >= NR_GIC_CPU_IF);
> +       BUG_ON(cpu >= gic->nr_cpu_if);
>         cpu_mask = gic_get_cpumask(gic);
>         gic_cpu_map[cpu] = cpu_mask;
>
> @@ -431,7 +493,7 @@ static void gic_cpu_init(struct gic_chip_data *gic)
>          * Clear our mask from the other map entries in case they're
>          * still undefined.
>          */
> -       for (i = 0; i < NR_GIC_CPU_IF; i++)
> +       for (i = 0; i < gic->nr_cpu_if; i++)
>                 if (i != cpu)
>                         gic_cpu_map[i] &= ~cpu_mask;
>
> @@ -467,7 +529,7 @@ void gic_cpu_if_down(void)
>   */
>  static void gic_dist_save(unsigned int gic_nr)
>  {
> -       unsigned int gic_irqs;
> +       unsigned int gic_irqs, nr_if =  32 / gic_data[gic_nr].nr_cpu_if;

nr_if is not the number of interfaces, but the number of interrupts per
target register. Please give this variable a name that reflects what it
is.

>         void __iomem *dist_base;
>         int i;
>
> @@ -484,7 +546,7 @@ static void gic_dist_save(unsigned int gic_nr)
>                 gic_data[gic_nr].saved_spi_conf[i] =
>                         readl_relaxed(dist_base + GIC_DIST_CONFIG + i * 4);
>
> -       for (i = 0; i < DIV_ROUND_UP(gic_irqs, 4); i++)
> +       for (i = 0; i < DIV_ROUND_UP(gic_irqs, nr_if); i++)
>                 gic_data[gic_nr].saved_spi_target[i] =
>                         readl_relaxed(dist_base + GIC_DIST_TARGET + i * 4);
>
> @@ -502,7 +564,7 @@ static void gic_dist_save(unsigned int gic_nr)
>   */
>  static void gic_dist_restore(unsigned int gic_nr)
>  {
> -       unsigned int gic_irqs;
> +       unsigned int gic_irqs, nr_if = 32 / gic_data[gic_nr].nr_cpu_if;

Same as above.

>         unsigned int i;
>         void __iomem *dist_base;
>
> @@ -525,7 +587,7 @@ static void gic_dist_restore(unsigned int gic_nr)
>                 writel_relaxed(0xa0a0a0a0,
>                         dist_base + GIC_DIST_PRI + i * 4);
>
> -       for (i = 0; i < DIV_ROUND_UP(gic_irqs, 4); i++)
> +       for (i = 0; i < DIV_ROUND_UP(gic_irqs, nr_if); i++)
>                 writel_relaxed(gic_data[gic_nr].saved_spi_target[i],
>                         dist_base + GIC_DIST_TARGET + i * 4);
>
> @@ -665,9 +727,19 @@ static void gic_raise_softirq(const struct cpumask *mask, unsigned int irq)
>          */
>         dmb(ishst);
>
> -       /* this always happens on GIC0 */
> -       writel_relaxed(map << 16 | irq, gic_data_dist_base(&gic_data[0]) + GIC_DIST_SOFTINT);
> -
> +       /*
> +        * CPUTargetList -- bit[23:16] in GIC_DIST_SOFTINT in ARM GIC.
> +        *                  bit[23:8] in GIC_DIST_SOFTINT in HiP04 GIC.
> +        * NSATT -- bit[15] in GIC_DIST_SOFTINT in ARM GIC.
> +        *          bit[7] in GIC_DIST_SOFTINT in HiP04 GIC.
> +        * this always happens on GIC0
> +        */
> +       if (gic_data[0].nr_cpu_if == 8)
> +               map = map << 16;
> +       else
> +               map = map << 8;
> +       writel_relaxed(map | irq,
> +                      gic_data_dist_base(&gic_data[0]) + GIC_DIST_SOFTINT);
>         raw_spin_unlock_irqrestore(&irq_controller_lock, flags);
>  }
>  #endif
> @@ -681,10 +753,15 @@ static void gic_raise_softirq(const struct cpumask *mask, unsigned int irq)
>   */
>  void gic_send_sgi(unsigned int cpu_id, unsigned int irq)
>  {
> -       BUG_ON(cpu_id >= NR_GIC_CPU_IF);
> +       BUG_ON(cpu_id >= gic_data[0].nr_cpu_if);
>         cpu_id = 1 << cpu_id;
>         /* this always happens on GIC0 */
> -       writel_relaxed((cpu_id << 16) | irq, gic_data_dist_base(&gic_data[0]) + GIC_DIST_SOFTINT);
> +       if (gic_data[0].nr_cpu_if == 8)
> +               cpu_id = cpu_id << 16;
> +       else
> +               cpu_id = cpu_id << 8;
> +       writel_relaxed(cpu_id | irq,
> +                      gic_data_dist_base(&gic_data[0]) + GIC_DIST_SOFTINT);
>  }
>
>  /*
> @@ -700,7 +777,7 @@ int gic_get_cpu_id(unsigned int cpu)
>  {
>         unsigned int cpu_bit;
>
> -       if (cpu >= NR_GIC_CPU_IF)
> +       if (cpu >= gic_data[0].nr_cpu_if)
>                 return -1;
>         cpu_bit = gic_cpu_map[cpu];
>         if (cpu_bit & (cpu_bit - 1))
> @@ -931,7 +1008,7 @@ void __init gic_init_bases(unsigned int gic_nr, int irq_start,
>         irq_hw_number_t hwirq_base;
>         struct gic_chip_data *gic;
>         int gic_irqs, irq_base, i;
> -       int nr_routable_irqs;
> +       int nr_routable_irqs, max_nr_irq;
>
>         BUG_ON(gic_nr >= MAX_GIC_NR);
>
> @@ -967,12 +1044,22 @@ void __init gic_init_bases(unsigned int gic_nr, int irq_start,
>                 gic_set_base_accessor(gic, gic_get_common_base);
>         }
>
> +       if (of_device_is_compatible(node, "hisilicon,hip04-gic")) {
> +               /* HiP04 GIC supports 16 CPUs at most */
> +               gic->nr_cpu_if = 16;
> +               max_nr_irq = 510;
> +       } else {
> +               /* ARM/Qualcomm GIC supports 8 CPUs at most */
> +               gic->nr_cpu_if = 8;
> +               max_nr_irq = 1020;
> +       }
> +
>         /*
>          * Initialize the CPU interface map to all CPUs.
>          * It will be refined as each CPU probes its ID.
>          */
> -       for (i = 0; i < NR_GIC_CPU_IF; i++)
> -               gic_cpu_map[i] = 0xff;
> +       for (i = 0; i < gic->nr_cpu_if; i++)
> +               gic_cpu_map[i] = (1 << gic->nr_cpu_if) - 1;
>
>         /*
>          * For primary GICs, skip over SGIs.
> @@ -988,12 +1075,13 @@ void __init gic_init_bases(unsigned int gic_nr, int irq_start,
>
>         /*
>          * Find out how many interrupts are supported.
> -        * The GIC only supports up to 1020 interrupt sources.
> +        * The ARM/Qualcomm GIC only supports up to 1020 interrupt sources.
> +        * The HiP04 GIC only supports up to 510 interrupt sources.
>          */
>         gic_irqs = readl_relaxed(gic_data_dist_base(gic) + GIC_DIST_CTR) & 0x1f;
>         gic_irqs = (gic_irqs + 1) * 32;
> -       if (gic_irqs > 1020)
> -               gic_irqs = 1020;
> +       if (gic_irqs > max_nr_irq)
> +               gic_irqs = max_nr_irq;
>         gic->gic_irqs = gic_irqs;
>
>         gic_irqs -= hwirq_base; /* calculate # of irqs to allocate */
> @@ -1069,6 +1157,7 @@ gic_of_init(struct device_node *node, struct device_node *parent)
>  }
>  IRQCHIP_DECLARE(cortex_a15_gic, "arm,cortex-a15-gic", gic_of_init);
>  IRQCHIP_DECLARE(cortex_a9_gic, "arm,cortex-a9-gic", gic_of_init);
> +IRQCHIP_DECLARE(hip04_gic, "hisilicon,hip04-gic", gic_of_init);
>  IRQCHIP_DECLARE(msm_8660_qgic, "qcom,msm-8660-qgic", gic_of_init);
>  IRQCHIP_DECLARE(msm_qgic2, "qcom,msm-qgic2", gic_of_init);

So this patch is a lot better than the previous ones. Still some work to
do to make it clearer, have the proper abstraction and avoid repetition
of similar constructs.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny.
