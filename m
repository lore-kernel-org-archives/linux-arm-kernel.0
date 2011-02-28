From: viresh.kumar@st.com (Viresh Kumar)
Date: Mon, 28 Feb 2011 16:11:21 +0530
Subject: [PATCH 6/8 resend] dw_dmac: Mark all tx_descriptors with DMA_CRTL_ACK
	after xfer finish
In-Reply-To: <cover.1298889267.git.viresh.kumar@st.com>
References: <cover.1298889267.git.viresh.kumar@st.com>
Message-ID: <82027aa0c6446df3f7fb8e3c5fbdc28f60ea33b7.1298889267.git.viresh.kumar@st.com>
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
index c40b89f..01f783d 100644
--- a/drivers/dma/dw_dmac.c
+++ b/drivers/dma/dw_dmac.c
@@ -196,6 +196,7 @@ dwc_descriptor_complete(struct dw_dma_chan *dwc, struct dw_desc *desc)
 	dma_async_tx_callback		callback;
 	void				*param;
 	struct dma_async_tx_descriptor	*txd = &desc->txd;
+	struct dw_desc	*child;
 
 	dev_vdbg(chan2dev(&dwc->chan), "descriptor %u complete\n", txd->cookie);
 
@@ -204,6 +205,12 @@ dwc_descriptor_complete(struct dw_dma_chan *dwc, struct dw_desc *desc)
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
