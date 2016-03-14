From: iamjoonsoo.kim@lge.com (Joonsoo Kim)
Date: Mon, 14 Mar 2016 16:18:03 +0900
Subject: Suspicious error for CMA stress test
In-Reply-To: <56E662E8.700@suse.cz>
References: <56D93ABE.9070406@huawei.com>
 <20160307043442.GB24602@js1304-P5Q-DELUXE>
 <56DD38E7.3050107@huawei.com> <56DDCB86.4030709@redhat.com>
 <56DE30CB.7020207@huawei.com> <56DF7B28.9060108@huawei.com>
 <CAAmzW4NDJwgq_P33Ru_X0MKXGQEnY5dr_SY1GFutPAqEUAc_rg@mail.gmail.com>
 <56E2FB5C.1040602@suse.cz>
 <20160314064925.GA27587@js1304-P5Q-DELUXE> <56E662E8.700@suse.cz>
Message-ID: <20160314071803.GA28094@js1304-P5Q-DELUXE>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 14, 2016 at 08:06:16AM +0100, Vlastimil Babka wrote:
> On 03/14/2016 07:49 AM, Joonsoo Kim wrote:
> >On Fri, Mar 11, 2016 at 06:07:40PM +0100, Vlastimil Babka wrote:
> >>On 03/11/2016 04:00 PM, Joonsoo Kim wrote:
> >>
> >>How about something like this? Just and idea, probably buggy (off-by-one etc.).
> >>Should keep away cost from <pageblock_order iterations@the expense of the
> >>relatively fewer >pageblock_order iterations.
> >
> >Hmm... I tested this and found that it's code size is a little bit
> >larger than mine. I'm not sure why this happens exactly but I guess it would be
> >related to compiler optimization. In this case, I'm in favor of my
> >implementation because it looks like well abstraction. It adds one
> >unlikely branch to the merge loop but compiler would optimize it to
> >check it once.
> 
> I would be surprised if compiler optimized that to check it once, as
> order increases with each loop iteration. But maybe it's smart
> enough to do something like I did by hand? Guess I'll check the
> disassembly.

Okay. I used following slightly optimized version and I need to
add 'max_order = min_t(unsigned int, MAX_ORDER, pageblock_order + 1)'
to yours. Please consider it, too.

Thanks.

------------------------>8------------------------
>From 36b8ffdaa0e7a8d33fd47a62a35a9e507e3e62e9 Mon Sep 17 00:00:00 2001
From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Date: Mon, 14 Mar 2016 15:20:07 +0900
Subject: [PATCH] mm: fix cma

Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
---
 mm/page_alloc.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 0bb933a..f7baa4f 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -627,8 +627,8 @@ static inline void rmv_page_order(struct page *page)
  *
  * For recording page's order, we use page_private(page).
  */
-static inline int page_is_buddy(struct page *page, struct page *buddy,
-							unsigned int order)
+static inline int page_is_buddy(struct zone *zone, struct page *page,
+				struct page *buddy, unsigned int order, int mt)
 {
 	if (!pfn_valid_within(page_to_pfn(buddy)))
 		return 0;
@@ -651,6 +651,15 @@ static inline int page_is_buddy(struct page *page, struct page *buddy,
 		if (page_zone_id(page) != page_zone_id(buddy))
 			return 0;
 
+		if (unlikely(has_isolate_pageblock(zone) &&
+			order >= pageblock_order)) {
+			int buddy_mt = get_pageblock_migratetype(buddy);
+
+			if (mt != buddy_mt && (is_migrate_isolate(mt) ||
+					is_migrate_isolate(buddy_mt)))
+				return 0;
+		}
+
 		VM_BUG_ON_PAGE(page_count(buddy) != 0, buddy);
 
 		return 1;
@@ -698,17 +707,8 @@ static inline void __free_one_page(struct page *page,
 	VM_BUG_ON_PAGE(page->flags & PAGE_FLAGS_CHECK_AT_PREP, page);
 
 	VM_BUG_ON(migratetype == -1);
-	if (is_migrate_isolate(migratetype)) {
-		/*
-		 * We restrict max order of merging to prevent merge
-		 * between freepages on isolate pageblock and normal
-		 * pageblock. Without this, pageblock isolation
-		 * could cause incorrect freepage accounting.
-		 */
-		max_order = min_t(unsigned int, MAX_ORDER, pageblock_order + 1);
-	} else {
+	if (!is_migrate_isolate(migratetype))
 		__mod_zone_freepage_state(zone, 1 << order, migratetype);
-	}
 
 	page_idx = pfn & ((1 << max_order) - 1);
 
@@ -718,7 +718,7 @@ static inline void __free_one_page(struct page *page,
 	while (order < max_order - 1) {
 		buddy_idx = __find_buddy_index(page_idx, order);
 		buddy = page + (buddy_idx - page_idx);
-		if (!page_is_buddy(page, buddy, order))
+		if (!page_is_buddy(zone, page, buddy, order, migratetype))
 			break;
 		/*
 		 * Our buddy is free or it is CONFIG_DEBUG_PAGEALLOC guard page,
@@ -752,7 +752,8 @@ static inline void __free_one_page(struct page *page,
 		higher_page = page + (combined_idx - page_idx);
 		buddy_idx = __find_buddy_index(combined_idx, order + 1);
 		higher_buddy = higher_page + (buddy_idx - combined_idx);
-		if (page_is_buddy(higher_page, higher_buddy, order + 1)) {
+		if (page_is_buddy(zone, higher_page, higher_buddy,
+					order + 1, migratetype)) {
 			list_add_tail(&page->lru,
 				&zone->free_area[order].free_list[migratetype]);
 			goto out;
-- 
1.9.1
