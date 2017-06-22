From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu, 22 Jun 2017 14:46:07 +0100
Subject: [PATCH v4 2/2] acpi, gicv3-its, numa: Adding numa node mapping
 for gic-its units
In-Reply-To: <1498111812-17053-3-git-send-email-ganapatrao.kulkarni@cavium.com>
References: <1498111812-17053-1-git-send-email-ganapatrao.kulkarni@cavium.com>
 <1498111812-17053-3-git-send-email-ganapatrao.kulkarni@cavium.com>
Message-ID: <20170622134607.GB9732@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 22, 2017 at 11:40:12AM +0530, Ganapatrao Kulkarni wrote:
> Add code to parse SRAT ITS Affinity sub table as defined in ACPI 6.2.
> Later in per device probe, ITS devices are mapped to numa node using
> ITS Id to proximity domain mapping.
> 
> Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
> ---
>  drivers/irqchip/irq-gic-v3-its.c | 75 +++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 74 insertions(+), 1 deletion(-)

Reviewed-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index 45ea1933..1c21e01 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -1833,6 +1833,77 @@ static int __init its_of_probe(struct device_node *node)
>  
>  #define ACPI_GICV3_ITS_MEM_SIZE (SZ_128K)
>  
> +#ifdef CONFIG_ACPI_NUMA
> +struct its_srat_map {
> +	u32	numa_node;  /* numa node id */
> +	u32	its_id;  /* GIC ITS ID */
> +};
> +
> +static struct its_srat_map its_srat_maps[MAX_NUMNODES] __initdata;
> +static int its_in_srat __initdata;
> +
> +static int __init acpi_get_its_numa_node(u32 its_id)
> +{
> +	int i;
> +
> +	for (i = 0; i < its_in_srat; i++) {
> +		if (its_id == its_srat_maps[i].its_id)
> +			return its_srat_maps[i].numa_node;
> +	}
> +	return NUMA_NO_NODE;
> +}
> +
> +static int __init gic_acpi_parse_srat_its(struct acpi_subtable_header *header,
> +			 const unsigned long end)
> +{
> +	int pxm, node;
> +	struct acpi_srat_its_affinity *its_affinity;
> +
> +	its_affinity = (struct acpi_srat_its_affinity *)header;
> +	if (!its_affinity)
> +		return -EINVAL;
> +
> +	if (its_affinity->header.length < sizeof(*its_affinity)) {
> +		pr_err("SRAT: Invalid header length %d in ITS affinity\n",
> +			its_affinity->header.length);
> +		return -EINVAL;
> +	}
> +
> +	if (its_in_srat >= MAX_NUMNODES) {
> +		pr_err("SRAT: ITS affinity exceeding max count[%d]\n",
> +				MAX_NUMNODES);
> +		return -EINVAL;
> +	}
> +
> +	pxm = its_affinity->proximity_domain;
> +	node = acpi_map_pxm_to_node(pxm);
> +
> +	if (node == NUMA_NO_NODE || node >= MAX_NUMNODES) {
> +		pr_err("SRAT: Invalid NUMA node %d in ITS affinity\n", node);
> +		return 0;
> +	}
> +
> +	its_srat_maps[its_in_srat].numa_node = node;
> +	its_srat_maps[its_in_srat].its_id = its_affinity->its_id;
> +	its_in_srat++;
> +	pr_info("SRAT: PXM %d -> ITS %d -> Node %d\n",
> +		pxm, its_affinity->its_id, node);
> +
> +	return 0;
> +}
> +
> +static void __init acpi_table_parse_srat_its(void)
> +{
> +	acpi_table_parse_entries(ACPI_SIG_SRAT,
> +			sizeof(struct acpi_table_srat),
> +			ACPI_SRAT_TYPE_GIC_ITS_AFFINITY,
> +			gic_acpi_parse_srat_its, 0);
> +}
> +#else
> +static void __init acpi_table_parse_srat_its(void)	{ }
> +static int __init acpi_get_its_numa_node(u32 its_id) { return NUMA_NO_NODE; }
> +#endif
> +
>  static int __init gic_acpi_parse_madt_its(struct acpi_subtable_header *header,
>  					  const unsigned long end)
>  {
> @@ -1861,7 +1932,8 @@ static int __init gic_acpi_parse_madt_its(struct acpi_subtable_header *header,
>  		goto dom_err;
>  	}
>  
> -	err = its_probe_one(&res, dom_handle, NUMA_NO_NODE);
> +	err = its_probe_one(&res, dom_handle,
> +			acpi_get_its_numa_node(its_entry->translation_id));
>  	if (!err)
>  		return 0;
>  
> @@ -1873,6 +1945,7 @@ static int __init gic_acpi_parse_madt_its(struct acpi_subtable_header *header,
>  
>  static void __init its_acpi_probe(void)
>  {
> +	acpi_table_parse_srat_its();
>  	acpi_table_parse_madt(ACPI_MADT_TYPE_GENERIC_TRANSLATOR,
>  			      gic_acpi_parse_madt_its, 0);
>  }
> -- 
> 1.8.1.4
> 
