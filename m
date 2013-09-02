From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Mon,  2 Sep 2013 13:44:59 +0530
Subject: [PATCH 2/2] dma: ste_dma40: Fix potential null pointer dereference
In-Reply-To: <1378109699-25245-1-git-send-email-sachin.kamat@linaro.org>
References: <1378109699-25245-1-git-send-email-sachin.kamat@linaro.org>
Message-ID: <1378109699-25245-2-git-send-email-sachin.kamat@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

kcalloc can return NULL. Check the pointer before dereferencing.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/dma/ste_dma40.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
index df0a606..82d2b97 100644
--- a/drivers/dma/ste_dma40.c
+++ b/drivers/dma/ste_dma40.c
@@ -2591,6 +2591,9 @@ dma40_prep_dma_cyclic(struct dma_chan *chan, dma_addr_t dma_addr,
 	int i;
 
 	sg = kcalloc(periods + 1, sizeof(struct scatterlist), GFP_NOWAIT);
+	if (!sg)
+		return NULL;
+
 	for (i = 0; i < periods; i++) {
 		sg_dma_address(&sg[i]) = dma_addr;
 		sg_dma_len(&sg[i]) = period_len;
-- 
1.7.9.5
