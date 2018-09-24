From: hch@lst.de (Christoph Hellwig)
Date: Mon, 24 Sep 2018 09:43:51 +0200
Subject: [PATCH 06/10] block: add a missing BIOVEC_SEG_BOUNDARY check in
 bio_add_pc_page
In-Reply-To: <20180924074355.2802-1-hch@lst.de>
References: <20180924074355.2802-1-hch@lst.de>
Message-ID: <20180924074355.2802-7-hch@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The actual recaculation of segments in __blk_recalc_rq_segments will
do this check, so there is no point in forcing it if we know it won't
succeed.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/bio.c b/block/bio.c
index 81d90b839e05..c254e5aa331f 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -731,7 +731,9 @@ int bio_add_pc_page(struct request_queue *q, struct bio *bio, struct page
 	}
 
 	/* If we may be able to merge these biovecs, force a recount */
-	if (bio->bi_vcnt > 1 && biovec_phys_mergeable(bvec-1, bvec))
+	if (bio->bi_vcnt > 1 &&
+	    biovec_phys_mergeable(bvec - 1, bvec) &&
+	    BIOVEC_SEG_BOUNDARY(q, bvec - 1, bvec))
 		bio_clear_flag(bio, BIO_SEG_VALID);
 
  done:
-- 
2.19.0
