From: robherring2@gmail.com (Rob Herring)
Date: Mon, 13 Aug 2012 22:49:04 -0500
Subject: [PATCH 1/4] ARM: add coherent dma ops
In-Reply-To: <1344916147-13546-1-git-send-email-robherring2@gmail.com>
References: <1344916147-13546-1-git-send-email-robherring2@gmail.com>
Message-ID: <1344916147-13546-2-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

arch_is_coherent is problematic as it is a global symbol. This
doesn't work for multi-platform kernels or platforms which can support
per device coherent DMA.

This adds arm_coherent_dma_ops to be used for devices which connected
coherently (i.e. to the ACP port on Cortex-A9 or A15). The arm_dma_ops
are modified at boot when arch_is_coherent is true.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/include/asm/dma-mapping.h |    1 +
 arch/arm/mm/dma-mapping.c          |   71 ++++++++++++++++++++++++++++++------
 2 files changed, 60 insertions(+), 12 deletions(-)

diff --git a/arch/arm/include/asm/dma-mapping.h b/arch/arm/include/asm/dma-mapping.h
index 2ae842d..c27d855 100644
--- a/arch/arm/include/asm/dma-mapping.h
+++ b/arch/arm/include/asm/dma-mapping.h
@@ -13,6 +13,7 @@
 
 #define DMA_ERROR_CODE	(~0)
 extern struct dma_map_ops arm_dma_ops;
