From: julien.grall@citrix.com (Julien Grall)
Date: Mon, 7 Sep 2015 16:33:45 +0100
Subject: [PATCH v4 07/20] block/xen-blkfront: Store a page rather a pfn in the
 grant structure
In-Reply-To: <1441640038-23615-1-git-send-email-julien.grall@citrix.com>
References: <1441640038-23615-1-git-send-email-julien.grall@citrix.com>
Message-ID: <1441640038-23615-8-git-send-email-julien.grall@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All the usage of the field pfn are done using the same idiom:

pfn_to_page(grant->pfn)

This will  return always the same page. Store directly the page in the
grant to clean up the code.

Signed-off-by: Julien Grall <julien.grall@citrix.com>
Acked-by: Roger Pau Monn? <roger.pau@citrix.com>
Reviewed-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>

---
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: David Vrabel <david.vrabel@citrix.com>

Roger, Stefano, I kept your Acked-by/Reviewed-by because the rebase was
minor. Let me know if you disagree.

    Changes in v4:
        - rebase after 7adf12b87f45a77d364464018fb8e9e1ac875152
        "xen-blkfront: don't add indirect pages to list when
        !feature_persistent"

    Changes in v3:
        - Use the correct indentation in get_grant. The current
        indentation (i.e without this patch) was wrong because it was
        using space rather than tabulation.
        - Add Roger's acked and Stefano's reviewed
        - s/mfn/gfn based on the new naming

    Changes in v2:
        - Patch added
---
 drivers/block/xen-blkfront.c | 39 +++++++++++++++++++--------------------
 1 file changed, 19 insertions(+), 20 deletions(-)

diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index b11f084..556475d 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -68,7 +68,7 @@ enum blkif_state {
 
 struct grant {
 	grant_ref_t gref;
-	unsigned long pfn;
+	struct page *page;
 	struct list_head node;
 };
 
@@ -222,7 +222,7 @@ static int fill_grant_buffer(struct blkfront_info *info, int num)
 				kfree(gnt_list_entry);
 				goto out_of_memory;
 			}
-			gnt_list_entry->pfn = page_to_pfn(granted_page);
+			gnt_list_entry->page = granted_page;
 		}
 
 		gnt_list_entry->gref = GRANT_INVALID_REF;
@@ -237,7 +237,7 @@ out_of_memory:
 	                         &info->grants, node) {
 		list_del(&gnt_list_entry->node);
 		if (info->feature_persistent)
-			__free_page(pfn_to_page(gnt_list_entry->pfn));
+			__free_page(gnt_list_entry->page);
 		kfree(gnt_list_entry);
 		i--;
 	}
