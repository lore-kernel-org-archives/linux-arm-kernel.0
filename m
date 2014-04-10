From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 10 Apr 2014 09:12:47 +0100
Subject: [PATCH v2 05/12] irq: gic: extends the cpu interface to 16
In-Reply-To: <1396944052-9887-6-git-send-email-haojian.zhuang@linaro.org>
 (Haojian Zhuang's message of "Tue, 8 Apr 2014 09:00:45 +0100")
References: <1396944052-9887-1-git-send-email-haojian.zhuang@linaro.org>
 <1396944052-9887-6-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <87lhvd38n4.fsf@approximate.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 08 2014 at  9:00:45 am BST, Haojian Zhuang <haojian.zhuang@linaro.org> wrote:

Hi Haojian,

> In order to support 16 CPUs, Hisilicon extends the GIC to support the
> number of CPU interfaces from 8 to 16.

Yet another Frankein-GIC! Hooray! I missed that fuzzy feeling! ;-)

First, it would be good to have an exact description of what are the
changes HiSilicon made in the GIC distributor. Here, I can only make
educated guesses (which I'd like to avoid).

> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
> ---
>  drivers/irqchip/irq-gic.c | 78 ++++++++++++++++++++++++++++-------------------
>  1 file changed, 47 insertions(+), 31 deletions(-)
>
> diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
> index 8fd27bf..44eff46 100644
> --- a/drivers/irqchip/irq-gic.c
> +++ b/drivers/irqchip/irq-gic.c
> @@ -76,9 +76,12 @@ static DEFINE_RAW_SPINLOCK(irq_controller_lock);
>   * The GIC mapping of CPU interfaces does not necessarily match
>   * the logical CPU numbering.  Let's use a mapping as returned
>   * by the GIC itself.
> + *
> + * Hisilicon HiP04 extends the number of CPU interface from 8 to 16.
>   */
> -#define NR_GIC_CPU_IF 8
> -static u8 gic_cpu_map[NR_GIC_CPU_IF] __read_mostly;
> +#define MAX_NR_GIC_CPU_IF 16
> +static u16 gic_cpu_map[MAX_NR_GIC_CPU_IF] __read_mostly;
> +static int nr_gic_cpu_if = 8;  /* The standard GIC supports 8 CPUs */

How do you deal with a situation where you have a standard GIC cascaded
into one of these super-charged GIC? This is really a per-GIC property,
not a global one.

>  /*
>   * Supported arch specific GIC irq extension.
> @@ -245,16 +248,19 @@ static int gic_retrigger(struct irq_data *d)
>  static int gic_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
>                             bool force)
>  {
> -       void __iomem *reg = gic_dist_base(d) + GIC_DIST_TARGET + (gic_irq(d) & ~3);
> -       unsigned int shift = (gic_irq(d) % 4) * 8;
> +       void __iomem *reg;
> +       unsigned int shift, step;
>         unsigned int cpu = cpumask_any_and(mask_val, cpu_online_mask);
>         u32 val, mask, bit;
> -
> -       if (cpu >= NR_GIC_CPU_IF || cpu >= nr_cpu_ids)
> +       if (cpu >= nr_gic_cpu_if || cpu >= nr_cpu_ids)
>                 return -EINVAL;
>
> +       step = BITS_PER_LONG / nr_gic_cpu_if;

NAK. This breaks arm64 in a very bad way. The GICD registers are always
32bit, nothing to do with the size of a long on a given CPU.

> +       shift = (gic_irq(d) % step) * nr_gic_cpu_if;
> +       reg = gic_dist_base(d) + GIC_DIST_TARGET + (gic_irq(d) / step * 4);
> +
>         raw_spin_lock(&irq_controller_lock);
> -       mask = 0xff << shift;
> +       mask = ((1 << nr_gic_cpu_if) - 1) << shift;
>         bit = gic_cpu_map[cpu] << shift;
>         val = readl_relaxed(reg) & ~mask;
>         writel_relaxed(val | bit, reg);

So, in the absence of any form of documentation, I'll guess:

GICD_ITARGETSRn has been modified to have 16bits per interrupt. Assuming
the GICD memory map stays the same, this means we now have a limit of
510 interrupts. Please reflect this limit in the init function.

> @@ -354,15 +360,17 @@ void __init gic_cascade_irq(unsigned int gic_nr, unsigned int irq)
>         irq_set_chained_handler(irq, gic_handle_cascade_irq);
>  }
>
> -static u8 gic_get_cpumask(struct gic_chip_data *gic)
> +static u16 gic_get_cpumask(struct gic_chip_data *gic)
>  {
>         void __iomem *base = gic_data_dist_base(gic);
> -       u32 mask, i;
> -
> -       for (i = mask = 0; i < 32; i += 4) {
> -               mask = readl_relaxed(base + GIC_DIST_TARGET + i);
> -               mask |= mask >> 16;
> -               mask |= mask >> 8;
> +       u32 mask, i, j, step;
> +
> +       /* get the number of CPU fields in GIC_DIST_TARGET register */
> +       step = BITS_PER_LONG / nr_gic_cpu_if;
> +       for (i = mask = 0; i < 32; i += step) {
> +               mask = readl_relaxed(base + GIC_DIST_TARGET + i / step * 4);
> +               for (j = BITS_PER_LONG >> 1; j >= nr_gic_cpu_if; j >>= 1)
> +                       mask |= mask >> j;

Again. All the uses of BITS_PER_LONG in this driver are completely
wrong. I'll stop commenting on that.

>                 if (mask)
>                         break;
>         }
> @@ -375,7 +383,7 @@ static u8 gic_get_cpumask(struct gic_chip_data *gic)
>
>  static void __init gic_dist_init(struct gic_chip_data *gic)
>  {
> -       unsigned int i;
> +       unsigned int i, step;
>         u32 cpumask;
>         unsigned int gic_irqs = gic->gic_irqs;
>         void __iomem *base = gic_data_dist_base(gic);
> @@ -392,10 +400,11 @@ static void __init gic_dist_init(struct gic_chip_data *gic)
>          * Set all global interrupts to this CPU only.
>          */
>         cpumask = gic_get_cpumask(gic);
> -       cpumask |= cpumask << 8;
> -       cpumask |= cpumask << 16;
> -       for (i = 32; i < gic_irqs; i += 4)
> -               writel_relaxed(cpumask, base + GIC_DIST_TARGET + i * 4 / 4);
> +       for (i = nr_gic_cpu_if; i < BITS_PER_LONG; i <<= 1)
> +               cpumask |= cpumask << i;
> +       step = BITS_PER_LONG / nr_gic_cpu_if;
> +       for (i = 32; i < gic_irqs; i += step)
> +               writel_relaxed(cpumask, base + GIC_DIST_TARGET + i / step * 4);
>
>         /*
>          * Set priority on all global interrupts.
> @@ -423,7 +432,7 @@ static void gic_cpu_init(struct gic_chip_data *gic)
>         /*
>          * Get what the GIC says our CPU mask is.
>          */
> -       BUG_ON(cpu >= NR_GIC_CPU_IF);
> +       BUG_ON(cpu >= nr_gic_cpu_if);
>         cpu_mask = gic_get_cpumask(gic);
>         gic_cpu_map[cpu] = cpu_mask;
>
> @@ -431,7 +440,7 @@ static void gic_cpu_init(struct gic_chip_data *gic)
>          * Clear our mask from the other map entries in case they're
>          * still undefined.
>          */
> -       for (i = 0; i < NR_GIC_CPU_IF; i++)
> +       for (i = 0; i < nr_gic_cpu_if; i++)
>                 if (i != cpu)
>                         gic_cpu_map[i] &= ~cpu_mask;
>
> @@ -469,7 +478,7 @@ static void gic_dist_save(unsigned int gic_nr)
>  {
>         unsigned int gic_irqs;
>         void __iomem *dist_base;
> -       int i;
> +       int i, step;
>
>         if (gic_nr >= MAX_GIC_NR)
>                 BUG();
> @@ -484,7 +493,8 @@ static void gic_dist_save(unsigned int gic_nr)
>                 gic_data[gic_nr].saved_spi_conf[i] =
>                         readl_relaxed(dist_base + GIC_DIST_CONFIG + i * 4);
>
> -       for (i = 0; i < DIV_ROUND_UP(gic_irqs, 4); i++)
> +       step = BITS_PER_LONG / nr_gic_cpu_if;
> +       for (i = 0; i < DIV_ROUND_UP(gic_irqs, step); i++)
>                 gic_data[gic_nr].saved_spi_target[i] =
>                         readl_relaxed(dist_base + GIC_DIST_TARGET + i * 4);
>
> @@ -503,7 +513,7 @@ static void gic_dist_save(unsigned int gic_nr)
>  static void gic_dist_restore(unsigned int gic_nr)
>  {
>         unsigned int gic_irqs;
> -       unsigned int i;
> +       unsigned int i, step;
>         void __iomem *dist_base;
>
>         if (gic_nr >= MAX_GIC_NR)
> @@ -525,7 +535,8 @@ static void gic_dist_restore(unsigned int gic_nr)
>                 writel_relaxed(0xa0a0a0a0,
>                         dist_base + GIC_DIST_PRI + i * 4);
>
> -       for (i = 0; i < DIV_ROUND_UP(gic_irqs, 4); i++)
> +       step = BITS_PER_LONG / nr_gic_cpu_if;
> +       for (i = 0; i < DIV_ROUND_UP(gic_irqs, step); i++)
>                 writel_relaxed(gic_data[gic_nr].saved_spi_target[i],
>                         dist_base + GIC_DIST_TARGET + i * 4);
>
> @@ -666,8 +677,8 @@ static void gic_raise_softirq(const struct cpumask *mask, unsigned int irq)
>         dmb(ishst);
>
>         /* this always happens on GIC0 */
> -       writel_relaxed(map << 16 | irq, gic_data_dist_base(&gic_data[0]) + GIC_DIST_SOFTINT);
> -
> +       writel_relaxed(map << (8 + 16 - nr_gic_cpu_if) | irq,
> +                      gic_data_dist_base(&gic_data[0]) + GIC_DIST_SOFTINT);

So you're writing the CPU target map into GICD_SGIR[23:8]. What happens
to the NSATT bit?

>         raw_spin_unlock_irqrestore(&irq_controller_lock, flags);
>  }
>  #endif
> @@ -681,7 +692,7 @@ static void gic_raise_softirq(const struct cpumask *mask, unsigned int irq)
>   */
>  void gic_send_sgi(unsigned int cpu_id, unsigned int irq)
>  {
> -       BUG_ON(cpu_id >= NR_GIC_CPU_IF);
> +       BUG_ON(cpu_id >= nr_gic_cpu_if);
>         cpu_id = 1 << cpu_id;
>         /* this always happens on GIC0 */
>         writel_relaxed((cpu_id << 16) | irq, gic_data_dist_base(&gic_data[0]) + GIC_DIST_SOFTINT);
> @@ -700,7 +711,7 @@ int gic_get_cpu_id(unsigned int cpu)
>  {
>         unsigned int cpu_bit;
>
> -       if (cpu >= NR_GIC_CPU_IF)
> +       if (cpu >= nr_gic_cpu_if)
>                 return -1;
>         cpu_bit = gic_cpu_map[cpu];
>         if (cpu_bit & (cpu_bit - 1))
> @@ -971,8 +982,8 @@ void __init gic_init_bases(unsigned int gic_nr, int irq_start,
>          * Initialize the CPU interface map to all CPUs.
>          * It will be refined as each CPU probes its ID.
>          */
> -       for (i = 0; i < NR_GIC_CPU_IF; i++)
> -               gic_cpu_map[i] = 0xff;
> +       for (i = 0; i < nr_gic_cpu_if; i++)
> +               gic_cpu_map[i] = (1 << MAX_NR_GIC_CPU_IF) - 1;
>
>         /*
>          * For primary GICs, skip over SGIs.
> @@ -1047,6 +1058,10 @@ gic_of_init(struct device_node *node, struct device_node *parent)
>         if (WARN_ON(!node))
>                 return -ENODEV;
>
> +       /* HiP04 supports 16 CPUs at most */
> +       if (of_device_is_compatible(node, "hisilicon,hip04-gic"))
> +               nr_gic_cpu_if = 16;
> +

Consider using a separate init function that will simply override this
value, rather than having a test in the generic code.

>         dist_base = of_iomap(node, 0);
>         WARN(!dist_base, "unable to map gic dist registers\n");
>
> @@ -1069,6 +1084,7 @@ gic_of_init(struct device_node *node, struct device_node *parent)
>  }
>  IRQCHIP_DECLARE(cortex_a15_gic, "arm,cortex-a15-gic", gic_of_init);
>  IRQCHIP_DECLARE(cortex_a9_gic, "arm,cortex-a9-gic", gic_of_init);
> +IRQCHIP_DECLARE(hip04_gic, "hisilicon,hip04-gic", gic_of_init);
>  IRQCHIP_DECLARE(msm_8660_qgic, "qcom,msm-8660-qgic", gic_of_init);
>  IRQCHIP_DECLARE(msm_qgic2, "qcom,msm-qgic2", gic_of_init);

General question: How does this work with virtualisation?
- Does your GICV interface also refect the changes you've made to GICC?
- Do your GICH_LRn registers reflect the changes to GICD_SGIR (can't
really see where you'd shove all the bits, but asking anyway)?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny.