+extern struct dma_map_ops arm_coherent_dma_ops;
 
 static inline struct dma_map_ops *get_dma_ops(struct device *dev)
 {
diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index c2cdf65..c14e37e 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -73,11 +73,18 @@ static dma_addr_t arm_dma_map_page(struct device *dev, struct page *page,
 	     unsigned long offset, size_t size, enum dma_data_direction dir,
 	     struct dma_attrs *attrs)
 {
-	if (!arch_is_coherent() && !dma_get_attr(DMA_ATTR_SKIP_CPU_SYNC, attrs))
+	if (!dma_get_attr(DMA_ATTR_SKIP_CPU_SYNC, attrs))
 		__dma_page_cpu_to_dev(page, offset, size, dir);
 	return pfn_to_dma(dev, page_to_pfn(page)) + offset;
 }
 
+static dma_addr_t arm_coherent_dma_map_page(struct device *dev, struct page *page,
+	     unsigned long offset, size_t size, enum dma_data_direction dir,
+	     struct dma_attrs *attrs)
+{
+	return pfn_to_dma(dev, page_to_pfn(page)) + offset;
+}
+
 /**
  * arm_dma_unmap_page - unmap a buffer previously mapped through dma_map_page()
  * @dev: valid struct device pointer, or NULL for ISA and EISA-like devices
@@ -96,7 +103,7 @@ static void arm_dma_unmap_page(struct device *dev, dma_addr_t handle,
 		size_t size, enum dma_data_direction dir,
 		struct dma_attrs *attrs)
 {
-	if (!arch_is_coherent() && !dma_get_attr(DMA_ATTR_SKIP_CPU_SYNC, attrs))
+	if (!dma_get_attr(DMA_ATTR_SKIP_CPU_SYNC, attrs))
 		__dma_page_dev_to_cpu(pfn_to_page(dma_to_pfn(dev, handle)),
 				      handle & ~PAGE_MASK, size, dir);
 }
@@ -106,8 +113,7 @@ static void arm_dma_sync_single_for_cpu(struct device *dev,
 {
 	unsigned int offset = handle & (PAGE_SIZE - 1);
 	struct page *page = pfn_to_page(dma_to_pfn(dev, handle-offset));
-	if (!arch_is_coherent())
-		__dma_page_dev_to_cpu(page, offset, size, dir);
+	__dma_page_dev_to_cpu(page, offset, size, dir);
 }
 
 static void arm_dma_sync_single_for_device(struct device *dev,
@@ -115,8 +121,7 @@ static void arm_dma_sync_single_for_device(struct device *dev,
 {
 	unsigned int offset = handle & (PAGE_SIZE - 1);
 	struct page *page = pfn_to_page(dma_to_pfn(dev, handle-offset));
-	if (!arch_is_coherent())
-		__dma_page_cpu_to_dev(page, offset, size, dir);
+	__dma_page_cpu_to_dev(page, offset, size, dir);
 }
 
 static int arm_dma_set_mask(struct device *dev, u64 dma_mask);
@@ -138,6 +143,22 @@ struct dma_map_ops arm_dma_ops = {
 };
 EXPORT_SYMBOL(arm_dma_ops);
 
+static void *arm_coherent_dma_alloc(struct device *dev, size_t size,
+	dma_addr_t *handle, gfp_t gfp, struct dma_attrs *attrs);
+static void arm_coherent_dma_free(struct device *dev, size_t size, void *cpu_addr,
+				  dma_addr_t handle, struct dma_attrs *attrs);
+
+struct dma_map_ops arm_coherent_dma_ops = {
+	.alloc			= arm_coherent_dma_alloc,
+	.free			= arm_coherent_dma_free,
+	.mmap			= arm_dma_mmap,
+	.get_sgtable		= arm_dma_get_sgtable,
+	.map_page		= arm_coherent_dma_map_page,
+	.map_sg			= arm_dma_map_sg,
+	.set_dma_mask		= arm_dma_set_mask,
+};
+EXPORT_SYMBOL(arm_coherent_dma_ops);
+
 static u64 get_coherent_dma_mask(struct device *dev)
 {
 	u64 mask = (u64)arm_dma_limit;
@@ -538,7 +559,7 @@ static void *__alloc_simple_buffer(struct device *dev, size_t size, gfp_t gfp,
 
 
 static void *__dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
-			 gfp_t gfp, pgprot_t prot, const void *caller)
+			 gfp_t gfp, pgprot_t prot, bool is_coherent, const void *caller)
 {
 	u64 mask = get_coherent_dma_mask(dev);
 	struct page *page;
@@ -571,7 +592,7 @@ static void *__dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
 	*handle = DMA_ERROR_CODE;
 	size = PAGE_ALIGN(size);
 
-	if (arch_is_coherent() || nommu())
+	if (is_coherent || nommu())
 		addr = __alloc_simple_buffer(dev, size, gfp, &page);
 	else if (gfp & GFP_ATOMIC)
 		addr = __alloc_from_pool(size, &page);
@@ -599,7 +620,20 @@ void *arm_dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
 	if (dma_alloc_from_coherent(dev, size, handle, &memory))
 		return memory;
 
-	return __dma_alloc(dev, size, handle, gfp, prot,
+	return __dma_alloc(dev, size, handle, gfp, prot, false,
+			   __builtin_return_address(0));
+}
+
+static void *arm_coherent_dma_alloc(struct device *dev, size_t size,
+	dma_addr_t *handle, gfp_t gfp, struct dma_attrs *attrs)
+{
+	pgprot_t prot = __get_dma_pgprot(attrs, pgprot_kernel);
+	void *memory;
+
+	if (dma_alloc_from_coherent(dev, size, handle, &memory))
+		return memory;
+
+	return __dma_alloc(dev, size, handle, gfp, prot, true,
 			   __builtin_return_address(0));
 }
 
@@ -636,8 +670,9 @@ int arm_dma_mmap(struct device *dev, struct vm_area_struct *vma,
 /*
  * Free a buffer as defined by the above mapping.
  */
-void arm_dma_free(struct device *dev, size_t size, void *cpu_addr,
-		  dma_addr_t handle, struct dma_attrs *attrs)
+static void __arm_dma_free(struct device *dev, size_t size, void *cpu_addr,
+			   dma_addr_t handle, struct dma_attrs *attrs,
+			   bool is_coherent)
 {
 	struct page *page = pfn_to_page(dma_to_pfn(dev, handle));
 
@@ -646,7 +681,7 @@ void arm_dma_free(struct device *dev, size_t size, void *cpu_addr,
 
 	size = PAGE_ALIGN(size);
 
-	if (arch_is_coherent() || nommu()) {
+	if (is_coherent || nommu()) {
 		__dma_free_buffer(page, size);
 	} else if (!IS_ENABLED(CONFIG_CMA)) {
 		__dma_free_remap(cpu_addr, size);
@@ -662,6 +697,18 @@ void arm_dma_free(struct device *dev, size_t size, void *cpu_addr,
 	}
 }
 
+void arm_dma_free(struct device *dev, size_t size, void *cpu_addr,
+		  dma_addr_t handle, struct dma_attrs *attrs)
+{
+	__arm_dma_free(dev, size, cpu_addr, handle, attrs, false);
+}
+
+static void arm_coherent_dma_free(struct device *dev, size_t size, void *cpu_addr,
+				  dma_addr_t handle, struct dma_attrs *attrs)
+{
+	__arm_dma_free(dev, size, cpu_addr, handle, attrs, true);
+}
+
 int arm_dma_get_sgtable(struct device *dev, struct sg_table *sgt,
 		 void *cpu_addr, dma_addr_t handle, size_t size,
 		 struct dma_attrs *attrs)
-- 
1.7.9.5
