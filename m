From: prylowski@metasoft.pl (Rafal Prylowski)
Date: Thu, 19 Apr 2012 11:19:00 +0200
Subject: [PATCH v2] dmaengine/ep93xx_dma: Implement double buffering for M2M
 DMA channels
Message-ID: <4F8FD884.7090403@metasoft.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add double buffering support for M2M DMA channels. Implement this by using EP93xx
M2M DMA Buffer and Control Finite State Machines to be sure that we are not
disabling the channel when it's actually operating.

Signed-off-by: Rafal Prylowski <prylowski@metasoft.pl>
Tested-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Acked-by: H Hartley Sweeten <hsweeten@visionengravers.com>

---
This version fixes issues with interrupt storm observed when dma is
used with spi-ep93xx.c and mmc_spi.c drivers.
Patch applies to v3.4rc3.

 drivers/dma/ep93xx_dma.c |  117 +++++++++++++++++++++++++++++--------
 1 file changed, 93 insertions(+), 24 deletions(-)

Index: linux-2.6/drivers/dma/ep93xx_dma.c
===================================================================
--- linux-2.6.orig/drivers/dma/ep93xx_dma.c
+++ linux-2.6/drivers/dma/ep93xx_dma.c
@@ -71,6 +71,7 @@
 #define M2M_CONTROL_TM_SHIFT		13
 #define M2M_CONTROL_TM_TX		(1 << M2M_CONTROL_TM_SHIFT)
 #define M2M_CONTROL_TM_RX		(2 << M2M_CONTROL_TM_SHIFT)
+#define M2M_CONTROL_NFBINT		BIT(21)
 #define M2M_CONTROL_RSS_SHIFT		22
 #define M2M_CONTROL_RSS_SSPRX		(1 << M2M_CONTROL_RSS_SHIFT)
 #define M2M_CONTROL_RSS_SSPTX		(2 << M2M_CONTROL_RSS_SHIFT)
@@ -79,7 +80,22 @@
 #define M2M_CONTROL_PWSC_SHIFT		25
 
 #define M2M_INTERRUPT			0x0004
-#define M2M_INTERRUPT_DONEINT		BIT(1)
+#define M2M_INTERRUPT_MASK		6
+
+#define M2M_STATUS			0x000c
+#define M2M_STATUS_CTL_SHIFT		1
+#define M2M_STATUS_CTL_IDLE		(0 << M2M_STATUS_CTL_SHIFT)
+#define M2M_STATUS_CTL_STALL		(1 << M2M_STATUS_CTL_SHIFT)
+#define M2M_STATUS_CTL_MEMRD		(2 << M2M_STATUS_CTL_SHIFT)
+#define M2M_STATUS_CTL_MEMWR		(3 << M2M_STATUS_CTL_SHIFT)
+#define M2M_STATUS_CTL_BWCWAIT		(4 << M2M_STATUS_CTL_SHIFT)
+#define M2M_STATUS_CTL_MASK		(7 << M2M_STATUS_CTL_SHIFT)
+#define M2M_STATUS_BUF_SHIFT		4
+#define M2M_STATUS_BUF_NO		(0 << M2M_STATUS_BUF_SHIFT)
+#define M2M_STATUS_BUF_ON		(1 << M2M_STATUS_BUF_SHIFT)
+#define M2M_STATUS_BUF_NEXT		(2 << M2M_STATUS_BUF_SHIFT)
+#define M2M_STATUS_BUF_MASK		(3 << M2M_STATUS_BUF_SHIFT)
+#define M2M_STATUS_DONE			BIT(6)
 
 #define M2M_BCR0			0x0010
 #define M2M_BCR1			0x0014
