From: hias@horus.com (Matthias Reichl)
Date: Thu,  9 Jun 2016 13:41:43 +0200
Subject: [PATCH 1/2] dmaengine: bcm2835: Fix cyclic DMA period splitting
In-Reply-To: <1465472504-10191-1-git-send-email-hias@horus.com>
References: <1465472504-10191-1-git-send-email-hias@horus.com>
Message-ID: <1465472504-10191-2-git-send-email-hias@horus.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The code responsible for splitting periods into chunks that
can be handled by the DMA controller missed to update total_len,
the number of bytes processed in the current period, when there
are more chunks to follow.

Therefore total_len was stuck at 0 and the code didn't work at all.
This resulted in a wrong control block layout and audio issues because
the cyclic DMA callback wasn't executing on period boundaries.

Fix this by adding the missing total_len update.

Signed-off-by: Matthias Reichl <hias@horus.com>
Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
Tested-by: Clive Messer <clive.messer@digitaldreamtime.co.uk>
---
 drivers/dma/bcm2835-dma.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
index 6149b27..344bcf92 100644
--- a/drivers/dma/bcm2835-dma.c
+++ b/drivers/dma/bcm2835-dma.c
@@ -251,8 +251,11 @@ static void bcm2835_dma_create_cb_set_length(
 	 */
 
 	/* have we filled in period_length yet? */
-	if (*total_len + control_block->length < period_len)
+	if (*total_len + control_block->length < period_len) {
+		/* update number of bytes in this period so far */
+		*total_len += control_block->length;
 		return;
+	}
 
 	/* calculate the length that remains to reach period_length */
 	control_block->length = period_len - *total_len;
-- 
2.1.4
