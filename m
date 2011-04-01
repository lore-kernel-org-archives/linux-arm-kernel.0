From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri,  1 Apr 2011 19:19:16 +0200
Subject: [PATCH 5/5] dmaengine: at_hdmac: specialize AHB interfaces to
	optimize transfers
In-Reply-To: <3ee5a0e314a22339ad7a15a5425045f5ed244eab.1301678094.git.nicolas.ferre@atmel.com>
References: <3ee5a0e314a22339ad7a15a5425045f5ed244eab.1301678094.git.nicolas.ferre@atmel.com>
Message-ID: <ec503e1ef062542fa4b0da84ad88bac60d0e42a7.1301678094.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DMA controller has two AHB interfaces on the SOC internal
matrix.
It is more efficient to specialize each interface as the
access to memory can introduce latencies that are not compatible
with peripheral accesses requirements.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 drivers/dma/at_hdmac.c      |   20 ++++++++++----------
 drivers/dma/at_hdmac_regs.h |    2 ++
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
index 6d0fb1f..634cca7 100644
--- a/drivers/dma/at_hdmac.c
+++ b/drivers/dma/at_hdmac.c
@@ -39,8 +39,7 @@
 
 #define	ATC_DEFAULT_CFG		(ATC_FIFOCFG_HALFFIFO)
 #define	ATC_DEFAULT_CTRLA	(0)
-#define	ATC_DEFAULT_CTRLB	(ATC_SIF(0)	\
-				|ATC_DIF(1))
+#define	ATC_DEFAULT_CTRLB	(ATC_SIF(MEM_IF) | ATC_DIF(MEM_IF))
 
 /*
  * Initial number of descriptors to allocate for each channel. This could
@@ -672,14 +671,14 @@ atc_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 	reg_width = atslave->reg_width;
 
 	ctrla = ATC_DEFAULT_CTRLA | atslave->ctrla;
-	ctrlb = ATC_DEFAULT_CTRLB | ATC_IEN;
+	ctrlb = ATC_IEN;
 
 	switch (direction) {
 	case DMA_TO_DEVICE:
 		ctrla |=  ATC_DST_WIDTH(reg_width);
 		ctrlb |=  ATC_DST_ADDR_MODE_FIXED
 			| ATC_SRC_ADDR_MODE_INCR
-			| ATC_FC_MEM2PER;
+			| ATC_FC_MEM2PER | ATC_SIF(MEM_IF) | ATC_DIF(PER_IF);
 		reg = atslave->tx_reg;
 		for_each_sg(sgl, sg, sg_len, i) {
 			struct at_desc	*desc;
@@ -720,7 +719,7 @@ atc_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 		ctrla |=  ATC_SRC_WIDTH(reg_width);
 		ctrlb |=  ATC_DST_ADDR_MODE_INCR
 			| ATC_SRC_ADDR_MODE_FIXED
-			| ATC_FC_PER2MEM;
+			| ATC_FC_PER2MEM | ATC_SIF(PER_IF) | ATC_DIF(MEM_IF);
 
 		reg = atslave->rx_reg;
 		for_each_sg(sgl, sg, sg_len, i) {
@@ -800,7 +799,7 @@ atc_prep_dma_cyclic(struct dma_chan *chan, dma_addr_t buf_addr, size_t buf_len,
 	unsigned int		periods = buf_len / period_len;
 	unsigned int		reg_width;
 	u32			ctrla;
-	u32			ctrlb;
+	u32			ctrlb = 0;
 	unsigned int		i;
 
 	dev_vdbg(chan2dev(chan), "prep_dma_cyclic: %s buf at 0x%08x - %d (%d/%d)\n",
@@ -831,12 +830,11 @@ atc_prep_dma_cyclic(struct dma_chan *chan, dma_addr_t buf_addr, size_t buf_len,
 	if (unlikely(!(direction & (DMA_TO_DEVICE | DMA_FROM_DEVICE))))
 		goto err_out;
 
-	/* prepare common CRTLA/CTRLB values */
+	/* prepare common CRTLA value */
 	ctrla =   ATC_DEFAULT_CTRLA | atslave->ctrla
 		| ATC_DST_WIDTH(reg_width)
 		| ATC_SRC_WIDTH(reg_width)
 		| period_len >> reg_width;
-	ctrlb = ATC_DEFAULT_CTRLB;
 
 	/* build cyclic linked list */
 	for (i = 0; i < periods; i++) {
@@ -854,7 +852,8 @@ atc_prep_dma_cyclic(struct dma_chan *chan, dma_addr_t buf_addr, size_t buf_len,
 			desc->lli.ctrlb = ctrlb
 					| ATC_DST_ADDR_MODE_FIXED
 					| ATC_SRC_ADDR_MODE_INCR
-					| ATC_FC_MEM2PER;
+					| ATC_FC_MEM2PER
+					| ATC_SIF(MEM_IF) | ATC_DIF(PER_IF);
 			break;
 
 		case DMA_FROM_DEVICE:
@@ -864,7 +863,8 @@ atc_prep_dma_cyclic(struct dma_chan *chan, dma_addr_t buf_addr, size_t buf_len,
 			desc->lli.ctrlb = ctrlb
 					| ATC_DST_ADDR_MODE_INCR
 					| ATC_SRC_ADDR_MODE_FIXED
-					| ATC_FC_PER2MEM;
+					| ATC_FC_PER2MEM
+					| ATC_SIF(PER_IF) | ATC_DIF(MEM_IF);
 			break;
 
 		default:
diff --git a/drivers/dma/at_hdmac_regs.h b/drivers/dma/at_hdmac_regs.h
index c79a9e0..9afcb8d 100644
--- a/drivers/dma/at_hdmac_regs.h
+++ b/drivers/dma/at_hdmac_regs.h
@@ -103,6 +103,8 @@
 /* Bitfields in CTRLB */
 #define	ATC_SIF(i)		(0x3 & (i))	/* Src tx done via AHB-Lite Interface i */
 #define	ATC_DIF(i)		((0x3 & (i)) <<  4)	/* Dst tx done via AHB-Lite Interface i */
+#define MEM_IF			0		/* specify AHB interface 0 as memory interface */
+#define PER_IF			1		/* specify AHB interface 1 as peripheral interface */
 #define	ATC_SRC_PIP		(0x1 <<  8)	/* Source Picture-in-Picture enabled */
 #define	ATC_DST_PIP		(0x1 << 12)	/* Destination Picture-in-Picture enabled */
 #define	ATC_SRC_DSCR_DIS	(0x1 << 16)	/* Src Descriptor fetch disable */
-- 
1.7.3
