From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Tue, 8 Jul 2014 16:42:11 +0100
Subject: [PATCH v2 2/3] xen/arm: reimplement xen_dma_unmap_page & friends
In-Reply-To: <alpine.DEB.2.02.1407081552200.27641@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1407081552200.27641@kaball.uk.xensource.com>
Message-ID: <1404834132-15847-2-git-send-email-stefano.stabellini@eu.citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

xen_dma_unmap_page, xen_dma_sync_single_for_cpu and
xen_dma_sync_single_for_device are currently implemented by calling into
the corresponding generic ARM implementation of these functions. In
order to do this, firstly the dma_addr_t handle, that on Xen is a
machine address, needs to be translated into a physical address.  The
operation is expensive and inaccurate, given that a single machine
address can correspond to multiple physical addresses in one domain,
because the same page can be granted multiple times by the frontend.

To avoid this problem, we introduce a Xen specific implementation of
xen_dma_unmap_page, xen_dma_sync_single_for_cpu and
xen_dma_sync_single_for_device, that can operate on machine addresses
directly.

The new implementation relies on the fact that the hypervisor creates a
second p2m mapping of any grant pages at physical address == machine
address of the page for dom0. Therefore we can access memory at physical
address == dma_addr_r handle and perform the cache flushing there. Some
cache maintenance operations require a virtual address. Instead of using
ioremap_cache, that is not safe in interrupt context, we allocate a
per-cpu PAGE_KERNEL scratch page and we manually update the pte for it.

arm64 doesn't need cache maintenance operations on unmap for now.

Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>

---

Changes in v2:
- check for XENFEAT_grant_map_11;
- remeber the ptep corresponding to scratch pages so that we don't need
to calculate it again every time;
- do not acutally unmap the page on xen_mm32_unmap;
- properly account preempt_enable/disable.
---
 arch/arm/include/asm/xen/page-coherent.h |   25 ++--
 arch/arm/xen/Makefile                    |    2 +-
 arch/arm/xen/mm32.c                      |  202 ++++++++++++++++++++++++++++++
 3 files changed, 210 insertions(+), 19 deletions(-)
 create mode 100644 arch/arm/xen/mm32.c

diff --git a/arch/arm/include/asm/xen/page-coherent.h b/arch/arm/include/asm/xen/page-coherent.h
index 1109017..e8275ea 100644
--- a/arch/arm/include/asm/xen/page-coherent.h
+++ b/arch/arm/include/asm/xen/page-coherent.h
@@ -26,25 +26,14 @@ static inline void xen_dma_map_page(struct device *hwdev, struct page *page,
 	__generic_dma_ops(hwdev)->map_page(hwdev, page, offset, size, dir, attrs);
 }
 
-static inline void xen_dma_unmap_page(struct device *hwdev, dma_addr_t handle,
+void xen_dma_unmap_page(struct device *hwdev, dma_addr_t handle,
 		size_t size, enum dma_data_direction dir,
-		struct dma_attrs *attrs)
-{
-	if (__generic_dma_ops(hwdev)->unmap_page)
-		__generic_dma_ops(hwdev)->unmap_page(hwdev, handle, size, dir, attrs);
-}
+		struct dma_attrs *attrs);
 
-static inline void xen_dma_sync_single_for_cpu(struct device *hwdev,
-		dma_addr_t handle, size_t size, enum dma_data_direction dir)
-{
-	if (__generic_dma_ops(hwdev)->sync_single_for_cpu)
-		__generic_dma_ops(hwdev)->sync_single_for_cpu(hwdev, handle, size, dir);
-}
+void xen_dma_sync_single_for_cpu(struct device *hwdev,
+		dma_addr_t handle, size_t size, enum dma_data_direction dir);
+
+void xen_dma_sync_single_for_device(struct device *hwdev,
+		dma_addr_t handle, size_t size, enum dma_data_direction dir);
 
