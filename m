From: shameerali.kolothum.thodi@huawei.com (Shameerali Kolothum Thodi)
Date: Mon, 10 Sep 2018 16:08:40 +0000
Subject: [PATCH v2 1/4] acpi: arm64: add iort support for PMCG
In-Reply-To: <40e762a2-0b53-d88d-936c-a0cff190682a@arm.com>
References: <20180724114515.21764-1-shameerali.kolothum.thodi@huawei.com>
 <20180724114515.21764-2-shameerali.kolothum.thodi@huawei.com>
 <40e762a2-0b53-d88d-936c-a0cff190682a@arm.com>
Message-ID: <5FC3163CFD30C246ABAA99954A238FA8387858C8@FRAEML521-MBX.china.huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robin,

Thanks for going through this series,

> -----Original Message-----
> From: Robin Murphy [mailto:robin.murphy at arm.com]
> Sent: 07 September 2018 16:36
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>;
> lorenzo.pieralisi at arm.com
> Cc: will.deacon at arm.com; mark.rutland at arm.com; Guohanjun (Hanjun Guo)
> <guohanjun@huawei.com>; John Garry <john.garry@huawei.com>;
> pabba at codeaurora.org; vkilari at codeaurora.org; rruigrok at codeaurora.org;
> linux-acpi at vger.kernel.org; linux-kernel at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org; Linuxarm <linuxarm@huawei.com>;
> neil.m.leeder at gmail.com
> Subject: Re: [PATCH v2 1/4] acpi: arm64: add iort support for PMCG
> 
> On 24/07/18 12:45, Shameer Kolothum wrote:
> > From: Neil Leeder <nleeder@codeaurora.org>
> >
> > Add support for the SMMU Performance Monitor Counter Group
> > information from ACPI. This is in preparation for its use
> > in the SMMU v3 PMU driver.
> >
> > Signed-off-by: Neil Leeder <nleeder@codeaurora.org>
> > Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
> > Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> > ---
> >   drivers/acpi/arm64/iort.c | 95
> +++++++++++++++++++++++++++++++++++++++++------
> >   1 file changed, 83 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> > index 7a3a541..ac4d0d6 100644
> > --- a/drivers/acpi/arm64/iort.c
> > +++ b/drivers/acpi/arm64/iort.c
> > @@ -356,7 +356,8 @@ static struct acpi_iort_node *iort_node_get_id(struct
> acpi_iort_node *node,
> >   	if (map->flags & ACPI_IORT_ID_SINGLE_MAPPING) {
> >   		if (node->type == ACPI_IORT_NODE_NAMED_COMPONENT ||
> >   		    node->type == ACPI_IORT_NODE_PCI_ROOT_COMPLEX ||
> > -		    node->type == ACPI_IORT_NODE_SMMU_V3) {
> > +		    node->type == ACPI_IORT_NODE_SMMU_V3 ||
> > +		    node->type == ACPI_IORT_NODE_PMCG) {
> >   			*id_out = map->output_base;
> >   			return parent;
> >   		}
> > @@ -394,6 +395,8 @@ static int iort_get_id_mapping_index(struct
> acpi_iort_node *node)
> >   		}
> >
> >   		return smmu->id_mapping_index;
> > +	case ACPI_IORT_NODE_PMCG:
> > +		return 0;
> 
> Why do we need a PMCG case here? AIUI this whole get_id_mapping_index
> business is only relevant to SMMUv3 nodes where we have some need to
> disambiguate the difference between the SMMU's own IDs and
> StreamID-to-DeviceID mappings within the same table. PMCGs simply have
> zero or one single ID mappings so should be equivalent to most named
> components (other than their mappings pointing straight to the ITS).

ITRC this is required for the iort_set_device_domain() function as
otherwise, dev_set_msi_domain() won't be called for PMCGs with MSI
support.

> >   	default:
> >   		return -EINVAL;
> >   	}
> > @@ -1287,6 +1290,63 @@ static bool __init arm_smmu_is_coherent(struct
> acpi_iort_node *node)
> >   	return smmu->flags & ACPI_IORT_SMMU_COHERENT_WALK;
> >   }
> >
> > +static void __init arm_smmu_common_dma_configure(struct device *dev,
> > +						enum dev_dma_attr attr)
> > +{
> > +	/* We expect the dma masks to be equivalent for	all SMMUs
> set-ups */
> > +	dev->dma_mask = &dev->coherent_dma_mask;
> > +
> > +	/* Configure DMA for the page table walker */
> > +	acpi_dma_configure(dev, attr);
> 
> Hmm, I don't think we actually need this call any more, since it should
> now happen later anyway via platform_dma_configure() as the relevant
> SMMU/PMCG driver binds.

This is only applicable to SMMU nodes. As you have noted below, these devices
are from the static table, so I am not sure platform_dma_configure() applies
here. I will double check.
 
> > +}
> > +
> > +static int __init arm_smmu_v3_pmu_count_resources(struct acpi_iort_node
> *node)
> 
> Can we be consistent with "pmcg" rather than "pmu" within IORT please?

