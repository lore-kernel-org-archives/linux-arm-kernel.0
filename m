From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Tue, 17 Jul 2012 12:53:44 +0200 (CEST)
Subject: [PATCH/RFC 1/4] dma: add a function to request a DMA channel for a
 specific client
In-Reply-To: <Pine.LNX.4.64.1207171201550.11241@axis700.grange>
References: <Pine.LNX.4.64.1207171201550.11241@axis700.grange>
Message-ID: <Pine.LNX.4.64.1207171242230.17060@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a new channel-request function, that uses a device pointer and a
transfer direction to locate the required client DMA request line. Devices,
that require DMA channels exceeding the traditional Tx / Rx scheme, can use
the optional "name" parameter.

This new function uses a new DMA multiplexer interface. The new DMA request
line routing concept declares, that client DMA request lines are always
statically connected to a DMA provider. If a client is directly connected
to a DMAC, such a statical connection results in a 1-to-1 relationship
between client DMA request lines and DMAC DMA channels. A more flexible
configuration includes a multiplexer between clients and DMAC instances. In
these cases it is the multiplexer, that controls the routing. The initial
DMA multiplexer API consists of only one call-back: .request_chan(), that
finds the next free (physical or virtual) DMA channel, that can be routed
to the requested slave DMA interface. The actual routing, if required,
should be performed as a part of the dmaengine_slave_config() processing.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/dma/dmaengine.c   |   73 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/dmaengine.h |    9 +++++
 2 files changed, 82 insertions(+), 0 deletions(-)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index 2397f6f..4fb927c 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -542,6 +542,79 @@ struct dma_chan *__dma_request_channel(dma_cap_mask_t *mask, dma_filter_fn fn, v
 }
 EXPORT_SYMBOL_GPL(__dma_request_channel);
 
+/**
+ * dma_request_slave_channel() - try to allocate an exclusive channel for device
+ * @dev:	client device, for which a channel should be allocated
+ * @direction:	transfer direction
+ * @name:	optional name of the channel, used, when the direction is not
+ *		sufficient to uniquely identify the DMA request
+ */
+struct dma_chan *dma_request_slave_channel(struct device *dev,
+		enum dma_transfer_direction direction, const char *name)
+{
+	struct dma_device *device, *_d;
+	struct dma_chan *chan = NULL;
+	dma_cap_mask_t mask;
+	int err;
+
+	dma_cap_zero(mask);
+	dma_cap_set(DMA_SLAVE, mask);
+
+	/* Find a channel */
+	mutex_lock(&dma_list_mutex);
+	list_for_each_entry_safe(device, _d, &dma_device_list, global_node) {
+		if (!device->mux || !device->mux->request_chan)
+			continue;
+
+		if (!dma_device_satisfies_mask(device, mask)) {
+			pr_info("%s: wrong capabilities\n", __func__);
+			continue;
+		}
+
+		/* ensure that all channels are either private or public. */
+		if (!dma_has_cap(DMA_PRIVATE, device->cap_mask)) {
+			bool public = false;
+			list_for_each_entry(chan, &device->channels, device_node) {
+				/* some channels are already publicly allocated */
+				if (chan->client_count) {
+					public = true;
+					break;
+				}
+			}
+			if (public)
+				continue;
+		}
+
+		chan = device->mux->request_chan(device, dev, direction, name);
+		if (chan) {
+			dma_cap_set(DMA_PRIVATE, device->cap_mask);
+			device->privatecnt++;
+			err = dma_chan_get(chan);
+			if (!err)
+				break;
+			if (err == -ENODEV) {
+				pr_debug("%s: %s module removed\n", __func__,
+					 dma_chan_name(chan));
+				list_del_rcu(&device->global_node);
+			} else
+				pr_debug("%s: failed to get %s: (%d)\n",
+					 __func__, dma_chan_name(chan), err);
+
+			if (--device->privatecnt == 0)
+				dma_cap_clear(DMA_PRIVATE, device->cap_mask);
+
+			chan = NULL;
+		}
+	}
+	mutex_unlock(&dma_list_mutex);
+
+	pr_debug("%s: %s (%s)\n", __func__, chan ? "success" : "fail",
+		 chan ? dma_chan_name(chan) : NULL);
+
+	return chan;
+}
+EXPORT_SYMBOL_GPL(dma_request_slave_channel);
+
 void dma_release_channel(struct dma_chan *chan)
 {
 	mutex_lock(&dma_list_mutex);
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index ccec62f..19b96d9 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -482,6 +482,11 @@ static inline struct dma_async_tx_descriptor *txd_next(struct dma_async_tx_descr
 }
 #endif
 
+struct dma_multiplexer {
+	struct dma_chan *(*request_chan)(struct dma_device *, struct device *,
+				enum dma_transfer_direction, const char *);
+};
+
 /**
  * struct dma_tx_state - filled in to report the status of
  * a transfer.
@@ -553,6 +558,8 @@ struct dma_device {
 	int dev_id;
 	struct device *dev;
 
+	const struct dma_multiplexer *mux;
+
 	int (*device_alloc_chan_resources)(struct dma_chan *chan);
 	void (*device_free_chan_resources)(struct dma_chan *chan);
 
@@ -994,6 +1001,8 @@ void dma_run_dependencies(struct dma_async_tx_descriptor *tx);
 struct dma_chan *dma_find_channel(enum dma_transaction_type tx_type);
 struct dma_chan *net_dma_find_channel(void);
 #define dma_request_channel(mask, x, y) __dma_request_channel(&(mask), x, y)
+struct dma_chan *dma_request_slave_channel(struct device *dev,
+		enum dma_transfer_direction direction, const char *name);
 
 /* --- Helper iov-locking functions --- */
 
-- 
1.7.2.5
