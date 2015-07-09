From: julien.grall@citrix.com (Julien Grall)
Date: Thu, 9 Jul 2015 21:42:28 +0100
Subject: [PATCH v2 16/20] block/xen-blkback: Make it running on 64KB page
 granularity
In-Reply-To: <1436474552-31789-1-git-send-email-julien.grall@citrix.com>
References: <1436474552-31789-1-git-send-email-julien.grall@citrix.com>
Message-ID: <1436474552-31789-17-git-send-email-julien.grall@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PV block protocol is using 4KB page granularity. The goal of this
patch is to allow a Linux using 64KB page granularity behaving as a
block backend on a non-modified Xen.

It's only necessary to adapt the ring size and the number of request per
indirect frames. The rest of the code is relying on the grant table
code.

Note that the grant table code is allocating a Linux page per grant
which will result to waste 6OKB for every grant when Linux is using 64KB
page granularity. This could be improved by sharing the page between
multiple grants.

Signed-off-by: Julien Grall <julien.grall@citrix.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: "Roger Pau Monn?" <roger.pau@citrix.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: David Vrabel <david.vrabel@citrix.com>
---

Improvement such as support of 64KB grant is not taken into
consideration in this patch because we have the requirement to run a
Linux using 64KB pages on a non-modified Xen.

This has been tested only with a loop device. I plan to test passing
hard drive partition but I didn't yet convert the swiotlb code.
---
 drivers/block/xen-blkback/blkback.c |  5 +++--
 drivers/block/xen-blkback/common.h  | 16 +++++++++++++---
 drivers/block/xen-blkback/xenbus.c  |  9 ++++++---
 3 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/drivers/block/xen-blkback/blkback.c b/drivers/block/xen-blkback/blkback.c
index ced9677..d5cce8c 100644
--- a/drivers/block/xen-blkback/blkback.c
+++ b/drivers/block/xen-blkback/blkback.c
@@ -961,7 +961,7 @@ static int xen_blkbk_parse_indirect(struct blkif_request *req,
 		seg[n].nsec = segments[i].last_sect -
 			segments[i].first_sect + 1;
 		seg[n].offset = (segments[i].first_sect << 9);
-		if ((segments[i].last_sect >= (PAGE_SIZE >> 9)) ||
+		if ((segments[i].last_sect >= (XEN_PAGE_SIZE >> 9)) ||
 		    (segments[i].last_sect < segments[i].first_sect)) {
 			rc = -EINVAL;
 			goto unmap;
@@ -1210,6 +1210,7 @@ static int dispatch_rw_block_io(struct xen_blkif *blkif,
 
 	req_operation = req->operation == BLKIF_OP_INDIRECT ?
 			req->u.indirect.indirect_op : req->operation;
+
 	if ((req->operation == BLKIF_OP_INDIRECT) &&
 	    (req_operation != BLKIF_OP_READ) &&
 	    (req_operation != BLKIF_OP_WRITE)) {
@@ -1268,7 +1269,7 @@ static int dispatch_rw_block_io(struct xen_blkif *blkif,
 			seg[i].nsec = req->u.rw.seg[i].last_sect -
 				req->u.rw.seg[i].first_sect + 1;
 			seg[i].offset = (req->u.rw.seg[i].first_sect << 9);
-			if ((req->u.rw.seg[i].last_sect >= (PAGE_SIZE >> 9)) ||
+			if ((req->u.rw.seg[i].last_sect >= (XEN_PAGE_SIZE >> 9)) ||
 			    (req->u.rw.seg[i].last_sect <
 			     req->u.rw.seg[i].first_sect))
 				goto fail_response;
diff --git a/drivers/block/xen-blkback/common.h b/drivers/block/xen-blkback/common.h
index 45a044a..33836bb 100644
--- a/drivers/block/xen-blkback/common.h
+++ b/drivers/block/xen-blkback/common.h
@@ -39,6 +39,7 @@
 #include <asm/pgalloc.h>
 #include <asm/hypervisor.h>
 #include <xen/grant_table.h>
+#include <xen/page.h>
 #include <xen/xenbus.h>
 #include <xen/interface/io/ring.h>
 #include <xen/interface/io/blkif.h>
@@ -51,12 +52,21 @@ extern unsigned int xen_blkif_max_ring_order;
  */
 #define MAX_INDIRECT_SEGMENTS 256
 
-#define SEGS_PER_INDIRECT_FRAME \
-	(PAGE_SIZE/sizeof(struct blkif_request_segment))
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
 #define MAX_INDIRECT_PAGES \
 	((MAX_INDIRECT_SEGMENTS + SEGS_PER_INDIRECT_FRAME - 1)/SEGS_PER_INDIRECT_FRAME)
 #define INDIRECT_PAGES(_segs) \
-	((_segs + SEGS_PER_INDIRECT_FRAME - 1)/SEGS_PER_INDIRECT_FRAME)
+	((_segs + XEN_PAGES_PER_INDIRECT_FRAME - 1)/XEN_PAGES_PER_INDIRECT_FRAME)
 
 /* Not a real protocol.  Used to generate ring structs which contain
  * the elements common to all protocols only.  This way we get a
diff --git a/drivers/block/xen-blkback/xenbus.c b/drivers/block/xen-blkback/xenbus.c
index deb3f00..edd27e4 100644
--- a/drivers/block/xen-blkback/xenbus.c
+++ b/drivers/block/xen-blkback/xenbus.c
@@ -176,21 +176,24 @@ static int xen_blkif_map(struct xen_blkif *blkif, grant_ref_t *gref,
 	{
 		struct blkif_sring *sring;
 		sring = (struct blkif_sring *)blkif->blk_ring;
-		BACK_RING_INIT(&blkif->blk_rings.native, sring, PAGE_SIZE * nr_grefs);
+		BACK_RING_INIT(&blkif->blk_rings.native, sring,
+			       XEN_PAGE_SIZE * nr_grefs);
 		break;
 	}
 	case BLKIF_PROTOCOL_X86_32:
 	{
 		struct blkif_x86_32_sring *sring_x86_32;
 		sring_x86_32 = (struct blkif_x86_32_sring *)blkif->blk_ring;
-		BACK_RING_INIT(&blkif->blk_rings.x86_32, sring_x86_32, PAGE_SIZE * nr_grefs);
+		BACK_RING_INIT(&blkif->blk_rings.x86_32, sring_x86_32,
+			       XEN_PAGE_SIZE * nr_grefs);
 		break;
 	}
 	case BLKIF_PROTOCOL_X86_64:
 	{
 		struct blkif_x86_64_sring *sring_x86_64;
 		sring_x86_64 = (struct blkif_x86_64_sring *)blkif->blk_ring;
-		BACK_RING_INIT(&blkif->blk_rings.x86_64, sring_x86_64, PAGE_SIZE * nr_grefs);
+		BACK_RING_INIT(&blkif->blk_rings.x86_64, sring_x86_64,
+			       XEN_PAGE_SIZE * nr_grefs);
 		break;
 	}
 	default:
-- 
2.1.4
