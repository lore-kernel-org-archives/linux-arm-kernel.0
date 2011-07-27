From: boojin.kim@samsung.com (Boojin Kim)
Date: Wed, 27 Jul 2011 14:31:24 +0900
Subject: [PATCH 02/15] DMA: PL330: Update PL330 DMA API driver
In-Reply-To: <1311744697-10264-1-git-send-email-boojin.kim@samsung.com>
References: <1311744697-10264-1-git-send-email-boojin.kim@samsung.com>
Message-ID: <1311744697-10264-3-git-send-email-boojin.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

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
 drivers/dma/pl330.c        |   13 ++++++++-----
 include/linux/amba/pl330.h |    6 +-----
 3 files changed, 11 insertions(+), 11 deletions(-)

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
index b7ecf47..5a10df9 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -69,6 +69,10 @@ struct dma_pl330_chan {
 	 * NULL if the channel is available to be acquired.
 	 */
 	void *pl330_chid;
+
+	/* For D-to-M and M-to-D channels */
+	int burst_sz; /* the peripheral fifo width */
+	dma_addr_t fifo_addr;
 };
 
 struct dma_pl330_dmac {
@@ -455,7 +459,7 @@ static struct dma_pl330_desc *pl330_get_desc(struct dma_pl330_chan *pch)
 	async_tx_ack(&desc->txd);
 
 	desc->req.rqtype = peri->rqtype;
-	desc->req.peri = peri->peri_id;
+	desc->req.peri = pch->chan.chan_id;
 
 	dma_async_tx_descriptor_init(&desc->txd, &pch->chan);
 
@@ -577,7 +581,7 @@ pl330_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 	struct dma_pl330_peri *peri = chan->private;
 	struct scatterlist *sg;
 	unsigned long flags;
-	int i, burst_size;
+	int i;
 	dma_addr_t addr;
 
 	if (unlikely(!pch || !sgl || !sg_len))
@@ -593,8 +597,7 @@ pl330_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 		return NULL;
 	}
 
-	addr = peri->fifo_addr;
-	burst_size = peri->burst_sz;
+	addr = pch->fifo_addr;
 
 	first = NULL;
 
@@ -642,7 +645,7 @@ pl330_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 				sg_dma_address(sg), addr, sg_dma_len(sg));
 		}
 
-		desc->rqcfg.brst_size = burst_size;
+		desc->rqcfg.brst_size = pch->burst_sz;
 		desc->rqcfg.brst_len = 1;
 	}
 
diff --git a/include/linux/amba/pl330.h b/include/linux/amba/pl330.h
index cbee7de..d12f077 100644
--- a/include/linux/amba/pl330.h
+++ b/include/linux/amba/pl330.h
@@ -19,12 +19,8 @@ struct dma_pl330_peri {
 	 * Peri_Req i/f of the DMAC that is
 	 * peripheral could be reached from.
 	 */
-	u8 peri_id; /* {0, 31} */
+	u8 peri_id; /* specific dma id */
 	enum pl330_reqtype rqtype;
-
-	/* For M->D and D->M Channels */
-	int burst_sz; /* in power of 2 */
-	dma_addr_t fifo_addr;
 };
 
 struct dma_pl330_platdata {
-- 
1.7.1
