From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 03 Jan 2011 22:40:53 +0000
Subject: [PATCH 32/48] ARM: PL08x: move AHB master port selection into prep_*
	functions
In-Reply-To: <20110103222943.GB4572@n2100.arm.linux.org.uk>
References: <20110103222943.GB4572@n2100.arm.linux.org.uk>
Message-ID: <E1PZt5B-0003RR-LQ@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As we initialize the default cctl value in the prep_* functions along
with the increment settings, we don't need to repeat the selection of
the AHB ports each time we create a LLI entry.  Do this in the prep_*
functions once per transfer.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/amba-pl08x.c |   47 ++++++++++++++++++++++-----------------------
 1 files changed, 23 insertions(+), 24 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index 72cc971..4ee0ab1 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -597,26 +597,6 @@ static int pl08x_fill_llis_for_desc(struct pl08x_driver_data *pl08x,
 	/* Get the default CCTL */
 	cctl = txd->cctl;
 
-	/*
-	 * On the PL080 we have two bus masters and we
-	 * should select one for source and one for
-	 * destination. We try to use AHB2 for the
-	 * bus which does not increment (typically the
-	 * peripheral) else we just choose something.
-	 */
-	cctl &= ~(PL080_CONTROL_DST_AHB2 | PL080_CONTROL_SRC_AHB2);
-	if (pl08x->vd->dualmaster) {
-		if (cctl & PL080_CONTROL_SRC_INCR)
-			/* Source increments, use AHB2 for destination */
-			cctl |= PL080_CONTROL_DST_AHB2;
-		else if (cctl & PL080_CONTROL_DST_INCR)
-			/* Destination increments, use AHB2 for source */
-			cctl |= PL080_CONTROL_SRC_AHB2;
-		else
-			/* Just pick something, source AHB1 dest AHB2 */
-			cctl |= PL080_CONTROL_DST_AHB2;
-	}
-
 	/* Find maximum width of the source bus */
 	txd->srcbus.maxwidth =
 		pl08x_get_bytes_for_cctl((cctl & PL080_CONTROL_SWIDTH_MASK) >>
@@ -1340,14 +1320,25 @@ static struct dma_async_tx_descriptor *pl08x_prep_dma_memcpy(
 	txd->direction = DMA_NONE;
 	txd->srcbus.addr = src;
 	txd->dstbus.addr = dest;
+	txd->len = len;
 
 	/* Set platform data for m2m */
 	txd->ccfg |= PL080_FLOW_MEM2MEM << PL080_CONFIG_FLOW_CONTROL_SHIFT;
-	txd->cctl = pl08x->pd->memcpy_channel.cctl;
+	txd->cctl = pl08x->pd->memcpy_channel.cctl &
+			~(PL080_CONTROL_DST_AHB2 | PL080_CONTROL_SRC_AHB2);
 
 	/* Both to be incremented or the code will break */
 	txd->cctl |= PL080_CONTROL_SRC_INCR | PL080_CONTROL_DST_INCR;
-	txd->len = len;
+
+	/*
+	 * On the PL080 we have two bus masters and we should select one for
+	 * source and one for destination. We try to use AHB2 for the bus
+	 * which does not increment (typically the peripheral) else we just
+	 * choose something.
+	 */
+	if (pl08x->vd->dualmaster)
+		/* Source increments, use AHB2 for destination */
+		txd->cctl |= PL080_CONTROL_DST_AHB2;
 
 	ret = pl08x_prep_channel_resources(plchan, txd);
 	if (ret)
@@ -1399,8 +1390,11 @@ static struct dma_async_tx_descriptor *pl08x_prep_slave_sg(
 	 * channel target address dynamically at runtime.
 	 */
 	txd->direction = direction;
+	txd->len = sgl->length;
+
 	txd->cctl = plchan->cd->cctl &
-			~(PL080_CONTROL_SRC_INCR | PL080_CONTROL_DST_INCR |
+			~(PL080_CONTROL_SRC_AHB2 | PL080_CONTROL_DST_AHB2 |
+			  PL080_CONTROL_SRC_INCR | PL080_CONTROL_DST_INCR |
 			  PL080_CONTROL_PROT_MASK);
 
 	/* Access the cell in privileged mode, non-bufferable, non-cacheable */
@@ -1409,6 +1403,9 @@ static struct dma_async_tx_descriptor *pl08x_prep_slave_sg(
 	if (direction == DMA_TO_DEVICE) {
 		txd->ccfg |= PL080_FLOW_MEM2PER << PL080_CONFIG_FLOW_CONTROL_SHIFT;
 		txd->cctl |= PL080_CONTROL_SRC_INCR;
+		if (pl08x->vd->dualmaster)
+			/* Source increments, use AHB2 for destination */
+			txd->cctl |= PL080_CONTROL_DST_AHB2;
 		txd->srcbus.addr = sgl->dma_address;
 		if (plchan->runtime_addr)
 			txd->dstbus.addr = plchan->runtime_addr;
@@ -1417,6 +1414,9 @@ static struct dma_async_tx_descriptor *pl08x_prep_slave_sg(
 	} else if (direction == DMA_FROM_DEVICE) {
 		txd->ccfg |= PL080_FLOW_PER2MEM << PL080_CONFIG_FLOW_CONTROL_SHIFT;
 		txd->cctl |= PL080_CONTROL_DST_INCR;
+		if (pl08x->vd->dualmaster)
+			/* Destination increments, use AHB2 for source */
+			txd->cctl |= PL080_CONTROL_SRC_AHB2;
 		if (plchan->runtime_addr)
 			txd->srcbus.addr = plchan->runtime_addr;
 		else
@@ -1427,7 +1427,6 @@ static struct dma_async_tx_descriptor *pl08x_prep_slave_sg(
 			"%s direction unsupported\n", __func__);
 		return NULL;
 	}
-	txd->len = sgl->length;
 
 	ret = pl08x_prep_channel_resources(plchan, txd);
 	if (ret)
-- 
1.6.2.5
