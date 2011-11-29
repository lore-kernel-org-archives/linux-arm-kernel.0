From: viresh.kumar@st.com (Viresh Kumar)
Date: Tue, 29 Nov 2011 12:56:50 +0530
Subject: [PATCH] dmaengine/amba-pl08x: Config ccfg and increment phychan_hold
 if phychan is true
Message-ID: <fc4d77e6355cc462cfc2e700415cd56b9db816cb.1322551469.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, if plchan->phychan is true, we return immediately from
prep_phy_chan(). We must configure txd->ccfg and increment phychan_hold before
returning. Otherwise, request line number wouldn't be configured in this txd.

Reported-by: Rajeev Kumar <rajeev-dlh.kumar@st.com>
Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 drivers/dma/amba-pl08x.c |   21 ++++++++++++---------
 1 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index 41c62fd..9ebceca 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -854,8 +854,10 @@ static int prep_phy_channel(struct pl08x_dma_chan *plchan,
 	int ret;
 
 	/* Check if we already have a channel */
-	if (plchan->phychan)
-		return 0;
+	if (plchan->phychan) {
+		ch = plchan->phychan;
+		goto got_channel;
+	}
 
 	ch = pl08x_get_phy_channel(pl08x, plchan);
 	if (!ch) {
@@ -880,21 +882,22 @@ static int prep_phy_channel(struct pl08x_dma_chan *plchan,
 			return -EBUSY;
 		}
 		ch->signal = ret;
-
-		/* Assign the flow control signal to this channel */
-		if (txd->direction == DMA_MEM_TO_DEV)
-			txd->ccfg |= ch->signal << PL080_CONFIG_DST_SEL_SHIFT;
-		else if (txd->direction == DMA_DEV_TO_MEM)
-			txd->ccfg |= ch->signal << PL080_CONFIG_SRC_SEL_SHIFT;
 	}
 
+	plchan->phychan = ch;
 	dev_dbg(&pl08x->adev->dev, "allocated physical channel %d and signal %d for xfer on %s\n",
 		 ch->id,
 		 ch->signal,
 		 plchan->name);
 
+got_channel:
+	/* Assign the flow control signal to this channel */
+	if (txd->direction == DMA_MEM_TO_DEV)
+		txd->ccfg |= ch->signal << PL080_CONFIG_DST_SEL_SHIFT;
+	else if (txd->direction == DMA_DEV_TO_MEM)
+		txd->ccfg |= ch->signal << PL080_CONFIG_SRC_SEL_SHIFT;
+
 	plchan->phychan_hold++;
-	plchan->phychan = ch;
 
 	return 0;
 }
-- 
1.7.2.2
