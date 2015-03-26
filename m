From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Thu, 26 Mar 2015 13:06:31 +0000
Subject: [PATCH 3/3] dma: at_xdmac: make all descriptors little endian
In-Reply-To: <1427375191-1467-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1427375191-1467-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <1427375191-1467-4-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Always write the descriptors for the at_xdmac in little endian when
the processor is running big endian.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
--
CC: Ludovic Desroches <ludovic.desroches@atmel.com>
CC: Vinod Koul <vinod.koul@intel.com>
CC: Dan Williams <dan.j.williams@intel.com>
CC: linux-arm-kernel at lists.infradead.org
CC: dmaengine at vger.kernel.org
---
 drivers/dma/at_xdmac.c | 97 ++++++++++++++++++++++++++------------------------
 1 file changed, 51 insertions(+), 46 deletions(-)

diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index d9891d3..65a37be 100644
--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -232,10 +232,10 @@ struct at_xdmac {
 /* Linked List Descriptor */
 struct at_xdmac_lld {
 	dma_addr_t	mbr_nda;	/* Next Descriptor Member */
-	u32		mbr_ubc;	/* Microblock Control Member */
+	__le32		mbr_ubc;	/* Microblock Control Member */
 	dma_addr_t	mbr_sa;		/* Source Address Member */
 	dma_addr_t	mbr_da;		/* Destination Address Member */
-	u32		mbr_cfg;	/* Configuration Register */
+	__le32		mbr_cfg;	/* Configuration Register */
 };
 
 
@@ -358,7 +358,7 @@ static void at_xdmac_start_xfer(struct at_xdmac_chan *atchan,
 	 */
 	if (at_xdmac_chan_is_cyclic(atchan)) {
 		reg = AT_XDMAC_CNDC_NDVIEW_NDV1;
-		at_xdmac_chan_write(atchan, AT_XDMAC_CC, first->lld.mbr_cfg);
+		at_xdmac_chan_write(atchan, AT_XDMAC_CC, le32_to_cpu(first->lld.mbr_cfg));
 	} else {
 		/*
 		 * No need to write AT_XDMAC_CC reg, it will be done when the
@@ -583,7 +583,7 @@ at_xdmac_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 	/* Prepare descriptors. */
 	for_each_sg(sgl, sg, sg_len, i) {
 		struct at_xdmac_desc	*desc = NULL;
-		u32			len, mem, dwidth, fixed_dwidth;
+		u32			len, mem, dwidth, fixed_dwidth, mbr_cfg;
 
 		len = sg_dma_len(sg);
 		mem = sg_dma_address(sg);
@@ -606,30 +606,32 @@ at_xdmac_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 
 		/* Linked list descriptor setup. */
 		if (direction == DMA_DEV_TO_MEM) {
-			desc->lld.mbr_sa = atchan->per_src_addr;
-			desc->lld.mbr_da = mem;
-			desc->lld.mbr_cfg = atchan->cfg[AT_XDMAC_DEV_TO_MEM_CFG];
+			mbr_cfg = atchan->cfg[AT_XDMAC_DEV_TO_MEM_CFG];
+			desc->lld.mbr_sa = cpu_to_le32(atchan->per_src_addr);
+			desc->lld.mbr_da = cpu_to_le32(mem);
+			desc->lld.mbr_cfg = cpu_to_le32(mbr_cfg);
 		} else {
-			desc->lld.mbr_sa = mem;
-			desc->lld.mbr_da = atchan->per_dst_addr;
-			desc->lld.mbr_cfg = atchan->cfg[AT_XDMAC_MEM_TO_DEV_CFG];
+			mbr_cfg = atchan->cfg[AT_XDMAC_MEM_TO_DEV_CFG];
+			desc->lld.mbr_sa = cpu_to_le32(mem);
+			desc->lld.mbr_da = cpu_to_le32(atchan->per_dst_addr);
+			desc->lld.mbr_cfg = cpu_to_le32(mbr_cfg);
 		}
-		dwidth = at_xdmac_get_dwidth(desc->lld.mbr_cfg);
+		dwidth = at_xdmac_get_dwidth(mbr_cfg);
 		fixed_dwidth = IS_ALIGNED(len, 1 << dwidth)
-			       ? at_xdmac_get_dwidth(desc->lld.mbr_cfg)
-			       : AT_XDMAC_CC_DWIDTH_BYTE;
-		desc->lld.mbr_ubc = AT_XDMAC_MBR_UBC_NDV2			/* next descriptor view */
-			| AT_XDMAC_MBR_UBC_NDEN					/* next descriptor dst parameter update */
-			| AT_XDMAC_MBR_UBC_NSEN					/* next descriptor src parameter update */
-			| (i == sg_len - 1 ? 0 : AT_XDMAC_MBR_UBC_NDE)		/* descriptor fetch */
-			| (len >> fixed_dwidth);				/* microblock length */
+			? at_xdmac_get_dwidth(mbr_cfg)
+			: AT_XDMAC_CC_DWIDTH_BYTE;
+		desc->lld.mbr_ubc = cpu_to_le32(AT_XDMAC_MBR_UBC_NDV2			/* next descriptor view */
+						| AT_XDMAC_MBR_UBC_NDEN					/* next descriptor dst parameter update */
+						| AT_XDMAC_MBR_UBC_NSEN					/* next descriptor src parameter update */
+						| (i == sg_len - 1 ? 0 : AT_XDMAC_MBR_UBC_NDE)		/* descriptor fetch */
+						| (len >> fixed_dwidth));				/* microblock length */
 		dev_dbg(chan2dev(chan),
 			 "%s: lld: mbr_sa=%pad, mbr_da=%pad, mbr_ubc=0x%08x\n",
 			 __func__, &desc->lld.mbr_sa, &desc->lld.mbr_da, desc->lld.mbr_ubc);
 
 		/* Chain lld. */
 		if (prev) {
-			prev->lld.mbr_nda = desc->tx_dma_desc.phys;
+			prev->lld.mbr_nda = cpu_to_le32(desc->tx_dma_desc.phys);
 			dev_dbg(chan2dev(chan),
 				 "%s: chain lld: prev=0x%p, mbr_nda=%pad\n",
 				 __func__, prev, &prev->lld.mbr_nda);
@@ -664,6 +666,7 @@ at_xdmac_prep_dma_cyclic(struct dma_chan *chan, dma_addr_t buf_addr,
 	struct at_xdmac_desc	*first = NULL, *prev = NULL;
 	unsigned int		periods = buf_len / period_len;
 	int			i;
+	__le32			mbr_cfg;
 
 	dev_dbg(chan2dev(chan), "%s: buf_addr=%pad, buf_len=%zd, period_len=%zd, dir=%s, flags=0x%lx\n",
 		__func__, &buf_addr, buf_len, period_len,
@@ -697,19 +700,21 @@ at_xdmac_prep_dma_cyclic(struct dma_chan *chan, dma_addr_t buf_addr,
 			__func__, desc, &desc->tx_dma_desc.phys);
 
 		if (direction == DMA_DEV_TO_MEM) {
-			desc->lld.mbr_sa = atchan->per_src_addr;
-			desc->lld.mbr_da = buf_addr + i * period_len;
-			desc->lld.mbr_cfg = atchan->cfg[AT_XDMAC_DEV_TO_MEM_CFG];
+			mbr_cfg = atchan->cfg[AT_XDMAC_DEV_TO_MEM_CFG];
+			desc->lld.mbr_sa = cpu_to_le32(atchan->per_src_addr);
+			desc->lld.mbr_da = cpu_to_le32(buf_addr + i * period_len);
+			desc->lld.mbr_cfg = cpu_to_le32(mbr_cfg);
 		} else {
-			desc->lld.mbr_sa = buf_addr + i * period_len;
-			desc->lld.mbr_da = atchan->per_dst_addr;
-			desc->lld.mbr_cfg = atchan->cfg[AT_XDMAC_MEM_TO_DEV_CFG];
+			mbr_cfg = atchan->cfg[AT_XDMAC_MEM_TO_DEV_CFG];
+			desc->lld.mbr_sa = cpu_to_le32(buf_addr + i * period_len);
+			desc->lld.mbr_da = cpu_to_le32(atchan->per_dst_addr);
+			desc->lld.mbr_cfg = cpu_to_le32(mbr_cfg);
 		}
-		desc->lld.mbr_ubc = AT_XDMAC_MBR_UBC_NDV1
-			| AT_XDMAC_MBR_UBC_NDEN
-			| AT_XDMAC_MBR_UBC_NSEN
-			| AT_XDMAC_MBR_UBC_NDE
-			| period_len >> at_xdmac_get_dwidth(desc->lld.mbr_cfg);
+		desc->lld.mbr_ubc = cpu_to_le32(AT_XDMAC_MBR_UBC_NDV1
+						| AT_XDMAC_MBR_UBC_NDEN
+						| AT_XDMAC_MBR_UBC_NSEN
+						| AT_XDMAC_MBR_UBC_NDE
+						| period_len >> at_xdmac_get_dwidth(mbr_cfg));
 
 		dev_dbg(chan2dev(chan),
 			 "%s: lld: mbr_sa=%pad, mbr_da=%pad, mbr_ubc=0x%08x\n",
@@ -717,7 +722,7 @@ at_xdmac_prep_dma_cyclic(struct dma_chan *chan, dma_addr_t buf_addr,
 
 		/* Chain lld. */
 		if (prev) {
-			prev->lld.mbr_nda = desc->tx_dma_desc.phys;
+			prev->lld.mbr_nda = cpu_to_le32(desc->tx_dma_desc.phys);
 			dev_dbg(chan2dev(chan),
 				 "%s: chain lld: prev=0x%p, mbr_nda=%pad\n",
 				 __func__, prev, &prev->lld.mbr_nda);
@@ -732,7 +737,7 @@ at_xdmac_prep_dma_cyclic(struct dma_chan *chan, dma_addr_t buf_addr,
 		list_add_tail(&desc->desc_node, &first->descs_list);
 	}
 
-	prev->lld.mbr_nda = first->tx_dma_desc.phys;
+	prev->lld.mbr_nda = cpu_to_le32(first->tx_dma_desc.phys);
 	dev_dbg(chan2dev(chan),
 		"%s: chain lld: prev=0x%p, mbr_nda=%pad\n",
 		__func__, prev, &prev->lld.mbr_nda);
@@ -838,14 +843,14 @@ at_xdmac_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dest, dma_addr_t src,
 		ublen = xfer_size >> dwidth;
 		remaining_size -= xfer_size;
 
-		desc->lld.mbr_sa = src_addr;
-		desc->lld.mbr_da = dst_addr;
-		desc->lld.mbr_ubc = AT_XDMAC_MBR_UBC_NDV2
-			| AT_XDMAC_MBR_UBC_NDEN
-			| AT_XDMAC_MBR_UBC_NSEN
-			| (remaining_size ? AT_XDMAC_MBR_UBC_NDE : 0)
-			| ublen;
-		desc->lld.mbr_cfg = chan_cc;
+		desc->lld.mbr_sa = cpu_to_le32(src_addr);
+		desc->lld.mbr_da = cpu_to_le32(dst_addr);
+		desc->lld.mbr_ubc = cpu_to_le32(AT_XDMAC_MBR_UBC_NDV2
+						| AT_XDMAC_MBR_UBC_NDEN
+						| AT_XDMAC_MBR_UBC_NSEN
+						| (remaining_size ? AT_XDMAC_MBR_UBC_NDE : 0)
+						| ublen);
+		desc->lld.mbr_cfg = cpu_to_le32(chan_cc);
 
 		dev_dbg(chan2dev(chan),
 			 "%s: lld: mbr_sa=%pad, mbr_da=%pad, mbr_ubc=0x%08x, mbr_cfg=0x%08x\n",
@@ -853,10 +858,10 @@ at_xdmac_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dest, dma_addr_t src,
 
 		/* Chain lld. */
 		if (prev) {
-			prev->lld.mbr_nda = desc->tx_dma_desc.phys;
+			prev->lld.mbr_nda = cpu_to_le32(desc->tx_dma_desc.phys);
 			dev_dbg(chan2dev(chan),
 				 "%s: chain lld: prev=0x%p, mbr_nda=0x%08x\n",
-				 __func__, prev, prev->lld.mbr_nda);
+				__func__, prev, le32_to_cpu(prev->lld.mbr_nda));
 		}
 
 		prev = desc;
@@ -915,7 +920,7 @@ at_xdmac_tx_status(struct dma_chan *chan, dma_cookie_t cookie,
 	 */
 	mask = AT_XDMAC_CC_TYPE | AT_XDMAC_CC_DSYNC;
 	value = AT_XDMAC_CC_TYPE_PER_TRAN | AT_XDMAC_CC_DSYNC_PER2MEM;
-	if ((desc->lld.mbr_cfg & mask) == value) {
+	if ((le32_to_cpu(desc->lld.mbr_cfg) & mask) == value) {
 		at_xdmac_write(atxdmac, AT_XDMAC_GSWF, atchan->mask);
 		while (!(at_xdmac_chan_read(atchan, AT_XDMAC_CIS) & AT_XDMAC_CIS_FIS))
 			cpu_relax();
@@ -929,9 +934,9 @@ at_xdmac_tx_status(struct dma_chan *chan, dma_cookie_t cookie,
 	 */
 	descs_list = &desc->descs_list;
 	list_for_each_entry_safe(desc, _desc, descs_list, desc_node) {
-		dwidth = at_xdmac_get_dwidth(desc->lld.mbr_cfg);
-		residue -= (desc->lld.mbr_ubc & 0xffffff) << dwidth;
-		if ((desc->lld.mbr_nda & 0xfffffffc) == cur_nda)
+		dwidth = at_xdmac_get_dwidth(cpu_to_le32(desc->lld.mbr_cfg));
+		residue -= (cpu_to_le32(desc->lld.mbr_ubc) & 0xffffff) << dwidth;
+		if ((cpu_to_le32(desc->lld.mbr_nda) & 0xfffffffc) == cur_nda)
 			break;
 	}
 	residue += at_xdmac_chan_read(atchan, AT_XDMAC_CUBC) << dwidth;
-- 
2.1.4
