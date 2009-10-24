From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Sat, 24 Oct 2009 23:05:34 +0100
Subject: [RFC 04/11] ARM: Remove __flush_icache_all() from
	__flush_dcache_page()
In-Reply-To: <cover.1256683230.git.rmk+kernel@arm.linux.org.uk>
References: <cover.1256683230.git.rmk+kernel@arm.linux.org.uk>
Message-ID: <e83d8b4d42656ff9c54ff5087a4faedf6895a51c.1256683230.git.rmk+kernel@arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Both call sites for __flush_dcache_page() end up calling
__flush_icache_all() themselves, so having __flush_dcache_page() do
this as well is wasteful.  Remove the duplicated icache flushing.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mm/flush.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mm/flush.c b/arch/arm/mm/flush.c
index 4e2a4e7..19c53dd 100644
--- a/arch/arm/mm/flush.c
+++ b/arch/arm/mm/flush.c
@@ -141,11 +141,9 @@ void __flush_dcache_page(struct address_space *mapping, struct page *page)
 	 * we only need to do one flush - which would be at the relevant
 	 * userspace colour, which is congruent with page->index.
 	 */
-	if (mapping && cache_is_vipt_aliasing()) {
+	if (mapping && cache_is_vipt_aliasing())
 		flush_pfn_alias(page_to_pfn(page),
 				page->index << PAGE_CACHE_SHIFT);
-		__flush_icache_all();
-	}
 }
 
 static void __flush_dcache_aliases(struct address_space *mapping, struct page *page)
-- 
1.6.2.5
