From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 03 Jan 2011 22:34:48 +0000
Subject: [PATCH 14/48] ARM: PL08x: remove circular buffer support
In-Reply-To: <20110103222943.GB4572@n2100.arm.linux.org.uk>
References: <20110103222943.GB4572@n2100.arm.linux.org.uk>
Message-ID: <E1PZszI-0001Op-2P@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The driver already won't initialize a channel with a circular buffer;
the check in pl08x_prep_channel_resources() sees to that.  Remove
circular buffer support for the time being.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/amba-pl08x.c |   71 +++++++++++++---------------------------------
 1 files changed, 20 insertions(+), 51 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index b721ed2..74b3591 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -927,39 +927,21 @@ static int pl08x_fill_llis_for_desc(struct pl08x_driver_data *pl08x,
 			__func__, (u32) MAX_NUM_TSFR_LLIS);
 		return 0;
 	}
+
+	llis_va = txd->llis_va;
 	/*
-	 * Decide whether this is a loop or a terminated transfer
+	 * The final LLI terminates the LLI.
 	 */
-	llis_va = txd->llis_va;
-	llis_bus = (struct lli *) txd->llis_bus;
-
-	if (cd->circular_buffer) {
-		/*
-		 * Loop the circular buffer so that the next element
-		 * points back to the beginning of the LLI.
-		 */
-		llis_va[num_llis - 1].next =
-			(dma_addr_t)((unsigned int)&(llis_bus[0]));
-	} else {
-		/*
-		 * On non-circular buffers, the final LLI terminates
-		 * the LLI.
-		 */
-		llis_va[num_llis - 1].next = 0;
-		/*
-		 * The final LLI element shall also fire an interrupt
-		 */
-		llis_va[num_llis - 1].cctl |= PL080_CONTROL_TC_IRQ_EN;
-	}
+	llis_va[num_llis - 1].next = 0;
+	/*
+	 * The final LLI element shall also fire an interrupt
+	 */
+	llis_va[num_llis - 1].cctl |= PL080_CONTROL_TC_IRQ_EN;
 
 	/* Now store the channel register values */
 	txd->csrc = llis_va[0].src;
 	txd->cdst = llis_va[0].dst;
-	if (num_llis > 1)
-		txd->clli = llis_va[0].next;
-	else
-		txd->clli = 0;
-
+	txd->clli = llis_va[0].next;
 	txd->cctl = llis_va[0].cctl;
 	/* ccfg will be set at physical channel allocation time */
 
@@ -1334,19 +1316,7 @@ static int pl08x_prep_channel_resources(struct pl08x_dma_chan *plchan,
 
 	spin_lock_irqsave(&plchan->lock, plchan->lockflags);
 
-	/*
-	 * If this device is not using a circular buffer then
-	 * queue this new descriptor for transfer.
-	 * The descriptor for a circular buffer continues
-	 * to be used until the channel is freed.
-	 */
-	if (txd->cd->circular_buffer)
-		dev_err(&pl08x->adev->dev,
-			"%s attempting to queue a circular buffer\n",
-			__func__);
-	else
-		list_add_tail(&txd->node,
-			      &plchan->desc_list);
+	list_add_tail(&txd->node, &plchan->desc_list);
 
 	/*
 	 * See if we already have a physical channel allocated,
@@ -1643,18 +1613,10 @@ static void pl08x_tasklet(unsigned long data)
 			callback(callback_param);
 
 		/*
-		 * Free the descriptor if it's not for a device
-		 * using a circular buffer
-		 */
-		if (!plchan->at->cd->circular_buffer) {
-			pl08x_free_txd(pl08x, plchan->at);
-			plchan->at = NULL;
-		}
-		/*
-		 * else descriptor for circular
-		 * buffers only freed when
-		 * client has disabled dma
+		 * Free the descriptor
 		 */
+		pl08x_free_txd(pl08x, plchan->at);
+		plchan->at = NULL;
 	}
 	/*
 	 * If a new descriptor is queued, set it up
@@ -1799,6 +1761,13 @@ static int pl08x_dma_init_virtual_channels(struct pl08x_driver_data *pl08x,
 				return -ENOMEM;
 			}
 		}
+		if (chan->cd->circular_buffer) {
+			dev_err(&pl08x->adev->dev,
+				"channel %s: circular buffers not supported\n",
+				chan->name);
+			kfree(chan);
+			continue;
+		}
 		dev_info(&pl08x->adev->dev,
 			 "initialize virtual channel \"%s\"\n",
 			 chan->name);
-- 
1.6.2.5
