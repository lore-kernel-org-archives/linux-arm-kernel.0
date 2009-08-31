From: dan.j.williams@intel.com (Dan Williams)
Date: Mon, 31 Aug 2009 08:40:42 -0700
Subject: [PATCH v2 1/4] iop-adma: cleanup iop_adma_run_tx_complete_actions
In-Reply-To: <20090831153946.1068.86702.stgit@dwillia2-linux.ch.intel.com>
References: <20090831153946.1068.86702.stgit@dwillia2-linux.ch.intel.com>
Message-ID: <20090831154042.1068.4140.stgit@dwillia2-linux.ch.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace 'desc->async_tx.' with 'tx->'

[ Impact: pure cleanup ]

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/dma/iop-adma.c |   19 ++++++++++---------
 1 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/iop-adma.c b/drivers/dma/iop-adma.c
index 4496bc6..ce45f3f 100644
--- a/drivers/dma/iop-adma.c
+++ b/drivers/dma/iop-adma.c
@@ -61,17 +61,18 @@ static dma_cookie_t
 iop_adma_run_tx_complete_actions(struct iop_adma_desc_slot *desc,
 	struct iop_adma_chan *iop_chan, dma_cookie_t cookie)
 {
-	BUG_ON(desc->async_tx.cookie < 0);
-	if (desc->async_tx.cookie > 0) {
-		cookie = desc->async_tx.cookie;
-		desc->async_tx.cookie = 0;
+	struct dma_async_tx_descriptor *tx = &desc->async_tx;
+
+	BUG_ON(tx->cookie < 0);
+	if (tx->cookie > 0) {
+		cookie = tx->cookie;
+		tx->cookie = 0;
 
 		/* call the callback (must not sleep or submit new
 		 * operations to this channel)
 		 */
-		if (desc->async_tx.callback)
-			desc->async_tx.callback(
-				desc->async_tx.callback_param);
+		if (tx->callback)
+			tx->callback(tx->callback_param);
 
 		/* unmap dma addresses
 		 * (unmap_single vs unmap_page?)
@@ -81,7 +82,7 @@ iop_adma_run_tx_complete_actions(struct iop_adma_desc_slot *desc,
 			struct device *dev =
 				&iop_chan->device->pdev->dev;
 			u32 len = unmap->unmap_len;
-			enum dma_ctrl_flags flags = desc->async_tx.flags;
+			enum dma_ctrl_flags flags = tx->flags;
 			u32 src_cnt;
 			dma_addr_t addr;
 			dma_addr_t dest;
@@ -115,7 +116,7 @@ iop_adma_run_tx_complete_actions(struct iop_adma_desc_slot *desc,
 	}
 
 	/* run dependent operations */
-	dma_run_dependencies(&desc->async_tx);
+	dma_run_dependencies(tx);
 
 	return cookie;
 }
