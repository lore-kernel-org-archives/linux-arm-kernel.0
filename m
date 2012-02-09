From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Thu,  9 Feb 2012 13:28:26 +0100
Subject: [RFC / PATCH] arm/davinci: optimize the DMA ISR
Message-ID: <1328790506-18507-1-git-send-email-bigeasy@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ISR does quiete a lot of hw access which could be avoided. First it
checks for a pending interrupt by reading alteast one register. Then it
checks for the "activated" slots by reading another register. This is
more or a less a must.
Now, once it found an active slot it does the same two reads again.
After that it "knows" that there must be a pending transfer however it
cross checks with the other register. There are 32 bit in an interger
which are polled instead of considering only the set bits and ignoring
those which are zero. This performs atleast 32 reads which could be
avoided. In case of a first match it does another read.
This patch reorganizes the access by re-using the register which have
been read and then uses ffs() to find the matching slot instead looping
over it. By doing this we get rid of the last (32 + 2 + hits) reads.

It is possible however that by really busy bank0 we never get to handle
bank1. If this is a problem, we could try to handle bank1 after we are
done with bank0 to check if there are any outstanding transfers.

To put some numbers on this, this is from spi transfer via spidev. The
first column is the number of total transfers, the time stamp is taken
before and after the ioctl():

|10000, min: 542us      avg: 591us
|20000, min: 542us      avg: 592us
|30000, min: 542us      avg: 592us
|40000, min: 542us      avg: 585us
|50000, min: 542us      avg: 593us

The same test case with the patch applied
|10000, min: 444us      avg: 493us
|20000, min: 444us      avg: 491us
|30000, min: 444us      avg: 489us
|40000, min: 444us      avg: 491us
|50000, min: 444us      avg: 492us

that is almost 100us that just went away.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/arm/mach-davinci/dma.c |   69 +++++++++++++++++++++----------------------
 1 files changed, 34 insertions(+), 35 deletions(-)

diff --git a/arch/arm/mach-davinci/dma.c b/arch/arm/mach-davinci/dma.c
index da90103..cfa68cb 100644
--- a/arch/arm/mach-davinci/dma.c
+++ b/arch/arm/mach-davinci/dma.c
@@ -353,9 +353,10 @@ static int irq2ctlr(int irq)
  *****************************************************************************/
 static irqreturn_t dma_irq_handler(int irq, void *data)
 {
-	int i;
 	int ctlr;
-	unsigned int cnt = 0;
+	u32 sh_ier;
+	u32 sh_ipr;
+	u32 bank;
 
 	ctlr = irq2ctlr(irq);
 	if (ctlr < 0)
@@ -363,41 +364,39 @@ static irqreturn_t dma_irq_handler(int irq, void *data)
 
 	dev_dbg(data, "dma_irq_handler\n");
 
-	if ((edma_shadow0_read_array(ctlr, SH_IPR, 0) == 0) &&
-	    (edma_shadow0_read_array(ctlr, SH_IPR, 1) == 0))
-		return IRQ_NONE;
+	sh_ipr = edma_shadow0_read_array(ctlr, SH_IPR, 0);
+	if (!sh_ipr) {
+		sh_ipr = edma_shadow0_read_array(ctlr, SH_IPR, 1);
+		if (!sh_ipr)
+			return IRQ_NONE;
+		sh_ier = edma_shadow0_read_array(ctlr, SH_IER, 1);
+		bank = 1;
+	} else {
+		sh_ier = edma_shadow0_read_array(ctlr, SH_IER, 0);
+		bank = 0;
+	}
 
-	while (1) {
-		int j;
-		if (edma_shadow0_read_array(ctlr, SH_IPR, 0) &
-				edma_shadow0_read_array(ctlr, SH_IER, 0))
-			j = 0;
-		else if (edma_shadow0_read_array(ctlr, SH_IPR, 1) &
-				edma_shadow0_read_array(ctlr, SH_IER, 1))
-			j = 1;
-		else
-			break;
-		dev_dbg(data, "IPR%d %08x\n", j,
-				edma_shadow0_read_array(ctlr, SH_IPR, j));
-		for (i = 0; i < 32; i++) {
-			int k = (j << 5) + i;
-			if ((edma_shadow0_read_array(ctlr, SH_IPR, j) & BIT(i))
-					&& (edma_shadow0_read_array(ctlr,
-							SH_IER, j) & BIT(i))) {
-				/* Clear the corresponding IPR bits */
-				edma_shadow0_write_array(ctlr, SH_ICR, j,
-							BIT(i));
-				if (edma_cc[ctlr]->intr_data[k].callback)
-					edma_cc[ctlr]->intr_data[k].callback(
-						k, DMA_COMPLETE,
-						edma_cc[ctlr]->intr_data[k].
-						data);
-			}
+	do {
+		u32 slot;
+		u32 channel;
+
+		dev_dbg(data, "IPR%d %08x\n", bank, sh_ipr);
+
+		slot = __ffs(sh_ipr);
+		sh_ipr &= ~(BIT(slot));
+
+		if (sh_ier & BIT(slot)) {
+			channel = (bank << 5) | slot;
+			/* Clear the corresponding IPR bits */
+			edma_shadow0_write_array(ctlr, SH_ICR, bank,
+					BIT(slot));
+			if (edma_cc[ctlr]->intr_data[channel].callback)
+				edma_cc[ctlr]->intr_data[channel].callback(
+					channel, DMA_COMPLETE,
+					edma_cc[ctlr]->intr_data[channel].data);
 		}
-		cnt++;
-		if (cnt > 10)
-			break;
-	}
+	} while (sh_ipr);
+
 	edma_shadow0_write(ctlr, SH_IEVAL, 1);
 	return IRQ_HANDLED;
 }
-- 
1.7.9
