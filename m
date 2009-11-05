From: jassi.brar@samsung.com (Jassi Brar)
Date: Thu,  5 Nov 2009 13:44:39 +0900
Subject: [PATCH 4/5] S3C64XX DMA: Free node for non-circular queues
Message-ID: <1257396279-32231-1-git-send-email-jassi.brar@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We need to free the buff and lli nodes if the buffer queue is 
not CIRCULAR.

Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
---
 arch/arm/plat-s3c64xx/dma.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-s3c64xx/dma.c b/arch/arm/plat-s3c64xx/dma.c
index 20b0747..0971d06 100644
--- a/arch/arm/plat-s3c64xx/dma.c
+++ b/arch/arm/plat-s3c64xx/dma.c
@@ -612,6 +612,12 @@ static irqreturn_t s3c64xx_dma_irq(int irq, void *pw)
 
 		s3c64xx_dma_bufffdone(chan, buff, res);
 
+		/* Free the node and update curr, if non-circular queue */
+		if (!(chan->flags & S3C2410_DMAF_CIRCULAR)) {
+			chan->curr = buff->next;
+			s3c64xx_dma_freebuff(buff);
+		}
+
 		/* Update 'next' */
 		buff = chan->next;
 		if (chan->next == chan->end) {
-- 
1.6.2.5
