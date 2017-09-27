From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 27 Sep 2017 14:54:49 +0100
Subject: [PATCH 3/4] ACPI: IORT: Skip SMMUv3 device ID map for two steps
 mappings
In-Reply-To: <1506475215-2731-4-git-send-email-hanjun.guo@linaro.org>
References: <1506475215-2731-1-git-send-email-hanjun.guo@linaro.org>
 <1506475215-2731-4-git-send-email-hanjun.guo@linaro.org>
Message-ID: <20170927135449.GA11347@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hanjun,

On Wed, Sep 27, 2017 at 09:20:14AM +0800, Hanjun Guo wrote:
> IORT revision C introduced SMMUv3 MSI support which adding a
> device ID mapping index in SMMUv3 sub table, to get the SMMUv3
> device ID mapping for the output ID (dev ID for ITS) and the
> link to which ITS.
> 
> So if a platform supports SMMUv3 MSI for control interrupt,
> there will be a additional single map entry under SMMU, this
> will not introduce any difference for devices just use one
> step map to get its output ID and parent (ITS or SMMU), such
> as PCI/NC/PMCG ---> ITS or PCI/NC ---> SMMU, but we need to
> do the special handling for two steps map case such as
> PCI/NC--->SMMUv3--->ITS.
> 
> Take a PCI hostbridge for example,
> 
> |----------------------|
> |  Root Complex Node   |
> |----------------------|
> |    map entry[x]      |
> |----------------------|
> |       id value       |
> | output_reference     |
> |---|------------------|
>     |
>     |   |----------------------|
>     |-->|        SMMUv3        |
>         |----------------------|
>         |     SMMU dev ID      |
>         |     mapping index 0  |
>         |----------------------|
>         |      map entry[0]    |
>         |----------------------|
>         |       id value       |
>         | output_reference-----------> ITS 1 (SMMU MSI domain)
>         |----------------------|
>         |      map entry[1]    |
>         |----------------------|
>         |       id value       |
>         | output_reference-----------> ITS 2 (PCI MSI domain)
>         |----------------------|
> 
> When the SMMU dev ID mapping index is 0, there is entry[0]
> to map to a ITS, we need to skip that map entry for PCI
> or NC (named component), or we may get the wrong ITS parent.

Is this actually true ? I think that currently we would simply skip
the entry and print an error log but we can't get a wrong ITS parent.

I am rewriting this commit (I will probably split it), it is doing the
right thing but the commit log is stale (probably caused by code
reshuffling).

Thanks,
Lorenzo

> Introduce iort_get_id_mapping_index() to get the index then
> skip the map entry in iort_node_map_id(), also to get the
> dev ID directly for iort_pmsi_get_dev_id() for ITS platform
> MSI preparation.
> 
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> ---
>  drivers/acpi/arm64/iort.c | 64 +++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 59 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index db71d7f..1c1160e 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -357,7 +357,8 @@ struct acpi_iort_node *iort_node_get_id(struct acpi_iort_node *node,
>  
>  	if (map->flags & ACPI_IORT_ID_SINGLE_MAPPING) {
>  		if (node->type == ACPI_IORT_NODE_NAMED_COMPONENT ||
> -		    node->type == ACPI_IORT_NODE_PCI_ROOT_COMPLEX) {
> +		    node->type == ACPI_IORT_NODE_PCI_ROOT_COMPLEX ||
> +		    node->type == ACPI_IORT_NODE_SMMU_V3) {
>  			*id_out = map->output_base;
>  			return parent;
>  		}
> @@ -366,6 +367,40 @@ struct acpi_iort_node *iort_node_get_id(struct acpi_iort_node *node,
>  	return NULL;
>  }
>  
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
> +
>  static struct acpi_iort_node *iort_node_map_id(struct acpi_iort_node *node,
>  					       u32 id_in, u32 *id_out,
>  					       u8 type_mask)
> @@ -375,7 +410,7 @@ static struct acpi_iort_node *iort_node_map_id(struct acpi_iort_node *node,
>  	/* Parse the ID mapping tree to find specified node type */
>  	while (node) {
>  		struct acpi_iort_id_mapping *map;
> -		int i;
> +		int i, index;
>  
>  		if (IORT_TYPE_MASK(node->type) & type_mask) {
>  			if (id_out)
> @@ -396,8 +431,19 @@ static struct acpi_iort_node *iort_node_map_id(struct acpi_iort_node *node,
>  			goto fail_map;
>  		}
>  
> +		/*
> +		 * we need to get SMMUv3 dev ID mapping index and skip its
> +		 * associated ID map for single mapping cases, error value
> +		 * returned for index will be an invalid value in practical.
> +		 */
> +		index = iort_get_id_mapping_index(node);
> +
>  		/* Do the ID translation */
>  		for (i = 0; i < node->mapping_count; i++, map++) {
> +			/* if it's a SMMUv3 device id mapping index, skip it */
> +			if (i == index)
> +				continue;
> +
>  			if (!iort_id_map(map, node->type, id, &id))
>  				break;
>  		}
> @@ -507,16 +553,24 @@ u32 iort_msi_map_rid(struct device *dev, u32 req_id)
>   */
>  int iort_pmsi_get_dev_id(struct device *dev, u32 *dev_id)
>  {
> -	int i;
> +	int i, index;
>  	struct acpi_iort_node *node;
>  
>  	node = iort_find_dev_node(dev);
>  	if (!node)
>  		return -ENODEV;
>  
> -	for (i = 0; i < node->mapping_count; i++) {
> -		if (iort_node_map_platform_id(node, dev_id, IORT_MSI_TYPE, i))
> +	index = iort_get_id_mapping_index(node);
> +	/* if there is a valid index, go get the dev_id directly */
> +	if (index >= 0) {
> +		if (iort_node_get_id(node, dev_id, index))
>  			return 0;
> +	} else {
> +		for (i = 0; i < node->mapping_count; i++) {
> +			if (iort_node_map_platform_id(node, dev_id,
> +						      IORT_MSI_TYPE, i))
> +				return 0;
> +		}
>  	}
>  
>  	return -ENODEV;
> -- 
> 1.9.1
> 
