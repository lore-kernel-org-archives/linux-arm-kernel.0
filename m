From: julien.grall@citrix.com (Julien Grall)
Date: Thu, 14 May 2015 18:00:58 +0100
Subject: [RFC 18/23] block/xen-blkfront: Make it running on 64KB page
 granularity
In-Reply-To: <1431622863-28575-1-git-send-email-julien.grall@citrix.com>
References: <1431622863-28575-1-git-send-email-julien.grall@citrix.com>
Message-ID: <1431622863-28575-19-git-send-email-julien.grall@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Julien Grall <julien.grall@linaro.org>

The PV block protocol is using 4KB page granularity. The goal of this
patch is to allow a Linux using 64KB page granularity using block
device on a non-modified Xen.

The block API is using segment which should at least be the size of a
Linux page. Therefore, the driver will have to break the page in chunk
of 4K before giving the page to the backend.

Breaking a 64KB segment in 4KB chunk will result to have some chunk with
no data. As the PV protocol always require to have data in the chunk, we
have to count the number of Xen page which will be in use and avoid to
sent empty chunk.

Note that, a pre-defined number of grant is reserved before preparing
the request. This pre-defined number is based on the number and the
maximum size of the segments. If each segment contain a very small
amount of data, the driver may reserve too much grant (16 grant is
reserved per segment with 64KB page granularity).

Futhermore, in the case of persistent grant we allocate one Linux page
per grant although only the 4KB of the page will be effectively use.
This could be improved by share the page with multiple grants.

Signed-off-by: Julien Grall <julien.grall@citrix.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Roger Pau Monn? <roger.pau@citrix.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: David Vrabel <david.vrabel@citrix.com>

---

Improvement such as support 64KB grant is not taken into consideration in
this patch because we have the requirement to run a Linux using 64KB page
on a non-modified Xen.
---
 drivers/block/xen-blkfront.c | 259 ++++++++++++++++++++++++++-----------------
 1 file changed, 156 insertions(+), 103 deletions(-)

diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index 60cf1d6..c6537ed 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -77,6 +77,7 @@ struct blk_shadow {
 	struct grant **grants_used;
 	struct grant **indirect_grants;
 	struct scatterlist *sg;
+	unsigned int num_sg;
 };
 
 struct split_bio {
@@ -98,7 +99,7 @@ static unsigned int xen_blkif_max_segments = 32;
 module_param_named(max, xen_blkif_max_segments, int, S_IRUGO);
 MODULE_PARM_DESC(max, "Maximum amount of segments in indirect requests (default is 32)");
 
-#define BLK_RING_SIZE __CONST_RING_SIZE(blkif, PAGE_SIZE)
+#define BLK_RING_SIZE __CONST_RING_SIZE(blkif, XEN_PAGE_SIZE)
 
 /*
  * We have one of these per vbd, whether ide, scsi or 'other'.  They
@@ -131,6 +132,7 @@ struct blkfront_info
 	unsigned int discard_granularity;
 	unsigned int discard_alignment;
 	unsigned int feature_persistent:1;
+	/* Number of 4K segment handled */
 	unsigned int max_indirect_segments;
 	int is_ready;
 };
@@ -158,10 +160,19 @@ static DEFINE_SPINLOCK(minor_lock);
 
 #define DEV_NAME	"xvd"	/* name in /dev */
 
-#define SEGS_PER_INDIRECT_FRAME \
-	(PAGE_SIZE/sizeof(struct blkif_request_segment))
-#define INDIRECT_GREFS(_segs) \
-	((_segs + SEGS_PER_INDIRECT_FRAME - 1)/SEGS_PER_INDIRECT_FRAME)
+/*
+ * Xen use 4K pages. The guest may use different page size (4K or 64K)
+ * Number of Xen pages per segment
+ */
+#define XEN_PAGES_PER_SEGMENT   (PAGE_SIZE / XEN_PAGE_SIZE)
+
+#define SEGS_PER_INDIRECT_FRAME	\
+	(XEN_PAGE_SIZE/sizeof(struct blkif_request_segment) / XEN_PAGES_PER_SEGMENT)
+#define XEN_PAGES_PER_INDIRECT_FRAME \
+	(XEN_PAGE_SIZE/sizeof(struct blkif_request_segment))
+
+#define INDIRECT_GREFS(_pages) \
+	((_pages + XEN_PAGES_PER_INDIRECT_FRAME - 1)/XEN_PAGES_PER_INDIRECT_FRAME)
 
 static int blkfront_setup_indirect(struct blkfront_info *info);
 
