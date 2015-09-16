From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Wed, 16 Sep 2015 23:05:09 +0800
Subject: [PATCH v2 3/5] irqchip/gic: Convert the GIC driver to ACPI probing
In-Reply-To: <1442152943-24493-4-git-send-email-marc.zyngier@arm.com>
References: <1442152943-24493-1-git-send-email-marc.zyngier@arm.com>
 <1442152943-24493-4-git-send-email-marc.zyngier@arm.com>
Message-ID: <55F98525.7030900@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

On 09/13/2015 10:02 PM, Marc Zyngier wrote:
[...]
> diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
> index e6b7ed5..8a0b9c3 100644
> --- a/drivers/irqchip/irq-gic.c
> +++ b/drivers/irqchip/irq-gic.c
> @@ -41,7 +41,6 @@
>   #include <linux/irqchip.h>
>   #include <linux/irqchip/chained_irq.h>
>   #include <linux/irqchip/arm-gic.h>
> -#include <linux/irqchip/arm-gic-acpi.h>
>
>   #include <asm/cputype.h>
>   #include <asm/irq.h>
> @@ -1177,7 +1176,7 @@ IRQCHIP_DECLARE(msm_qgic2, "qcom,msm-qgic2", gic_of_init);
>   #endif
>
>   #ifdef CONFIG_ACPI
> -static phys_addr_t dist_phy_base, cpu_phy_base __initdata;
> +static phys_addr_t cpu_phy_base __initdata;
>
>   static int __init
>   gic_acpi_parse_madt_cpu(struct acpi_subtable_header *header,
> @@ -1205,60 +1204,56 @@ gic_acpi_parse_madt_cpu(struct acpi_subtable_header *header,
>   	return 0;
>   }
>
> -static int __init
> -gic_acpi_parse_madt_distributor(struct acpi_subtable_header *header,
> -				const unsigned long end)
> +/* The things you have to do to just *count* something... */
> +static int __init acpi_dummy_func(struct acpi_subtable_header *header,
> +				  const unsigned long end)
>   {
> -	struct acpi_madt_generic_distributor *dist;
> +	return 0;
> +}
>
> -	dist = (struct acpi_madt_generic_distributor *)header;
> +static bool __init acpi_gic_redist_is_present(void)
> +{
> +	return acpi_table_parse_madt(ACPI_MADT_TYPE_GENERIC_REDISTRIBUTOR,
> +				     acpi_dummy_func, 0) > 0;
> +}
>
> -	if (BAD_MADT_ENTRY(dist, end))
> -		return -EINVAL;
> +static bool __init gic_validate_dist(struct acpi_subtable_header *header,
> +				     struct acpi_probe_entry *ape)
> +{
> +	struct acpi_madt_generic_distributor *dist;
> +	dist = (struct acpi_madt_generic_distributor *)header;
>
> -	dist_phy_base = dist->base_address;
> -	return 0;
> +	return (dist->version == ape->driver_data &&
> +		(dist->version != ACPI_MADT_GIC_VERSION_NONE ||
> +		 !acpi_gic_redist_is_present()));
>

When I was rebasing the GICv3 patches on top of yours, I noticed
that GICv3 will also needs to check the acpi_gic_redist_is_present(),
can we move the code above to some common place, or just leave
the code duplicate but self-contained?

Thanks
Hanjun
