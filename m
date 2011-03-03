From: viresh.kumar@st.com (Viresh Kumar)
Date: Thu, 3 Mar 2011 15:47:20 +0530
Subject: [PATCH V2 07/13] dw_dmac: Mark all tx_descriptors with DMA_CRTL_ACK
	after xfer finish
In-Reply-To: <cover.1299146382.git.viresh.kumar@st.com>
References: <cover.1299146382.git.viresh.kumar@st.com>
Message-ID: <2532583bc4c61efb844ed151273d77f5760a5762.1299146382.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

dwc_desc_get checks all descriptors for DMA_CTRL_ACK before allocating them for
transfers. And descriptors are not marked with DMA_CRTL_ACK after transfer
finishes. Thus descriptor once used is not usable again. This patch marks
descriptors with DMA_CRTL_ACK after dma xfer finishes

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 drivers/dma/dw_dmac.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/dma/dw_dmac.c b/drivers/dma/dw_dmac.c
index 734829f..836c299 100644
--- a/drivers/dma/dw_dmac.c
+++ b/drivers/dma/dw_dmac.c
@@ -198,6 +198,7 @@ dwc_descriptor_complete(struct dw_dma_chan *dwc, struct dw_desc *desc)
 	dma_async_tx_callback		callback;
 	void				*param;
 	struct dma_async_tx_descriptor	*txd = &desc->txd;
+	struct dw_desc			*child;
 
 	dev_vdbg(chan2dev(&dwc->chan), "descriptor %u complete\n", txd->cookie);
 
@@ -206,6 +207,12 @@ dwc_descriptor_complete(struct dw_dma_chan *dwc, struct dw_desc *desc)
 	param = txd->callback_param;
 
 	dwc_sync_desc_for_cpu(dwc, desc);
+
+	/* async_tx_ack */
+	list_for_each_entry(child, &desc->tx_list, desc_node)
+		async_tx_ack(&child->txd);
+	async_tx_ack(&desc->txd);
+
 	list_splice_init(&desc->tx_list, &dwc->free_list);
 	list_move(&desc->desc_node, &dwc->free_list);
 
-- 
1.7.2.2
