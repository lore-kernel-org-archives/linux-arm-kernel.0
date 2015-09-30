From: julien.grall@citrix.com (Julien Grall)
Date: Wed, 30 Sep 2015 11:45:27 +0100
Subject: [PATCH v5 12/22] xen/balloon: Don't rely on the page granularity is
 the same for Xen and Linux
In-Reply-To: <1443609937-25278-1-git-send-email-julien.grall@citrix.com>
References: <1443609937-25278-1-git-send-email-julien.grall@citrix.com>
Message-ID: <1443609937-25278-13-git-send-email-julien.grall@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For ARM64 guests, Linux is able to support either 64K or 4K page
granularity. Although, the hypercall interface is always based on 4K
page granularity.

With 64K page granularity, a single page will be spread over multiple
Xen frame.

To avoid splitting the page into 4K frame, take advantage of the
extent_order field to directly allocate/free chunk of the Linux page
size.

Note that PVMMU is only used for PV guest (which is x86) and the page
granularity is always 4KB. Some BUILD_BUG_ON has been added to ensure
that because the code has not been modified.

Signed-off-by: Julien Grall <julien.grall@citrix.com>
Reviewed-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>

---
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: David Vrabel <david.vrabel@citrix.com>
Cc: Wei Liu <wei.liu2@citrix.com>

Note that two BUILD_BUG_ON(XEN_PAGE_SIZE != PAGE_SIZE) in code built
for the PV MMU code is kept in order to have at least one even if we
ever decide to drop of code section.

Stefano, I've kept your reviewed-by because the rebase conflict was very
trivial. Let me know if it's not okay.

    Changes in v5:
        - Add Stefano's reviewed-by
        - Fix comment coding style
        - Rebase on top of xentip/for-linus-4.4. Got minor conflict

    Changes in v4:
        - s/xen_page_to_pfn/page_to_xen_pfn/ based on the new naming
        - Use the field lru in the page to get a list of pages when
        decreasing the memory reservation. It avoids to use a static
        array to store the pages (see v3).
        - Update comment for EXTENT_ORDER.

    Changes in v3:
        - Fix errors reported by checkpatch.pl
        - s/mfn/gfn/ based on the new naming
        - Rather than splitting the page into 4KB chunk, use the
        extent_order field to allocate directly a Linux page size. This
        is avoid lots of code for no benefits.

    Changes in v2:
        - Use xen_apply_to_page to split a page in 4K chunk
        - It's not necessary to have a smaller frame list. Re-use
        PAGE_SIZE
        - Convert reserve_additional_memory to use XEN_... macro
---
 drivers/xen/balloon.c | 69 ++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 54 insertions(+), 15 deletions(-)

diff --git a/drivers/xen/balloon.c b/drivers/xen/balloon.c
index 5fd7ee1..eaab31f 100644
--- a/drivers/xen/balloon.c
+++ b/drivers/xen/balloon.c
@@ -113,6 +113,12 @@ static struct ctl_table xen_root[] = {
 #endif
 
 /*
+ * Use one extent per PAGE_SIZE to avoid to break down the page into
+ * multiple frame.
+ */
+#define EXTENT_ORDER (fls(XEN_PFN_PER_PAGE) - 1)
+
+/*
  * balloon_process() state:
  *
  * BP_DONE: done or nothing to do,
@@ -304,6 +310,12 @@ static enum bp_state reserve_additional_memory(void)
 	nid = memory_add_physaddr_to_nid(resource->start);
 
 #ifdef CONFIG_XEN_HAVE_PVMMU
+	/*
+	 * We don't support PV MMU when Linux and Xen is using
+	 * different page granularity.
+	 */
+	BUILD_BUG_ON(XEN_PAGE_SIZE != PAGE_SIZE);
+
         /*
          * add_memory() will build page tables for the new memory so
          * the p2m must contain invalid entries so the correct
@@ -384,11 +396,11 @@ static bool balloon_is_inflated(void)
 static enum bp_state increase_reservation(unsigned long nr_pages)
 {
 	int rc;
-	unsigned long  pfn, i;
+	unsigned long i;
 	struct page   *page;
 	struct xen_memory_reservation reservation = {
 		.address_bits = 0,
-		.extent_order = 0,
+		.extent_order = EXTENT_ORDER,
 		.domid        = DOMID_SELF
 	};
 
@@ -401,7 +413,11 @@ static enum bp_state increase_reservation(unsigned long nr_pages)
 			nr_pages = i;
 			break;
 		}
-		frame_list[i] = page_to_pfn(page);
+
+		/* XENMEM_populate_physmap requires a PFN based on Xen
+		 * granularity.
+		 */
+		frame_list[i] = page_to_xen_pfn(page);
 		page = balloon_next_page(page);
 	}
 
