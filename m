From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Wed, 27 Sep 2017 08:34:20 +0800
Subject: [RFC PATCH v2 4/4] ACPI: IORT: SMMUv3 nodes MSI support
In-Reply-To: <20170922130741.GD3475@red-moon>
References: <1505999838-52530-1-git-send-email-guohanjun@huawei.com>
 <1505999838-52530-5-git-send-email-guohanjun@huawei.com>
 <20170922130741.GD3475@red-moon>
Message-ID: <59CAF20C.6050403@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/22/2017 09:07 PM, Lorenzo Pieralisi wrote:
> On Thu, Sep 21, 2017 at 09:17:18PM +0800, Hanjun Guo wrote:
>> From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>>
>> Since we make single mappings valid for SMMUv3 (and PMCG), also
>> we have a mapping index for SMMUv3 MSI, we can directly use that
>> index to get the map entry, then retrieve dev ID and ITS parent
>> to add SMMUv3 MSI support.
>>
>> Introduce a new API iort_set_device_domain() to find the MSI domain
>> for an SMMUv3 (or any other IORT table node) to reduce the complex
>> of doing that via acpi_configure_pmsi_domain(), then reuse the
>> iort_node_get_id() to get the dev id for SMMU MSI.
>>
>> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>> ---
>>   drivers/acpi/arm64/iort.c | 99 ++++++++++++++++++++++++++++++++++++++---------
>>   1 file changed, 81 insertions(+), 18 deletions(-)
>>
>> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
>> index 269959e..bbab2ab 100644
>> --- a/drivers/acpi/arm64/iort.c
>> +++ b/drivers/acpi/arm64/iort.c
>> @@ -357,7 +357,8 @@ struct acpi_iort_node *iort_node_get_id(struct acpi_iort_node *node,
>>
>>   	if (map->flags & ACPI_IORT_ID_SINGLE_MAPPING) {
>>   		if (node->type == ACPI_IORT_NODE_NAMED_COMPONENT ||
>> -		    node->type == ACPI_IORT_NODE_PCI_ROOT_COMPLEX) {
>> +		    node->type == ACPI_IORT_NODE_PCI_ROOT_COMPLEX ||
>> +		    node->type == ACPI_IORT_NODE_SMMU_V3) {
>>   			*id_out = map->output_base;
>>   			return parent;
>>   		}
>> @@ -366,8 +367,8 @@ struct acpi_iort_node *iort_node_get_id(struct acpi_iort_node *node,
>>   	return NULL;
>>   }
>>
>> -static int iort_get_smmu_v3_id_mapping_index(struct acpi_iort_node *node,
>> -					     u32 *index)
>> +static int iort_get_id_mapping_index(struct acpi_iort_node *node,
>> +				     u32 *index)
>>   {
>>   	struct acpi_iort_smmu_v3 *smmu;
>>
>> @@ -378,20 +379,28 @@ static int iort_get_smmu_v3_id_mapping_index(struct acpi_iort_node *node,
>>   	if (node->revision < 1)
>>   		return -EINVAL;
>>
>> -	smmu = (struct acpi_iort_smmu_v3 *)node->node_data;
>> -	/* if any of the gsi for control interrupts is not 0, ignore the MSI */
>> -	if (smmu->event_gsiv || smmu->pri_gsiv || smmu->gerr_gsiv
>> -	    || smmu->sync_gsiv)
>> -		return -EINVAL;
>> +	switch (node->type) {
>> +	case ACPI_IORT_NODE_SMMU_V3:
>> +		smmu = (struct acpi_iort_smmu_v3 *)node->node_data;
>> +		/*
>> +		 * if any of the gsi for control interrupts is not 0,
>> +		 * ignore the MSI
>> +		 */
>> +		if (smmu->event_gsiv || smmu->pri_gsiv || smmu->gerr_gsiv
>> +		    || smmu->sync_gsiv)
>> +			return -EINVAL;
>>
>> -	if (smmu->id_mapping_index >= node->mapping_count) {
>> -		pr_err(FW_BUG "[node %p type %d] ID mapping index overflows valid mappings\n",
>> -		       node, node->type);
>> +		if (smmu->id_mapping_index >= node->mapping_count) {
>> +			pr_err(FW_BUG "[node %p type %d] ID mapping index overflows valid mappings\n",
>> +			       node, node->type);
>> +			return -EINVAL;
>> +		}
>> +
>> +		*index = smmu->id_mapping_index;
>> +		return 0;
>> +	default:
>>   		return -EINVAL;
>>   	}
>> -
>> -	*index = smmu->id_mapping_index;
>> -	return 0;
>>   }
>>
>>   static struct acpi_iort_node *iort_node_map_id(struct acpi_iort_node *node,
>> @@ -431,7 +440,7 @@ static struct acpi_iort_node *iort_node_map_id(struct acpi_iort_node *node,
>>   		 *  associated ID map for single mapping cases.
>>   		 */
>>   		if (node->type == ACPI_IORT_NODE_SMMU_V3)
>
> I wanted to use:
>
> iort_get_id_mapping_index()
>
> so that the node type check is done *in* that function and you do
> not need to check it here.
>
>> -			ret = iort_get_smmu_v3_id_mapping_index(node, &index);
>> +			ret = iort_get_id_mapping_index(node, &index);
>>
>>   		/* Do the ID translation */
>>   		for (i = 0; i < node->mapping_count; i++, map++) {
>> @@ -555,9 +564,18 @@ int iort_pmsi_get_dev_id(struct device *dev, u32 *dev_id)
>>   	if (!node)
>>   		return -ENODEV;
>>
>> -	for (i = 0; i < node->mapping_count; i++) {
>> -		if (iort_node_map_platform_id(node, dev_id, IORT_MSI_TYPE, i))
>> -			return 0;
>> +	if (node->type == ACPI_IORT_NODE_SMMU_V3) {
>
> Ditto.
>
>> +		u32 index;
>> +
>> +		if (!iort_get_id_mapping_index(node, &index)) {
>> +			if (iort_node_get_id(node, dev_id, index))
>> +				return 0;
>> +		}
>> +	} else {
>> +		for (i = 0; i < node->mapping_count; i++) {
>> +			if (iort_node_map_platform_id(node, dev_id, IORT_MSI_TYPE, i))
>> +				return 0;
>> +		}
>>   	}
>>
>>   	return -ENODEV;
>> @@ -620,6 +638,49 @@ struct irq_domain *iort_get_device_domain(struct device *dev, u32 req_id)
>>   	return irq_find_matching_fwnode(handle, DOMAIN_BUS_PCI_MSI);
>>   }
>
> All changes above can be squashed with patch 3.
>
>> +static void iort_set_device_domain(struct device *dev,
>> +				   struct acpi_iort_node *node)
>> +{
>> +	struct acpi_iort_its_group *its;
>> +	struct acpi_iort_node *msi_parent;
>> +	struct acpi_iort_id_mapping *map;
>> +	struct fwnode_handle *iort_fwnode;
>> +	struct irq_domain *domain;
>> +	int ret, index;
>> +
>> +	ret = iort_get_id_mapping_index(node, &index);
>> +	if (ret < 0)
>> +		return;
>> +
>> +	map = ACPI_ADD_PTR(struct acpi_iort_id_mapping, node,
>> +			   node->mapping_offset + index * sizeof(*map));
>> +
>> +	/* Firmware bug! */
>> +	if (!map->output_reference ||
>> +	    !(map->flags & ACPI_IORT_ID_SINGLE_MAPPING)) {
>> +		pr_err(FW_BUG "[node %p type %d] Invalid MSI mapping\n",
>> +		       node, node->type);
>> +		return;
>> +	}
>> +
>> +	msi_parent = ACPI_ADD_PTR(struct acpi_iort_node, iort_table,
>> +				  map->output_reference);
>> +
>> +	if (!msi_parent || msi_parent->type != ACPI_IORT_NODE_ITS_GROUP)
>> +		return;
>> +
>> +	/* Move to ITS specific data */
>> +	its = (struct acpi_iort_its_group *)msi_parent->node_data;
>> +
>> +	iort_fwnode = iort_find_domain_token(its->identifiers[0]);
>> +	if (!iort_fwnode)
>> +		return;
>> +
>> +	domain = irq_find_matching_fwnode(iort_fwnode, DOMAIN_BUS_PLATFORM_MSI);
>> +	if (domain)
>> +		dev_set_msi_domain(dev, domain);
>> +}
>> +
>>   /**
>>    * iort_get_platform_device_domain() - Find MSI domain related to a
>>    * platform device
>> @@ -1246,6 +1307,8 @@ static int __init iort_add_smmu_platform_device(struct acpi_iort_node *node)
>>   	/* Configure DMA for the page table walker */
>>   	acpi_dma_configure(&pdev->dev, attr);
>>
>> +	iort_set_device_domain(&pdev->dev, node);
>> +
>
> ..and then you introduce iort_set_device_domain() and use it in a
> separate patch.
>
> With these changes I think we are ready to queue the series.

Updated already, will send a new version soon.

Thanks
Hanjun
