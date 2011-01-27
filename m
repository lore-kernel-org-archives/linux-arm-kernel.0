From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 27 Jan 2011 12:32:53 +0000
Subject: [PATCH 1/2] DMA: PL08x: fix infinite wait when terminating transfers
Message-ID: <20110127123253.GC25968@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If we try to pause a channel when terminating a transfer, we could end
up spinning for it to become inactive indefinitely, and can result in
an uninterruptible wait requiring a reset to recover from.

Terminating a transfer is supposed to take effect immediately, but may
result in data loss.

To make this clear, rename the function to pl08x_terminate_phy_chan().
Also, make sure it is always consistently called - with the spinlock
held and IRQs disabled, and ensure that the TC and ERR interrupt status
is always cleared.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/amba-pl08x.c |   32 ++++++++++++++++++--------------
 1 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index 297f48b..8321a39 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -267,19 +267,24 @@ static void pl08x_resume_phy_chan(struct pl08x_phy_chan *ch)
 }
 
 
-/* Stops the channel */
-static void pl08x_stop_phy_chan(struct pl08x_phy_chan *ch)
+/*
+ * pl08x_terminate_phy_chan() stops the channel, clears the FIFO and
+ * clears any pending interrupt status.  This should not be used for
+ * an on-going transfer, but as a method of shutting down a channel
+ * (eg, when it's no longer used) or terminating a transfer.
+ */
+static void pl08x_terminate_phy_chan(struct pl08x_driver_data *pl08x,
+	struct pl08x_phy_chan *ch)
 {
-	u32 val;
+	u32 val = readl(ch->base + PL080_CH_CONFIG);
 
-	pl08x_pause_phy_chan(ch);
+	val &= ~(PL080_CONFIG_ENABLE | PL080_CONFIG_ERR_IRQ_MASK |
+	         PL080_CONFIG_TC_IRQ_MASK);
 
-	/* Disable channel */
-	val = readl(ch->base + PL080_CH_CONFIG);
-	val &= ~PL080_CONFIG_ENABLE;
-	val &= ~PL080_CONFIG_ERR_IRQ_MASK;
-	val &= ~PL080_CONFIG_TC_IRQ_MASK;
 	writel(val, ch->base + PL080_CH_CONFIG);
+
+	writel(1 << ch->id, pl08x->base + PL080_ERR_CLEAR);
+	writel(1 << ch->id, pl08x->base + PL080_TC_CLEAR);
 }
 
 static inline u32 get_bytes_in_cctl(u32 cctl)
@@ -404,13 +409,12 @@ static inline void pl08x_put_phy_channel(struct pl08x_driver_data *pl08x,
 {
 	unsigned long flags;
 
+	spin_lock_irqsave(&ch->lock, flags);
+
 	/* Stop the channel and clear its interrupts */
-	pl08x_stop_phy_chan(ch);
-	writel((1 << ch->id), pl08x->base + PL080_ERR_CLEAR);
-	writel((1 << ch->id), pl08x->base + PL080_TC_CLEAR);
+	pl08x_terminate_phy_chan(pl08x, ch);
 
 	/* Mark it as free */
-	spin_lock_irqsave(&ch->lock, flags);
 	ch->serving = NULL;
 	spin_unlock_irqrestore(&ch->lock, flags);
 }
@@ -1449,7 +1453,7 @@ static int pl08x_control(struct dma_chan *chan, enum dma_ctrl_cmd cmd,
 		plchan->state = PL08X_CHAN_IDLE;
 
 		if (plchan->phychan) {
-			pl08x_stop_phy_chan(plchan->phychan);
+			pl08x_terminate_phy_chan(pl08x, plchan->phychan);
 
 			/*
 			 * Mark physical channel as free and free any slave
-- 
1.6.2.5
