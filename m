From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Fri, 13 Oct 2017 14:04:45 +0100
Subject: [PATCH v2 3/4] ACPI/IORT: Add SMMUv3 specific special index
 mapping handling
In-Reply-To: <1507878590-51066-4-git-send-email-guohanjun@huawei.com>
References: <1507878590-51066-1-git-send-email-guohanjun@huawei.com>
 <1507878590-51066-4-git-send-email-guohanjun@huawei.com>
Message-ID: <20171013130445.GA27895@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[+Robert, Will]

Rafael, Robert,

On Fri, Oct 13, 2017 at 03:09:49PM +0800, Hanjun Guo wrote:

[...]

> +#if (ACPI_CA_VERSION > 0x20170929)

Any objection to handling 4.15 trees dependency by using ACPICA
version as a temporary guard (that I will promptly remove at -rc1) ?

This series will go via arm64 tree and I see no other obvious way of
handling the dependency with ACPICA, unless I can send an ACPI IORT pull
request to Rafael and ACPICA changes go via Rafael's tree too.

Please let me know, I would like to send the pull request to arm64
shortly.

Thanks,
Lorenzo

> +static int iort_get_id_mapping_index(struct acpi_iort_node *node)
> +{
> +	struct acpi_iort_smmu_v3 *smmu;
> +
> +	switch (node->type) {
> +	case ACPI_IORT_NODE_SMMU_V3:
> +		/*
> +		 * SMMUv3 dev ID mapping index was introdueced in revision 1
> +		 * table, not available in revision 0
> +		 */
> +		if (node->revision < 1)
> +			return -EINVAL;
> +
> +		smmu = (struct acpi_iort_smmu_v3 *)node->node_data;
> +		/*
> +		 * ID mapping index is only ignored if all interrupts are
> +		 * GSIV based
> +		 */
> +		if (smmu->event_gsiv && smmu->pri_gsiv && smmu->gerr_gsiv
> +		    && smmu->sync_gsiv)
> +			return -EINVAL;
> +
> +		if (smmu->id_mapping_index >= node->mapping_count) {
> +			pr_err(FW_BUG "[node %p type %d] ID mapping index overflows valid mappings\n",
> +			       node, node->type);
> +			return -EINVAL;
> +		}
> +
> +		return smmu->id_mapping_index;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +#else
>  static inline int iort_get_id_mapping_index(struct acpi_iort_node *node)
>  {
>  	return -EINVAL;
>  }
> +#endif
>  
>  static struct acpi_iort_node *iort_node_map_id(struct acpi_iort_node *node,
>  					       u32 id_in, u32 *id_out,
> -- 
> 1.7.12.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
