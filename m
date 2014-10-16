From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 16 Oct 2014 12:17:05 +0200
Subject: [PATCH v2 06/53] dmaengine: Create a generic dma_slave_caps callback
In-Reply-To: <1413454672-27400-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1413454672-27400-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1413454672-27400-7-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

dma_slave_caps is very important to the generic layers that might interact with
dmaengine, such as ASoC. Unfortunately, it has been added as yet another
dma_device callback, and most of the existing drivers haven't implemented it,
reducing its reliability.

Introduce a generic behaviour and a flag to trigger it. In case this flag
hasn't been set, fall back to the old mechanism.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 include/linux/dmaengine.h | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 4d0294ec3567..85afd71df2e7 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -643,6 +643,8 @@ struct dma_device {
 	int dev_id;
 	struct device *dev;
 
+	bool generic_slave_caps;
+
 	int (*device_alloc_chan_resources)(struct dma_chan *chan);
 	void (*device_free_chan_resources)(struct dma_chan *chan);
 
@@ -772,17 +774,32 @@ static inline struct dma_async_tx_descriptor *dmaengine_prep_interleaved_dma(
 
 static inline int dma_get_slave_caps(struct dma_chan *chan, struct dma_slave_caps *caps)
 {
+	struct dma_device *device;
+
 	if (!chan || !caps)
 		return -EINVAL;
 
+	device = chan->device;
+
 	/* check if the channel supports slave transactions */
-	if (!test_bit(DMA_SLAVE, chan->device->cap_mask.bits))
+	if (!test_bit(DMA_SLAVE, device->cap_mask.bits))
+		return -ENXIO;
+
+	if (device->device_slave_caps)
+		return device->device_slave_caps(chan, caps);
+
+	/*
+	 * Check whether it reports it uses the generic slave
+	 * capabilities, if not, that means it doesn't support any
+	 * kind of slave capabilities reporting.
+	 */
+	if (device->generic_slave_caps)
 		return -ENXIO;
 
-	if (chan->device->device_slave_caps)
-		return chan->device->device_slave_caps(chan, caps);
+	caps->cmd_pause = !!device->device_pause;
+	caps->cmd_terminate = !!device->device_terminate_all;
 
-	return -ENXIO;
+	return 0;
 }
 
 static inline int dmaengine_terminate_all(struct dma_chan *chan)
-- 
2.1.1
