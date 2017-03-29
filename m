From: roy.pledge@nxp.com (Roy Pledge)
Date: Wed, 29 Mar 2017 17:13:53 -0400
Subject: [RFC PATCH 1/5] soc/fsl/qbman: Use shared-dma-pool for BMan private
 memory allocations
In-Reply-To: <1490822037-6752-1-git-send-email-roy.pledge@nxp.com>
References: <1490822037-6752-1-git-send-email-roy.pledge@nxp.com>
Message-ID: <1490822037-6752-2-git-send-email-roy.pledge@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the shared-memory-pool mechanism for free buffer proxy record
area allocation.

Signed-off-by: Roy Pledge <roy.pledge@nxp.com>
---
 drivers/soc/fsl/qbman/bman_ccsr.c | 27 ++++++++++++++++++++++++++-
 drivers/soc/fsl/qbman/bman_priv.h |  3 +++
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/fsl/qbman/bman_ccsr.c b/drivers/soc/fsl/qbman/bman_ccsr.c
index a8e8389..5485c3c 100644
--- a/drivers/soc/fsl/qbman/bman_ccsr.c
+++ b/drivers/soc/fsl/qbman/bman_ccsr.c
@@ -170,10 +170,11 @@ static int fsl_bman_probe(struct platform_device *pdev)
 {
 	int ret, err_irq;
 	struct device *dev = &pdev->dev;
-	struct device_node *node = dev->of_node;
+	struct device_node *mem_node, *node = dev->of_node;
 	struct resource *res;
 	u16 id, bm_pool_cnt;
 	u8 major, minor;
+	u64 size;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res) {
@@ -201,6 +202,30 @@ static int fsl_bman_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
+	ret = of_reserved_mem_device_init(dev);
+	if (ret) {
+		dev_err(dev, "of_reserved_mem_device_init() failed 0x%x\n", ret);
+		return -ENODEV;
+	}
+	mem_node = of_parse_phandle(dev->of_node, "memory-region", 0);
+	if (mem_node) {
+		ret = of_property_read_u64(mem_node, "size", &size);
+		if (ret) {
+			dev_err(dev, "FBPR: of_address_to_resource fails 0x%x\n", ret);
+			return -ENODEV;
+		}
+		fbpr_sz = size;
+	} else {
+		dev_err(dev, "No memory-region found for FBPR\n");
+		return -ENODEV;
+	}
+	if (!dma_zalloc_coherent(dev, fbpr_sz, &fbpr_a, 0)) {
+		dev_err(dev, "Alloc FBPR memory failed\n");
+		return -ENODEV;
+	}
+
+	dev_info(dev, "Allocated FBPR 0x%llx 0x%zx\n", fbpr_a, fbpr_sz);
+
 	bm_set_memory(fbpr_a, fbpr_sz);
 
 	err_irq = platform_get_irq(pdev, 0);
diff --git a/drivers/soc/fsl/qbman/bman_priv.h b/drivers/soc/fsl/qbman/bman_priv.h
index f6896a2..765a4bf 100644
--- a/drivers/soc/fsl/qbman/bman_priv.h
+++ b/drivers/soc/fsl/qbman/bman_priv.h
@@ -33,6 +33,9 @@
 #include "dpaa_sys.h"
 
 #include <soc/fsl/bman.h>
+#include <linux/dma-contiguous.h>
+#include <linux/of_address.h>
+#include <linux/dma-mapping.h>
 
 /* Portal processing (interrupt) sources */
 #define BM_PIRQ_RCRI	0x00000002	/* RCR Ring (below threshold) */
-- 
2.9.3
