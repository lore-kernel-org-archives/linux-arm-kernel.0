From: tixy@linaro.org (Jon Medhurst)
Date: Fri,  7 Nov 2014 18:05:18 +0000
Subject: [PATCH 2/2] dma: pl330: Limit MFIFO usage for memcpy to avoid
 exhausting entries
In-Reply-To: <1415383518-29327-1-git-send-email-tixy@linaro.org>
References: <1415383518-29327-1-git-send-email-tixy@linaro.org>
Message-ID: <1415383518-29327-3-git-send-email-tixy@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The MFIFO is shared by all channels so restrict each memcpy to it's fair
share. This is being over cautious, but without a global view of DMA
channel usage on a system it's not possible to come up with a more
optimum safe limit.

Signed-off-by: Jon Medhurst <tixy@linaro.org>
---
 drivers/dma/pl330.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index 8f869ec..849439a 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -2336,7 +2336,7 @@ static inline int get_burst_len(struct dma_pl330_desc *desc, size_t len)
 	int burst_len;
 
 	burst_len = pl330->pcfg.data_bus_width / 8;
-	burst_len *= pl330->pcfg.data_buf_dep;
+	burst_len *= pl330->pcfg.data_buf_dep / pl330->pcfg.num_chan;
 	burst_len >>= desc->rqcfg.brst_size;
 
 	/* src/dst_burst_len can't be more than 16 */
-- 
2.1.1
