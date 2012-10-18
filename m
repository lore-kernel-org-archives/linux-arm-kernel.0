From: steve.capper@arm.com (Steve Capper)
Date: Thu, 18 Oct 2012 17:15:38 +0100
Subject: [RFC PATCH 2/6] ARM: mm: Add support for flushing HugeTLB pages.
In-Reply-To: <1350576942-25299-1-git-send-email-steve.capper@arm.com>
References: <1350576942-25299-1-git-send-email-steve.capper@arm.com>
Message-ID: <1350576942-25299-3-git-send-email-steve.capper@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On ARM we use the __flush_dcache_page function to flush the dcache of pages
when needed; usually when the PG_dcache_clean bit is unset and we are setting a
PTE.

A HugeTLB page is represented as a compound page consisting of an array of
pages. Thus to flush the dcache of a HugeTLB page, one must flush more than a
single page.

This patch modifies __flush_dcache_page such that all constituent pages of a
HugeTLB page are flushed.

Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Steve Capper <steve.capper@arm.com>
---
 arch/arm/mm/flush.c |   25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mm/flush.c b/arch/arm/mm/flush.c
index 1c8f7f5..0a69cb8 100644
--- a/arch/arm/mm/flush.c
+++ b/arch/arm/mm/flush.c
@@ -17,6 +17,7 @@
 #include <asm/highmem.h>
 #include <asm/smp_plat.h>
 #include <asm/tlbflush.h>
+#include <linux/hugetlb.h>
 
 #include "mm.h"
 
@@ -168,17 +169,21 @@ void __flush_dcache_page(struct address_space *mapping, struct page *page)
 	 * coherent with the kernels mapping.
 	 */
 	if (!PageHighMem(page)) {
-		__cpuc_flush_dcache_area(page_address(page), PAGE_SIZE);
+		__cpuc_flush_dcache_area(page_address(page), (PAGE_SIZE << compound_order(page)));
 	} else {
-		void *addr = kmap_high_get(page);
-		if (addr) {
-			__cpuc_flush_dcache_area(addr, PAGE_SIZE);
-			kunmap_high(page);
-		} else if (cache_is_vipt()) {
-			/* unmapped pages might still be cached */
-			addr = kmap_atomic(page);
-			__cpuc_flush_dcache_area(addr, PAGE_SIZE);
-			kunmap_atomic(addr);
+		unsigned long i;
+		for(i = 0; i < (1 << compound_order(page)); i++) {
+			struct page *cpage = page + i;
+			void *addr = kmap_high_get(cpage);
+			if (addr) {
+				__cpuc_flush_dcache_area(addr, PAGE_SIZE);
+				kunmap_high(cpage);
+			} else if (cache_is_vipt()) {
+				/* unmapped pages might still be cached */
+				addr = kmap_atomic(cpage);
+				__cpuc_flush_dcache_area(addr, PAGE_SIZE);
+				kunmap_atomic(addr);
+			}
 		}
 	}
 
-- 
1.7.9.5
