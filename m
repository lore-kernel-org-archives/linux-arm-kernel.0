From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Wed, 9 Oct 2013 21:48:25 +0100
Subject: [PATCH v8 12/17] xen: introduce xen_dma_map/unmap_page and
 xen_dma_sync_single_for_cpu/device
In-Reply-To: <alpine.DEB.2.02.1310092109190.26077@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1310092109190.26077@kaball.uk.xensource.com>
Message-ID: <1381351710-1876-12-git-send-email-stefano.stabellini@eu.citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Introduce xen_dma_map_page, xen_dma_unmap_page,
xen_dma_sync_single_for_cpu and xen_dma_sync_single_for_device.
They have empty implementations on x86 and ia64 but they call the
corresponding platform dma_ops function on arm and arm64.

Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
---
 arch/arm/include/asm/xen/page-coherent.h   |   28 ++++++++++++++++++++++++++++
 arch/arm64/include/asm/xen/page-coherent.h |   25 +++++++++++++++++++++++++
 arch/ia64/include/asm/xen/page-coherent.h  |   14 ++++++++++++++
 arch/x86/include/asm/xen/page-coherent.h   |   14 ++++++++++++++
 4 files changed, 81 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/xen/page-coherent.h b/arch/arm/include/asm/xen/page-coherent.h
index c4d843c..532cffe 100644
--- a/arch/arm/include/asm/xen/page-coherent.h
+++ b/arch/arm/include/asm/xen/page-coherent.h
@@ -19,4 +19,32 @@ static inline void xen_free_coherent_pages(struct device *hwdev, size_t size,
 	__generic_dma_ops(hwdev)->free(hwdev, size, cpu_addr, dma_handle, attrs);
 }
 
+static inline dma_addr_t xen_dma_map_page(struct device *hwdev, struct page *page,
+	     unsigned long offset, size_t size, enum dma_data_direction dir,
+	     struct dma_attrs *attrs)
+{
+	return __generic_dma_ops(hwdev)->map_page(hwdev, page, offset, size, dir, attrs);
+}
+
+static inline void xen_dma_unmap_page(struct device *hwdev, dma_addr_t handle,
+		size_t size, enum dma_data_direction dir,
+		struct dma_attrs *attrs)
+{
+	if (__generic_dma_ops(hwdev)->unmap_page)
+		__generic_dma_ops(hwdev)->unmap_page(hwdev, handle, size, dir, attrs);
+}
+
+static inline void xen_dma_sync_single_for_cpu(struct device *hwdev,
+		dma_addr_t handle, size_t size, enum dma_data_direction dir)
+{
+	if (__generic_dma_ops(hwdev)->sync_single_for_cpu)
+		__generic_dma_ops(hwdev)->sync_single_for_cpu(hwdev, handle, size, dir);
+}
+
+static inline void xen_dma_sync_single_for_device(struct device *hwdev,
+		dma_addr_t handle, size_t size, enum dma_data_direction dir)
+{
+	if (__generic_dma_ops(hwdev)->sync_single_for_device)
+		__generic_dma_ops(hwdev)->sync_single_for_device(hwdev, handle, size, dir);
+}
 #endif /* _ASM_ARM_XEN_PAGE_COHERENT_H */
diff --git a/arch/arm64/include/asm/xen/page-coherent.h b/arch/arm64/include/asm/xen/page-coherent.h
index 3b4f029..5abe098 100644
--- a/arch/arm64/include/asm/xen/page-coherent.h
+++ b/arch/arm64/include/asm/xen/page-coherent.h
@@ -19,4 +19,29 @@ static inline void xen_free_coherent_pages(struct device *hwdev, size_t size,
 	__generic_dma_ops(hwdev)->free(hwdev, size, cpu_addr, dma_handle, attrs);
 }
 
