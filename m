From: julien.grall@citrix.com (Julien Grall)
Date: Thu, 9 Jul 2015 21:42:19 +0100
Subject: [PATCH v2 07/20] block/xen-blkfront: split get_grant in 2
In-Reply-To: <1436474552-31789-1-git-send-email-julien.grall@citrix.com>
References: <1436474552-31789-1-git-send-email-julien.grall@citrix.com>
Message-ID: <1436474552-31789-8-git-send-email-julien.grall@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Prepare the code to support 64KB page granularity. The first
implementation will use a full Linux page per indirect and persistent
grant. When non-persistent grant is used, each page of a bio request
may be split in multiple grant.

Furthermore, the field page of the grant structure is only used to copy
data from persistent grant or indirect grant. Avoid to set it for other
use case as it will have no meaning given the page will be split in
multiple grant.

Provide 2 functions, to setup indirect grant, the other for bio page.

Signed-off-by: Julien Grall <julien.grall@citrix.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Roger Pau Monn? <roger.pau@citrix.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: David Vrabel <david.vrabel@citrix.com>
---
    Changes in v2:
        - Patch added
---
 drivers/block/xen-blkfront.c | 85 ++++++++++++++++++++++++++++++--------------
 1 file changed, 59 insertions(+), 26 deletions(-)

diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index 7b81d23..95fd067 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -242,34 +242,77 @@ out_of_memory:
 	return -ENOMEM;
 }
 
-static struct grant *get_grant(grant_ref_t *gref_head,
-			       struct page *page,
-                               struct blkfront_info *info)
+static struct grant *get_free_grant(struct blkfront_info *info)
 {
 	struct grant *gnt_list_entry;
-	unsigned long buffer_mfn;
 
 	BUG_ON(list_empty(&info->grants));
 	gnt_list_entry = list_first_entry(&info->grants, struct grant,
-	                                  node);
+					  node);
 	list_del(&gnt_list_entry->node);
 
-	if (gnt_list_entry->gref != GRANT_INVALID_REF) {
+	if (gnt_list_entry->gref != GRANT_INVALID_REF)
 		info->persistent_gnts_c--;
+
+	return gnt_list_entry;
+}
+
+static void grant_foreign_access(const struct grant *gnt_list_entry,
+				 const struct blkfront_info *info)
+{
+	gnttab_page_grant_foreign_access_ref(gnt_list_entry->gref,
+					     info->xbdev->otherend_id,
+					     gnt_list_entry->page,
+					     0);
+}
+
+static struct grant *get_grant(grant_ref_t *gref_head,
+			       unsigned long mfn,
+			       struct blkfront_info *info)
+{
+	struct grant *gnt_list_entry = get_free_grant(info);
+
+	if (gnt_list_entry->gref != GRANT_INVALID_REF)
 		return gnt_list_entry;
+
+	/* Assign a gref to this page */
+	gnt_list_entry->gref = gnttab_claim_grant_reference(gref_head);
+	BUG_ON(gnt_list_entry->gref == -ENOSPC);
+	if (info->feature_persistent)
+		grant_foreign_access(gnt_list_entry, info);
+	else {
+		/* Grant access to the MFN passed by the caller */
+		gnttab_grant_foreign_access_ref(gnt_list_entry->gref,
+			                        info->xbdev->otherend_id,
+				                mfn, 0);
 	}
 
+	return gnt_list_entry;
+}
+
+static struct grant *get_indirect_grant(grant_ref_t *gref_head,
+					struct blkfront_info *info)
+{
+	struct grant *gnt_list_entry = get_free_grant(info);
+
+	if (gnt_list_entry->gref != GRANT_INVALID_REF)
+		return gnt_list_entry;
+
 	/* Assign a gref to this page */
 	gnt_list_entry->gref = gnttab_claim_grant_reference(gref_head);
 	BUG_ON(gnt_list_entry->gref == -ENOSPC);
 	if (!info->feature_persistent) {
-		BUG_ON(!page);
-		gnt_list_entry->page = page;
+		struct page *indirect_page;
+
+		/* Fetch a pre-allocated page to use for indirect grefs */
+		BUG_ON(list_empty(&info->indirect_pages));
+		indirect_page = list_first_entry(&info->indirect_pages,
+		                                 struct page, lru);
+		list_del(&indirect_page->lru);
+		gnt_list_entry->page = indirect_page;
 	}
-	buffer_mfn = page_to_mfn(gnt_list_entry->page);
-	gnttab_grant_foreign_access_ref(gnt_list_entry->gref,
-	                                info->xbdev->otherend_id,
-	                                buffer_mfn, 0);
+	grant_foreign_access(gnt_list_entry, info);
+
 	return gnt_list_entry;
 }
 
@@ -522,29 +565,19 @@ static int blkif_queue_rw_req(struct request *req)
 
 		if ((ring_req->operation == BLKIF_OP_INDIRECT) &&
 		    (i % SEGS_PER_INDIRECT_FRAME == 0)) {
-			struct page *uninitialized_var(page);
-
 			if (segments)
 				kunmap_atomic(segments);
 
 			n = i / SEGS_PER_INDIRECT_FRAME;
-			if (!info->feature_persistent) {
-				struct page *indirect_page;
-
-				/* Fetch a pre-allocated page to use for indirect grefs */
-				BUG_ON(list_empty(&info->indirect_pages));
-				indirect_page = list_first_entry(&info->indirect_pages,
-				                                 struct page, lru);
-				list_del(&indirect_page->lru);
-				page = indirect_page;
-			}
-			gnt_list_entry = get_grant(&gref_head, page, info);
+			gnt_list_entry = get_indirect_grant(&gref_head, info);
 			info->shadow[id].indirect_grants[n] = gnt_list_entry;
 			segments = kmap_atomic(gnt_list_entry->page);
 			ring_req->u.indirect.indirect_grefs[n] = gnt_list_entry->gref;
 		}
 
-		gnt_list_entry = get_grant(&gref_head, sg_page(sg), info);
+		gnt_list_entry = get_grant(&gref_head,
+					   page_to_mfn(sg_page(sg)),
+					   info);
 		ref = gnt_list_entry->gref;
 
 		info->shadow[id].grants_used[i] = gnt_list_entry;
-- 
2.1.4
