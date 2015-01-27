From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Tue, 27 Jan 2015 16:30:31 +0100
Subject: [RESEND PATCH v2 3/4] dmaengine: at_xdmac: simplify channel
 configuration stuff
In-Reply-To: <1422372632-21659-1-git-send-email-ludovic.desroches@atmel.com>
References: <1422372632-21659-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <1422372632-21659-4-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch simplifies the channel configuration register management.
Relying on a "software snapshot" of the configuration is not safe and
too complex.

Multiple dwidths will be introduced for slave transfers. In this case,
it becomes quite difficult to have an accurate snapshot of the channel
configuration register in the way it is done. Using the channel
configuration available in the lli descriptor simplifies this stuff.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 drivers/dma/at_xdmac.c | 36 ++++++++++++++----------------------
 1 file changed, 14 insertions(+), 22 deletions(-)

diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index 6169f83..37aa4a9 100644
--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -191,10 +191,9 @@ struct at_xdmac_chan {
 	struct dma_chan			chan;
 	void __iomem			*ch_regs;
 	u32				mask;		/* Channel Mask */
-	u32				cfg[3];		/* Channel Configuration Register */
-	#define	AT_XDMAC_CUR_CFG	0		/* Current channel conf */
-	#define	AT_XDMAC_DEV_TO_MEM_CFG	1		/* Predifined dev to mem channel conf */
-	#define	AT_XDMAC_MEM_TO_DEV_CFG	2		/* Predifined mem to dev channel conf */
+	u32				cfg[2];		/* Channel Configuration Register */
+	#define	AT_XDMAC_DEV_TO_MEM_CFG	0		/* Predifined dev to mem channel conf */
+	#define	AT_XDMAC_MEM_TO_DEV_CFG	1		/* Predifined mem to dev channel conf */
 	u8				perid;		/* Peripheral ID */
 	u8				perif;		/* Peripheral Interface */
 	u8				memif;		/* Memory Interface */
@@ -358,14 +357,7 @@ static void at_xdmac_start_xfer(struct at_xdmac_chan *atchan,
 	 */
 	if (is_slave_direction(first->direction)) {
 		reg = AT_XDMAC_CNDC_NDVIEW_NDV1;
-		if (first->direction == DMA_MEM_TO_DEV)
-			atchan->cfg[AT_XDMAC_CUR_CFG] =
-				atchan->cfg[AT_XDMAC_MEM_TO_DEV_CFG];
-		else
-			atchan->cfg[AT_XDMAC_CUR_CFG] =
-				atchan->cfg[AT_XDMAC_DEV_TO_MEM_CFG];
-		at_xdmac_chan_write(atchan, AT_XDMAC_CC,
-				    atchan->cfg[AT_XDMAC_CUR_CFG]);
+		at_xdmac_chan_write(atchan, AT_XDMAC_CC, first->lld.mbr_cfg);
 	} else {
 		/*
 		 * No need to write AT_XDMAC_CC reg, it will be done when the
@@ -569,7 +561,6 @@ at_xdmac_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 	struct at_xdmac_desc	*first = NULL, *prev = NULL;
 	struct scatterlist	*sg;
 	int			i;
-	u32			cfg;
 	unsigned int		xfer_size = 0;
 
 	if (!sgl)
@@ -616,17 +607,17 @@ at_xdmac_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 		if (direction == DMA_DEV_TO_MEM) {
 			desc->lld.mbr_sa = atchan->per_src_addr;
 			desc->lld.mbr_da = mem;
-			cfg = atchan->cfg[AT_XDMAC_DEV_TO_MEM_CFG];
+			desc->lld.mbr_cfg = atchan->cfg[AT_XDMAC_DEV_TO_MEM_CFG];
 		} else {
 			desc->lld.mbr_sa = mem;
 			desc->lld.mbr_da = atchan->per_dst_addr;
-			cfg = atchan->cfg[AT_XDMAC_MEM_TO_DEV_CFG];
+			desc->lld.mbr_cfg = atchan->cfg[AT_XDMAC_MEM_TO_DEV_CFG];
 		}
-		desc->lld.mbr_ubc = AT_XDMAC_MBR_UBC_NDV1		/* next descriptor view */
-			| AT_XDMAC_MBR_UBC_NDEN				/* next descriptor dst parameter update */
-			| AT_XDMAC_MBR_UBC_NSEN				/* next descriptor src parameter update */
-			| (i == sg_len - 1 ? 0 : AT_XDMAC_MBR_UBC_NDE)	/* descriptor fetch */
-			| len / (1 << at_xdmac_get_dwidth(cfg));	/* microblock length */
+		desc->lld.mbr_ubc = AT_XDMAC_MBR_UBC_NDV1			/* next descriptor view */
+			| AT_XDMAC_MBR_UBC_NDEN					/* next descriptor dst parameter update */
+			| AT_XDMAC_MBR_UBC_NSEN					/* next descriptor src parameter update */
+			| (i == sg_len - 1 ? 0 : AT_XDMAC_MBR_UBC_NDE)		/* descriptor fetch */
+			| len / (1 << at_xdmac_get_dwidth(desc->lld.mbr_cfg));	/* microblock length */
 		dev_dbg(chan2dev(chan),
 			 "%s: lld: mbr_sa=%pad, mbr_da=%pad, mbr_ubc=0x%08x\n",
 			 __func__, &desc->lld.mbr_sa, &desc->lld.mbr_da, desc->lld.mbr_ubc);
@@ -890,7 +881,7 @@ at_xdmac_tx_status(struct dma_chan *chan, dma_cookie_t cookie,
 	enum dma_status		ret;
 	int			residue;
 	u32			cur_nda, mask, value;
-	u8			dwidth = at_xdmac_get_dwidth(atchan->cfg[AT_XDMAC_CUR_CFG]);
+	u8			dwidth = 0;
 
 	ret = dma_cookie_status(chan, cookie, txstate);
 	if (ret == DMA_COMPLETE)
@@ -920,7 +911,7 @@ at_xdmac_tx_status(struct dma_chan *chan, dma_cookie_t cookie,
 	 */
 	mask = AT_XDMAC_CC_TYPE | AT_XDMAC_CC_DSYNC;
 	value = AT_XDMAC_CC_TYPE_PER_TRAN | AT_XDMAC_CC_DSYNC_PER2MEM;
-	if ((atchan->cfg[AT_XDMAC_CUR_CFG] & mask) == value) {
+	if ((desc->lld.mbr_cfg & mask) == value) {
 		at_xdmac_write(atxdmac, AT_XDMAC_GSWF, atchan->mask);
 		while (!(at_xdmac_chan_read(atchan, AT_XDMAC_CIS) & AT_XDMAC_CIS_FIS))
 			cpu_relax();
@@ -934,6 +925,7 @@ at_xdmac_tx_status(struct dma_chan *chan, dma_cookie_t cookie,
 	 */
 	descs_list = &desc->descs_list;
 	list_for_each_entry_safe(desc, _desc, descs_list, desc_node) {
+		dwidth = at_xdmac_get_dwidth(desc->lld.mbr_cfg);
 		residue -= (desc->lld.mbr_ubc & 0xffffff) << dwidth;
 		if ((desc->lld.mbr_nda & 0xfffffffc) == cur_nda)
 			break;
-- 
2.2.0
