From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 22 Oct 2014 17:43:20 +0200
Subject: [PATCH v3 06/59] dmaengine: Introduce a device_config callback
In-Reply-To: <1413992653-21963-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1413992653-21963-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1413992653-21963-7-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The fact that the channel configuration is done in device_control is rather
misleading, since it's not really advertised as such, plus, the fact that the
framework exposes a function of its own makes it not really intuitive, while
we're losing the type checking whenever we pass that unsigned long argument.

Add a device_config callback to dma_device, with a fallback on the old
behaviour for now for existing drivers to opt in.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 include/linux/dmaengine.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 4d912575fec0..f797cb81355f 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -607,6 +607,8 @@ struct dma_tx_state {
  *	The function takes a buffer of size buf_len. The callback function will
  *	be called after period_len bytes have been transferred.
  * @device_prep_interleaved_dma: Transfer expression in a generic way.
+ * @device_config: Pushes a new configuration to a channel, return 0 or an error
+ *	code
  * @device_control: manipulate all pending operations on a channel, returns
  *	zero or error code
  * @device_tx_status: poll for transaction completion, the optional
@@ -673,6 +675,9 @@ struct dma_device {
 	struct dma_async_tx_descriptor *(*device_prep_interleaved_dma)(
 		struct dma_chan *chan, struct dma_interleaved_template *xt,
 		unsigned long flags);
+
+	int (*device_config)(struct dma_chan *chan,
+			     struct dma_slave_config *config);
 	int (*device_control)(struct dma_chan *chan, enum dma_ctrl_cmd cmd,
 		unsigned long arg);
 
@@ -696,6 +701,9 @@ static inline int dmaengine_device_control(struct dma_chan *chan,
 static inline int dmaengine_slave_config(struct dma_chan *chan,
 					  struct dma_slave_config *config)
 {
+	if (chan->device->device_config)
+		return chan->device->device_config(chan, config);
+
 	return dmaengine_device_control(chan, DMA_SLAVE_CONFIG,
 			(unsigned long)config);
 }
-- 
2.1.1
