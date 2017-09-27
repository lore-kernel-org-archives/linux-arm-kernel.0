From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Wed, 27 Sep 2017 09:20:15 +0800
Subject: [PATCH 4/4] ACPI: IORT: SMMUv3 nodes MSI support
In-Reply-To: <1506475215-2731-1-git-send-email-hanjun.guo@linaro.org>
References: <1506475215-2731-1-git-send-email-hanjun.guo@linaro.org>
Message-ID: <1506475215-2731-5-git-send-email-hanjun.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

Since we make single mappings valid for SMMUv3 (and PMCG), also
we have a mapping index for SMMUv3 MSI, we can directly use that
index to get the map entry, then retrieve ITS parent to add SMMUv3
MSI support.

Introduce a new API iort_set_device_domain() to find the MSI domain
for an SMMUv3 (or any other IORT table node) to reduce the complex
of doing that via acpi_configure_pmsi_domain().

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 drivers/acpi/arm64/iort.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 1c1160e..06b38de 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -633,6 +633,49 @@ struct irq_domain *iort_get_device_domain(struct device *dev, u32 req_id)
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
+	int index;
+
+	index = iort_get_id_mapping_index(node);
+	if (index < 0)
+		return;
+
+	map = ACPI_ADD_PTR(struct acpi_iort_id_mapping, node,
+			   node->mapping_offset + index * sizeof(*map));
+
+	/* Firmware bug! */
+	if (!map->output_reference ||
+	    !(map->flags & ACPI_IORT_ID_SINGLE_MAPPING)) {
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
@@ -1259,6 +1302,8 @@ static int __init iort_add_smmu_platform_device(struct acpi_iort_node *node)
 	/* Configure DMA for the page table walker */
 	acpi_dma_configure(&pdev->dev, attr);
 
+	iort_set_device_domain(&pdev->dev, node);
+
 	ret = platform_device_add(pdev);
 	if (ret)
 		goto dma_deconfigure;
-- 
1.9.1
