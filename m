From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 13 Jul 2011 17:47:27 +0900
Subject: [PATCH V2 02/12] DMA: PL330: Update PL330 DMA API driver
In-Reply-To: <1310546857-6304-1-git-send-email-kgene.kim@samsung.com>
References: <1310546857-6304-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1310546857-6304-3-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Boojin Kim <boojin.kim@samsung.com>

This patch updates following 3 items.
1. Removes unneccessary code.
2. Add AMBA, PL330 configuration
3. Change the meaning of 'peri_id' variable
   from PL330 event number to specific dma id by user.

Signed-off-by: Boojin Kim <boojin.kim@samsung.com>
Cc: Vinod Koul <vinod.koul@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 drivers/dma/Kconfig        |    3 ++-
 drivers/dma/pl330.c        |   31 ++++++++++++++++---------------
 include/linux/amba/pl330.h |    2 +-
 3 files changed, 19 insertions(+), 17 deletions(-)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 25cf327..569cb14 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -193,7 +193,8 @@ config ARCH_HAS_ASYNC_TX_FIND_CHANNEL
 config PL330_DMA
 	tristate "DMA API Driver for PL330"
 	select DMA_ENGINE
-	depends on PL330
+	depends on ARM_AMBA
+	select PL330
 	help
 	  Select if your platform has one or more PL330 DMACs.
 	  You need to provide platform specific settings via
diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index 39e9ffd..9bdda7b 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -455,7 +455,7 @@ static struct dma_pl330_desc *pl330_get_desc(struct dma_pl330_chan *pch)
 	async_tx_ack(&desc->txd);
 
 	desc->req.rqtype = peri->rqtype;
-	desc->req.peri = peri->peri_id;
+	desc->req.peri = pch->chan.chan_id;
 
 	dma_async_tx_descriptor_init(&desc->txd, &pch->chan);
 
@@ -577,7 +577,7 @@ pl330_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 	struct dma_pl330_peri *peri = chan->private;
 	struct scatterlist *sg;
 	unsigned long flags;
-	int i, burst_size;
+	int i;
 	dma_addr_t addr;
 
 	if (unlikely(!pch || !sgl || !sg_len))
@@ -594,7 +594,6 @@ pl330_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 	}
 
 	addr = peri->fifo_addr;
-	burst_size = peri->burst_sz;
 
 	first = NULL;
 
@@ -642,7 +641,7 @@ pl330_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 				sg_dma_address(sg), addr, sg_dma_len(sg));
 		}
 
-		desc->rqcfg.brst_size = burst_size;
+		desc->rqcfg.brst_size = peri->burst_sz;
 		desc->rqcfg.brst_len = 1;
 	}
 
@@ -749,17 +748,19 @@ pl330_probe(struct amba_device *adev, const struct amba_id *id)
 		struct dma_pl330_peri *peri = &pdat->peri[i];
 		pch = &pdmac->peripherals[i];
 
-		switch (peri->rqtype) {
-		case MEMTOMEM:
-			dma_cap_set(DMA_MEMCPY, pd->cap_mask);
-			break;
-		case MEMTODEV:
-		case DEVTOMEM:
-			dma_cap_set(DMA_SLAVE, pd->cap_mask);
-			break;
-		default:
-			dev_err(&adev->dev, "DEVTODEV Not Supported\n");
-			continue;
+		if (peri) {
+			switch (peri->rqtype) {
+			case MEMTOMEM:
+				dma_cap_set(DMA_MEMCPY, pd->cap_mask);
+				break;
+			case MEMTODEV:
+			case DEVTOMEM:
+				dma_cap_set(DMA_SLAVE, pd->cap_mask);
+				break;
+			default:
+				dev_err(&adev->dev, "DEVTODEV Not Supported\n");
+				continue;
+			}
 		}
 
 		INIT_LIST_HEAD(&pch->work_list);
diff --git a/include/linux/amba/pl330.h b/include/linux/amba/pl330.h
index cbee7de..17b0ada 100644
--- a/include/linux/amba/pl330.h
+++ b/include/linux/amba/pl330.h
@@ -19,7 +19,7 @@ struct dma_pl330_peri {
 	 * Peri_Req i/f of the DMAC that is
 	 * peripheral could be reached from.
 	 */
-	u8 peri_id; /* {0, 31} */
+	u8 peri_id; /* specific dma id */
 	enum pl330_reqtype rqtype;
 
 	/* For M->D and D->M Channels */
-- 
1.7.1