+static inline dma_addr_t xen_dma_map_page(struct device *hwdev, struct page *page,
+	     unsigned long offset, size_t size, enum dma_data_direction dir,
+	     struct dma_attrs *attrs)
+{
+	return __generic_dma_ops(hwdev)->map_page(hwdev, page, offset, size, dir, attrs);
+}
+
+static inline void xen_dma_unmap_page(struct device *hwdev, dma_addr_t handle,
+		size_t size, enum dma_data_direction dir,
+		struct dma_attrs *attrs)
+{
+	__generic_dma_ops(hwdev)->unmap_page(hwdev, handle, size, dir, attrs);
+}
+
+static inline void xen_dma_sync_single_for_cpu(struct device *hwdev,
+		dma_addr_t handle, size_t size, enum dma_data_direction dir)
+{
+	__generic_dma_ops(hwdev)->sync_single_for_cpu(hwdev, handle, size, dir);
+}
+
+static inline void xen_dma_sync_single_for_device(struct device *hwdev,
+		dma_addr_t handle, size_t size, enum dma_data_direction dir)
+{
+	__generic_dma_ops(hwdev)->sync_single_for_device(hwdev, handle, size, dir);
+}
 #endif /* _ASM_ARM64_XEN_PAGE_COHERENT_H */
diff --git a/arch/ia64/include/asm/xen/page-coherent.h b/arch/ia64/include/asm/xen/page-coherent.h
index 37b929c..ed2e5ed 100644
--- a/arch/ia64/include/asm/xen/page-coherent.h
+++ b/arch/ia64/include/asm/xen/page-coherent.h
@@ -21,4 +21,18 @@ static inline void xen_free_coherent_pages(struct device *hwdev, size_t size,
 	free_pages((unsigned long) cpu_addr, get_order(size));
 }
 
+static inline dma_addr_t xen_dma_map_page(struct device *hwdev, struct page *page,
+	     unsigned long offset, size_t size, enum dma_data_direction dir,
+	     struct dma_attrs *attrs) { return page_to_phys(page); }
+
+static inline void xen_dma_unmap_page(struct device *hwdev, dma_addr_t handle,
+		size_t size, enum dma_data_direction dir,
+		struct dma_attrs *attrs) { }
+
+static inline void xen_dma_sync_single_for_cpu(struct device *hwdev,
+		dma_addr_t handle, size_t size, enum dma_data_direction dir) { }
+
+static inline void xen_dma_sync_single_for_device(struct device *hwdev,
+		dma_addr_t handle, size_t size, enum dma_data_direction dir) { }
+
 #endif /* _ASM_IA64_XEN_PAGE_COHERENT_H */
diff --git a/arch/x86/include/asm/xen/page-coherent.h b/arch/x86/include/asm/xen/page-coherent.h
index 31de2e0..3ddc2c2 100644
--- a/arch/x86/include/asm/xen/page-coherent.h
+++ b/arch/x86/include/asm/xen/page-coherent.h
@@ -21,4 +21,18 @@ static inline void xen_free_coherent_pages(struct device *hwdev, size_t size,
 	free_pages((unsigned long) cpu_addr, get_order(size));
 }
 
+static inline dma_addr_t xen_dma_map_page(struct device *hwdev, struct page *page,
+	     unsigned long offset, size_t size, enum dma_data_direction dir,
+	     struct dma_attrs *attrs) { return page_to_phys(page); }
+
+static inline void xen_dma_unmap_page(struct device *hwdev, dma_addr_t handle,
+		size_t size, enum dma_data_direction dir,
+		struct dma_attrs *attrs) { }
+
+static inline void xen_dma_sync_single_for_cpu(struct device *hwdev,
+		dma_addr_t handle, size_t size, enum dma_data_direction dir) { }
+
+static inline void xen_dma_sync_single_for_device(struct device *hwdev,
+		dma_addr_t handle, size_t size, enum dma_data_direction dir) { }
+
 #endif /* _ASM_X86_XEN_PAGE_COHERENT_H */
-- 
1.7.2.5
