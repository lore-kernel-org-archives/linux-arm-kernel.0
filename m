From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Thu, 17 Oct 2013 18:43:23 +0100
Subject: [PATCH v8 08/19] arm/xen: get_dma_ops: return xen_dma_ops if we are
 running as xen_initial_domain
In-Reply-To: <alpine.DEB.2.02.1310171833520.26077@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1310171833520.26077@kaball.uk.xensource.com>
Message-ID: <1382031814-8782-8-git-send-email-stefano.stabellini@eu.citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We can't simply override arm_dma_ops with xen_dma_ops because devices
are allowed to have their own dma_ops and they take precedence over
arm_dma_ops. When running on Xen as initial domain, we always want
xen_dma_ops to be the one in use.

Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
CC: will.deacon at arm.com
CC: linux at arm.linux.org.uk

Changes in v7:
- return xen_dma_ops only if we are the initial domain;
- rename __get_dma_ops to __generic_dma_ops.
---
 arch/arm/include/asm/dma-mapping.h |   13 ++++++++++++-
 1 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/arch/arm/include/asm/dma-mapping.h b/arch/arm/include/asm/dma-mapping.h
index 01b5a3d..f5945d4 100644
--- a/arch/arm/include/asm/dma-mapping.h
+++ b/arch/arm/include/asm/dma-mapping.h
@@ -12,17 +12,28 @@
 #include <asm/memory.h>
 #include <asm/cacheflush.h>
 
+#include <xen/xen.h>
+#include <asm/xen/hypervisor.h>
+
 #define DMA_ERROR_CODE	(~0)
 extern struct dma_map_ops arm_dma_ops;
 extern struct dma_map_ops arm_coherent_dma_ops;
 
-static inline struct dma_map_ops *get_dma_ops(struct device *dev)
+static inline struct dma_map_ops *__generic_dma_ops(struct device *dev)
 {
 	if (dev && dev->archdata.dma_ops)
 		return dev->archdata.dma_ops;
 	return &arm_dma_ops;
 }
 
+static inline struct dma_map_ops *get_dma_ops(struct device *dev)
+{
+	if (xen_initial_domain())
+		return xen_dma_ops;
+	else
+		return __generic_dma_ops(dev);
+}
+
 static inline void set_dma_ops(struct device *dev, struct dma_map_ops *ops)
 {
 	BUG_ON(!dev);
-- 
1.7.2.5
