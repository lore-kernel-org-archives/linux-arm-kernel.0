From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Tue, 15 Aug 2017 18:15:25 +0100
Subject: [RFC PATCH 4/4] ACPI: IORT: Add SMMUv3 MSI support
In-Reply-To: <CAGHbJ3AgEvbpsPdeqJ+bFWa5hBMqxBX6g1eC4HiUvHarJf8H+g@mail.gmail.com>
References: <1502276017-63108-1-git-send-email-guohanjun@huawei.com>
 <1502276017-63108-5-git-send-email-guohanjun@huawei.com>
 <20170811093348.GC26039@red-moon>
 <CAGHbJ3AgEvbpsPdeqJ+bFWa5hBMqxBX6g1eC4HiUvHarJf8H+g@mail.gmail.com>
Message-ID: <20170815171525.GB13707@e107981-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 11, 2017 at 09:56:31PM +0800, Hanjun Guo wrote:
> Hi Lorenzo,
> 
> On 11 August 2017 at 17:33, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote:
> > On Wed, Aug 09, 2017 at 06:53:37PM +0800, Hanjun Guo wrote:
> >> From: Hanjun Guo <hanjun.guo@linaro.org>
> >>
> >> Since we have a mapping index for SMMUv3 MSI, we can
> >> directly use that index to get the map entry, then
> >> retrieve dev ID and ITS parent to add SMMUv3 MSI
> >> support.
> >>
> >> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> >> ---
> >>  drivers/acpi/arm64/iort.c | 46 ++++++++++++++++++++++++++++++++++++----------
> >>  1 file changed, 36 insertions(+), 10 deletions(-)
> >>
> >> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> >> index 9439f02..ce03298 100644
> >> --- a/drivers/acpi/arm64/iort.c
> >> +++ b/drivers/acpi/arm64/iort.c
> >> @@ -313,7 +313,8 @@ static int iort_id_map(struct acpi_iort_id_mapping *map, u8 type, u32 rid_in,
> >>       /* Single mapping does not care for input id */
> >>       if (map->flags & ACPI_IORT_ID_SINGLE_MAPPING) {
> >>               if (type == ACPI_IORT_NODE_NAMED_COMPONENT ||
> >> -                 type == ACPI_IORT_NODE_PCI_ROOT_COMPLEX) {
> >> +                 type == ACPI_IORT_NODE_PCI_ROOT_COMPLEX ||
> >> +                 type == ACPI_IORT_NODE_SMMU_V3) {
> >>                       *rid_out = map->output_base;
> >>                       return 0;
> >>               }
> >> @@ -357,7 +358,8 @@ struct acpi_iort_node *iort_node_get_id(struct acpi_iort_node *node,
> >>
> >>       if (map->flags & ACPI_IORT_ID_SINGLE_MAPPING) {
> >>               if (node->type == ACPI_IORT_NODE_NAMED_COMPONENT ||
> >> -                 node->type == ACPI_IORT_NODE_PCI_ROOT_COMPLEX) {
> >> +                 node->type == ACPI_IORT_NODE_PCI_ROOT_COMPLEX ||
> >> +                 node->type == ACPI_IORT_NODE_SMMU_V3) {
> >>                       *id_out = map->output_base;
> >>                       return parent;
> >>               }
> >> @@ -549,9 +551,21 @@ int iort_pmsi_get_dev_id(struct device *dev, u32 *dev_id)
> >>       if (!node)
> >>               return -ENODEV;
> >>
> >> -     for (i = 0; i < node->mapping_count; i++) {
> >> -             if (iort_node_map_platform_id(node, dev_id, IORT_MSI_TYPE, i))
> >> +     if (node->type == ACPI_IORT_NODE_SMMU_V3) {
> >> +             u32 index;
> >> +
> >> +             if (iort_get_smmu_v3_id_mapping_index(node, &index))
> >> +                     return -ENODEV;
> >> +
> >> +             if (iort_node_map_platform_id(node, dev_id, IORT_MSI_TYPE,
> >> +                 index))
> >>                       return 0;
> >> +     } else {
> >> +             for (i = 0; i < node->mapping_count; i++) {
> >> +                     if (iort_node_map_platform_id(node, dev_id,
> >> +                         IORT_MSI_TYPE, i))
> >> +                             return 0;
> >> +             }
> >>       }
> >>
> >>       return -ENODEV;
> >> @@ -626,20 +640,30 @@ static struct irq_domain *iort_get_platform_device_domain(struct device *dev)
> >>       struct acpi_iort_node *node, *msi_parent;
> >>       struct fwnode_handle *iort_fwnode;
> >>       struct acpi_iort_its_group *its;
> >> -     int i;
> >>
> >>       /* find its associated iort node */
> >> -     node = iort_scan_node(ACPI_IORT_NODE_NAMED_COMPONENT,
> >> -                           iort_match_node_callback, dev);
> >> +     node = iort_find_dev_node(dev);
> >>       if (!node)
> >>               return NULL;
> >>
> >>       /* then find its msi parent node */
> >> -     for (i = 0; i < node->mapping_count; i++) {
> >> +     if (node->type == ACPI_IORT_NODE_SMMU_V3) {
> >> +             u32 index;
> >> +
> >> +             if (iort_get_smmu_v3_id_mapping_index(node, &index))
> >> +                     return NULL;
> >> +
> >>               msi_parent = iort_node_map_platform_id(node, NULL,
> >> +                                                    IORT_MSI_TYPE, index);
> >> +     } else {
> >> +             int i;
> >> +
> >> +             for (i = 0; i < node->mapping_count; i++) {
> >> +                     msi_parent = iort_node_map_platform_id(node, NULL,
> >>                                                      IORT_MSI_TYPE, i);
> >> -             if (msi_parent)
> >> -                     break;
> >> +                     if (msi_parent)
> >> +                             break;
> >> +             }
> >>       }
> >>
> >>       if (!msi_parent)
> >> @@ -1233,6 +1257,8 @@ static int __init iort_add_smmu_platform_device(struct acpi_iort_node *node)
> >>       /* Configure DMA for the page table walker */
> >>       acpi_dma_configure(&pdev->dev, attr);
> >>
> >> +     acpi_configure_pmsi_domain(&pdev->dev);
> >
> > I think this is just overkill. There are two separate things to solve
> > here:
> >
> > 1) Make single mappings valid for SMMUv3 (and PMCG); that's fair enough
> >    and goes with the logic to skip the ITS DeviceID index for "normal"
> >    mappings, I can live with that
> > 2) Find the MSI domain for an SMMUv3 (or any other IORT table node); I
> >    do not think you need all this complexity to do it via
> >    acpi_configure_pmsi_domain(), it can be done in a easier way with
> >    an ad-hoc stub (it does not even have to be SMMUv3 specific)
> >
> > My worry is that we are peppering the generic IORT mapping code with
> > node types specific kludges and it is becoming a mess.
> 
> Agreed.
> 
> >
> > I can rework the patch to show you what I have in mind, please let
> > me know.
> 
> Please, thank you very much for doing so.

Here, untested just to get your opinion, please let me know.

Thanks,
Lorenzo

-- >8 --
Subject: [PATCH 4/4] ACPI/IORT: IORT nodes MSI handling

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 drivers/acpi/arm64/iort.c | 76 +++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 63 insertions(+), 13 deletions(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 24678c3..21a0aab 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -366,7 +366,7 @@ struct acpi_iort_node *iort_node_get_id(struct acpi_iort_node *node,
 	return NULL;
 }
 
-static int iort_get_smmu_v3_id_mapping_index(struct acpi_iort_node *node,
+static int iort_get_id_mapping_index(struct acpi_iort_node *node,
 					     u32 *index)
 {
 	struct acpi_iort_smmu_v3 *smmu;
@@ -378,20 +378,25 @@ static int iort_get_smmu_v3_id_mapping_index(struct acpi_iort_node *node,
 	if (node->revision < 1)
 		return -EINVAL;
 
-	smmu = (struct acpi_iort_smmu_v3 *)node->node_data;
-	/* if any of the gsi for control interrupts is not 0, ignore the MSI */
-	if (smmu->event_gsiv || smmu->pri_gsiv || smmu->gerr_gsiv
-	    || smmu->sync_gsiv)
-		return -EINVAL;
+	switch (node->type) {
+	case ACPI_IORT_NODE_SMMU_V3:
+		smmu = (struct acpi_iort_smmu_v3 *)node->node_data;
+		/* if any of the gsi for control interrupts is not 0, ignore the MSI */
+		if (smmu->event_gsiv || smmu->pri_gsiv || smmu->gerr_gsiv
+		    || smmu->sync_gsiv)
+			return -EINVAL;
+
+		if (smmu->id_mapping_index >= node->mapping_count) {
+			pr_err(FW_BUG "[node %p type %d] ID mapping index overflows valid mappings\n",
+			       node, node->type);
+			return -EINVAL;
+		}
 
-	if (smmu->id_mapping_index >= node->mapping_count) {
-		pr_err(FW_BUG "[node %p type %d] ID mapping index overflows valid mappings\n",
-		       node, node->type);
+		*index = smmu->id_mapping_index;
+		return 0;
+	default:
 		return -EINVAL;
 	}
-
-	*index = smmu->id_mapping_index;
-	return 0;
 }
 
 static struct acpi_iort_node *iort_node_map_id(struct acpi_iort_node *node,
@@ -431,7 +436,7 @@ static struct acpi_iort_node *iort_node_map_id(struct acpi_iort_node *node,
 		 *  associated ID map for single mapping cases.
 		 */
 		if (node->type == ACPI_IORT_NODE_SMMU_V3)
-			ret = iort_get_smmu_v3_id_mapping_index(node, &index);
+			ret = iort_get_id_mapping_index(node, &index);
 
 		/* Do the ID translation */
 		for (i = 0; i < node->mapping_count; i++, map++) {
@@ -620,6 +625,49 @@ struct irq_domain *iort_get_device_domain(struct device *dev, u32 req_id)
 	return irq_find_matching_fwnode(handle, DOMAIN_BUS_PCI_MSI);
 }
 
+static void iort_set_device_domain(struct device *dev,
+				   struct acpi_iort_node *node)
+{
+	struct acpi_iort_its_group *its;
+	struct acpi_iort_node *msi_parent;
+	struct acpi_iort_id_mapping *map;
+	struct fwnode_handle *iort_fwnode;
+	struct irq_domain *domain;
+	int ret, index;
+
+	ret = iort_get_id_mapping_index(node, &index);
+	if (ret < 0)
+		return;
+
+	map = ACPI_ADD_PTR(struct acpi_iort_id_mapping, node,
+			   node->mapping_offset + index * sizeof(*map));
+
+	/* Firmware bug! */
+	if (!map->output_reference ||
+			!(map->flags & ACPI_IORT_ID_SINGLE_MAPPING)) {
+		pr_err(FW_BUG "[node %p type %d] Invalid MSI mapping\n",
+		       node, node->type);
+		return;
+	}
+
+	msi_parent = ACPI_ADD_PTR(struct acpi_iort_node, iort_table,
+				  map->output_reference);
+
+	if (!msi_parent || msi_parent->type != ACPI_IORT_NODE_ITS_GROUP)
+		return;
+
+	/* Move to ITS specific data */
+	its = (struct acpi_iort_its_group *)msi_parent->node_data;
+
+	iort_fwnode = iort_find_domain_token(its->identifiers[0]);
+	if (!iort_fwnode)
+		return;
+
+	domain = irq_find_matching_fwnode(iort_fwnode, DOMAIN_BUS_PLATFORM_MSI);
+	if (domain)
+		dev_set_msi_domain(dev, domain);
+}
+
 /**
  * iort_get_platform_device_domain() - Find MSI domain related to a
  * platform device
@@ -1159,6 +1207,8 @@ static int __init iort_add_smmu_platform_device(struct acpi_iort_node *node)
 	/* Configure DMA for the page table walker */
 	acpi_dma_configure(&pdev->dev, attr);
 
+	iort_set_device_domain(&pdev->dev, node);
+
 	ret = platform_device_add(pdev);
 	if (ret)
 		goto dma_deconfigure;
-- 
2.10.0
