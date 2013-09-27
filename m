From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Fri, 27 Sep 2013 17:09:57 +0100
Subject: [PATCH v6 09/19] arm64/xen: get_dma_ops: return xen_dma_ops if we are
 running on Xen
In-Reply-To: <alpine.DEB.2.02.1309271653420.5498@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1309271653420.5498@kaball.uk.xensource.com>
Message-ID: <1380298207-29151-9-git-send-email-stefano.stabellini@eu.citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
CC: catalin.marinas at arm.com
CC: will.deacon at arm.com
---
 arch/arm64/include/asm/dma-mapping.h |   13 ++++++++++++-
 1 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/arch/arm64/include/asm/dma-mapping.h b/arch/arm64/include/asm/dma-mapping.h
index c2cb8a0..1dbd1d5 100644
--- a/arch/arm64/include/asm/dma-mapping.h
+++ b/arch/arm64/include/asm/dma-mapping.h
@@ -23,12 +23,15 @@
 
 #include <asm-generic/dma-coherent.h>
 
+#include <xen/xen.h>
+#include <asm/xen/hypervisor.h>
+
 #define ARCH_HAS_DMA_GET_REQUIRED_MASK
 
 #define DMA_ERROR_CODE	(~0)
 extern struct dma_map_ops *dma_ops;
 
-static inline struct dma_map_ops *get_dma_ops(struct device *dev)
+static inline struct dma_map_ops *__get_dma_ops(struct device *dev)
 {
 	if (unlikely(!dev) || !dev->archdata.dma_ops)
 		return dma_ops;
@@ -36,6 +39,14 @@ static inline struct dma_map_ops *get_dma_ops(struct device *dev)
 		return dev->archdata.dma_ops;
 }
 
+static inline struct dma_map_ops *get_dma_ops(struct device *dev)
+{
+	if (xen_domain())
+		return xen_dma_ops;
+	else
+		return __get_dma_ops(dev);
+}
+
 #include <asm-generic/dma-mapping-common.h>
 
 static inline dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr)
-- 
1.7.2.5
