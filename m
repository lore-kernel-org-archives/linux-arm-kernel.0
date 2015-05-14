From: julien.grall@citrix.com (Julien Grall)
Date: Thu, 14 May 2015 18:00:55 +0100
Subject: [RFC 15/23] xen/balloon: Don't rely on the page granularity is the
 same for Xen and Linux
In-Reply-To: <1431622863-28575-1-git-send-email-julien.grall@citrix.com>
References: <1431622863-28575-1-git-send-email-julien.grall@citrix.com>
Message-ID: <1431622863-28575-16-git-send-email-julien.grall@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For ARM64 guests, Linux is able to support either 64K or 4K page
granularity. Although, the hypercall interface is always based on 4K
page granularity.

With 64K page granuliarty, a single page will be spread over multiple
Xen frame.

When a driver request/free a balloon page, the balloon driver will have
to split the Linux page in 4K chunk before asking Xen to add/remove the
frame from the guest.

Note that this can work on any page granularity assuming it's a multiple
of 4K.

Signed-off-by: Julien Grall <julien.grall@citrix.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: David Vrabel <david.vrabel@citrix.com>
Cc: Wei Liu <wei.liu2@citrix.com>

---

TODO/LIMITATIONS:
    - When CONFIG_XEN_HAVE_PMMU only 4K page granularity is supported
    - It may be possible to extend the concept for ballooning 2M/1G
    page.
---
 drivers/xen/balloon.c | 93 +++++++++++++++++++++++++++++++++------------------
 1 file changed, 60 insertions(+), 33 deletions(-)

diff --git a/drivers/xen/balloon.c b/drivers/xen/balloon.c
index fd93369..f0d8666 100644
--- a/drivers/xen/balloon.c
+++ b/drivers/xen/balloon.c
@@ -91,7 +91,7 @@ struct balloon_stats balloon_stats;
 EXPORT_SYMBOL_GPL(balloon_stats);
 
 /* We increase/decrease in batches which fit in a page */
-static xen_pfn_t frame_list[PAGE_SIZE / sizeof(unsigned long)];
+static xen_pfn_t frame_list[XEN_PAGE_SIZE / sizeof(unsigned long)];
 
 
 /* List of ballooned pages, threaded through the mem_map array. */
