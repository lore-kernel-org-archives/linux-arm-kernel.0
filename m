From: viresh.kumar@st.com (Viresh Kumar)
Date: Thu, 3 Mar 2011 15:47:17 +0530
Subject: [PATCH V2 04/13] dw_dmac: Calling dwc_scan_descriptors from
	dwc_tx_status() after taking lock
In-Reply-To: <cover.1299146382.git.viresh.kumar@st.com>
References: <cover.1299146382.git.viresh.kumar@st.com>
Message-ID: <72245f0f6b2b25072a0d4641e66b8699819c683e.1299146382.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Lock must be taken before calling dwc_scan_descriptors, as this may
access/modify shared data and queues. dwc_tx_status wasn't taking lock before
calling this routine. This patch add code that takes lock before calling
dwc_scan_descriptors.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 drivers/dma/dw_dmac.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/dma/dw_dmac.c b/drivers/dma/dw_dmac.c
index 942b50f..2b0d5e9 100644
--- a/drivers/dma/dw_dmac.c
+++ b/drivers/dma/dw_dmac.c
@@ -836,7 +836,9 @@ dwc_tx_status(struct dma_chan *chan,
 
 	ret = dma_async_is_complete(cookie, last_complete, last_used);
 	if (ret != DMA_SUCCESS) {
+		spin_lock_bh(&dwc->lock);
 		dwc_scan_descriptors(to_dw_dma(chan->device), dwc);
+		spin_unlock_bh(&dwc->lock);
 
 		last_complete = dwc->completed;
 		last_used = chan->cookie;
-- 
1.7.2.2
