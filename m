From: steve.capper@linaro.org (Steve Capper)
Date: Mon, 16 Dec 2013 15:03:43 +0000
Subject: [PATCH V2] arm: mm: fix dcache flush logic for compound high pages
Message-ID: <1387206223-1670-1-git-send-email-steve.capper@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When given a compound high page, __flush_dcache_page will only flush
the first page of the compound page repeatedly rather than the entire
set of constituent pages.

This patch corrects the logic such that all constituent pages are now
flushed.

Signed-off-by: Steve Capper <steve.capper@linaro.org>
---
V2: style change use page + i rather than separate struct *cpage
---
 arch/arm/mm/flush.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mm/flush.c b/arch/arm/mm/flush.c
index 6d5ba9a..3387e60 100644
--- a/arch/arm/mm/flush.c
+++ b/arch/arm/mm/flush.c
@@ -175,16 +175,16 @@ void __flush_dcache_page(struct address_space *mapping, struct page *page)
 		unsigned long i;
 		if (cache_is_vipt_nonaliasing()) {
 			for (i = 0; i < (1 << compound_order(page)); i++) {
-				void *addr = kmap_atomic(page);
+				void *addr = kmap_atomic(page + i);
 				__cpuc_flush_dcache_area(addr, PAGE_SIZE);
 				kunmap_atomic(addr);
 			}
 		} else {
 			for (i = 0; i < (1 << compound_order(page)); i++) {
-				void *addr = kmap_high_get(page);
+				void *addr = kmap_high_get(page + i);
 				if (addr) {
 					__cpuc_flush_dcache_area(addr, PAGE_SIZE);
-					kunmap_high(page);
+					kunmap_high(page + i);
 				}
 			}
 		}
-- 
1.8.1.4
