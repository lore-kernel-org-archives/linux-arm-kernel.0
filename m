From: julien.grall@citrix.com (Julien Grall)
Date: Wed, 30 Sep 2015 11:45:30 +0100
Subject: [PATCH v5 15/22] block/xen-blkfront: Make it running on 64KB page
 granularity
In-Reply-To: <1443609937-25278-1-git-send-email-julien.grall@citrix.com>
References: <1443609937-25278-1-git-send-email-julien.grall@citrix.com>
Message-ID: <1443609937-25278-16-git-send-email-julien.grall@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PV block protocol is using 4KB page granularity. The goal of this
patch is to allow a Linux using 64KB page granularity using block
device on a non-modified Xen.

The block API is using segment which should at least be the size of a
Linux page. Therefore, the driver will have to break the page in chunk
of 4K before giving the page to the backend.

When breaking a 64KB segment in 4KB chunks, it is possible that some
chunks are empty. As the PV protocol always require to have data in the
chunk, we have to count the number of Xen page which will be in use and
avoid sending empty chunks.

Note that, a pre-defined number of grants are reserved before preparing
the request. This pre-defined number is based on the number and the
maximum size of the segments. If each segment contains a very small
amount of data, the driver may reserve too many grants (16 grants is
reserved per segment with 64KB page granularity).

Furthermore, in the case of persistent grants we allocate one Linux page
per grant although only the first 4KB of the page will be effectively
in use. This could be improved by sharing the page with multiple grants.

Signed-off-by: Julien Grall <julien.grall@citrix.com>
Acked-by: Roger Pau Monn? <roger.pau@citrix.com>

---
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: David Vrabel <david.vrabel@citrix.com>

