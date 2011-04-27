From: viresh.kumar@st.com (Viresh Kumar)
Date: Wed, 27 Apr 2011 15:06:45 +0530
Subject: [PATCH V3 3/7] dmaengine/dw_dmac: don't call callback routine in case
	dmaengine_terminate_all() is called
In-Reply-To: <cover.1303896566.git.viresh.kumar@st.com>
References: <cover.1303896566.git.viresh.kumar@st.com>
Message-ID: <b5e9038ecac3f44d265c7321de551bd9b66cdddd.1303896567.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If dmaengine_terminate_all() is called for dma channel, then it doesn't make
much sense to call registered callback routine. While in case of success or
failure it must be called.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 drivers/dma/dw_dmac.c |   27 ++++++++++++++-------------
 1 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/dma/dw_dmac.c b/drivers/dma/dw_dmac.c
index b6dfc39..f590109 100644
--- a/drivers/dma/dw_dmac.c
+++ b/drivers/dma/dw_dmac.c
@@ -198,7 +198,8 @@ static void dwc_dostart(struct dw_dma_chan *dwc, struct dw_desc *first)
 /*----------------------------------------------------------------------*/
 
 static void
-dwc_descriptor_complete(struct dw_dma_chan *dwc, struct dw_desc *desc)
+dwc_descriptor_complete(struct dw_dma_chan *dwc, struct dw_desc *desc,
+		bool callback_required)
 {
 	dma_async_tx_callback		callback;
 	void				*param;
@@ -208,8 +209,10 @@ dwc_descriptor_complete(struct dw_dma_chan *dwc, struct dw_desc *desc)
 	dev_vdbg(chan2dev(&dwc->chan), "descriptor %u complete\n", txd->cookie);
 
 	dwc->completed = txd->cookie;
-	callback = txd->callback;
-	param = txd->callback_param;
+	if (callback_required) {
+		callback = txd->callback;
+		param = txd->callback_param;
+	}
 
 	dwc_sync_desc_for_cpu(dwc, desc);
 
@@ -241,12 +244,10 @@ dwc_descriptor_complete(struct dw_dma_chan *dwc, struct dw_desc *desc)
 		}
 	}
 
-	/*
-	 * The API requires that no submissions are done from a
-	 * callback, so we don't need to drop the lock here
-	 */
-	if (callback)
-		callback(param);
+	if (callback_required) {
+		if (callback)
+			callback(param);
+	}
 }
 
 static void dwc_complete_all(struct dw_dma *dw, struct dw_dma_chan *dwc)
@@ -275,7 +276,7 @@ static void dwc_complete_all(struct dw_dma *dw, struct dw_dma_chan *dwc)
 	}
 
 	list_for_each_entry_safe(desc, _desc, &list, desc_node)
-		dwc_descriptor_complete(dwc, desc);
+		dwc_descriptor_complete(dwc, desc, 1);
 }
 
 static void dwc_scan_descriptors(struct dw_dma *dw, struct dw_dma_chan *dwc)
@@ -325,7 +326,7 @@ static void dwc_scan_descriptors(struct dw_dma *dw, struct dw_dma_chan *dwc)
 		 * No descriptors so far seem to be in progress, i.e.
 		 * this one must be done.
 		 */
-		dwc_descriptor_complete(dwc, desc);
+		dwc_descriptor_complete(dwc, desc, 1);
 	}
 
 	dev_err(chan2dev(&dwc->chan),
@@ -387,7 +388,7 @@ static void dwc_handle_error(struct dw_dma *dw, struct dw_dma_chan *dwc)
 		dwc_dump_lli(dwc, &child->lli);
 
 	/* Pretend the descriptor completed successfully */
-	dwc_descriptor_complete(dwc, bad_desc);
+	dwc_descriptor_complete(dwc, bad_desc, 1);
 }
 
 /* --------------------- Cyclic DMA API extensions -------------------- */
@@ -837,7 +838,7 @@ static int dwc_control(struct dma_chan *chan, enum dma_ctrl_cmd cmd,
 
 	/* Flush all pending and queued descriptors */
 	list_for_each_entry_safe(desc, _desc, &list, desc_node)
-		dwc_descriptor_complete(dwc, desc);
+		dwc_descriptor_complete(dwc, desc, 0);
 
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
-- 
1.7.3.4
