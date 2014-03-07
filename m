From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Fri,  7 Mar 2014 16:46:45 -0300
Subject: [PATCH v2 1/3] dma: mv_xor: Remove unneeded
 mv_xor_clean_completed_slots() call
In-Reply-To: <1394221607-15064-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1394221607-15064-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1394221607-15064-2-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In mv_xor_status(), we are currently calling mv_xor_clean_completed_slots()
when the transaction is complete (the cookie status is DMA_COMPLETE).
However, a completed status means that mv_xor_slot_cleanup() was called,
which cleans the completed slots.

In other words, there's nothing to cleanup for a completed transaction in
mv_xor_status(). Remove the unneeded call to mv_xor_clean_completed_slots().

Reported-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 drivers/dma/mv_xor.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
index 766b68e..589917b 100644
--- a/drivers/dma/mv_xor.c
+++ b/drivers/dma/mv_xor.c
@@ -702,10 +702,8 @@ static enum dma_status mv_xor_status(struct dma_chan *chan,
 	enum dma_status ret;
 
 	ret = dma_cookie_status(chan, cookie, txstate);
-	if (ret == DMA_COMPLETE) {
-		mv_xor_clean_completed_slots(mv_chan);
+	if (ret == DMA_COMPLETE)
 		return ret;
-	}
 	mv_xor_slot_cleanup(mv_chan);
 
 	return dma_cookie_status(chan, cookie, txstate);
-- 
1.9.0
