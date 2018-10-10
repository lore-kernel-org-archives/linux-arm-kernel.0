From: laurentiu.tudor@nxp.com (laurentiu.tudor at nxp.com)
Date: Wed, 10 Oct 2018 15:07:20 +0300
Subject: [PATCH v3 02/22] soc/fsl/bman: map FBPR area in the iommu
In-Reply-To: <20181010120737.30300-1-laurentiu.tudor@nxp.com>
References: <20181010120737.30300-1-laurentiu.tudor@nxp.com>
Message-ID: <20181010120737.30300-3-laurentiu.tudor@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

Add a one-to-one iommu mapping for bman private data memory (FBPR).
This is required for BMAN to work without faults behind an iommu.

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
 drivers/soc/fsl/qbman/bman_ccsr.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/soc/fsl/qbman/bman_ccsr.c b/drivers/soc/fsl/qbman/bman_ccsr.c
index 05c42235dd41..d180da003e4a 100644
--- a/drivers/soc/fsl/qbman/bman_ccsr.c
+++ b/drivers/soc/fsl/qbman/bman_ccsr.c
@@ -29,6 +29,7 @@
  */
 
 #include "bman_priv.h"
+#include <linux/iommu.h>
 
 u16 bman_ip_rev;
 EXPORT_SYMBOL(bman_ip_rev);
@@ -171,6 +172,7 @@ static int fsl_bman_probe(struct platform_device *pdev)
 	int ret, err_irq;
 	struct device *dev = &pdev->dev;
 	struct device_node *node = dev->of_node;
+	struct iommu_domain *domain;
 	struct resource *res;
 	u16 id, bm_pool_cnt;
 	u8 major, minor;
@@ -216,6 +218,15 @@ static int fsl_bman_probe(struct platform_device *pdev)
 
 	dev_dbg(dev, "Allocated FBPR 0x%llx 0x%zx\n", fbpr_a, fbpr_sz);
 
+	/* Create an 1-to-1 iommu mapping for FBPR area */
+	domain = iommu_get_domain_for_dev(dev);
+	if (domain) {
+		ret = iommu_map(domain, fbpr_a, fbpr_a, fbpr_sz,
+				IOMMU_READ | IOMMU_WRITE | IOMMU_CACHE);
+		if (ret)
+			dev_warn(dev, "failed to iommu_map() %d\n", ret);
+	}
+
 	bm_set_memory(fbpr_a, fbpr_sz);
 
 	err_irq = platform_get_irq(pdev, 0);
-- 
2.17.1
