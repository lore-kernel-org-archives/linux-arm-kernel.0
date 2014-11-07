From: tixy@linaro.org (Jon Medhurst)
Date: Fri,  7 Nov 2014 18:05:17 +0000
Subject: [PATCH 1/2] dma: pl330: Align DMA memcpy operations to MFIFO width
In-Reply-To: <1415383518-29327-1-git-send-email-tixy@linaro.org>
References: <1415383518-29327-1-git-send-email-tixy@linaro.org>
Message-ID: <1415383518-29327-2-git-send-email-tixy@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The algorithm used for programming the DMA Controller doesn't take into
consideration the requirements of transfers that are not aligned to the
bus width. This failure may result in DMA transferring one too few MFIFO
entries (so too few bytes are copied) or the DMA trying to write one too
many MFIFO entries and hanging because this is never provided.

See "MFIFO Usage Overview" chapter in the the TRM for "CoreLink DMA
Controller DMA-330", Revision r1p1.

We work around these shortcomings by making sure we pick a burst size
and length which ensures no bursts straddle an MFIFO entry.

Signed-off-by: Jon Medhurst <tixy@linaro.org>
---
 drivers/dma/pl330.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index 4839bfa..8f869ec 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -2459,8 +2459,13 @@ pl330_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dst,
 	/* Select max possible burst size */
 	burst = pl330->pcfg.data_bus_width / 8;
 
+	/*
+	 * Make sure we use a burst size that aligns with all the memcpy
+	 * parameters because our DMA programming algorithm doesn't cope with
+	 * transfers which straddle an entry in the DMA device's MFIFO.
+	 */
 	while (burst > 1) {
-		if (!(len % burst))
+		if (!((src | dst | len) % burst))
 			break;
 		burst /= 2;
 	}
@@ -2469,6 +2474,13 @@ pl330_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dst,
 	while (burst != (1 << desc->rqcfg.brst_size))
 		desc->rqcfg.brst_size++;
 
+	/*
+	 * If burst size is smaller than bus width then make sure we only
+	 * transfer one at a time to avoid a burst stradling an MFIFO entry.
+	 */
+	if (desc->rqcfg.brst_size * 8 < pl330->pcfg.data_bus_width)
+		desc->rqcfg.brst_len = 1;
+
 	desc->rqcfg.brst_len = get_burst_len(desc, len);
 
 	desc->txd.flags = flags;
-- 
2.1.1
