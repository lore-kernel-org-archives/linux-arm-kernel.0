From: laurentiu.tudor@nxp.com (laurentiu.tudor at nxp.com)
Date: Wed, 10 Oct 2018 15:07:22 +0300
Subject: [PATCH v3 04/22] soc/fsl/qman-portal: map CENA area in the iommu
In-Reply-To: <20181010120737.30300-1-laurentiu.tudor@nxp.com>
References: <20181010120737.30300-1-laurentiu.tudor@nxp.com>
Message-ID: <20181010120737.30300-5-laurentiu.tudor@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

Add a one-to-one iommu mapping for qman portal CENA register area.
This is required for QMAN stashing to work without faults behind
an iommu.

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
 drivers/soc/fsl/qbman/qman_portal.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/soc/fsl/qbman/qman_portal.c b/drivers/soc/fsl/qbman/qman_portal.c
index a120002b630e..6d9da3b1b5ad 100644
--- a/drivers/soc/fsl/qbman/qman_portal.c
+++ b/drivers/soc/fsl/qbman/qman_portal.c
@@ -29,6 +29,7 @@
  */
 
 #include "qman_priv.h"
+#include <linux/iommu.h>
 
 struct qman_portal *qman_dma_portal;
 EXPORT_SYMBOL(qman_dma_portal);
@@ -222,6 +223,7 @@ static int qman_portal_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *node = dev->of_node;
+	struct iommu_domain *domain;
 	struct qm_portal_config *pcfg;
 	struct resource *addr_phys[2];
 	int irq, cpu, err;
@@ -276,6 +278,21 @@ static int qman_portal_probe(struct platform_device *pdev)
 		goto err_ioremap2;
 	}
 
+	/* Create an 1-to-1 iommu mapping for cena portal area */
+	domain = iommu_get_domain_for_dev(dev);
+	if (domain) {
+		/*
+		 * Note: not mapping this as cacheable triggers the infamous
+		 * QMan CIDE error.
+		 */
+		err = iommu_map(domain,
+				addr_phys[0]->start, addr_phys[0]->start,
+				resource_size(addr_phys[0]),
+				IOMMU_READ | IOMMU_WRITE | IOMMU_CACHE);
+		if (err)
+			dev_warn(dev, "failed to iommu_map() %d\n", err);
+	}
+
 	pcfg->pools = qm_get_pools_sdqcr();
 
 	spin_lock(&qman_lock);
-- 
2.17.1
