From: Hong-Xing.Zhu@freescale.com (Richard Zhu)
Date: Sat, 2 Apr 2011 15:23:45 +0800
Subject: [PATCH RFC] RAMDISK: doing write barrier will return -EIO
In-Reply-To: <1301729025-2647-1-git-send-email-Hong-Xing.Zhu@freescale.com>
References: <1301729025-2647-1-git-send-email-Hong-Xing.Zhu@freescale.com>
Message-ID: <1301729025-2647-2-git-send-email-Hong-Xing.Zhu@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

when doing write barrier, the data of the bio is NULL, it's OK for
ramdisk doing nothing, So the result of the bio must be success.

Signed-off-by: Richard Zhu <Hong-Xing.Zhu@freescale.com>
---
 drivers/block/brd.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index b7f51e4..8d4964c 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -335,12 +335,14 @@ static int brd_make_request(struct request_queue *q, struct bio *bio)
 	struct bio_vec *bvec;
 	sector_t sector;
 	int i;
-	int err = -EIO;
+	int err = 0;
 
 	sector = bio->bi_sector;
 	if (sector + (bio->bi_size >> SECTOR_SHIFT) >
-						get_capacity(bdev->bd_disk))
+						get_capacity(bdev->bd_disk)) {
+		err = -EIO;
 		goto out;
+	}
 
 	if (unlikely(bio->bi_rw & REQ_DISCARD)) {
 		err = 0;
-- 
1.7.1