@@ -246,8 +246,8 @@ out_of_memory:
 }
 
 static struct grant *get_grant(grant_ref_t *gref_head,
-                               unsigned long pfn,
-                               struct blkfront_info *info)
+			       struct page *page,
+			       struct blkfront_info *info)
 {
 	struct grant *gnt_list_entry;
 	unsigned long buffer_gfn;
@@ -266,10 +266,10 @@ static struct grant *get_grant(grant_ref_t *gref_head,
 	gnt_list_entry->gref = gnttab_claim_grant_reference(gref_head);
 	BUG_ON(gnt_list_entry->gref == -ENOSPC);
 	if (!info->feature_persistent) {
-		BUG_ON(!pfn);
-		gnt_list_entry->pfn = pfn;
+		BUG_ON(!page);
+		gnt_list_entry->page = page;
 	}
-	buffer_gfn = pfn_to_gfn(gnt_list_entry->pfn);
+	buffer_gfn = xen_page_to_gfn(gnt_list_entry->page);
 	gnttab_grant_foreign_access_ref(gnt_list_entry->gref,
 	                                info->xbdev->otherend_id,
 	                                buffer_gfn, 0);
@@ -525,7 +525,7 @@ static int blkif_queue_rw_req(struct request *req)
 
 		if ((ring_req->operation == BLKIF_OP_INDIRECT) &&
 		    (i % SEGS_PER_INDIRECT_FRAME == 0)) {
-			unsigned long uninitialized_var(pfn);
+			struct page *uninitialized_var(page);
 
 			if (segments)
 				kunmap_atomic(segments);
@@ -542,15 +542,15 @@ static int blkif_queue_rw_req(struct request *req)
 				indirect_page = list_first_entry(&info->indirect_pages,
 								 struct page, lru);
 				list_del(&indirect_page->lru);
-				pfn = page_to_pfn(indirect_page);
+				page = indirect_page;
 			}
-			gnt_list_entry = get_grant(&gref_head, pfn, info);
+			gnt_list_entry = get_grant(&gref_head, page, info);
 			info->shadow[id].indirect_grants[n] = gnt_list_entry;
-			segments = kmap_atomic(pfn_to_page(gnt_list_entry->pfn));
+			segments = kmap_atomic(gnt_list_entry->page);
 			ring_req->u.indirect.indirect_grefs[n] = gnt_list_entry->gref;
 		}
 
-		gnt_list_entry = get_grant(&gref_head, page_to_pfn(sg_page(sg)), info);
+		gnt_list_entry = get_grant(&gref_head, sg_page(sg), info);
 		ref = gnt_list_entry->gref;
 
 		info->shadow[id].grants_used[i] = gnt_list_entry;
@@ -561,7 +561,7 @@ static int blkif_queue_rw_req(struct request *req)
 
 			BUG_ON(sg->offset + sg->length > PAGE_SIZE);
 
-			shared_data = kmap_atomic(pfn_to_page(gnt_list_entry->pfn));
+			shared_data = kmap_atomic(gnt_list_entry->page);
 			bvec_data = kmap_atomic(sg_page(sg));
 
 			/*
@@ -1002,7 +1002,7 @@ static void blkif_free(struct blkfront_info *info, int suspend)
 				info->persistent_gnts_c--;
 			}
 			if (info->feature_persistent)
-				__free_page(pfn_to_page(persistent_gnt->pfn));
+				__free_page(persistent_gnt->page);
 			kfree(persistent_gnt);
 		}
 	}
@@ -1037,7 +1037,7 @@ static void blkif_free(struct blkfront_info *info, int suspend)
 			persistent_gnt = info->shadow[i].grants_used[j];
 			gnttab_end_foreign_access(persistent_gnt->gref, 0, 0UL);
 			if (info->feature_persistent)
-				__free_page(pfn_to_page(persistent_gnt->pfn));
+				__free_page(persistent_gnt->page);
 			kfree(persistent_gnt);
 		}
 
@@ -1051,7 +1051,7 @@ static void blkif_free(struct blkfront_info *info, int suspend)
 		for (j = 0; j < INDIRECT_GREFS(segs); j++) {
 			persistent_gnt = info->shadow[i].indirect_grants[j];
 			gnttab_end_foreign_access(persistent_gnt->gref, 0, 0UL);
-			__free_page(pfn_to_page(persistent_gnt->pfn));
+			__free_page(persistent_gnt->page);
 			kfree(persistent_gnt);
 		}
 
@@ -1102,8 +1102,7 @@ static void blkif_completion(struct blk_shadow *s, struct blkfront_info *info,
 	if (bret->operation == BLKIF_OP_READ && info->feature_persistent) {
 		for_each_sg(s->sg, sg, nseg, i) {
 			BUG_ON(sg->offset + sg->length > PAGE_SIZE);
-			shared_data = kmap_atomic(
-				pfn_to_page(s->grants_used[i]->pfn));
+			shared_data = kmap_atomic(s->grants_used[i]->page);
 			bvec_data = kmap_atomic(sg_page(sg));
 			memcpy(bvec_data   + sg->offset,
 			       shared_data + sg->offset,
@@ -1155,7 +1154,7 @@ static void blkif_completion(struct blk_shadow *s, struct blkfront_info *info,
 				 * available pages for indirect grefs.
 				 */
 				if (!info->feature_persistent) {
-					indirect_page = pfn_to_page(s->indirect_grants[i]->pfn);
+					indirect_page = s->indirect_grants[i]->page;
 					list_add(&indirect_page->lru, &info->indirect_pages);
 				}
 				s->indirect_grants[i]->gref = GRANT_INVALID_REF;
-- 
2.1.4
