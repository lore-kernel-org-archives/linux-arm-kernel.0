From: viresh.kumar@st.com (Viresh Kumar)
Date: Thu, 5 May 2011 17:30:30 +0530
Subject: [PATCH V4 2/5] dmaengine/dw_dmac: set residue as total len in
	dwc_tx_status if status is !DMA_SUCCESS
In-Reply-To: <cover.1304596524.git.viresh.kumar@st.com>
References: <cover.1304596524.git.viresh.kumar@st.com>
Message-ID: <ccb0ba3bf0aab037c956295e267607829a936764.1304596524.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If transfer status is !=DMA_SUCCESS, return total transfer len as residue,
instead of zero.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 drivers/dma/dw_dmac.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/drivers/dma/dw_dmac.c b/drivers/dma/dw_dmac.c
index d28cd84..75b32e1 100644
--- a/drivers/dma/dw_dmac.c
+++ b/drivers/dma/dw_dmac.c
@@ -862,7 +862,11 @@ dwc_tx_status(struct dma_chan *chan,
 		ret = dma_async_is_complete(cookie, last_complete, last_used);
 	}
 
-	dma_set_tx_state(txstate, last_complete, last_used, 0);
+	if (ret != DMA_SUCCESS)
+		dma_set_tx_state(txstate, last_complete, last_used,
+				dwc_first_active(dwc)->len);
+	else
+		dma_set_tx_state(txstate, last_complete, last_used, 0);
 
 	return ret;
 }
-- 
1.7.2.2
