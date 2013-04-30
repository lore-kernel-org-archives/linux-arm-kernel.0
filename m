From: steve.capper@linaro.org (Steve Capper)
Date: Tue, 30 Apr 2013 17:30:44 +0100
Subject: [RFC PATCH 5/9] ARM64: mm: Add support for flushing huge pages.
In-Reply-To: <1367339448-21727-1-git-send-email-steve.capper@linaro.org>
References: <1367339448-21727-1-git-send-email-steve.capper@linaro.org>
Message-ID: <1367339448-21727-6-git-send-email-steve.capper@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The code to flush the dcache of a dirty page, __flush_dcache_page,
will only flush the head of a HugeTLB/THP page.

This patch adjusts __flush_dcache_page such that the order of the
compound page is used to determine the size of area to flush.

Signed-off-by: Steve Capper <steve.capper@linaro.org>
---
 arch/arm64/mm/flush.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/mm/flush.c b/arch/arm64/mm/flush.c
index 88611c3..71c182d 100644
--- a/arch/arm64/mm/flush.c
+++ b/arch/arm64/mm/flush.c
@@ -72,7 +72,8 @@ void copy_to_user_page(struct vm_area_struct *vma, struct page *page,
 
 void __flush_dcache_page(struct page *page)
 {
-	__flush_dcache_area(page_address(page), PAGE_SIZE);
+	size_t page_size = PAGE_SIZE << compound_order(page);
+	__flush_dcache_area(page_address(page), page_size);
 }
 
 void __sync_icache_dcache(pte_t pte, unsigned long addr)
-- 
1.8.1.4