@@ -326,7 +326,7 @@ static enum bp_state reserve_additional_memory(long credit)
 static enum bp_state increase_reservation(unsigned long nr_pages)
 {
 	int rc;
-	unsigned long  pfn, i;
+	unsigned long  pfn, i, nr_frames;
 	struct page   *page;
 	struct xen_memory_reservation reservation = {
 		.address_bits = 0,
@@ -343,30 +343,43 @@ static enum bp_state increase_reservation(unsigned long nr_pages)
 	}
 #endif
 
-	if (nr_pages > ARRAY_SIZE(frame_list))
-		nr_pages = ARRAY_SIZE(frame_list);
+	if (nr_pages > (ARRAY_SIZE(frame_list) / XEN_PFN_PER_PAGE))
+		nr_pages = ARRAY_SIZE(frame_list) / XEN_PFN_PER_PAGE;
+
+	nr_frames = nr_pages * XEN_PFN_PER_PAGE;
+
+	pfn = 0; /* make gcc happy */
 
 	page = list_first_entry_or_null(&ballooned_pages, struct page, lru);
-	for (i = 0; i < nr_pages; i++) {
-		if (!page) {
-			nr_pages = i;
-			break;
+	for (i = 0; i < nr_frames; i++) {
+		if (!(i % XEN_PFN_PER_PAGE)) {
+			if (!page) {
+				nr_frames = i;
+				break;
+			}
+			pfn = xen_page_to_pfn(page);
+			page = balloon_next_page(page);
 		}
-		frame_list[i] = page_to_pfn(page);
-		page = balloon_next_page(page);
+		frame_list[i] = pfn++;
 	}
 
 	set_xen_guest_handle(reservation.extent_start, frame_list);
-	reservation.nr_extents = nr_pages;
+	reservation.nr_extents = nr_frames;
 	rc = HYPERVISOR_memory_op(XENMEM_populate_physmap, &reservation);
 	if (rc <= 0)
 		return BP_EAGAIN;
 
 	for (i = 0; i < rc; i++) {
-		page = balloon_retrieve(false);
-		BUG_ON(page == NULL);
 
-		pfn = page_to_pfn(page);
+		/* TODO: Make this code cleaner to make CONFIG_XEN_HAVE_PVMMU
+		 * with 64K Pages
+		 */
+		if (!(i % XEN_PFN_PER_PAGE)) {
+			page = balloon_retrieve(false);
+			BUG_ON(page == NULL);
+
+			pfn = page_to_pfn(page);
+		}
 
 #ifdef CONFIG_XEN_HAVE_PVMMU
 		if (!xen_feature(XENFEAT_auto_translated_physmap)) {
@@ -385,7 +398,8 @@ static enum bp_state increase_reservation(unsigned long nr_pages)
 #endif
 
 		/* Relinquish the page back to the allocator. */
-		__free_reserved_page(page);
+		if (!(i % XEN_PFN_PER_PAGE))
+			__free_reserved_page(page);
 	}
 
 	balloon_stats.current_pages += rc;
@@ -396,7 +410,7 @@ static enum bp_state increase_reservation(unsigned long nr_pages)
 static enum bp_state decrease_reservation(unsigned long nr_pages, gfp_t gfp)
 {
 	enum bp_state state = BP_DONE;
-	unsigned long  pfn, i;
+	unsigned long  pfn, i, nr_frames;
 	struct page   *page;
 	int ret;
 	struct xen_memory_reservation reservation = {
@@ -414,19 +428,27 @@ static enum bp_state decrease_reservation(unsigned long nr_pages, gfp_t gfp)
 	}
 #endif
 
-	if (nr_pages > ARRAY_SIZE(frame_list))
-		nr_pages = ARRAY_SIZE(frame_list);
+	if (nr_pages > (ARRAY_SIZE(frame_list) / XEN_PFN_PER_PAGE))
+		nr_pages = ARRAY_SIZE(frame_list) / XEN_PFN_PER_PAGE;
 
-	for (i = 0; i < nr_pages; i++) {
-		page = alloc_page(gfp);
-		if (page == NULL) {
-			nr_pages = i;
-			state = BP_EAGAIN;
-			break;
+	nr_frames = nr_pages * XEN_PFN_PER_PAGE;
+
+	pfn = 0; /* Make GCC happy */
+
+	for (i = 0; i < nr_frames; i++) {
+
+		if (!(i % XEN_PFN_PER_PAGE)) {
+			page = alloc_page(gfp);
+			if (page == NULL) {
+				nr_frames = i;
+				state = BP_EAGAIN;
+				break;
+			}
+			scrub_page(page);
+			pfn = xen_page_to_pfn(page);
 		}
-		scrub_page(page);
 
-		frame_list[i] = page_to_pfn(page);
+		frame_list[i] = pfn++;
 	}
 
 	/*
@@ -439,16 +461,20 @@ static enum bp_state decrease_reservation(unsigned long nr_pages, gfp_t gfp)
 	kmap_flush_unused();
 
 	/* Update direct mapping, invalidate P2M, and add to balloon. */
-	for (i = 0; i < nr_pages; i++) {
+	for (i = 0; i < nr_frames; i++) {
 		pfn = frame_list[i];
 		frame_list[i] = pfn_to_mfn(pfn);
-		page = pfn_to_page(pfn);
+		page = xen_pfn_to_page(pfn);
+
+		/* TODO: Make this code cleaner to make CONFIG_XEN_HAVE_PVMMU
+		 * work with 64K pages
+		 */
 
 #ifdef CONFIG_XEN_HAVE_PVMMU
 		if (!xen_feature(XENFEAT_auto_translated_physmap)) {
 			if (!PageHighMem(page)) {
 				ret = HYPERVISOR_update_va_mapping(
-						(unsigned long)__va(pfn << PAGE_SHIFT),
+						(unsigned long)__va(pfn << XEN_PAGE_SHIFT),
 						__pte_ma(0), 0);
 				BUG_ON(ret);
 			}
@@ -456,17 +482,18 @@ static enum bp_state decrease_reservation(unsigned long nr_pages, gfp_t gfp)
 		}
 #endif
 
-		balloon_append(page);
+		if (!(i % XEN_PFN_PER_PAGE))
+			balloon_append(page);
 	}
 
 	flush_tlb_all();
 
 	set_xen_guest_handle(reservation.extent_start, frame_list);
-	reservation.nr_extents   = nr_pages;
+	reservation.nr_extents   = nr_frames;
 	ret = HYPERVISOR_memory_op(XENMEM_decrease_reservation, &reservation);
-	BUG_ON(ret != nr_pages);
+	BUG_ON(ret != nr_frames);
 
-	balloon_stats.current_pages -= nr_pages;
+	balloon_stats.current_pages -= nr_frames * XEN_PFN_PER_PAGE;
 
 	return state;
 }
-- 
2.1.4
