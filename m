From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Wed, 12 Nov 2014 11:40:44 +0000
Subject: [PATCH v9 03/13] xen/arm: if(pfn_valid(pfn)) call native dma_ops
In-Reply-To: <alpine.DEB.2.02.1411121130020.26318@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1411121130020.26318@kaball.uk.xensource.com>
Message-ID: <1415792454-23161-3-git-send-email-stefano.stabellini@eu.citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove code duplication in mm32.c by calling the native dma_ops if the
page is a local page (not a foreign page). Use a simple pfn_valid(pfn)
check to figure out if the page is local, exploiting the fact that dom0
is mapped 1:1, therefore pfn_valid always returns false when called on a
foreign mfn.

Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

---

Changes in v9:

- remove BUG_ON from the loop;
- add static inline for xen_dma_unmap_page, xen_dma_sync_single_for_cpu,
  xen_dma_sync_single_for_device.
---
 arch/arm/include/asm/xen/page-coherent.h |   49 +++++++++++++++++++++++++----
 arch/arm/xen/mm32.c                      |   50 +++++++-----------------------
 2 files changed, 54 insertions(+), 45 deletions(-)

diff --git a/arch/arm/include/asm/xen/page-coherent.h b/arch/arm/include/asm/xen/page-coherent.h
index e8275ea..9cfd895 100644
--- a/arch/arm/include/asm/xen/page-coherent.h
+++ b/arch/arm/include/asm/xen/page-coherent.h
@@ -5,6 +5,15 @@
 #include <linux/dma-attrs.h>
 #include <linux/dma-mapping.h>
 
+void __xen_dma_unmap_page(struct device *hwdev, dma_addr_t handle,
+		size_t size, enum dma_data_direction dir,
+		struct dma_attrs *attrs);
+void __xen_dma_sync_single_for_cpu(struct device *hwdev,
+		dma_addr_t handle, size_t size, enum dma_data_direction dir);
+
+void __xen_dma_sync_single_for_device(struct device *hwdev,
+		dma_addr_t handle, size_t size, enum dma_data_direction dir);
+
 static inline void *xen_alloc_coherent_pages(struct device *hwdev, size_t size,
 		dma_addr_t *dma_handle, gfp_t flags,
 		struct dma_attrs *attrs)
@@ -26,14 +35,42 @@ static inline void xen_dma_map_page(struct device *hwdev, struct page *page,
 	__generic_dma_ops(hwdev)->map_page(hwdev, page, offset, size, dir, attrs);
 }
 
-void xen_dma_unmap_page(struct device *hwdev, dma_addr_t handle,
+static inline void xen_dma_unmap_page(struct device *hwdev, dma_addr_t handle,
 		size_t size, enum dma_data_direction dir,
-		struct dma_attrs *attrs);
+		struct dma_attrs *attrs)
+{
+	unsigned long pfn = PFN_DOWN(handle);
+	/* Dom0 is mapped 1:1, so calling pfn_valid on a foreign mfn will
+	 * always return false. If the page is local we can safely call the
+	 * native dma_ops function, otherwise we call the xen specific
+	 * function. */
+	if (pfn_valid(pfn)) {
+		if (__generic_dma_ops(hwdev)->unmap_page)
+			__generic_dma_ops(hwdev)->unmap_page(hwdev, handle, size, dir, attrs);
+	} else
+		__xen_dma_unmap_page(hwdev, handle, size, dir, attrs);
+}
 
-void xen_dma_sync_single_for_cpu(struct device *hwdev,
-		dma_addr_t handle, size_t size, enum dma_data_direction dir);
+static inline void xen_dma_sync_single_for_cpu(struct device *hwdev,
+		dma_addr_t handle, size_t size, enum dma_data_direction dir)
+{
+	unsigned long pfn = PFN_DOWN(handle);
+	if (pfn_valid(pfn)) {
+		if (__generic_dma_ops(hwdev)->sync_single_for_cpu)
+			__generic_dma_ops(hwdev)->sync_single_for_cpu(hwdev, handle, size, dir);
+	} else
+		__xen_dma_sync_single_for_cpu(hwdev, handle, size, dir);
+}
 
-void xen_dma_sync_single_for_device(struct device *hwdev,
-		dma_addr_t handle, size_t size, enum dma_data_direction dir);
+static inline void xen_dma_sync_single_for_device(struct device *hwdev,
+		dma_addr_t handle, size_t size, enum dma_data_direction dir)
+{
+	unsigned long pfn = PFN_DOWN(handle);
+	if (pfn_valid(pfn)) {
+		if (__generic_dma_ops(hwdev)->sync_single_for_device)
+			__generic_dma_ops(hwdev)->sync_single_for_device(hwdev, handle, size, dir);
+	} else
+		__xen_dma_sync_single_for_device(hwdev, handle, size, dir);
+}
 
 #endif /* _ASM_ARM_XEN_PAGE_COHERENT_H */
