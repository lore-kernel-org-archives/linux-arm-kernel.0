From: viresh.kumar@st.com (Viresh Kumar)
Date: Fri, 5 Aug 2011 15:32:44 +0530
Subject: [PATCH V3 19/20] dmaengine/amba-pl08x: Check txd->llis_va before
	freeing dma_pool
In-Reply-To: <cover.1312538034.git.viresh.kumar@st.com>
References: <cover.1312538034.git.viresh.kumar@st.com>
Message-ID: <4ef4f1c757c02b89fd2cce6775318a417c2626bb.1312538034.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In pl08x_free_txd(), check if pool is allocated successfully before freeing it.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/dma/amba-pl08x.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index e4e7969..4d2aedc 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -800,7 +800,8 @@ static void pl08x_free_txd(struct pl08x_driver_data *pl08x,
 	struct pl08x_sg *dsg, *_dsg;
 
 	/* Free the LLI */
-	dma_pool_free(pl08x->pool, txd->llis_va, txd->llis_bus);
+	if (txd->llis_va)
+		dma_pool_free(pl08x->pool, txd->llis_va, txd->llis_bus);
 
 	pl08x->pool_ctr--;
 
-- 
1.7.2.2
