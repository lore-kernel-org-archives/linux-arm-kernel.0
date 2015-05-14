From: julien.grall@citrix.com (Julien Grall)
Date: Thu, 14 May 2015 18:00:46 +0100
Subject: [RFC 06/23] block/xen-blkback: s/nr_pages/nr_segs/
In-Reply-To: <1431622863-28575-1-git-send-email-julien.grall@citrix.com>
References: <1431622863-28575-1-git-send-email-julien.grall@citrix.com>
Message-ID: <1431622863-28575-7-git-send-email-julien.grall@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Julien Grall <julien.grall@linaro.org>

Make the code less confusing to read now that Linux may not have the
same page size as Xen.

Signed-off-by: Julien Grall <julien.grall@citrix.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Roger Pau Monn? <roger.pau@citrix.com>
---
 drivers/block/xen-blkback/blkback.c | 10 +++++-----
 drivers/block/xen-blkback/common.h  |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/block/xen-blkback/blkback.c b/drivers/block/xen-blkback/blkback.c
index 713fc9f..7049528 100644
--- a/drivers/block/xen-blkback/blkback.c
+++ b/drivers/block/xen-blkback/blkback.c
@@ -729,7 +729,7 @@ static void xen_blkbk_unmap_and_respond(struct pending_req *req)
 	struct grant_page **pages = req->segments;
 	unsigned int invcount;
 
-	invcount = xen_blkbk_unmap_prepare(blkif, pages, req->nr_pages,
+	invcount = xen_blkbk_unmap_prepare(blkif, pages, req->nr_segs,
 					   req->unmap, req->unmap_pages);
 
 	work->data = req;
@@ -915,7 +915,7 @@ static int xen_blkbk_map_seg(struct pending_req *pending_req)
 	int rc;
 
 	rc = xen_blkbk_map(pending_req->blkif, pending_req->segments,
-			   pending_req->nr_pages,
+			   pending_req->nr_segs,
 	                   (pending_req->operation != BLKIF_OP_READ));
 
 	return rc;
@@ -931,7 +931,7 @@ static int xen_blkbk_parse_indirect(struct blkif_request *req,
 	int indirect_grefs, rc, n, nseg, i;
 	struct blkif_request_segment *segments = NULL;
 
-	nseg = pending_req->nr_pages;
+	nseg = pending_req->nr_segs;
 	indirect_grefs = INDIRECT_PAGES(nseg);
 	BUG_ON(indirect_grefs > BLKIF_MAX_INDIRECT_PAGES_PER_REQUEST);
 
@@ -1251,7 +1251,7 @@ static int dispatch_rw_block_io(struct xen_blkif *blkif,
 	pending_req->id        = req->u.rw.id;
 	pending_req->operation = req_operation;
 	pending_req->status    = BLKIF_RSP_OKAY;
-	pending_req->nr_pages  = nseg;
+	pending_req->nr_segs   = nseg;
 
 	if (req->operation != BLKIF_OP_INDIRECT) {
 		preq.dev               = req->u.rw.handle;
@@ -1372,7 +1372,7 @@ static int dispatch_rw_block_io(struct xen_blkif *blkif,
 
  fail_flush:
 	xen_blkbk_unmap(blkif, pending_req->segments,
-	                pending_req->nr_pages);
+	                pending_req->nr_segs);
  fail_response:
 	/* Haven't submitted any bio's yet. */
 	make_response(blkif, req->u.rw.id, req_operation, BLKIF_RSP_ERROR);
diff --git a/drivers/block/xen-blkback/common.h b/drivers/block/xen-blkback/common.h
index f620b5d..7a03e07 100644
--- a/drivers/block/xen-blkback/common.h
+++ b/drivers/block/xen-blkback/common.h
@@ -343,7 +343,7 @@ struct grant_page {
 struct pending_req {
 	struct xen_blkif	*blkif;
 	u64			id;
-	int			nr_pages;
+	int			nr_segs;
 	atomic_t		pendcnt;
 	unsigned short		operation;
 	int			status;
-- 
2.1.4
