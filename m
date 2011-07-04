From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 04 Jul 2011 09:48:16 +0100
Subject: [PATCH 02/10] ARM: dma-mapping: define dma_(un)?map_single in terms
	of dma_(un)?map_page
In-Reply-To: <20110704084711.GN21898@n2100.arm.linux.org.uk>
References: <20110704084711.GN21898@n2100.arm.linux.org.uk>
Message-ID: <E1QdepE-0000Z8-Ae@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use dma_map_page()/dma_unmap_page() internals to handle dma_map_single()
and dma_unmap_single().

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/common/dmabounce.c        |   28 ----------------------------
 arch/arm/include/asm/dma-mapping.h |   31 +++++++++----------------------
 2 files changed, 9 insertions(+), 50 deletions(-)

diff --git a/arch/arm/common/dmabounce.c b/arch/arm/common/dmabounce.c
index 841df7d..8a0588b 100644
--- a/arch/arm/common/dmabounce.c
+++ b/arch/arm/common/dmabounce.c
@@ -328,34 +328,6 @@ static inline void unmap_single(struct device *dev, dma_addr_t dma_addr,
  * substitute the safe buffer for the unsafe one.
  * (basically move the buffer from an unsafe area to a safe one)
  */
-dma_addr_t __dma_map_single(struct device *dev, void *ptr, size_t size,
-		enum dma_data_direction dir)
-{
-	dev_dbg(dev, "%s(ptr=%p,size=%d,dir=%x)\n",
-		__func__, ptr, size, dir);
-
-	BUG_ON(!valid_dma_direction(dir));
-
-	return map_single(dev, ptr, size, dir);
-}
-EXPORT_SYMBOL(__dma_map_single);
-
-/*
- * see if a mapped address was really a "safe" buffer and if so, copy
- * the data from the safe buffer back to the unsafe buffer and free up
- * the safe buffer.  (basically return things back to the way they
- * should be)
- */
-void __dma_unmap_single(struct device *dev, dma_addr_t dma_addr, size_t size,
-		enum dma_data_direction dir)
-{
-	dev_dbg(dev, "%s(ptr=%p,size=%d,dir=%x)\n",
-		__func__, (void *) dma_addr, size, dir);
-
-	unmap_single(dev, dma_addr, size, dir);
-}
-EXPORT_SYMBOL(__dma_unmap_single);
-
 dma_addr_t __dma_map_page(struct device *dev, struct page *page,
 		unsigned long offset, size_t size, enum dma_data_direction dir)
 {
diff --git a/arch/arm/include/asm/dma-mapping.h b/arch/arm/include/asm/dma-mapping.h
index 4fff837..d2903d0 100644
--- a/arch/arm/include/asm/dma-mapping.h
+++ b/arch/arm/include/asm/dma-mapping.h
@@ -298,10 +298,6 @@ extern int dma_needs_bounce(struct device*, dma_addr_t, size_t);
 /*
  * The DMA API, implemented by dmabounce.c.  See below for descriptions.
  */
-extern dma_addr_t __dma_map_single(struct device *, void *, size_t,
-		enum dma_data_direction);
-extern void __dma_unmap_single(struct device *, dma_addr_t, size_t,
-		enum dma_data_direction);
 extern dma_addr_t __dma_map_page(struct device *, struct page *,
 		unsigned long, size_t, enum dma_data_direction);
 extern void __dma_unmap_page(struct device *, dma_addr_t, size_t,
@@ -328,13 +324,6 @@ static inline int dmabounce_sync_for_device(struct device *d, dma_addr_t addr,
 }
 
 
-static inline dma_addr_t __dma_map_single(struct device *dev, void *cpu_addr,
-		size_t size, enum dma_data_direction dir)
-{
-	__dma_single_cpu_to_dev(cpu_addr, size, dir);
-	return virt_to_dma(dev, cpu_addr);
-}
-
 static inline dma_addr_t __dma_map_page(struct device *dev, struct page *page,
 	     unsigned long offset, size_t size, enum dma_data_direction dir)
 {
@@ -342,12 +331,6 @@ static inline dma_addr_t __dma_map_page(struct device *dev, struct page *page,
 	return pfn_to_dma(dev, page_to_pfn(page)) + offset;
 }
 
-static inline void __dma_unmap_single(struct device *dev, dma_addr_t handle,
-		size_t size, enum dma_data_direction dir)
-{
-	__dma_single_dev_to_cpu(dma_to_virt(dev, handle), size, dir);
-}
-
 static inline void __dma_unmap_page(struct device *dev, dma_addr_t handle,
 		size_t size, enum dma_data_direction dir)
 {
@@ -373,14 +356,18 @@ static inline void __dma_unmap_page(struct device *dev, dma_addr_t handle,
 static inline dma_addr_t dma_map_single(struct device *dev, void *cpu_addr,
 		size_t size, enum dma_data_direction dir)
 {
+	unsigned long offset;
+	struct page *page;
 	dma_addr_t addr;
 
+	BUG_ON(!virt_addr_valid(cpu_addr));
+	BUG_ON(!virt_addr_valid(cpu_addr + size - 1));
 	BUG_ON(!valid_dma_direction(dir));
 
-	addr = __dma_map_single(dev, cpu_addr, size, dir);
-	debug_dma_map_page(dev, virt_to_page(cpu_addr),
-			(unsigned long)cpu_addr & ~PAGE_MASK, size,
-			dir, addr, true);
+	page = virt_to_page(cpu_addr);
+	offset = (unsigned long)cpu_addr & ~PAGE_MASK;
+	addr = __dma_map_page(dev, page, offset, size, dir);
+	debug_dma_map_page(dev, page, offset, size, dir, addr, true);
 
 	return addr;
 }
@@ -430,7 +417,7 @@ static inline void dma_unmap_single(struct device *dev, dma_addr_t handle,
 		size_t size, enum dma_data_direction dir)
 {
 	debug_dma_unmap_page(dev, handle, size, dir, true);
-	__dma_unmap_single(dev, handle, size, dir);
+	__dma_unmap_page(dev, handle, size, dir);
 }
 
 /**
-- 
1.7.4.4
