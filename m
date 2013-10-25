From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Fri, 25 Oct 2013 11:51:44 +0100
Subject: [PATCH v9 09/18] arm64/xen: get_dma_ops: return xen_dma_ops if we are
 running as xen_initial_domain
In-Reply-To: <alpine.DEB.2.02.1310251144020.26077@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1310251144020.26077@kaball.uk.xensource.com>
Message-ID: <1382698313-13161-9-git-send-email-stefano.stabellini@eu.citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We can't simply override arm_dma_ops with xen_dma_ops because devices
are allowed to have their own dma_ops and they take precedence over
arm_dma_ops. When running on Xen as initial domain, we always want
xen_dma_ops to be the one in use.

We introduce __generic_dma_ops to allow xen_dma_ops functions to call
back to the native implementation.

Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
CC: will.deacon at arm.com

Changes in v7:
- return xen_dma_ops only if we are the initial domain;
- rename __get_dma_ops to __generic_dma_ops.
---
 arch/arm64/include/asm/dma-mapping.h |   13 ++++++++++++-
 1 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/arch/arm64/include/asm/dma-mapping.h b/arch/arm64/include/asm/dma-mapping.h
index 59206b1..fd0c0c0 100644
--- a/arch/arm64/include/asm/dma-mapping.h
+++ b/arch/arm64/include/asm/dma-mapping.h
@@ -23,12 +23,15 @@
 
 #include <asm-generic/dma-coherent.h>
 
+#include <xen/xen.h>
+#include <asm/xen/hypervisor.h>
+
 #define ARCH_HAS_DMA_GET_REQUIRED_MASK
 
 #define DMA_ERROR_CODE	(~(dma_addr_t)0)
 extern struct dma_map_ops *dma_ops;
 
-static inline struct dma_map_ops *get_dma_ops(struct device *dev)
+static inline struct dma_map_ops *__generic_dma_ops(struct device *dev)
 {
 	if (unlikely(!dev) || !dev->archdata.dma_ops)
 		return dma_ops;
@@ -36,6 +39,14 @@ static inline struct dma_map_ops *get_dma_ops(struct device *dev)
 		return dev->archdata.dma_ops;
 }
 
+static inline struct dma_map_ops *get_dma_ops(struct device *dev)
+{
+	if (xen_initial_domain())
+		return xen_dma_ops;
+	else
+		return __generic_dma_ops(dev);
+}
+
 #include <asm-generic/dma-mapping-common.h>
 
 static inline dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr)
-- 
1.7.2.5
