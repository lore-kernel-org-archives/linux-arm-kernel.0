From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 20 Nov 2009 18:04:00 +0000
Subject: [PATCH 4/7] ARM: dma-mapping: split dma_unmap_page() from
	dma_unmap_single()
In-Reply-To: <20091120182539.GG16920@n2100.arm.linux.org.uk>
References: <20091120182539.GG16920@n2100.arm.linux.org.uk>
Message-ID: <E1NBYE8-0005l1-GI@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We will need to treat dma_unmap_page() differently from dma_unmap_single()

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/common/dmabounce.c        |   21 ++++++++++++++++++---
 arch/arm/include/asm/dma-mapping.h |    8 +++++---
 2 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/arch/arm/common/dmabounce.c b/arch/arm/common/dmabounce.c
index 734ac91..5a375e5 100644
--- a/arch/arm/common/dmabounce.c
+++ b/arch/arm/common/dmabounce.c
@@ -342,6 +342,22 @@ dma_addr_t dma_map_single(struct device *dev, void *ptr, size_t size,
 }
 EXPORT_SYMBOL(dma_map_single);
 
+/*
+ * see if a mapped address was really a "safe" buffer and if so, copy
+ * the data from the safe buffer back to the unsafe buffer and free up
+ * the safe buffer.  (basically return things back to the way they
+ * should be)
+ */
+void dma_unmap_single(struct device *dev, dma_addr_t dma_addr, size_t size,
+		enum dma_data_direction dir)
+{
+	dev_dbg(dev, "%s(ptr=%p,size=%d,dir=%x)\n",
+		__func__, (void *) dma_addr, size, dir);
+
+	unmap_single(dev, dma_addr, size, dir);
+}
+EXPORT_SYMBOL(dma_unmap_single);
+
 dma_addr_t dma_map_page(struct device *dev, struct page *page,
 		unsigned long offset, size_t size, enum dma_data_direction dir)
 {
@@ -366,8 +382,7 @@ EXPORT_SYMBOL(dma_map_page);
  * the safe buffer.  (basically return things back to the way they
  * should be)
  */
-
-void dma_unmap_single(struct device *dev, dma_addr_t dma_addr, size_t size,
+void dma_unmap_page(struct device *dev, dma_addr_t dma_addr, size_t size,
 		enum dma_data_direction dir)
 {
 	dev_dbg(dev, "%s(ptr=%p,size=%d,dir=%x)\n",
@@ -375,7 +390,7 @@ void dma_unmap_single(struct device *dev, dma_addr_t dma_addr, size_t size,
 
 	unmap_single(dev, dma_addr, size, dir);
 }
-EXPORT_SYMBOL(dma_unmap_single);
+EXPORT_SYMBOL(dma_unmap_page);
 
 int dmabounce_sync_for_cpu(struct device *dev, dma_addr_t addr,
 		unsigned long off, size_t sz, enum dma_data_direction dir)
diff --git a/arch/arm/include/asm/dma-mapping.h b/arch/arm/include/asm/dma-mapping.h
index f06d80c..a96300b 100644
--- a/arch/arm/include/asm/dma-mapping.h
+++ b/arch/arm/include/asm/dma-mapping.h
@@ -257,9 +257,11 @@ extern int dma_needs_bounce(struct device*, dma_addr_t, size_t);
  */
 extern dma_addr_t dma_map_single(struct device *, void *, size_t,
 		enum dma_data_direction);
+extern void dma_unmap_single(struct device *, dma_addr_t, size_t,
+		enum dma_data_direction);
 extern dma_addr_t dma_map_page(struct device *, struct page *,
 		unsigned long, size_t, enum dma_data_direction);
-extern void dma_unmap_single(struct device *, dma_addr_t, size_t,
+extern void dma_unmap_page(struct device *, dma_addr_t, size_t,
 		enum dma_data_direction);
 
 /*
@@ -352,7 +354,6 @@ static inline void dma_unmap_single(struct device *dev, dma_addr_t handle,
 {
 	/* nothing to do */
 }
-#endif /* CONFIG_DMABOUNCE */
 
 /**
  * dma_unmap_page - unmap a buffer previously mapped through dma_map_page()
@@ -371,8 +372,9 @@ static inline void dma_unmap_single(struct device *dev, dma_addr_t handle,
 static inline void dma_unmap_page(struct device *dev, dma_addr_t handle,
 		size_t size, enum dma_data_direction dir)
 {
-	dma_unmap_single(dev, handle, size, dir);
+	/* nothing to do */
 }
+#endif /* CONFIG_DMABOUNCE */
 
 /**
  * dma_sync_single_range_for_cpu
-- 
1.6.2.5
