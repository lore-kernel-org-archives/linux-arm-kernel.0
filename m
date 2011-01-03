From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 03 Jan 2011 22:40:33 +0000
Subject: [PATCH 31/48] ARM: PL08x: move cctl increment and protection setup to
	prep_slave_sg
In-Reply-To: <20110103222943.GB4572@n2100.arm.linux.org.uk>
References: <20110103222943.GB4572@n2100.arm.linux.org.uk>
Message-ID: <E1PZt4r-0003E2-GG@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We don't need to initialize the cctl increment and protection values
in the runtime_config method - we have all the inforamtion to setup
these values in prep_slave_sg().  Move their initialization there.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/amba-pl08x.c |   15 ++++++++-------
 1 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index 6d224d4..72cc971 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -1148,12 +1148,10 @@ static void dma_set_runtime_config(struct dma_chan *chan,
 	plchan->runtime_direction = config->direction;
 	if (config->direction == DMA_TO_DEVICE) {
 		plchan->runtime_addr = config->dst_addr;
-		cctl |= PL080_CONTROL_SRC_INCR;
 		addr_width = config->dst_addr_width;
 		maxburst = config->dst_maxburst;
 	} else if (config->direction == DMA_FROM_DEVICE) {
 		plchan->runtime_addr = config->src_addr;
-		cctl |= PL080_CONTROL_DST_INCR;
 		addr_width = config->src_addr_width;
 		maxburst = config->src_maxburst;
 	} else {
@@ -1197,10 +1195,6 @@ static void dma_set_runtime_config(struct dma_chan *chan,
 		cctl |= burst_sizes[i].reg;
 	}
 
-	/* Access the cell in privileged mode, non-bufferable, non-cacheable */
-	cctl &= ~PL080_CONTROL_PROT_MASK;
-	cctl |= PL080_CONTROL_PROT_SYS;
-
 	/* Modify the default channel data to fit PrimeCell request */
 	cd->cctl = cctl;
 
@@ -1405,10 +1399,16 @@ static struct dma_async_tx_descriptor *pl08x_prep_slave_sg(
 	 * channel target address dynamically at runtime.
 	 */
 	txd->direction = direction;
-	txd->cctl = plchan->cd->cctl;
+	txd->cctl = plchan->cd->cctl &
+			~(PL080_CONTROL_SRC_INCR | PL080_CONTROL_DST_INCR |
+			  PL080_CONTROL_PROT_MASK);
+
+	/* Access the cell in privileged mode, non-bufferable, non-cacheable */
+	txd->cctl |= PL080_CONTROL_PROT_SYS;
 
 	if (direction == DMA_TO_DEVICE) {
 		txd->ccfg |= PL080_FLOW_MEM2PER << PL080_CONFIG_FLOW_CONTROL_SHIFT;
+		txd->cctl |= PL080_CONTROL_SRC_INCR;
 		txd->srcbus.addr = sgl->dma_address;
 		if (plchan->runtime_addr)
 			txd->dstbus.addr = plchan->runtime_addr;
@@ -1416,6 +1416,7 @@ static struct dma_async_tx_descriptor *pl08x_prep_slave_sg(
 			txd->dstbus.addr = plchan->cd->addr;
 	} else if (direction == DMA_FROM_DEVICE) {
 		txd->ccfg |= PL080_FLOW_PER2MEM << PL080_CONFIG_FLOW_CONTROL_SHIFT;
+		txd->cctl |= PL080_CONTROL_DST_INCR;
 		if (plchan->runtime_addr)
 			txd->srcbus.addr = plchan->runtime_addr;
 		else
-- 
1.6.2.5
