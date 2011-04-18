From: viresh.kumar@st.com (Viresh Kumar)
Date: Mon, 18 Apr 2011 16:20:01 +0530
Subject: [PATCH 3/6] dmaengine/dw_dmac: call dwc_descriptor_complete from
	dwc_control with lock held
In-Reply-To: <e52c8e679fbf3007cf7e5e4bcfc86ea208a09d7c.1303123511.git.viresh.kumar@st.com>
References: <e52c8e679fbf3007cf7e5e4bcfc86ea208a09d7c.1303123511.git.viresh.kumar@st.com>
Message-ID: <66b3083da689c5e76d7322ca9f117d631fda08af.1303123511.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

dwc_descriptor_complete must always be called with channel lock held. This patch
moves unlock code, in dwc_control(), untill after dwc_descriptor_complete is
called.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 drivers/dma/dw_dmac.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/dw_dmac.c b/drivers/dma/dw_dmac.c
index 69a9c9d..b49d7f3 100644
--- a/drivers/dma/dw_dmac.c
+++ b/drivers/dma/dw_dmac.c
@@ -830,12 +830,12 @@ static int dwc_control(struct dma_chan *chan, enum dma_ctrl_cmd cmd,
 	list_splice_init(&dwc->queue, &list);
 	list_splice_init(&dwc->active_list, &list);
 
-	spin_unlock_irqrestore(&dwc->lock, dw->flags);
-
 	/* Flush all pending and queued descriptors */
 	list_for_each_entry_safe(desc, _desc, &list, desc_node)
 		dwc_descriptor_complete(dwc, desc);
 
+	spin_unlock_irqrestore(&dwc->lock, dw->flags);
+
 	return 0;
 }
 
-- 
1.7.2.2
