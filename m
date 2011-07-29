From: viresh.kumar@st.com (Viresh Kumar)
Date: Fri, 29 Jul 2011 16:19:18 +0530
Subject: [PATCH 08/18] dmaengine/amba-pl08x: No need to check "ch->signal < 0"
In-Reply-To: <cover.1311936523.git.viresh.kumar@st.com>
References: <cover.1311936523.git.viresh.kumar@st.com>
Message-ID: <1e1f287888a2ce9affdcbded8f63028fa3f6b09b.1311936524.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We have just executed following in pl08x_get_phy_channel():
	ch->signal = -1;

We don't have to compare "ch->signal < 0", as this will always be true.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 drivers/dma/amba-pl08x.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index f1a25cf..c4ce1a2 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -923,7 +923,7 @@ static int prep_phy_channel(struct pl08x_dma_chan *plchan,
 	 * need, but for slaves the physical signals may be muxed!
 	 * Can the platform allow us to use this channel?
 	 */
-	if (plchan->slave && ch->signal < 0 && pl08x->pd->get_signal) {
+	if (plchan->slave && pl08x->pd->get_signal) {
 		ret = pl08x->pd->get_signal(plchan);
 		if (ret < 0) {
 			dev_dbg(&pl08x->adev->dev,
-- 
1.7.2.2
