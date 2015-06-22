From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Mon, 22 Jun 2015 17:45:20 +0100
Subject: [PATCH v2 3/9] irqchip / GIC: Add GIC version support in ACPI MADT
In-Reply-To: <1434703572-26221-4-git-send-email-hanjun.guo@linaro.org>
References: <1434703572-26221-1-git-send-email-hanjun.guo@linaro.org>
 <1434703572-26221-4-git-send-email-hanjun.guo@linaro.org>
Message-ID: <20150622164520.GA26129@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 19, 2015 at 09:46:06AM +0100, Hanjun Guo wrote:

[...]

> +
> +static int __init
> +match_gic_redist(struct acpi_subtable_header *header, const unsigned long end)
> +{
> +	return 0;
> +}
> +static bool __init acpi_gic_redist_is_present(void)
> +{
> +	int count;
> +
> +	/* scan MADT table to find if we have redistributor entries */
> +	count  =  acpi_table_parse_madt(ACPI_MADT_TYPE_GENERIC_REDISTRIBUTOR,
> +					match_gic_redist, 0);
> +
> +	/* has at least one GIC redistributor entry */
> +	if (count > 0)
> +		return true;
> +	else
> +		return false;
> +}

return count > 0;

What about systems where the redistributor data is in the GICC subtable ? Do
you treat them as GIC V2 :) ?

On a side note, having to define an empty function like match_gic_redist is
horrible.

I wonder whether it is not better to refactor map_madt_entry(), create
a MADT subtable iterator out of it and make that code generic, instead
of being forced to add these useless MADT handlers just to count
entries, it is not the first I noticed.

> +static int __init acpi_gic_version_init(void)
> +{
> +	int count;
> +	void __iomem *dist_base;
> +	u32 reg;
> +
> +	count = acpi_table_parse_madt(ACPI_MADT_TYPE_GENERIC_DISTRIBUTOR,
> +					acpi_gic_parse_distributor, 0);
> +
> +	if (count <= 0) {
> +		pr_err("No valid GIC distributor entry exists\n");
> +		return -ENODEV;
> +	}
> +
> +	if (gic_version >= ACPI_MADT_GIC_VERSION_RESERVED) {
> +		pr_err("Invalid GIC version %d in MADT\n", gic_version);
> +		return -EINVAL;
> +	}
> +
> +	/*
> +	 * when the GIC version is 0, we fallback to hardware discovery.
> +	 * this is also needed to keep compatiable with ACPI 5.1,
> +	 * which has no gic_version field in distributor structure and
> +	 * reserved as 0.
> +	 *
> +	 * For hardware discovery, the offset for GICv1/2 and GICv3/4 to
> +	 * get the GIC version is different (0xFE8 for GICv1/2 and 0xFFE8
> +	 * for GICv3/4), so we need to handle it separately.

> +	 */
> +	if (gic_version	== ACPI_MADT_GIC_VERSION_NONE) {
> +		/* it's GICv3/v4 if redistributor is present */
> +		if (acpi_gic_redist_is_present()) {

See above, IIUC you might have systems with GIC v3 where this call
would fail, and we do not want to fall back to GIC v2.

Lorenzo

> +			dist_base = ioremap(dist_phy_base,
> +					    ACPI_GICV3_DIST_MEM_SIZE);
> +			if (!dist_base)
> +				return -ENOMEM;
> +
> +			reg = readl_relaxed(dist_base + GICD_PIDR2) &
> +					    GIC_PIDR2_ARCH_MASK;
> +			if (reg == GIC_PIDR2_ARCH_GICv3)
> +				gic_version = ACPI_MADT_GIC_VERSION_V3;
> +			else
> +				gic_version = ACPI_MADT_GIC_VERSION_V4;
> +
> +			iounmap(dist_base);
> +		} else {
> +			gic_version = ACPI_MADT_GIC_VERSION_V2;
> +		}

> +	}
> +
> +	return 0;
> +}
> diff --git a/include/linux/irqchip/arm-gic-acpi.h b/include/linux/irqchip/arm-gic-acpi.h
> index de3419e..13bc676 100644
> --- a/include/linux/irqchip/arm-gic-acpi.h
> +++ b/include/linux/irqchip/arm-gic-acpi.h
> @@ -19,6 +19,7 @@
>   */
>  #define ACPI_GICV2_DIST_MEM_SIZE	(SZ_4K)
>  #define ACPI_GIC_CPU_IF_MEM_SIZE	(SZ_8K)
> +#define ACPI_GICV3_DIST_MEM_SIZE	(SZ_64K)
>  
>  struct acpi_table_header;
>  
> -- 
> 1.9.1
> 