@@ -204,7 +215,7 @@ static int fill_grant_buffer(struct blkfront_info *info, int num)
 				kfree(gnt_list_entry);
 				goto out_of_memory;
 			}
-			gnt_list_entry->pfn = page_to_pfn(granted_page);
+			gnt_list_entry->pfn = xen_page_to_pfn(granted_page);
 		}
 
 		gnt_list_entry->gref = GRANT_INVALID_REF;
@@ -219,7 +230,7 @@ out_of_memory:
 	                         &info->grants, node) {
 		list_del(&gnt_list_entry->node);
 		if (info->feature_persistent)
-			__free_page(pfn_to_page(gnt_list_entry->pfn));
+			__free_page(xen_pfn_to_page(gnt_list_entry->pfn));
 		kfree(gnt_list_entry);
 		i--;
 	}
@@ -389,7 +400,8 @@ static int blkif_queue_request(struct request *req)
 	struct blkif_request *ring_req;
 	unsigned long id;
 	unsigned int fsect, lsect;
-	int i, ref, n;
+	unsigned int shared_off, shared_len, bvec_off, sg_total;
+	int i, ref, n, grant;
 	struct blkif_request_segment *segments = NULL;
 
 	/*
@@ -401,18 +413,19 @@ static int blkif_queue_request(struct request *req)
 	grant_ref_t gref_head;
 	struct grant *gnt_list_entry = NULL;
 	struct scatterlist *sg;
-	int nseg, max_grefs;
+	int nseg, max_grefs, nr_page;
+	unsigned long pfn;
 
 	if (unlikely(info->connected != BLKIF_STATE_CONNECTED))
 		return 1;
 
-	max_grefs = req->nr_phys_segments;
+	max_grefs = req->nr_phys_segments * XEN_PAGES_PER_SEGMENT;
 	if (max_grefs > BLKIF_MAX_SEGMENTS_PER_REQUEST)
 		/*
 		 * If we are using indirect segments we need to account
 		 * for the indirect grefs used in the request.
 		 */
-		max_grefs += INDIRECT_GREFS(req->nr_phys_segments);
+		max_grefs += INDIRECT_GREFS(req->nr_phys_segments * XEN_PAGES_PER_SEGMENT);
 
 	/* Check if we have enough grants to allocate a requests */
 	if (info->persistent_gnts_c < max_grefs) {
@@ -446,12 +459,19 @@ static int blkif_queue_request(struct request *req)
 			ring_req->u.discard.flag = 0;
 	} else {
 		BUG_ON(info->max_indirect_segments == 0 &&
-		       req->nr_phys_segments > BLKIF_MAX_SEGMENTS_PER_REQUEST);
+		       (XEN_PAGES_PER_SEGMENT * req->nr_phys_segments) > BLKIF_MAX_SEGMENTS_PER_REQUEST);
 		BUG_ON(info->max_indirect_segments &&
-		       req->nr_phys_segments > info->max_indirect_segments);
+		       (req->nr_phys_segments * XEN_PAGES_PER_SEGMENT) > info->max_indirect_segments);
 		nseg = blk_rq_map_sg(req->q, req, info->shadow[id].sg);
+		nr_page = 0;
+		/* Calculate the number of Xen pages used */
+		for_each_sg(info->shadow[id].sg, sg, nseg, i) {
+			nr_page += (round_up(sg->offset + sg->length, XEN_PAGE_SIZE) - round_down(sg->offset, XEN_PAGE_SIZE)) >> XEN_PAGE_SHIFT;
+		}
+
 		ring_req->u.rw.id = id;
