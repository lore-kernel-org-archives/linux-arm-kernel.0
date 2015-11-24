From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Tue, 24 Nov 2015 11:54:42 +0000
Subject: [Xen-devel] [PATCH v3 26/62] arm/gic-v2: Add ACPI boot support
 for GICv2
In-Reply-To: <1447753261-7552-27-git-send-email-shannon.zhao@linaro.org>
References: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
 <1447753261-7552-27-git-send-email-shannon.zhao@linaro.org>
Message-ID: <alpine.DEB.2.02.1511241138500.1107@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 17 Nov 2015, shannon.zhao at linaro.org wrote:
> From: Parth Dixit <parth.dixit@linaro.org>
> 
> ACPI on Xen hypervisor uses MADT table for proper GIC initialization.
> First get the GIC version from GIC Distributor. Then parse GIC related
> subtables, collect CPU interface and distributor addresses and call
> driver initialization function (which is hardware abstraction agnostic).
> In a similar way, FDT initialize GICv2.
> 
> Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> Signed-off-by: Naresh Bhat <naresh.bhat@linaro.org>
> Signed-off-by: Parth Dixit <parth.dixit@linaro.org>
> Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
> ---
>  xen/arch/arm/gic-v2.c | 122 +++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 121 insertions(+), 1 deletion(-)
> 
> diff --git a/xen/arch/arm/gic-v2.c b/xen/arch/arm/gic-v2.c
> index e31d38e..9a9fcd5 100644
> --- a/xen/arch/arm/gic-v2.c
> +++ b/xen/arch/arm/gic-v2.c
> @@ -29,6 +29,8 @@
>  #include <xen/device_tree.h>
>  #include <xen/libfdt/libfdt.h>
>  #include <xen/sizes.h>
> +#include <xen/acpi.h>
> +#include <acpi/actables.h>
>  #include <asm/p2m.h>
>  #include <asm/domain.h>
>  #include <asm/platform.h>
> @@ -36,6 +38,7 @@
>  
>  #include <asm/io.h>
>  #include <asm/gic.h>
> +#include <asm/acpi.h>
>  
>  /*
>   * LR register definitions are GIC v2 specific.
> @@ -681,11 +684,113 @@ static void __init dt_gicv2_init(void)
>                 csize, vsize);
>  }
>  
> +#ifdef CONFIG_ACPI
> +static int __init
> +gic_acpi_parse_madt_cpu(struct acpi_subtable_header *header,
> +                        const unsigned long end)
> +{
> +    static int cpu_base_assigned = 0;
> +    struct acpi_madt_generic_interrupt *processor;
> +
> +    processor = (struct acpi_madt_generic_interrupt *)header;

Use container_of to cast


> +    if ( BAD_MADT_ENTRY(processor, end) )
> +        return -EINVAL;
> +
> +    /* Read from APIC table and fill up the GIC variables */
> +    if ( cpu_base_assigned == 0 )
> +    {
> +        cbase = processor->base_address;
> +        csize = SZ_8K;
> +        hbase = processor->gich_base_address;
> +        vbase = processor->gicv_base_address;
> +        gicv2_info.maintenance_irq = processor->vgic_interrupt;
> +
> +        if( processor->flags & ACPI_MADT_VGIC_IRQ_MODE )
> +            irq_set_type(gicv2_info.maintenance_irq, ACPI_IRQ_TYPE_EDGE_BOTH);
> +        else
> +            irq_set_type(gicv2_info.maintenance_irq, ACPI_IRQ_TYPE_LEVEL_MASK);
> +
> +	cpu_base_assigned = 1;

coding style


> +    }
> +    else
> +    {
> +        if ( cbase != processor->base_address
> +             || hbase != processor->gich_base_address
> +             || vbase != processor->gicv_base_address
> +             || gicv2_info.maintenance_irq != processor->vgic_interrupt )
> +        {
> +	    printk("GICv2: GICC entries are not same in MADT table\n");
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

Same here.

It looks OK aside from these few things.


> +    if ( BAD_MADT_ENTRY(dist, end) )
> +        return -EINVAL;
> +
> +    dbase = dist->base_address;
> +
> +    return 0;
> +}
> +
> +static void __init acpi_gicv2_init(void)
> +{
> +    acpi_status status;
> +    struct acpi_table_header *table;
> +    int count;
> +
> +    status = acpi_get_table(ACPI_SIG_MADT, 0, &table);
> +
> +    if ( ACPI_FAILURE(status) )
> +    {
> +        const char *msg = acpi_format_exception(status);
> +
> +        panic("GICv2: Failed to get MADT table, %s", msg);
> +    }
> +
> +    /* Collect CPU base addresses */
> +    count = acpi_parse_entries(ACPI_SIG_MADT, sizeof(struct acpi_table_madt),
> +                               gic_acpi_parse_madt_cpu, table,
> +                               ACPI_MADT_TYPE_GENERIC_INTERRUPT, 0);
> +    if ( count <= 0 )
> +        panic("GICv2: No valid GICC entries exists");
> +
> +    /*
> +     * Find distributor base address. We expect one distributor entry since
> +     * ACPI 5.0 spec neither support multi-GIC instances nor GIC cascade.
> +     */
> +    count = acpi_parse_entries(ACPI_SIG_MADT, sizeof(struct acpi_table_madt),
> +                               gic_acpi_parse_madt_distributor, table,
> +                               ACPI_MADT_TYPE_GENERIC_DISTRIBUTOR, 0);
> +    if ( count <= 0 )
> +        panic("GICv2: No valid GICD entries exists");
> +}
> +#else
> +static void __init acpi_gicv2_init(void)
> +{
> +/* Should never reach here */
> +}
> +#endif
> +
>  static int __init gicv2_init(void)
>  {
>      uint32_t aliased_offset = 0;
>  
> -    dt_gicv2_init();
> +    if( acpi_disabled )
> +        dt_gicv2_init();
> +    else
> +        acpi_gicv2_init();
>  
>      printk("GICv2 initialization:\n"
>                "        gic_dist_addr=%"PRIpaddr"\n"
> @@ -793,6 +898,21 @@ DT_DEVICE_START(gicv2, "GICv2", DEVICE_GIC)
>          .init = dt_gicv2_preinit,
>  DT_DEVICE_END
>  
> +#ifdef CONFIG_ACPI
> +/* Set up the GIC */
> +static int __init acpi_gicv2_preinit(const void *data)
> +{
> +    gicv2_info.hw_version = GIC_V2;
> +    register_gic_ops(&gicv2_ops);
> +
> +    return 0;
> +}
> +
> +ACPI_DEVICE_START(agicv2, "GICv2", DEVICE_GIC)
> +        .class_type = GIC_V2,
> +        .init = acpi_gicv2_preinit,
> +ACPI_DEVICE_END
> +#endif
>  /*
>   * Local variables:
>   * mode: C
