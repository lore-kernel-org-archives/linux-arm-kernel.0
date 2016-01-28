From: john.ogness@linutronix.de (John Ogness)
Date: Thu, 28 Jan 2016 11:29:08 +0100
Subject: [PATCH v4] dmaengine: edma: fix residue race for cyclic
Message-ID: <87k2mu2e16.fsf@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When retrieving the residue value, the SRC/DST fields of the
active PaRAM are read to determine the current position of
the DMA engine. However, the AM335x Technical Reference Manual
states:

  11.3.3.6 Parameter Set Updates

  After the TR is read from the PaRAM (and is in the process
  of being submitted to the EDMA3TC), the following fields are
  updated as needed: ... SRC DST

This means SRC/DST is incremented even though the DMA transfer
may not have started yet or is in progress. Thus if the reader
of the residue accesses the DMA buffer too quickly, the CPU is
misinformed about the data that has been successfully processed.

The CCSTAT.ACTV register is a boolean that is set if any TR is
being processed by either the EMDA3CC or EDMA3TC. By polling
this register it is possible to ensure that the residue value
returned is valid for immediate processing. However, since the
DMA engine may be active, polling may never hit a moment where
no TR is being processed. To handle this, the SRC/DST is also
polled to see if it changes. And as a last resort, a max loop
count for the busy waiting exists to avoid an infinite loop.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 v1-v2 changes
 . rebased for next-20151016
 . added multiple exit conditions for busy wait loop

 v2-v3 changes
 . rebased for next-20160121
 . reduced max loops from 10000 to 1000
 . loop countdown instead of count
 . change debug print function and message
 . fine-tune comments

 v3-v4 changes
 . rebased for next-20160128
 . moved register bit definition

 drivers/dma/edma.c |   41 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
index d92d655..e3d7fcb 100644
--- a/drivers/dma/edma.c
+++ b/drivers/dma/edma.c
@@ -113,6 +113,9 @@
 #define GET_NUM_REGN(x)		((x & 0x300000) >> 20) /* bits 20-21 */
 #define CHMAP_EXIST		BIT(24)
 
+/* CCSTAT register */
+#define EDMA_CCSTAT_ACTV	BIT(4)
+
 /*
  * Max of 20 segments per channel to conserve PaRAM slots
  * Also note that MAX_NR_SG should be atleast the no.of periods
@@ -1680,9 +1683,20 @@ static void edma_issue_pending(struct dma_chan *chan)
 	spin_unlock_irqrestore(&echan->vchan.lock, flags);
 }
 
+/*
+ * This limit exists to avoid a possible infinite loop when waiting for proof
+ * that a particular transfer is completed. This limit can be hit if there
+ * are large bursts to/from slow devices or the CPU is never able to catch
+ * the DMA hardware idle. On an AM335x transfering 48 bytes from the UART
+ * RX-FIFO, as many as 55 loops have been seen.
+ */
+#define EDMA_MAX_TR_WAIT_LOOPS 1000
+
 static u32 edma_residue(struct edma_desc *edesc)
 {
 	bool dst = edesc->direction == DMA_DEV_TO_MEM;
+	int loop_count = EDMA_MAX_TR_WAIT_LOOPS;
+	struct edma_chan *echan = edesc->echan;
 	struct edma_pset *pset = edesc->pset;
 	dma_addr_t done, pos;
 	int i;
@@ -1691,7 +1705,32 @@ static u32 edma_residue(struct edma_desc *edesc)
 	 * We always read the dst/src position from the first RamPar
 	 * pset. That's the one which is active now.
 	 */
-	pos = edma_get_position(edesc->echan->ecc, edesc->echan->slot[0], dst);
+	pos = edma_get_position(echan->ecc, echan->slot[0], dst);
+
+	/*
+	 * "pos" may represent a transfer request that is still being
+	 * processed by the EDMACC or EDMATC. We will busy wait until
+	 * any one of the situations occurs:
+	 *   1. the DMA hardware is idle
+	 *   2. a new transfer request is setup
+	 *   3. we hit the loop limit
+	 */
+	while (edma_read(echan->ecc, EDMA_CCSTAT) & EDMA_CCSTAT_ACTV) {
+		/* check if a new transfer request is setup */
+		if (edma_get_position(echan->ecc,
+				      echan->slot[0], dst) != pos) {
+			break;
+		}
+
+		if (!--loop_count) {
+			dev_dbg_ratelimited(echan->vchan.chan.device->dev,
+				"%s: timeout waiting for PaRAM update\n",
+				__func__);
+			break;
+		}
+
+		cpu_relax();
+	}
 
 	/*
 	 * Cyclic is simple. Just subtract pset[0].addr from pos.
-- 
1.7.10.4
