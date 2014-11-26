From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Wed, 26 Nov 2014 17:22:28 +0100
Subject: [PATCH 2/3] dmaengine: at_xdmac: simplify channel configuration stuff
In-Reply-To: <1417018949-24246-1-git-send-email-ludovic.desroches@atmel.com>
References: <1417018949-24246-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <1417018949-24246-3-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Using the cc field of the descriptor simplifies the management of the channel
configuration.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 drivers/dma/at_xdmac.c | 33 +++++++++++++--------------------
 1 file changed, 13 insertions(+), 20 deletions(-)

diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index bc4b018..94b714e 100644
--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -200,6 +200,7 @@ struct at_xdmac_chan {
 	u8				memif;		/* Memory Interface */
 	u32				per_src_addr;
 	u32				per_dst_addr;
+	u32				save_cc;
 	u32				save_cim;
 	u32				save_cnda;
 	u32				save_cndc;
@@ -357,14 +358,7 @@ static void at_xdmac_start_xfer(struct at_xdmac_chan *atchan,
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
@@ -568,7 +562,6 @@ at_xdmac_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 	struct at_xdmac_desc	*first = NULL, *prev = NULL;
 	struct scatterlist	*sg;
 	int			i;
-	u32			cfg;
 	unsigned int		xfer_size = 0;
 
 	if (!sgl)
@@ -615,17 +608,17 @@ at_xdmac_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
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
@@ -889,7 +882,7 @@ at_xdmac_tx_status(struct dma_chan *chan, dma_cookie_t cookie,
 	enum dma_status		ret;
 	int			residue;
 	u32			cur_nda, mask, value;
-	u8			dwidth = at_xdmac_get_dwidth(atchan->cfg[AT_XDMAC_CUR_CFG]);
+	u8			dwidth = 0;
 
 	ret = dma_cookie_status(chan, cookie, txstate);
 	if (ret == DMA_COMPLETE)
@@ -933,6 +926,7 @@ at_xdmac_tx_status(struct dma_chan *chan, dma_cookie_t cookie,
 	 */
 	descs_list = &desc->descs_list;
 	list_for_each_entry_safe(desc, _desc, descs_list, desc_node) {
+		dwidth = at_xdmac_get_dwidth(desc->lld.mbr_cfg);
 		residue -= (desc->lld.mbr_ubc & 0xffffff) << dwidth;
 		if ((desc->lld.mbr_nda & 0xfffffffc) == cur_nda)
 			break;
@@ -1276,6 +1270,7 @@ static int atmel_xdmac_suspend(struct device *dev)
 	list_for_each_entry_safe(chan, _chan, &atxdmac->dma.channels, device_node) {
 		struct at_xdmac_chan	*atchan = to_at_xdmac_chan(chan);
 
+		atchan->save_cc = at_xdmac_chan_read(atchan, AT_XDMAC_CC);
 		if (at_xdmac_chan_is_cyclic(atchan)) {
 			if (!at_xdmac_chan_is_paused(atchan))
 				at_xdmac_device_pause(chan);
@@ -1298,7 +1293,6 @@ static int atmel_xdmac_resume(struct device *dev)
 	struct at_xdmac_chan	*atchan;
 	struct dma_chan		*chan, *_chan;
 	int			i;
-	u32			cfg;
 
 	clk_prepare_enable(atxdmac->clk);
 
@@ -1313,8 +1307,7 @@ static int atmel_xdmac_resume(struct device *dev)
 	at_xdmac_write(atxdmac, AT_XDMAC_GE, atxdmac->save_gs);
 	list_for_each_entry_safe(chan, _chan, &atxdmac->dma.channels, device_node) {
 		atchan = to_at_xdmac_chan(chan);
-		cfg = atchan->cfg[AT_XDMAC_CUR_CFG];
-		at_xdmac_chan_write(atchan, AT_XDMAC_CC, cfg);
+		at_xdmac_chan_write(atchan, AT_XDMAC_CC, atchan->save_cc);
 		if (at_xdmac_chan_is_cyclic(atchan)) {
 			at_xdmac_chan_write(atchan, AT_XDMAC_CNDA, atchan->save_cnda);
 			at_xdmac_chan_write(atchan, AT_XDMAC_CNDC, atchan->save_cndc);
-- 
2.0.3