@@ -415,10 +431,16 @@ static enum bp_state increase_reservation(unsigned long nr_pages)
 		page = balloon_retrieve(false);
 		BUG_ON(page == NULL);
 
-		pfn = page_to_pfn(page);
-
 #ifdef CONFIG_XEN_HAVE_PVMMU
+		/*
+		 * We don't support PV MMU when Linux and Xen is using
+		 * different page granularity.
+		 */
+		BUILD_BUG_ON(XEN_PAGE_SIZE != PAGE_SIZE);
+
 		if (!xen_feature(XENFEAT_auto_translated_physmap)) {
+			unsigned long pfn = page_to_pfn(page);
+
 			set_phys_to_machine(pfn, frame_list[i]);
 
 			/* Link back into the page tables if not highmem. */
@@ -445,14 +467,15 @@ static enum bp_state increase_reservation(unsigned long nr_pages)
 static enum bp_state decrease_reservation(unsigned long nr_pages, gfp_t gfp)
 {
 	enum bp_state state = BP_DONE;
-	unsigned long  pfn, i;
-	struct page   *page;
+	unsigned long i;
+	struct page *page, *tmp;
 	int ret;
 	struct xen_memory_reservation reservation = {
 		.address_bits = 0,
-		.extent_order = 0,
+		.extent_order = EXTENT_ORDER,
 		.domid        = DOMID_SELF
 	};
+	LIST_HEAD(pages);
 
 	if (nr_pages > ARRAY_SIZE(frame_list))
 		nr_pages = ARRAY_SIZE(frame_list);
@@ -465,8 +488,7 @@ static enum bp_state decrease_reservation(unsigned long nr_pages, gfp_t gfp)
 			break;
 		}
 		scrub_page(page);
-
-		frame_list[i] = page_to_pfn(page);
+		list_add(&page->lru, &pages);
 	}
 
 	/*
@@ -478,14 +500,24 @@ static enum bp_state decrease_reservation(unsigned long nr_pages, gfp_t gfp)
 	 */
 	kmap_flush_unused();
 
-	/* Update direct mapping, invalidate P2M, and add to balloon. */
-	for (i = 0; i < nr_pages; i++) {
-		pfn = frame_list[i];
-		frame_list[i] = pfn_to_gfn(pfn);
-		page = pfn_to_page(pfn);
+	/*
+	 * Setup the frame, update direct mapping, invalidate P2M,
+	 * and add to balloon.
+	 */
+	list_for_each_entry_safe(page, tmp, &pages, lru) {
+		/* XENMEM_decrease_reservation requires a GFN */
+		frame_list[i] = xen_page_to_gfn(page);
 
 #ifdef CONFIG_XEN_HAVE_PVMMU
+		/*
+		 * We don't support PV MMU when Linux and Xen is using
+		 * different page granularity.
+		 */
+		BUILD_BUG_ON(XEN_PAGE_SIZE != PAGE_SIZE);
+
 		if (!xen_feature(XENFEAT_auto_translated_physmap)) {
+			unsigned long pfn = page_to_pfn(page);
+
 			if (!PageHighMem(page)) {
 				ret = HYPERVISOR_update_va_mapping(
 						(unsigned long)__va(pfn << PAGE_SHIFT),
@@ -495,6 +527,7 @@ static enum bp_state decrease_reservation(unsigned long nr_pages, gfp_t gfp)
 			__set_phys_to_machine(pfn, INVALID_P2M_ENTRY);
 		}
 #endif
+		list_del(&page->lru);
 
 		balloon_append(page);
 	}
@@ -603,6 +636,12 @@ int alloc_xenballooned_pages(int nr_pages, struct page **pages)
 		if (page) {
 			pages[pgno++] = page;
 #ifdef CONFIG_XEN_HAVE_PVMMU
+			/*
+			 * We don't support PV MMU when Linux and Xen is using
+			 * different page granularity.
+			 */
+			BUILD_BUG_ON(XEN_PAGE_SIZE != PAGE_SIZE);
+
 			ret = xen_alloc_p2m_entry(page_to_pfn(page));
 			if (ret < 0)
 				goto out_undo;
-- 
2.1.4
