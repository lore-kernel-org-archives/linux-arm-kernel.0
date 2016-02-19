From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Fri, 19 Feb 2016 09:22:43 +0100
Subject: [RFC 2/3] iommu: dma-iommu: move IOMMU/DMA-mapping code from ARM64
 arch to drivers
In-Reply-To: <1455870164-25337-1-git-send-email-m.szyprowski@samsung.com>
References: <1455870164-25337-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1455870164-25337-3-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch moves all the IOMMU-based DMA-mapping code from arch/arm64/mm
to drivers/iommu/dma-iommu-ops.c. This way it can be easily shared with
ARM architecture, which will also use them.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm64/include/asm/dma-mapping.h |  39 ++-
 arch/arm64/mm/dma-mapping.c          | 491 ++---------------------------------
 drivers/iommu/Makefile               |   2 +-
 drivers/iommu/dma-iommu-ops.c        | 471 +++++++++++++++++++++++++++++++++
 include/linux/dma-iommu.h            |  14 +
 5 files changed, 538 insertions(+), 479 deletions(-)
 create mode 100644 drivers/iommu/dma-iommu-ops.c

diff --git a/arch/arm64/include/asm/dma-mapping.h b/arch/arm64/include/asm/dma-mapping.h
index ba437f090a74..3a582d820717 100644
--- a/arch/arm64/include/asm/dma-mapping.h
+++ b/arch/arm64/include/asm/dma-mapping.h
@@ -22,6 +22,7 @@
 #include <linux/vmalloc.h>
 
 #include <xen/xen.h>
+#include <asm/cacheflush.h>
 #include <asm/xen/hypervisor.h>
 
 #define DMA_ERROR_CODE	(~(dma_addr_t)0)
@@ -47,14 +48,17 @@ static inline struct dma_map_ops *get_dma_ops(struct device *dev)
 		return __generic_dma_ops(dev);
 }
 
+static inline void arch_set_dma_ops(struct device *dev, struct dma_map_ops *ops)
+{
+	dev->archdata.dma_ops = ops;
+}
+
 void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
 			struct iommu_ops *iommu, bool coherent);
 #define arch_setup_dma_ops	arch_setup_dma_ops
 
-#ifdef CONFIG_IOMMU_DMA
 void arch_teardown_dma_ops(struct device *dev);
 #define arch_teardown_dma_ops	arch_teardown_dma_ops
-#endif
 
 /* do not use this function in a driver */
 static inline bool is_device_dma_coherent(struct device *dev)
@@ -86,5 +90,36 @@ static inline void dma_mark_clean(void *addr, size_t size)
 {
 }
 
+static inline void arch_flush_page(struct device *dev, const void *virt,
+				   phys_addr_t phys)
+{
+	__dma_flush_range(virt, virt + PAGE_SIZE);
+}
+
+static inline void arch_dma_map_area(phys_addr_t phys, size_t size,
+				     enum dma_data_direction dir)
+{
+	__dma_map_area(phys_to_virt(phys), size, dir);
+}
+
+static inline void arch_dma_unmap_area(phys_addr_t phys, size_t size,
+				       enum dma_data_direction dir)
+{
+	__dma_unmap_area(phys_to_virt(phys), size, dir);
+}
+
+static inline pgprot_t arch_get_dma_pgprot(struct dma_attrs *attrs,
+					pgprot_t prot, bool coherent)
+{
+	if (!coherent || dma_get_attr(DMA_ATTR_WRITE_COMBINE, attrs))
+		return pgprot_writecombine(prot);
+	return prot;
+}
+
+extern void *arch_alloc_from_atomic_pool(size_t size, struct page **ret_page,
+					 gfp_t flags);
+extern bool arch_in_atomic_pool(void *start, size_t size);
+extern int arch_free_from_atomic_pool(void *start, size_t size);
+
 #endif	/* __KERNEL__ */
 #endif	/* __ASM_DMA_MAPPING_H */
diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index a6e757cbab77..d8cb8552bbff 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -24,19 +24,12 @@
 #include <linux/genalloc.h>
 #include <linux/dma-mapping.h>
 #include <linux/dma-contiguous.h>
+#include <linux/dma-iommu.h>
 #include <linux/vmalloc.h>
 #include <linux/swiotlb.h>
 
 #include <asm/cacheflush.h>
 
-static pgprot_t __get_dma_pgprot(struct dma_attrs *attrs, pgprot_t prot,
-				 bool coherent)
-{
-	if (!coherent || dma_get_attr(DMA_ATTR_WRITE_COMBINE, attrs))
-		return pgprot_writecombine(prot);
-	return prot;
-}
-
 static struct gen_pool *atomic_pool;
 
 #define DEFAULT_DMA_COHERENT_POOL_SIZE  SZ_256K
@@ -49,7 +42,7 @@ static int __init early_coherent_pool(char *p)
 }
 early_param("coherent_pool", early_coherent_pool);
 
-static void *__alloc_from_pool(size_t size, struct page **ret_page, gfp_t flags)
+void *arch_alloc_from_atomic_pool(size_t size, struct page **ret_page, gfp_t flags)
 {
 	unsigned long val;
 	void *ptr = NULL;
@@ -71,14 +64,14 @@ static void *__alloc_from_pool(size_t size, struct page **ret_page, gfp_t flags)
 	return ptr;
 }
 
-static bool __in_atomic_pool(void *start, size_t size)
+bool arch_in_atomic_pool(void *start, size_t size)
 {
 	return addr_in_gen_pool(atomic_pool, (unsigned long)start, size);
 }
 