-static inline void xen_dma_sync_single_for_device(struct device *hwdev,
-		dma_addr_t handle, size_t size, enum dma_data_direction dir)
-{
-	if (__generic_dma_ops(hwdev)->sync_single_for_device)
-		__generic_dma_ops(hwdev)->sync_single_for_device(hwdev, handle, size, dir);
-}
 #endif /* _ASM_ARM_XEN_PAGE_COHERENT_H */
diff --git a/arch/arm/xen/Makefile b/arch/arm/xen/Makefile
index 1296952..1f85bfe 100644
--- a/arch/arm/xen/Makefile
+++ b/arch/arm/xen/Makefile
@@ -1 +1 @@
-obj-y		:= enlighten.o hypercall.o grant-table.o p2m.o mm.o
+obj-y		:= enlighten.o hypercall.o grant-table.o p2m.o mm.o mm32.o
diff --git a/arch/arm/xen/mm32.c b/arch/arm/xen/mm32.c
new file mode 100644
index 0000000..964d0af
--- /dev/null
+++ b/arch/arm/xen/mm32.c
@@ -0,0 +1,202 @@
+#include <linux/cpu.h>
+#include <linux/dma-mapping.h>
+#include <linux/gfp.h>
+#include <linux/highmem.h>
+
+#include <xen/features.h>
+
+static DEFINE_PER_CPU(unsigned long, xen_mm32_scratch_virt);
+static DEFINE_PER_CPU(pte_t *, xen_mm32_scratch_ptep);
+
+static int alloc_xen_mm32_scratch_page(int cpu)
+{
+	struct page *page;
+	unsigned long virt;
+	pmd_t *pmdp;
+	pte_t *ptep;
+
+	if (per_cpu(xen_mm32_scratch_ptep, cpu) != NULL)
+		return 0;
+
+	page = alloc_page(GFP_KERNEL);
+	if (page == NULL) {
+		pr_warn("Failed to allocate xen_mm32_scratch_page for cpu %d\n", cpu);
+		return -ENOMEM;
+	}
+
+	virt = (unsigned long)__va(page_to_phys(page));
+	pmdp = pmd_offset(pud_offset(pgd_offset_k(virt), virt), virt);
+	ptep = pte_offset_kernel(pmdp, virt);
+
+	per_cpu(xen_mm32_scratch_virt, cpu) = virt;
+	per_cpu(xen_mm32_scratch_ptep, cpu) = ptep;
+
+	return 0;
+}
+
+static int xen_mm32_cpu_notify(struct notifier_block *self,
+				    unsigned long action, void *hcpu)
+{
+	int cpu = (long)hcpu;
+	switch (action) {
+	case CPU_UP_PREPARE:
+		if (alloc_xen_mm32_scratch_page(cpu))
+			return NOTIFY_BAD;
+		break;
+	default:
+		break;
+	}
+	return NOTIFY_OK;
+}
+
+static struct notifier_block xen_mm32_cpu_notifier = {
+	.notifier_call	= xen_mm32_cpu_notify,
+};
+
+static void* xen_mm32_remap_page(dma_addr_t handle)
+{
+	unsigned long virt = get_cpu_var(xen_mm32_scratch_virt);
+	pte_t *ptep = __get_cpu_var(xen_mm32_scratch_ptep);
+
+	*ptep = pfn_pte(handle >> PAGE_SHIFT, PAGE_KERNEL);
+	local_flush_tlb_kernel_page(virt);
+
+	return (void*)virt;
+}
+
+static void xen_mm32_unmap(void *vaddr)
+{
+	put_cpu_var(xen_mm32_scratch_virt);
+}
+
+
+/* functions called by SWIOTLB */
+
+static void dma_cache_maint(dma_addr_t handle, unsigned long offset,
+	size_t size, enum dma_data_direction dir,
+	void (*op)(const void *, size_t, int))
+{
+	unsigned long pfn;
+	size_t left = size;
+
+	pfn = (handle >> PAGE_SHIFT) + offset / PAGE_SIZE;
+	offset %= PAGE_SIZE;
+
+	do {
+		size_t len = left;
+		void *vaddr;
+	
+		if (!pfn_valid(pfn))
+		{
+			/* Cannot map the page, we don't know its physical address.
+			 * Return and hope for the best */
+			if (!xen_feature(XENFEAT_grant_map_11))
+				return;
+			vaddr = xen_mm32_remap_page(handle) + offset;
+			op(vaddr, len, dir);
+			xen_mm32_unmap(vaddr - offset);
+		} else {
+			struct page *page = pfn_to_page(pfn);
+
+			if (PageHighMem(page)) {
+				if (len + offset > PAGE_SIZE)
+					len = PAGE_SIZE - offset;
+
+				if (cache_is_vipt_nonaliasing()) {
+					vaddr = kmap_atomic(page);
+					op(vaddr + offset, len, dir);
+					kunmap_atomic(vaddr);
+				} else {
+					vaddr = kmap_high_get(page);
+					if (vaddr) {
+						op(vaddr + offset, len, dir);
+						kunmap_high(page);
+					}
+				}
+			} else {
+				vaddr = page_address(page) + offset;
+				op(vaddr, len, dir);
+			}
+		}
+
+		offset = 0;
+		pfn++;
+		left -= len;
+	} while (left);
+}
+
+static void __xen_dma_page_dev_to_cpu(struct device *hwdev, dma_addr_t handle,
+		size_t size, enum dma_data_direction dir)
+{
+	/* Cannot use __dma_page_dev_to_cpu because we don't have a
+	 * struct page for handle */
+
+	if (dir == DMA_TO_DEVICE)
+		outer_inv_range(handle, handle + size);
+
+	dma_cache_maint(handle & PAGE_MASK, handle & ~PAGE_MASK, size, dir, dmac_unmap_area);
+}
+
+static void __xen_dma_page_cpu_to_dev(struct device *hwdev, dma_addr_t handle,
+		size_t size, enum dma_data_direction dir)
+{
+
+	dma_cache_maint(handle & PAGE_MASK, handle & ~PAGE_MASK, size, dir, dmac_map_area);
+
+	if (dir == DMA_FROM_DEVICE) {
+		outer_inv_range(handle, handle + size);
+	} else {
+		outer_clean_range(handle, handle + size);
+	}
+}
+
+void xen_dma_unmap_page(struct device *hwdev, dma_addr_t handle,
+		size_t size, enum dma_data_direction dir,
+		struct dma_attrs *attrs)
+
+{
+	if (!__generic_dma_ops(hwdev)->unmap_page)
+		return;
+	if (dma_get_attr(DMA_ATTR_SKIP_CPU_SYNC, attrs))
+		return;
+
+	__xen_dma_page_dev_to_cpu(hwdev, handle, size, dir);
+}
+
+void xen_dma_sync_single_for_cpu(struct device *hwdev,
+		dma_addr_t handle, size_t size, enum dma_data_direction dir)
+{
+	if (!__generic_dma_ops(hwdev)->sync_single_for_cpu)
+		return;
+	__xen_dma_page_dev_to_cpu(hwdev, handle, size, dir);
+}
+
+void xen_dma_sync_single_for_device(struct device *hwdev,
+		dma_addr_t handle, size_t size, enum dma_data_direction dir)
+{
+	if (!__generic_dma_ops(hwdev)->sync_single_for_device)
+		return;
+	__xen_dma_page_cpu_to_dev(hwdev, handle, size, dir);
+}
+
+int __init xen_mm32_init(void)
+{
+	int cpu;
+
+	if (!xen_initial_domain())
+		return 0;
+
+	register_cpu_notifier(&xen_mm32_cpu_notifier);
+	get_online_cpus();
+	for_each_online_cpu(cpu) {
+		if (alloc_xen_mm32_scratch_page(cpu)) {
+			put_online_cpus();
+			unregister_cpu_notifier(&xen_mm32_cpu_notifier);
+			return -ENOMEM;
+		}
+	}
+	put_online_cpus();
+
+	return 0;
+}
+arch_initcall(xen_mm32_init);
-- 
1.7.10.4
