From: viresh.kumar@st.com (Viresh Kumar)
Date: Mon, 1 Aug 2011 15:07:29 +0530
Subject: [PATCH V2 19/20] dmaengine/amba-pl08x: Check txd->llis_va before
	freeing dma_pool
In-Reply-To: <cover.1312190881.git.viresh.kumar@st.com>
References: <cover.1312190881.git.viresh.kumar@st.com>
Message-ID: <ac7230fffb2629b8a745b90d6c2d6e6d59d78794.1312190882.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In pl08x_free_txd(), check if pool is allocated successfully before freeing it.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/dma/amba-pl08x.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index adc8a36..2667e0d 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -796,7 +796,8 @@ static void pl08x_free_txd(struct pl08x_driver_data *pl08x,
 	struct pl08x_sg *dsg, *_dsg;
 
 	/* Free the LLI */
-	dma_pool_free(pl08x->pool, txd->llis_va, txd->llis_bus);
+	if (txd->llis_va)
+		dma_pool_free(pl08x->pool, txd->llis_va, txd->llis_bus);
 
 	pl08x->pool_ctr--;
 
-- 
1.7.2.2
