From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Fri, 18 Nov 2011 17:43:08 +0100
Subject: [PATCH 01/11] mm: page_alloc: handle MIGRATE_ISOLATE in
 free_pcppages_bulk()
In-Reply-To: <1321634598-16859-1-git-send-email-m.szyprowski@samsung.com>
References: <1321634598-16859-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1321634598-16859-2-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Michal Nazarewicz <mina86@mina86.com>

If page is on PCP list while pageblock it belongs to gets isolated,
the page's private still holds the old migrate type.  This means
that free_pcppages_bulk() will put the page on a freelist of the
old migrate type instead of MIGRATE_ISOLATE.

This commit changes that by explicitly checking whether page's
pageblock's migrate type is MIGRATE_ISOLATE and if it is, overwrites
page's private data.

Signed-off-by: Michal Nazarewicz <mina86@mina86.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 mm/page_alloc.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 9dd443d..58d1a2e 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -628,6 +628,18 @@ static void free_pcppages_bulk(struct zone *zone, int count,
 			page = list_entry(list->prev, struct page, lru);
 			/* must delete as __free_one_page list manipulates */
 			list_del(&page->lru);
+
+			/*
+			 * When page is isolated in set_migratetype_isolate()
+			 * function it's page_private is not changed since the
+			 * function has no way of knowing if it can touch it.
+			 * This means that when a page is on PCP list, it's
+			 * page_private no longer matches the desired migrate
+			 * type.
+			 */
+			if (get_pageblock_migratetype(page) == MIGRATE_ISOLATE)
+				set_page_private(page, MIGRATE_ISOLATE);
+
 			/* MIGRATE_MOVABLE list may include MIGRATE_RESERVEs */
 			__free_one_page(page, zone, 0, page_private(page));
 			trace_mm_page_pcpu_drain(page, 0, page_private(page));
-- 
1.7.1.569.g6f426
