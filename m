From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Tue, 13 Oct 2015 21:54:29 +0200
Subject: [PATCH v2 2/3] dmaengine: enable DMA_CTRL_REUSE
In-Reply-To: <1444766070-26915-1-git-send-email-robert.jarzmik@free.fr>
References: <1444766070-26915-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <1444766070-26915-2-git-send-email-robert.jarzmik@free.fr>
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
index 09479d4be4db..0d64dc8627a8 100644
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
index 7ea9184eaa13..2fd8344f219b 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -658,6 +658,7 @@ enum dmaengine_alignment {
  *	struct with auxiliary transfer status information, otherwise the call
  *	will just return a simple status code
  * @device_issue_pending: push pending transactions to hardware
+ * @descriptor_reuse: a submitted transfer can be resubmitted after completion
  */
 struct dma_device {
 
@@ -680,6 +681,7 @@ struct dma_device {
 	u32 src_addr_widths;
 	u32 dst_addr_widths;
 	u32 directions;
+	bool descriptor_reuse;
 	enum dma_residue_granularity residue_granularity;
 
 	int (*device_alloc_chan_resources)(struct dma_chan *chan);
-- 
2.1.4