-		if (nseg > BLKIF_MAX_SEGMENTS_PER_REQUEST) {
+		info->shadow[id].num_sg = nseg;
+		if (nr_page > BLKIF_MAX_SEGMENTS_PER_REQUEST) {
 			/*
 			 * The indirect operation can only be a BLKIF_OP_READ or
 			 * BLKIF_OP_WRITE
@@ -462,7 +482,7 @@ static int blkif_queue_request(struct request *req)
 				BLKIF_OP_WRITE : BLKIF_OP_READ;
 			ring_req->u.indirect.sector_number = (blkif_sector_t)blk_rq_pos(req);
 			ring_req->u.indirect.handle = info->handle;
-			ring_req->u.indirect.nr_segments = nseg;
+			ring_req->u.indirect.nr_segments = nr_page;
 		} else {
 			ring_req->u.rw.sector_number = (blkif_sector_t)blk_rq_pos(req);
 			ring_req->u.rw.handle = info->handle;
@@ -490,79 +510,95 @@ static int blkif_queue_request(struct request *req)
 					ring_req->operation = 0;
 				}
 			}
-			ring_req->u.rw.nr_segments = nseg;
+			ring_req->u.rw.nr_segments = nr_page;
 		}
+		grant = 0;
 		for_each_sg(info->shadow[id].sg, sg, nseg, i) {
-			fsect = sg->offset >> 9;
-			lsect = fsect + (sg->length >> 9) - 1;
-
-			if ((ring_req->operation == BLKIF_OP_INDIRECT) &&
-			    (i % SEGS_PER_INDIRECT_FRAME == 0)) {
-				unsigned long uninitialized_var(pfn);
-
-				if (segments)
-					kunmap_atomic(segments);
-
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
+			sg_total = sg->length;
+			shared_off = xen_offset_in_page(sg->offset);
+			bvec_off = sg->offset;
+			pfn = xen_page_to_pfn(sg_page(sg)) + (sg->offset >> XEN_PAGE_SHIFT);
+
+			while (sg_total != 0) {
+				if ((ring_req->operation == BLKIF_OP_INDIRECT) &&
+				    (grant % XEN_PAGES_PER_INDIRECT_FRAME == 0)) {
+					unsigned long uninitialized_var(pfn);
+
+					if (segments)
+						kunmap_atomic(segments);
+
+					n = grant / XEN_PAGES_PER_INDIRECT_FRAME;
+					if (!info->feature_persistent) {
+						struct page *indirect_page;
+
+						/* Fetch a pre-allocated page to use for indirect grefs */
+						BUG_ON(list_empty(&info->indirect_pages));
+						indirect_page = list_first_entry(&info->indirect_pages,
+						                                 struct page, lru);
+						list_del(&indirect_page->lru);
+						pfn = xen_page_to_pfn(indirect_page);
+					}
+					gnt_list_entry = get_grant(&gref_head, pfn, info);
+					info->shadow[id].indirect_grants[n] = gnt_list_entry;
+					segments = kmap_atomic(xen_pfn_to_page(gnt_list_entry->pfn));
+					ring_req->u.indirect.indirect_grefs[n] = gnt_list_entry->gref;
 				}
-				gnt_list_entry = get_grant(&gref_head, pfn, info);
-				info->shadow[id].indirect_grants[n] = gnt_list_entry;
-				segments = kmap_atomic(pfn_to_page(gnt_list_entry->pfn));
-				ring_req->u.indirect.indirect_grefs[n] = gnt_list_entry->gref;
-			}
 
-			gnt_list_entry = get_grant(&gref_head, page_to_pfn(sg_page(sg)), info);
-			ref = gnt_list_entry->gref;
+				shared_len = min(sg_total, (unsigned)XEN_PAGE_SIZE - shared_off);
 
-			info->shadow[id].grants_used[i] = gnt_list_entry;
 
