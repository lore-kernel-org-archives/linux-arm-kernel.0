From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 27 Sep 2014 10:54:42 +0200
Subject: [PATCH 6/9] dmaengine: Create a generic dma_slave_caps callback
In-Reply-To: <1411808085-27792-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1411808085-27792-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1411808085-27792-7-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

dma_slave_caps is very important to the generic layers that might interact with
dmaengine, such as ASoC. Unfortunately, it has been added as yet another
dma_device callback, and most of the existing drivers haven't implemented it,
reducing its reliability.

Introduce a generic behaviour, pre-filling the dma_slave_caps struct with what
it knows about the dma controller, before calling the dma_device callback, both
to maintain a backward compatibility and to make sure that drivers can override
that generic behaviour.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 include/linux/dmaengine.h | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 4d0294ec3567..cfcbee145898 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -772,17 +772,24 @@ static inline struct dma_async_tx_descriptor *dmaengine_prep_interleaved_dma(
 
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
 		return -ENXIO;
 
-	if (chan->device->device_slave_caps)
-		return chan->device->device_slave_caps(chan, caps);
+	caps->cmd_pause = !!device->device_pause;
+	caps->cmd_terminate = !!device->device_terminate_all;
+
+	if (device->device_slave_caps)
+		return device->device_slave_caps(chan, caps);
 
-	return -ENXIO;
+	return 0;
 }
 
 static inline int dmaengine_terminate_all(struct dma_chan *chan)
-- 
2.1.0
