From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 03 Jan 2011 22:45:17 +0000
Subject: [PATCH 45/48] ARM: PL08x: introduce 'phychan_hold' to hold on to
	physical channels
In-Reply-To: <20110103222943.GB4572@n2100.arm.linux.org.uk>
References: <20110103222943.GB4572@n2100.arm.linux.org.uk>
Message-ID: <E1PZt9R-0003SK-IK@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Introduce 'phychan_hold' to hold on to physical DMA channels while we're
preparing a new descriptor for it.  This will be incremented when we
allocate a physical channel and set the MUX registers during the
preparation of the TXD, and will only be decremented when the TXD is
submitted.

This prevents the physical channel being given up before the new TXD
is placed on the queue.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/amba-pl08x.c   |   11 +++++++++++
 include/linux/amba/pl08x.h |    3 +++
 2 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index 650e2bb..bf6f7d0 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -959,6 +959,7 @@ static int prep_phy_channel(struct pl08x_dma_chan *plchan,
 		 ch->signal,
 		 plchan->name);
 
+	plchan->phychan_hold++;
 	plchan->phychan = ch;
 
 	return 0;
@@ -998,6 +999,8 @@ static dma_cookie_t pl08x_tx_submit(struct dma_async_tx_descriptor *tx)
 		/* Do this memcpy whenever there is a channel ready */
 		plchan->state = PL08X_CHAN_WAITING;
 		plchan->waiting = txd;
+	} else {
+		plchan->phychan_hold--;
 	}
 
 	/* This unlock follows the lock in the prep() function */
@@ -1585,6 +1588,7 @@ static void pl08x_tasklet(unsigned long data)
 		 */
 		plchan->lc = txd->tx.cookie;
 	}
+
 	/*
 	 * If a new descriptor is queued, set it up
 	 * plchan->at is NULL here
@@ -1598,6 +1602,12 @@ static void pl08x_tasklet(unsigned long data)
 		list_del(&next->node);
 
 		pl08x_start_txd(plchan, next);
+	} else if (plchan->phychan_hold) {
+		/*
+		 * This channel is still in use - we have a new txd being
+		 * prepared and will soon be queued.  Don't give up the
+		 * physical channel.
+		 */
 	} else {
 		struct pl08x_dma_chan *waiting = NULL;
 
@@ -1625,6 +1635,7 @@ static void pl08x_tasklet(unsigned long data)
 				ret = prep_phy_channel(waiting,
 						       waiting->waiting);
 				BUG_ON(ret);
+				waiting->phychan_hold--;
 				waiting->state = PL08X_CHAN_RUNNING;
 				waiting->waiting = NULL;
 				pl08x_issue_pending(&waiting->chan);
diff --git a/include/linux/amba/pl08x.h b/include/linux/amba/pl08x.h
index 08a9024..95b76ea 100644
--- a/include/linux/amba/pl08x.h
+++ b/include/linux/amba/pl08x.h
@@ -151,6 +151,8 @@ enum pl08x_dma_chan_state {
  * struct pl08x_dma_chan - this structure wraps a DMA ENGINE channel
  * @chan: wrappped abstract channel
  * @phychan: the physical channel utilized by this channel, if there is one
+ * @phychan_hold: if non-zero, hold on to the physical channel even if we
+ *  have no pending entries
  * @tasklet: tasklet scheduled by the IRQ to handle actual work etc
  * @name: name of channel
  * @cd: channel platform data
@@ -173,6 +175,7 @@ enum pl08x_dma_chan_state {
 struct pl08x_dma_chan {
 	struct dma_chan chan;
 	struct pl08x_phy_chan *phychan;
+	int phychan_hold;
 	struct tasklet_struct tasklet;
 	char *name;
 	struct pl08x_channel_data *cd;
-- 
1.6.2.5
