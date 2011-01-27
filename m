From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 27 Jan 2011 12:37:44 +0000
Subject: [PATCH 2/2] DMA: PL08x: fix channel pausing to timeout rather
	than lockup
In-Reply-To: <20110127123253.GC25968@n2100.arm.linux.org.uk>
References: <20110127123253.GC25968@n2100.arm.linux.org.uk>
Message-ID: <20110127123744.GA28855@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If a transfer is initiated from memory to a peripheral, then data is
fetched and the channel is marked busy.  This busy status persists until
the HALT bit is set and the queued data has been transfered to the
peripheral.  Waiting indefinitely after setting the HALT bit results in
system lockups.  Timeout this operation, and print an error when this
happens.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
This happens when a M->P transfer is started, but the peripheral doesn't
take the data.  The DMA controller will mark itself active and fetch data
from memory, in anticipation of the peripheral wanting the data.  This
advances the source address.

An alternative approach here is to just set the HALT bit and return
immediately, without waiting for the primecell to show that it is no
longer active.  In any case, resuming the channel will allow the
transfer to continue without data loss.

 drivers/dma/amba-pl08x.c |   21 +++++++++++++++------
 1 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index 8321a39..07bca49 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -79,6 +79,7 @@
 #include <linux/module.h>
 #include <linux/interrupt.h>
 #include <linux/slab.h>
+#include <linux/delay.h>
 #include <linux/dmapool.h>
 #include <linux/dmaengine.h>
 #include <linux/amba/bus.h>
@@ -235,16 +236,19 @@ static void pl08x_start_txd(struct pl08x_dma_chan *plchan,
 }
 
 /*
- * Overall DMAC remains enabled always.
+ * Pause the channel by setting the HALT bit.
  *
- * Disabling individual channels could lose data.
+ * For M->P transfers, pause the DMAC first and then stop the peripheral -
+ * the FIFO can only drain if the peripheral is still requesting data.
+ * (note: this can still timeout if the DMAC FIFO never drains of data.)
  *
- * Disable the peripheral DMA after disabling the DMAC in order to allow
- * the DMAC FIFO to drain, and hence allow the channel to show inactive
+ * For P->M transfers, disable the peripheral first to stop it filling
+ * the DMAC FIFO, and then pause the DMAC.
  */
 static void pl08x_pause_phy_chan(struct pl08x_phy_chan *ch)
 {
 	u32 val;
+	int timeout;
 
 	/* Set the HALT bit and wait for the FIFO to drain */
 	val = readl(ch->base + PL080_CH_CONFIG);
@@ -252,8 +256,13 @@ static void pl08x_pause_phy_chan(struct pl08x_phy_chan *ch)
 	writel(val, ch->base + PL080_CH_CONFIG);
 
 	/* Wait for channel inactive */
-	while (pl08x_phy_channel_busy(ch))
-		cpu_relax();
+	for (timeout = 1000; timeout; timeout--) {
+		if (!pl08x_phy_channel_busy(ch))
+			break;
+		udelay(1);
+	}
+	if (pl08x_phy_channel_busy(ch))
+		pr_err("pl08x: channel%u timeout waiting for pause\n", ch->id);
 }
 
 static void pl08x_resume_phy_chan(struct pl08x_phy_chan *ch)
-- 
1.6.2.5
