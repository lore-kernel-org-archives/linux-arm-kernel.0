From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Wed, 10 Feb 2010 16:44:40 +0100 (CET)
Subject: [PATCH] async-tx: fix buffer sumbission error handling in ipu_idma.c
Message-ID: <Pine.LNX.4.64.1002101643390.4495@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If submitting new buffer failed, a wrong descriptor gets completed and it
doesn't check, if a callback is at all defined, which can lead to an Oops. Fix
these bugs and make ipu_update_channel_buffer() void, because it never fails.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/dma/ipu/ipu_idmac.c |   24 +++++++-----------------
 1 files changed, 7 insertions(+), 17 deletions(-)

diff --git a/drivers/dma/ipu/ipu_idmac.c b/drivers/dma/ipu/ipu_idmac.c
index 9a5bc1a..fbc5d25 100644
--- a/drivers/dma/ipu/ipu_idmac.c
+++ b/drivers/dma/ipu/ipu_idmac.c
@@ -761,12 +761,10 @@ static void ipu_select_buffer(enum ipu_channel channel, int buffer_n)
  * @buffer_n:	buffer number to update.
  *		0 or 1 are the only valid values.
  * @phyaddr:	buffer physical address.
- * @return:	Returns 0 on success or negative error code on failure. This
- *              function will fail if the buffer is set to ready.
  */
 /* Called under spin_lock(_irqsave)(&ichan->lock) */
-static int ipu_update_channel_buffer(struct idmac_channel *ichan,
-				     int buffer_n, dma_addr_t phyaddr)
+static void ipu_update_channel_buffer(struct idmac_channel *ichan,
+				      int buffer_n, dma_addr_t phyaddr)
 {
 	enum ipu_channel channel = ichan->dma_chan.chan_id;
 	uint32_t reg;
@@ -806,8 +804,6 @@ static int ipu_update_channel_buffer(struct idmac_channel *ichan,
 	}
 
 	spin_unlock_irqrestore(&ipu_data.lock, flags);
-
-	return 0;
 }
 
 /* Called under spin_lock_irqsave(&ichan->lock) */
@@ -827,14 +823,7 @@ static int ipu_submit_buffer(struct idmac_channel *ichan,
 	 * could make it conditional on status >= IPU_CHANNEL_ENABLED, but
 	 * doing it again shouldn't hurt either.
 	 */
-	ret = ipu_update_channel_buffer(ichan, buf_idx,
-					sg_dma_address(sg));
-
-	if (ret < 0) {
-		dev_err(dev, "Updating sg %p on channel 0x%x buffer %d failed!\n",
-			sg, chan_id, buf_idx);
-		return ret;
-	}
+	ipu_update_channel_buffer(ichan, buf_idx, sg_dma_address(sg));
 
 	ipu_select_buffer(chan_id, buf_idx);
 	dev_dbg(dev, "Updated sg %p on channel 0x%x buffer %d\n",
@@ -1379,10 +1368,11 @@ static irqreturn_t idmac_interrupt(int irq, void *dev_id)
 
 	if (likely(sgnew) &&
 	    ipu_submit_buffer(ichan, descnew, sgnew, ichan->active_buffer) < 0) {
-		callback = desc->txd.callback;
-		callback_param = desc->txd.callback_param;
+		callback = descnew->txd.callback;
+		callback_param = descnew->txd.callback_param;
 		spin_unlock(&ichan->lock);
-		callback(callback_param);
+		if (callback)
+			callback(callback_param);
 		spin_lock(&ichan->lock);
 	}
 
-- 
1.6.2.4
