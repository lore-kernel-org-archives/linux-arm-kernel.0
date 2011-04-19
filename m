From: viresh.kumar@st.com (Viresh Kumar)
Date: Tue, 19 Apr 2011 14:02:08 +0530
Subject: [PATCH V2 3/7] dmaengine/dw_dmac: call dwc_descriptor_complete from
	dwc_control with lock held
In-Reply-To: <cover.1303194835.git.viresh.kumar@st.com>
References: <cover.1303194835.git.viresh.kumar@st.com>
Message-ID: <c19b6c33e8a04b652e78252fa96021bcd39047e4.1303194835.git.viresh.kumar@st.com>
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
index 66d7f1b..c211460 100644
--- a/drivers/dma/dw_dmac.c
+++ b/drivers/dma/dw_dmac.c
@@ -825,12 +825,12 @@ static int dwc_control(struct dma_chan *chan, enum dma_ctrl_cmd cmd,
 	list_splice_init(&dwc->queue, &list);
 	list_splice_init(&dwc->active_list, &list);
 
-	spin_unlock_irqrestore(&dwc->lock, dwc->lflags);
-
 	/* Flush all pending and queued descriptors */
 	list_for_each_entry_safe(desc, _desc, &list, desc_node)
 		dwc_descriptor_complete(dwc, desc);
 
+	spin_unlock_irqrestore(&dwc->lock, dwc->lflags);
+
 	return 0;
 }
 
-- 
1.7.2.2
