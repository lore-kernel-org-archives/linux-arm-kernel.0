From: shameerali.kolothum.thodi@huawei.com (Shameerali Kolothum Thodi)
Date: Fri, 5 Oct 2018 11:06:45 +0000
Subject: [PATCH v3 1/3] acpi: arm64: add iort support for PMCG
In-Reply-To: <7572d65b-1d10-b460-c2c8-4f46e2e0d53c@arm.com>
References: <20180921150803.25444-1-shameerali.kolothum.thodi@huawei.com>
 <20180921150803.25444-2-shameerali.kolothum.thodi@huawei.com>
 <20181004164356.GA16278@red-moon>
 <7572d65b-1d10-b460-c2c8-4f46e2e0d53c@arm.com>
Message-ID: <5FC3163CFD30C246ABAA99954A238FA8387956A3@FRAEML521-MBX.china.huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Robin Murphy [mailto:robin.murphy at arm.com]
> Sent: 04 October 2018 18:35
> To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>; Shameerali Kolothum Thodi
> <shameerali.kolothum.thodi@huawei.com>
> Cc: will.deacon at arm.com; mark.rutland at arm.com; Guohanjun (Hanjun Guo)
> <guohanjun@huawei.com>; John Garry <john.garry@huawei.com>;
> pabba at codeaurora.org; vkilari at codeaurora.org; rruigrok at codeaurora.org;
> linux-acpi at vger.kernel.org; linux-kernel at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org; Linuxarm <linuxarm@huawei.com>;
> neil.m.leeder at gmail.com
> Subject: Re: [PATCH v3 1/3] acpi: arm64: add iort support for PMCG
> 
> On 04/10/18 17:43, Lorenzo Pieralisi wrote:
> > On Fri, Sep 21, 2018 at 04:08:01PM +0100, Shameer Kolothum wrote:
> >> From: Neil Leeder <nleeder@codeaurora.org>
> >>
> >> Add support for the SMMU Performance Monitor Counter Group
> >> information from ACPI. This is in preparation for its use
> >> in the SMMUv3 PMU driver.
> >>
> >> Signed-off-by: Neil Leeder <nleeder@codeaurora.org>
> >> Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
> >> Signed-off-by: Shameer Kolothum
> <shameerali.kolothum.thodi@huawei.com>
> >> ---
> >>   drivers/acpi/arm64/iort.c | 78
> +++++++++++++++++++++++++++++++++++++++--------
> >>   1 file changed, 66 insertions(+), 12 deletions(-)
> >>
> >> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> >> index 08f26db..b979c86 100644
> >> --- a/drivers/acpi/arm64/iort.c
> >> +++ b/drivers/acpi/arm64/iort.c
> >> @@ -356,7 +356,8 @@ static struct acpi_iort_node
> *iort_node_get_id(struct acpi_iort_node *node,
> >>   	if (map->flags & ACPI_IORT_ID_SINGLE_MAPPING) {
> >>   		if (node->type == ACPI_IORT_NODE_NAMED_COMPONENT ||
> >>   		    node->type == ACPI_IORT_NODE_PCI_ROOT_COMPLEX ||
> >> -		    node->type == ACPI_IORT_NODE_SMMU_V3) {
> >> +		    node->type == ACPI_IORT_NODE_SMMU_V3 ||
> >> +		    node->type == ACPI_IORT_NODE_PMCG) {
> >>   			*id_out = map->output_base;
> >>   			return parent;
> >>   		}
> >> @@ -394,6 +395,8 @@ static int iort_get_id_mapping_index(struct
> acpi_iort_node *node)
> >>   		}
> >>
> >>   		return smmu->id_mapping_index;
> >> +	case ACPI_IORT_NODE_PMCG:
> >> +		return 0;
> >>   	default:
> >>   		return -EINVAL;
> >>   	}
> >> @@ -1309,6 +1312,50 @@ static bool __init arm_smmu_is_coherent(struct
> acpi_iort_node *node)
> >>   	return smmu->flags & ACPI_IORT_SMMU_COHERENT_WALK;
> >>   }
> >>
> >> +static void __init arm_smmu_common_dma_configure(struct device *dev,
> >> +						enum dev_dma_attr attr)
> >> +{
> >> +	/* We expect the dma masks to be equivalent for all SMMUs set-ups */
> >> +	dev->dma_mask = &dev->coherent_dma_mask;
> >> +
> >> +	/* Configure DMA for the page table walker */
> >> +	acpi_dma_configure(dev, attr);
> >> +}
> >
> > It looks like we can't get rid of this acpi_dma_configure() call
> > given that the platform device we create has no ACPI companion
> > (and I am not looking forward to fabricating one to make the
> > code homogeneous :)).
> 
> Yeah, given that this is essentially only for SMMUs, the alternatives
> all end up looking like too much bother to be worthwhile.
> 
> > Still, having two methods per IORT node type (dev_is_coherent() and
> > dev_dma_configure()) does not make much sense, we can merge it into one
> > I think.
> 
> Good point - looks the attr from dev_is_coherent is only ever passed
> through dev_dma_configure, so we may as well just have per-SMMU-type
> dev_dma_configure methods which retrieve their own relevant coherency
> directly. FWIW, on v2 I was tempted to suggest just wrapping the DMA
> setup in "if (node->type != ACPI_IORT_NODE_PMCG)..." rather than messing
> with more callbacks, but that clearly wouldn't fit well with the local
> style here.

Right,  attr is passed to dev_dma_configure only. I will merge the callbacks
as suggested in the next revision.

Thanks,
Shameer