-static int __free_from_pool(void *start, size_t size)
+int arch_free_from_atomic_pool(void *start, size_t size)
 {
-	if (!__in_atomic_pool(start, size))
+	if (!arch_in_atomic_pool(start, size))
 		return 0;
 
 	gen_pool_free(atomic_pool, (unsigned long)start, size);
@@ -142,13 +135,13 @@ static void *__dma_alloc(struct device *dev, size_t size,
 	struct page *page;
 	void *ptr, *coherent_ptr;
 	bool coherent = is_device_dma_coherent(dev);
-	pgprot_t prot = __get_dma_pgprot(attrs, PAGE_KERNEL, false);
+	pgprot_t prot = arch_get_dma_pgprot(attrs, PAGE_KERNEL, false);
 
 	size = PAGE_ALIGN(size);
 
 	if (!coherent && !gfpflags_allow_blocking(flags)) {
 		struct page *page = NULL;
-		void *addr = __alloc_from_pool(size, &page, flags);
+		void *addr = arch_alloc_from_atomic_pool(size, &page, flags);
 
 		if (addr)
 			*dma_handle = phys_to_dma(dev, page_to_phys(page));
@@ -192,7 +185,7 @@ static void __dma_free(struct device *dev, size_t size,
 	size = PAGE_ALIGN(size);
 
 	if (!is_device_dma_coherent(dev)) {
-		if (__free_from_pool(vaddr, size))
+		if (arch_free_from_atomic_pool(vaddr, size))
 			return;
 		vunmap(vaddr);
 	}
@@ -312,7 +305,7 @@ static int __swiotlb_mmap(struct device *dev,
 	unsigned long pfn = dma_to_phys(dev, dma_addr) >> PAGE_SHIFT;
 	unsigned long off = vma->vm_pgoff;
 
-	vma->vm_page_prot = __get_dma_pgprot(attrs, vma->vm_page_prot,
+	vma->vm_page_prot = arch_get_dma_pgprot(attrs, vma->vm_page_prot,
 					     is_device_dma_coherent(dev));
 
 	if (dma_mmap_from_coherent(dev, vma, cpu_addr, size, &ret))
@@ -526,470 +519,16 @@ static int __init dma_debug_do_init(void)
 }
 fs_initcall(dma_debug_do_init);
 
-
-#ifdef CONFIG_IOMMU_DMA
-#include <linux/dma-iommu.h>
-#include <linux/platform_device.h>
-#include <linux/amba/bus.h>
-
-/* Thankfully, all cache ops are by VA so we can ignore phys here */
-static void flush_page(struct device *dev, const void *virt, phys_addr_t phys)
-{
-	__dma_flush_range(virt, virt + PAGE_SIZE);
-}
-
-static void *__iommu_alloc_attrs(struct device *dev, size_t size,
-				 dma_addr_t *handle, gfp_t gfp,
-				 struct dma_attrs *attrs)
-{
-	bool coherent = is_device_dma_coherent(dev);
-	int ioprot = dma_direction_to_prot(DMA_BIDIRECTIONAL, coherent);
-	size_t iosize = size;
-	void *addr;
-
-	if (WARN(!dev, "cannot create IOMMU mapping for unknown device\n"))
-		return NULL;
-
-	size = PAGE_ALIGN(size);
-
-	/*
-	 * Some drivers rely on this, and we probably don't want the
-	 * possibility of stale kernel data being read by devices anyway.
-	 */
-	gfp |= __GFP_ZERO;
-
-	if (gfpflags_allow_blocking(gfp)) {
-		struct page **pages;
-		pgprot_t prot = __get_dma_pgprot(attrs, PAGE_KERNEL, coherent);
-
-		pages = iommu_dma_alloc(dev, iosize, gfp, ioprot, handle,
-					flush_page);
-		if (!pages)
-			return NULL;
-
-		addr = dma_common_pages_remap(pages, size, VM_USERMAP, prot,
-					      __builtin_return_address(0));
-		if (!addr)
-			iommu_dma_free(dev, pages, iosize, handle);
-	} else {
-		struct page *page;
-		/*
-		 * In atomic context we can't remap anything, so we'll only
-		 * get the virtually contiguous buffer we need by way of a
-		 * physically contiguous allocation.
-		 */
-		if (coherent) {
-			page = alloc_pages(gfp, get_order(size));
-			addr = page ? page_address(page) : NULL;
-		} else {
-			addr = __alloc_from_pool(size, &page, gfp);
-		}
-		if (!addr)
-			return NULL;
-
-		*handle = iommu_dma_map_page(dev, page, 0, iosize, ioprot);
-		if (iommu_dma_mapping_error(dev, *handle)) {
-			if (coherent)
-				__free_pages(page, get_order(size));
-			else
-				__free_from_pool(addr, size);
-			addr = NULL;
-		}
-	}
-	return addr;
-}
-
-static void __iommu_free_attrs(struct device *dev, size_t size, void *cpu_addr,
-			       dma_addr_t handle, struct dma_attrs *attrs)
-{
-	size_t iosize = size;
-
-	size = PAGE_ALIGN(size);
-	/*
-	 * @cpu_addr will be one of 3 things depending on how it was allocated:
-	 * - A remapped array of pages from iommu_dma_alloc(), for all
-	 *   non-atomic allocations.
-	 * - A non-cacheable alias from the atomic pool, for atomic
-	 *   allocations by non-coherent devices.
-	 * - A normal lowmem address, for atomic allocations by
-	 *   coherent devices.
-	 * Hence how dodgy the below logic looks...
-	 */
-	if (__in_atomic_pool(cpu_addr, size)) {
-		iommu_dma_unmap_page(dev, handle, iosize, 0, NULL);
-		__free_from_pool(cpu_addr, size);
-	} else if (is_vmalloc_addr(cpu_addr)){
-		struct vm_struct *area = find_vm_area(cpu_addr);
-
-		if (WARN_ON(!area || !area->pages))
-			return;
-		iommu_dma_free(dev, area->pages, iosize, &handle);
-		dma_common_free_remap(cpu_addr, size, VM_USERMAP);
-	} else {
-		iommu_dma_unmap_page(dev, handle, iosize, 0, NULL);
-		__free_pages(virt_to_page(cpu_addr), get_order(size));
-	}
-}
-
-static int __iommu_mmap_attrs(struct device *dev, struct vm_area_struct *vma,
-			      void *cpu_addr, dma_addr_t dma_addr, size_t size,
-			      struct dma_attrs *attrs)
-{
-	struct vm_struct *area;
-	int ret;
-
-	vma->vm_page_prot = __get_dma_pgprot(attrs, vma->vm_page_prot,
-					     is_device_dma_coherent(dev));
-
-	if (dma_mmap_from_coherent(dev, vma, cpu_addr, size, &ret))
-		return ret;
-
-	area = find_vm_area(cpu_addr);
-	if (WARN_ON(!area || !area->pages))
-		return -ENXIO;
-
-	return iommu_dma_mmap(area->pages, size, vma);
-}
-
-static int __iommu_get_sgtable(struct device *dev, struct sg_table *sgt,
-			       void *cpu_addr, dma_addr_t dma_addr,
-			       size_t size, struct dma_attrs *attrs)
-{
-	unsigned int count = PAGE_ALIGN(size) >> PAGE_SHIFT;
-	struct vm_struct *area = find_vm_area(cpu_addr);
-
-	if (WARN_ON(!area || !area->pages))
-		return -ENXIO;
-
-	return sg_alloc_table_from_pages(sgt, area->pages, count, 0, size,
-					 GFP_KERNEL);
-}
-
-static void __iommu_sync_single_for_cpu(struct device *dev,
-					dma_addr_t dev_addr, size_t size,
-					enum dma_data_direction dir)
-{
-	phys_addr_t phys;
-
-	if (is_device_dma_coherent(dev))
-		return;
-
-	phys = iommu_iova_to_phys(iommu_get_domain_for_dev(dev), dev_addr);
-	__dma_unmap_area(phys_to_virt(phys), size, dir);
-}
-
-static void __iommu_sync_single_for_device(struct device *dev,
-					   dma_addr_t dev_addr, size_t size,
-					   enum dma_data_direction dir)
-{
-	phys_addr_t phys;
-
-	if (is_device_dma_coherent(dev))
-		return;
-
-	phys = iommu_iova_to_phys(iommu_get_domain_for_dev(dev), dev_addr);
-	__dma_map_area(phys_to_virt(phys), size, dir);
-}
-
-static dma_addr_t __iommu_map_page(struct device *dev, struct page *page,
-				   unsigned long offset, size_t size,
-				   enum dma_data_direction dir,
-				   struct dma_attrs *attrs)
-{
-	bool coherent = is_device_dma_coherent(dev);
-	int prot = dma_direction_to_prot(dir, coherent);
-	dma_addr_t dev_addr = iommu_dma_map_page(dev, page, offset, size, prot);
-
-	if (!iommu_dma_mapping_error(dev, dev_addr) &&
-	    !dma_get_attr(DMA_ATTR_SKIP_CPU_SYNC, attrs))
-		__iommu_sync_single_for_device(dev, dev_addr, size, dir);
-
-	return dev_addr;
-}
-
-static void __iommu_unmap_page(struct device *dev, dma_addr_t dev_addr,
-			       size_t size, enum dma_data_direction dir,
-			       struct dma_attrs *attrs)
-{
-	if (!dma_get_attr(DMA_ATTR_SKIP_CPU_SYNC, attrs))
-		__iommu_sync_single_for_cpu(dev, dev_addr, size, dir);
-
-	iommu_dma_unmap_page(dev, dev_addr, size, dir, attrs);
-}
-
-static void __iommu_sync_sg_for_cpu(struct device *dev,
-				    struct scatterlist *sgl, int nelems,
-				    enum dma_data_direction dir)
-{
-	struct scatterlist *sg;
-	int i;
-
-	if (is_device_dma_coherent(dev))
-		return;
-
-	for_each_sg(sgl, sg, nelems, i)
-		__dma_unmap_area(sg_virt(sg), sg->length, dir);
-}
-
-static void __iommu_sync_sg_for_device(struct device *dev,
-				       struct scatterlist *sgl, int nelems,
-				       enum dma_data_direction dir)
-{
-	struct scatterlist *sg;
-	int i;
-
-	if (is_device_dma_coherent(dev))
-		return;
-
-	for_each_sg(sgl, sg, nelems, i)
-		__dma_map_area(sg_virt(sg), sg->length, dir);
-}
-
-static int __iommu_map_sg_attrs(struct device *dev, struct scatterlist *sgl,
-				int nelems, enum dma_data_direction dir,
-				struct dma_attrs *attrs)
-{
-	bool coherent = is_device_dma_coherent(dev);
-
-	if (!dma_get_attr(DMA_ATTR_SKIP_CPU_SYNC, attrs))
-		__iommu_sync_sg_for_device(dev, sgl, nelems, dir);
-
-	return iommu_dma_map_sg(dev, sgl, nelems,
-			dma_direction_to_prot(dir, coherent));
-}
-
-static void __iommu_unmap_sg_attrs(struct device *dev,
-				   struct scatterlist *sgl, int nelems,
-				   enum dma_data_direction dir,
-				   struct dma_attrs *attrs)
-{
-	if (!dma_get_attr(DMA_ATTR_SKIP_CPU_SYNC, attrs))
-		__iommu_sync_sg_for_cpu(dev, sgl, nelems, dir);
-
-	iommu_dma_unmap_sg(dev, sgl, nelems, dir, attrs);
-}
-
-static struct dma_map_ops iommu_dma_ops = {
-	.alloc = __iommu_alloc_attrs,
-	.free = __iommu_free_attrs,
-	.mmap = __iommu_mmap_attrs,
-	.get_sgtable = __iommu_get_sgtable,
-	.map_page = __iommu_map_page,
-	.unmap_page = __iommu_unmap_page,
-	.map_sg = __iommu_map_sg_attrs,
-	.unmap_sg = __iommu_unmap_sg_attrs,
-	.sync_single_for_cpu = __iommu_sync_single_for_cpu,
-	.sync_single_for_device = __iommu_sync_single_for_device,
-	.sync_sg_for_cpu = __iommu_sync_sg_for_cpu,
-	.sync_sg_for_device = __iommu_sync_sg_for_device,
-	.dma_supported = iommu_dma_supported,
-	.mapping_error = iommu_dma_mapping_error,
-};
-
-/*
- * TODO: Right now __iommu_setup_dma_ops() gets called too early to do
- * everything it needs to - the device is only partially created and the
- * IOMMU driver hasn't seen it yet, so it can't have a group. Thus we
- * need this delayed attachment dance. Once IOMMU probe ordering is sorted
- * to move the arch_setup_dma_ops() call later, all the notifier bits below
- * become unnecessary, and will go away.
- */
-struct iommu_dma_notifier_data {
-	struct list_head list;
-	struct device *dev;
-	const struct iommu_ops *ops;
-	u64 dma_base;
-	u64 size;
-};
-static LIST_HEAD(iommu_dma_masters);
-static DEFINE_MUTEX(iommu_dma_notifier_lock);
-
-/*
- * Temporarily "borrow" a domain feature flag to to tell if we had to resort
- * to creating our own domain here, in case we need to clean it up again.
- */
-#define __IOMMU_DOMAIN_FAKE_DEFAULT		(1U << 31)
-
-static bool do_iommu_attach(struct device *dev, const struct iommu_ops *ops,
-			   u64 dma_base, u64 size)
-{
-	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
-
-	/*
-	 * Best case: The device is either part of a group which was
-	 * already attached to a domain in a previous call, or it's
-	 * been put in a default DMA domain by the IOMMU core.
-	 */
-	if (!domain) {
-		/*
-		 * Urgh. The IOMMU core isn't going to do default domains
-		 * for non-PCI devices anyway, until it has some means of
-		 * abstracting the entirely implementation-specific
-		 * sideband data/SoC topology/unicorn dust that may or
-		 * may not differentiate upstream masters.
-		 * So until then, HORRIBLE HACKS!
-		 */
-		domain = ops->domain_alloc(IOMMU_DOMAIN_DMA);
-		if (!domain)
-			goto out_no_domain;
-
-		domain->ops = ops;
-		domain->type = IOMMU_DOMAIN_DMA | __IOMMU_DOMAIN_FAKE_DEFAULT;
-
-		if (iommu_attach_device(domain, dev))
-			goto out_put_domain;
-	}
-
-	if (iommu_dma_init_domain(domain, dma_base, size))
-		goto out_detach;
-
-	dev->archdata.dma_ops = &iommu_dma_ops;
-	return true;
-
-out_detach:
-	iommu_detach_device(domain, dev);
-out_put_domain:
-	if (domain->type & __IOMMU_DOMAIN_FAKE_DEFAULT)
-		iommu_domain_free(domain);
-out_no_domain:
-	pr_warn("Failed to set up IOMMU for device %s; retaining platform DMA ops\n",
-		dev_name(dev));
-	return false;
-}
-
-static void queue_iommu_attach(struct device *dev, const struct iommu_ops *ops,
-			      u64 dma_base, u64 size)
-{
-	struct iommu_dma_notifier_data *iommudata;
-
-	iommudata = kzalloc(sizeof(*iommudata), GFP_KERNEL);
-	if (!iommudata)
-		return;
-
-	iommudata->dev = dev;
-	iommudata->ops = ops;
-	iommudata->dma_base = dma_base;
-	iommudata->size = size;
-
-	mutex_lock(&iommu_dma_notifier_lock);
-	list_add(&iommudata->list, &iommu_dma_masters);
-	mutex_unlock(&iommu_dma_notifier_lock);
-}
-
-static int __iommu_attach_notifier(struct notifier_block *nb,
-				   unsigned long action, void *data)
-{
-	struct iommu_dma_notifier_data *master, *tmp;
-
-	if (action != BUS_NOTIFY_ADD_DEVICE)
-		return 0;
-
-	mutex_lock(&iommu_dma_notifier_lock);
-	list_for_each_entry_safe(master, tmp, &iommu_dma_masters, list) {
-		if (do_iommu_attach(master->dev, master->ops,
-				master->dma_base, master->size)) {
-			list_del(&master->list);
-			kfree(master);
-		}
-	}
-	mutex_unlock(&iommu_dma_notifier_lock);
-	return 0;
-}
-
-static int __init register_iommu_dma_ops_notifier(struct bus_type *bus)
-{
-	struct notifier_block *nb = kzalloc(sizeof(*nb), GFP_KERNEL);
-	int ret;
-
-	if (!nb)
-		return -ENOMEM;
-	/*
-	 * The device must be attached to a domain before the driver probe
-	 * routine gets a chance to start allocating DMA buffers. However,
-	 * the IOMMU driver also needs a chance to configure the iommu_group
-	 * via its add_device callback first, so we need to make the attach
-	 * happen between those two points. Since the IOMMU core uses a bus
-	 * notifier with default priority for add_device, do the same but
-	 * with a lower priority to ensure the appropriate ordering.
-	 */
-	nb->notifier_call = __iommu_attach_notifier;
-	nb->priority = -100;
-
-	ret = bus_register_notifier(bus, nb);
-	if (ret) {
-		pr_warn("Failed to register DMA domain notifier; IOMMU DMA ops unavailable on bus '%s'\n",
-			bus->name);
-		kfree(nb);
-	}
-	return ret;
-}
-
-static int __init __iommu_dma_init(void)
-{
-	int ret;
-
-	ret = iommu_dma_init();
-	if (!ret)
-		ret = register_iommu_dma_ops_notifier(&platform_bus_type);
-	if (!ret)
-		ret = register_iommu_dma_ops_notifier(&amba_bustype);
-
-	/* handle devices queued before this arch_initcall */
-	if (!ret)
-		__iommu_attach_notifier(NULL, BUS_NOTIFY_ADD_DEVICE, NULL);
-	return ret;
-}
-arch_initcall(__iommu_dma_init);
-
-static void __iommu_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
-				  const struct iommu_ops *ops)
+void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
+			struct iommu_ops *iommu, bool coherent)
 {
-	struct iommu_group *group;
+	dev->archdata.dma_coherent = coherent;
 
-	if (!ops)
-		return;
-	/*
-	 * TODO: As a concession to the future, we're ready to handle being
-	 * called both early and late (i.e. after bus_add_device). Once all
-	 * the platform bus code is reworked to call us late and the notifier
-	 * junk above goes away, move the body of do_iommu_attach here.
-	 */
-	group = iommu_group_get(dev);
-	if (group) {
-		do_iommu_attach(dev, ops, dma_base, size);
-		iommu_group_put(group);
-	} else {
-		queue_iommu_attach(dev, ops, dma_base, size);
-	}
+	if (!common_iommu_setup_dma_ops(dev, dma_base, size, iommu))
+		arch_set_dma_ops(dev, &swiotlb_dma_ops);
 }
 
 void arch_teardown_dma_ops(struct device *dev)
 {
-	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
-
-	if (domain) {
-		iommu_detach_device(domain, dev);
-		if (domain->type & __IOMMU_DOMAIN_FAKE_DEFAULT)
-			iommu_domain_free(domain);
-	}
-
-	dev->archdata.dma_ops = NULL;
-}
-
-#else
-
-static void __iommu_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
-				  struct iommu_ops *iommu)
-{ }
-
-#endif  /* CONFIG_IOMMU_DMA */
-
-void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
-			struct iommu_ops *iommu, bool coherent)
-{
-	if (!dev->archdata.dma_ops)
-		dev->archdata.dma_ops = &swiotlb_dma_ops;
-
-	dev->archdata.dma_coherent = coherent;
-	__iommu_setup_dma_ops(dev, dma_base, size, iommu);
+	common_iommu_teardown_dma_ops(dev);
 }
diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index 42fc0c25cf1a..c0dbf765bf45 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -1,7 +1,7 @@
 obj-$(CONFIG_IOMMU_API) += iommu.o
 obj-$(CONFIG_IOMMU_API) += iommu-traces.o
 obj-$(CONFIG_IOMMU_API) += iommu-sysfs.o
-obj-$(CONFIG_IOMMU_DMA) += dma-iommu.o
+obj-$(CONFIG_IOMMU_DMA) += dma-iommu.o dma-iommu-ops.o
 obj-$(CONFIG_IOMMU_IO_PGTABLE) += io-pgtable.o
 obj-$(CONFIG_IOMMU_IO_PGTABLE_LPAE) += io-pgtable-arm.o
 obj-$(CONFIG_IOMMU_IOVA) += iova.o
diff --git a/drivers/iommu/dma-iommu-ops.c b/drivers/iommu/dma-iommu-ops.c
new file mode 100644
index 000000000000..047c47e3c0ab
--- /dev/null
+++ b/drivers/iommu/dma-iommu-ops.c
@@ -0,0 +1,471 @@
+/*
+ * A common IOMMU based DMA-API implementation for ARM and ARM64 architecutes.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/device.h>
+#include <linux/dma-iommu.h>
+#include <linux/gfp.h>
+#include <linux/huge_mm.h>
+#include <linux/iommu.h>
+#include <linux/iova.h>
+#include <linux/mm.h>
+#include <linux/scatterlist.h>
+#include <linux/vmalloc.h>
+
+#include <linux/platform_device.h>
+#include <linux/amba/bus.h>
+
+#include <asm/dma-mapping.h>
+
+static void *__iommu_alloc_attrs(struct device *dev, size_t size,
+				 dma_addr_t *handle, gfp_t gfp,
+				 struct dma_attrs *attrs)
+{
+	bool coherent = is_device_dma_coherent(dev);
+	int ioprot = dma_direction_to_prot(DMA_BIDIRECTIONAL, coherent);
+	size_t iosize = size;
+	void *addr;
+
+	if (WARN(!dev, "cannot create IOMMU mapping for unknown device\n"))
+		return NULL;
+
+	size = PAGE_ALIGN(size);
+
+	/*
+	 * Some drivers rely on this, and we probably don't want the
+	 * possibility of stale kernel data being read by devices anyway.
+	 */
+	gfp |= __GFP_ZERO;
+
+	if (gfpflags_allow_blocking(gfp)) {
+		struct page **pages;
+		pgprot_t prot = arch_get_dma_pgprot(attrs, PAGE_KERNEL,
+						    coherent);
+
+		pages = iommu_dma_alloc(dev, iosize, gfp, ioprot, handle,
+					arch_flush_page);
+		if (!pages)
+			return NULL;
+
+		addr = dma_common_pages_remap(pages, size, VM_USERMAP, prot,
+					      __builtin_return_address(0));
+		if (!addr)
+			iommu_dma_free(dev, pages, iosize, handle);
+	} else {
+		struct page *page;
+		/*
+		 * In atomic context we can't remap anything, so we'll only
+		 * get the virtually contiguous buffer we need by way of a
+		 * physically contiguous allocation.
+		 */
+		if (coherent) {
+			page = alloc_pages(gfp, get_order(size));
+			addr = page ? page_address(page) : NULL;
+		} else {
+			addr = arch_alloc_from_atomic_pool(size, &page, gfp);
+		}
+		if (!addr)
+			return NULL;
+
+		*handle = iommu_dma_map_page(dev, page, 0, iosize, ioprot);
+		if (iommu_dma_mapping_error(dev, *handle)) {
+			if (coherent)
+				__free_pages(page, get_order(size));
+			else
+				arch_free_from_atomic_pool(addr, size);
+			addr = NULL;
+		}
+	}
+	return addr;
+}
+
+static void __iommu_free_attrs(struct device *dev, size_t size, void *cpu_addr,
+			       dma_addr_t handle, struct dma_attrs *attrs)
+{
+	size_t iosize = size;
+
+	size = PAGE_ALIGN(size);
+	/*
+	 * @cpu_addr will be one of 3 things depending on how it was allocated:
+	 * - A remapped array of pages from iommu_dma_alloc(), for all
+	 *   non-atomic allocations.
+	 * - A non-cacheable alias from the atomic pool, for atomic
+	 *   allocations by non-coherent devices.
+	 * - A normal lowmem address, for atomic allocations by
+	 *   coherent devices.
+	 * Hence how dodgy the below logic looks...
+	 */
+	if (arch_in_atomic_pool(cpu_addr, size)) {
+		iommu_dma_unmap_page(dev, handle, iosize, 0, NULL);
+		arch_free_from_atomic_pool(cpu_addr, size);
+	} else if (is_vmalloc_addr(cpu_addr)){
+		struct vm_struct *area = find_vm_area(cpu_addr);
+
+		if (WARN_ON(!area || !area->pages))
+			return;
+		iommu_dma_free(dev, area->pages, iosize, &handle);
+		dma_common_free_remap(cpu_addr, size, VM_USERMAP);
+	} else {
+		iommu_dma_unmap_page(dev, handle, iosize, 0, NULL);
+		__free_pages(virt_to_page(cpu_addr), get_order(size));
+	}
+}
+
+static int __iommu_mmap_attrs(struct device *dev, struct vm_area_struct *vma,
+			      void *cpu_addr, dma_addr_t dma_addr, size_t size,
+			      struct dma_attrs *attrs)
+{
+	struct vm_struct *area;
+	int ret;
+
+	vma->vm_page_prot = arch_get_dma_pgprot(attrs, vma->vm_page_prot,
+					        is_device_dma_coherent(dev));
+
+	if (dma_mmap_from_coherent(dev, vma, cpu_addr, size, &ret))
+		return ret;
+
+	area = find_vm_area(cpu_addr);
+	if (WARN_ON(!area || !area->pages))
+		return -ENXIO;
+
+	return iommu_dma_mmap(area->pages, size, vma);
+}
+
+static int __iommu_get_sgtable(struct device *dev, struct sg_table *sgt,
+			       void *cpu_addr, dma_addr_t dma_addr,
+			       size_t size, struct dma_attrs *attrs)
+{
+	unsigned int count = PAGE_ALIGN(size) >> PAGE_SHIFT;
+	struct vm_struct *area = find_vm_area(cpu_addr);
+
+	if (WARN_ON(!area || !area->pages))
+		return -ENXIO;
+
+	return sg_alloc_table_from_pages(sgt, area->pages, count, 0, size,
+					 GFP_KERNEL);
+}
+
+static void __iommu_sync_single_for_cpu(struct device *dev,
+					dma_addr_t dev_addr, size_t size,
+					enum dma_data_direction dir)
+{
+	phys_addr_t phys;
+
+	if (is_device_dma_coherent(dev))
+		return;
+
+	phys = iommu_iova_to_phys(iommu_get_domain_for_dev(dev), dev_addr);
+	arch_dma_unmap_area(phys, size, dir);
+}
+
+static void __iommu_sync_single_for_device(struct device *dev,
+					   dma_addr_t dev_addr, size_t size,
+					   enum dma_data_direction dir)
+{
+	phys_addr_t phys;
+
+	if (is_device_dma_coherent(dev))
+		return;
+
+	phys = iommu_iova_to_phys(iommu_get_domain_for_dev(dev), dev_addr);
+	arch_dma_map_area(phys, size, dir);
+}
+
+static dma_addr_t __iommu_map_page(struct device *dev, struct page *page,
+				   unsigned long offset, size_t size,
+				   enum dma_data_direction dir,
+				   struct dma_attrs *attrs)
+{
+	bool coherent = is_device_dma_coherent(dev);
+	int prot = dma_direction_to_prot(dir, coherent);
+	dma_addr_t dev_addr = iommu_dma_map_page(dev, page, offset, size, prot);
+
+	if (!iommu_dma_mapping_error(dev, dev_addr) &&
+	    !dma_get_attr(DMA_ATTR_SKIP_CPU_SYNC, attrs))
+		__iommu_sync_single_for_device(dev, dev_addr, size, dir);
+
+	return dev_addr;
+}
+
+static void __iommu_unmap_page(struct device *dev, dma_addr_t dev_addr,
+			       size_t size, enum dma_data_direction dir,
+			       struct dma_attrs *attrs)
+{
+	if (!dma_get_attr(DMA_ATTR_SKIP_CPU_SYNC, attrs))
+		__iommu_sync_single_for_cpu(dev, dev_addr, size, dir);
+
+	iommu_dma_unmap_page(dev, dev_addr, size, dir, attrs);
+}
+
+static void __iommu_sync_sg_for_cpu(struct device *dev,
+				    struct scatterlist *sgl, int nelems,
+				    enum dma_data_direction dir)
+{
+	struct scatterlist *sg;
+	int i;
+
+	if (is_device_dma_coherent(dev))
+		return;
+
+	for_each_sg(sgl, sg, nelems, i)
+		arch_dma_unmap_area(sg_phys(sg), sg->length, dir);
+}
+
+static void __iommu_sync_sg_for_device(struct device *dev,
+				       struct scatterlist *sgl, int nelems,
+				       enum dma_data_direction dir)
+{
+	struct scatterlist *sg;
+	int i;
+
+	if (is_device_dma_coherent(dev))
+		return;
+
+	for_each_sg(sgl, sg, nelems, i)
+		arch_dma_map_area(sg_phys(sg), sg->length, dir);
+}
+
+static int __iommu_map_sg_attrs(struct device *dev, struct scatterlist *sgl,
+				int nelems, enum dma_data_direction dir,
+				struct dma_attrs *attrs)
+{
+	bool coherent = is_device_dma_coherent(dev);
+
+	if (!dma_get_attr(DMA_ATTR_SKIP_CPU_SYNC, attrs))
+		__iommu_sync_sg_for_device(dev, sgl, nelems, dir);
+
+	return iommu_dma_map_sg(dev, sgl, nelems,
+			dma_direction_to_prot(dir, coherent));
+}
+
+static void __iommu_unmap_sg_attrs(struct device *dev,
+				   struct scatterlist *sgl, int nelems,
+				   enum dma_data_direction dir,
+				   struct dma_attrs *attrs)
+{
+	if (!dma_get_attr(DMA_ATTR_SKIP_CPU_SYNC, attrs))
+		__iommu_sync_sg_for_cpu(dev, sgl, nelems, dir);
+
+	iommu_dma_unmap_sg(dev, sgl, nelems, dir, attrs);
+}
+
+static struct dma_map_ops iommu_dma_ops = {
+	.alloc = __iommu_alloc_attrs,
+	.free = __iommu_free_attrs,
+	.mmap = __iommu_mmap_attrs,
+	.get_sgtable = __iommu_get_sgtable,
+	.map_page = __iommu_map_page,
+	.unmap_page = __iommu_unmap_page,
+	.map_sg = __iommu_map_sg_attrs,
+	.unmap_sg = __iommu_unmap_sg_attrs,
+	.sync_single_for_cpu = __iommu_sync_single_for_cpu,
+	.sync_single_for_device = __iommu_sync_single_for_device,
+	.sync_sg_for_cpu = __iommu_sync_sg_for_cpu,
+	.sync_sg_for_device = __iommu_sync_sg_for_device,
+	.dma_supported = iommu_dma_supported,
+	.mapping_error = iommu_dma_mapping_error,
+};
+
+/*
+ * TODO: Right now __iommu_setup_dma_ops() gets called too early to do
+ * everything it needs to - the device is only partially created and the
+ * IOMMU driver hasn't seen it yet, so it can't have a group. Thus we
+ * need this delayed attachment dance. Once IOMMU probe ordering is sorted
+ * to move the arch_setup_dma_ops() call later, all the notifier bits below
+ * become unnecessary, and will go away.
+ */
+struct iommu_dma_notifier_data {
+	struct list_head list;
+	struct device *dev;
+	const struct iommu_ops *ops;
+	u64 dma_base;
+	u64 size;
+};
+static LIST_HEAD(iommu_dma_masters);
+static DEFINE_MUTEX(iommu_dma_notifier_lock);
+
+/*
+ * Temporarily "borrow" a domain feature flag to to tell if we had to resort
+ * to creating our own domain here, in case we need to clean it up again.
+ */
+#define __IOMMU_DOMAIN_FAKE_DEFAULT		(1U << 31)
+
+static bool do_iommu_attach(struct device *dev, const struct iommu_ops *ops,
+			   u64 dma_base, u64 size)
+{
+	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
+
+	/*
+	 * Best case: The device is either part of a group which was
+	 * already attached to a domain in a previous call, or it's
+	 * been put in a default DMA domain by the IOMMU core.
+	 */
+	if (!domain) {
+		/*
+		 * Urgh. The IOMMU core isn't going to do default domains
+		 * for non-PCI devices anyway, until it has some means of
+		 * abstracting the entirely implementation-specific
+		 * sideband data/SoC topology/unicorn dust that may or
+		 * may not differentiate upstream masters.
+		 * So until then, HORRIBLE HACKS!
+		 */
+		domain = ops->domain_alloc(IOMMU_DOMAIN_DMA);
+		if (!domain)
+			goto out_no_domain;
+
+		domain->ops = ops;
+		domain->type = IOMMU_DOMAIN_DMA | __IOMMU_DOMAIN_FAKE_DEFAULT;
+
+		if (iommu_attach_device(domain, dev))
+			goto out_put_domain;
+	}
+
+	if (iommu_dma_init_domain(domain, dma_base, size))
+		goto out_detach;
+
+	arch_set_dma_ops(dev, &iommu_dma_ops);
+	return true;
+
+out_detach:
+	iommu_detach_device(domain, dev);
+out_put_domain:
+	if (domain->type & __IOMMU_DOMAIN_FAKE_DEFAULT)
+		iommu_domain_free(domain);
+out_no_domain:
+	pr_warn("Failed to set up IOMMU for device %s; retaining platform DMA ops\n",
+		dev_name(dev));
+	return false;
+}
+
+static void queue_iommu_attach(struct device *dev, const struct iommu_ops *ops,
+			      u64 dma_base, u64 size)
+{
+	struct iommu_dma_notifier_data *iommudata;
+
+	iommudata = kzalloc(sizeof(*iommudata), GFP_KERNEL);
+	if (!iommudata)
+		return;
+
+	iommudata->dev = dev;
+	iommudata->ops = ops;
+	iommudata->dma_base = dma_base;
+	iommudata->size = size;
+
+	mutex_lock(&iommu_dma_notifier_lock);
+	list_add(&iommudata->list, &iommu_dma_masters);
+	mutex_unlock(&iommu_dma_notifier_lock);
+}
+
+static int __iommu_attach_notifier(struct notifier_block *nb,
+				   unsigned long action, void *data)
+{
+	struct iommu_dma_notifier_data *master, *tmp;
+
+	if (action != BUS_NOTIFY_ADD_DEVICE)
+		return 0;
+
+	mutex_lock(&iommu_dma_notifier_lock);
+	list_for_each_entry_safe(master, tmp, &iommu_dma_masters, list) {
+		if (do_iommu_attach(master->dev, master->ops,
+				master->dma_base, master->size)) {
+			list_del(&master->list);
+			kfree(master);
+		}
+	}
+	mutex_unlock(&iommu_dma_notifier_lock);
+	return 0;
+}
+
+static int __init register_iommu_dma_ops_notifier(struct bus_type *bus)
+{
+	struct notifier_block *nb = kzalloc(sizeof(*nb), GFP_KERNEL);
+	int ret;
+
+	if (!nb)
+		return -ENOMEM;
+	/*
+	 * The device must be attached to a domain before the driver probe
+	 * routine gets a chance to start allocating DMA buffers. However,
+	 * the IOMMU driver also needs a chance to configure the iommu_group
+	 * via its add_device callback first, so we need to make the attach
+	 * happen between those two points. Since the IOMMU core uses a bus
+	 * notifier with default priority for add_device, do the same but
+	 * with a lower priority to ensure the appropriate ordering.
+	 */
+	nb->notifier_call = __iommu_attach_notifier;
+	nb->priority = -100;
+
+	ret = bus_register_notifier(bus, nb);
+	if (ret) {
+		pr_warn("Failed to register DMA domain notifier; IOMMU DMA ops unavailable on bus '%s'\n",
+			bus->name);
+		kfree(nb);
+	}
+	return ret;
+}
+
+static int __init __iommu_dma_init(void)
+{
+	int ret;
+
+	ret = iommu_dma_init();
+	if (!ret)
+		ret = register_iommu_dma_ops_notifier(&platform_bus_type);
+	if (!ret)
+		ret = register_iommu_dma_ops_notifier(&amba_bustype);
+
+	/* handle devices queued before this arch_initcall */
+	if (!ret)
+		__iommu_attach_notifier(NULL, BUS_NOTIFY_ADD_DEVICE, NULL);
+	return ret;
+}
+arch_initcall(__iommu_dma_init);
+
+bool common_iommu_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
+				  const struct iommu_ops *ops)
+{
+	struct iommu_group *group;
+
+	if (!ops)
+		return false;
+	/*
+	 * TODO: As a concession to the future, we're ready to handle being
+	 * called both early and late (i.e. after bus_add_device). Once all
+	 * the platform bus code is reworked to call us late and the notifier
+	 * junk above goes away, move the body of do_iommu_attach here.
+	 */
+	group = iommu_group_get(dev);
+	if (group) {
+		do_iommu_attach(dev, ops, dma_base, size);
+		iommu_group_put(group);
+	} else {
+		queue_iommu_attach(dev, ops, dma_base, size);
+	}
+
+	return true;
+}
+
+void common_iommu_teardown_dma_ops(struct device *dev)
+{
+	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
+
+	if (domain) {
+		iommu_detach_device(domain, dev);
+		if (domain->type & __IOMMU_DOMAIN_FAKE_DEFAULT)
+			iommu_domain_free(domain);
+	}
+
+	arch_set_dma_ops(dev, NULL);
+}
diff --git a/include/linux/dma-iommu.h b/include/linux/dma-iommu.h
index fc481037478a..01a836c43dc3 100644
--- a/include/linux/dma-iommu.h
+++ b/include/linux/dma-iommu.h
@@ -62,6 +62,10 @@ void iommu_dma_unmap_sg(struct device *dev, struct scatterlist *sg, int nents,
 int iommu_dma_supported(struct device *dev, u64 mask);
 int iommu_dma_mapping_error(struct device *dev, dma_addr_t dma_addr);
 
+bool common_iommu_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
+				  const struct iommu_ops *ops);
+void common_iommu_teardown_dma_ops(struct device *dev);
+
 #else
 
 struct iommu_domain;
@@ -80,6 +84,16 @@ static inline void iommu_put_dma_cookie(struct iommu_domain *domain)
 {
 }
 
+static inline bool common_iommu_setup_dma_ops(struct device *dev, u64 dma_base,
+					u64 size, const struct iommu_ops *ops)
+{
+	return false;
+}
+
+static inline void common_iommu_teardown_dma_ops(struct device *dev)
+{
+}
+
 #endif	/* CONFIG_IOMMU_DMA */
 #endif	/* __KERNEL__ */
 #endif	/* __DMA_IOMMU_H */
-- 
1.9.2
