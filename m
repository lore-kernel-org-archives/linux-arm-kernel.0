From: jassi.brar@samsung.com (Jassi Brar)
Date: Thu,  5 Nov 2009 13:44:33 +0900
Subject: [PATCH 3/5] S3C64XX DMA: Callback with correct buffer pointer
Message-ID: <1257396273-32201-1-git-send-email-jassi.brar@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

buffdone callback should be called per buffer request with pointer
to the latest serviced request.
'next' should point to the one next to currently active.

Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
---
 arch/arm/plat-s3c64xx/dma.c |   29 ++++++++++++++++++++++++++++-
 1 files changed, 28 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-s3c64xx/dma.c b/arch/arm/plat-s3c64xx/dma.c
index 5a08a86..20b0747 100644
--- a/arch/arm/plat-s3c64xx/dma.c
+++ b/arch/arm/plat-s3c64xx/dma.c
@@ -578,6 +578,7 @@ static irqreturn_t s3c64xx_dma_irq(int irq, void *pw)
 	errstat = readl(dmac->regs + PL080_ERR_STATUS);
 
 	for (offs = 0, bit = 1; offs < 8; offs++, bit <<= 1) {
+		struct s3c64xx_dma_buff *buff;
 
 		if (!(errstat & bit) && !(tcstat & bit))
 			continue;
@@ -593,7 +594,33 @@ static irqreturn_t s3c64xx_dma_irq(int irq, void *pw)
 		if (errstat & bit)
 			writel(bit, dmac->regs + PL080_ERR_CLEAR);
 
-		s3c64xx_dma_bufffdone(chan, chan->curr, res);
+		/* 'next' points to the buffer that is next to the
+		 * currently active buffer.
+		 * For CIRCULAR queues, 'next' will be same as 'curr'
+		 * when 'end' is the active buffer.
+		 */
+		buff = chan->curr;
+		while (buff && buff != chan->next
+				&& buff->next != chan->next)
+			buff = buff->next;
+
+		if (!buff)
+			BUG();
+
+		if (buff == chan->next)
+			buff = chan->end;
+
+		s3c64xx_dma_bufffdone(chan, buff, res);
+
+		/* Update 'next' */
+		buff = chan->next;
+		if (chan->next == chan->end) {
+			chan->next = chan->curr;
+			if (!(chan->flags & S3C2410_DMAF_CIRCULAR))
+				chan->end = NULL;
+		} else {
+			chan->next = buff->next;
+		}
 	}
 
 	return IRQ_HANDLED;
-- 
1.6.2.5
