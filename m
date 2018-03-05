From: nipun.gupta@nxp.com (Nipun Gupta)
Date: Mon,  5 Mar 2018 19:59:22 +0530
Subject: [PATCH 2/6] iommu: support iommu configuration for fsl-mc devices
In-Reply-To: <1520260166-29387-1-git-send-email-nipun.gupta@nxp.com>
References: <1520260166-29387-1-git-send-email-nipun.gupta@nxp.com>
Message-ID: <1520260166-29387-3-git-send-email-nipun.gupta@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nipun Gupta <nipun.gupta@nxp.com>
---
 drivers/iommu/of_iommu.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 5c36a8b..cc2fb9c 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -24,6 +24,7 @@
 #include <linux/of_iommu.h>
 #include <linux/of_pci.h>
 #include <linux/slab.h>
+#include <linux/fsl/mc.h>
 
 #define NO_IOMMU	1
 
@@ -160,6 +161,26 @@ static int of_pci_iommu_init(struct pci_dev *pdev, u16 alias, void *data)
 	return err;
 }
 
+static int
+of_fsl_mc_iommu_init(struct fsl_mc_device *mc_dev,
+		      struct device_node *master_np)
+{
+	struct of_phandle_args iommu_spec;
+	int err;
+
+	iommu_spec.np = of_parse_phandle(master_np, "iommu-parent", 0);
+	if (!iommu_spec.np)
+		return NO_IOMMU;
+
+	iommu_spec.args[0] = mc_dev->icid;
+	iommu_spec.args_count = 1;
+
+	err = of_iommu_xlate(&mc_dev->dev, &iommu_spec);
+	of_node_put(iommu_spec.np);
+
+	return err;
+}
+
 const struct iommu_ops *of_iommu_configure(struct device *dev,
 					   struct device_node *master_np)
 {
@@ -191,6 +212,8 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
 
 		err = pci_for_each_dma_alias(to_pci_dev(dev),
 					     of_pci_iommu_init, &info);
+	} else if (dev_is_fsl_mc(dev)) {
+		err = of_fsl_mc_iommu_init(to_fsl_mc_device(dev), master_np);
 	} else {
 		struct of_phandle_args iommu_spec;
 		int idx = 0;
-- 
1.9.1