-			if (rq_data_dir(req) && info->feature_persistent) {
-				char *bvec_data;
-				void *shared_data;
+				gnt_list_entry = get_grant(&gref_head, pfn++, info);
+				ref = gnt_list_entry->gref;
 
-				BUG_ON(sg->offset + sg->length > PAGE_SIZE);
+				info->shadow[id].grants_used[grant] = gnt_list_entry;
 
-				shared_data = kmap_atomic(pfn_to_page(gnt_list_entry->pfn));
-				bvec_data = kmap_atomic(sg_page(sg));
+				if (rq_data_dir(req) && info->feature_persistent) {
+					char *bvec_data;
+					void *shared_data;
 
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
+					BUG_ON(sg->offset + sg->length > PAGE_SIZE);
 
-				kunmap_atomic(bvec_data);
-				kunmap_atomic(shared_data);
-			}
-			if (ring_req->operation != BLKIF_OP_INDIRECT) {
-				ring_req->u.rw.seg[i] =
+					shared_data = kmap_atomic(xen_pfn_to_page(gnt_list_entry->pfn));
+					bvec_data = kmap_atomic(sg_page(sg));
+
+					/*
+					 * this does not wipe data stored outside the
+					 * range sg->offset..sg->offset+sg->length.
+					 * Therefore, blkback *could* see data from
+					 * previous requests. This is OK as long as
+					 * persistent grants are shared with just one
+					 * domain. It may need refactoring if this
+					 * changes
+					 */
+					memcpy(shared_data + shared_off,
+					       bvec_data   + bvec_off,
+					       sg->length);
+
+					kunmap_atomic(bvec_data);
+					kunmap_atomic(shared_data);
+					bvec_off += shared_off;
+				}
+
+				fsect = shared_off >> 9;
+				lsect = fsect + (shared_len >> 9) - 1;
+				if (ring_req->operation != BLKIF_OP_INDIRECT) {
+					ring_req->u.rw.seg[grant] =
+							(struct blkif_request_segment) {
+								.gref       = ref,
+								.first_sect = fsect,
+								.last_sect  = lsect };
+				} else {
+					n = grant % XEN_PAGES_PER_INDIRECT_FRAME;
+					segments[n] =
 						(struct blkif_request_segment) {
-							.gref       = ref,
-							.first_sect = fsect,
-							.last_sect  = lsect };
-			} else {
-				n = i % SEGS_PER_INDIRECT_FRAME;
-				segments[n] =
-					(struct blkif_request_segment) {
-							.gref       = ref,
-							.first_sect = fsect,
-							.last_sect  = lsect };
+								.gref       = ref,
+								.first_sect = fsect,
+								.last_sect  = lsect };
+				}
+
+				sg_total -= shared_len;
+				shared_off = 0;
+				grant++;
 			}
 		}
 		if (segments)
@@ -674,14 +710,14 @@ static int xlvbd_init_blk_queue(struct gendisk *gd, u16 sector_size,
 	/* Hard sector size and max sectors impersonate the equiv. hardware. */
 	blk_queue_logical_block_size(rq, sector_size);
 	blk_queue_physical_block_size(rq, physical_sector_size);
-	blk_queue_max_hw_sectors(rq, (segments * PAGE_SIZE) / 512);
+	blk_queue_max_hw_sectors(rq, (segments * XEN_PAGE_SIZE) / 512);
 
 	/* Each segment in a request is up to an aligned page in size. */
 	blk_queue_segment_boundary(rq, PAGE_SIZE - 1);
 	blk_queue_max_segment_size(rq, PAGE_SIZE);
 
 	/* Ensure a merged request will fit in a single I/O ring slot. */
-	blk_queue_max_segments(rq, segments);
+	blk_queue_max_segments(rq, segments / XEN_PAGES_PER_SEGMENT);
 
 	/* Make sure buffer addresses are sector-aligned. */
 	blk_queue_dma_alignment(rq, 511);
@@ -961,7 +997,7 @@ static void blkif_free(struct blkfront_info *info, int suspend)
 				info->persistent_gnts_c--;
 			}
 			if (info->feature_persistent)
-				__free_page(pfn_to_page(persistent_gnt->pfn));
+				__free_page(xen_pfn_to_page(persistent_gnt->pfn));
 			kfree(persistent_gnt);
 		}
 	}
@@ -996,7 +1032,7 @@ static void blkif_free(struct blkfront_info *info, int suspend)
 			persistent_gnt = info->shadow[i].grants_used[j];
 			gnttab_end_foreign_access(persistent_gnt->gref, 0, 0UL);
 			if (info->feature_persistent)
