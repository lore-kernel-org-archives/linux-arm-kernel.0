From: arve@android.com (=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=)
Date: Mon,  5 Apr 2010 20:09:16 -0700
Subject: [PATCH] mm: Check if any page in a pageblock is reserved before
	marking it MIGRATE_RESERVE
In-Reply-To: <20100405101424.GA21207@csn.ul.ie>
References: <20100405101424.GA21207@csn.ul.ie>
Message-ID: <1270523356-1728-1-git-send-email-arve@android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fixes a problem where the first pageblock got marked MIGRATE_RESERVE even
though it only had a few free pages. This in turn caused no contiguous memory
to be reserved and frequent kswapd wakeups that emptied the caches to get more
contiguous memory.

Signed-off-by: Arve Hj?nnev?g <arve@android.com>
---
 mm/page_alloc.c |   16 +++++++++++++++-
 1 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index fb7df1d..46ade16 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2860,6 +2860,20 @@ static inline unsigned long wait_table_bits(unsigned long size)
 #define LONG_ALIGN(x) (((x)+(sizeof(long))-1)&~((sizeof(long))-1))
 
 /*
+ * Check if a pageblock contains reserved pages
+ */
+static int pageblock_is_reserved(unsigned long start_pfn)
+{
+	unsigned long end_pfn = start_pfn + pageblock_nr_pages;
+	unsigned long pfn;
+
+	for (pfn = start_pfn; pfn < end_pfn; pfn++)
+		if (!pfn_valid_within(pfn) || PageReserved(pfn_to_page(pfn)))
+			return 1;
+	return 0;
+}
+
+/*
  * Mark a number of pageblocks as MIGRATE_RESERVE. The number
  * of blocks reserved is based on min_wmark_pages(zone). The memory within
  * the reserve will tend to store contiguous free pages. Setting min_free_kbytes
@@ -2898,7 +2912,7 @@ static void setup_zone_migrate_reserve(struct zone *zone)
 			continue;
 
 		/* Blocks with reserved pages will never free, skip them. */
-		if (PageReserved(page))
+		if (pageblock_is_reserved(pfn))
 			continue;
 
 		block_migratetype = get_pageblock_migratetype(page);
-- 
1.6.5.1
