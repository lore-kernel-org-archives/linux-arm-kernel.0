From: viresh.kumar@st.com (Viresh Kumar)
Date: Mon, 28 Feb 2011 16:11:19 +0530
Subject: [PATCH 4/8 resend] dw_dmac: calling dwc_scan_descriptors from
	dwc_tx_status() after taking lock
In-Reply-To: <cover.1298889267.git.viresh.kumar@st.com>
References: <cover.1298889267.git.viresh.kumar@st.com>
Message-ID: <725d9e629bce9f79d87bdab4596a5088b70ea416.1298889267.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 drivers/dma/dw_dmac.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/dma/dw_dmac.c b/drivers/dma/dw_dmac.c
index 3bf4772..5cc5abf 100644
--- a/drivers/dma/dw_dmac.c
+++ b/drivers/dma/dw_dmac.c
@@ -830,7 +830,9 @@ dwc_tx_status(struct dma_chan *chan,
 
 	ret = dma_async_is_complete(cookie, last_complete, last_used);
 	if (ret != DMA_SUCCESS) {
+		spin_lock_bh(&dwc->lock);
 		dwc_scan_descriptors(to_dw_dma(chan->device), dwc);
+		spin_unlock_bh(&dwc->lock);
 
 		last_complete = dwc->completed;
 		last_used = chan->cookie;
-- 
1.7.2.2
