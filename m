From: robin.murphy@arm.com (Robin Murphy)
Date: Mon, 7 Aug 2017 12:17:16 +0100
Subject: [PATCH 1/2] acpi: arm64: add iort support for PMCG
In-Reply-To: <1501876754-1064-2-git-send-email-nleeder@codeaurora.org>
References: <1501876754-1064-1-git-send-email-nleeder@codeaurora.org>
 <1501876754-1064-2-git-send-email-nleeder@codeaurora.org>
Message-ID: <22df7d0e-3017-b3f6-67e2-21b9ece433c3@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Neil,

On 04/08/17 20:59, Neil Leeder wrote:
> Add support for the SMMU Performance Monitor Counter Group
> information from ACPI. This is in preparation for its use
> in the SMMU v3 PMU driver.
> 
> Signed-off-by: Neil Leeder <nleeder@codeaurora.org>
> ---
>  drivers/acpi/arm64/iort.c | 54 +++++++++++++++++++++++++++++++++++++++++++++++
>  include/acpi/actbl2.h     |  9 +++++++-
>  2 files changed, 62 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index a3215ee..5a998cd 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -970,6 +970,40 @@ static bool __init arm_smmu_is_coherent(struct acpi_iort_node *node)
>  	return smmu->flags & ACPI_IORT_SMMU_COHERENT_WALK;
>  }
>  
> +static int __init arm_smmu_pmu_count_resources(struct acpi_iort_node *node)
> +{
> +	struct acpi_iort_pmcg *pmcg;
> +
> +	/* Retrieve PMCG specific data */
> +	pmcg = (struct acpi_iort_pmcg *)node->node_data;
> +
> +	/*
> +	 * There are always 2 memory resources.
> +	 * If the overflow_gsiv is present then add that for a total of 3.
> +	 */
> +	return pmcg->overflow_gsiv > 0 ? 3 : 2;
> +}
> +
> +static void __init arm_smmu_pmu_init_resources(struct resource *res,
> +					       struct acpi_iort_node *node)
> +{
> +	struct acpi_iort_pmcg *pmcg;
> +
> +	/* Retrieve PMCG specific data */
> +	pmcg = (struct acpi_iort_pmcg *)node->node_data;
> +
> +	res[0].start = pmcg->base_address;
> +	res[0].end = pmcg->base_address + SZ_4K - 1;
> +	res[0].flags = IORESOURCE_MEM;
> +	res[1].start = pmcg->base_address + SZ_64K;

Ugh, I see there's a nasty spec hole here - IORT only defines one base
address, but SMMUv3 says *both* pages have imp-def base addresses. I
guess this assumption of them being in consecutive 64K regions holds for
your platform, but as things stand it doesn't appear possible to rely on
it generally :(

I'll follow up internally to see if we need to get IORT and/or SBSA
updated or clarified.

> +	res[1].end = pmcg->base_address + SZ_64K + SZ_4K - 1;
> +	res[1].flags = IORESOURCE_MEM;
> +
> +	if (pmcg->overflow_gsiv)
> +		acpi_iort_register_irq(pmcg->overflow_gsiv, "overflow",
> +				       ACPI_EDGE_SENSITIVE, &res[2]);
> +}
> +
>  struct iort_iommu_config {
>  	const char *name;
>  	int (*iommu_init)(struct acpi_iort_node *node);
> @@ -993,6 +1027,12 @@ struct iort_iommu_config {
>  	.iommu_init_resources = arm_smmu_init_resources
>  };
>  
> +static const struct iort_iommu_config iort_arm_smmu_pmcg_cfg __initconst = {
> +	.name = "arm-smmu-pmu",
> +	.iommu_count_resources = arm_smmu_pmu_count_resources,
> +	.iommu_init_resources = arm_smmu_pmu_init_resources
> +};
> +
>  static __init
>  const struct iort_iommu_config *iort_get_iommu_cfg(struct acpi_iort_node *node)
>  {
> @@ -1001,6 +1041,8 @@ const struct iort_iommu_config *iort_get_iommu_cfg(struct acpi_iort_node *node)
>  		return &iort_arm_smmu_v3_cfg;
>  	case ACPI_IORT_NODE_SMMU:
>  		return &iort_arm_smmu_cfg;
> +	case ACPI_IORT_NODE_PMCG:
> +		return &iort_arm_smmu_pmcg_cfg;
>  	default:
>  		return NULL;
>  	}
> @@ -1056,6 +1098,15 @@ static int __init iort_add_smmu_platform_device(struct acpi_iort_node *node)
>  	if (ret)
>  		goto dev_put;
>  
> +	/* End of init for PMCG */
> +	if (node->type == ACPI_IORT_NODE_PMCG) {
> +		ret = platform_device_add(pdev);
> +		if (ret)
> +			goto dev_put;
> +
> +		return 0;
> +	}
> +
>  	/*
>  	 * We expect the dma masks to be equivalent for
>  	 * all SMMUs set-ups
> @@ -1131,6 +1182,9 @@ static void __init iort_init_platform_devices(void)
>  				acpi_free_fwnode_static(fwnode);
>  				return;
>  			}
> +		} else if (iort_node->type == ACPI_IORT_NODE_PMCG) {
> +			if (iort_add_smmu_platform_device(iort_node))
> +				return;
>  		}
>  
>  		iort_node = ACPI_ADD_PTR(struct acpi_iort_node, iort_node,
> diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
> index 707dda74..2169b6f 100644
> --- a/include/acpi/actbl2.h
> +++ b/include/acpi/actbl2.h

Hopefully these changes are merely here for reference, but just in case
it needs to be said, they should go as a separate patch via ACPICA
(presumably there's also some corresponding iASL stuff to compile PMCG
nodes in the first place).

Robin.

> @@ -695,7 +695,8 @@ enum acpi_iort_node_type {
>  	ACPI_IORT_NODE_NAMED_COMPONENT = 0x01,
>  	ACPI_IORT_NODE_PCI_ROOT_COMPLEX = 0x02,
>  	ACPI_IORT_NODE_SMMU = 0x03,
> -	ACPI_IORT_NODE_SMMU_V3 = 0x04
> +	ACPI_IORT_NODE_SMMU_V3 = 0x04,
> +	ACPI_IORT_NODE_PMCG = 0x05
>  };
>  
>  struct acpi_iort_id_mapping {
> @@ -811,6 +812,12 @@ struct acpi_iort_smmu_v3 {
>  #define ACPI_IORT_SMMU_V3_COHACC_OVERRIDE   (1)
>  #define ACPI_IORT_SMMU_V3_HTTU_OVERRIDE     (1<<1)
>  
> +struct acpi_iort_pmcg {
> +	u64 base_address;	/* PMCG base address */
> +	u32 overflow_gsiv;
> +	u32 node_reference;
> +};
> +
>  /*******************************************************************************
>   *
>   * IVRS - I/O Virtualization Reporting Structure
> 
