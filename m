From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 24 Dec 2010 10:09:46 +0000
Subject: [PATCH 11/11] ARM: PL08x: fix atomic_t usage and tx_submit() return
	value
In-Reply-To: <20101224100550.GB20587@n2100.arm.linux.org.uk>
References: <20101224100550.GB20587@n2100.arm.linux.org.uk>
Message-ID: <E1PW4ao-0006Du-7T@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The last_issued variable uses an atomic type, which is only
incremented inside a protected region, and then read.  Every
where else only reads the value, so it isn't using atomic_t
correctly.  It doesn't even need to.  Convert it to a dma_cookie_t.

Also, fix dma_cookie_t when it wraps negative - negative returns
from tx_submit() mean failure, yet in reality we always succeed.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/amba-pl08x.c   |   18 +++++++++---------
 include/linux/amba/pl08x.h |    2 +-
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index a87fc8f..ac42208 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -74,7 +74,6 @@
 #include <asm/hardware/pl080.h>
 #include <asm/dma.h>
 #include <asm/mach/dma.h>
-#include <asm/atomic.h>
 #include <asm/processor.h>
 #include <asm/cacheflush.h>
 
@@ -1081,8 +1080,10 @@ static dma_cookie_t pl08x_tx_submit(struct dma_async_tx_descriptor *tx)
 {
 	struct pl08x_dma_chan *plchan = to_pl08x_chan(tx->chan);
 
-	atomic_inc(&plchan->last_issued);
-	tx->cookie = atomic_read(&plchan->last_issued);
+	plchan->last_issued += 1;
+	if (plchan->last_issued < 0)
+		plchan->last_issued = 0;
+	tx->cookie = plchan->last_issued;
 	/* This unlock follows the lock in the prep() function */
 	spin_unlock_irqrestore(&plchan->lock, plchan->lockflags);
 
@@ -1114,7 +1115,7 @@ pl08x_dma_tx_status(struct dma_chan *chan,
 	enum dma_status ret;
 	u32 bytesleft = 0;
 
-	last_used = atomic_read(&plchan->last_issued);
+	last_used = plchan->last_issued;
 	last_complete = plchan->lc;
 
 	ret = dma_async_is_complete(cookie, last_complete, last_used);
@@ -1130,7 +1131,7 @@ pl08x_dma_tx_status(struct dma_chan *chan,
 	/*
 	 * This cookie not complete yet
 	 */
-	last_used = atomic_read(&plchan->last_issued);
+	last_used = plchan->last_issued;
 	last_complete = plchan->lc;
 
 	/* Get number of bytes left in the active transactions and queue */
@@ -1642,8 +1643,7 @@ static void pl08x_tasklet(unsigned long data)
 		/*
 		 * Update last completed
 		 */
-		plchan->lc =
-			(plchan->at->tx.cookie);
+		plchan->lc = plchan->at->tx.cookie;
 
 		/*
 		 * Device callbacks should NOT clear
@@ -1819,8 +1819,8 @@ static int pl08x_dma_init_virtual_channels(struct pl08x_driver_data *pl08x,
 			 chan->name);
 
 		chan->chan.device = dmadev;
-		atomic_set(&chan->last_issued, 0);
-		chan->lc = atomic_read(&chan->last_issued);
+		chan->last_issued = 0;
+		chan->lc = 0;
 
 		spin_lock_init(&chan->lock);
 		INIT_LIST_HEAD(&chan->desc_list);
diff --git a/include/linux/amba/pl08x.h b/include/linux/amba/pl08x.h
index 521a0f8..bc272c2 100644
--- a/include/linux/amba/pl08x.h
+++ b/include/linux/amba/pl08x.h
@@ -174,7 +174,7 @@ struct pl08x_dma_chan {
 	struct pl08x_channel_data *cd;
 	dma_addr_t runtime_addr;
 	enum dma_data_direction	runtime_direction;
-	atomic_t last_issued;
+	dma_cookie_t last_issued;
 	dma_cookie_t lc;
 	struct list_head desc_list;
 	struct pl08x_txd *at;
-- 
1.6.2.5
