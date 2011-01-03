From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 03 Jan 2011 22:40:13 +0000
Subject: [PATCH 30/48] ARM: PL08x: move default cctl into txd structure
In-Reply-To: <20110103222943.GB4572@n2100.arm.linux.org.uk>
References: <20110103222943.GB4572@n2100.arm.linux.org.uk>
Message-ID: <E1PZt4X-0002zS-DM@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rather than modifying platform data while preparing a transfer, copy
the cctl value into the txd structure and modify the value there.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/amba-pl08x.c   |   21 ++++++---------------
 include/linux/amba/pl08x.h |    3 ++-
 2 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index f0a2988..6d224d4 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -577,7 +577,6 @@ static inline size_t pl08x_pre_boundary(u32 addr, size_t len)
 static int pl08x_fill_llis_for_desc(struct pl08x_driver_data *pl08x,
 			      struct pl08x_txd *txd)
 {
-	struct pl08x_channel_data *cd = txd->cd;
 	struct pl08x_bus_data *mbus, *sbus;
 	size_t remainder;
 	int num_llis = 0;
@@ -595,17 +594,8 @@ static int pl08x_fill_llis_for_desc(struct pl08x_driver_data *pl08x,
 
 	pl08x->pool_ctr++;
 
-	/*
-	 * Initialize bus values for this transfer
-	 * from the passed optimal values
-	 */
-	if (!cd) {
-		dev_err(&pl08x->adev->dev, "%s no channel data\n", __func__);
-		return 0;
-	}
-
-	/* Get the default CCTL from the platform data */
-	cctl = cd->cctl;
+	/* Get the default CCTL */
+	cctl = txd->cctl;
 
 	/*
 	 * On the PL080 we have two bus masters and we
@@ -1358,11 +1348,11 @@ static struct dma_async_tx_descriptor *pl08x_prep_dma_memcpy(
 	txd->dstbus.addr = dest;
 
 	/* Set platform data for m2m */
-	txd->cd = &pl08x->pd->memcpy_channel;
 	txd->ccfg |= PL080_FLOW_MEM2MEM << PL080_CONFIG_FLOW_CONTROL_SHIFT;
+	txd->cctl = pl08x->pd->memcpy_channel.cctl;
 
 	/* Both to be incremented or the code will break */
-	txd->cd->cctl |= PL080_CONTROL_SRC_INCR | PL080_CONTROL_DST_INCR;
+	txd->cctl |= PL080_CONTROL_SRC_INCR | PL080_CONTROL_DST_INCR;
 	txd->len = len;
 
 	ret = pl08x_prep_channel_resources(plchan, txd);
@@ -1415,6 +1405,8 @@ static struct dma_async_tx_descriptor *pl08x_prep_slave_sg(
 	 * channel target address dynamically at runtime.
 	 */
 	txd->direction = direction;
+	txd->cctl = plchan->cd->cctl;
+
 	if (direction == DMA_TO_DEVICE) {
 		txd->ccfg |= PL080_FLOW_MEM2PER << PL080_CONFIG_FLOW_CONTROL_SHIFT;
 		txd->srcbus.addr = sgl->dma_address;
@@ -1434,7 +1426,6 @@ static struct dma_async_tx_descriptor *pl08x_prep_slave_sg(
 			"%s direction unsupported\n", __func__);
 		return NULL;
 	}
-	txd->cd = plchan->cd;
 	txd->len = sgl->length;
 
 	ret = pl08x_prep_channel_resources(plchan, txd);
diff --git a/include/linux/amba/pl08x.h b/include/linux/amba/pl08x.h
index 8e74cb1..8d90830 100644
--- a/include/linux/amba/pl08x.h
+++ b/include/linux/amba/pl08x.h
@@ -110,8 +110,9 @@ struct pl08x_txd {
 	size_t len;
 	dma_addr_t llis_bus;
 	void *llis_va;
-	struct pl08x_channel_data *cd;
 	bool active;
+	/* Default cctl value for LLIs */
+	u32 cctl;
 	/*
 	 * Settings to be put into the physical channel when we
 	 * trigger this txd.  Other registers are in llis_va[0].
-- 
1.6.2.5
