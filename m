From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Tue, 27 Jan 2015 16:30:32 +0100
Subject: [RESEND PATCH v2 4/4] dmaengine: at_xdmac: allow muliple dwidths when
 doing slave transfers
In-Reply-To: <1422372632-21659-1-git-send-email-ludovic.desroches@atmel.com>
References: <1422372632-21659-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <1422372632-21659-5-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When using FIFO, we need to support differents data width in a single
transfer. For example, serial device which usually uses 1-byte data
width will use 4-bytes data width when using the FIFO. If the transfer
size is not aligned on 4-bytes then the end of the transfer will be
performed with 1-byte data-width. For that reason,
at_xdmac_prep_slave_sg() now builds linked list descriptors using view 2
instead of view 1 so each of them can update the DWIDTH field into the
Channel Configuration Register.

Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 drivers/dma/at_xdmac.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index 37aa4a9..710546d 100644
--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -25,6 +25,7 @@
 #include <linux/dmapool.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
+#include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/module.h>
 #include <linux/of_dma.h>
@@ -351,11 +352,11 @@ static void at_xdmac_start_xfer(struct at_xdmac_chan *atchan,
 	at_xdmac_chan_write(atchan, AT_XDMAC_CNDA, reg);
 
 	/*
-	 * When doing memory to memory transfer we need to use the next
+	 * When doing non cyclic transfer we need to use the next
 	 * descriptor view 2 since some fields of the configuration register
 	 * depend on transfer size and src/dest addresses.
 	 */
-	if (is_slave_direction(first->direction)) {
+	if (at_xdmac_chan_is_cyclic(atchan)) {
 		reg = AT_XDMAC_CNDC_NDVIEW_NDV1;
 		at_xdmac_chan_write(atchan, AT_XDMAC_CC, first->lld.mbr_cfg);
 	} else {
@@ -582,7 +583,7 @@ at_xdmac_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 	/* Prepare descriptors. */
 	for_each_sg(sgl, sg, sg_len, i) {
 		struct at_xdmac_desc	*desc = NULL;
-		u32			len, mem;
+		u32			len, mem, dwidth, fixed_dwidth;
 
 		len = sg_dma_len(sg);
 		mem = sg_dma_address(sg);
@@ -613,11 +614,15 @@ at_xdmac_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 			desc->lld.mbr_da = atchan->per_dst_addr;
 			desc->lld.mbr_cfg = atchan->cfg[AT_XDMAC_MEM_TO_DEV_CFG];
 		}
-		desc->lld.mbr_ubc = AT_XDMAC_MBR_UBC_NDV1			/* next descriptor view */
+		dwidth = at_xdmac_get_dwidth(desc->lld.mbr_cfg);
+		fixed_dwidth = IS_ALIGNED(len, 1 << dwidth)
+			       ? at_xdmac_get_dwidth(desc->lld.mbr_cfg)
+			       : AT_XDMAC_CC_DWIDTH_BYTE;
+		desc->lld.mbr_ubc = AT_XDMAC_MBR_UBC_NDV2			/* next descriptor view */
 			| AT_XDMAC_MBR_UBC_NDEN					/* next descriptor dst parameter update */
 			| AT_XDMAC_MBR_UBC_NSEN					/* next descriptor src parameter update */
 			| (i == sg_len - 1 ? 0 : AT_XDMAC_MBR_UBC_NDE)		/* descriptor fetch */
-			| len / (1 << at_xdmac_get_dwidth(desc->lld.mbr_cfg));	/* microblock length */
+			| (len >> fixed_dwidth);				/* microblock length */
 		dev_dbg(chan2dev(chan),
 			 "%s: lld: mbr_sa=%pad, mbr_da=%pad, mbr_ubc=0x%08x\n",
 			 __func__, &desc->lld.mbr_sa, &desc->lld.mbr_da, desc->lld.mbr_ubc);
-- 
2.2.0
