From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Tue, 24 Nov 2015 12:00:15 +0000
Subject: [Xen-devel] [PATCH v3 27/62] arm/gic-v3: Add ACPI boot support
 for GICv3
In-Reply-To: <1447753261-7552-28-git-send-email-shannon.zhao@linaro.org>
References: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
 <1447753261-7552-28-git-send-email-shannon.zhao@linaro.org>
Message-ID: <alpine.DEB.2.02.1511241157370.1107@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 17 Nov 2015, shannon.zhao at linaro.org wrote:
> From: Shannon Zhao <shannon.zhao@linaro.org>
> 
> Like GICv2, ACPI on Xen hypervisor uses MADT table for proper GICv3
> initialization. Parse GIC distributor subtable, redistributor subtable
> and interrupt subtable.
> 
> Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
> ---
>  xen/arch/arm/gic-v3.c | 182 +++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 181 insertions(+), 1 deletion(-)
> 
> diff --git a/xen/arch/arm/gic-v3.c b/xen/arch/arm/gic-v3.c
> index bd13010..fa732d7 100644
> --- a/xen/arch/arm/gic-v3.c
> +++ b/xen/arch/arm/gic-v3.c
> @@ -34,6 +34,8 @@
>  #include <xen/sizes.h>
>  #include <xen/libfdt/libfdt.h>
>  #include <xen/sort.h>
> +#include <xen/acpi.h>
> +#include <acpi/actables.h>
>  #include <asm/p2m.h>
>  #include <asm/domain.h>
>  #include <asm/io.h>
> @@ -41,6 +43,7 @@
>  #include <asm/gic.h>
>  #include <asm/gic_v3_defs.h>
>  #include <asm/cpufeature.h>
> +#include <asm/acpi.h>
>  
>  /* Global state */
>  static struct {
> @@ -1242,6 +1245,164 @@ static void __init dt_gicv3_init(void)
>      }
>  }
>  
> +#ifdef CONFIG_ACPI
> +static int __init
> +gic_acpi_parse_madt_cpu(struct acpi_subtable_header *header,
> +                        const unsigned long end)
> +{
> +    static bool cpu_base_assigned = false;
> +    struct acpi_madt_generic_interrupt *processor;
> +
> +    processor = (struct acpi_madt_generic_interrupt *)header;
> +
> +    if ( BAD_MADT_ENTRY(processor, end) )
> +        return -EINVAL;
> +
> +    /* Read from APIC table and fill up the GIC variables */
> +    if ( !cpu_base_assigned )
> +    {
> +        cbase = processor->base_address;
> +        csize = SZ_8K;
> +        vbase = processor->gicv_base_address;
> +        gicv3_info.maintenance_irq = processor->vgic_interrupt;
> +
> +        if( processor->flags & ACPI_MADT_VGIC_IRQ_MODE )
> +            irq_set_type(gicv3_info.maintenance_irq, ACPI_IRQ_TYPE_EDGE_BOTH);
> +        else
> +            irq_set_type(gicv3_info.maintenance_irq, ACPI_IRQ_TYPE_LEVEL_MASK);
> +
> +	cpu_base_assigned = true;

coding style


> +    }
> +    else
> +    {
> +        if ( cbase != processor->base_address
> +             || vbase != processor->gicv_base_address
> +             || gicv3_info.maintenance_irq != processor->vgic_interrupt )
> +        {
> +	    printk("GICv3: GICC entries are not same in MADT table\n");
> +	    return -EINVAL;

coding style


> +        }
> +    }
> +
> +    return 0;
> +}
> +
> +static int __init
> +gic_acpi_parse_madt_distributor(struct acpi_subtable_header *header,
> +                                const unsigned long end)
> +{
> +    struct acpi_madt_generic_distributor *dist;
> +
> +    dist = (struct acpi_madt_generic_distributor *)header;
> +
> +    if ( BAD_MADT_ENTRY(dist, end) )
> +        return -EINVAL;
> +
> +    dbase = dist->base_address;
> +
> +    return 0;
> +}
> +static int __init
> +gic_acpi_get_madt_redistributor_num(struct acpi_subtable_header *header,
> +                                    const unsigned long end)
> +{
> +    return 0;

I think you should at least add a comment here to explain why we just
return 0 in this case


> +}
> +
> +static void __init acpi_gicv3_init(void)
> +{
> +    struct acpi_table_header *table;
> +    struct rdist_region *rdist_regs;
> +    acpi_status status;
> +    int count, i;
> +    uint32_t reg;
> +
> +    status = acpi_get_table(ACPI_SIG_MADT, 0, &table);
> +
> +    if ( ACPI_FAILURE(status) )
> +    {
> +        const char *msg = acpi_format_exception(status);
> +
> +        panic("GICv3: Failed to get MADT table, %s", msg);
> +    }
> +
> +    /*
> +     * Find distributor base address. We expect one distributor entry since
> +     * ACPI 5.0 spec neither support multi-GIC instances nor GIC cascade.
> +     */
> +    count = acpi_parse_entries(ACPI_SIG_MADT, sizeof(struct acpi_table_madt),
> +                               gic_acpi_parse_madt_distributor, table,
> +                               ACPI_MADT_TYPE_GENERIC_DISTRIBUTOR, 0);
> +
> +    if ( count <= 0 )
> +        panic("GICv3: No valid GICD entries exists");
> +
> +    if ( (dbase & ~PAGE_MASK) )
> +        panic("GICv3: Found unaligned distributor address %"PRIpaddr"",
> +              dbase);
> +
> +    gicv3.map_dbase = ioremap_nocache(dbase, SZ_64K);
> +    if ( !gicv3.map_dbase )
> +        panic("GICv3: Failed to ioremap for GIC distributor\n");
> +
> +    reg = readl_relaxed(GICD + GICD_PIDR2) & GIC_PIDR2_ARCH_MASK;
> +    if ( reg != GIC_PIDR2_ARCH_GICv3 )
> +         panic("GICv3: no distributor detected\n");

I think these should be moved to a common init function


> +    /* Get number of redistributor */
> +    count = acpi_parse_entries(ACPI_SIG_MADT, sizeof(struct acpi_table_madt),
> +                               gic_acpi_get_madt_redistributor_num, table,
> +                               ACPI_MADT_TYPE_GENERIC_REDISTRIBUTOR, 0);
> +    if ( count <= 0 )
> +        panic("GICv3: No valid GICR entries exists");
> +
> +    gicv3.rdist_count = count;
> +
> +    if ( gicv3.rdist_count > MAX_RDIST_COUNT )
> +        panic("GICv3: Number of redistributor regions is more than"
> +              "%d (Increase MAX_RDIST_COUNT!!)\n", MAX_RDIST_COUNT);
> +
> +    rdist_regs = xzalloc_array(struct rdist_region, gicv3.rdist_count);
> +    if ( !rdist_regs )
> +        panic("GICv3: Failed to allocate memory for rdist regions\n");
> +
> +    for ( i = 0; i < gicv3.rdist_count; i++ )
> +    {
> +        struct acpi_subtable_header *subtable;
> +        struct acpi_madt_generic_redistributor *gic_rdist;
> +
> +        subtable = acpi_get_entry(ACPI_SIG_MADT, sizeof(struct acpi_table_madt),
> +                                  table, ACPI_MADT_TYPE_GENERIC_REDISTRIBUTOR,
> +                                  i);
> +        if ( !subtable )
> +            panic("GICv3: Can't get GICR entry");
> +
> +	gic_rdist = (struct acpi_madt_generic_redistributor *)subtable;

coding style


> +        rdist_regs[i].base = gic_rdist->base_address;
> +        rdist_regs[i].size = gic_rdist->length;
> +    }
> +
> +    /* The vGIC code requires the region to be sorted */
> +    sort(rdist_regs, gicv3.rdist_count, sizeof(*rdist_regs), cmp_rdist, NULL);
> +
> +    gicv3.rdist_regions= rdist_regs;
> +
> +    /* Collect CPU base addresses */
> +    count = acpi_parse_entries(ACPI_SIG_MADT, sizeof(struct acpi_table_madt),
> +                               gic_acpi_parse_madt_cpu, table,
> +                               ACPI_MADT_TYPE_GENERIC_INTERRUPT, 0);
> +    if ( count <= 0 )
> +        panic("GICv3: No valid GICC entries exists");
> +
> +    gicv3.rdist_stride = 0;
> +}
> +#else
> +static void __init acpi_gicv3_init(void)
> +{
> +/* Should never reach here */
> +}
> +#endif
> +
>  /* Set up the GIC */
>  static int __init gicv3_init(void)
>  {
> @@ -1253,7 +1414,10 @@ static int __init gicv3_init(void)
>          return -ENODEV;
>      }
>  
> -    dt_gicv3_init();
> +    if( acpi_disabled )
> +        dt_gicv3_init();
> +    else
> +        acpi_gicv3_init();
>  
>      for ( i = 0; i < gicv3.rdist_count; i++ )
>      {
> @@ -1345,6 +1509,22 @@ DT_DEVICE_START(gicv3, "GICv3", DEVICE_GIC)
>          .init = dt_gicv3_preinit,
>  DT_DEVICE_END
>  
> +#ifdef CONFIG_ACPI
> +/* Set up the GIC */
> +static int __init acpi_gicv3_preinit(const void *data)
> +{
> +    gicv3_info.hw_version = GIC_V3;
> +    register_gic_ops(&gicv3_ops);
> +
> +    return 0;
> +}
> +
> +ACPI_DEVICE_START(agicv3, "GICv3", DEVICE_GIC)
> +        .class_type = GIC_V3,
> +        .init = acpi_gicv3_preinit,
> +ACPI_DEVICE_END
> +#endif
> +
>  /*
>   * Local variables:
>   * mode: C
> -- 
> 2.1.0
> 
> 
> _______________________________________________
> Xen-devel mailing list
> Xen-devel at lists.xen.org
> http://lists.xen.org/xen-devel
> 
