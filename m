From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Wed, 31 Jul 2013 18:45:26 +0100
Subject: [PATCH RFC 2/8] arm: introduce a global dma_ops pointer
In-Reply-To: <alpine.DEB.2.02.1307311833040.4893@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1307311833040.4893@kaball.uk.xensource.com>
Message-ID: <1375292732-7627-2-git-send-email-stefano.stabellini@eu.citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Initially set dma_ops to arm_dma_ops.
Use dma_ops instead of arm_dma_ops in dmabounce.

Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
CC: will.deacon at arm.com
CC: linux at arm.linux.org.uk
---
 arch/arm/common/dmabounce.c        |   10 +++++-----
 arch/arm/include/asm/dma-mapping.h |    3 ++-
 arch/arm/mm/dma-mapping.c          |    3 +++
 3 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/arm/common/dmabounce.c b/arch/arm/common/dmabounce.c
index 1143c4d..b626122 100644
--- a/arch/arm/common/dmabounce.c
+++ b/arch/arm/common/dmabounce.c
@@ -325,7 +325,7 @@ static dma_addr_t dmabounce_map_page(struct device *dev, struct page *page,
 		return DMA_ERROR_CODE;
 
 	if (ret == 0) {
-		arm_dma_ops.sync_single_for_device(dev, dma_addr, size, dir);
+		dma_ops->sync_single_for_device(dev, dma_addr, size, dir);
 		return dma_addr;
 	}
 
@@ -353,7 +353,7 @@ static void dmabounce_unmap_page(struct device *dev, dma_addr_t dma_addr, size_t
 
 	buf = find_safe_buffer_dev(dev, dma_addr, __func__);
 	if (!buf) {
-		arm_dma_ops.sync_single_for_cpu(dev, dma_addr, size, dir);
+		dma_ops->sync_single_for_cpu(dev, dma_addr, size, dir);
 		return;
 	}
 
@@ -397,7 +397,7 @@ static void dmabounce_sync_for_cpu(struct device *dev,
 	if (!__dmabounce_sync_for_cpu(dev, handle, size, dir))
 		return;
 
-	arm_dma_ops.sync_single_for_cpu(dev, handle, size, dir);
+	dma_ops->sync_single_for_cpu(dev, handle, size, dir);
 }
 
 static int __dmabounce_sync_for_device(struct device *dev, dma_addr_t addr,
@@ -437,7 +437,7 @@ static void dmabounce_sync_for_device(struct device *dev,
 	if (!__dmabounce_sync_for_device(dev, handle, size, dir))
 		return;
 
-	arm_dma_ops.sync_single_for_device(dev, handle, size, dir);
+	dma_ops->sync_single_for_device(dev, handle, size, dir);
 }
 
 static int dmabounce_set_mask(struct device *dev, u64 dma_mask)
@@ -445,7 +445,7 @@ static int dmabounce_set_mask(struct device *dev, u64 dma_mask)
 	if (dev->archdata.dmabounce)
 		return 0;
 
-	return arm_dma_ops.set_dma_mask(dev, dma_mask);
+	return dma_ops->set_dma_mask(dev, dma_mask);
 }
 
 static struct dma_map_ops dmabounce_ops = {
diff --git a/arch/arm/include/asm/dma-mapping.h b/arch/arm/include/asm/dma-mapping.h
index ad89e0f..f907f65 100644
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
