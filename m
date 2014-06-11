From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 11 Jun 2014 17:16:05 +0100
Subject: [PATCH v4 02/20] arm64: initial support for GICv3
In-Reply-To: <CALicx6vz6JZsMDmEVUMarsTd67xK1r+HjVTD0Jg94U6LD9bk3w@mail.gmail.com>
References: <CALicx6vz6JZsMDmEVUMarsTd67xK1r+HjVTD0Jg94U6LD9bk3w@mail.gmail.com>
Message-ID: <539880C5.6020203@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vijay,

On 11/06/14 16:52, Vijay Kilari wrote:
>  Hi Marc,
> 
> [...]
>> +
>> +static void gic_write_pmr(u64 val)
>> +{
>> +       asm volatile("msr " __stringify(ICC_PMR_EL1) ", %0" : : "r" (val));
>> +}
>> +
>> +static void gic_write_ctlr(u64 val)
>> +{
>> +       asm volatile("msr " __stringify(ICC_CTLR_EL1) ", %0" : : "r" (val));
>> +       isb();
>> +}
>> +
>> +static void gic_write_grpen1(u64 val)
>> +{
>> +       asm volatile("msr " __stringify(ICC_GRPEN1_EL1) ", %0" : : "r" (val));
>> +       isb();
> 
>  As per 4.4.11 of PRD03-GENC-010745 17.0 specification

First thing (not relevant to your question), I'd suggest you upgrade to
a *recent* version of the spec.

> execution of DSB after write to ICC_{PMR,IAR, EOI, IGRPEN} etc will
> ensure the observability of GIC register access. However here you are using
> isb(). Is that ok?

I think it depends whether or not you want all effects to be
synchronously observable in the whole system. We already have barriers
on exception returns that will ensure the observability of all these.
Adding them on a per access basis is likely to degrade performance.

>> +}
> [...]
> 
>> +static int gic_populate_rdist(void)
>> +{
>> +       u64 mpidr = cpu_logical_map(smp_processor_id());
>> +       u64 typer;
>> +       u32 aff;
>> +       int i;
>> +
>> +       /*
>> +        * Convert affinity to a 32bit value that can be matched to
>> +        * GICR_TYPER bits [63:32].
>> +        */
>> +       aff = (MPIDR_AFFINITY_LEVEL(mpidr, 3) << 24 |
>> +              MPIDR_AFFINITY_LEVEL(mpidr, 2) << 16 |
>> +              MPIDR_AFFINITY_LEVEL(mpidr, 1) << 8 |
>> +              MPIDR_AFFINITY_LEVEL(mpidr, 0));
>> +
>> +       for (i = 0; i < gic_data.redist_regions; i++) {
>> +               void __iomem *ptr = gic_data.redist_base[i];
>> +               u32 reg;
>> +
>> +               reg = readl_relaxed(ptr + GICR_PIDR2) & GIC_PIDR2_ARCH_MASK;
>> +               if (reg != 0x30 && reg != 0x40) { /* We're in trouble... */
>> +                       pr_warn("No redistributor present @%p\n", ptr);
>> +                       break;
>> +               }
>> +
>> +               do {
>> +                       typer = readq_relaxed(ptr + GICR_TYPER);
>> +                       if ((typer >> 32) == aff) {
>> +                               gic_data_rdist_rd_base() = ptr;
>> +                               pr_info("CPU%d: found redistributor %llx @%p\n",
>> +                                       smp_processor_id(),
>> +                                       (unsigned long long)mpidr, ptr);
>> +                               return 0;
>> +                       }
>> +
>> +                       if (gic_data.redist_stride) {
>> +                               ptr += gic_data.redist_stride;
>> +                       } else {
>> +                               ptr += SZ_64K * 2; /* Skip RD_base + SGI_base */
>> +                               if (typer & GICR_TYPER_VLPIS)
>> +                                       ptr += SZ_64K * 2; /* Skip VLPI_base + reserved page */
>> +                       }
>> +               } while (!(typer & GICR_TYPER_LAST));
>> +       }
>> +
> [...]
> 
>> +
> [...]
>> +
>> +static int __init gic_of_init(struct device_node *node, struct device_node *parent)
>> +{
>> +       void __iomem *dist_base;
>> +       void __iomem **redist_base;
>> +       u64 redist_stride;
>> +       u32 redist_regions;
>> +       u32 reg;
>> +       int gic_irqs;
>> +       int err;
>> +       int i;
>> +
>> +       dist_base = of_iomap(node, 0);
>> +       if (!dist_base) {
>> +               pr_err("%s: unable to map gic dist registers\n",
>> +                       node->full_name);
>> +               return -ENXIO;
>> +       }
>> +
>> +       reg = readl_relaxed(dist_base + GICD_PIDR2) & GIC_PIDR2_ARCH_MASK;
>> +       if (reg != 0x30 && reg != 0x40) {
>> +               pr_err("%s: no distributor detected, giving up\n",
>> +                       node->full_name);
>> +               err = -ENODEV;
>> +               goto out_unmap_dist;
>> +       }
>> +
>> +       if (of_property_read_u32(node, "#redistributor-regions", &redist_regions))
>> +               redist_regions = 1;
>> +
>> +       redist_base = kzalloc(sizeof(*redist_base) * redist_regions, GFP_KERNEL);
>> +       if (!redist_base) {
>> +               err = -ENOMEM;
>> +               goto out_unmap_dist;
>> +       }
>> +
>> +       for (i = 0; i < redist_regions; i++) {
>> +               redist_base[i] = of_iomap(node, 1 + i);
>> +               if (!redist_base[i]) {
>> +                       pr_err("%s: couldn't map region %d\n",
>> +                              node->full_name, i);
>> +                       err = -ENODEV;
>> +                       goto out_unmap_rdist;
>> +               }
>> +       }
>> +
>> +       if (of_property_read_u64(node, "redistributor-stride", &redist_stride))
>> +               redist_stride = 0;
> 
> why can't redist_stride be set to 2 * SZ_64K by default if redist_stride is not
> available in dt? Because in populate_redist() if stride is set to 0,
> the redistributor search
>  pointer is incremented by 2 * SZ_64K?

Because redist_stride is supposed to give you the absolute stride,
irrespective of the GIC implementing VLPIs or not.

If you read again the code in populate_redist(), you'll see that the
default (with redist_stride == 0) is to adapt to what TYPER says about
the features your GIC supports.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
