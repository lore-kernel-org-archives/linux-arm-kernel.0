From: steve.capper@linaro.org (Steve Capper)
Date: Fri, 13 Dec 2013 12:06:30 +0000
Subject: [PATCH 1/2] arm: mm: fix dcache flush logic for compound high pages
In-Reply-To: <1386936391-30493-1-git-send-email-steve.capper@linaro.org>
References: <1386936391-30493-1-git-send-email-steve.capper@linaro.org>
Message-ID: <1386936391-30493-2-git-send-email-steve.capper@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When given a compound high page, __flush_dcache_page will only flush
the first page of the compound page repeatedly rather than the entire
set of constituent pages.

This patch corrects the logic such that all constituent pages are now
flushed.

Signed-off-by: Steve Capper <steve.capper@linaro.org>
---
 arch/arm/mm/flush.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mm/flush.c b/arch/arm/mm/flush.c
index 6d5ba9a..4962302 100644
--- a/arch/arm/mm/flush.c
+++ b/arch/arm/mm/flush.c
@@ -173,18 +173,19 @@ void __flush_dcache_page(struct address_space *mapping, struct page *page)
 		__cpuc_flush_dcache_area(page_address(page), page_size);
 	} else {
 		unsigned long i;
+		struct page *cpage = page;
 		if (cache_is_vipt_nonaliasing()) {
-			for (i = 0; i < (1 << compound_order(page)); i++) {
-				void *addr = kmap_atomic(page);
+			for (i = 0; i < (1 << compound_order(page)); cpage++, i++) {
+				void *addr = kmap_atomic(cpage);
 				__cpuc_flush_dcache_area(addr, PAGE_SIZE);
 				kunmap_atomic(addr);
 			}
 		} else {
-			for (i = 0; i < (1 << compound_order(page)); i++) {
-				void *addr = kmap_high_get(page);
+			for (i = 0; i < (1 << compound_order(page)); cpage++, i++) {
+				void *addr = kmap_high_get(cpage);
 				if (addr) {
 					__cpuc_flush_dcache_area(addr, PAGE_SIZE);
-					kunmap_high(page);
+					kunmap_high(cpage);
 				}
 			}
 		}
-- 
1.8.1.4
