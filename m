From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 12 Jul 2013 17:48:10 -0400
Subject: [RFC/RFT PATCH 1/5] block: Rename parameter dma_mask to max_addr for
 blk_queue_bounce_limit()
In-Reply-To: <1373665694-7580-1-git-send-email-santosh.shilimkar@ti.com>
References: <1373665694-7580-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <1373665694-7580-2-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The blk_queue_bounce_limit() API parameter 'dma_mask' is actually the
maximum address the device can handle rather than a dma_mask. Rename
it accordingly to avoid it being interpreted as dma_mask.

No functional change.

The idea is to fix the bad assumptions about dma_mask wherever it could
be miss-interpreted.

Cc: Russell King <rmk@arm.linux.org.uk>
Cc: Jens Axboe <axboe@kernel.dk>

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 block/blk-settings.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index c50ecf0..026c151 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -195,17 +195,17 @@ EXPORT_SYMBOL(blk_queue_make_request);
 /**
  * blk_queue_bounce_limit - set bounce buffer limit for queue
  * @q: the request queue for the device
- * @dma_mask: the maximum address the device can handle
+ * @max_addr: the maximum address the device can handle
  *
  * Description:
  *    Different hardware can have different requirements as to what pages
  *    it can do I/O directly to. A low level driver can call
  *    blk_queue_bounce_limit to have lower memory pages allocated as bounce
- *    buffers for doing I/O to pages residing above @dma_mask.
+ *    buffers for doing I/O to pages residing above @max_addr.
  **/
-void blk_queue_bounce_limit(struct request_queue *q, u64 dma_mask)
+void blk_queue_bounce_limit(struct request_queue *q, u64 max_addr)
 {
-	unsigned long b_pfn = dma_mask >> PAGE_SHIFT;
+	unsigned long b_pfn = max_addr >> PAGE_SHIFT;
 	int dma = 0;
 
 	q->bounce_gfp = GFP_NOIO;
-- 
1.7.9.5
