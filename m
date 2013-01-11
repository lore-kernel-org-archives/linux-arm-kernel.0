From: mporter@ti.com (Matt Porter)
Date: Fri, 11 Jan 2013 00:48:43 -0500
Subject: [PATCH v4 07/14] dmaengine: add dma_request_slave_channel_compat()
In-Reply-To: <1357883330-5364-1-git-send-email-mporter@ti.com>
References: <1357883330-5364-1-git-send-email-mporter@ti.com>
Message-ID: <1357883330-5364-8-git-send-email-mporter@ti.com>
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
index 9fd0c5b..64f9f69 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -1047,6 +1047,16 @@ void dma_run_dependencies(struct dma_async_tx_descriptor *tx);
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
