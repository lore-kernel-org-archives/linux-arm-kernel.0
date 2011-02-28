From: viresh.kumar@st.com (Viresh Kumar)
Date: Mon, 28 Feb 2011 16:11:18 +0530
Subject: [PATCH 3/8 resend] dw_dmac: call dwc_scan_descriptor from
	dwc_issue_pending only if active list is empty
In-Reply-To: <cover.1298889267.git.viresh.kumar@st.com>
References: <cover.1298889267.git.viresh.kumar@st.com>
Message-ID: <8003205172278ef36cfca1fd50a54cb143fad958.1298889267.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

dwc_scan_descriptor was called even when there were descriptors in active list.
Checking if active list is empty or not.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 drivers/dma/dw_dmac.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/dma/dw_dmac.c b/drivers/dma/dw_dmac.c
index 6dd03b0..3bf4772 100644
--- a/drivers/dma/dw_dmac.c
+++ b/drivers/dma/dw_dmac.c
@@ -848,7 +848,7 @@ static void dwc_issue_pending(struct dma_chan *chan)
 	struct dw_dma_chan	*dwc = to_dw_dma_chan(chan);
 
 	spin_lock_bh(&dwc->lock);
-	if (!list_empty(&dwc->queue))
+	if (!list_empty(&dwc->queue) && list_empty(&dwc->active_list))
 		dwc_scan_descriptors(to_dw_dma(chan->device), dwc);
 	spin_unlock_bh(&dwc->lock);
 }
-- 
1.7.2.2
