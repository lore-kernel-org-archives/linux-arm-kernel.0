From: ext-mika.1.westerberg@nokia.com (Mika Westerberg)
Date: Tue, 22 Jun 2010 09:59:10 +0300
Subject: [PATCH 1/3] use ARCH_PFN_OFFSET for pfn_to_paddr/paddr_to_pfn
	translations
In-Reply-To: <cover.1277188127.git.ext-mika.1.westerberg@nokia.com>
References: <cover.1277188127.git.ext-mika.1.westerberg@nokia.com>
Message-ID: <5867f5fbc8c566b76fa9ccc92ee1587b06cf18c4.1277188128.git.ext-mika.1.westerberg@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is needed on architectures where PHYS_OFFSET is not always zero.
By default ARCH_PFN_OFFSET is zero but archs may redefine it if needed.

Also make sure that exclude_zero_pages() uses pfn_to_paddr().

Signed-off-by: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
---
 makedumpfile.c |    2 +-
 makedumpfile.h |   10 ++++++++--
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index 8a90baa..a33bab6 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -4810,7 +4810,7 @@ exclude_zero_pages(void)
 
 	initialize_2nd_bitmap(&bitmap2);
 
-	for (pfn = paddr = 0; pfn < info->max_mapnr;
+	for (pfn = 0, paddr = pfn_to_paddr(pfn); pfn < info->max_mapnr;
 	    pfn++, paddr += info->page_size) {
 
 		print_progress(PROGRESS_ZERO_PAGES, pfn, info->max_mapnr);
diff --git a/makedumpfile.h b/makedumpfile.h
index 2785001..2717d81 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -112,8 +112,6 @@ isAnon(unsigned long mapping)
 #define PAGEOFFSET(X)		(((unsigned long)(X)) & (PAGESIZE() - 1))
 #define PAGEBASE(X)		(((unsigned long)(X)) & ~(PAGESIZE() - 1))
 #define _2MB_PAGE_MASK		(~((2*1048576)-1))
-#define paddr_to_pfn(X)		((unsigned long long)(X) >> PAGESHIFT())
-#define pfn_to_paddr(X)		((unsigned long long)(X) << PAGESHIFT())
 
 /*
  * for SPARSEMEM
@@ -696,6 +694,14 @@ unsigned long long vaddr_to_paddr_ia64(unsigned long vaddr);
 #define VADDR_REGION(X)		(((unsigned long)(X)) >> REGION_SHIFT)
 #endif          /* ia64 */
 
+#ifndef ARCH_PFN_OFFSET
+#define ARCH_PFN_OFFSET		0
+#endif
+#define paddr_to_pfn(X) \
+	(((unsigned long long)(X) >> PAGESHIFT()) - ARCH_PFN_OFFSET)
+#define pfn_to_paddr(X) \
+	(((unsigned long long)(X) + ARCH_PFN_OFFSET) << PAGESHIFT())
+
 struct pt_load_segment {
 	off_t			file_offset;
 	unsigned long long	phys_start;
-- 
1.5.6.5
