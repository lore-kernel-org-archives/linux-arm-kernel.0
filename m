From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 12 Oct 2011 13:08:55 +0200
Subject: [PATCH] fixup: mm: alloc_contig_range: increase min_free_kbytes during
	allocation
In-Reply-To: <4E93F088.60006@stericsson.com>
References: <4E93F088.60006@stericsson.com>
Message-ID: <1318417735-9199-1-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 mm/page_alloc.c |   15 ++++++++++++---
 1 files changed, 12 insertions(+), 3 deletions(-)

Hello Maxime,

Please check if this patch fixes your lockup issue. It is a bit cruel,
but it looks that in case of real low-memory situation page allocation
is very complex task which usually ends in waiting for the io/fs and
free pages that really don't arrive at all.

Best regards
--
Marek Szyprowski
Samsung Poland R&D Center



diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 055aa4c..45473e9 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5872,6 +5872,7 @@ int alloc_contig_range(unsigned long start, unsigned long end,
 		       gfp_t flags, unsigned migratetype)
 {
 	unsigned long outer_start, outer_end;
+	unsigned int count = end - start;
 	int ret;
 
 	/*
@@ -5900,7 +5901,10 @@ int alloc_contig_range(unsigned long start, unsigned long end,
 	ret = __start_isolate_page_range(pfn_to_maxpage(start),
 					 pfn_to_maxpage_up(end), migratetype);
 	if (ret)
-		goto done;
+		return ret;
+
+	min_free_kbytes += count * PAGE_SIZE / 1024;
+	setup_per_zone_wmarks();
 
 	ret = __alloc_contig_migrate_range(start, end);
 	if (ret)
@@ -5922,8 +5926,10 @@ int alloc_contig_range(unsigned long start, unsigned long end,
 
 	ret = 0;
 	while (!PageBuddy(pfn_to_page(start & (~0UL << ret))))
-		if (WARN_ON(++ret >= MAX_ORDER))
-			return -EINVAL;
+		if (WARN_ON(++ret >= MAX_ORDER)) {
+			ret = -EINVAL;
+			goto done;
+		}
 
 	outer_start = start & (~0UL << ret);
 	outer_end   = alloc_contig_freed_pages(outer_start, end, flags);
@@ -5936,6 +5942,9 @@ int alloc_contig_range(unsigned long start, unsigned long end,
 
 	ret = 0;
 done:
+	min_free_kbytes -= count * PAGE_SIZE / 1024;
+	setup_per_zone_wmarks();
+
 	__undo_isolate_page_range(pfn_to_maxpage(start), pfn_to_maxpage_up(end),
 				  migratetype);
 	return ret;
-- 
1.7.1.569.g6f426