Improvement such as support 64KB grant is not taken into consideration in
this patch because we have the requirement to run a Linux using 64KB page
on a non-modified Xen.

    Changes in v4:
        - Rebase after d50babbe300eedf33ea5b00a12c5df3a05bd96c7 "
        xen-blkfront: introduce blkfront_gather_backend_features()"
        - Fix typoes
        - Add Roger's acked-by

    Changes in v3:
        - Use DIV_ROUND_UP in INDIRECT_GREFS
        - Split lines over 80 characters whenever it's possible
        - s/mfn/gfn/ based on the new naming
        - The grant callback doesn't allow anymore to change the len
        (wasn't used here).
        - gnttab_foreach_grant has been renamed to gnttab_foreach_grant_in_range
        - Use gnttab_count_grant to get the number of grants in a sg
        - Do some renaming to use the correct variable every time

    Changes in v2:
        - Use gnttab_foreach_grant to split a Linux page into grant
---
 drivers/block/xen-blkfront.c | 324 ++++++++++++++++++++++++++++---------------
 1 file changed, 213 insertions(+), 111 deletions(-)

diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index ff96efc..43cda94 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -78,6 +78,7 @@ struct blk_shadow {
 	struct grant **grants_used;
 	struct grant **indirect_grants;
 	struct scatterlist *sg;
+	unsigned int num_sg;
 };
 
 struct split_bio {
@@ -106,8 +107,12 @@ static unsigned int xen_blkif_max_ring_order;
 module_param_named(max_ring_page_order, xen_blkif_max_ring_order, int, S_IRUGO);
 MODULE_PARM_DESC(max_ring_page_order, "Maximum order of pages to be used for the shared ring");
 
-#define BLK_RING_SIZE(info) __CONST_RING_SIZE(blkif, PAGE_SIZE * (info)->nr_ring_pages)
-#define BLK_MAX_RING_SIZE __CONST_RING_SIZE(blkif, PAGE_SIZE * XENBUS_MAX_RING_PAGES)
+#define BLK_RING_SIZE(info)	\
+	__CONST_RING_SIZE(blkif, XEN_PAGE_SIZE * (info)->nr_ring_pages)
+
+#define BLK_MAX_RING_SIZE	\
+	__CONST_RING_SIZE(blkif, XEN_PAGE_SIZE * XENBUS_MAX_RING_PAGES)
+
 /*
  * ring-ref%i i=(-1UL) would take 11 characters + 'ring-ref' is 8, so 19
  * characters are enough. Define to 20 to keep consist with backend.
@@ -146,6 +151,7 @@ struct blkfront_info
 	unsigned int discard_granularity;
 	unsigned int discard_alignment;
 	unsigned int feature_persistent:1;
+	/* Number of 4KB segments handled */
 	unsigned int max_indirect_segments;
 	int is_ready;
 	struct blk_mq_tag_set tag_set;
@@ -174,10 +180,23 @@ static DEFINE_SPINLOCK(minor_lock);
 
 #define DEV_NAME	"xvd"	/* name in /dev */
 
-#define SEGS_PER_INDIRECT_FRAME \
-	(PAGE_SIZE/sizeof(struct blkif_request_segment))
-#define INDIRECT_GREFS(_segs) \
-	((_segs + SEGS_PER_INDIRECT_FRAME - 1)/SEGS_PER_INDIRECT_FRAME)
+/*
+ * Grants are always the same size as a Xen page (i.e 4KB).
+ * A physical segment is always the same size as a Linux page.
+ * Number of grants per physical segment
+ */
+#define GRANTS_PER_PSEG	(PAGE_SIZE / XEN_PAGE_SIZE)
+
+#define GRANTS_PER_INDIRECT_FRAME \
+	(XEN_PAGE_SIZE / sizeof(struct blkif_request_segment))
+
+#define PSEGS_PER_INDIRECT_FRAME	\
+	(GRANTS_INDIRECT_FRAME / GRANTS_PSEGS)
+
+#define INDIRECT_GREFS(_grants)		\
+	DIV_ROUND_UP(_grants, GRANTS_PER_INDIRECT_FRAME)
+
+#define GREFS(_psegs)	((_psegs) * GRANTS_PER_PSEG)
 
 static int blkfront_setup_indirect(struct blkfront_info *info);
 static int blkfront_gather_backend_features(struct blkfront_info *info);
@@ -465,14 +484,100 @@ static int blkif_queue_discard_req(struct request *req)
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
+static void blkif_setup_rw_req_grant(unsigned long gfn, unsigned int offset,
+				     unsigned int len, void *data)
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
+	    (grant_idx % GRANTS_PER_INDIRECT_FRAME == 0)) {
+		if (setup->segments)
+			kunmap_atomic(setup->segments);
+
+		n = grant_idx / GRANTS_PER_INDIRECT_FRAME;
+		gnt_list_entry = get_indirect_grant(&setup->gref_head, info);
+		shadow->indirect_grants[n] = gnt_list_entry;
+		setup->segments = kmap_atomic(gnt_list_entry->page);
+		ring_req->u.indirect.indirect_grefs[n] = gnt_list_entry->gref;
+	}
+
+	gnt_list_entry = get_grant(&setup->gref_head, gfn, info);
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
+		       len);
+
+		kunmap_atomic(shared_data);
+		setup->bvec_off += len;
+	}
+
+	fsect = offset >> 9;
+	lsect = fsect + (len >> 9) - 1;
+	if (ring_req->operation != BLKIF_OP_INDIRECT) {
+		ring_req->u.rw.seg[grant_idx] =
+			(struct blkif_request_segment) {
+				.gref       = ref,
+				.first_sect = fsect,
+				.last_sect  = lsect };
+	} else {
+		setup->segments[grant_idx % GRANTS_PER_INDIRECT_FRAME] =
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
@@ -480,25 +585,23 @@ static int blkif_queue_rw_req(struct request *req)
 	 * as there are not sufficiently many free.
 	 */
 	bool new_persistent_gnts;
-	grant_ref_t gref_head;
-	struct grant *gnt_list_entry = NULL;
 	struct scatterlist *sg;
-	int nseg, max_grefs;
+	int num_sg, max_grefs, num_grant;
 
-	max_grefs = req->nr_phys_segments;
+	max_grefs = req->nr_phys_segments * GRANTS_PER_PSEG;
 	if (max_grefs > BLKIF_MAX_SEGMENTS_PER_REQUEST)
 		/*
 		 * If we are using indirect segments we need to account
 		 * for the indirect grefs used in the request.
 		 */
-		max_grefs += INDIRECT_GREFS(req->nr_phys_segments);
+		max_grefs += INDIRECT_GREFS(max_grefs);
 
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
@@ -515,12 +618,19 @@ static int blkif_queue_rw_req(struct request *req)
 	info->shadow[id].request = req;
 
 	BUG_ON(info->max_indirect_segments == 0 &&
-	       req->nr_phys_segments > BLKIF_MAX_SEGMENTS_PER_REQUEST);
+	       GREFS(req->nr_phys_segments) > BLKIF_MAX_SEGMENTS_PER_REQUEST);
 	BUG_ON(info->max_indirect_segments &&
-	       req->nr_phys_segments > info->max_indirect_segments);
-	nseg = blk_rq_map_sg(req->q, req, info->shadow[id].sg);
+	       GREFS(req->nr_phys_segments) > info->max_indirect_segments);
+
+	num_sg = blk_rq_map_sg(req->q, req, info->shadow[id].sg);
+	num_grant = 0;
+	/* Calculate the number of grant used */
+	for_each_sg(info->shadow[id].sg, sg, num_sg, i)
+	       num_grant += gnttab_count_grant(sg->offset, sg->length);
+
 	ring_req->u.rw.id = id;
