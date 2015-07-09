From: julien.grall@citrix.com (Julien Grall)
Date: Thu, 9 Jul 2015 21:42:27 +0100
Subject: [PATCH v2 15/20] block/xen-blkfront: Make it running on 64KB page
 granularity
In-Reply-To: <1436474552-31789-1-git-send-email-julien.grall@citrix.com>
References: <1436474552-31789-1-git-send-email-julien.grall@citrix.com>
Message-ID: <1436474552-31789-16-git-send-email-julien.grall@citrix.com>
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

    Changes in v2:
        - Use gnttab_foreach_grant to split a Linux page into grant
---
 drivers/block/xen-blkfront.c | 304 ++++++++++++++++++++++++++++---------------
 1 file changed, 198 insertions(+), 106 deletions(-)

diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index 95fd067..644ba76 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -77,6 +77,7 @@ struct blk_shadow {
 	struct grant **grants_used;
 	struct grant **indirect_grants;
 	struct scatterlist *sg;
+	unsigned int num_sg;
 };
 
 struct split_bio {
@@ -106,8 +107,8 @@ static unsigned int xen_blkif_max_ring_order;
 module_param_named(max_ring_page_order, xen_blkif_max_ring_order, int, S_IRUGO);
 MODULE_PARM_DESC(max_ring_page_order, "Maximum order of pages to be used for the shared ring");
 
-#define BLK_RING_SIZE(info) __CONST_RING_SIZE(blkif, PAGE_SIZE * (info)->nr_ring_pages)
-#define BLK_MAX_RING_SIZE __CONST_RING_SIZE(blkif, PAGE_SIZE * XENBUS_MAX_RING_PAGES)
+#define BLK_RING_SIZE(info) __CONST_RING_SIZE(blkif, XEN_PAGE_SIZE * (info)->nr_ring_pages)
+#define BLK_MAX_RING_SIZE __CONST_RING_SIZE(blkif, XEN_PAGE_SIZE * XENBUS_MAX_RING_PAGES)
 /*
  * ring-ref%i i=(-1UL) would take 11 characters + 'ring-ref' is 8, so 19
  * characters are enough. Define to 20 to keep consist with backend.
@@ -146,6 +147,7 @@ struct blkfront_info
 	unsigned int discard_granularity;
 	unsigned int discard_alignment;
 	unsigned int feature_persistent:1;
+	/* Number of 4K segment handled */
 	unsigned int max_indirect_segments;
 	int is_ready;
 };
@@ -173,10 +175,19 @@ static DEFINE_SPINLOCK(minor_lock);
 
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
 
@@ -463,14 +474,100 @@ static int blkif_queue_discard_req(struct request *req)
 	return 0;
 }
 
