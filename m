From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Wed, 10 Feb 2010 17:32:38 +0100 (CET)
Subject: [PATCH v2] async-tx: fix buffer sumbission error handling in
	ipu_idma.c
In-Reply-To: <e9c3a7c21002100754k7737b79cvb13a2b39ad16cc44@mail.gmail.com>
References: <Pine.LNX.4.64.1002101643390.4495@axis700.grange>
	<e9c3a7c21002100754k7737b79cvb13a2b39ad16cc44@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.1002101659580.4495@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If submitting new buffer failed, a wrong descriptor gets completed and it
doesn't check, if a callback is at all defined, which can lead to an Oops. Fix
these bugs and make ipu_update_channel_buffer() void, because it never fails.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

v1 -> v2: When fixing Oopses remember to not introduce compiler warnings;)

On Wed, 10 Feb 2010, Dan Williams wrote:

> On Wed, Feb 10, 2010 at 8:44 AM, Guennadi Liakhovetski
> <g.liakhovetski@gmx.de> wrote:
> > If submitting new buffer failed, a wrong descriptor gets completed and it
> > doesn't check, if a callback is at all defined, which can lead to an Oops. Fix
> > these bugs and make ipu_update_channel_buffer() void, because it never fails.
> >
> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> 
> Looks like 2.6.33 material.  Shall I tag it for -stable as well?

This is more of a theoretical Oops possibility. You have to really try 
hard to get it - if at all possible. At least I've never seen one and 
never heard anyone seeing it. So, strictly speaking, I don't think this 
bug can hurt anyone, but, if Sascha has nothing against this patch, you 
can push it to stable too.

 drivers/dma/ipu/ipu_idmac.c |   25 +++++++------------------
 1 files changed, 7 insertions(+), 18 deletions(-)

diff --git a/drivers/dma/ipu/ipu_idmac.c b/drivers/dma/ipu/ipu_idmac.c
index 9a5bc1a..e80bae1 100644
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
@@ -816,7 +812,6 @@ static int ipu_submit_buffer(struct idmac_channel *ichan,
 {
 	unsigned int chan_id = ichan->dma_chan.chan_id;
 	struct device *dev = &ichan->dma_chan.dev->device;
-	int ret;
 
 	if (async_tx_test_ack(&desc->txd))
 		return -EINTR;
@@ -827,14 +822,7 @@ static int ipu_submit_buffer(struct idmac_channel *ichan,
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
@@ -1379,10 +1367,11 @@ static irqreturn_t idmac_interrupt(int irq, void *dev_id)
 
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
