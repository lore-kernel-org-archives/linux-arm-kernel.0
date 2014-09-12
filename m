From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 12 Sep 2014 09:36:47 +0200
Subject: [PATCH 1/4] dma: pl08x: support fixed signal assignment
Message-ID: <1410507407-32408-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some implementations such as the Nomadik do not place a mux
in front of the DMA single/burst request signals into the
PL08x DMA controller, instead they lock a certain signal to
a certain device. This makes things simpler and the platform
does not need to implement a muxing function.

Implement this scheme and flag that the Nomadik uses this
method.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/dma/amba-pl08x.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index e34024b000a4..1e523a094cc5 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -109,6 +109,11 @@ struct pl08x_driver_data;
  *	missing
  * @pl080s: whether this version is a PL080S, which has separate register and
  *	LLI word for transfer size.
+ * @fixed_signals: if the channel signal allocation on the PL08x is fixed,
+ *	i.e. each device burst/single control signals are connected directly
+ *	to the DMAC signal lines without any mux.
+ * @max_transfer_size: the maximum single element transfer size for this
+ *	PL08x variant.
  */
 struct vendor_data {
 	u8 config_offset;
@@ -116,6 +121,7 @@ struct vendor_data {
 	bool dualmaster;
 	bool nomadik;
 	bool pl080s;
+	bool fixed_signals;
 	u32 max_transfer_size;
 };
 
@@ -315,6 +321,15 @@ static int pl08x_request_mux(struct pl08x_dma_chan *plchan)
 	const struct pl08x_platform_data *pd = plchan->host->pd;
 	int ret;
 
+	/*
+	 * For engines with fixed signal assignment for slave transfers,
+	 * this signal is assigned during probe.
+	 */
+	if (plchan->host->vd->fixed_signals) {
+		BUG_ON(plchan->signal < 0);
+		return 0;
+	}
+
 	if (plchan->mux_use++ == 0 && pd->get_xfer_signal) {
 		ret = pd->get_xfer_signal(plchan->cd);
 		if (ret < 0) {
@@ -331,6 +346,9 @@ static void pl08x_release_mux(struct pl08x_dma_chan *plchan)
 {
 	const struct pl08x_platform_data *pd = plchan->host->pd;
 
+	if (plchan->host->vd->fixed_signals)
+		return;
+
 	if (plchan->signal >= 0) {
 		WARN_ON(plchan->mux_use == 0);
 
@@ -1892,6 +1910,18 @@ static int pl08x_dma_init_virtual_channels(struct pl08x_driver_data *pl08x,
 
 		if (slave) {
 			chan->cd = &pl08x->pd->slave_channels[i];
+			/*
+			 * Some implementations have muxed signals, whereas some
+			 * use a mux in front of the signals and need dynamic
+			 * assignment of signals.
+			 */
+			if (pl08x->vd->fixed_signals) {
+				chan->signal = i;
+				chan->name = chan->cd->bus_id;
+				dev_dbg(&pl08x->adev->dev,
+					"assign fixed signal %u to channel %s",
+					chan->signal, chan->name);
+			}
 			pl08x_dma_slave_init(chan);
 		} else {
 			chan->cd = &pl08x->pd->memcpy_channel;
@@ -2236,6 +2266,7 @@ static struct vendor_data vendor_nomadik = {
 	.channels = 8,
 	.dualmaster = true,
 	.nomadik = true,
+	.fixed_signals = true,
 	.max_transfer_size = PL080_CONTROL_TRANSFER_SIZE_MASK,
 };
 
-- 
1.9.3