+struct setup_rw_req {
+	unsigned int grant_idx;
+	struct blkif_request_segment *segments;
+	struct blkfront_info *info;
+	struct blkif_request *ring_req;
+	grant_ref_t gref_head;
+	unsigned int id;
+	/* Only used when persistent grant is used and it's a read request */
+	bool need_copy;
+	unsigned int bvec_off;
+	char *bvec_data;
+};
+
+static void blkif_setup_rw_req_grant(unsigned long mfn, unsigned int offset,
+				     unsigned int *len, void *data)
+{
+	struct setup_rw_req *setup = data;
+	int n, ref;
+	struct grant *gnt_list_entry;
+	unsigned int fsect, lsect;
+	/* Convenient aliases */
+	unsigned int grant_idx = setup->grant_idx;
+	struct blkif_request *ring_req = setup->ring_req;
+	struct blkfront_info *info = setup->info;
+	struct blk_shadow *shadow = &info->shadow[setup->id];
+
+	if ((ring_req->operation == BLKIF_OP_INDIRECT) &&
+	    (grant_idx % XEN_PAGES_PER_INDIRECT_FRAME == 0)) {
+		if (setup->segments)
+			kunmap_atomic(setup->segments);
+
+		n = grant_idx / XEN_PAGES_PER_INDIRECT_FRAME;
+		gnt_list_entry = get_indirect_grant(&setup->gref_head, info);
+		shadow->indirect_grants[n] = gnt_list_entry;
+		setup->segments = kmap_atomic(gnt_list_entry->page);
+		ring_req->u.indirect.indirect_grefs[n] = gnt_list_entry->gref;
+	}
+
+	gnt_list_entry = get_grant(&setup->gref_head, mfn, info);
+	ref = gnt_list_entry->gref;
+	shadow->grants_used[grant_idx] = gnt_list_entry;
+
+	if (setup->need_copy) {
+		void *shared_data;
+
+		shared_data = kmap_atomic(gnt_list_entry->page);
+		/*
+		 * this does not wipe data stored outside the
+		 * range sg->offset..sg->offset+sg->length.
+		 * Therefore, blkback *could* see data from
+		 * previous requests. This is OK as long as
+		 * persistent grants are shared with just one
+		 * domain. It may need refactoring if this
+		 * changes
+		 */
+		memcpy(shared_data + offset,
+		       setup->bvec_data + setup->bvec_off,
+		       *len);
+
+		kunmap_atomic(shared_data);
+		setup->bvec_off += *len;
+	}
+
+	fsect = offset >> 9;
+	lsect = fsect + (*len >> 9) - 1;
+	if (ring_req->operation != BLKIF_OP_INDIRECT) {
+		ring_req->u.rw.seg[grant_idx] =
+			(struct blkif_request_segment) {
+				.gref       = ref,
+				.first_sect = fsect,
+				.last_sect  = lsect };
+	} else {
+		setup->segments[grant_idx % XEN_PAGES_PER_INDIRECT_FRAME] =
+			(struct blkif_request_segment) {
+				.gref       = ref,
+				.first_sect = fsect,
+				.last_sect  = lsect };
+	}
+
+	(setup->grant_idx)++;
+}
+
 static int blkif_queue_rw_req(struct request *req)
 {
 	struct blkfront_info *info = req->rq_disk->private_data;
 	struct blkif_request *ring_req;
 	unsigned long id;
-	unsigned int fsect, lsect;
-	int i, ref, n;
-	struct blkif_request_segment *segments = NULL;
+	int i;
+	struct setup_rw_req setup = {
+		.grant_idx = 0,
+		.segments = NULL,
+		.info = info,
+		.need_copy = rq_data_dir(req) && info->feature_persistent,
+	};
 
 	/*
 	 * Used to store if we are able to queue the request by just using
@@ -478,25 +575,23 @@ static int blkif_queue_rw_req(struct request *req)
 	 * as there are not sufficiently many free.
 	 */
 	bool new_persistent_gnts;
-	grant_ref_t gref_head;
-	struct grant *gnt_list_entry = NULL;
 	struct scatterlist *sg;
-	int nseg, max_grefs;
+	int nseg, max_grefs, nr_page;
 
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
 		new_persistent_gnts = 1;
 		if (gnttab_alloc_grant_references(
 		    max_grefs - info->persistent_gnts_c,
-		    &gref_head) < 0) {
+		    &setup.gref_head) < 0) {
 			gnttab_request_free_callback(
 				&info->callback,
 				blkif_restart_queue_callback,
@@ -513,12 +608,18 @@ static int blkif_queue_rw_req(struct request *req)
 	info->shadow[id].request = req;
 
 	BUG_ON(info->max_indirect_segments == 0 &&
-	       req->nr_phys_segments > BLKIF_MAX_SEGMENTS_PER_REQUEST);
+	       (XEN_PAGES_PER_SEGMENT * req->nr_phys_segments) > BLKIF_MAX_SEGMENTS_PER_REQUEST);
 	BUG_ON(info->max_indirect_segments &&
-	       req->nr_phys_segments > info->max_indirect_segments);
+		(req->nr_phys_segments * XEN_PAGES_PER_SEGMENT) > info->max_indirect_segments);
 	nseg = blk_rq_map_sg(req->q, req, info->shadow[id].sg);
+	nr_page = 0;
+	/* Calculate the number of Xen pages used */
+	for_each_sg(info->shadow[id].sg, sg, nseg, i) {
+		nr_page += (round_up(sg->offset + sg->length, XEN_PAGE_SIZE) - round_down(sg->offset, XEN_PAGE_SIZE)) >> XEN_PAGE_SHIFT;
+	}
 	ring_req->u.rw.id = id;
