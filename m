From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 28 Jul 2014 18:38:58 +0100
Subject: [PATCH v15 01/12] irq: gic: support hip04 gic
In-Reply-To: <1406555876-11989-2-git-send-email-haojian.zhuang@linaro.org>
 (Haojian Zhuang's message of "Mon, 28 Jul 2014 14:57:45 +0100")
References: <1406555876-11989-1-git-send-email-haojian.zhuang@linaro.org>
 <1406555876-11989-2-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <87a97to025.fsf@approximate.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Haojian,

On Mon, Jul 28 2014 at  2:57:45 pm BST, Haojian Zhuang <haojian.zhuang@linaro.org> wrote:
> There's some difference between ARM GICv2 and HiP04 GIC.
>
> * HiP04 GIC could support 16 cores at most, and ARM GIC could support
> 8 cores at most. So the defination on GIC_DIST_TARGET registers are
> different since CPU interfaces are increased from 8-bit to 16-bit.
>
> * HiP04 GIC could support 510 interrupts at most, and ARM GIC could
> support 1020 interrupts at most.
>
> Changelog:
> v14:
>   * Mount function pointers to different implementation on standard
>     GICv2 and Hisilicon HiP04 GIC.
>
> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
> ---
>  Documentation/devicetree/bindings/arm/gic.txt |   1 +
>  drivers/irqchip/irq-gic.c                     | 436 +++++++++++++++++++++-----
>  2 files changed, 350 insertions(+), 87 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/arm/gic.txt b/Documentation/devicetree/bindings/arm/gic.txt
> index 5573c08..150f7d6 100644
> --- a/Documentation/devicetree/bindings/arm/gic.txt
> +++ b/Documentation/devicetree/bindings/arm/gic.txt
> @@ -16,6 +16,7 @@ Main node required properties:
>         "arm,cortex-a9-gic"
>         "arm,cortex-a7-gic"
>         "arm,arm11mp-gic"
> +       "hisilicon,hip04-gic"
>  - interrupt-controller : Identifies the node as an interrupt controller
>  - #interrupt-cells : Specifies the number of cells needed to encode an
>    interrupt source.  The type shall be a <u32> and the value shall be 3.
> diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
> index 508b815..b47243f 100644
> --- a/drivers/irqchip/irq-gic.c
> +++ b/drivers/irqchip/irq-gic.c
> @@ -69,19 +69,23 @@ struct gic_chip_data {
>  #ifdef CONFIG_GIC_NON_BANKED
>         void __iomem *(*get_base)(union gic_base *);
>  #endif
> +       void (*init_cpu_map)(void);
> +       u32 (*get_cpu_map)(u32);
> +       void (*set_cpu_map)(u32, u32);
> +       bool (*cpu_invalid)(u32);

Nit: It would make more sense to me to have a "cpu_valid" hook, instead
of the negative version.

> +       u32 (*get_cpumask)(struct gic_chip_data *);
> +       void (*set_dist_target)(struct gic_chip_data *, u32, u32);
> +       void (*set_dist_softint)(struct gic_chip_data *, u32, u32);
> +       void (*dist_init)(struct gic_chip_data *);
> +       void (*dist_save)(unsigned int);
> +       void (*dist_restore)(unsigned int);
> +       u32 nr_cpu_if;
> +       u32 max_nr_irq;
>  };
>
>  static DEFINE_RAW_SPINLOCK(irq_controller_lock);
>
>  /*
> - * The GIC mapping of CPU interfaces does not necessarily match
> - * the logical CPU numbering.  Let's use a mapping as returned
> - * by the GIC itself.
> - */
> -#define NR_GIC_CPU_IF 8
> -static u8 gic_cpu_map[NR_GIC_CPU_IF] __read_mostly;
> -
> -/*
>   * Supported arch specific GIC irq extension.
>   * Default make them NULL.
>   */
> @@ -222,23 +226,21 @@ static int gic_retrigger(struct irq_data *d)
>  static int gic_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
>                             bool force)
>  {
> -       void __iomem *reg = gic_dist_base(d) + GIC_DIST_TARGET + (gic_irq(d) & ~3);
> -       unsigned int cpu, shift = (gic_irq(d) % 4) * 8;
> -       u32 val, mask, bit;
> +       struct gic_chip_data *gic_data = irq_data_get_irq_chip_data(d);
> +       unsigned int cpu;
> +       u32 bit;
>
>         if (!force)
>                 cpu = cpumask_any_and(mask_val, cpu_online_mask);
>         else
>                 cpu = cpumask_first(mask_val);
>
> -       if (cpu >= NR_GIC_CPU_IF || cpu >= nr_cpu_ids)
> +       if (gic_data->cpu_invalid(cpu) || cpu >= nr_cpu_ids)
>                 return -EINVAL;
>
>         raw_spin_lock(&irq_controller_lock);
> -       mask = 0xff << shift;
> -       bit = gic_cpu_map[cpu] << shift;
> -       val = readl_relaxed(reg) & ~mask;
> -       writel_relaxed(val | bit, reg);
> +       bit = gic_data->get_cpu_map(cpu);
> +       gic_data->set_dist_target(gic_data, gic_irq(d), bit);
>         raw_spin_unlock(&irq_controller_lock);
>
>         return IRQ_SET_MASK_OK;
> @@ -304,7 +306,7 @@ static void gic_handle_cascade_irq(unsigned int irq, struct irq_desc *desc)
>                 goto out;
>
>         cascade_irq = irq_find_mapping(chip_data->domain, gic_irq);
> -       if (unlikely(gic_irq < 32 || gic_irq > 1020))
> +       if (unlikely(gic_irq < 32 || gic_irq > chip_data->max_nr_irq))
>                 handle_bad_irq(cascade_irq, desc);
>         else
>                 generic_handle_irq(cascade_irq);
> @@ -335,69 +337,31 @@ void __init gic_cascade_irq(unsigned int gic_nr, unsigned int irq)
>         irq_set_chained_handler(irq, gic_handle_cascade_irq);
>  }
>
> -static u8 gic_get_cpumask(struct gic_chip_data *gic)
> -{
> -       void __iomem *base = gic_data_dist_base(gic);
> -       u32 mask, i;
> -
> -       for (i = mask = 0; i < 32; i += 4) {
> -               mask = readl_relaxed(base + GIC_DIST_TARGET + i);
> -               mask |= mask >> 16;
> -               mask |= mask >> 8;
> -               if (mask)
> -                       break;
> -       }
> -
> -       if (!mask)
> -               pr_crit("GIC CPU mask not found - kernel will fail to boot.\n");
> -
> -       return mask;
> -}
> -
> -static void __init gic_dist_init(struct gic_chip_data *gic)
> -{
> -       unsigned int i;
> -       u32 cpumask;
> -       unsigned int gic_irqs = gic->gic_irqs;
> -       void __iomem *base = gic_data_dist_base(gic);
> -
> -       writel_relaxed(0, base + GIC_DIST_CTRL);
> -
> -       /*
> -        * Set all global interrupts to this CPU only.
> -        */
> -       cpumask = gic_get_cpumask(gic);
> -       cpumask |= cpumask << 8;
> -       cpumask |= cpumask << 16;
> -       for (i = 32; i < gic_irqs; i += 4)
> -               writel_relaxed(cpumask, base + GIC_DIST_TARGET + i * 4 / 4);
> -
> -       gic_dist_config(base, gic_irqs, NULL);
> -
> -       writel_relaxed(1, base + GIC_DIST_CTRL);
> -}
> -
>  static void gic_cpu_init(struct gic_chip_data *gic)
>  {
>         void __iomem *dist_base = gic_data_dist_base(gic);
>         void __iomem *base = gic_data_cpu_base(gic);
>         unsigned int cpu_mask, cpu = smp_processor_id();
>         int i;
> +       u32 data;
>
>         /*
>          * Get what the GIC says our CPU mask is.
>          */
> -       BUG_ON(cpu >= NR_GIC_CPU_IF);
> -       cpu_mask = gic_get_cpumask(gic);
> -       gic_cpu_map[cpu] = cpu_mask;
> +       BUG_ON(gic->cpu_invalid(cpu));
> +       cpu_mask = gic->get_cpumask(gic);
> +       gic->set_cpu_map(cpu, cpu_mask);
>
>         /*
>          * Clear our mask from the other map entries in case they're
>          * still undefined.
>          */
> -       for (i = 0; i < NR_GIC_CPU_IF; i++)
> -               if (i != cpu)
> -                       gic_cpu_map[i] &= ~cpu_mask;
> +       for (i = 0; i < gic->nr_cpu_if; i++) {
> +               if (i != cpu) {
> +                       data = gic->get_cpu_map(i);
> +                       gic->set_cpu_map(i, data & ~cpu_mask);
> +               }
> +       }
>
>         gic_cpu_config(dist_base, NULL);
>
> @@ -489,6 +453,70 @@ static void gic_dist_restore(unsigned int gic_nr)
>         writel_relaxed(1, dist_base + GIC_DIST_CTRL);
>  }
>
> +static void hip04_dist_save(unsigned int gic_nr)
> +{
> +       unsigned int gic_irqs;
> +       void __iomem *dist_base;
> +       int i;
> +
> +       if (gic_nr >= MAX_GIC_NR)
> +               BUG();
> +
> +       gic_irqs = gic_data[gic_nr].gic_irqs;
> +       dist_base = gic_data_dist_base(&gic_data[gic_nr]);
> +
> +       if (!dist_base)
> +               return;
> +
> +       for (i = 0; i < DIV_ROUND_UP(gic_irqs, 16); i++)
> +               gic_data[gic_nr].saved_spi_conf[i] =
> +                       readl_relaxed(dist_base + GIC_DIST_CONFIG + i * 4);
> +
> +       for (i = 0; i < DIV_ROUND_UP(gic_irqs, 2); i++)
> +               gic_data[gic_nr].saved_spi_target[i] =
> +                       readl_relaxed(dist_base + GIC_DIST_TARGET + i * 2);
> +
> +       for (i = 0; i < DIV_ROUND_UP(gic_irqs, 32); i++)
> +               gic_data[gic_nr].saved_spi_enable[i] =
> +                       readl_relaxed(dist_base + GIC_DIST_ENABLE_SET + i * 4);
> +}
> +
> +static void hip04_dist_restore(unsigned int gic_nr)
> +{
> +       unsigned int gic_irqs;
> +       unsigned int i;
> +       void __iomem *dist_base;
> +
> +       if (gic_nr >= MAX_GIC_NR)
> +               BUG();
> +
> +       gic_irqs = gic_data[gic_nr].gic_irqs;
> +       dist_base = gic_data_dist_base(&gic_data[gic_nr]);
> +
> +       if (!dist_base)
> +               return;
> +
> +       writel_relaxed(0, dist_base + GIC_DIST_CTRL);
> +
> +       for (i = 0; i < DIV_ROUND_UP(gic_irqs, 16); i++)
> +               writel_relaxed(gic_data[gic_nr].saved_spi_conf[i],
> +                       dist_base + GIC_DIST_CONFIG + i * 4);
> +
> +       for (i = 0; i < DIV_ROUND_UP(gic_irqs, 4); i++)
> +               writel_relaxed(0xa0a0a0a0,
> +                       dist_base + GIC_DIST_PRI + i * 4);
> +
> +       for (i = 0; i < DIV_ROUND_UP(gic_irqs, 2); i++)
> +               writel_relaxed(gic_data[gic_nr].saved_spi_target[i],
> +                       dist_base + GIC_DIST_TARGET + i * 2);
> +
> +       for (i = 0; i < DIV_ROUND_UP(gic_irqs, 32); i++)
> +               writel_relaxed(gic_data[gic_nr].saved_spi_enable[i],
> +                       dist_base + GIC_DIST_ENABLE_SET + i * 4);
> +
> +       writel_relaxed(1, dist_base + GIC_DIST_CTRL);
> +}
> +
>  static void gic_cpu_save(unsigned int gic_nr)
>  {
>         int i;
> @@ -565,11 +593,11 @@ static int gic_notifier(struct notifier_block *self, unsigned long cmd,   void *v)
>                         gic_cpu_restore(i);
>                         break;
>                 case CPU_CLUSTER_PM_ENTER:
> -                       gic_dist_save(i);
> +                       gic_data[i].dist_save(i);
>                         break;
>                 case CPU_CLUSTER_PM_ENTER_FAILED:
>                 case CPU_CLUSTER_PM_EXIT:
> -                       gic_dist_restore(i);
> +                       gic_data[i].dist_restore(i);
>                         break;
>                 }
>         }
> @@ -610,7 +638,7 @@ static void gic_raise_softirq(const struct cpumask *mask, unsigned int irq)
>
>         /* Convert our logical CPU mask into a physical one. */
>         for_each_cpu(cpu, mask)
> -               map |= gic_cpu_map[cpu];
> +               map |= gic_data[0].get_cpu_map(cpu);
>
>         /*
>          * Ensure that stores to Normal memory are visible to the
> @@ -619,7 +647,7 @@ static void gic_raise_softirq(const struct cpumask *mask, unsigned int irq)
>         dmb(ishst);
>
>         /* this always happens on GIC0 */
> -       writel_relaxed(map << 16 | irq, gic_data_dist_base(&gic_data[0]) + GIC_DIST_SOFTINT);
> +       gic_data[0].set_dist_softint(&gic_data[0], irq, map);
>
>         raw_spin_unlock_irqrestore(&irq_controller_lock, flags);
>  }
> @@ -634,10 +662,9 @@ static void gic_raise_softirq(const struct cpumask *mask, unsigned int irq)
>   */
>  void gic_send_sgi(unsigned int cpu_id, unsigned int irq)
>  {
> -       BUG_ON(cpu_id >= NR_GIC_CPU_IF);
> -       cpu_id = 1 << cpu_id;
> +       BUG_ON(gic_data[0].cpu_invalid(cpu_id));
>         /* this always happens on GIC0 */
> -       writel_relaxed((cpu_id << 16) | irq, gic_data_dist_base(&gic_data[0]) + GIC_DIST_SOFTINT);
> +       gic_data[0].set_dist_softint(&gic_data[0], irq, 1 << cpu_id);
>  }
>
>  /*
> @@ -653,9 +680,9 @@ int gic_get_cpu_id(unsigned int cpu)
>  {
>         unsigned int cpu_bit;
>
> -       if (cpu >= NR_GIC_CPU_IF)
> +       if (gic_data[0].cpu_invalid(cpu))
>                 return -1;
> -       cpu_bit = gic_cpu_map[cpu];
> +       cpu_bit = gic_data[0].get_cpu_map(cpu);
>         if (cpu_bit & (cpu_bit - 1))
>                 return -1;
>         return __ffs(cpu_bit);
> @@ -673,6 +700,7 @@ int gic_get_cpu_id(unsigned int cpu)
>   */
>  void gic_migrate_target(unsigned int new_cpu_id)
>  {
> +       struct gic_chip_data *gic = &gic_data[gic_nr];
>         unsigned int cur_cpu_id, gic_irqs, gic_nr = 0;
>         void __iomem *dist_base;
>         int i, ror_val, cpu = smp_processor_id();
> @@ -681,19 +709,19 @@ void gic_migrate_target(unsigned int new_cpu_id)
>         if (gic_nr >= MAX_GIC_NR)
>                 BUG();
>
> -       dist_base = gic_data_dist_base(&gic_data[gic_nr]);
> +       dist_base = gic_data_dist_base(gic);
>         if (!dist_base)
>                 return;
> -       gic_irqs = gic_data[gic_nr].gic_irqs;
> +       gic_irqs = gic->gic_irqs;
>
> -       cur_cpu_id = __ffs(gic_cpu_map[cpu]);
> +       cur_cpu_id = __ffs(gic->get_cpu_map(cpu));
>         cur_target_mask = 0x01010101 << cur_cpu_id;
>         ror_val = (cur_cpu_id - new_cpu_id) & 31;
>
>         raw_spin_lock(&irq_controller_lock);
>
>         /* Update the target interface for this logical CPU */
> -       gic_cpu_map[cpu] = 1 << new_cpu_id;
> +       gic_data->set_cpu_map(cpu, 1 << new_cpu_id);
>
>         /*
>          * Find all the peripheral interrupts targetting the current
> @@ -730,8 +758,7 @@ void gic_migrate_target(unsigned int new_cpu_id)
>                 writel_relaxed(val, dist_base + GIC_DIST_SGI_PENDING_CLEAR + i);
>                 for (j = i; j < i + 4; j++) {
>                         if (val & 0xff)
> -                               writel_relaxed((1 << (new_cpu_id + 16)) | j,
> -                                               dist_base + GIC_DIST_SOFTINT);
> +                               gic->set_dist_softint(gic, j, 1 << new_cpu_id);
>                         val >>= 8;
>                 }
>         }
> @@ -883,7 +910,7 @@ void __init gic_init_bases(unsigned int gic_nr, int irq_start,
>  {
>         irq_hw_number_t hwirq_base;
>         struct gic_chip_data *gic;
> -       int gic_irqs, irq_base, i;
> +       int gic_irqs, irq_base;
>         int nr_routable_irqs;
>
>         BUG_ON(gic_nr >= MAX_GIC_NR);
> @@ -924,8 +951,7 @@ void __init gic_init_bases(unsigned int gic_nr, int irq_start,
>          * Initialize the CPU interface map to all CPUs.
>          * It will be refined as each CPU probes its ID.
>          */
> -       for (i = 0; i < NR_GIC_CPU_IF; i++)
> -               gic_cpu_map[i] = 0xff;
> +       gic->init_cpu_map();
>
>         /*
>          * For primary GICs, skip over SGIs.
> @@ -941,12 +967,13 @@ void __init gic_init_bases(unsigned int gic_nr, int irq_start,
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
> +       if (gic_irqs > gic->max_nr_irq)
> +               gic_irqs = gic->max_nr_irq;
>         gic->gic_irqs = gic_irqs;
>
>         gic_irqs -= hwirq_base; /* calculate # of irqs to allocate */
> @@ -981,7 +1008,7 @@ void __init gic_init_bases(unsigned int gic_nr, int irq_start,
>         }
>
>         gic_chip.flags |= gic_arch_extn.flags;
> -       gic_dist_init(gic);
> +       gic->dist_init(gic);
>         gic_cpu_init(gic);
>         gic_pm_init(gic);
>  }
> @@ -989,6 +1016,98 @@ void __init gic_init_bases(unsigned int gic_nr, int irq_start,
>  #ifdef CONFIG_OF
>  static int gic_cnt __initdata;

I think you just broke all the non-DT platforms in one single go.

> +/*
> + * The GIC mapping of CPU interfaces does not necessarily match
> + * the logical CPU numbering.  Let's use a mapping as returned
> + * by the GIC itself.
> + */
> +#define NR_GIC_CPU_IF 8
> +static u8 gic_cpu_map[NR_GIC_CPU_IF] __read_mostly;
> +
> +static void gic_init_cpu_map(void)
> +{
> +       int i;
> +       for (i = 0; i < NR_GIC_CPU_IF; i++)
> +               gic_cpu_map[i] = 0xff;
> +}
> +
> +static u32 gic_get_cpu_map(u32 i)
> +{
> +       return gic_cpu_map[i];
> +}
> +
> +static void gic_set_cpu_map(u32 i, u32 data)
> +{
> +       gic_cpu_map[i] = data & 0xff;
> +}
> +
> +static bool gic_cpu_invalid(u32 cpu)
> +{
> +       return cpu >= NR_GIC_CPU_IF;
> +}
> +
> +static u32 gic_get_cpumask(struct gic_chip_data *gic)
> +{
> +       void __iomem *base = gic_data_dist_base(gic);
> +       u32 mask, i;
> +
> +       for (i = mask = 0; i < 32; i += 4) {
> +               mask = readl_relaxed(base + GIC_DIST_TARGET + i);
> +               mask |= mask >> 16;
> +               mask |= mask >> 8;
> +               if (mask)
> +                       break;
> +       }
> +
> +       if (!mask)
> +               pr_crit("GIC CPU mask not found - kernel will fail to boot.\n");
> +
> +       return mask & 0xff;
> +}
> +
> +static void gic_set_dist_target(struct gic_chip_data *gic, u32 irq, u32 data)
> +{
> +       void __iomem *base = gic_data_dist_base(gic);
> +       u32 val, mask, offset, shift = (irq % 4) * 8;
> +
> +       mask = 0xff << shift;
> +       offset = irq & ~3U;
> +       val = readl_relaxed(base + GIC_DIST_TARGET + offset) & ~mask;
> +       val |= data << shift;
> +       writel_relaxed(val, base + GIC_DIST_TARGET + offset);
> +}
> +
> +static void gic_set_dist_softint(struct gic_chip_data *gic, u32 irq, u32 data)
> +{
> +       void __iomem *base = gic_data_dist_base(gic);
> +
> +       data = data << 16;
> +       writel_relaxed(data | irq, base + GIC_DIST_SOFTINT);
> +}
> +
> +static void gic_dist_init(struct gic_chip_data *gic)
> +{
> +       unsigned int i;
> +       u32 cpumask;
> +       unsigned int gic_irqs = gic->gic_irqs;
> +       void __iomem *base = gic_data_dist_base(gic);
> +
> +       writel_relaxed(0, base + GIC_DIST_CTRL);
> +
> +       /*
> +        * Set all global interrupts to this CPU only.
> +        */
> +       cpumask = gic_get_cpumask(gic);
> +       cpumask |= cpumask << 8;
> +       cpumask |= cpumask << 16;
> +       for (i = 32; i < gic_irqs; i += 4)
> +               writel_relaxed(cpumask, base + GIC_DIST_TARGET + i * 4 / 4);
> +
> +       gic_dist_config(base, gic_irqs, NULL);
> +
> +       writel_relaxed(1, base + GIC_DIST_CTRL);
> +}
> +
>  static int __init
>  gic_of_init(struct device_node *node, struct device_node *parent)
>  {
> @@ -1009,6 +1128,148 @@ gic_of_init(struct device_node *node, struct device_node *parent)
>         if (of_property_read_u32(node, "cpu-offset", &percpu_offset))
>                 percpu_offset = 0;
>
> +       gic_data[gic_cnt].nr_cpu_if = 8;
> +       gic_data[gic_cnt].init_cpu_map = gic_init_cpu_map;
> +       gic_data[gic_cnt].get_cpu_map = gic_get_cpu_map;
> +       gic_data[gic_cnt].set_cpu_map = gic_set_cpu_map;
> +       gic_data[gic_cnt].cpu_invalid = gic_cpu_invalid;
> +       gic_data[gic_cnt].get_cpumask = gic_get_cpumask;
> +       gic_data[gic_cnt].dist_init = gic_dist_init;
> +       gic_data[gic_cnt].dist_save = gic_dist_save;
> +       gic_data[gic_cnt].dist_restore = gic_dist_restore;
> +       gic_data[gic_cnt].set_dist_target = gic_set_dist_target;
> +       gic_data[gic_cnt].set_dist_softint = gic_set_dist_softint;
> +       gic_data[gic_cnt].max_nr_irq = 1020;
> +       gic_init_bases(gic_cnt, -1, dist_base, cpu_base, percpu_offset, node);
> +       if (!gic_cnt)
> +               gic_init_physaddr(node);
> +
> +       if (parent) {
> +               irq = irq_of_parse_and_map(node, 0);
> +               gic_cascade_irq(gic_cnt, irq);
> +       }
> +       gic_cnt++;
> +       return 0;
> +}
> +
> +/* HiP04 extends the number of CPU interface from 8 to 16 */
> +#define NR_HIP04_CPU_IF        16
> +static u16 hip04_cpu_map[NR_HIP04_CPU_IF] __read_mostly;
> +
> +static void hip04_init_cpu_map(void)
> +{
> +       int i;
> +       for (i = 0; i < NR_HIP04_CPU_IF; i++)
> +               hip04_cpu_map[i] = 0xffff;
> +}
> +
> +static u32 hip04_get_cpu_map(u32 i)
> +{
> +       return hip04_cpu_map[i];
> +}
> +
> +static void hip04_set_cpu_map(u32 i, u32 data)
> +{
> +       hip04_cpu_map[i] = data & 0xffff;
> +}
> +
> +static bool hip04_cpu_invalid(u32 cpu)
> +{
> +       return cpu >= NR_HIP04_CPU_IF;
> +}
> +
> +static u32 hip04_get_cpumask(struct gic_chip_data *gic)
> +{
> +       void __iomem *base = gic_data_dist_base(gic);
> +       u32 mask, i;
> +
> +       for (i = mask = 0; i < 32; i += 2) {
> +               mask = readl_relaxed(base + GIC_DIST_TARGET + i * 2);
> +               mask |= mask >> 16;
> +               if (mask)
> +                       break;
> +       }
> +
> +       if (!mask)
> +               pr_crit("GIC CPU mask not found - kernel will fail to
> boot.\n");

Certainly we don't need this message twice. It should be placed wherever
necessary.

> +
> +       return mask & 0xffff;
> +}
> +
> +static void hip04_set_dist_target(struct gic_chip_data *gic, u32 irq, u32 data)
> +{
> +       void __iomem *base = gic_data_dist_base(gic);
> +       u32 val, mask, offset, shift = (irq % 2) * 16;
> +
> +       mask = 0xffff << shift;
> +       offset = (irq * 2) & ~3U;
> +       val = readl_relaxed(base + GIC_DIST_TARGET + offset) & ~mask;
> +       val |= data << shift;
> +       writel_relaxed(val, base + GIC_DIST_TARGET + offset);
> +}
> +
> +static void hip04_set_dist_softint(struct gic_chip_data *gic, u32 irq, u32 data)
> +{
> +       void __iomem *base = gic_data_dist_base(gic);
> +
> +       data = data << 8;
> +       writel_relaxed(data | irq, base + GIC_DIST_SOFTINT);
> +}
> +
> +static void hip04_dist_init(struct gic_chip_data *gic)
> +{
> +       unsigned int i;
> +       u32 cpumask;
> +       unsigned int gic_irqs = gic->gic_irqs;
> +       void __iomem *base = gic_data_dist_base(gic);
> +
> +       writel_relaxed(0, base + GIC_DIST_CTRL);
> +
> +       /*
> +        * Set all global interrupts to this CPU only.
> +        */
> +       cpumask = hip04_get_cpumask(gic);
> +       cpumask |= cpumask << 16;
> +       for (i = 32; i < gic_irqs; i += 2)
> +               writel_relaxed(cpumask, base + GIC_DIST_TARGET + i * 2);
> +
> +       gic_dist_config(base, gic_irqs, NULL);
> +
> +       writel_relaxed(1, base + GIC_DIST_CTRL);
> +}
> +
> +static int __init
> +hip04_of_init(struct device_node *node, struct device_node *parent)
> +{
> +       void __iomem *cpu_base;
> +       void __iomem *dist_base;
> +       u32 percpu_offset;
> +       int irq;
> +
> +       if (WARN_ON(!node))
> +               return -ENODEV;
> +
> +       dist_base = of_iomap(node, 0);
> +       WARN(!dist_base, "unable to map gic dist registers\n");
> +
> +       cpu_base = of_iomap(node, 1);
> +       WARN(!cpu_base, "unable to map gic cpu registers\n");
> +
> +       if (of_property_read_u32(node, "cpu-offset", &percpu_offset))
> +               percpu_offset = 0;
> +
> +       gic_data[gic_cnt].nr_cpu_if = 16;
> +       gic_data[gic_cnt].init_cpu_map = hip04_init_cpu_map;
> +       gic_data[gic_cnt].get_cpu_map = hip04_get_cpu_map;
> +       gic_data[gic_cnt].set_cpu_map = hip04_set_cpu_map;
> +       gic_data[gic_cnt].cpu_invalid = hip04_cpu_invalid;
> +       gic_data[gic_cnt].get_cpumask = hip04_get_cpumask;
> +       gic_data[gic_cnt].dist_init = hip04_dist_init;
> +       gic_data[gic_cnt].dist_save = hip04_dist_save;
> +       gic_data[gic_cnt].dist_restore = hip04_dist_restore;
> +       gic_data[gic_cnt].set_dist_target = hip04_set_dist_target;
> +       gic_data[gic_cnt].set_dist_softint = hip04_set_dist_softint;
> +       gic_data[gic_cnt].max_nr_irq = 510;
>         gic_init_bases(gic_cnt, -1, dist_base, cpu_base, percpu_offset, node);
>         if (!gic_cnt)
>                 gic_init_physaddr(node);
> @@ -1022,6 +1283,7 @@ gic_of_init(struct device_node *node, struct device_node *parent)
>  }
>  IRQCHIP_DECLARE(cortex_a15_gic, "arm,cortex-a15-gic", gic_of_init);
>  IRQCHIP_DECLARE(cortex_a9_gic, "arm,cortex-a9-gic", gic_of_init);
> +IRQCHIP_DECLARE(hip04_gic, "hisilicon,hip04-gic", hip04_of_init);
>  IRQCHIP_DECLARE(msm_8660_qgic, "qcom,msm-8660-qgic", gic_of_init);
>  IRQCHIP_DECLARE(msm_qgic2, "qcom,msm-qgic2", gic_of_init);

Overall, this code should be able to sitting within a #ifdef/#endif
block, only selected if this platform is enabled, and possibly find a
way not to impact all the other platforms when this is not selected.

Finally, I'd like to outline how much I dislike the way the GIC
architecture has been abused here. Yes, this solves a particular
problem, at a given point in time, but this also feels extremely short
sighted from whoever has put this thing together. This really feels like
a short-term HW hack that is already addressed by GICv3. Merging support
for non architecture compliant HW is never the best solution.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny.