Ok.

> 
> > +{
> > +	struct acpi_iort_pmcg *pmcg;
> > +
> > +	/* Retrieve PMCG specific data */
> > +	pmcg = (struct acpi_iort_pmcg *)node->node_data;
> > +
> > +	/*
> > +	 * There are always 2 memory resources.
> > +	 * If the overflow_gsiv is present then add that for a total of 3.
> > +	 */
> > +	return pmcg->overflow_gsiv > 0 ? 3 : 2;
> > +}
> > +
> > +static void __init arm_smmu_v3_pmu_init_resources(struct resource *res,
> > +					       struct acpi_iort_node *node)
> > +{
> > +	struct acpi_iort_pmcg *pmcg;
> > +
> > +	/* Retrieve PMCG specific data */
> > +	pmcg = (struct acpi_iort_pmcg *)node->node_data;
> > +
> > +	res[0].start = pmcg->page0_base_address;
> > +	res[0].end = pmcg->page0_base_address + SZ_4K - 1;
> > +	res[0].flags = IORESOURCE_MEM;
> > +	res[1].start = pmcg->page1_base_address;
> > +	res[1].end = pmcg->page1_base_address + SZ_4K - 1;
> > +	res[1].flags = IORESOURCE_MEM;
> > +
> > +	if (pmcg->overflow_gsiv)
> > +		acpi_iort_register_irq(pmcg->overflow_gsiv, "overflow",
> > +				       ACPI_EDGE_SENSITIVE, &res[2]);
> > +}
> > +
> > +static struct acpi_iort_node *iort_find_pmcg_ref(struct acpi_iort_node
> *node)
> > +{
> > +	struct acpi_iort_pmcg *pmcg;
> > +	struct acpi_iort_node *ref_node = NULL;
> > +
> > +	/* Retrieve PMCG specific data */
> > +	pmcg = (struct acpi_iort_pmcg *)node->node_data;
> > +	if (pmcg->node_reference)
> > +		ref_node = ACPI_ADD_PTR(struct acpi_iort_node,
> > +					iort_table,  pmcg->node_reference);
> > +	return ref_node;
> > +}
> > +
> >   struct iort_dev_config {
> >   	const char *name;
> >   	int (*dev_init)(struct acpi_iort_node *node);
> > @@ -1296,6 +1356,8 @@ struct iort_dev_config {
> >   				     struct acpi_iort_node *node);
> >   	void (*dev_set_proximity)(struct device *dev,
> >   				    struct acpi_iort_node *node);
> > +	void (*dev_dma_configure)(struct device *dev,
> > +					enum dev_dma_attr attr);
> >   };
> >
> >   static const struct iort_dev_config iort_arm_smmu_v3_cfg __initconst = {
> > @@ -1304,23 +1366,38 @@ static const struct iort_dev_config
> iort_arm_smmu_v3_cfg __initconst = {
> >   	.dev_count_resources = arm_smmu_v3_count_resources,
> >   	.dev_init_resources = arm_smmu_v3_init_resources,
> >   	.dev_set_proximity = arm_smmu_v3_set_proximity,
> > +	.dev_dma_configure = arm_smmu_common_dma_configure
> >   };
> >
> >   static const struct iort_dev_config iort_arm_smmu_cfg __initconst = {
> >   	.name = "arm-smmu",
> >   	.dev_is_coherent = arm_smmu_is_coherent,
> >   	.dev_count_resources = arm_smmu_count_resources,
> > -	.dev_init_resources = arm_smmu_init_resources
> > +	.dev_init_resources = arm_smmu_init_resources,
> > +	.dev_dma_configure = arm_smmu_common_dma_configure
> > +};
> > +
> > +static const struct iort_dev_config iort_arm_smmu_v3_pmcg_cfg
> __initconst = {
> > +	.name = "arm-smmu-v3-pmu",
> > +	.dev_count_resources = arm_smmu_v3_pmu_count_resources,
> > +	.dev_init_resources = arm_smmu_v3_pmu_init_resources
> >   };
> >
> >   static __init const struct iort_dev_config *iort_get_dev_cfg(
> >   			struct acpi_iort_node *node)
> >   {
> > +	struct acpi_iort_node *ref_node;
> > +
> >   	switch (node->type) {
> >   	case ACPI_IORT_NODE_SMMU_V3:
> >   		return &iort_arm_smmu_v3_cfg;
> >   	case ACPI_IORT_NODE_SMMU:
> >   		return &iort_arm_smmu_cfg;
> > +	case ACPI_IORT_NODE_PMCG:
> > +		/* Check this is associated with SMMUv3 */
> > +		ref_node = iort_find_pmcg_ref(node);
> 
> This seems overly restrictive - admittedly the only non-SMMU DTI
> components I know of don't actually implement a PMCG for their internal
> TBU, but I'm sure something will eventually, and there doesn't seem to
> be any good reason for Linux to forcibly ignore it when it does.

Right. I think that?s a misread of IORT spec from my part thinking there might
be non SMMUv3 specific PMCG associated with  NC/RC. I will remove this.

Thanks,
Shameer

> > +		if (ref_node && ref_node->type ==
> ACPI_IORT_NODE_SMMU_V3)
> > +			return &iort_arm_smmu_v3_pmcg_cfg;
> >   	default:
> >   		return NULL;
> >   	}
> > @@ -1376,12 +1453,6 @@ static int __init iort_add_platform_device(struct
> acpi_iort_node *node,
> >   	if (ret)
> >   		goto dev_put;
> >
> > -	/*
> > -	 * We expect the dma masks to be equivalent for
> > -	 * all SMMUs set-ups
> > -	 */
> > -	pdev->dev.dma_mask = &pdev->dev.coherent_dma_mask;
> > -
> >   	fwnode = iort_get_fwnode(node);
> >
> >   	if (!fwnode) {
> > @@ -1391,11 +1462,11 @@ static int __init iort_add_platform_device(struct
> acpi_iort_node *node,
> >
> >   	pdev->dev.fwnode = fwnode;
> >
> > -	attr = ops->dev_is_coherent && ops->dev_is_coherent(node) ?
> > +	if (ops->dev_dma_configure) {
> > +		attr = ops->dev_is_coherent && ops->dev_is_coherent(node) ?
> >   			DEV_DMA_COHERENT : DEV_DMA_NON_COHERENT;
> 
> Oh, right, these guys don't have an ACPI companion or a standard DMA
> attr because they're from a static table, so platform_dma_configure()
> won't pick them up. Oh well. We probably don't want to start dragging
> IORT internals into the platform bus code, so I guess it's not worth
> trying to change that.
> 
> Robin.
> 
> > -
> > -	/* Configure DMA for the page table walker */
> > -	acpi_dma_configure(&pdev->dev, attr);
> > +		ops->dev_dma_configure(&pdev->dev, attr);
> > +	}
> >
> >   	iort_set_device_domain(&pdev->dev, node);
> >
> >
