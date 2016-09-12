From: labbott@redhat.com (Laura Abbott)
Date: Mon, 12 Sep 2016 14:32:56 -0700
Subject: [RFCv3][PATCH 3/5] arm64: Implement ARCH_HAS_FORCE_CACHE
In-Reply-To: <1473715978-11633-1-git-send-email-labbott@redhat.com>
References: <1473715978-11633-1-git-send-email-labbott@redhat.com>
Message-ID: <1473715978-11633-4-git-send-email-labbott@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


arm64 may need to guarantee the caches are synced. Implement versions of
the kernel_force_cache API to allow this.

Signed-off-by: Laura Abbott <labbott@redhat.com>
---
v3: Switch to calling cache operations directly instead of relying on
DMA mapping.
---
 arch/arm64/include/asm/cacheflush.h |  8 ++++++++
 arch/arm64/mm/cache.S               | 24 ++++++++++++++++++++----
 arch/arm64/mm/flush.c               | 11 +++++++++++
 3 files changed, 39 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/cacheflush.h b/arch/arm64/include/asm/cacheflush.h
index c64268d..1134c15 100644
--- a/arch/arm64/include/asm/cacheflush.h
+++ b/arch/arm64/include/asm/cacheflush.h
@@ -87,6 +87,9 @@ extern void __dma_map_area(const void *, size_t, int);
 extern void __dma_unmap_area(const void *, size_t, int);
 extern void __dma_flush_range(const void *, const void *);
 
+extern void __force_dcache_clean(const void *, size_t);
+extern void __force_dcache_invalidate(const void *, size_t);
+
 /*
  * Copy user data from/to a page which is mapped into a different
  * processes address space.  Really, we want to allow our "user
@@ -149,4 +152,9 @@ int set_memory_rw(unsigned long addr, int numpages);
 int set_memory_x(unsigned long addr, int numpages);
 int set_memory_nx(unsigned long addr, int numpages);
 
+#define ARCH_HAS_FORCE_CACHE 1
+
+void kernel_force_cache_clean(struct page *page, size_t size);
+void kernel_force_cache_invalidate(struct page *page, size_t size);
+
 #endif
diff --git a/arch/arm64/mm/cache.S b/arch/arm64/mm/cache.S
index 07d7352..e99c9a4 100644
--- a/arch/arm64/mm/cache.S
+++ b/arch/arm64/mm/cache.S
@@ -184,10 +184,6 @@ ENDPIPROC(__dma_flush_range)
  *	- dir	- DMA direction
  */
 ENTRY(__dma_map_area)
-	add	x1, x1, x0
-	cmp	w2, #DMA_FROM_DEVICE
-	b.eq	__dma_inv_range
-	b	__dma_clean_range
 ENDPIPROC(__dma_map_area)
 
 /*
@@ -202,3 +198,23 @@ ENTRY(__dma_unmap_area)
 	b.ne	__dma_inv_range
 	ret
 ENDPIPROC(__dma_unmap_area)
+
+/*
+ *	__force_dcache_clean(start, size)
+ *	- start	- kernel virtual start address
+ *	- size	- size of region
+ */
+ENTRY(__force_dcache_clean)
+	add	x1, x1, x0
+	b	__dma_clean_range
+ENDPROC(__force_dcache_clean)
+
+/*
+ *	__force_dcache_invalidate(start, size)
+ *	- start	- kernel virtual start address
+ *	- size	- size of region
+ */
+ENTRY(__force_dcache_invalidate)
+	add	x1, x1, x0
+	b	__dma_inv_range
+ENDPROC(__force_dcache_invalidate)
diff --git a/arch/arm64/mm/flush.c b/arch/arm64/mm/flush.c
index 43a76b0..54ff32e 100644
--- a/arch/arm64/mm/flush.c
+++ b/arch/arm64/mm/flush.c
@@ -20,6 +20,7 @@
 #include <linux/export.h>
 #include <linux/mm.h>
 #include <linux/pagemap.h>
+#include <linux/dma-mapping.h>
 
 #include <asm/cacheflush.h>
 #include <asm/cachetype.h>
@@ -94,3 +95,13 @@ EXPORT_SYMBOL(flush_dcache_page);
  * Additional functions defined in assembly.
  */
 EXPORT_SYMBOL(flush_icache_range);
+
+void kernel_force_cache_clean(struct page *page, size_t size)
+{
+	__force_dcache_clean(page_address(page), size);
+}
+
+void kernel_force_cache_invalidate(struct page *page, size_t size)
+{
+	__force_dcache_invalidate(page_address(page), size);
+}
-- 
2.7.4