-				__free_page(pfn_to_page(persistent_gnt->pfn));
+				__free_page(xen_pfn_to_page(persistent_gnt->pfn));
 			kfree(persistent_gnt);
 		}
 
@@ -1010,7 +1046,7 @@ static void blkif_free(struct blkfront_info *info, int suspend)
 		for (j = 0; j < INDIRECT_GREFS(segs); j++) {
 			persistent_gnt = info->shadow[i].indirect_grants[j];
 			gnttab_end_foreign_access(persistent_gnt->gref, 0, 0UL);
-			__free_page(pfn_to_page(persistent_gnt->pfn));
+			__free_page(xen_pfn_to_page(persistent_gnt->pfn));
 			kfree(persistent_gnt);
 		}
 
@@ -1050,26 +1086,42 @@ static void blkif_completion(struct blk_shadow *s, struct blkfront_info *info,
 	struct scatterlist *sg;
 	char *bvec_data;
 	void *shared_data;
-	int nseg;
+	int nseg, nr_page;
+	unsigned int total, bvec_offset, shared_offset, length;
+	unsigned int grant = 0;
 
-	nseg = s->req.operation == BLKIF_OP_INDIRECT ?
+	nr_page = s->req.operation == BLKIF_OP_INDIRECT ?
 		s->req.u.indirect.nr_segments : s->req.u.rw.nr_segments;
+	nseg = s->num_sg;
 
 	if (bret->operation == BLKIF_OP_READ && info->feature_persistent) {
 		for_each_sg(s->sg, sg, nseg, i) {
 			BUG_ON(sg->offset + sg->length > PAGE_SIZE);
-			shared_data = kmap_atomic(
-				pfn_to_page(s->grants_used[i]->pfn));
+
+			bvec_offset = sg->offset;
+			shared_offset = xen_offset_in_page(sg->offset);
 			bvec_data = kmap_atomic(sg_page(sg));
-			memcpy(bvec_data   + sg->offset,
-			       shared_data + sg->offset,
-			       sg->length);
+			total = sg->length;
+
+			while (total != 0) {
+				length = min(total, (unsigned)XEN_PAGE_SIZE + shared_offset);
+				shared_data = kmap_atomic(
+					xen_pfn_to_page(s->grants_used[grant]->pfn));
+				memcpy(bvec_data   + bvec_offset,
+				       shared_data + shared_offset,
+				       length);
+				kunmap_atomic(shared_data);
+
+				shared_offset = 0;
+				bvec_offset += length;
+				total -= length;
+				grant++;
+			}
 			kunmap_atomic(bvec_data);
-			kunmap_atomic(shared_data);
 		}
 	}
 	/* Add the persistent grant into the list of free grants */
-	for (i = 0; i < nseg; i++) {
+	for (i = 0; i < nr_page; i++) {
 		if (gnttab_query_foreign_access(s->grants_used[i]->gref)) {
 			/*
 			 * If the grant is still mapped by the backend (the
@@ -1095,7 +1147,7 @@ static void blkif_completion(struct blk_shadow *s, struct blkfront_info *info,
 		}
 	}
 	if (s->req.operation == BLKIF_OP_INDIRECT) {
-		for (i = 0; i < INDIRECT_GREFS(nseg); i++) {
+		for (i = 0; i < INDIRECT_GREFS(nr_page); i++) {
 			if (gnttab_query_foreign_access(s->indirect_grants[i]->gref)) {
 				if (!info->feature_persistent)
 					pr_alert_ratelimited("backed has not unmapped grant: %u\n",
@@ -1110,7 +1162,7 @@ static void blkif_completion(struct blk_shadow *s, struct blkfront_info *info,
 				 * Add the used indirect page back to the list of
 				 * available pages for indirect grefs.
 				 */
-				indirect_page = pfn_to_page(s->indirect_grants[i]->pfn);
+				indirect_page = xen_pfn_to_page(s->indirect_grants[i]->pfn);
 				list_add(&indirect_page->lru, &info->indirect_pages);
 				s->indirect_grants[i]->gref = GRANT_INVALID_REF;
 				list_add_tail(&s->indirect_grants[i]->node, &info->grants);
@@ -1248,7 +1300,7 @@ static int setup_blkring(struct xenbus_device *dev,
 		return -ENOMEM;
 	}
 	SHARED_RING_INIT(sring);
-	FRONT_RING_INIT(&info->ring, sring, PAGE_SIZE);
+	FRONT_RING_INIT(&info->ring, sring, XEN_PAGE_SIZE);
 
 	err = xenbus_grant_ring(dev, info->ring.sring, 1, &gref);
 	if (err < 0) {
@@ -1562,8 +1614,8 @@ static int blkif_recover(struct blkfront_info *info)
 			atomic_set(&split_bio->pending, pending);
 			split_bio->bio = bio;
 			for (i = 0; i < pending; i++) {
-				offset = (i * segs * PAGE_SIZE) >> 9;
-				size = min((unsigned int)(segs * PAGE_SIZE) >> 9,
+				offset = (i * segs * XEN_PAGE_SIZE) >> 9;
+				size = min((unsigned int)(segs * XEN_PAGE_SIZE) >> 9,
 					   (unsigned int)bio_sectors(bio) - offset);
 				cloned_bio = bio_clone(bio, GFP_NOIO);
 				BUG_ON(cloned_bio == NULL);
@@ -1674,7 +1726,7 @@ static void blkfront_setup_discard(struct blkfront_info *info)
 
 static int blkfront_setup_indirect(struct blkfront_info *info)
 {
-	unsigned int indirect_segments, segs;
+	unsigned int indirect_segments, segs, nr_page;
 	int err, i;
 
 	err = xenbus_gather(XBT_NIL, info->xbdev->otherend,
@@ -1682,14 +1734,15 @@ static int blkfront_setup_indirect(struct blkfront_info *info)
 			    NULL);
 	if (err) {
 		info->max_indirect_segments = 0;
-		segs = BLKIF_MAX_SEGMENTS_PER_REQUEST;
+		nr_page = BLKIF_MAX_SEGMENTS_PER_REQUEST;
 	} else {
 		info->max_indirect_segments = min(indirect_segments,
 						  xen_blkif_max_segments);
-		segs = info->max_indirect_segments;
+	    nr_page = info->max_indirect_segments;
 	}
+	segs = nr_page / XEN_PAGES_PER_SEGMENT;
 
-	err = fill_grant_buffer(info, (segs + INDIRECT_GREFS(segs)) * BLK_RING_SIZE);
+	err = fill_grant_buffer(info, (nr_page + INDIRECT_GREFS(nr_page)) * BLK_RING_SIZE);
 	if (err)
 		goto out_of_memory;
 
@@ -1699,7 +1752,7 @@ static int blkfront_setup_indirect(struct blkfront_info *info)
 		 * grants, we need to allocate a set of pages that can be
 		 * used for mapping indirect grefs
 		 */
-		int num = INDIRECT_GREFS(segs) * BLK_RING_SIZE;
+		int num = INDIRECT_GREFS(nr_page) * BLK_RING_SIZE;
 
 		BUG_ON(!list_empty(&info->indirect_pages));
 		for (i = 0; i < num; i++) {
@@ -1712,13 +1765,13 @@ static int blkfront_setup_indirect(struct blkfront_info *info)
 
 	for (i = 0; i < BLK_RING_SIZE; i++) {
 		info->shadow[i].grants_used = kzalloc(
-			sizeof(info->shadow[i].grants_used[0]) * segs,
+			sizeof(info->shadow[i].grants_used[0]) * nr_page,
 			GFP_NOIO);
 		info->shadow[i].sg = kzalloc(sizeof(info->shadow[i].sg[0]) * segs, GFP_NOIO);
 		if (info->max_indirect_segments)
 			info->shadow[i].indirect_grants = kzalloc(
 				sizeof(info->shadow[i].indirect_grants[0]) *
-				INDIRECT_GREFS(segs),
+				INDIRECT_GREFS(nr_page),
 				GFP_NOIO);
 		if ((info->shadow[i].grants_used == NULL) ||
 			(info->shadow[i].sg == NULL) ||
-- 
2.1.4
