From: steve.capper@linaro.org (Steve Capper)
Date: Thu, 23 May 2013 16:31:18 +0100
Subject: [PATCH v2 2/4] ARM: mm: Add support for flushing HugeTLB pages.
In-Reply-To: <1369323080-9673-1-git-send-email-steve.capper@linaro.org>
References: <1369323080-9673-1-git-send-email-steve.capper@linaro.org>
Message-ID: <1369323080-9673-3-git-send-email-steve.capper@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On ARM we use the __flush_dcache_page function to flush the dcache
of pages when needed; usually when the PG_dcache_clean bit is unset
and we are setting a PTE.

A HugeTLB page is represented as a compound page consisting of an
array of pages. Thus to flush the dcache of a HugeTLB page, one must
flush more than a single page.

This patch modifies __flush_dcache_page such that all constituent
pages of a HugeTLB page are flushed.

Signed-off-by: Steve Capper <steve.capper@linaro.org>
Reviewed-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mm/flush.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mm/flush.c b/arch/arm/mm/flush.c
index 0d473cc..3706407 100644
--- a/arch/arm/mm/flush.c
+++ b/arch/arm/mm/flush.c
@@ -17,6 +17,7 @@
 #include <asm/highmem.h>
 #include <asm/smp_plat.h>
 #include <asm/tlbflush.h>
+#include <linux/hugetlb.h>
 
 #include "mm.h"
 
@@ -168,19 +169,23 @@ void __flush_dcache_page(struct address_space *mapping, struct page *page)
 	 * coherent with the kernels mapping.
 	 */
 	if (!PageHighMem(page)) {
-		__cpuc_flush_dcache_area(page_address(page), PAGE_SIZE);
+		size_t page_size = PAGE_SIZE << compound_order(page);
+		__cpuc_flush_dcache_area(page_address(page), page_size);
 	} else {
-		void *addr;
-
+		unsigned long i;
 		if (cache_is_vipt_nonaliasing()) {
-			addr = kmap_atomic(page);
-			__cpuc_flush_dcache_area(addr, PAGE_SIZE);
-			kunmap_atomic(addr);
-		} else {
-			addr = kmap_high_get(page);
-			if (addr) {
+			for (i = 0; i < (1 << compound_order(page)); i++) {
+				void *addr = kmap_atomic(page);
 				__cpuc_flush_dcache_area(addr, PAGE_SIZE);
-				kunmap_high(page);
+				kunmap_atomic(addr);
+			}
+		} else {
+			for (i = 0; i < (1 << compound_order(page)); i++) {
+				void *addr = kmap_high_get(page);
+				if (addr) {
+					__cpuc_flush_dcache_area(addr, PAGE_SIZE);
+					kunmap_high(page);
+				}
 			}
 		}
 	}
-- 
1.8.1.4
