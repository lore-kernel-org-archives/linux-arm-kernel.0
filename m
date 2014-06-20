From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 20 Jun 2014 11:02:24 +0100
Subject: [PATCH v5 02/20] arm64: initial support for GICv3
In-Reply-To: <1403169583-13668-3-git-send-email-marc.zyngier@arm.com>
References: <1403169583-13668-1-git-send-email-marc.zyngier@arm.com>
 <1403169583-13668-3-git-send-email-marc.zyngier@arm.com>
Message-ID: <20140620100224.GC30188@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

I have some minor comments below.

On Thu, Jun 19, 2014 at 10:19:25AM +0100, Marc Zyngier wrote:
> The Generic Interrupt Controller (version 3) offers services that are
> similar to GICv2, with a number of additional features:
> - Affinity routing based on the CPU MPIDR (ARE)
> - System register for the CPU interfaces (SRE)
> - Support for more that 8 CPUs
> - Locality-specific Peripheral Interrupts (LPIs)
> - Interrupt Translation Services (ITS)
>
> This patch adds preliminary support for GICv3 with ARE and SRE,
> non-secure mode only. It relies on higher exception levels to grant ARE
> and SRE access.
>
> Support for LPI and ITS will be added at a later time.
>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Reviewed-by: Zi Shen Lim <zlim@broadcom.com>
> Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
> Reviewed-by: Tirumalesh Chalamarla <tchalamarla@cavium.com>
> Reviewed-by: Yun Wu <wuyun.wu@huawei.com>
> Reviewed-by: Zhen Lei <thunder.leizhen@huawei.com>
> Tested-by: Tirumalesh Chalamarla<tchalamarla@cavium.com>
> Tested-by: Radha Mohan Chintakuntla <rchintakuntla@cavium.com>
> Acked-by: Radha Mohan Chintakuntla <rchintakuntla@cavium.com>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm64/Kconfig                 |   1 +
>  arch/arm64/kernel/head.S           |  18 +
>  arch/arm64/kernel/hyp-stub.S       |   1 +
>  drivers/irqchip/Kconfig            |   5 +
>  drivers/irqchip/Makefile           |   1 +
>  drivers/irqchip/irq-gic-v3.c       | 690 +++++++++++++++++++++++++++++++++++++
>  include/linux/irqchip/arm-gic-v3.h | 193 +++++++++++
>  7 files changed, 909 insertions(+)
>  create mode 100644 drivers/irqchip/irq-gic-v3.c
>  create mode 100644 include/linux/irqchip/arm-gic-v3.h

[...]

> +#ifdef CONFIG_ARM_GIC_V3
> +       /* GICv3 system register access */
> +       mrs     x0, id_aa64pfr0_el1
> +       ubfx    x0, x0, #24, #4
> +       cmp     x0, #1
> +       b.ne    3f
> +
> +       mrs     x0, ICC_SRE_EL2
> +       orr     x0, x0, #1                      // Set ICC_SRE_EL2.SRE==1
> +       orr     x0, x0, #(1 << 3)               // Set ICC_SRE_EL2.Enable==1

Could we use macros for these constants?

We already seem to have ICC_SRE_EL2_ENABLE in arm-gic-v3.h, so we'd just
need to add ICC_SRE_EL2_SRE.

The ubfx on the id_aa64pfr0_el1 value probably can't be made nicer with
macros, but I guess we can't have everything.

[...]

> +#define DEFAULT_PMR_VALUE      0xf0

Is this an arbitrary value, or chosen for a particular reason? Could we
have a comment either way?

> +static void gic_do_wait_for_rwp(void __iomem *base)
> +{
> +       u32 count = 1000000;    /* 1s! */

I would suggest using USEC_PER_SEC, but it looks like to do so you'd
need to pull in all of <linux/time.h>, so I guess that's not worthwhile.

> +
> +       while (readl_relaxed(base + GICD_CTLR) & GICD_CTLR_RWP) {
> +               count--;
> +               if (!count) {
> +                       pr_err_ratelimited("RWP timeout, gone fishing\n");
> +                       return;
> +               }
> +               cpu_relax();
> +               udelay(1);
> +       };
> +}

[...]

> +/*
> + * Routines to acknowledge, disable and enable interrupts
> + */

This comment looks out of sync with the code; gic_read_iar was earlier.

[...]