-	if (nseg > BLKIF_MAX_SEGMENTS_PER_REQUEST) {
+	info->shadow[id].num_sg = nseg;
+	if (nr_page > BLKIF_MAX_SEGMENTS_PER_REQUEST) {
 		/*
 		 * The indirect operation can only be a BLKIF_OP_READ or
 		 * BLKIF_OP_WRITE
@@ -529,7 +630,7 @@ static int blkif_queue_rw_req(struct request *req)
 			BLKIF_OP_WRITE : BLKIF_OP_READ;
 		ring_req->u.indirect.sector_number = (blkif_sector_t)blk_rq_pos(req);
 		ring_req->u.indirect.handle = info->handle;
-		ring_req->u.indirect.nr_segments = nseg;
+		ring_req->u.indirect.nr_segments = nr_page;
 	} else {
 		ring_req->u.rw.sector_number = (blkif_sector_t)blk_rq_pos(req);
 		ring_req->u.rw.handle = info->handle;
@@ -557,73 +658,30 @@ static int blkif_queue_rw_req(struct request *req)
 				ring_req->operation = 0;
 			}
 		}
-		ring_req->u.rw.nr_segments = nseg;
+		ring_req->u.rw.nr_segments = nr_page;
 	}
-	for_each_sg(info->shadow[id].sg, sg, nseg, i) {
-		fsect = sg->offset >> 9;
-		lsect = fsect + (sg->length >> 9) - 1;
-
-		if ((ring_req->operation == BLKIF_OP_INDIRECT) &&
-		    (i % SEGS_PER_INDIRECT_FRAME == 0)) {
-			if (segments)
-				kunmap_atomic(segments);
-
-			n = i / SEGS_PER_INDIRECT_FRAME;
-			gnt_list_entry = get_indirect_grant(&gref_head, info);
-			info->shadow[id].indirect_grants[n] = gnt_list_entry;
-			segments = kmap_atomic(gnt_list_entry->page);
-			ring_req->u.indirect.indirect_grefs[n] = gnt_list_entry->gref;
-		}
 
-		gnt_list_entry = get_grant(&gref_head,
-					   page_to_mfn(sg_page(sg)),
-					   info);
-		ref = gnt_list_entry->gref;
-
-		info->shadow[id].grants_used[i] = gnt_list_entry;
-
-		if (rq_data_dir(req) && info->feature_persistent) {
-			char *bvec_data;
-			void *shared_data;
-
-			BUG_ON(sg->offset + sg->length > PAGE_SIZE);
+	setup.ring_req = ring_req;
+	setup.id = id;
+	for_each_sg(info->shadow[id].sg, sg, nseg, i) {
+		BUG_ON(sg->offset + sg->length > PAGE_SIZE);
 
-			shared_data = kmap_atomic(gnt_list_entry->page);
-			bvec_data = kmap_atomic(sg_page(sg));
+		if (setup.need_copy) {
+			setup.bvec_off = sg->offset;
+			setup.bvec_data = kmap_atomic(sg_page(sg));
+		}
 
-			/*
-			 * this does not wipe data stored outside the
-			 * range sg->offset..sg->offset+sg->length.
-			 * Therefore, blkback *could* see data from
-			 * previous requests. This is OK as long as
-			 * persistent grants are shared with just one
-			 * domain. It may need refactoring if this
-			 * changes
-			 */
-			memcpy(shared_data + sg->offset,
-			       bvec_data   + sg->offset,
-			       sg->length);
+		gnttab_foreach_grant(sg_page(sg),
+				     sg->offset,
+				     sg->length,
+				     blkif_setup_rw_req_grant,
+				     &setup);
 
-			kunmap_atomic(bvec_data);
-			kunmap_atomic(shared_data);
-		}
-		if (ring_req->operation != BLKIF_OP_INDIRECT) {
-			ring_req->u.rw.seg[i] =
-					(struct blkif_request_segment) {
-						.gref       = ref,
-						.first_sect = fsect,
-						.last_sect  = lsect };
-		} else {
-			n = i % SEGS_PER_INDIRECT_FRAME;
-			segments[n] =
-				(struct blkif_request_segment) {
-						.gref       = ref,
-						.first_sect = fsect,
-						.last_sect  = lsect };
-		}
+		if (setup.need_copy)
+			kunmap_atomic(setup.bvec_data);
 	}
-	if (segments)
-		kunmap_atomic(segments);
+	if (setup.segments)
+		kunmap_atomic(setup.segments);
 
 	info->ring.req_prod_pvt++;
 
@@ -631,7 +689,7 @@ static int blkif_queue_rw_req(struct request *req)
 	info->shadow[id].req = *ring_req;
 
 	if (new_persistent_gnts)
-		gnttab_free_grant_references(gref_head);
+		gnttab_free_grant_references(setup.gref_head);
 
 	return 0;
 }
@@ -748,14 +806,14 @@ static int xlvbd_init_blk_queue(struct gendisk *gd, u16 sector_size,
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
@@ -1120,32 +1178,65 @@ free_shadow:
 
 }
 
