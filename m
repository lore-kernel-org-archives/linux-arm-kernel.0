From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 28 Nov 2016 12:15:53 +0000
Subject: [PATCH] arm64: Remove I-cache invalidation from flush_cache_range()
Message-ID: <1480335353-4030-1-git-send-email-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The flush_cache_range() function (similarly for flush_cache_page()) is
called when the kernel is changing an existing VA->PA mapping range to
either a new PA or to different attributes. Since ARMv8 has PIPT-like
D-caches, this function does not need to perform any D-cache
maintenance. The I-cache maintenance is already handled via set_pte_at()
and flush_cache_range() cannot anyway guarantee that there are no cache
lines left after invalidation due to the speculative loads.

This patch makes flush_cache_range() a no-op.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---

Cc'ing Russell as well, I think we can remove the __flush_icache_all()
call in arch/arm for the VIPT (both aliasing and non-aliasing) caches
since we already handle the I-cache in __sync_icache_dcache(). Any
opinion?

 arch/arm64/include/asm/cacheflush.h | 6 +++++-
 arch/arm64/mm/flush.c               | 7 -------
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/include/asm/cacheflush.h b/arch/arm64/include/asm/cacheflush.h
index e9f64ecb75ce..5a2a6ee65f65 100644
--- a/arch/arm64/include/asm/cacheflush.h
+++ b/arch/arm64/include/asm/cacheflush.h
@@ -65,7 +65,6 @@
  *		- kaddr  - page address
  *		- size   - region size
  */
-extern void flush_cache_range(struct vm_area_struct *vma, unsigned long start, unsigned long end);
 extern void flush_icache_range(unsigned long start, unsigned long end);
 extern void __flush_dcache_area(void *addr, size_t len);
 extern void __clean_dcache_area_poc(void *addr, size_t len);
@@ -82,6 +81,11 @@ static inline void flush_cache_page(struct vm_area_struct *vma,
 {
 }
 
+static inline void flush_cache_range(struct vm_area_struct *vma,
+				     unsigned long start, unsigned long end)
+{
+}
+
 /*
  * Cache maintenance functions used by the DMA API. No to be used directly.
  */
diff --git a/arch/arm64/mm/flush.c b/arch/arm64/mm/flush.c
index 2d78d5a9b89f..554a2558c12e 100644
--- a/arch/arm64/mm/flush.c
+++ b/arch/arm64/mm/flush.c
@@ -25,13 +25,6 @@
 #include <asm/cachetype.h>
 #include <asm/tlbflush.h>
 
-void flush_cache_range(struct vm_area_struct *vma, unsigned long start,
-		       unsigned long end)
-{
-	if (vma->vm_flags & VM_EXEC)
-		__flush_icache_all();
-}
-
 void sync_icache_aliases(void *kaddr, unsigned long len)
 {
 	unsigned long addr = (unsigned long)kaddr;