> Robin.
> 
> >
> > Thanks,
> > Lorenzo
> >
> >> +static int __init arm_smmu_v3_pmcg_count_resources(struct
> acpi_iort_node *node)
> >> +{
> >> +	struct acpi_iort_pmcg *pmcg;
> >> +
> >> +	/* Retrieve PMCG specific data */
> >> +	pmcg = (struct acpi_iort_pmcg *)node->node_data;
> >> +
> >> +	/*
> >> +	 * There are always 2 memory resources.
> >> +	 * If the overflow_gsiv is present then add that for a total of 3.
> >> +	 */
> >> +	return pmcg->overflow_gsiv ? 3 : 2;
> >> +}
> >> +
> >> +static void __init arm_smmu_v3_pmcg_init_resources(struct resource
> *res,
> >> +					       struct acpi_iort_node *node)
> >> +{
> >> +	struct acpi_iort_pmcg *pmcg;
> >> +
> >> +	/* Retrieve PMCG specific data */
> >> +	pmcg = (struct acpi_iort_pmcg *)node->node_data;
> >> +
> >> +	res[0].start = pmcg->page0_base_address;
> >> +	res[0].end = pmcg->page0_base_address + SZ_4K - 1;
> >> +	res[0].flags = IORESOURCE_MEM;
> >> +	res[1].start = pmcg->page1_base_address;
> >> +	res[1].end = pmcg->page1_base_address + SZ_4K - 1;
> >> +	res[1].flags = IORESOURCE_MEM;
> >> +
> >> +	if (pmcg->overflow_gsiv)
> >> +		acpi_iort_register_irq(pmcg->overflow_gsiv, "overflow",
> >> +				       ACPI_EDGE_SENSITIVE, &res[2]);
> >> +}
> >> +
> >>   struct iort_dev_config {
> >>   	const char *name;
> >>   	int (*dev_init)(struct acpi_iort_node *node);
> >> @@ -1318,6 +1365,8 @@ struct iort_dev_config {
> >>   				     struct acpi_iort_node *node);
> >>   	void (*dev_set_proximity)(struct device *dev,
> >>   				    struct acpi_iort_node *node);
> >> +	void (*dev_dma_configure)(struct device *dev,
> >> +					enum dev_dma_attr attr);
> >>   };
> >>
> >>   static const struct iort_dev_config iort_arm_smmu_v3_cfg __initconst = {
> >> @@ -1326,23 +1375,34 @@ static const struct iort_dev_config
> iort_arm_smmu_v3_cfg __initconst = {
> >>   	.dev_count_resources = arm_smmu_v3_count_resources,
> >>   	.dev_init_resources = arm_smmu_v3_init_resources,
> >>   	.dev_set_proximity = arm_smmu_v3_set_proximity,
> >> +	.dev_dma_configure = arm_smmu_common_dma_configure,
> >>   };
> >>
> >>   static const struct iort_dev_config iort_arm_smmu_cfg __initconst = {
> >>   	.name = "arm-smmu",
> >>   	.dev_is_coherent = arm_smmu_is_coherent,
> >>   	.dev_count_resources = arm_smmu_count_resources,
> >> -	.dev_init_resources = arm_smmu_init_resources
> >> +	.dev_init_resources = arm_smmu_init_resources,
> >> +	.dev_dma_configure = arm_smmu_common_dma_configure,
> >> +};
> >> +
> >> +static const struct iort_dev_config iort_arm_smmu_v3_pmcg_cfg
> __initconst = {
> >> +	.name = "arm-smmu-v3-pmu",
> >> +	.dev_count_resources = arm_smmu_v3_pmcg_count_resources,
> >> +	.dev_init_resources = arm_smmu_v3_pmcg_init_resources,
> >>   };
> >>
> >>   static __init const struct iort_dev_config *iort_get_dev_cfg(
> >>   			struct acpi_iort_node *node)
> >>   {
> >> +
> >>   	switch (node->type) {
> >>   	case ACPI_IORT_NODE_SMMU_V3:
> >>   		return &iort_arm_smmu_v3_cfg;
> >>   	case ACPI_IORT_NODE_SMMU:
> >>   		return &iort_arm_smmu_cfg;
> >> +	case ACPI_IORT_NODE_PMCG:
> >> +		return &iort_arm_smmu_v3_pmcg_cfg;
> >>   	default:
> >>   		return NULL;
> >>   	}
> >> @@ -1398,12 +1458,6 @@ static int __init iort_add_platform_device(struct
> acpi_iort_node *node,
> >>   	if (ret)
> >>   		goto dev_put;
> >>
> >> -	/*
> >> -	 * We expect the dma masks to be equivalent for
> >> -	 * all SMMUs set-ups
> >> -	 */
> >> -	pdev->dev.dma_mask = &pdev->dev.coherent_dma_mask;
> >> -
> >>   	fwnode = iort_get_fwnode(node);
> >>
> >>   	if (!fwnode) {
> >> @@ -1413,11 +1467,11 @@ static int __init
> iort_add_platform_device(struct acpi_iort_node *node,
> >>
> >>   	pdev->dev.fwnode = fwnode;
> >>
> >> -	attr = ops->dev_is_coherent && ops->dev_is_coherent(node) ?
> >> +	if (ops->dev_dma_configure) {
> >> +		attr = ops->dev_is_coherent && ops->dev_is_coherent(node) ?
> >>   			DEV_DMA_COHERENT : DEV_DMA_NON_COHERENT;
> >> -
> >> -	/* Configure DMA for the page table walker */
> >> -	acpi_dma_configure(&pdev->dev, attr);
> >> +		ops->dev_dma_configure(&pdev->dev, attr);
> >> +	}
> >>
> >>   	iort_set_device_domain(&pdev->dev, node);
> >>
> >> --
> >> 2.7.4
> >>
> >>
