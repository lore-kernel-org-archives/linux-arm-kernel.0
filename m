From: andy.gross@linaro.org (Andy Gross)
Date: Sat, 20 Aug 2016 01:07:01 -0500
Subject: [PATCH] ARM: cacheflush: Remove unused secure_flush_area API
Message-ID: <1471673221-19181-1-git-send-email-andy.gross@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch removes the unused secure_flush_area function.  The only
consumer of this function has moved to using the streaming DMA APIs.

Signed-off-by: Andy Gross <andy.gross@linaro.org>
---
 arch/arm/include/asm/cacheflush.h | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/arch/arm/include/asm/cacheflush.h b/arch/arm/include/asm/cacheflush.h
index 9156fc3..bdd283b 100644
--- a/arch/arm/include/asm/cacheflush.h
+++ b/arch/arm/include/asm/cacheflush.h
@@ -501,21 +501,4 @@ static inline void set_kernel_text_ro(void) { }
 void flush_uprobe_xol_access(struct page *page, unsigned long uaddr,
 			     void *kaddr, unsigned long len);
 
-/**
- * secure_flush_area - ensure coherency across the secure boundary
- * @addr: virtual address
- * @size: size of region
- *
- * Ensure that the specified area of memory is coherent across the secure
- * boundary from the non-secure side.  This is used when calling secure
- * firmware where the secure firmware does not ensure coherency.
- */
-static inline void secure_flush_area(const void *addr, size_t size)
-{
-	phys_addr_t phys = __pa(addr);
-
-	__cpuc_flush_dcache_area((void *)addr, size);
-	outer_flush_range(phys, phys + size);
-}
-
 #endif
-- 
1.9.1
