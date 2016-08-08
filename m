From: labbott@redhat.com (Laura Abbott)
Date: Mon,  8 Aug 2016 10:49:35 -0700
Subject: [RFCv2][PATCH 3/5] arm64: Implement ARCH_HAS_FORCE_CACHE
In-Reply-To: <1470678577-14010-1-git-send-email-labbott@redhat.com>
References: <1470678577-14010-1-git-send-email-labbott@redhat.com>
Message-ID: <1470678577-14010-4-git-send-email-labbott@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arm64 may need to guarantee the caches are synced. Implement versions of
the kernel_force_cache API based on the DMA APIs.

Signed-off-by: Laura Abbott <labbott@redhat.com>
---
 arch/arm64/include/asm/cacheflush.h |  5 +++++
 arch/arm64/mm/flush.c               | 11 +++++++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/arm64/include/asm/cacheflush.h b/arch/arm64/include/asm/cacheflush.h
index c64268d..9980dd8 100644
--- a/arch/arm64/include/asm/cacheflush.h
+++ b/arch/arm64/include/asm/cacheflush.h
@@ -149,4 +149,9 @@ int set_memory_rw(unsigned long addr, int numpages);
 int set_memory_x(unsigned long addr, int numpages);
 int set_memory_nx(unsigned long addr, int numpages);
 
+#define ARCH_HAS_FORCE_CACHE 1
+
+void kernel_force_cache_clean(struct page *page, size_t size);
+void kernel_force_cache_invalidate(struct page *page, size_t size);
+
 #endif
diff --git a/arch/arm64/mm/flush.c b/arch/arm64/mm/flush.c
index 43a76b0..0af78ab 100644
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
+	__dma_map_area(page_address(page), size, DMA_BIDIRECTIONAL);
+}
+
+void kernel_force_cache_invalidate(struct page *page, size_t size)
+{
+	__dma_unmap_area(page_address(page), size, DMA_BIDIRECTIONAL);
+}
-- 
2.7.4
