From: viresh.kumar@st.com (Viresh Kumar)
Date: Fri, 5 Aug 2011 15:32:35 +0530
Subject: [PATCH V3 10/20] dmaengine/amba-pl08x: No need to check "ch->signal <
	0"
In-Reply-To: <cover.1312538034.git.viresh.kumar@st.com>
References: <cover.1312538034.git.viresh.kumar@st.com>
Message-ID: <3f2bc035f4f7285c30636fae97630f365d69978c.1312538034.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We have just executed following in pl08x_get_phy_channel():
	ch->signal = -1;

We don't have to compare "ch->signal < 0", as this will always be true.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/dma/amba-pl08x.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index d79688d..3653961 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -916,7 +916,7 @@ static int prep_phy_channel(struct pl08x_dma_chan *plchan,
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
