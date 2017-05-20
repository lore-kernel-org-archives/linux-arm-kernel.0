From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 20 May 2017 23:42:52 +0200
Subject: [PATCH 3/5 v2] dma: pl08x: Make slave engine optional
In-Reply-To: <20170520214254.21541-1-linus.walleij@linaro.org>
References: <20170520214254.21541-1-linus.walleij@linaro.org>
Message-ID: <20170520214254.21541-3-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the vendor data does not specify any signals, we do not
have to support slave DMA. Make the registration of the slave
DMA engine optional, so we can use this for the FTDMAC020
in the Gemini that only has memcpy support.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- No changes, just resending.
---
 drivers/dma/amba-pl08x.c | 128 +++++++++++++++++++++++++++++------------------
 1 file changed, 78 insertions(+), 50 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index d3d660a36ad7..6ddb029dac50 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -253,8 +253,9 @@ struct pl08x_dma_chan {
 
 /**
  * struct pl08x_driver_data - the local state holder for the PL08x
- * @slave: slave engine for this instance
+ * @slave: optional slave engine for this instance
  * @memcpy: memcpy engine for this instance
+ * @has_slave: the PL08x has a slave engine (routed signals)
  * @base: virtual memory base (remapped) for the PL08x
  * @adev: the corresponding AMBA (PrimeCell) bus entry
  * @vd: vendor data for this PL08x variant
@@ -269,6 +270,7 @@ struct pl08x_dma_chan {
 struct pl08x_driver_data {
 	struct dma_device slave;
 	struct dma_device memcpy;
+	bool has_slave;
 	void __iomem *base;
 	struct amba_device *adev;
 	const struct vendor_data *vd;
@@ -705,7 +707,7 @@ static void pl08x_phy_free(struct pl08x_dma_chan *plchan)
 			break;
 		}
 
-	if (!next) {
+	if (!next && pl08x->has_slave) {
 		list_for_each_entry(p, &pl08x->slave.channels, vc.chan.device_node)
 			if (p->state == PL08X_CHAN_WAITING) {
 				next = p;
@@ -2085,12 +2087,15 @@ static int pl08x_debugfs_show(struct seq_file *s, void *data)
 			   pl08x_state_str(chan->state));
 	}
 
-	seq_printf(s, "\nPL08x virtual slave channels:\n");
-	seq_printf(s, "CHANNEL:\tSTATE:\n");
-	seq_printf(s, "--------\t------\n");
-	list_for_each_entry(chan, &pl08x->slave.channels, vc.chan.device_node) {
-		seq_printf(s, "%s\t\t%s\n", chan->name,
-			   pl08x_state_str(chan->state));
+	if (pl08x->has_slave) {
+		seq_printf(s, "\nPL08x virtual slave channels:\n");
+		seq_printf(s, "CHANNEL:\tSTATE:\n");
+		seq_printf(s, "--------\t------\n");
+		list_for_each_entry(chan, &pl08x->slave.channels,
+				    vc.chan.device_node) {
+			seq_printf(s, "%s\t\t%s\n", chan->name,
+				   pl08x_state_str(chan->state));
+		}
 	}
 
 	return 0;
@@ -2128,6 +2133,10 @@ static struct dma_chan *pl08x_find_chan_id(struct pl08x_driver_data *pl08x,
 {
 	struct pl08x_dma_chan *chan;
 
+	/* Trying to get a slave channel from something with no slave support */
+	if (!pl08x->has_slave)
+		return NULL;
+
 	list_for_each_entry(chan, &pl08x->slave.channels, vc.chan.device_node) {
 		if (chan->signal == id)
 			return &chan->vc.chan;
@@ -2265,20 +2274,24 @@ static int pl08x_of_probe(struct amba_device *adev,
 	 * for a device and have it's AHB interfaces set up at
 	 * translation time.
 	 */
-	chanp = devm_kcalloc(&adev->dev,
-			pl08x->vd->signals,
-			sizeof(struct pl08x_channel_data),
-			GFP_KERNEL);
-	if (!chanp)
-		return -ENOMEM;
+	if (pl08x->vd->signals) {
+		chanp = devm_kcalloc(&adev->dev,
+				     pl08x->vd->signals,
+				     sizeof(struct pl08x_channel_data),
+				     GFP_KERNEL);
+		if (!chanp)
+			return -ENOMEM;
 
-	pd->slave_channels = chanp;
-	for (i = 0; i < pl08x->vd->signals; i++) {
-		/* chanp->periph_buses will be assigned at translation */
-		chanp->bus_id = kasprintf(GFP_KERNEL, "slave%d", i);
-		chanp++;
+		pd->slave_channels = chanp;
+		for (i = 0; i < pl08x->vd->signals; i++) {
+			/*
+			 * chanp->periph_buses will be assigned at translation
+			 */
+			chanp->bus_id = kasprintf(GFP_KERNEL, "slave%d", i);
+			chanp++;
+		}
+		pd->num_slave_channels = pl08x->vd->signals;
 	}
-	pd->num_slave_channels = pl08x->vd->signals;
 
 	pl08x->pd = pd;
 
@@ -2340,24 +2353,34 @@ static int pl08x_probe(struct amba_device *adev, const struct amba_id *id)
 	pl08x->memcpy.directions = BIT(DMA_MEM_TO_MEM);
 	pl08x->memcpy.residue_granularity = DMA_RESIDUE_GRANULARITY_SEGMENT;
 
-	/* Initialize slave engine */
-	dma_cap_set(DMA_SLAVE, pl08x->slave.cap_mask);
-	dma_cap_set(DMA_CYCLIC, pl08x->slave.cap_mask);
-	pl08x->slave.dev = &adev->dev;
-	pl08x->slave.device_free_chan_resources = pl08x_free_chan_resources;
-	pl08x->slave.device_prep_dma_interrupt = pl08x_prep_dma_interrupt;
-	pl08x->slave.device_tx_status = pl08x_dma_tx_status;
-	pl08x->slave.device_issue_pending = pl08x_issue_pending;
-	pl08x->slave.device_prep_slave_sg = pl08x_prep_slave_sg;
-	pl08x->slave.device_prep_dma_cyclic = pl08x_prep_dma_cyclic;
-	pl08x->slave.device_config = pl08x_config;
-	pl08x->slave.device_pause = pl08x_pause;
-	pl08x->slave.device_resume = pl08x_resume;
-	pl08x->slave.device_terminate_all = pl08x_terminate_all;
-	pl08x->slave.src_addr_widths = PL80X_DMA_BUSWIDTHS;
-	pl08x->slave.dst_addr_widths = PL80X_DMA_BUSWIDTHS;
-	pl08x->slave.directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
-	pl08x->slave.residue_granularity = DMA_RESIDUE_GRANULARITY_SEGMENT;
+	/*
+	 * Initialize slave engine, if the block has no signals, that means
+	 * we have no slave support.
+	 */
+	if (vd->signals) {
+		pl08x->has_slave = true;
+		dma_cap_set(DMA_SLAVE, pl08x->slave.cap_mask);
+		dma_cap_set(DMA_CYCLIC, pl08x->slave.cap_mask);
+		pl08x->slave.dev = &adev->dev;
+		pl08x->slave.device_free_chan_resources =
+			pl08x_free_chan_resources;
+		pl08x->slave.device_prep_dma_interrupt =
+			pl08x_prep_dma_interrupt;
+		pl08x->slave.device_tx_status = pl08x_dma_tx_status;
+		pl08x->slave.device_issue_pending = pl08x_issue_pending;
+		pl08x->slave.device_prep_slave_sg = pl08x_prep_slave_sg;
+		pl08x->slave.device_prep_dma_cyclic = pl08x_prep_dma_cyclic;
+		pl08x->slave.device_config = pl08x_config;
+		pl08x->slave.device_pause = pl08x_pause;
+		pl08x->slave.device_resume = pl08x_resume;
+		pl08x->slave.device_terminate_all = pl08x_terminate_all;
+		pl08x->slave.src_addr_widths = PL80X_DMA_BUSWIDTHS;
+		pl08x->slave.dst_addr_widths = PL80X_DMA_BUSWIDTHS;
+		pl08x->slave.directions =
+			BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
+		pl08x->slave.residue_granularity =
+			DMA_RESIDUE_GRANULARITY_SEGMENT;
+	}
 
 	/* Get the platform data */
 	pl08x->pd = dev_get_platdata(&adev->dev);
@@ -2465,13 +2488,15 @@ static int pl08x_probe(struct amba_device *adev, const struct amba_id *id)
 	}
 
 	/* Register slave channels */
-	ret = pl08x_dma_init_virtual_channels(pl08x, &pl08x->slave,
-			pl08x->pd->num_slave_channels, true);
-	if (ret < 0) {
-		dev_warn(&pl08x->adev->dev,
-			"%s failed to enumerate slave channels - %d\n",
-				__func__, ret);
-		goto out_no_slave;
+	if (pl08x->has_slave) {
+		ret = pl08x_dma_init_virtual_channels(pl08x, &pl08x->slave,
+					pl08x->pd->num_slave_channels, true);
+		if (ret < 0) {
+			dev_warn(&pl08x->adev->dev,
+				 "%s failed to enumerate slave channels - %d\n",
+				 __func__, ret);
+			goto out_no_slave;
+		}
 	}
 
 	ret = dma_async_device_register(&pl08x->memcpy);
@@ -2482,12 +2507,14 @@ static int pl08x_probe(struct amba_device *adev, const struct amba_id *id)
 		goto out_no_memcpy_reg;
 	}
 
-	ret = dma_async_device_register(&pl08x->slave);
-	if (ret) {
-		dev_warn(&pl08x->adev->dev,
+	if (pl08x->has_slave) {
+		ret = dma_async_device_register(&pl08x->slave);
+		if (ret) {
+			dev_warn(&pl08x->adev->dev,
 			"%s failed to register slave as an async device - %d\n",
 			__func__, ret);
-		goto out_no_slave_reg;
+			goto out_no_slave_reg;
+		}
 	}
 
 	amba_set_drvdata(adev, pl08x);
@@ -2501,7 +2528,8 @@ static int pl08x_probe(struct amba_device *adev, const struct amba_id *id)
 out_no_slave_reg:
 	dma_async_device_unregister(&pl08x->memcpy);
 out_no_memcpy_reg:
-	pl08x_free_virtual_channels(&pl08x->slave);
+	if (pl08x->has_slave)
+		pl08x_free_virtual_channels(&pl08x->slave);
 out_no_slave:
 	pl08x_free_virtual_channels(&pl08x->memcpy);
 out_no_memcpy:
-- 
2.9.4
