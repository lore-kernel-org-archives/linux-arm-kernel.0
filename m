From: steve.capper@linaro.org (Steve Capper)
Date: Wed,  2 Jul 2014 11:46:23 +0100
Subject: [PATCH] arm64: mm: Make icache synchronisation logic huge page aware
Message-ID: <1404297983-30840-1-git-send-email-steve.capper@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The __sync_icache_dcache routine will only flush the dcache for the
first page of a compound page, potentially leading to stale icache
data residing further on in a hugetlb page.

This patch addresses this issue by taking into consideration the
order of the page when flushing the dcache.

Reported-by: Mark Brown <broonie@linaro.org>
Tested-by: Mark Brown <broonie@linaro.org>
Signed-off-by: Steve Capper <steve.capper@linaro.org>
---
 arch/arm64/mm/flush.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/mm/flush.c b/arch/arm64/mm/flush.c
index e4193e3..0d64089 100644
--- a/arch/arm64/mm/flush.c
+++ b/arch/arm64/mm/flush.c
@@ -79,7 +79,8 @@ void __sync_icache_dcache(pte_t pte, unsigned long addr)
 		return;
 
 	if (!test_and_set_bit(PG_dcache_clean, &page->flags)) {
-		__flush_dcache_area(page_address(page), PAGE_SIZE);
+		__flush_dcache_area(page_address(page),
+				PAGE_SIZE << compound_order(page));
 		__flush_icache_all();
 	} else if (icache_is_aivivt()) {
 		__flush_icache_all();
-- 
1.9.3
