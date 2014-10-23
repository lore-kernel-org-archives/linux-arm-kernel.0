From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Thu, 23 Oct 2014 18:27:23 +0100
Subject: [PATCH v5 3/6] xen/arm: introduce xen_is_dma_coherent
In-Reply-To: <alpine.DEB.2.02.1410231821520.876@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1410231821520.876@kaball.uk.xensource.com>
Message-ID: <1414085246-16160-3-git-send-email-stefano.stabellini@eu.citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Introduce a utility function to check whether a device is dma coherent.
The current implementation is suboptimal. Let's rework it later in
common arch/arm code.

Use it to figure out whether we need to issue cache maintenance
operations instead of checking on the existence of a particular dma_ops
function for the device.

Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>

---

Changes in v5:
- introduce xen_is_dma_coherent as a xen specific function;
- call xen_is_dma_coherent instead of is_dma_coherent.
---
 arch/arm/include/asm/xen/page-coherent.h |    5 +++++
 arch/arm/xen/mm32.c                      |    6 +++---
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/arm/include/asm/xen/page-coherent.h b/arch/arm/include/asm/xen/page-coherent.h
index e8275ea..6f0f882 100644
--- a/arch/arm/include/asm/xen/page-coherent.h
+++ b/arch/arm/include/asm/xen/page-coherent.h
@@ -5,6 +5,11 @@
 #include <linux/dma-attrs.h>
 #include <linux/dma-mapping.h>
 
+static inline bool xen_is_dma_coherent(struct device *dev)
+{
+    return (__generic_dma_ops(dev) == &arm_coherent_dma_ops);
+}
+ 
 static inline void *xen_alloc_coherent_pages(struct device *hwdev, size_t size,
 		dma_addr_t *dma_handle, gfp_t flags,
 		struct dma_attrs *attrs)
diff --git a/arch/arm/xen/mm32.c b/arch/arm/xen/mm32.c
index 6153d61..6c0224e 100644
--- a/arch/arm/xen/mm32.c
+++ b/arch/arm/xen/mm32.c
@@ -76,7 +76,7 @@ void xen_dma_unmap_page(struct device *hwdev, dma_addr_t handle,
 		struct dma_attrs *attrs)
 
 {
-	if (!__generic_dma_ops(hwdev)->unmap_page)
+	if (xen_is_dma_coherent(hwdev))
 		return;
 	if (dma_get_attr(DMA_ATTR_SKIP_CPU_SYNC, attrs))
 		return;
@@ -87,7 +87,7 @@ void xen_dma_unmap_page(struct device *hwdev, dma_addr_t handle,
 void xen_dma_sync_single_for_cpu(struct device *hwdev,
 		dma_addr_t handle, size_t size, enum dma_data_direction dir)
 {
-	if (!__generic_dma_ops(hwdev)->sync_single_for_cpu)
+	if (xen_is_dma_coherent(hwdev))
 		return;
 	__xen_dma_page_dev_to_cpu(hwdev, handle, size, dir);
 }
@@ -95,7 +95,7 @@ void xen_dma_sync_single_for_cpu(struct device *hwdev,
 void xen_dma_sync_single_for_device(struct device *hwdev,
 		dma_addr_t handle, size_t size, enum dma_data_direction dir)
 {
-	if (!__generic_dma_ops(hwdev)->sync_single_for_device)
+	if (xen_is_dma_coherent(hwdev))
 		return;
 	__xen_dma_page_cpu_to_dev(hwdev, handle, size, dir);
 }
-- 
1.7.10.4
