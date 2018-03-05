From: nipun.gupta@nxp.com (Nipun Gupta)
Date: Mon,  5 Mar 2018 19:59:25 +0530
Subject: [PATCH 5/6] dma-mapping: support fsl-mc bus
In-Reply-To: <1520260166-29387-1-git-send-email-nipun.gupta@nxp.com>
References: <1520260166-29387-1-git-send-email-nipun.gupta@nxp.com>
Message-ID: <1520260166-29387-6-git-send-email-nipun.gupta@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nipun Gupta <nipun.gupta@nxp.com>
---
 drivers/base/dma-mapping.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/base/dma-mapping.c b/drivers/base/dma-mapping.c
index 3b11835..2279c4d 100644
--- a/drivers/base/dma-mapping.c
+++ b/drivers/base/dma-mapping.c
@@ -334,6 +334,7 @@ void dma_common_free_remap(void *cpu_addr, size_t size, unsigned long vm_flags)
  * Common configuration to enable DMA API use for a device
  */
 #include <linux/pci.h>
+#include <linux/fsl/mc.h>
 
 int dma_configure(struct device *dev)
 {
@@ -349,6 +350,12 @@ int dma_configure(struct device *dev)
 			dma_dev = dma_dev->parent;
 	}
 
+	if (dev_is_fsl_mc(dev)) {
+		dma_dev = dev;
+		while (dev_is_fsl_mc(dma_dev))
+			dma_dev = dma_dev->parent;
+	}
+
 	if (dma_dev->of_node) {
 		ret = of_dma_configure(dev, dma_dev->of_node);
 	} else if (has_acpi_companion(dma_dev)) {
-- 
1.9.1
