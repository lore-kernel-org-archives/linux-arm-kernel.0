From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 03 Jan 2011 22:41:13 +0000
Subject: [PATCH 33/48] ARM: PL08x: allow AHB master port selection to be
	configured
In-Reply-To: <20110103222943.GB4572@n2100.arm.linux.org.uk>
References: <20110103222943.GB4572@n2100.arm.linux.org.uk>
Message-ID: <E1PZt5V-0003RV-Oq@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Platforms need to be able to control which AHB master interface is used,
as each AHB master interface may be asymetric.  Allow the interfaces
used for fetching LLIs, memory, and each peripheral to be configured
individually.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/amba-pl08x.c   |   77 ++++++++++++++++++++++++-------------------
 include/linux/amba/pl08x.h |   15 +++++++-
 2 files changed, 56 insertions(+), 36 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index 4ee0ab1..986c127 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -126,6 +126,8 @@ struct pl08x_lli {
  * @phy_chans: array of data for the physical channels
  * @pool: a pool for the LLI descriptors
  * @pool_ctr: counter of LLIs in the pool
+ * @lli_buses: bitmask to or in to LLI pointer selecting AHB port for LLI fetches
+ * @mem_buses: set to indicate memory transfers on AHB2.
  * @lock: a spinlock for this struct
  */
 struct pl08x_driver_data {
@@ -138,6 +140,8 @@ struct pl08x_driver_data {
 	struct pl08x_phy_chan *phy_chans;
 	struct dma_pool *pool;
 	int pool_ctr;
+	u8 lli_buses;
+	u8 mem_buses;
 	spinlock_t lock;
 };
 
@@ -526,20 +530,12 @@ static int pl08x_fill_lli_for_desc(struct pl08x_driver_data *pl08x,
 
 	BUG_ON(num_llis >= MAX_NUM_TSFR_LLIS);
 
-	llis_va[num_llis].cctl		= cctl;
-	llis_va[num_llis].src		= txd->srcbus.addr;
-	llis_va[num_llis].dst		= txd->dstbus.addr;
-
-	/*
-	 * On versions with dual masters, you can optionally AND on
-	 * PL080_LLI_LM_AHB2 to the LLI to tell the hardware to read
-	 * in new LLIs with that controller, but we always try to
-	 * choose AHB1 to point into memory. The idea is to have AHB2
-	 * fixed on the peripheral and AHB1 messing around in the
-	 * memory. So we don't manipulate this bit currently.
-	 */
-
+	llis_va[num_llis].cctl = cctl;
+	llis_va[num_llis].src = txd->srcbus.addr;
+	llis_va[num_llis].dst = txd->dstbus.addr;
 	llis_va[num_llis].lli = llis_bus + (num_llis + 1) * sizeof(struct pl08x_lli);
+	if (pl08x->lli_buses & PL08X_AHB2)
+		llis_va[num_llis].lli |= PL080_LLI_LM_AHB2;
 
 	if (cctl & PL080_CONTROL_SRC_INCR)
 		txd->srcbus.addr += len;
@@ -639,13 +635,6 @@ static int pl08x_fill_llis_for_desc(struct pl08x_driver_data *pl08x,
 	pl08x_choose_master_bus(&txd->srcbus, &txd->dstbus,
 				&mbus, &sbus, cctl);
 
-
-	/*
-	 * The lowest bit of the LLI register
-	 * is also used to indicate which master to
-	 * use for reading the LLIs.
-	 */
-
 	if (txd->len < mbus->buswidth) {
 		/*
 		 * Less than a bus width available
@@ -1282,6 +1271,23 @@ static int pl08x_prep_channel_resources(struct pl08x_dma_chan *plchan,
 	return 0;
 }
 
+/*
+ * Given the source and destination available bus masks, select which
+ * will be routed to each port.  We try to have source and destination
+ * on separate ports, but always respect the allowable settings.
+ */
+static u32 pl08x_select_bus(struct pl08x_driver_data *pl08x, u8 src, u8 dst)
+{
+	u32 cctl = 0;
+
+	if (!(dst & PL08X_AHB1) || ((dst & PL08X_AHB2) && (src & PL08X_AHB1)))
+		cctl |= PL080_CONTROL_DST_AHB2;
+	if (!(src & PL08X_AHB1) || ((src & PL08X_AHB2) && !(dst & PL08X_AHB2)))
+		cctl |= PL080_CONTROL_SRC_AHB2;
+
+	return cctl;
+}
+
 static struct pl08x_txd *pl08x_get_txd(struct pl08x_dma_chan *plchan)
 {
 	struct pl08x_txd *txd = kzalloc(sizeof(struct pl08x_txd), GFP_NOWAIT);
@@ -1330,15 +1336,9 @@ static struct dma_async_tx_descriptor *pl08x_prep_dma_memcpy(
 	/* Both to be incremented or the code will break */
 	txd->cctl |= PL080_CONTROL_SRC_INCR | PL080_CONTROL_DST_INCR;
 
-	/*
-	 * On the PL080 we have two bus masters and we should select one for
-	 * source and one for destination. We try to use AHB2 for the bus
-	 * which does not increment (typically the peripheral) else we just
-	 * choose something.
-	 */
 	if (pl08x->vd->dualmaster)
-		/* Source increments, use AHB2 for destination */
-		txd->cctl |= PL080_CONTROL_DST_AHB2;
+		txd->cctl |= pl08x_select_bus(pl08x,
+					pl08x->mem_buses, pl08x->mem_buses);
 
 	ret = pl08x_prep_channel_resources(plchan, txd);
 	if (ret)
@@ -1359,6 +1359,7 @@ static struct dma_async_tx_descriptor *pl08x_prep_slave_sg(
 	struct pl08x_dma_chan *plchan = to_pl08x_chan(chan);
 	struct pl08x_driver_data *pl08x = plchan->host;
 	struct pl08x_txd *txd;
+	u8 src_buses, dst_buses;
 	int ret;
 
 	/*
@@ -1403,31 +1404,31 @@ static struct dma_async_tx_descriptor *pl08x_prep_slave_sg(
 	if (direction == DMA_TO_DEVICE) {
 		txd->ccfg |= PL080_FLOW_MEM2PER << PL080_CONFIG_FLOW_CONTROL_SHIFT;
 		txd->cctl |= PL080_CONTROL_SRC_INCR;
-		if (pl08x->vd->dualmaster)
-			/* Source increments, use AHB2 for destination */
-			txd->cctl |= PL080_CONTROL_DST_AHB2;
 		txd->srcbus.addr = sgl->dma_address;
 		if (plchan->runtime_addr)
 			txd->dstbus.addr = plchan->runtime_addr;
 		else
 			txd->dstbus.addr = plchan->cd->addr;
+		src_buses = pl08x->mem_buses;
+		dst_buses = plchan->cd->periph_buses;
 	} else if (direction == DMA_FROM_DEVICE) {
 		txd->ccfg |= PL080_FLOW_PER2MEM << PL080_CONFIG_FLOW_CONTROL_SHIFT;
 		txd->cctl |= PL080_CONTROL_DST_INCR;
-		if (pl08x->vd->dualmaster)
-			/* Destination increments, use AHB2 for source */
-			txd->cctl |= PL080_CONTROL_SRC_AHB2;
 		if (plchan->runtime_addr)
 			txd->srcbus.addr = plchan->runtime_addr;
 		else
 			txd->srcbus.addr = plchan->cd->addr;
 		txd->dstbus.addr = sgl->dma_address;
+		src_buses = plchan->cd->periph_buses;
+		dst_buses = pl08x->mem_buses;
 	} else {
 		dev_err(&pl08x->adev->dev,
 			"%s direction unsupported\n", __func__);
 		return NULL;
 	}
 
+	txd->cctl |= pl08x_select_bus(pl08x, src_buses, dst_buses);
+
 	ret = pl08x_prep_channel_resources(plchan, txd);
 	if (ret)
 		return NULL;
@@ -1879,6 +1880,14 @@ static int pl08x_probe(struct amba_device *adev, struct amba_id *id)
 	pl08x->adev = adev;
 	pl08x->vd = vd;
 
+	/* By default, AHB1 only.  If dualmaster, from platform */
+	pl08x->lli_buses = PL08X_AHB1;
+	pl08x->mem_buses = PL08X_AHB1;
+	if (pl08x->vd->dualmaster) {
+		pl08x->lli_buses = pl08x->pd->lli_buses;
+		pl08x->mem_buses = pl08x->pd->mem_buses;
+	}
+
 	/* A DMA memory pool for LLIs, align on 1-byte boundary */
 	pl08x->pool = dma_pool_create(DRIVER_NAME, &pl08x->adev->dev,
 			PL08X_LLI_TSFR_SIZE, PL08X_ALIGN, 0);
diff --git a/include/linux/amba/pl08x.h b/include/linux/amba/pl08x.h
index 8d90830..f858651 100644
--- a/include/linux/amba/pl08x.h
+++ b/include/linux/amba/pl08x.h
@@ -25,6 +25,12 @@
 struct pl08x_lli;
 struct pl08x_driver_data;
 
+/* Bitmasks for selecting AHB ports for DMA transfers */
+enum {
+	PL08X_AHB1 = (1 << 0),
+	PL08X_AHB2 = (1 << 1)
+};
+
 /**
  * struct pl08x_channel_data - data structure to pass info between
  * platform and PL08x driver regarding channel configuration
@@ -51,6 +57,8 @@ struct pl08x_driver_data;
  * round round round)
  * @single: the device connected to this channel will request single
  * DMA transfers, not bursts. (Bursts are default.)
+ * @periph_buses: the device connected to this channel is accessible via
+ * these buses (use PL08X_AHB1 | PL08X_AHB2).
  */
 struct pl08x_channel_data {
 	char *bus_id;
@@ -61,6 +69,7 @@ struct pl08x_channel_data {
 	dma_addr_t addr;
 	bool circular_buffer;
 	bool single;
+	u8 periph_buses;
 };
 
 /**
@@ -193,8 +202,8 @@ struct pl08x_dma_chan {
  * less than zero, else it returns the allocated signal number
  * @put_signal: indicate to the platform that this physical signal is not
  * running any DMA transfer and multiplexing can be recycled
- * @bus_bit_lli: Bit[0] of the address indicated which AHB bus master the
- * LLI addresses are on 0/1 Master 1/2.
+ * @lli_buses: buses which LLIs can be fetched from: PL08X_AHB1 | PL08X_AHB2
+ * @mem_buses: buses which memory can be accessed from: PL08X_AHB1 | PL08X_AHB2
  */
 struct pl08x_platform_data {
 	struct pl08x_channel_data *slave_channels;
@@ -202,6 +211,8 @@ struct pl08x_platform_data {
 	struct pl08x_channel_data memcpy_channel;
 	int (*get_signal)(struct pl08x_dma_chan *);
 	void (*put_signal)(struct pl08x_dma_chan *);
+	u8 lli_buses;
+	u8 mem_buses;
 };
 
 #ifdef CONFIG_AMBA_PL08X
-- 
1.6.2.5
