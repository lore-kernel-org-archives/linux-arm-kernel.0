From: julien.grall@citrix.com (Julien Grall)
Date: Wed, 30 Sep 2015 11:45:21 +0100
Subject: [PATCH v5 06/22] block/xen-blkfront: Split blkif_queue_request in 2
In-Reply-To: <1443609937-25278-1-git-send-email-julien.grall@citrix.com>
References: <1443609937-25278-1-git-send-email-julien.grall@citrix.com>
Message-ID: <1443609937-25278-7-git-send-email-julien.grall@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, blkif_queue_request has 2 distinct execution path:
    - Send a discard request
    - Send a read/write request

The function is also allocating grants to use for generating the
request. Although, this is only used for read/write request.

Rather than having a function with 2 distinct execution path, separate
the function in 2. This will also remove one level of tabulation.

Signed-off-by: Julien Grall <julien.grall@citrix.com>
Reviewed-by: Roger Pau Monn? <roger.pau@citrix.com>

---
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: David Vrabel <david.vrabel@citrix.com>

    Roger, if you really want if can drop the else clause in
    blkif_queue_request, IHMO it's more clear here. Although I've kept
    your Reviewed-by. Let me know if it's not fine.

    Changes in v3:
        - Fix errors reported by checkpatch.pl
        - Add Roger's Reviewed-by

    Changes in v2:
        - Patch added
---
 drivers/block/xen-blkfront.c | 277 ++++++++++++++++++++++++-------------------
 1 file changed, 153 insertions(+), 124 deletions(-)

diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index 0823a96..c94ca26 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -394,13 +394,35 @@ static int blkif_ioctl(struct block_device *bdev, fmode_t mode,
 	return 0;
 }
 
