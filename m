From: jamie@jamieiles.com (Jamie Iles)
Date: Tue, 21 Dec 2010 10:20:01 +0000
Subject: [PATCH 1/2] ARM: convert dma-mapping to asm-generic API
Message-ID: <1292926802-12326-1-git-send-email-jamie@jamieiles.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This converts ARM to use the asm-generic/dma-mapping-common API for
the DMA API. As a side effect, this also allows us to take advantage
of DMA API debugging (CONFIG_DMA_API_DEBUG).

We have dma_map_ops for normal, non-coherent architectures, fully
coherent architectures and architectures that require dmabounce
support. A dma_ops field is added to struct dev_archdata so platforms
using an ACP can override the dma operations for that device to be
fully coherent e.g.

	struct device *my_coherent_device;
	my_coherent_device->dev_archdata.dma_ops = &coherent_dma_ops;

Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Signed-off-by: Jamie Iles <jamie@jamieiles.com>
---

Note: this patch also requires "ARM: dmabounce: fix partial sync in
dma_sync_single_* API" from FUJITA Tomonori:

	http://www.spinics.net/lists/netdev/msg126826.html

which allows us to do fuzzy matching of the buffers when using
dmabounce.

 arch/arm/Kconfig                   |    2 +
 arch/arm/common/dmabounce.c        |  157 ++++++++++++++++----------
 arch/arm/include/asm/device.h      |    5 +-
 arch/arm/include/asm/dma-mapping.h |  221 ++++--------------------------------
 arch/arm/mm/dma-mapping.c          |  220 +++++++++++++++++++++++------------
 5 files changed, 270 insertions(+), 335 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 2d26e54..0ba5088 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -16,6 +16,8 @@ config ARM
 	select HAVE_DYNAMIC_FTRACE if (!XIP_KERNEL)
 	select HAVE_FUNCTION_GRAPH_TRACER if (!THUMB2_KERNEL)
 	select HAVE_GENERIC_DMA_COHERENT
+	select HAVE_DMA_ATTRS
+	select HAVE_DMA_API_DEBUG
 	select HAVE_KERNEL_GZIP
 	select HAVE_KERNEL_LZO
 	select HAVE_KERNEL_LZMA