-	if (nseg > BLKIF_MAX_SEGMENTS_PER_REQUEST) {
+	info->shadow[id].num_sg = num_sg;
+	if (num_grant > BLKIF_MAX_SEGMENTS_PER_REQUEST) {
 		/*
 		 * The indirect operation can only be a BLKIF_OP_READ or
 		 * BLKIF_OP_WRITE
@@ -531,7 +641,7 @@ static int blkif_queue_rw_req(struct request *req)
 			BLKIF_OP_WRITE : BLKIF_OP_READ;
 		ring_req->u.indirect.sector_number = (blkif_sector_t)blk_rq_pos(req);
 		ring_req->u.indirect.handle = info->handle;
-		ring_req->u.indirect.nr_segments = nseg;
+		ring_req->u.indirect.nr_segments = num_grant;
 	} else {
 		ring_req->u.rw.sector_number = (blkif_sector_t)blk_rq_pos(req);
 		ring_req->u.rw.handle = info->handle;
@@ -559,73 +669,30 @@ static int blkif_queue_rw_req(struct request *req)
 				ring_req->operation = 0;
 			}
 		}
-		ring_req->u.rw.nr_segments = nseg;
-	}
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
-
-		gnt_list_entry = get_grant(&gref_head,
-					   xen_page_to_gfn(sg_page(sg)),
-					   info);
-		ref = gnt_list_entry->gref;
-
-		info->shadow[id].grants_used[i] = gnt_list_entry;
-
-		if (rq_data_dir(req) && info->feature_persistent) {
-			char *bvec_data;
-			void *shared_data;
+		ring_req->u.rw.nr_segments = num_grant;
+	}
 
-			BUG_ON(sg->offset + sg->length > PAGE_SIZE);
+	setup.ring_req = ring_req;
+	setup.id = id;
+	for_each_sg(info->shadow[id].sg, sg, num_sg, i) {
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
+		gnttab_foreach_grant_in_range(sg_page(sg),
+					      sg->offset,
+					      sg->length,
+					      blkif_setup_rw_req_grant,
+					      &setup);
 
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
 
@@ -633,7 +700,7 @@ static int blkif_queue_rw_req(struct request *req)
 	info->shadow[id].req = *ring_req;
 
 	if (new_persistent_gnts)
-		gnttab_free_grant_references(gref_head);
+		gnttab_free_grant_references(setup.gref_head);
 
 	return 0;
 }
@@ -750,14 +817,14 @@ static int xlvbd_init_blk_queue(struct gendisk *gd, u16 sector_size,
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
+	blk_queue_max_segments(rq, segments / GRANTS_PER_PSEG);
 
 	/* Make sure buffer addresses are sector-aligned. */
 	blk_queue_dma_alignment(rq, 511);
@@ -1116,32 +1183,65 @@ free_shadow:
 
 }
 
+struct copy_from_grant {
+	const struct blk_shadow *s;
+	unsigned int grant_idx;
+	unsigned int bvec_offset;
+	char *bvec_data;
+};
+
+static void blkif_copy_from_grant(unsigned long gfn, unsigned int offset,
+				  unsigned int len, void *data)
+{
+	struct copy_from_grant *info = data;
+	char *shared_data;
+	/* Convenient aliases */
+	const struct blk_shadow *s = info->s;
+
+	shared_data = kmap_atomic(s->grants_used[info->grant_idx]->page);
+
+	memcpy(info->bvec_data + info->bvec_offset,
+	       shared_data + offset, len);
+
+	info->bvec_offset += len;
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
+	int num_sg, num_grant;
+	struct copy_from_grant data = {
+		.s = s,
+		.grant_idx = 0,
+	};
 
-	nseg = s->req.operation == BLKIF_OP_INDIRECT ?
+	num_grant = s->req.operation == BLKIF_OP_INDIRECT ?
 		s->req.u.indirect.nr_segments : s->req.u.rw.nr_segments;
+	num_sg = s->num_sg;
 
 	if (bret->operation == BLKIF_OP_READ && info->feature_persistent) {
-		for_each_sg(s->sg, sg, nseg, i) {
+		for_each_sg(s->sg, sg, num_sg, i) {
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
+			gnttab_foreach_grant_in_range(sg_page(sg),
+						      sg->offset,
+						      sg->length,
+						      blkif_copy_from_grant,
+						      &data);
+
+			kunmap_atomic(data.bvec_data);
 		}
 	}
 	/* Add the persistent grant into the list of free grants */
-	for (i = 0; i < nseg; i++) {
+	for (i = 0; i < num_grant; i++) {
 		if (gnttab_query_foreign_access(s->grants_used[i]->gref)) {
 			/*
 			 * If the grant is still mapped by the backend (the
@@ -1167,7 +1267,7 @@ static void blkif_completion(struct blk_shadow *s, struct blkfront_info *info,
 		}
 	}
 	if (s->req.operation == BLKIF_OP_INDIRECT) {
-		for (i = 0; i < INDIRECT_GREFS(nseg); i++) {
+		for (i = 0; i < INDIRECT_GREFS(num_grant); i++) {
 			if (gnttab_query_foreign_access(s->indirect_grants[i]->gref)) {
 				if (!info->feature_persistent)
 					pr_alert_ratelimited("backed has not unmapped grant: %u\n",
@@ -1311,7 +1411,7 @@ static int setup_blkring(struct xenbus_device *dev,
 {
 	struct blkif_sring *sring;
 	int err, i;
-	unsigned long ring_size = info->nr_ring_pages * PAGE_SIZE;
+	unsigned long ring_size = info->nr_ring_pages * XEN_PAGE_SIZE;
 	grant_ref_t gref[XENBUS_MAX_RING_PAGES];
 
 	for (i = 0; i < info->nr_ring_pages; i++)
@@ -1640,8 +1740,8 @@ static int blkif_recover(struct blkfront_info *info)
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
@@ -1752,15 +1852,17 @@ static void blkfront_setup_discard(struct blkfront_info *info)
 
 static int blkfront_setup_indirect(struct blkfront_info *info)
 {
-	unsigned int segs;
+	unsigned int psegs, grants;
 	int err, i;
 
 	if (info->max_indirect_segments == 0)
-		segs = BLKIF_MAX_SEGMENTS_PER_REQUEST;
+		grants = BLKIF_MAX_SEGMENTS_PER_REQUEST;
 	else
-		segs = info->max_indirect_segments;
+		grants = info->max_indirect_segments;
+	psegs = grants / GRANTS_PER_PSEG;
 
-	err = fill_grant_buffer(info, (segs + INDIRECT_GREFS(segs)) * BLK_RING_SIZE(info));
+	err = fill_grant_buffer(info,
+				(grants + INDIRECT_GREFS(grants)) * BLK_RING_SIZE(info));
 	if (err)
 		goto out_of_memory;
 
@@ -1770,7 +1872,7 @@ static int blkfront_setup_indirect(struct blkfront_info *info)
 		 * grants, we need to allocate a set of pages that can be
 		 * used for mapping indirect grefs
 		 */
-		int num = INDIRECT_GREFS(segs) * BLK_RING_SIZE(info);
+		int num = INDIRECT_GREFS(grants) * BLK_RING_SIZE(info);
 
 		BUG_ON(!list_empty(&info->indirect_pages));
 		for (i = 0; i < num; i++) {
@@ -1783,20 +1885,20 @@ static int blkfront_setup_indirect(struct blkfront_info *info)
 
 	for (i = 0; i < BLK_RING_SIZE(info); i++) {
 		info->shadow[i].grants_used = kzalloc(
-			sizeof(info->shadow[i].grants_used[0]) * segs,
+			sizeof(info->shadow[i].grants_used[0]) * grants,
 			GFP_NOIO);
-		info->shadow[i].sg = kzalloc(sizeof(info->shadow[i].sg[0]) * segs, GFP_NOIO);
+		info->shadow[i].sg = kzalloc(sizeof(info->shadow[i].sg[0]) * psegs, GFP_NOIO);
 		if (info->max_indirect_segments)
 			info->shadow[i].indirect_grants = kzalloc(
 				sizeof(info->shadow[i].indirect_grants[0]) *
-				INDIRECT_GREFS(segs),
+				INDIRECT_GREFS(grants),
 				GFP_NOIO);
 		if ((info->shadow[i].grants_used == NULL) ||
 			(info->shadow[i].sg == NULL) ||
 		     (info->max_indirect_segments &&
 		     (info->shadow[i].indirect_grants == NULL)))
 			goto out_of_memory;
-		sg_init_table(info->shadow[i].sg, segs);
+		sg_init_table(info->shadow[i].sg, psegs);
 	}
 
 
-- 
2.1.4
