From: rabin.vincent@stericsson.com (Rabin Vincent)
Date: Tue, 22 Jun 2010 13:53:01 +0530
Subject: [PATCH] Fix flush_kernel_dcache_page for VIPT non-aliasing caches
Message-ID: <1277194981-21548-1-git-send-email-rabin.vincent@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

flush_kernel_dcache_page() is currently a no-op on CPUs with VIPT
non-aliasing data caches.

Because the data and instruction caches are not coherent, not flushing
the D-cache when PIO is done in the kernel could mean that data stays in
the D-cache and stale data is loaded from memory into the I-cache when
this page is later executed from.

This can be observed, for example, as random crashes in the init process
when a file system is mounted from MMC, if the drivers (or the MMC block
driver bounce buffer) uses flush_kernel_dcache_page() (usually
indirectly via the sg_miter API).

This problem is visible on systems with write-allocate caches.  To fix
it, flush the D-cache in flush_kernel_dcache_page() even on VIPT
non-aliasing caches.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: Linus Walleij <linus.walleij@stericsson.com>
Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
---
 arch/arm/include/asm/cacheflush.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/include/asm/cacheflush.h b/arch/arm/include/asm/cacheflush.h
index 4656a24..ddbee95 100644
--- a/arch/arm/include/asm/cacheflush.h
+++ b/arch/arm/include/asm/cacheflush.h
@@ -406,7 +406,7 @@ static inline void flush_anon_page(struct vm_area_struct *vma,
 static inline void flush_kernel_dcache_page(struct page *page)
 {
 	/* highmem pages are always flushed upon kunmap already */
-	if ((cache_is_vivt() || cache_is_vipt_aliasing()) && !PageHighMem(page))
+	if (!PageHighMem(page))
 		__cpuc_flush_dcache_area(page_address(page), PAGE_SIZE);
 }
 
-- 
1.7.0
