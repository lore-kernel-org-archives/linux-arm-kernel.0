From: viresh.kumar@st.com (Viresh Kumar)
Date: Mon, 1 Aug 2011 15:07:30 +0530
Subject: [PATCH V2 20/20] dmaengine/amba-pl08x: Call pl08x_free_txd() instead
	of calling kfree() directly
In-Reply-To: <cover.1312190881.git.viresh.kumar@st.com>
References: <cover.1312190881.git.viresh.kumar@st.com>
Message-ID: <149303ac0cac8dd5de5506b29d7a800a223bed79.1312190882.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

pl08x_prep_channel_resources() is calling kfree() directly for txd(). To
maintain consistency in code call pl08x_free_txd() instead.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/dma/amba-pl08x.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index 2667e0d..063970f 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -1202,7 +1202,9 @@ static int pl08x_prep_channel_resources(struct pl08x_dma_chan *plchan,
 
 	num_llis = pl08x_fill_llis_for_desc(pl08x, txd);
 	if (!num_llis) {
-		kfree(txd);
+		spin_lock_irqsave(&plchan->lock, flags);
+		pl08x_free_txd(pl08x, txd);
+		spin_unlock_irqrestore(&plchan->lock, flags);
 		return -EINVAL;
 	}
 
-- 
1.7.2.2
