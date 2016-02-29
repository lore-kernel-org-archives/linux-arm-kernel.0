From: robin.murphy@arm.com (Robin Murphy)
Date: Mon, 29 Feb 2016 13:46:12 +0000
Subject: [PATCH 03/12] iommu/of: Handle iommu-map property for PCI
In-Reply-To: <cover.1456514380.git.robin.murphy@arm.com>
References: <cover.1456514380.git.robin.murphy@arm.com>
Message-ID: <961e88620bc9c113dbafa72081f864517fa1043c.1456514380.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have a way to pick up the RID translation and target IOMMU,
hook up of_iommu_configure() to bring PCI devices into the of_xlate
mechanism and allow them IOMMU-backed DMA ops without the need for
driver-specific handling.

CC: Rob Herring <robh+dt@kernel.org>
CC: Frank Rowand <frowand.list@gmail.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/of_iommu.c | 43 ++++++++++++++++++++++++++++++++++++-------
 1 file changed, 36 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 5fea665..910826c 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -22,6 +22,7 @@
 #include <linux/limits.h>
 #include <linux/of.h>
 #include <linux/of_iommu.h>
+#include <linux/of_pci.h>
 #include <linux/slab.h>
 
 static const struct of_device_id __iommu_of_table_sentinel
@@ -134,20 +135,48 @@ struct iommu_ops *of_iommu_get_ops(struct device_node *np)
 	return ops;
 }
 
+static int __get_pci_rid(struct pci_dev *pdev, u16 alias, void *data)
+{
+	struct of_phandle_args *iommu_spec = data;
+	struct device_node *np = pdev->bus->dev.of_node;
+
+	iommu_spec->args[0] = alias;
+	return np == iommu_spec->np;
+}
+
 struct iommu_ops *of_iommu_configure(struct device *dev,
 				     struct device_node *master_np)
 {
 	struct of_phandle_args iommu_spec;
-	struct device_node *np;
+	struct device_node *np = NULL;
 	struct iommu_ops *ops = NULL;
 	int idx = 0;
 
-	/*
-	 * We can't do much for PCI devices without knowing how
-	 * device IDs are wired up from the PCI bus to the IOMMU.
-	 */
-	if (dev_is_pci(dev))
-		return NULL;
+	if (dev_is_pci(dev)) {
+		/*
+		 * Start by tracing the RID alias down the PCI topology as
+		 * far as the host bridge whose OF node we have...
+		 */
+		iommu_spec.np = master_np;
+		pci_for_each_dma_alias(to_pci_dev(dev), __get_pci_rid,
+				       &iommu_spec);
+		/*
+		 * ...then find out what that becomes once it escapes the PCI
+		 * bus into the system beyond, and which IOMMU it ends up at.
+		 */
+		if (of_pci_map_rid(master_np, "iommu-map", iommu_spec.args[0],
+				   &np, iommu_spec.args))
+			return NULL;
+
+		iommu_spec.np = np;
+		iommu_spec.args_count = 1;
+		ops = of_iommu_get_ops(np);
+		if (!ops || !ops->of_xlate || ops->of_xlate(dev, &iommu_spec))
+			goto err_put_node;
+
+		of_node_put(np);
+		return ops;
+	}
 
 	/*
 	 * We don't currently walk up the tree looking for a parent IOMMU.
-- 
2.7.2.333.g70bd996.dirty
