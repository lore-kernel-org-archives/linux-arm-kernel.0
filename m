From: iamjoonsoo.kim@lge.com (Joonsoo Kim)
Date: Tue, 19 Mar 2013 14:01:27 +0900
Subject: [PATCH v2] ARM: mm: clean-up in order to reduce to call
 kmap_high_get()
Message-ID: <1363669287-9049-1-git-send-email-iamjoonsoo.kim@lge.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In kmap_atomic(), kmap_high_get() is invoked for checking already
mapped area. In __flush_dcache_page() and dma_cache_maint_page(),
we explicitly call kmap_high_get() before kmap_atomic()
when cache_is_vipt(), so kmap_high_get() can be invoked twice.
This is useless operation, so remove one.

v2: change cache_is_vipt() to cache_is_vipt_nonaliasing() in order to
be self-documented

Acked-by: Nicolas Pitre <nico@linaro.org>
Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
---
Hello Nicolas.
I maintain your 'Acked-by' while updating this patch to v2.
Please let me know if there is problem.

Thanks.

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index e9db6b4..ef3e0f3 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -823,16 +823,17 @@ static void dma_cache_maint_page(struct page *page, unsigned long offset,
 		if (PageHighMem(page)) {
 			if (len + offset > PAGE_SIZE)
 				len = PAGE_SIZE - offset;
-			vaddr = kmap_high_get(page);
-			if (vaddr) {
-				vaddr += offset;
-				op(vaddr, len, dir);
-				kunmap_high(page);
-			} else if (cache_is_vipt()) {
-				/* unmapped pages might still be cached */
+
+			if (cache_is_vipt_nonaliasing()) {
 				vaddr = kmap_atomic(page);
 				op(vaddr + offset, len, dir);
 				kunmap_atomic(vaddr);
+			} else {
+				vaddr = kmap_high_get(page);
+				if (vaddr) {
+					op(vaddr + offset, len, dir);
+					kunmap_high(page);
+				}
 			}
 		} else {
 			vaddr = page_address(page) + offset;
diff --git a/arch/arm/mm/flush.c b/arch/arm/mm/flush.c
index 1c8f7f5..0d473cc 100644
--- a/arch/arm/mm/flush.c
+++ b/arch/arm/mm/flush.c
@@ -170,15 +170,18 @@ void __flush_dcache_page(struct address_space *mapping, struct page *page)
 	if (!PageHighMem(page)) {
 		__cpuc_flush_dcache_area(page_address(page), PAGE_SIZE);
 	} else {
-		void *addr = kmap_high_get(page);
-		if (addr) {
-			__cpuc_flush_dcache_area(addr, PAGE_SIZE);
-			kunmap_high(page);
-		} else if (cache_is_vipt()) {
-			/* unmapped pages might still be cached */
+		void *addr;
+
+		if (cache_is_vipt_nonaliasing()) {
 			addr = kmap_atomic(page);
 			__cpuc_flush_dcache_area(addr, PAGE_SIZE);
 			kunmap_atomic(addr);
+		} else {
+			addr = kmap_high_get(page);
+			if (addr) {
+				__cpuc_flush_dcache_area(addr, PAGE_SIZE);
+				kunmap_high(page);
+			}
 		}
 	}
 
-- 
1.7.9.5
