From: viresh.kumar@st.com (Viresh Kumar)
Date: Fri, 29 Jul 2011 16:19:27 +0530
Subject: [PATCH 17/18] dmaengine/amba-pl08x: Check txd->llis_va before freeing
	dma_pool
In-Reply-To: <cover.1311936523.git.viresh.kumar@st.com>
References: <cover.1311936523.git.viresh.kumar@st.com>
Message-ID: <1ce7eda8117f76d1e9d35bcf59d188351d1b9465.1311936524.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In pl08x_free_txd(), check if pool is allocated successfully before freeing it.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 drivers/dma/amba-pl08x.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index ddc06bd..a72255c 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -784,7 +784,8 @@ static void pl08x_free_txd(struct pl08x_driver_data *pl08x,
 	struct pl08x_sg *dsg, *_dsg;
 
 	/* Free the LLI */
-	dma_pool_free(pl08x->pool, txd->llis_va, txd->llis_bus);
+	if (txd->llis_va)
+		dma_pool_free(pl08x->pool, txd->llis_va, txd->llis_bus);
 
 	pl08x->pool_ctr--;
 
-- 
1.7.2.2
