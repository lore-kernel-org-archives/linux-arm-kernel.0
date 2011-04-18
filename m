From: viresh.kumar@st.com (Viresh Kumar)
Date: Mon, 18 Apr 2011 16:20:00 +0530
Subject: [PATCH 2/6] dmaengine/dw_dmac: Enable resubmission from callback
	routine.
In-Reply-To: <e52c8e679fbf3007cf7e5e4bcfc86ea208a09d7c.1303123511.git.viresh.kumar@st.com>
References: <e52c8e679fbf3007cf7e5e4bcfc86ea208a09d7c.1303123511.git.viresh.kumar@st.com>
Message-ID: <cf350c267897bd4eaf5a027c659771eee117ac74.1303123511.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Resubmission of new transfer must be allowed from callbacks. For this release
lock before calling callback routine and enable them again.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 drivers/dma/dw_dmac.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/dw_dmac.c b/drivers/dma/dw_dmac.c
index 357265f..69a9c9d 100644
--- a/drivers/dma/dw_dmac.c
+++ b/drivers/dma/dw_dmac.c
@@ -242,12 +242,10 @@ dwc_descriptor_complete(struct dw_dma_chan *dwc, struct dw_desc *desc)
 		}
 	}
 
-	/*
-	 * The API requires that no submissions are done from a
-	 * callback, so we don't need to drop the lock here
-	 */
+	spin_unlock_irqrestore(&dwc->lock, dw->flags);
 	if (callback)
 		callback(param);
+	spin_lock_irqsave(&dwc->lock, dw->flags);
 }
 
 static void dwc_complete_all(struct dw_dma *dw, struct dw_dma_chan *dwc)
-- 
1.7.2.2