+struct copy_from_grant {
+	const struct blk_shadow *s;
+	unsigned int grant_idx;
+	unsigned int bvec_offset;
+	char *bvec_data;
+};
+
+static void blkif_copy_from_grant(unsigned long mfn, unsigned int offset,
+				  unsigned int *len, void *data)
+{
+	struct copy_from_grant *info = data;
+	char *shared_data;
+	/* Convenient aliases */
+	const struct blk_shadow *s = info->s;
+
+	shared_data = kmap_atomic(s->grants_used[info->grant_idx]->page);
+
+	memcpy(info->bvec_data + info->bvec_offset,
+	       shared_data + offset, *len);
+
+	info->bvec_offset += *len;
+	info->grant_idx++;
+
+	kunmap_atomic(shared_data);
+}
+
 static void blkif_completion(struct blk_shadow *s, struct blkfront_info *info,
 			     struct blkif_response *bret)
 {
 	int i = 0;
 	struct scatterlist *sg;
-	char *bvec_data;
-	void *shared_data;
-	int nseg;
+	int nseg, nr_page;
+	struct copy_from_grant data = {
+		.s = s,
+		.grant_idx = 0,
+	};
 
-	nseg = s->req.operation == BLKIF_OP_INDIRECT ?
+	nr_page = s->req.operation == BLKIF_OP_INDIRECT ?
 		s->req.u.indirect.nr_segments : s->req.u.rw.nr_segments;
+	nseg = s->num_sg;
 
 	if (bret->operation == BLKIF_OP_READ && info->feature_persistent) {
 		for_each_sg(s->sg, sg, nseg, i) {
 			BUG_ON(sg->offset + sg->length > PAGE_SIZE);
-			shared_data = kmap_atomic(s->grants_used[i]->page);
-			bvec_data = kmap_atomic(sg_page(sg));
-			memcpy(bvec_data   + sg->offset,
-			       shared_data + sg->offset,
-			       sg->length);
-			kunmap_atomic(bvec_data);
-			kunmap_atomic(shared_data);
+
+			data.bvec_offset = sg->offset;
+			data.bvec_data = kmap_atomic(sg_page(sg));
+
+			gnttab_foreach_grant(sg_page(sg),
+					     sg->offset,
+					     sg->length,
+					     blkif_copy_from_grant,
+					     &data);
+
+			kunmap_atomic(data.bvec_data);
 		}
 	}
 	/* Add the persistent grant into the list of free grants */
-	for (i = 0; i < nseg; i++) {
+	for (i = 0; i < nr_page; i++) {
 		if (gnttab_query_foreign_access(s->grants_used[i]->gref)) {
 			/*
 			 * If the grant is still mapped by the backend (the
@@ -1171,7 +1262,7 @@ static void blkif_completion(struct blk_shadow *s, struct blkfront_info *info,
 		}
 	}
 	if (s->req.operation == BLKIF_OP_INDIRECT) {
-		for (i = 0; i < INDIRECT_GREFS(nseg); i++) {
+		for (i = 0; i < INDIRECT_GREFS(nr_page); i++) {
 			if (gnttab_query_foreign_access(s->indirect_grants[i]->gref)) {
 				if (!info->feature_persistent)
 					pr_alert_ratelimited("backed has not unmapped grant: %u\n",
@@ -1314,7 +1405,7 @@ static int setup_blkring(struct xenbus_device *dev,
 {
 	struct blkif_sring *sring;
 	int err, i;
-	unsigned long ring_size = info->nr_ring_pages * PAGE_SIZE;
+	unsigned long ring_size = info->nr_ring_pages * XEN_PAGE_SIZE;
 	grant_ref_t gref[XENBUS_MAX_RING_PAGES];
 
 	for (i = 0; i < info->nr_ring_pages; i++)
@@ -1666,8 +1757,8 @@ static int blkif_recover(struct blkfront_info *info)
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
@@ -1778,7 +1869,7 @@ static void blkfront_setup_discard(struct blkfront_info *info)
 
 static int blkfront_setup_indirect(struct blkfront_info *info)
 {
-	unsigned int indirect_segments, segs;
+	unsigned int indirect_segments, segs, nr_page;
 	int err, i;
 
 	err = xenbus_gather(XBT_NIL, info->xbdev->otherend,
@@ -1786,14 +1877,15 @@ static int blkfront_setup_indirect(struct blkfront_info *info)
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
 
-	err = fill_grant_buffer(info, (segs + INDIRECT_GREFS(segs)) * BLK_RING_SIZE(info));
+	err = fill_grant_buffer(info, (nr_page + INDIRECT_GREFS(nr_page)) * BLK_RING_SIZE(info));
 	if (err)
 		goto out_of_memory;
 
@@ -1803,7 +1895,7 @@ static int blkfront_setup_indirect(struct blkfront_info *info)
 		 * grants, we need to allocate a set of pages that can be
 		 * used for mapping indirect grefs
 		 */
-		int num = INDIRECT_GREFS(segs) * BLK_RING_SIZE(info);
+		int num = INDIRECT_GREFS(nr_page) * BLK_RING_SIZE(info);
 
 		BUG_ON(!list_empty(&info->indirect_pages));
 		for (i = 0; i < num; i++) {
@@ -1816,13 +1908,13 @@ static int blkfront_setup_indirect(struct blkfront_info *info)
 
 	for (i = 0; i < BLK_RING_SIZE(info); i++) {
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
