From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sun,  6 Sep 2015 13:40:53 +0200
Subject: [PATCH 2/3] dmaengine: enable DMA_CTRL_REUSE
In-Reply-To: <1441539654-19055-1-git-send-email-robert.jarzmik@free.fr>
References: <1441539654-19055-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <1441539654-19055-2-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In the current state, the capability of transfer reuse can neither be
set by a slave dmaengine driver, nor used by a client driver, because
the capability is not available to dma_get_slave_caps().

Fix this by adding a way to declare the capability.

Fixes: 272420214d26 ("dmaengine: Add DMA_CTRL_REUSE")
Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 drivers/dma/dmaengine.c   | 1 +
 include/linux/dmaengine.h | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index 3ff284c8e3d5..bb33e2ff5a42 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -493,6 +493,7 @@ int dma_get_slave_caps(struct dma_chan *chan, struct dma_slave_caps *caps)
 	caps->dst_addr_widths = device->dst_addr_widths;
 	caps->directions = device->directions;
 	caps->residue_granularity = device->residue_granularity;
+	caps->descriptor_reuse = device->descriptor_reuse;
 
 	/*
 	 * Some devices implement only pause (e.g. to get residuum) but no
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index e2f5eb419976..71b95257d835 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -635,6 +635,7 @@ struct dma_tx_state {
  *	struct with auxiliary transfer status information, otherwise the call
  *	will just return a simple status code
  * @device_issue_pending: push pending transactions to hardware
+ * @descriptor_reuse: a submitted transfer can be resubmitted after completion
  */
 struct dma_device {
 
@@ -657,6 +658,7 @@ struct dma_device {
 	u32 src_addr_widths;
 	u32 dst_addr_widths;
 	u32 directions;
+	bool descriptor_reuse;
 	enum dma_residue_granularity residue_granularity;
 
 	int (*device_alloc_chan_resources)(struct dma_chan *chan);
-- 
2.1.4
