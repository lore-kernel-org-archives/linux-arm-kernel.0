From: viresh.kumar@st.com (Viresh Kumar)
Date: Mon, 1 Aug 2011 15:07:20 +0530
Subject: [PATCH V2 10/20] dmaengine/amba-pl08x: No need to check "ch->signal <
	0"
In-Reply-To: <cover.1312190881.git.viresh.kumar@st.com>
References: <cover.1312190881.git.viresh.kumar@st.com>
Message-ID: <41f085d3f399d2a60ef1afbf04b75104c5794af3.1312190881.git.viresh.kumar@st.com>
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
index da17249..f463841 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -921,7 +921,7 @@ static int prep_phy_channel(struct pl08x_dma_chan *plchan,
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
