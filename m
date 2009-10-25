From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Sun, 25 Oct 2009 10:23:04 +0000
Subject: [RFC 05/11] ARM: Avoid flush_dcache_page() for zero page
In-Reply-To: <cover.1256683230.git.rmk+kernel@arm.linux.org.uk>
References: <cover.1256683230.git.rmk+kernel@arm.linux.org.uk>
Message-ID: <9f29e68031fd5eb01882e7549ab26267a0a173ba.1256683230.git.rmk+kernel@arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The zero page is read-only, and has its cache state cleared during
boot.  No further maintanence for this page is required.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mm/fault-armv.c |    7 +++++++
 arch/arm/mm/flush.c      |   11 ++++++++++-
 arch/arm/mm/mmu.c        |    2 +-
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mm/fault-armv.c b/arch/arm/mm/fault-armv.c
index 830cf17..7296022 100644
--- a/arch/arm/mm/fault-armv.c
+++ b/arch/arm/mm/fault-armv.c
@@ -153,7 +153,14 @@ void update_mmu_cache(struct vm_area_struct *vma, unsigned long addr, pte_t pte)
 	if (!pfn_valid(pfn))
 		return;
 
+	/*
+	 * The zero page is never written to, so never has any dirty
+	 * cache lines, and therefore never needs to be flushed.
+	 */
 	page = pfn_to_page(pfn);
+	if (page == ZERO_PAGE(0))
+		return;
+
 	mapping = page_mapping(page);
 #ifndef CONFIG_SMP
 	if (test_and_clear_bit(PG_dcache_dirty, &page->flags))
diff --git a/arch/arm/mm/flush.c b/arch/arm/mm/flush.c
index 19c53dd..82dd2c5 100644
--- a/arch/arm/mm/flush.c
+++ b/arch/arm/mm/flush.c
@@ -198,7 +198,16 @@ static void __flush_dcache_aliases(struct address_space *mapping, struct page *p
  */
 void flush_dcache_page(struct page *page)
 {
-	struct address_space *mapping = page_mapping(page);
+	struct address_space *mapping;
+
+	/*
+	 * The zero page is never written to, so never has any dirty
+	 * cache lines, and therefore never needs to be flushed.
+	 */
+	if (page == ZERO_PAGE(0))
+		return;
+
+	mapping = page_mapping(page);
 
 #ifndef CONFIG_SMP
 	if (!PageHighMem(page) && mapping && !mapping_mapped(mapping))
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 02243ee..2a7cc61 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -1029,7 +1029,7 @@ void __init paging_init(struct machine_desc *mdesc)
 	 */
 	zero_page = alloc_bootmem_low_pages(PAGE_SIZE);
 	empty_zero_page = virt_to_page(zero_page);
-	flush_dcache_page(empty_zero_page);
+	__flush_dcache_page(NULL, empty_zero_page);
 }
 
 /*
-- 
1.6.2.5