-/*
- * Generate a Xen blkfront IO request from a blk layer request.  Reads
- * and writes are handled as expected.
- *
- * @req: a request struct
- */
-static int blkif_queue_request(struct request *req)
+static int blkif_queue_discard_req(struct request *req)
+{
+	struct blkfront_info *info = req->rq_disk->private_data;
+	struct blkif_request *ring_req;
+	unsigned long id;
+
+	/* Fill out a communications ring structure. */
+	ring_req = RING_GET_REQUEST(&info->ring, info->ring.req_prod_pvt);
+	id = get_id_from_freelist(info);
+	info->shadow[id].request = req;
+
+	ring_req->operation = BLKIF_OP_DISCARD;
+	ring_req->u.discard.nr_sectors = blk_rq_sectors(req);
+	ring_req->u.discard.id = id;
+	ring_req->u.discard.sector_number = (blkif_sector_t)blk_rq_pos(req);
+	if ((req->cmd_flags & REQ_SECURE) && info->feature_secdiscard)
+		ring_req->u.discard.flag = BLKIF_DISCARD_SECURE;
+	else
+		ring_req->u.discard.flag = 0;
+
+	info->ring.req_prod_pvt++;
+
+	/* Keep a private copy so we can reissue requests when recovering. */
+	info->shadow[id].req = *ring_req;
+
+	return 0;
+}
+
+static int blkif_queue_rw_req(struct request *req)
 {
 	struct blkfront_info *info = req->rq_disk->private_data;
 	struct blkif_request *ring_req;
@@ -420,9 +442,6 @@ static int blkif_queue_request(struct request *req)
 	struct scatterlist *sg;
 	int nseg, max_grefs;
 
-	if (unlikely(info->connected != BLKIF_STATE_CONNECTED))
-		return 1;
-
 	max_grefs = req->nr_phys_segments;
 	if (max_grefs > BLKIF_MAX_SEGMENTS_PER_REQUEST)
 		/*
@@ -452,139 +471,131 @@ static int blkif_queue_request(struct request *req)
 	id = get_id_from_freelist(info);
 	info->shadow[id].request = req;
 
-	if (unlikely(req->cmd_flags & (REQ_DISCARD | REQ_SECURE))) {
-		ring_req->operation = BLKIF_OP_DISCARD;
-		ring_req->u.discard.nr_sectors = blk_rq_sectors(req);
-		ring_req->u.discard.id = id;
-		ring_req->u.discard.sector_number = (blkif_sector_t)blk_rq_pos(req);
-		if ((req->cmd_flags & REQ_SECURE) && info->feature_secdiscard)
-			ring_req->u.discard.flag = BLKIF_DISCARD_SECURE;
-		else
-			ring_req->u.discard.flag = 0;
+	BUG_ON(info->max_indirect_segments == 0 &&
+	       req->nr_phys_segments > BLKIF_MAX_SEGMENTS_PER_REQUEST);
+	BUG_ON(info->max_indirect_segments &&
+	       req->nr_phys_segments > info->max_indirect_segments);
+	nseg = blk_rq_map_sg(req->q, req, info->shadow[id].sg);
+	ring_req->u.rw.id = id;
+	if (nseg > BLKIF_MAX_SEGMENTS_PER_REQUEST) {
+		/*
+		 * The indirect operation can only be a BLKIF_OP_READ or
+		 * BLKIF_OP_WRITE
+		 */
+		BUG_ON(req->cmd_flags & (REQ_FLUSH | REQ_FUA));
+		ring_req->operation = BLKIF_OP_INDIRECT;
+		ring_req->u.indirect.indirect_op = rq_data_dir(req) ?
+			BLKIF_OP_WRITE : BLKIF_OP_READ;
+		ring_req->u.indirect.sector_number = (blkif_sector_t)blk_rq_pos(req);
+		ring_req->u.indirect.handle = info->handle;
+		ring_req->u.indirect.nr_segments = nseg;
 	} else {
-		BUG_ON(info->max_indirect_segments == 0 &&
-		       req->nr_phys_segments > BLKIF_MAX_SEGMENTS_PER_REQUEST);
-		BUG_ON(info->max_indirect_segments &&
-		       req->nr_phys_segments > info->max_indirect_segments);
-		nseg = blk_rq_map_sg(req->q, req, info->shadow[id].sg);
-		ring_req->u.rw.id = id;
-		if (nseg > BLKIF_MAX_SEGMENTS_PER_REQUEST) {
+		ring_req->u.rw.sector_number = (blkif_sector_t)blk_rq_pos(req);
+		ring_req->u.rw.handle = info->handle;
+		ring_req->operation = rq_data_dir(req) ?
+			BLKIF_OP_WRITE : BLKIF_OP_READ;
+		if (req->cmd_flags & (REQ_FLUSH | REQ_FUA)) {
 			/*
-			 * The indirect operation can only be a BLKIF_OP_READ or
-			 * BLKIF_OP_WRITE
+			 * Ideally we can do an unordered flush-to-disk.
+			 * In case the backend onlysupports barriers, use that.
+			 * A barrier request a superset of FUA, so we can
+			 * implement it the same way.  (It's also a FLUSH+FUA,
+			 * since it is guaranteed ordered WRT previous writes.)
 			 */
-			BUG_ON(req->cmd_flags & (REQ_FLUSH | REQ_FUA));
-			ring_req->operation = BLKIF_OP_INDIRECT;
-			ring_req->u.indirect.indirect_op = rq_data_dir(req) ?
-				BLKIF_OP_WRITE : BLKIF_OP_READ;
-			ring_req->u.indirect.sector_number = (blkif_sector_t)blk_rq_pos(req);
-			ring_req->u.indirect.handle = info->handle;
-			ring_req->u.indirect.nr_segments = nseg;
-		} else {
-			ring_req->u.rw.sector_number = (blkif_sector_t)blk_rq_pos(req);
-			ring_req->u.rw.handle = info->handle;
-			ring_req->operation = rq_data_dir(req) ?
-				BLKIF_OP_WRITE : BLKIF_OP_READ;
-			if (req->cmd_flags & (REQ_FLUSH | REQ_FUA)) {
-				/*
-				 * Ideally we can do an unordered flush-to-disk. In case the
-				 * backend onlysupports barriers, use that. A barrier request
-				 * a superset of FUA, so we can implement it the same
-				 * way.  (It's also a FLUSH+FUA, since it is
-				 * guaranteed ordered WRT previous writes.)
-				 */
-				switch (info->feature_flush &
-					((REQ_FLUSH|REQ_FUA))) {
-				case REQ_FLUSH|REQ_FUA:
-					ring_req->operation =
-						BLKIF_OP_WRITE_BARRIER;
-					break;
-				case REQ_FLUSH:
-					ring_req->operation =
-						BLKIF_OP_FLUSH_DISKCACHE;
-					break;
-				default:
-					ring_req->operation = 0;
-				}
+			switch (info->feature_flush &
+				((REQ_FLUSH|REQ_FUA))) {
+			case REQ_FLUSH|REQ_FUA:
+				ring_req->operation =
+					BLKIF_OP_WRITE_BARRIER;
+				break;
+			case REQ_FLUSH:
+				ring_req->operation =
+					BLKIF_OP_FLUSH_DISKCACHE;
+				break;
+			default:
+				ring_req->operation = 0;
 			}
-			ring_req->u.rw.nr_segments = nseg;
 		}
-		for_each_sg(info->shadow[id].sg, sg, nseg, i) {
-			fsect = sg->offset >> 9;
-			lsect = fsect + (sg->length >> 9) - 1;
+		ring_req->u.rw.nr_segments = nseg;
+	}
+	for_each_sg(info->shadow[id].sg, sg, nseg, i) {
+		fsect = sg->offset >> 9;
+		lsect = fsect + (sg->length >> 9) - 1;
 
-			if ((ring_req->operation == BLKIF_OP_INDIRECT) &&
-			    (i % SEGS_PER_INDIRECT_FRAME == 0)) {
-				unsigned long uninitialized_var(pfn);
+		if ((ring_req->operation == BLKIF_OP_INDIRECT) &&
+		    (i % SEGS_PER_INDIRECT_FRAME == 0)) {
+			unsigned long uninitialized_var(pfn);
 
-				if (segments)
-					kunmap_atomic(segments);
+			if (segments)
+				kunmap_atomic(segments);
 
-				n = i / SEGS_PER_INDIRECT_FRAME;
-				if (!info->feature_persistent) {
-					struct page *indirect_page;
-
-					/* Fetch a pre-allocated page to use for indirect grefs */
-					BUG_ON(list_empty(&info->indirect_pages));
-					indirect_page = list_first_entry(&info->indirect_pages,
-					                                 struct page, lru);
-					list_del(&indirect_page->lru);
-					pfn = page_to_pfn(indirect_page);
-				}
-				gnt_list_entry = get_grant(&gref_head, pfn, info);
-				info->shadow[id].indirect_grants[n] = gnt_list_entry;
-				segments = kmap_atomic(pfn_to_page(gnt_list_entry->pfn));
-				ring_req->u.indirect.indirect_grefs[n] = gnt_list_entry->gref;
+			n = i / SEGS_PER_INDIRECT_FRAME;
+			if (!info->feature_persistent) {
+				struct page *indirect_page;
+
+				/*
+				 * Fetch a pre-allocated page to use for
+				 * indirect grefs
+				 */
+				BUG_ON(list_empty(&info->indirect_pages));
+				indirect_page = list_first_entry(&info->indirect_pages,
+								 struct page, lru);
+				list_del(&indirect_page->lru);
+				pfn = page_to_pfn(indirect_page);
 			}
+			gnt_list_entry = get_grant(&gref_head, pfn, info);
+			info->shadow[id].indirect_grants[n] = gnt_list_entry;
+			segments = kmap_atomic(pfn_to_page(gnt_list_entry->pfn));
+			ring_req->u.indirect.indirect_grefs[n] = gnt_list_entry->gref;
+		}
 
-			gnt_list_entry = get_grant(&gref_head, page_to_pfn(sg_page(sg)), info);
-			ref = gnt_list_entry->gref;
+		gnt_list_entry = get_grant(&gref_head, page_to_pfn(sg_page(sg)), info);
+		ref = gnt_list_entry->gref;
 
-			info->shadow[id].grants_used[i] = gnt_list_entry;
+		info->shadow[id].grants_used[i] = gnt_list_entry;
 
-			if (rq_data_dir(req) && info->feature_persistent) {
-				char *bvec_data;
-				void *shared_data;
+		if (rq_data_dir(req) && info->feature_persistent) {
+			char *bvec_data;
+			void *shared_data;
 
-				BUG_ON(sg->offset + sg->length > PAGE_SIZE);
+			BUG_ON(sg->offset + sg->length > PAGE_SIZE);
 
-				shared_data = kmap_atomic(pfn_to_page(gnt_list_entry->pfn));
-				bvec_data = kmap_atomic(sg_page(sg));
+			shared_data = kmap_atomic(pfn_to_page(gnt_list_entry->pfn));
+			bvec_data = kmap_atomic(sg_page(sg));
 
-				/*
-				 * this does not wipe data stored outside the
-				 * range sg->offset..sg->offset+sg->length.
-				 * Therefore, blkback *could* see data from
-				 * previous requests. This is OK as long as
-				 * persistent grants are shared with just one
-				 * domain. It may need refactoring if this
-				 * changes
-				 */
-				memcpy(shared_data + sg->offset,
-				       bvec_data   + sg->offset,
-				       sg->length);
+			/*
+			 * this does not wipe data stored outside the
+			 * range sg->offset..sg->offset+sg->length.
+			 * Therefore, blkback *could* see data from
+			 * previous requests. This is OK as long as
+			 * persistent grants are shared with just one
+			 * domain. It may need refactoring if this
+			 * changes
+			 */
+			memcpy(shared_data + sg->offset,
+			       bvec_data   + sg->offset,
+			       sg->length);
 
-				kunmap_atomic(bvec_data);
-				kunmap_atomic(shared_data);
-			}
-			if (ring_req->operation != BLKIF_OP_INDIRECT) {
-				ring_req->u.rw.seg[i] =
-						(struct blkif_request_segment) {
-							.gref       = ref,
-							.first_sect = fsect,
-							.last_sect  = lsect };
-			} else {
-				n = i % SEGS_PER_INDIRECT_FRAME;
-				segments[n] =
+			kunmap_atomic(bvec_data);
+			kunmap_atomic(shared_data);
+		}
+		if (ring_req->operation != BLKIF_OP_INDIRECT) {
+			ring_req->u.rw.seg[i] =
 					(struct blkif_request_segment) {
-							.gref       = ref,
-							.first_sect = fsect,
-							.last_sect  = lsect };
-			}
+						.gref       = ref,
+						.first_sect = fsect,
+						.last_sect  = lsect };
+		} else {
+			n = i % SEGS_PER_INDIRECT_FRAME;
+			segments[n] =
+				(struct blkif_request_segment) {
+						.gref       = ref,
+						.first_sect = fsect,
+						.last_sect  = lsect };
 		}
-		if (segments)
-			kunmap_atomic(segments);
 	}
+	if (segments)
+		kunmap_atomic(segments);
 
 	info->ring.req_prod_pvt++;
 
@@ -597,6 +608,24 @@ static int blkif_queue_request(struct request *req)
 	return 0;
 }
 
+/*
+ * Generate a Xen blkfront IO request from a blk layer request.  Reads
+ * and writes are handled as expected.
+ *
+ * @req: a request struct
+ */
+static int blkif_queue_request(struct request *req)
+{
+	struct blkfront_info *info = req->rq_disk->private_data;
+
+	if (unlikely(info->connected != BLKIF_STATE_CONNECTED))
+		return 1;
+
+	if (unlikely(req->cmd_flags & (REQ_DISCARD | REQ_SECURE)))
+		return blkif_queue_discard_req(req);
+	else
+		return blkif_queue_rw_req(req);
+}
 
 static inline void flush_requests(struct blkfront_info *info)
 {
-- 
2.1.4
