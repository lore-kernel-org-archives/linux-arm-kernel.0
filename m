From: mporter@ti.com (Matt Porter)
Date: Thu, 11 Oct 2012 15:04:34 -0400
Subject: [RFC PATCH v2 09/16] dmaengine: add dma_request_slave_channel_compat()
In-Reply-To: <1349982281-10785-1-git-send-email-mporter@ti.com>
References: <1349982281-10785-1-git-send-email-mporter@ti.com>
Message-ID: <1349982281-10785-10-git-send-email-mporter@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds a dma_request_slave_channel_compat() wrapper which accepts
both the arguments from dma_request_channel() and
dma_request_slave_channel(). Based on whether the driver is
instantiated via DT, the appropriate channel request call will be
made.

This allows for a much cleaner migration of drivers to the
dmaengine DT API as platforms continue to be mixed between those
that boot using DT and those that do not.

Suggested-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Matt Porter <mporter@ti.com>
---
 include/linux/dmaengine.h |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index c88f302..11d9e25 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -1007,6 +1007,16 @@ void dma_run_dependencies(struct dma_async_tx_descriptor *tx);
 struct dma_chan *dma_find_channel(enum dma_transaction_type tx_type);
 struct dma_chan *net_dma_find_channel(void);
 #define dma_request_channel(mask, x, y) __dma_request_channel(&(mask), x, y)
+static inline struct dma_chan
+*dma_request_slave_channel_compat(dma_cap_mask_t mask, dma_filter_fn fn,
+				  void *fn_param, struct device *dev,
+				  char *name)
+{
+	if (dev->of_node)
+		return dma_request_slave_channel(dev, name);
+	else
+		return dma_request_channel(mask, fn, fn_param);
+}
 
 /* --- Helper iov-locking functions --- */
 
-- 
1.7.9.5