@@ -426,15 +442,6 @@ static int m2p_hw_interrupt(struct ep93x
 
 /*
  * M2M DMA implementation
- *
- * For the M2M transfers we don't use NFB at all. This is because it simply
- * doesn't work well with memcpy transfers. When you submit both buffers it is
- * extremely unlikely that you get an NFB interrupt, but it instead reports
- * DONE interrupt and both buffers are already transferred which means that we
- * weren't able to update the next buffer.
- *
- * So for now we "simulate" NFB by just submitting buffer after buffer
- * without double buffering.
  */
 
 static int m2m_hw_setup(struct ep93xx_dma_chan *edmac)
@@ -543,6 +550,11 @@ static void m2m_hw_submit(struct ep93xx_
 	m2m_fill_desc(edmac);
 	control |= M2M_CONTROL_DONEINT;
 
+	if (ep93xx_dma_advance_active(edmac)) {
+		m2m_fill_desc(edmac);
+		control |= M2M_CONTROL_NFBINT;
+	}
+
 	/*
 	 * Now we can finally enable the channel. For M2M channel this must be
 	 * done _after_ the BCRx registers are programmed.
@@ -560,32 +572,89 @@ static void m2m_hw_submit(struct ep93xx_
 	}
 }
 
+/*
+ * According to EP93xx User's Guide, we should receive DONE interrupt when all
+ * M2M DMA controller transactions complete normally. This is not always the
+ * case - sometimes EP93xx M2M DMA asserts DONE interrupt when the DMA channel
+ * is still running (channel Buffer FSM in DMA_BUF_ON state, and channel
+ * Control FSM in DMA_MEM_RD state, observed@least in IDE-DMA operation).
+ * In effect, disabling the channel when only DONE bit is set could stop
+ * currently running DMA transfer. To avoid this, we use Buffer FSM and
+ * Control FSM to check current state of DMA channel.
+ */
 static int m2m_hw_interrupt(struct ep93xx_dma_chan *edmac)
 {
+	u32 status = readl(edmac->regs + M2M_STATUS);
+	u32 ctl_fsm = status & M2M_STATUS_CTL_MASK;
+	u32 buf_fsm = status & M2M_STATUS_BUF_MASK;
+	bool done = status & M2M_STATUS_DONE;
+	bool last_done;
 	u32 control;
+	struct ep93xx_dma_desc *desc;
 
-	if (!(readl(edmac->regs + M2M_INTERRUPT) & M2M_INTERRUPT_DONEINT))
+	/* Accept only DONE and NFB interrupts */
+	if (!(readl(edmac->regs + M2M_INTERRUPT) & M2M_INTERRUPT_MASK))
 		return INTERRUPT_UNKNOWN;
 
-	/* Clear the DONE bit */
-	writel(0, edmac->regs + M2M_INTERRUPT);
+	if (done) {
+		/* Clear the DONE bit */
+		writel(0, edmac->regs + M2M_INTERRUPT);
+	}
 
-	/* Disable interrupts and the channel */
-	control = readl(edmac->regs + M2M_CONTROL);
-	control &= ~(M2M_CONTROL_DONEINT | M2M_CONTROL_ENABLE);
-	writel(control, edmac->regs + M2M_CONTROL);
+	/*
+	 * Check whether we are done with descriptors or not. This, together
+	 * with DMA channel state, determines action to take in interrupt.
+	 */
+	desc = ep93xx_dma_get_active(edmac);
+	last_done = !desc || desc->txd.cookie;
 
 	/*
-	 * Since we only get DONE interrupt we have to find out ourselves
-	 * whether there still is something to process. So we try to advance
-	 * the chain an see whether it succeeds.
+	 * Use M2M DMA Buffer FSM and Control FSM to check current state of
+	 * DMA channel. Using DONE and NFB bits from channel status register
+	 * or bits from channel interrupt register is not reliable.
 	 */
-	if (ep93xx_dma_advance_active(edmac)) {
-		edmac->edma->hw_submit(edmac);
-		return INTERRUPT_NEXT_BUFFER;
+	if (!last_done &&
+	    (buf_fsm == M2M_STATUS_BUF_NO ||
+	     buf_fsm == M2M_STATUS_BUF_ON)) {
+		/*
+		 * Two buffers are ready for update when Buffer FSM is in
+		 * DMA_NO_BUF state. Only one buffer can be prepared without
+		 * disabling the channel or polling the DONE bit.
+		 * To simplify things, always prepare only one buffer.
+		 */
+		if (ep93xx_dma_advance_active(edmac)) {
+			m2m_fill_desc(edmac);
+			if (done && !edmac->chan.private) {
+				/* Software trigger for memcpy channel */
+				control = readl(edmac->regs + M2M_CONTROL);
+				control |= M2M_CONTROL_START;
+				writel(control, edmac->regs + M2M_CONTROL);
+			}
+			return INTERRUPT_NEXT_BUFFER;
+		} else {
+			last_done = true;
+		}
 	}
 
-	return INTERRUPT_DONE;
+	/*
+	 * Disable the channel only when Buffer FSM is in DMA_NO_BUF state
+	 * and Control FSM is in DMA_STALL state.
+	 */
+	if (last_done &&
+	    buf_fsm == M2M_STATUS_BUF_NO &&
+	    ctl_fsm == M2M_STATUS_CTL_STALL) {
+		/* Disable interrupts and the channel */
+		control = readl(edmac->regs + M2M_CONTROL);
+		control &= ~(M2M_CONTROL_DONEINT | M2M_CONTROL_NFBINT
+			    | M2M_CONTROL_ENABLE);
+		writel(control, edmac->regs + M2M_CONTROL);
+		return INTERRUPT_DONE;
+	}
+
+	/*
+	 * Nothing to do this time.
+	 */
+	return INTERRUPT_NEXT_BUFFER;
 }
 
 /*
