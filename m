From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Tue, 21 Jun 2016 15:32:57 +0800
Subject: [PATCH v2] arm64: mm: remove page_mapping check in
 __sync_icache_dcache
Message-ID: <1466494377-33358-1-git-send-email-wangkefeng.wang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shaokun Zhang <zhangshaokun@hisilicon.com>

In aarch64 sync icache and dcache, if anonymous pages hold self-modified
code and these pages are migrated, it also should be flushed dcache and
invalided icache.

Therefore, page_mapping(page) check should be removed, otherwise icache
maybe fetch stale instruction from PoU.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: stable at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
---

Change from v1:
- update changelog suggested by Catalin.
- add stable maillist 

 arch/arm64/mm/flush.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm64/mm/flush.c b/arch/arm64/mm/flush.c
index dbd12ea..43a76b0 100644
--- a/arch/arm64/mm/flush.c
+++ b/arch/arm64/mm/flush.c
@@ -71,10 +71,6 @@ void __sync_icache_dcache(pte_t pte, unsigned long addr)
 {
 	struct page *page = pte_page(pte);
 
-	/* no flushing needed for anonymous pages */
-	if (!page_mapping(page))
-		return;
-
 	if (!test_and_set_bit(PG_dcache_clean, &page->flags))
 		sync_icache_aliases(page_address(page),
 				    PAGE_SIZE << compound_order(page));
-- 
1.7.12.4
