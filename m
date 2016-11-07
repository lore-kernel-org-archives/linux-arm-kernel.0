From: rabin.vincent@axis.com (Rabin Vincent)
Date: Mon,  7 Nov 2016 11:30:24 +0100
Subject: [PATCH] ARM: avoid cache flushing in flush_dcache_page()
Message-ID: <1478514624-30910-1-git-send-email-rabin.vincent@axis.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rabin Vincent <rabinv@axis.com>

When the data cache is PIPT or VIPT non-aliasing, and cache operations
are broadcast by the hardware, we can always postpone the flush in
flush_dcache_page().  A similar change was done for ARM64 in commit
b5b6c9e9149d ("arm64: Avoid cache flushing in flush_dcache_page()").

Signed-off-by: Rabin Vincent <rabinv@axis.com>
---
 arch/arm/mm/flush.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/mm/flush.c b/arch/arm/mm/flush.c
index 3cced84..f1e6190 100644
--- a/arch/arm/mm/flush.c
+++ b/arch/arm/mm/flush.c
@@ -327,6 +327,12 @@ void flush_dcache_page(struct page *page)
 	if (page == ZERO_PAGE(0))
 		return;
 
+	if (!cache_ops_need_broadcast() && cache_is_vipt_nonaliasing()) {
+		if (test_bit(PG_dcache_clean, &page->flags))
+			clear_bit(PG_dcache_clean, &page->flags);
+		return;
+	}
+
 	mapping = page_mapping(page);
 
 	if (!cache_ops_need_broadcast() &&
-- 
2.1.4
