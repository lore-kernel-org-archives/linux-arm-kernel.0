From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Mon, 5 Aug 2013 17:30:50 +0100
Subject: [PATCH v3 04/10] arm: introduce a global dma_ops pointer
In-Reply-To: <alpine.DEB.2.02.1308051503190.4893@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1308051503190.4893@kaball.uk.xensource.com>
Message-ID: <1375720256-8014-4-git-send-email-stefano.stabellini@eu.citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Initially set dma_ops to arm_dma_ops.


Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
CC: will.deacon at arm.com
CC: linux at arm.linux.org.uk


Changes in v3:
-  keep using arm_dma_ops in dmabounce.
---
 arch/arm/include/asm/dma-mapping.h |    3 ++-
 arch/arm/mm/dma-mapping.c          |    3 +++
 2 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/arch/arm/include/asm/dma-mapping.h b/arch/arm/include/asm/dma-mapping.h
index 5b8eef9..5c130bc 100644
--- a/arch/arm/include/asm/dma-mapping.h
+++ b/arch/arm/include/asm/dma-mapping.h
@@ -12,6 +12,7 @@
 #include <asm/memory.h>
 
 #define DMA_ERROR_CODE	(~0)
+extern struct dma_map_ops *dma_ops;
 extern struct dma_map_ops arm_dma_ops;
 extern struct dma_map_ops arm_coherent_dma_ops;
 
@@ -19,7 +20,7 @@ static inline struct dma_map_ops *get_dma_ops(struct device *dev)
 {
 	if (dev && dev->archdata.dma_ops)
 		return dev->archdata.dma_ops;
-	return &arm_dma_ops;
+	return dma_ops;
 }
 
 static inline void set_dma_ops(struct device *dev, struct dma_map_ops *ops)
diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 7f9b179..870b12c 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -141,6 +141,9 @@ struct dma_map_ops arm_dma_ops = {
 };
 EXPORT_SYMBOL(arm_dma_ops);
 
+struct dma_map_ops *dma_ops = &arm_dma_ops;
+EXPORT_SYMBOL(dma_ops);
+
 static void *arm_coherent_dma_alloc(struct device *dev, size_t size,
 	dma_addr_t *handle, gfp_t gfp, struct dma_attrs *attrs);
 static void arm_coherent_dma_free(struct device *dev, size_t size, void *cpu_addr,
-- 
1.7.2.5
