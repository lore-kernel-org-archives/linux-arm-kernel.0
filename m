From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 16 Oct 2014 12:17:03 +0200
Subject: [PATCH v2 04/53] dmaengine: split out pause/resume operations from
 device_control
In-Reply-To: <1413454672-27400-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1413454672-27400-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1413454672-27400-5-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Split out the pause and resume operations to callbacks of their own. In order
to preserve some backwark compatibility, the dmaengine_pause/dmaengine_resume
are still falling back on dmaengine_device_control.

Hopefully, that will allow to get the device capabilities in a generic way,
removing the need to implement device_slave_caps.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 include/linux/dmaengine.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 7937f81e5e2e..b89c8004fcd8 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -612,6 +612,10 @@ struct dma_tx_state {
  *	code
  * @device_control: manipulate all pending operations on a channel, returns
  *	zero or error code
+ * @device_pause: Pauses any transfer happening on a channel. Returns
+ *	0 or an error code
+ * @device_resume: Resumes any transfer on a channel previously
+ *	paused. Returns 0 or an error code
  * @device_tx_status: poll for transaction completion, the optional
  *	txstate parameter can be supplied with a pointer to get a
  *	struct with auxiliary transfer status information, otherwise the call
@@ -680,6 +684,8 @@ struct dma_device {
 			     struct dma_slave_config *config);
 	int (*device_control)(struct dma_chan *chan, enum dma_ctrl_cmd cmd,
 			      unsigned long arg);
+	int (*device_pause)(struct dma_chan *chan);
+	int (*device_resume)(struct dma_chan *chan);
 	enum dma_status (*device_tx_status)(struct dma_chan *chan,
 					    dma_cookie_t cookie,
 					    struct dma_tx_state *txstate);
@@ -783,11 +789,17 @@ static inline int dmaengine_terminate_all(struct dma_chan *chan)
 
 static inline int dmaengine_pause(struct dma_chan *chan)
 {
+	if (chan->device->device_pause)
+		return chan->device->device_pause(chan);
+
 	return dmaengine_device_control(chan, DMA_PAUSE, 0);
 }
 
 static inline int dmaengine_resume(struct dma_chan *chan)
 {
+	if (chan->device->device_resume)
+		return chan->device->device_resume(chan);
+
 	return dmaengine_device_control(chan, DMA_RESUME, 0);
 }
 
-- 
2.1.1
