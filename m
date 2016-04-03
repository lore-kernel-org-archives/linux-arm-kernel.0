From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun,  3 Apr 2016 21:01:19 +0200
Subject: [PATCH v3] dma: pl08x: allocate OF slave channel data at probe time
Message-ID: <1459710079-8525-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current OF translation of channels can never work with
any DMA client using the DMA channels directly: the only way
to get the channels initialized properly is in the
dma_async_device_register() call, where chan->dev etc is
allocated and initialized.

Allocate and initialize all possible DMA channels and
only augment a target channel with the periph_buses at
of_xlate(). Remove some const settings to make things work.

Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Joachim Eastwood <manabian@gmail.com>
Cc: Johannes Stezenbach <js@sig21.net>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v2->v3:
- Drop the patch and variable for fixed signal assignment.
- Always assign a fixed channel number when registering
  the channels.
ChangeLog v1->v2:
- Rely on the number of signals for the variant coming in
  from vendor data.

Joachim: I hope this works with LPC, I assign the signal number
now.
---
 drivers/dma/amba-pl08x.c   | 85 +++++++++++++++++++++++++++++++---------------
 include/linux/amba/pl08x.h |  2 +-
 2 files changed, 58 insertions(+), 29 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index 9b42c0588550..fafec2d27c72 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -107,16 +107,20 @@ struct pl08x_driver_data;
 /**
  * struct vendor_data - vendor-specific config parameters for PL08x derivatives
  * @channels: the number of channels available in this variant
+ * @signals: the number of request signals available from the hardware
  * @dualmaster: whether this version supports dual AHB masters or not.
  * @nomadik: whether the channels have Nomadik security extension bits
  *	that need to be checked for permission before use and some registers are
  *	missing
  * @pl080s: whether this version is a PL080S, which has separate register and
  *	LLI word for transfer size.
+ * @max_transfer_size: the maximum single element transfer size for this
+ *	PL08x variant.
  */
 struct vendor_data {
 	u8 config_offset;
 	u8 channels;
+	u8 signals;
 	bool dualmaster;
 	bool nomadik;
 	bool pl080s;
@@ -235,7 +239,7 @@ struct pl08x_dma_chan {
 	struct virt_dma_chan vc;
 	struct pl08x_phy_chan *phychan;
 	const char *name;
-	const struct pl08x_channel_data *cd;
+	struct pl08x_channel_data *cd;
 	struct dma_slave_config cfg;
 	struct pl08x_txd *at;
 	struct pl08x_driver_data *host;
@@ -1909,6 +1913,12 @@ static int pl08x_dma_init_virtual_channels(struct pl08x_driver_data *pl08x,
 
 		if (slave) {
 			chan->cd = &pl08x->pd->slave_channels[i];
+			/*
+			 * Some implementations have muxed signals, whereas some
+			 * use a mux in front of the signals and need dynamic
+			 * assignment of signals.
+			 */
+			chan->signal = i;
 			pl08x_dma_slave_init(chan);
 		} else {
 			chan->cd = &pl08x->pd->memcpy_channel;
@@ -2050,40 +2060,33 @@ static struct dma_chan *pl08x_of_xlate(struct of_phandle_args *dma_spec,
 				       struct of_dma *ofdma)
 {
 	struct pl08x_driver_data *pl08x = ofdma->of_dma_data;
-	struct pl08x_channel_data *data;
-	struct pl08x_dma_chan *chan;
 	struct dma_chan *dma_chan;
+	struct pl08x_dma_chan *plchan;
 
 	if (!pl08x)
 		return NULL;
 
-	if (dma_spec->args_count != 2)
+	if (dma_spec->args_count != 2) {
+		dev_err(&pl08x->adev->dev,
+			"DMA channel translation requires two cells\n");
 		return NULL;
+	}
 
 	dma_chan = pl08x_find_chan_id(pl08x, dma_spec->args[0]);
-	if (dma_chan)
-		return dma_get_slave_channel(dma_chan);
-
-	chan = devm_kzalloc(pl08x->slave.dev, sizeof(*chan) + sizeof(*data),
-			    GFP_KERNEL);
-	if (!chan)
+	if (!dma_chan) {
+		dev_err(&pl08x->adev->dev,
+			"DMA slave channel not found\n");
 		return NULL;
+	}
 
-	data = (void *)&chan[1];
-	data->bus_id = "(none)";
-	data->periph_buses = dma_spec->args[1];
-
-	chan->cd = data;
-	chan->host = pl08x;
-	chan->slave = true;
-	chan->name = data->bus_id;
-	chan->state = PL08X_CHAN_IDLE;
-	chan->signal = dma_spec->args[0];
-	chan->vc.desc_free = pl08x_desc_free;
-
-	vchan_init(&chan->vc, &pl08x->slave);
+	plchan = to_pl08x_chan(dma_chan);
+	dev_dbg(&pl08x->adev->dev,
+		"translated channel for signal %d\n",
+		dma_spec->args[0]);
 
-	return dma_get_slave_channel(&chan->vc.chan);
+	/* Augment channel data for applicable AHB buses */
+	plchan->cd->periph_buses = dma_spec->args[1];
+	return dma_get_slave_channel(dma_chan);
 }
 
 static int pl08x_of_probe(struct amba_device *adev,
@@ -2091,9 +2094,11 @@ static int pl08x_of_probe(struct amba_device *adev,
 			  struct device_node *np)
 {
 	struct pl08x_platform_data *pd;
+	struct pl08x_channel_data *chanp = NULL;
 	u32 cctl_memcpy = 0;
 	u32 val;
 	int ret;
+	int i;
 
 	pd = devm_kzalloc(&adev->dev, sizeof(*pd), GFP_KERNEL);
 	if (!pd)
@@ -2195,6 +2200,26 @@ static int pl08x_of_probe(struct amba_device *adev,
 	/* Use the buses that can access memory, obviously */
 	pd->memcpy_channel.periph_buses = pd->mem_buses;
 
+	/*
+	 * Allocate channel data for all possible slave channels (one
+	 * for each possible signal), channels will then be allocated
+	 * for a device and have it's AHB interfaces set up at
+	 * translation time.
+	 */
+	chanp = devm_kzalloc(&adev->dev,
+			pl08x->vd->signals *
+			sizeof(struct pl08x_channel_data),
+			GFP_KERNEL);
+	if (!chanp)
+		return -ENOMEM;
+	pd->slave_channels = chanp;
+	for (i = 0; i < pl08x->vd->signals; i++) {
+		/* chanp->periph_buses will be assigned at translation */
+		chanp->bus_id = kasprintf(GFP_KERNEL, "slave%d", i);
+		chanp++;
+	}
+	pd->num_slave_channels = pl08x->vd->signals;
+
 	pl08x->pd = pd;
 
 	return of_dma_controller_register(adev->dev.of_node, pl08x_of_xlate,
@@ -2234,6 +2259,10 @@ static int pl08x_probe(struct amba_device *adev, const struct amba_id *id)
 		goto out_no_pl08x;
 	}
 
+	/* Assign useful pointers to the driver state */
+	pl08x->adev = adev;
+	pl08x->vd = vd;
+
 	/* Initialize memcpy engine */
 	dma_cap_set(DMA_MEMCPY, pl08x->memcpy.cap_mask);
 	pl08x->memcpy.dev = &adev->dev;
@@ -2284,10 +2313,6 @@ static int pl08x_probe(struct amba_device *adev, const struct amba_id *id)
 		}
 	}
 
-	/* Assign useful pointers to the driver state */
-	pl08x->adev = adev;
-	pl08x->vd = vd;
-
 	/* By default, AHB1 only.  If dualmaster, from platform */
 	pl08x->lli_buses = PL08X_AHB1;
 	pl08x->mem_buses = PL08X_AHB1;
@@ -2438,6 +2463,7 @@ out_no_pl08x:
 static struct vendor_data vendor_pl080 = {
 	.config_offset = PL080_CH_CONFIG,
 	.channels = 8,
+	.signals = 16,
 	.dualmaster = true,
 	.max_transfer_size = PL080_CONTROL_TRANSFER_SIZE_MASK,
 };
@@ -2445,6 +2471,7 @@ static struct vendor_data vendor_pl080 = {
 static struct vendor_data vendor_nomadik = {
 	.config_offset = PL080_CH_CONFIG,
 	.channels = 8,
+	.signals = 32,
 	.dualmaster = true,
 	.nomadik = true,
 	.max_transfer_size = PL080_CONTROL_TRANSFER_SIZE_MASK,
@@ -2453,6 +2480,7 @@ static struct vendor_data vendor_nomadik = {
 static struct vendor_data vendor_pl080s = {
 	.config_offset = PL080S_CH_CONFIG,
 	.channels = 8,
+	.signals = 32,
 	.pl080s = true,
 	.max_transfer_size = PL080S_CONTROL_TRANSFER_SIZE_MASK,
 };
@@ -2460,6 +2488,7 @@ static struct vendor_data vendor_pl080s = {
 static struct vendor_data vendor_pl081 = {
 	.config_offset = PL080_CH_CONFIG,
 	.channels = 2,
+	.signals = 16,
 	.dualmaster = false,
 	.max_transfer_size = PL080_CONTROL_TRANSFER_SIZE_MASK,
 };
diff --git a/include/linux/amba/pl08x.h b/include/linux/amba/pl08x.h
index 10fe2a211c2e..27e9ec8778eb 100644
--- a/include/linux/amba/pl08x.h
+++ b/include/linux/amba/pl08x.h
@@ -86,7 +86,7 @@ struct pl08x_channel_data {
  * @mem_buses: buses which memory can be accessed from: PL08X_AHB1 | PL08X_AHB2
  */
 struct pl08x_platform_data {
-	const struct pl08x_channel_data *slave_channels;
+	struct pl08x_channel_data *slave_channels;
 	unsigned int num_slave_channels;
 	struct pl08x_channel_data memcpy_channel;
 	int (*get_xfer_signal)(const struct pl08x_channel_data *);
-- 
2.4.11
