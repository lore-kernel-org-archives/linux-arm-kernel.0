From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Mon, 1 Jun 2015 17:40:48 +0200
Subject: [PATCH v2] dmaengine: at_xdmac: rework slave configuration part
Message-ID: <1433173324-13182-1-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rework slave configuration part in order to no more report wrong errors
about the configuration.
Only maxburst and addr width values are checked when doing the slave
configuration. The validity of the channel configuration is done at
prepare time.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
Cc: stable at vger.kernel.org # 4.0 and later
---

Changes from v1:
- rework to not use implicitly direction in slave config function.

 drivers/dma/at_xdmac.c | 156 ++++++++++++++++++++++++++++++-------------------
 1 file changed, 96 insertions(+), 60 deletions(-)

diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index d9891d3..dcd1a4ed 100644
--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -174,6 +174,8 @@
 #define AT_XDMAC_MBR_UBC_NDV3		(0x3 << 27)	/* Next Descriptor View 3 */
 
 #define AT_XDMAC_MAX_CHAN	0x20
+#define AT_XDMAC_MAX_CSIZE	16	/* 16 data */
+#define AT_XDMAC_MAX_DWIDTH	8	/* 64 bits */
 
 #define AT_XDMAC_DMA_BUSWIDTHS\
 	(BIT(DMA_SLAVE_BUSWIDTH_UNDEFINED) |\
@@ -192,20 +194,17 @@ struct at_xdmac_chan {
 	struct dma_chan			chan;
 	void __iomem			*ch_regs;
 	u32				mask;		/* Channel Mask */
-	u32				cfg[2];		/* Channel Configuration Register */
-	#define	AT_XDMAC_DEV_TO_MEM_CFG	0		/* Predifined dev to mem channel conf */
-	#define	AT_XDMAC_MEM_TO_DEV_CFG	1		/* Predifined mem to dev channel conf */
+	u32				cfg;		/* Channel Configuration Register */
 	u8				perid;		/* Peripheral ID */
 	u8				perif;		/* Peripheral Interface */
 	u8				memif;		/* Memory Interface */
-	u32				per_src_addr;
-	u32				per_dst_addr;
 	u32				save_cc;
 	u32				save_cim;
 	u32				save_cnda;
 	u32				save_cndc;
 	unsigned long			status;
 	struct tasklet_struct		tasklet;
+	struct dma_slave_config		sconfig;
 
 	spinlock_t			lock;
 
@@ -494,61 +493,94 @@ static struct dma_chan *at_xdmac_xlate(struct of_phandle_args *dma_spec,
 	return chan;
 }
 
+static int at_xdmac_compute_chan_conf(struct dma_chan *chan,
+				      enum dma_transfer_direction direction)
+{
+	struct at_xdmac_chan	*atchan = to_at_xdmac_chan(chan);
+	int			csize, dwidth;
+
+	if (direction == DMA_DEV_TO_MEM) {
+		atchan->cfg =
+			AT91_XDMAC_DT_PERID(atchan->perid)
+			| AT_XDMAC_CC_DAM_INCREMENTED_AM
+			| AT_XDMAC_CC_SAM_FIXED_AM
+			| AT_XDMAC_CC_DIF(atchan->memif)
+			| AT_XDMAC_CC_SIF(atchan->perif)
+			| AT_XDMAC_CC_SWREQ_HWR_CONNECTED
+			| AT_XDMAC_CC_DSYNC_PER2MEM
+			| AT_XDMAC_CC_MBSIZE_SIXTEEN
+			| AT_XDMAC_CC_TYPE_PER_TRAN;
+		csize = ffs(atchan->sconfig.src_maxburst) - 1;
+		if (csize < 0) {
+			dev_err(chan2dev(chan), "invalid src maxburst value\n");
+			return -EINVAL;
+		}
+		atchan->cfg |= AT_XDMAC_CC_CSIZE(csize);
+		dwidth = ffs(atchan->sconfig.src_addr_width) - 1;
+		if (dwidth < 0) {
+			dev_err(chan2dev(chan), "invalid src addr width value\n");
+			return -EINVAL;
+		}
+		atchan->cfg |= AT_XDMAC_CC_DWIDTH(dwidth);
+	} else if (direction == DMA_MEM_TO_DEV) {
+		atchan->cfg =
+			AT91_XDMAC_DT_PERID(atchan->perid)
+			| AT_XDMAC_CC_DAM_FIXED_AM
+			| AT_XDMAC_CC_SAM_INCREMENTED_AM
+			| AT_XDMAC_CC_DIF(atchan->perif)
+			| AT_XDMAC_CC_SIF(atchan->memif)
+			| AT_XDMAC_CC_SWREQ_HWR_CONNECTED
+			| AT_XDMAC_CC_DSYNC_MEM2PER
+			| AT_XDMAC_CC_MBSIZE_SIXTEEN
+			| AT_XDMAC_CC_TYPE_PER_TRAN;
+		csize = ffs(atchan->sconfig.dst_maxburst) - 1;
+		if (csize < 0) {
+			dev_err(chan2dev(chan), "invalid src maxburst value\n");
+			return -EINVAL;
+		}
+		atchan->cfg |= AT_XDMAC_CC_CSIZE(csize);
+		dwidth = ffs(atchan->sconfig.dst_addr_width) - 1;
+		if (dwidth < 0) {
+			dev_err(chan2dev(chan), "invalid dst addr width value\n");
+			return -EINVAL;
+		}
+		atchan->cfg |= AT_XDMAC_CC_DWIDTH(dwidth);
+	}
+
+	dev_dbg(chan2dev(chan),	"%s: cfg=0x%08x\n", __func__, atchan->cfg);
+
+	return 0;
+}
+
+/*
+ * Only check that maxburst and addr width values are supported by the
+ * the controller but not that the configuration is good to perform the
+ * transfer since we don't know the direction at this stage.
+ */
+static int at_xdmac_check_slave_config(struct dma_slave_config *sconfig)
+{
+	if ((sconfig->src_maxburst > AT_XDMAC_MAX_CSIZE)
+	    || (sconfig->dst_maxburst > AT_XDMAC_MAX_CSIZE))
+		return -EINVAL;
+
+	if ((sconfig->src_addr_width > AT_XDMAC_MAX_DWIDTH)
+	    || (sconfig->dst_addr_width > AT_XDMAC_MAX_DWIDTH))
+		return -EINVAL;
+
+	return 0;
+}
+
 static int at_xdmac_set_slave_config(struct dma_chan *chan,
 				      struct dma_slave_config *sconfig)
 {
 	struct at_xdmac_chan	*atchan = to_at_xdmac_chan(chan);
-	u8 dwidth;
-	int csize;
 
-	atchan->cfg[AT_XDMAC_DEV_TO_MEM_CFG] =
-		AT91_XDMAC_DT_PERID(atchan->perid)
-		| AT_XDMAC_CC_DAM_INCREMENTED_AM
-		| AT_XDMAC_CC_SAM_FIXED_AM
-		| AT_XDMAC_CC_DIF(atchan->memif)
-		| AT_XDMAC_CC_SIF(atchan->perif)
-		| AT_XDMAC_CC_SWREQ_HWR_CONNECTED
-		| AT_XDMAC_CC_DSYNC_PER2MEM
-		| AT_XDMAC_CC_MBSIZE_SIXTEEN
-		| AT_XDMAC_CC_TYPE_PER_TRAN;
-	csize = at_xdmac_csize(sconfig->src_maxburst);
-	if (csize < 0) {
-		dev_err(chan2dev(chan), "invalid src maxburst value\n");
+	if (at_xdmac_check_slave_config(sconfig)) {
+		dev_err(chan2dev(chan), "invalid slave configuration\n");
 		return -EINVAL;
 	}
-	atchan->cfg[AT_XDMAC_DEV_TO_MEM_CFG] |= AT_XDMAC_CC_CSIZE(csize);
-	dwidth = ffs(sconfig->src_addr_width) - 1;
-	atchan->cfg[AT_XDMAC_DEV_TO_MEM_CFG] |= AT_XDMAC_CC_DWIDTH(dwidth);
-
-
-	atchan->cfg[AT_XDMAC_MEM_TO_DEV_CFG] =
-		AT91_XDMAC_DT_PERID(atchan->perid)
-		| AT_XDMAC_CC_DAM_FIXED_AM
-		| AT_XDMAC_CC_SAM_INCREMENTED_AM
-		| AT_XDMAC_CC_DIF(atchan->perif)
-		| AT_XDMAC_CC_SIF(atchan->memif)
-		| AT_XDMAC_CC_SWREQ_HWR_CONNECTED
-		| AT_XDMAC_CC_DSYNC_MEM2PER
-		| AT_XDMAC_CC_MBSIZE_SIXTEEN
-		| AT_XDMAC_CC_TYPE_PER_TRAN;
-	csize = at_xdmac_csize(sconfig->dst_maxburst);
-	if (csize < 0) {
-		dev_err(chan2dev(chan), "invalid src maxburst value\n");
-		return -EINVAL;
-	}
-	atchan->cfg[AT_XDMAC_MEM_TO_DEV_CFG] |= AT_XDMAC_CC_CSIZE(csize);
-	dwidth = ffs(sconfig->dst_addr_width) - 1;
-	atchan->cfg[AT_XDMAC_MEM_TO_DEV_CFG] |= AT_XDMAC_CC_DWIDTH(dwidth);
-
-	/* Src and dst addr are needed to configure the link list descriptor. */
-	atchan->per_src_addr = sconfig->src_addr;
-	atchan->per_dst_addr = sconfig->dst_addr;
 
-	dev_dbg(chan2dev(chan),
-		"%s: cfg[dev2mem]=0x%08x, cfg[mem2dev]=0x%08x, per_src_addr=0x%08x, per_dst_addr=0x%08x\n",
-		__func__, atchan->cfg[AT_XDMAC_DEV_TO_MEM_CFG],
-		atchan->cfg[AT_XDMAC_MEM_TO_DEV_CFG],
-		atchan->per_src_addr, atchan->per_dst_addr);
+	memcpy(&atchan->sconfig, sconfig, sizeof(atchan->sconfig));
 
 	return 0;
 }
@@ -604,16 +636,18 @@ at_xdmac_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 			return NULL;
 		}
 
+		if (at_xdmac_compute_chan_conf(chan, direction))
+			return NULL;
+
 		/* Linked list descriptor setup. */
 		if (direction == DMA_DEV_TO_MEM) {
-			desc->lld.mbr_sa = atchan->per_src_addr;
+			desc->lld.mbr_sa = atchan->sconfig.src_addr;
 			desc->lld.mbr_da = mem;
-			desc->lld.mbr_cfg = atchan->cfg[AT_XDMAC_DEV_TO_MEM_CFG];
 		} else {
 			desc->lld.mbr_sa = mem;
-			desc->lld.mbr_da = atchan->per_dst_addr;
-			desc->lld.mbr_cfg = atchan->cfg[AT_XDMAC_MEM_TO_DEV_CFG];
+			desc->lld.mbr_da = atchan->sconfig.dst_addr;
 		}
+		desc->lld.mbr_cfg = atchan->cfg;
 		dwidth = at_xdmac_get_dwidth(desc->lld.mbr_cfg);
 		fixed_dwidth = IS_ALIGNED(len, 1 << dwidth)
 			       ? at_xdmac_get_dwidth(desc->lld.mbr_cfg)
@@ -696,15 +730,17 @@ at_xdmac_prep_dma_cyclic(struct dma_chan *chan, dma_addr_t buf_addr,
 			"%s: desc=0x%p, tx_dma_desc.phys=%pad\n",
 			__func__, desc, &desc->tx_dma_desc.phys);
 
+		if (at_xdmac_compute_chan_conf(chan, direction))
+			return NULL;
+
 		if (direction == DMA_DEV_TO_MEM) {
-			desc->lld.mbr_sa = atchan->per_src_addr;
+			desc->lld.mbr_sa = atchan->sconfig.src_addr;
 			desc->lld.mbr_da = buf_addr + i * period_len;
-			desc->lld.mbr_cfg = atchan->cfg[AT_XDMAC_DEV_TO_MEM_CFG];
 		} else {
 			desc->lld.mbr_sa = buf_addr + i * period_len;
-			desc->lld.mbr_da = atchan->per_dst_addr;
-			desc->lld.mbr_cfg = atchan->cfg[AT_XDMAC_MEM_TO_DEV_CFG];
+			desc->lld.mbr_da = atchan->sconfig.dst_addr;
 		}
+		desc->lld.mbr_cfg = atchan->cfg;
 		desc->lld.mbr_ubc = AT_XDMAC_MBR_UBC_NDV1
 			| AT_XDMAC_MBR_UBC_NDEN
 			| AT_XDMAC_MBR_UBC_NSEN
-- 
2.2.0