diff --git a/arch/arm/common/dmabounce.c b/arch/arm/common/dmabounce.c
index 2e6deec..8b9c524 100644
--- a/arch/arm/common/dmabounce.c
+++ b/arch/arm/common/dmabounce.c
@@ -332,42 +332,10 @@ static inline void unmap_single(struct device *dev, dma_addr_t dma_addr,
 
 /* ************************************************** */
 
-/*
- * see if a buffer address is in an 'unsafe' range.  if it is
- * allocate a 'safe' buffer and copy the unsafe buffer into it.
- * substitute the safe buffer for the unsafe one.
- * (basically move the buffer from an unsafe area to a safe one)
- */
-dma_addr_t dma_map_single(struct device *dev, void *ptr, size_t size,
-		enum dma_data_direction dir)
-{
-	dev_dbg(dev, "%s(ptr=%p,size=%d,dir=%x)\n",
-		__func__, ptr, size, dir);
-
-	BUG_ON(!valid_dma_direction(dir));
-
-	return map_single(dev, ptr, size, dir);
-}
-EXPORT_SYMBOL(dma_map_single);
-
-/*
- * see if a mapped address was really a "safe" buffer and if so, copy
- * the data from the safe buffer back to the unsafe buffer and free up
- * the safe buffer.  (basically return things back to the way they
- * should be)
- */
-void dma_unmap_single(struct device *dev, dma_addr_t dma_addr, size_t size,
-		enum dma_data_direction dir)
-{
-	dev_dbg(dev, "%s(ptr=%p,size=%d,dir=%x)\n",
-		__func__, (void *) dma_addr, size, dir);
-
-	unmap_single(dev, dma_addr, size, dir);
-}
-EXPORT_SYMBOL(dma_unmap_single);
-
-dma_addr_t dma_map_page(struct device *dev, struct page *page,
-		unsigned long offset, size_t size, enum dma_data_direction dir)
+static dma_addr_t dmabounce_map_page(struct device *dev, struct page *page,
+				     unsigned long offset, size_t size,
+				     enum dma_data_direction dir,
+				     struct dma_attrs *attrs)
 {
 	dev_dbg(dev, "%s(page=%p,off=%#lx,size=%zx,dir=%x)\n",
 		__func__, page, offset, size, dir);
@@ -382,7 +350,6 @@ dma_addr_t dma_map_page(struct device *dev, struct page *page,
 
 	return map_single(dev, page_address(page) + offset, size, dir);
 }
-EXPORT_SYMBOL(dma_map_page);
 
 /*
  * see if a mapped address was really a "safe" buffer and if so, copy
@@ -390,28 +357,34 @@ EXPORT_SYMBOL(dma_map_page);
  * the safe buffer.  (basically return things back to the way they
  * should be)
  */
-void dma_unmap_page(struct device *dev, dma_addr_t dma_addr, size_t size,
-		enum dma_data_direction dir)
+static void dmabounce_unmap_page(struct device *dev, dma_addr_t dma_addr,
+				 size_t size, enum dma_data_direction dir,
+				 struct dma_attrs *attrs)
 {
 	dev_dbg(dev, "%s(ptr=%p,size=%d,dir=%x)\n",
 		__func__, (void *) dma_addr, size, dir);
 
 	unmap_single(dev, dma_addr, size, dir);
 }
-EXPORT_SYMBOL(dma_unmap_page);
 
-int dmabounce_sync_for_cpu(struct device *dev, dma_addr_t addr,
-		unsigned long off, size_t sz, enum dma_data_direction dir)
+static void dmabounce_sync_for_cpu(struct device *dev, dma_addr_t addr,
+				   size_t sz, enum dma_data_direction dir)
 {
 	struct safe_buffer *buf;
+	unsigned long off;
+
+	buf = find_safe_buffer_dev(dev, addr, __func__, 1);
+	if (!buf) {
+		if (!arch_is_coherent())
+			non_coherent_dma_ops.sync_single_for_cpu(dev, addr,
+								 sz, dir);
+		return;
+	}
 
+	off = addr - buf->safe_dma_addr;
 	dev_dbg(dev, "%s(dma=%#x,off=%#lx,sz=%zx,dir=%x)\n",
 		__func__, addr, off, sz, dir);
 
-	buf = find_safe_buffer_dev(dev, addr, __func__, 1);
-	if (!buf)
-		return 1;
-
 	BUG_ON(buf->direction != dir);
 
 	dev_dbg(dev, "%s: unsafe buffer %p (dma=%#x) mapped to %p (dma=%#x)\n",
@@ -421,28 +394,30 @@ int dmabounce_sync_for_cpu(struct device *dev, dma_addr_t addr,
 	DO_STATS(dev->archdata.dmabounce->bounce_count++);
 
 	if (dir == DMA_FROM_DEVICE || dir == DMA_BIDIRECTIONAL) {
-		if (addr != buf->safe_dma_addr)
-			off = addr - buf->safe_dma_addr;
 		dev_dbg(dev, "%s: copy back safe %p to unsafe %p size %d\n",
 			__func__, buf->safe + off, buf->ptr + off, sz);
 		memcpy(buf->ptr + off, buf->safe + off, sz);
 	}
-	return 0;
 }
-EXPORT_SYMBOL(dmabounce_sync_for_cpu);
 
-int dmabounce_sync_for_device(struct device *dev, dma_addr_t addr,
-		unsigned long off, size_t sz, enum dma_data_direction dir)
+static void dmabounce_sync_for_device(struct device *dev, dma_addr_t addr,
+				      size_t sz, enum dma_data_direction dir)
 {
 	struct safe_buffer *buf;
+	unsigned long off;
+
+	buf = find_safe_buffer_dev(dev, addr, __func__, 1);
+	if (!buf) {
+		if (!arch_is_coherent())
+			non_coherent_dma_ops.sync_single_for_cpu(dev, addr,
+								 sz, dir);
+		return;
+	}
 
+	off = addr - buf->safe_dma_addr;
 	dev_dbg(dev, "%s(dma=%#x,off=%#lx,sz=%zx,dir=%x)\n",
 		__func__, addr, off, sz, dir);
 
-	buf = find_safe_buffer_dev(dev, addr, __func__, 1);
-	if (!buf)
-		return 1;
-
 	BUG_ON(buf->direction != dir);
 
 	dev_dbg(dev, "%s: unsafe buffer %p (dma=%#x) mapped to %p (dma=%#x)\n",
@@ -456,9 +431,7 @@ int dmabounce_sync_for_device(struct device *dev, dma_addr_t addr,
 			__func__,buf->ptr + off, buf->safe + off, sz);
 		memcpy(buf->safe + off, buf->ptr + off, sz);
 	}
-	return 0;
 }
-EXPORT_SYMBOL(dmabounce_sync_for_device);
 
 static int dmabounce_init_pool(struct dmabounce_pool *pool, struct device *dev,
 		const char *name, unsigned long size)
@@ -472,6 +445,73 @@ static int dmabounce_init_pool(struct dmabounce_pool *pool, struct device *dev,
 	return pool->pool ? 0 : -ENOMEM;
 }
 
+void dmabounce_sync_sg_for_cpu(struct device *dev, struct scatterlist *sg,
+			       int nents, enum dma_data_direction dir)
+{
+	struct scatterlist *s;
+	int i;
+
+	for_each_sg(sg, s, nents, i)
+		dmabounce_sync_for_cpu(dev, sg_dma_address(s), sg_dma_len(s),
+				       dir);
+}
+
+void dmabounce_sync_sg_for_device(struct device *dev, struct scatterlist *sg,
+				  int nents, enum dma_data_direction dir)
+{
+	struct scatterlist *s;
+	int i;
+
+	for_each_sg(sg, s, nents, i)
+		dmabounce_sync_for_device(dev, sg_dma_address(s), sg_dma_len(s),
+					  dir);
+}
+
+int dmabounce_map_sg(struct device *dev, struct scatterlist *sg, int nents,
+		     enum dma_data_direction dir, struct dma_attrs *attrs)
+{
+	struct scatterlist *s;
+	int i, j;
+
+	for_each_sg(sg, s, nents, i) {
+		s->dma_address = dmabounce_map_page(dev, sg_page(s),
+						    s->offset, s->length,
+						    dir, attrs);
+		if (dma_mapping_error(dev, s->dma_address))
+			goto bad_mapping;
+	}
+	return nents;
+
+ bad_mapping:
+	for_each_sg(sg, s, i, j)
+		dmabounce_unmap_page(dev, sg_dma_address(s), sg_dma_len(s),
+				     dir, attrs);
+	return 0;
+}
+
+void dmabounce_unmap_sg(struct device *dev, struct scatterlist *sg,
+			int nents, enum dma_data_direction dir,
+			struct dma_attrs *attrs)
+{
+	struct scatterlist *s;
+	int i;
+
+	for_each_sg(sg, s, nents, i)
+		dmabounce_unmap_page(dev, sg_dma_address(s), sg_dma_len(s),
+				     dir, attrs);
+}
+
+static struct dma_map_ops dmabounce_dma_ops = {
+	.map_page		= dmabounce_map_page,
+	.unmap_page		= dmabounce_unmap_page,
+	.map_sg			= dmabounce_map_sg,
+	.unmap_sg		= dmabounce_unmap_sg,
+	.sync_sg_for_cpu	= dmabounce_sync_sg_for_cpu,
+	.sync_sg_for_device	= dmabounce_sync_sg_for_device,
+	.sync_single_for_cpu	= dmabounce_sync_for_cpu,
+	.sync_single_for_device	= dmabounce_sync_for_device,
+};
+
 int dmabounce_register_dev(struct device *dev, unsigned long small_buffer_size,
 		unsigned long large_buffer_size)
 {
@@ -518,6 +558,7 @@ int dmabounce_register_dev(struct device *dev, unsigned long small_buffer_size,
 #endif
 
 	dev->archdata.dmabounce = device_info;
+	dev->archdata.dma_ops = &dmabounce_dma_ops;
 
 	dev_info(dev, "dmabounce: registered device\n");
 
diff --git a/arch/arm/include/asm/device.h b/arch/arm/include/asm/device.h
index 9f390ce..1983b1a 100644
--- a/arch/arm/include/asm/device.h
+++ b/arch/arm/include/asm/device.h
@@ -6,10 +6,13 @@
 #ifndef ASMARM_DEVICE_H
 #define ASMARM_DEVICE_H
 
+struct dma_map_ops;
+
 struct dev_archdata {
 #ifdef CONFIG_DMABOUNCE
-	struct dmabounce_device_info *dmabounce;
+	struct dmabounce_device_info	*dmabounce;
 #endif
+	struct dma_map_ops		*dma_ops;
 };
 
 struct pdev_archdata {
diff --git a/arch/arm/include/asm/dma-mapping.h b/arch/arm/include/asm/dma-mapping.h
index c568da7..e10f94b 100644
--- a/arch/arm/include/asm/dma-mapping.h
+++ b/arch/arm/include/asm/dma-mapping.h
@@ -3,11 +3,7 @@
 
 #ifdef __KERNEL__
 
-#include <linux/mm_types.h>
-#include <linux/scatterlist.h>
-
 #include <asm-generic/dma-coherent.h>
-#include <asm/memory.h>
 
 /*
  * page_to_dma/dma_to_virt/virt_to_dma are architecture private functions
@@ -56,6 +52,22 @@ static inline dma_addr_t virt_to_dma(struct device *dev, void *addr)
 }
 #endif
 
+extern struct dma_map_ops coherent_dma_ops;
+extern struct dma_map_ops non_coherent_dma_ops;
+
+extern struct dma_map_ops *dma_ops;
+
+/*
+ * Devices may override the dma_ops on a per-device basis. If they haven't
+ * then fallback to the system dma_ops.
+ */
+static inline struct dma_map_ops *get_dma_ops(struct device *dev)
+{
+	return dev->archdata.dma_ops ? dev->archdata.dma_ops : dma_ops;
+}
+
+#include <asm-generic/dma-mapping-common.h>
+
 /*
  * The DMA API is built upon the notion of "buffer ownership".  A buffer
  * is either exclusively owned by the CPU (and therefore may be accessed
@@ -76,8 +88,7 @@ static inline void __dma_single_cpu_to_dev(const void *kaddr, size_t size,
 	extern void ___dma_single_cpu_to_dev(const void *, size_t,
 		enum dma_data_direction);
 
-	if (!arch_is_coherent())
-		___dma_single_cpu_to_dev(kaddr, size, dir);
+	___dma_single_cpu_to_dev(kaddr, size, dir);
 }
 
 static inline void __dma_single_dev_to_cpu(const void *kaddr, size_t size,
@@ -86,8 +97,7 @@ static inline void __dma_single_dev_to_cpu(const void *kaddr, size_t size,
 	extern void ___dma_single_dev_to_cpu(const void *, size_t,
 		enum dma_data_direction);
 
-	if (!arch_is_coherent())
-		___dma_single_dev_to_cpu(kaddr, size, dir);
+	___dma_single_dev_to_cpu(kaddr, size, dir);
 }
 
 static inline void __dma_page_cpu_to_dev(struct page *page, unsigned long off,
@@ -96,8 +106,7 @@ static inline void __dma_page_cpu_to_dev(struct page *page, unsigned long off,
 	extern void ___dma_page_cpu_to_dev(struct page *, unsigned long,
 		size_t, enum dma_data_direction);
 
-	if (!arch_is_coherent())
-		___dma_page_cpu_to_dev(page, off, size, dir);
+	___dma_page_cpu_to_dev(page, off, size, dir);
 }
 
 static inline void __dma_page_dev_to_cpu(struct page *page, unsigned long off,
@@ -106,8 +115,7 @@ static inline void __dma_page_dev_to_cpu(struct page *page, unsigned long off,
 	extern void ___dma_page_dev_to_cpu(struct page *, unsigned long,
 		size_t, enum dma_data_direction);
 
-	if (!arch_is_coherent())
-		___dma_page_dev_to_cpu(page, off, size, dir);
+	___dma_page_dev_to_cpu(page, off, size, dir);
 }
 
 /*
@@ -289,196 +297,7 @@ extern void dmabounce_unregister_dev(struct device *);
  *
  */
 extern int dma_needs_bounce(struct device*, dma_addr_t, size_t);
-
-/*
- * The DMA API, implemented by dmabounce.c.  See below for descriptions.
- */
-extern dma_addr_t dma_map_single(struct device *, void *, size_t,
-		enum dma_data_direction);
-extern void dma_unmap_single(struct device *, dma_addr_t, size_t,
-		enum dma_data_direction);
-extern dma_addr_t dma_map_page(struct device *, struct page *,
-		unsigned long, size_t, enum dma_data_direction);
-extern void dma_unmap_page(struct device *, dma_addr_t, size_t,
-		enum dma_data_direction);
-
-/*
- * Private functions
- */
-int dmabounce_sync_for_cpu(struct device *, dma_addr_t, unsigned long,
-		size_t, enum dma_data_direction);
-int dmabounce_sync_for_device(struct device *, dma_addr_t, unsigned long,
-		size_t, enum dma_data_direction);
-#else
-static inline int dmabounce_sync_for_cpu(struct device *d, dma_addr_t addr,
-	unsigned long offset, size_t size, enum dma_data_direction dir)
-{
-	return 1;
-}
-
-static inline int dmabounce_sync_for_device(struct device *d, dma_addr_t addr,
-	unsigned long offset, size_t size, enum dma_data_direction dir)
-{
-	return 1;
-}
-
-
-/**
- * dma_map_single - map a single buffer for streaming DMA
- * @dev: valid struct device pointer, or NULL for ISA and EISA-like devices
- * @cpu_addr: CPU direct mapped address of buffer
- * @size: size of buffer to map
- * @dir: DMA transfer direction
- *
- * Ensure that any data held in the cache is appropriately discarded
- * or written back.
- *
- * The device owns this memory once this call has completed.  The CPU
- * can regain ownership by calling dma_unmap_single() or
- * dma_sync_single_for_cpu().
- */
-static inline dma_addr_t dma_map_single(struct device *dev, void *cpu_addr,
-		size_t size, enum dma_data_direction dir)
-{
-	BUG_ON(!valid_dma_direction(dir));
-
-	__dma_single_cpu_to_dev(cpu_addr, size, dir);
-
-	return virt_to_dma(dev, cpu_addr);
-}
-
-/**
- * dma_map_page - map a portion of a page for streaming DMA
- * @dev: valid struct device pointer, or NULL for ISA and EISA-like devices
- * @page: page that buffer resides in
- * @offset: offset into page for start of buffer
- * @size: size of buffer to map
- * @dir: DMA transfer direction
- *
- * Ensure that any data held in the cache is appropriately discarded
- * or written back.
- *
- * The device owns this memory once this call has completed.  The CPU
- * can regain ownership by calling dma_unmap_page().
- */
-static inline dma_addr_t dma_map_page(struct device *dev, struct page *page,
-	     unsigned long offset, size_t size, enum dma_data_direction dir)
-{
-	BUG_ON(!valid_dma_direction(dir));
-
-	__dma_page_cpu_to_dev(page, offset, size, dir);
-
-	return page_to_dma(dev, page) + offset;
-}
-
-/**
- * dma_unmap_single - unmap a single buffer previously mapped
- * @dev: valid struct device pointer, or NULL for ISA and EISA-like devices
- * @handle: DMA address of buffer
- * @size: size of buffer (same as passed to dma_map_single)
- * @dir: DMA transfer direction (same as passed to dma_map_single)
- *
- * Unmap a single streaming mode DMA translation.  The handle and size
- * must match what was provided in the previous dma_map_single() call.
- * All other usages are undefined.
- *
- * After this call, reads by the CPU to the buffer are guaranteed to see
- * whatever the device wrote there.
- */
-static inline void dma_unmap_single(struct device *dev, dma_addr_t handle,
-		size_t size, enum dma_data_direction dir)
-{
-	__dma_single_dev_to_cpu(dma_to_virt(dev, handle), size, dir);
-}
-
-/**
- * dma_unmap_page - unmap a buffer previously mapped through dma_map_page()
- * @dev: valid struct device pointer, or NULL for ISA and EISA-like devices
- * @handle: DMA address of buffer
- * @size: size of buffer (same as passed to dma_map_page)
- * @dir: DMA transfer direction (same as passed to dma_map_page)
- *
- * Unmap a page streaming mode DMA translation.  The handle and size
- * must match what was provided in the previous dma_map_page() call.
- * All other usages are undefined.
- *
- * After this call, reads by the CPU to the buffer are guaranteed to see
- * whatever the device wrote there.
- */
-static inline void dma_unmap_page(struct device *dev, dma_addr_t handle,
-		size_t size, enum dma_data_direction dir)
-{
-	__dma_page_dev_to_cpu(dma_to_page(dev, handle), handle & ~PAGE_MASK,
-		size, dir);
-}
 #endif /* CONFIG_DMABOUNCE */
 
-/**
- * dma_sync_single_range_for_cpu
- * @dev: valid struct device pointer, or NULL for ISA and EISA-like devices
- * @handle: DMA address of buffer
- * @offset: offset of region to start sync
- * @size: size of region to sync
- * @dir: DMA transfer direction (same as passed to dma_map_single)
- *
- * Make physical memory consistent for a single streaming mode DMA
- * translation after a transfer.
- *
- * If you perform a dma_map_single() but wish to interrogate the
- * buffer using the cpu, yet do not wish to teardown the PCI dma
- * mapping, you must call this function before doing so.  At the
- * next point you give the PCI dma address back to the card, you
- * must first the perform a dma_sync_for_device, and then the
- * device again owns the buffer.
- */
-static inline void dma_sync_single_range_for_cpu(struct device *dev,
-		dma_addr_t handle, unsigned long offset, size_t size,
-		enum dma_data_direction dir)
-{
-	BUG_ON(!valid_dma_direction(dir));
-
-	if (!dmabounce_sync_for_cpu(dev, handle, offset, size, dir))
-		return;
-
-	__dma_single_dev_to_cpu(dma_to_virt(dev, handle) + offset, size, dir);
-}
-
-static inline void dma_sync_single_range_for_device(struct device *dev,
-		dma_addr_t handle, unsigned long offset, size_t size,
-		enum dma_data_direction dir)
-{
-	BUG_ON(!valid_dma_direction(dir));
-
-	if (!dmabounce_sync_for_device(dev, handle, offset, size, dir))
-		return;
-
-	__dma_single_cpu_to_dev(dma_to_virt(dev, handle) + offset, size, dir);
-}
-
-static inline void dma_sync_single_for_cpu(struct device *dev,
-		dma_addr_t handle, size_t size, enum dma_data_direction dir)
-{
-	dma_sync_single_range_for_cpu(dev, handle, 0, size, dir);
-}
-
-static inline void dma_sync_single_for_device(struct device *dev,
-		dma_addr_t handle, size_t size, enum dma_data_direction dir)
-{
-	dma_sync_single_range_for_device(dev, handle, 0, size, dir);
-}
-
-/*
- * The scatter list versions of the above methods.
- */
-extern int dma_map_sg(struct device *, struct scatterlist *, int,
-		enum dma_data_direction);
-extern void dma_unmap_sg(struct device *, struct scatterlist *, int,
-		enum dma_data_direction);
-extern void dma_sync_sg_for_cpu(struct device *, struct scatterlist *, int,
-		enum dma_data_direction);
-extern void dma_sync_sg_for_device(struct device *, struct scatterlist *, int,
-		enum dma_data_direction);
-
-
 #endif /* __KERNEL__ */
 #endif
diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index a9bdfcd..b90f323 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -326,13 +326,19 @@ __dma_alloc(struct device *dev, size_t size, dma_addr_t *handle, gfp_t gfp,
 }
 
 /*
- * Allocate DMA-coherent memory space and return both the kernel remapped
- * virtual and bus address for that space.
+ * Perform a coherent allocation. If the device has specified an
+ * alloc_coherent method then use that, if not then allocate DMA-coherent
+ * memory space and return both the kernel remapped virtual and bus address
+ * for that space.
  */
 void *
 dma_alloc_coherent(struct device *dev, size_t size, dma_addr_t *handle, gfp_t gfp)
 {
 	void *memory;
+	struct dma_map_ops *dma_ops = get_dma_ops(dev);
+
+	if (dma_ops->alloc_coherent)
+		return dma_ops->alloc_coherent(dev, size, handle, gfp);
 
 	if (dma_alloc_from_coherent(dev, size, handle, &memory))
 		return memory;
@@ -405,8 +411,15 @@ EXPORT_SYMBOL(dma_mmap_writecombine);
  */
 void dma_free_coherent(struct device *dev, size_t size, void *cpu_addr, dma_addr_t handle)
 {
+	struct dma_map_ops *dma_ops = get_dma_ops(dev);
+
 	WARN_ON(irqs_disabled());
 
+	if (dma_ops->free_coherent) {
+		dma_ops->free_coherent(dev, size, cpu_addr, handle);
+		return;
+	}
+
 	if (dma_release_from_coherent(dev, get_order(size), cpu_addr))
 		return;
 
@@ -541,31 +554,73 @@ void ___dma_page_dev_to_cpu(struct page *page, unsigned long off,
 }
 EXPORT_SYMBOL(___dma_page_dev_to_cpu);
 
-/**
- * dma_map_sg - map a set of SG buffers for streaming mode DMA
- * @dev: valid struct device pointer, or NULL for ISA and EISA-like devices
- * @sg: list of buffers
- * @nents: number of buffers to map
- * @dir: DMA transfer direction
- *
- * Map a set of buffers described by scatterlist in streaming mode for DMA.
- * This is the scatter-gather version of the dma_map_single interface.
- * Here the scatter gather list elements are each tagged with the
- * appropriate dma address and length.  They are obtained via
- * sg_dma_{address,length}.
- *
- * Device ownership issues as mentioned for dma_map_single are the same
- * here.
+static dma_addr_t coherent_map_page(struct device *dev, struct page *page,
+				    unsigned long offset, size_t size,
+				    enum dma_data_direction dir,
+				    struct dma_attrs *attrs)
+{
+	return page_to_dma(dev, page) + offset;
+}
+
+int coherent_map_sg(struct device *dev, struct scatterlist *sg, int nents,
+		    enum dma_data_direction dir, struct dma_attrs *attrs)
+{
+	struct scatterlist *s;
+	int i;
+
+	for_each_sg(sg, s, nents, i) {
+		s->dma_address = coherent_map_page(dev, sg_page(s), s->offset,
+						   s->length, dir, attrs);
+		if (dma_mapping_error(dev, s->dma_address))
+			return 0;
+	}
+
+	return nents;
+}
+
+/*
+ * Coherent DMA ops. These can either be used for the whole system
+ * automatically if arch_is_coherent() is true or on a per device basis if the
+ * device is connected to the ACP port to provide coherency for that device.
+ * For individual devices, these DMA ops should be set in
+ * dev->archdata.dma_ops
  */
-int dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
-		enum dma_data_direction dir)
+struct dma_map_ops coherent_dma_ops = {
+	.map_page		= coherent_map_page,
+	.map_sg			= coherent_map_sg,
+};
+EXPORT_SYMBOL(coherent_dma_ops);
+
+static dma_addr_t non_coherent_map_page(struct device *dev, struct page *page,
+					unsigned long offset, size_t size,
+					enum dma_data_direction dir,
+					struct dma_attrs *attrs)
+{
+	BUG_ON(!valid_dma_direction(dir));
+
+	__dma_page_cpu_to_dev(page, offset, size, dir);
+
+	return page_to_dma(dev, page) + offset;
+}
+
+static void non_coherent_unmap_page(struct device *dev, dma_addr_t handle,
+				    size_t size, enum dma_data_direction dir,
+				    struct dma_attrs *attrs)
+{
+	__dma_page_dev_to_cpu(dma_to_page(dev, handle), handle & ~PAGE_MASK,
+			      size, dir);
+}
+
+int non_coherent_map_sg(struct device *dev, struct scatterlist *sg, int nents,
+			enum dma_data_direction dir, struct dma_attrs *attrs)
 {
 	struct scatterlist *s;
 	int i, j;
 
 	for_each_sg(sg, s, nents, i) {
-		s->dma_address = dma_map_page(dev, sg_page(s), s->offset,
-						s->length, dir);
+		s->dma_address = non_coherent_map_page(dev, sg_page(s),
+						       s->offset, s->length,
+						       dir, attrs);
 		if (dma_mapping_error(dev, s->dma_address))
 			goto bad_mapping;
 	}
@@ -573,76 +628,91 @@ int dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
 
  bad_mapping:
 	for_each_sg(sg, s, i, j)
-		dma_unmap_page(dev, sg_dma_address(s), sg_dma_len(s), dir);
+		non_coherent_unmap_page(dev, sg_dma_address(s), sg_dma_len(s),
+					dir, attrs);
 	return 0;
 }
-EXPORT_SYMBOL(dma_map_sg);
-
-/**
- * dma_unmap_sg - unmap a set of SG buffers mapped by dma_map_sg
- * @dev: valid struct device pointer, or NULL for ISA and EISA-like devices
- * @sg: list of buffers
- * @nents: number of buffers to unmap (returned from dma_map_sg)
- * @dir: DMA transfer direction (same as was passed to dma_map_sg)
- *
- * Unmap a set of streaming mode DMA translations.  Again, CPU access
- * rules concerning calls here are the same as for dma_unmap_single().
- */
-void dma_unmap_sg(struct device *dev, struct scatterlist *sg, int nents,
-		enum dma_data_direction dir)
+
+void non_coherent_unmap_sg(struct device *dev, struct scatterlist *sg,
+			   int nents, enum dma_data_direction dir,
+			   struct dma_attrs *attrs)
 {
 	struct scatterlist *s;
 	int i;
 
 	for_each_sg(sg, s, nents, i)
-		dma_unmap_page(dev, sg_dma_address(s), sg_dma_len(s), dir);
+		non_coherent_unmap_page(dev, sg_dma_address(s), sg_dma_len(s),
+					dir, attrs);
 }
-EXPORT_SYMBOL(dma_unmap_sg);
-
-/**
- * dma_sync_sg_for_cpu
- * @dev: valid struct device pointer, or NULL for ISA and EISA-like devices
- * @sg: list of buffers
- * @nents: number of buffers to map (returned from dma_map_sg)
- * @dir: DMA transfer direction (same as was passed to dma_map_sg)
- */
-void dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sg,
-			int nents, enum dma_data_direction dir)
+
+static void
+non_coherent_sync_single_for_cpu(struct device *dev, dma_addr_t handle,
+				 size_t size, enum dma_data_direction dir)
+{
+	BUG_ON(!valid_dma_direction(dir));
+
+	__dma_single_dev_to_cpu(dma_to_virt(dev, handle), size, dir);
+}
+
+static void
+non_coherent_sync_single_for_device(struct device *dev, dma_addr_t handle,
+				    size_t size, enum dma_data_direction dir)
+{
+	BUG_ON(!valid_dma_direction(dir));
+
+	__dma_single_cpu_to_dev(dma_to_virt(dev, handle), size, dir);
+}
+
+void non_coherent_sync_sg_for_cpu(struct device *dev, struct scatterlist *sg,
+				  int nents, enum dma_data_direction dir)
 {
 	struct scatterlist *s;
 	int i;
 
-	for_each_sg(sg, s, nents, i) {
-		if (!dmabounce_sync_for_cpu(dev, sg_dma_address(s), 0,
-					    sg_dma_len(s), dir))
-			continue;
-
-		__dma_page_dev_to_cpu(sg_page(s), s->offset,
-				      s->length, dir);
-	}
+	for_each_sg(sg, s, nents, i)
+		__dma_page_dev_to_cpu(sg_page(s), s->offset, s->length, dir);
 }
-EXPORT_SYMBOL(dma_sync_sg_for_cpu);
-
-/**
- * dma_sync_sg_for_device
- * @dev: valid struct device pointer, or NULL for ISA and EISA-like devices
- * @sg: list of buffers
- * @nents: number of buffers to map (returned from dma_map_sg)
- * @dir: DMA transfer direction (same as was passed to dma_map_sg)
- */
-void dma_sync_sg_for_device(struct device *dev, struct scatterlist *sg,
-			int nents, enum dma_data_direction dir)
+
+void non_coherent_sync_sg_for_device(struct device *dev,
+				     struct scatterlist *sg, int nents,
+				     enum dma_data_direction dir)
 {
 	struct scatterlist *s;
 	int i;
 
-	for_each_sg(sg, s, nents, i) {
-		if (!dmabounce_sync_for_device(dev, sg_dma_address(s), 0,
-					sg_dma_len(s), dir))
-			continue;
+	for_each_sg(sg, s, nents, i)
+		__dma_page_cpu_to_dev(sg_page(s), s->offset, s->length, dir);
+}
 
-		__dma_page_cpu_to_dev(sg_page(s), s->offset,
-				      s->length, dir);
-	}
+/*
+ * Noncoherent DMA ops. This is normal for most ARM systems that aren't fully
+ * coherent. Caches need invalidation and flushing to allow the device/cpu to
+ * see changes.
+ */
+struct dma_map_ops non_coherent_dma_ops = {
+	.map_page		= non_coherent_map_page,
+	.unmap_page		= non_coherent_unmap_page,
+	.map_sg			= non_coherent_map_sg,
+	.unmap_sg		= non_coherent_unmap_sg,
+	.sync_sg_for_cpu	= non_coherent_sync_sg_for_cpu,
+	.sync_sg_for_device	= non_coherent_sync_sg_for_device,
+	.sync_single_for_cpu	= non_coherent_sync_single_for_cpu,
+	.sync_single_for_device	= non_coherent_sync_single_for_device,
+};
+EXPORT_SYMBOL(non_coherent_dma_ops);
+
+#define PREALLOC_DMA_DEBUG_ENTRIES	(1 << 15)
+
+struct dma_map_ops *dma_ops = &non_coherent_dma_ops;
+EXPORT_SYMBOL(dma_ops);
+
+static int __init dma_init(void)
+{
+	if (arch_is_coherent())
+		dma_ops = &coherent_dma_ops;
+
+	dma_debug_init(PREALLOC_DMA_DEBUG_ENTRIES);
+
+	return 0;
 }
-EXPORT_SYMBOL(dma_sync_sg_for_device);
+fs_initcall(dma_init);
-- 
1.7.2.3