> +static u64 gic_mpidr_to_affinity(u64 mpidr)
> +{
> +       u64 aff;
> +
> +       aff = (MPIDR_AFFINITY_LEVEL(mpidr, 3) << 32 |
> +              MPIDR_AFFINITY_LEVEL(mpidr, 2) << 16 |
> +              MPIDR_AFFINITY_LEVEL(mpidr, 1) << 8  |
> +              MPIDR_AFFINITY_LEVEL(mpidr, 0)) & ~GICD_IROUTER_SPI_MODE_ANY;

Surely GICD_IROUTER_SPI_MODE_ANY (bit 31) can't ever be set by the rest
of the expression above? Or am I being thick?

[...]

> +static asmlinkage void __exception_irq_entry gic_handle_irq(struct pt_regs *regs)
> +{
> +       u64 irqnr;
> +
> +       do {
> +               irqnr = gic_read_iar();
> +
> +               if (likely(irqnr > 15 && irqnr < 1020)) {
> +                       u64 irq = irq_find_mapping(gic_data.domain, irqnr);
> +                       if (likely(irq)) {
> +                               handle_IRQ(irq, regs);
> +                               continue;
> +                       }
> +
> +                       WARN_ONCE(true, "Unexpected SPI received!\n");
> +                       gic_write_eoir(irqnr);
> +               }
> +               if (irqnr < 16) {
> +                       gic_write_eoir(irqnr);
> +#ifdef CONFIG_SMP
> +                       handle_IPI(irqnr, regs);
> +#else
> +                       WARN_ONCE(true, "Unexpected SGI received!\n");
> +#endif
> +                       continue;
> +               }
> +       } while (irqnr != 0x3ff);

Any chance we could have a GIC_IRQNR_SPURIOUS macro or similar?

[...]

> +static void __init gic_dist_init(void)
> +{
> +       unsigned int i;
> +       u64 affinity;
> +       void __iomem *base = gic_data.dist_base;
> +
> +       /* Disable the distributor */
> +       writel_relaxed(0, base + GICD_CTLR);
> +       gic_dist_wait_for_rwp();
> +
> +       gic_dist_config(base, gic_data.irq_nr, gic_dist_wait_for_rwp);
> +
> +       /* Enable distributor with ARE, Group1 */
> +       writel_relaxed(GICD_CTLR_ARE_NS | GICD_CTLR_ENABLE_G1A | GICD_CTLR_ENABLE_G1,
> +                      base + GICD_CTLR);
> +
> +       /*
> +        * Set all global interrupts to the boot CPU only. ARE must be
> +        * enabled.
> +        */
> +       affinity = gic_mpidr_to_affinity(cpu_logical_map(smp_processor_id()));
> +       for (i = 32; i < gic_data.irq_nr; i++)
> +               writeq_relaxed(affinity, base + GICD_IROUTER + i * 8);
> +} +

I assume completion of the GICD_IROUTER writes is guaranteed elsewhere?

> +static int gic_populate_rdist(void)
> +{
> +       u64 mpidr = cpu_logical_map(smp_processor_id());
> +       u64 typer;
> +       u32 aff;
> +       int i;
> +
> +       /*
> +        * Convert affinity to a 32bit value that can be matched to
> +        * GICR_TYPER bits [63:32].
> +        */
> +       aff = (MPIDR_AFFINITY_LEVEL(mpidr, 3) << 24 |
> +              MPIDR_AFFINITY_LEVEL(mpidr, 2) << 16 |
> +              MPIDR_AFFINITY_LEVEL(mpidr, 1) << 8 |
> +              MPIDR_AFFINITY_LEVEL(mpidr, 0));
> +
> +       for (i = 0; i < gic_data.redist_regions; i++) {
> +               void __iomem *ptr = gic_data.redist_base[i];
> +               u32 reg;
> +
> +               reg = readl_relaxed(ptr + GICR_PIDR2) & GIC_PIDR2_ARCH_MASK;
> +               if (reg != 0x30 && reg != 0x40) { /* We're in trouble... */
> +                       pr_warn("No redistributor present @%p\n", ptr);
> +                       break;
> +               }

What are these magic numbers?

[...]

> +static int __init gic_of_init(struct device_node *node, struct device_node *parent)
> +{
> +       void __iomem *dist_base;
> +       void __iomem **redist_base;
> +       u64 redist_stride;
> +       u32 redist_regions;
> +       u32 reg;
> +       int gic_irqs;
> +       int err;
> +       int i;
> +
> +       dist_base = of_iomap(node, 0);
> +       if (!dist_base) {
> +               pr_err("%s: unable to map gic dist registers\n",
> +                       node->full_name);
> +               return -ENXIO;
> +       }
> +
> +       reg = readl_relaxed(dist_base + GICD_PIDR2) & GIC_PIDR2_ARCH_MASK;
> +       if (reg != 0x30 && reg != 0x40) {
> +               pr_err("%s: no distributor detected, giving up\n",
> +                       node->full_name);
> +               err = -ENODEV;
> +               goto out_unmap_dist;
> +       }

The magic numbers strike again...

Cheers,
Mark.