diff --git a/arch/arm/xen/mm32.c b/arch/arm/xen/mm32.c
index 6153d61..5bb8391 100644
--- a/arch/arm/xen/mm32.c
+++ b/arch/arm/xen/mm32.c
@@ -4,13 +4,15 @@
 #include <linux/highmem.h>
 
 #include <xen/features.h>
-
+enum dma_cache_op {
+       DMA_UNMAP,
+       DMA_MAP,
+};
 
 /* functions called by SWIOTLB */
 
 static void dma_cache_maint(dma_addr_t handle, unsigned long offset,
-	size_t size, enum dma_data_direction dir,
-	void (*op)(const void *, size_t, int))
+	size_t size, enum dma_data_direction dir, enum dma_cache_op op)
 {
 	unsigned long pfn;
 	size_t left = size;
@@ -20,34 +22,8 @@ static void dma_cache_maint(dma_addr_t handle, unsigned long offset,
 
 	do {
 		size_t len = left;
-		void *vaddr;
 	
-		if (!pfn_valid(pfn))
-		{
-			/* TODO: cache flush */
-		} else {
-			struct page *page = pfn_to_page(pfn);
-
-			if (PageHighMem(page)) {
-				if (len + offset > PAGE_SIZE)
-					len = PAGE_SIZE - offset;
-
-				if (cache_is_vipt_nonaliasing()) {
-					vaddr = kmap_atomic(page);
-					op(vaddr + offset, len, dir);
-					kunmap_atomic(vaddr);
-				} else {
-					vaddr = kmap_high_get(page);
-					if (vaddr) {
-						op(vaddr + offset, len, dir);
-						kunmap_high(page);
-					}
-				}
-			} else {
-				vaddr = page_address(page) + offset;
-				op(vaddr, len, dir);
-			}
-		}
+		/* TODO: cache flush */
 
 		offset = 0;
 		pfn++;
@@ -58,20 +34,16 @@ static void dma_cache_maint(dma_addr_t handle, unsigned long offset,
 static void __xen_dma_page_dev_to_cpu(struct device *hwdev, dma_addr_t handle,
 		size_t size, enum dma_data_direction dir)
 {
-	/* Cannot use __dma_page_dev_to_cpu because we don't have a
-	 * struct page for handle */
-
-	dma_cache_maint(handle & PAGE_MASK, handle & ~PAGE_MASK, size, dir, dmac_unmap_area);
+	dma_cache_maint(handle & PAGE_MASK, handle & ~PAGE_MASK, size, dir, DMA_UNMAP);
 }
 
 static void __xen_dma_page_cpu_to_dev(struct device *hwdev, dma_addr_t handle,
 		size_t size, enum dma_data_direction dir)
 {
-
-	dma_cache_maint(handle & PAGE_MASK, handle & ~PAGE_MASK, size, dir, dmac_map_area);
+	dma_cache_maint(handle & PAGE_MASK, handle & ~PAGE_MASK, size, dir, DMA_MAP);
 }
 
-void xen_dma_unmap_page(struct device *hwdev, dma_addr_t handle,
+void __xen_dma_unmap_page(struct device *hwdev, dma_addr_t handle,
 		size_t size, enum dma_data_direction dir,
 		struct dma_attrs *attrs)
 
@@ -84,7 +56,7 @@ void xen_dma_unmap_page(struct device *hwdev, dma_addr_t handle,
 	__xen_dma_page_dev_to_cpu(hwdev, handle, size, dir);
 }
 
-void xen_dma_sync_single_for_cpu(struct device *hwdev,
+void __xen_dma_sync_single_for_cpu(struct device *hwdev,
 		dma_addr_t handle, size_t size, enum dma_data_direction dir)
 {
 	if (!__generic_dma_ops(hwdev)->sync_single_for_cpu)
@@ -92,7 +64,7 @@ void xen_dma_sync_single_for_cpu(struct device *hwdev,
 	__xen_dma_page_dev_to_cpu(hwdev, handle, size, dir);
 }
 
-void xen_dma_sync_single_for_device(struct device *hwdev,
+void __xen_dma_sync_single_for_device(struct device *hwdev,
 		dma_addr_t handle, size_t size, enum dma_data_direction dir)
 {
 	if (!__generic_dma_ops(hwdev)->sync_single_for_device)
-- 
1.7.10.4
