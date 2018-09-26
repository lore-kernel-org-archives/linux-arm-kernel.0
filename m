From: laurentiu.tudor@nxp.com (laurentiu.tudor at nxp.com)
Date: Wed, 26 Sep 2018 16:22:28 +0300
Subject: [PATCH v2 03/22] soc/fsl/qman: map FQD and PFDR areas in the iommu
In-Reply-To: <20180926132247.10971-1-laurentiu.tudor@nxp.com>
References: <20180926132247.10971-1-laurentiu.tudor@nxp.com>
Message-ID: <20180926132247.10971-4-laurentiu.tudor@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

Add a one-to-one iommu mapping for qman private data memory areas
(FQD and PFDR). This is required for QMAN to work without faults
behind an iommu.

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
 drivers/soc/fsl/qbman/qman_ccsr.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/soc/fsl/qbman/qman_ccsr.c b/drivers/soc/fsl/qbman/qman_ccsr.c
index 619e22030460..0cfe79f85a66 100644
--- a/drivers/soc/fsl/qbman/qman_ccsr.c
+++ b/drivers/soc/fsl/qbman/qman_ccsr.c
@@ -29,6 +29,7 @@
  */
 
 #include "qman_priv.h"
+#include <linux/iommu.h>
 
 u16 qman_ip_rev;
 EXPORT_SYMBOL(qman_ip_rev);
@@ -692,6 +693,7 @@ static int fsl_qman_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *node = dev->of_node;
+	struct iommu_domain *domain;
 	struct resource *res;
 	int ret, err_irq;
 	u16 id;
@@ -769,6 +771,19 @@ static int fsl_qman_probe(struct platform_device *pdev)
 	}
 	dev_dbg(dev, "Allocated PFDR 0x%llx 0x%zx\n", pfdr_a, pfdr_sz);
 
+	/* Create an 1-to-1 iommu mapping for fqd and pfdr areas */
+	domain = iommu_get_domain_for_dev(dev);
+	if (domain) {
+		ret = iommu_map(domain, fqd_a, fqd_a, fqd_sz,
+				IOMMU_READ | IOMMU_WRITE | IOMMU_CACHE);
+		if (ret)
+			dev_warn(dev, "iommu_map(fqd) failed %d\n", ret);
+		ret = iommu_map(domain, pfdr_a, pfdr_a, pfdr_sz,
+				IOMMU_READ | IOMMU_WRITE | IOMMU_CACHE);
+		if (ret)
+			dev_warn(dev, "iommu_map(pfdr) failed %d\n", ret);
+	}
+
 	ret = qman_init_ccsr(dev);
 	if (ret) {
 		dev_err(dev, "CCSR setup failed\n");
-- 
2.17.1
