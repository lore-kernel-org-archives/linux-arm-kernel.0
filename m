From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Thu, 26 Nov 2015 12:10:08 +0000
Subject: [PATCH v3 28/62] arm/gic: Add ACPI support for GIC preinit
In-Reply-To: <1447753261-7552-29-git-send-email-shannon.zhao@linaro.org>
References: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
 <1447753261-7552-29-git-send-email-shannon.zhao@linaro.org>
Message-ID: <alpine.DEB.2.02.1511261209220.1107@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 17 Nov 2015, shannon.zhao at linaro.org wrote:
> From: Shannon Zhao <shannon.zhao@linaro.org>
> 
> Since ACPI 6.0 defines that GIC Distributor Structure contains the GIC
> version filed, it could get GIC version from that. According to the
> version, call different preinit functions.
> 
> Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
> ---
>  xen/arch/arm/gic.c | 55 ++++++++++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 51 insertions(+), 4 deletions(-)
> 
> diff --git a/xen/arch/arm/gic.c b/xen/arch/arm/gic.c
> index 1e1e5ba..ac82588 100644
> --- a/xen/arch/arm/gic.c
> +++ b/xen/arch/arm/gic.c
> @@ -27,6 +27,7 @@
>  #include <xen/softirq.h>
>  #include <xen/list.h>
>  #include <xen/device_tree.h>
> +#include <xen/acpi.h>
>  #include <asm/p2m.h>
>  #include <asm/domain.h>
>  #include <asm/platform.h>
> @@ -34,6 +35,7 @@
>  #include <asm/io.h>
>  #include <asm/gic.h>
>  #include <asm/vgic.h>
> +#include <asm/acpi.h>
>  
>  static void gic_restore_pending_irqs(struct vcpu *v);
>  
> @@ -228,10 +230,7 @@ int gic_irq_xlate(const u32 *intspec, unsigned int intsize,
>      return 0;
>  }
>  
> -/* Find the interrupt controller and set up the callback to translate
> - * device tree IRQ.
> - */
> -void __init gic_preinit(void)
> +void __init dt_gic_preinit(void)
>  {
>      int rc;
>      struct dt_device_node *node;
> @@ -261,6 +260,54 @@ void __init gic_preinit(void)
>      dt_device_set_used_by(node, DOMID_XEN);
>  }
>  
> +#ifdef CONFIG_ACPI
> +static void __init acpi_gic_preinit(void)
> +{
> +    int rc = 0;
> +    acpi_status status;
> +    struct acpi_table_header *table;
> +    struct acpi_subtable_header * subtable;
> +    struct acpi_madt_generic_distributor *dist;
> +
> +    status = acpi_get_table(ACPI_SIG_MADT, 0, &table);
> +    if ( ACPI_FAILURE(status) )
> +    {
> +        const char *msg = acpi_format_exception(status);
> +
> +        panic("Failed to get MADT table, %s", msg);
> +    }
> +
> +    subtable = acpi_get_entry(ACPI_SIG_MADT, sizeof(struct acpi_table_madt),
> +                              table, ACPI_MADT_TYPE_GENERIC_DISTRIBUTOR, 0);
> +    if ( !subtable )
> +        panic("No valid GICD entries exists");
> +
> +    dist = (struct acpi_madt_generic_distributor *)subtable;
> +
> +    if ( dist->version == ACPI_MADT_GIC_VERSION_V2 )
> +        rc = acpi_device_init(DEVICE_GIC, NULL, GIC_V2);
> +    else if ( dist->version == ACPI_MADT_GIC_VERSION_V3 )
> +        rc = acpi_device_init(DEVICE_GIC, NULL, GIC_V3);

I agree with your suggestion and Julien's previous comment. Something like:

ACPI_DEVICE_START(agicv2, "GICv2", DEVICE_GIC)
        .class_type = ACPI_MADT_GIC_VERSION_V2,
        .init = acpi_gicv2_preinit,
ACPI_DEVICE_END

would be better.


> +    else
> +        panic("Wrong GIC version or unsupported GIC");
> +    if ( rc )
> +        panic("Unable to find compatible GIC in the ACPI table");
> +}
> +#else
> +static void __init acpi_gic_preinit(void) {}
> +#endif
> +
> +/* Find the interrupt controller and set up the callback to translate
> + * device tree IRQ.
> + */
> +void __init gic_preinit(void)
> +{
> +    if( acpi_disabled )

coding style


> +        dt_gic_preinit();
> +    else
> +        acpi_gic_preinit();
> +}
> +
>  /* Set up the GIC */
>  void __init gic_init(void)
>  {
> -- 
> 2.1.0
> 
