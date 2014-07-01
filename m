From: jingchang.lu@freescale.com (Jingchang Lu)
Date: Tue, 1 Jul 2014 16:41:03 +0800
Subject: [PATCH] dmaengine: fsl-edma: fix dmamux index calculating error
Message-ID: <1404204063-20961-1-git-send-email-jingchang.lu@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jingchang Lu <jingchang.lu@freescale.com>
---
 drivers/dma/fsl-edma.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/fsl-edma.c b/drivers/dma/fsl-edma.c
index b396a7f..24ab3d3 100644
--- a/drivers/dma/fsl-edma.c
+++ b/drivers/dma/fsl-edma.c
@@ -248,11 +248,12 @@ static void fsl_edma_chan_mux(struct fsl_edma_chan *fsl_chan,
 			unsigned int slot, bool enable)
 {
 	u32 ch = fsl_chan->vchan.chan.chan_id;
-	void __iomem *muxaddr = fsl_chan->edma->muxbase[ch / DMAMUX_NR];
+	void __iomem *muxaddr;
 	unsigned chans_per_mux, ch_off;
 
 	chans_per_mux = fsl_chan->edma->n_chans / DMAMUX_NR;
 	ch_off = fsl_chan->vchan.chan.chan_id % chans_per_mux;
+	muxaddr = fsl_chan->edma->muxbase[ch / chans_per_mux];
 
 	if (enable)
 		edma_writeb(fsl_chan->edma,
@@ -724,6 +725,7 @@ static struct dma_chan *fsl_edma_xlate(struct of_phandle_args *dma_spec,
 {
 	struct fsl_edma_engine *fsl_edma = ofdma->of_dma_data;
 	struct dma_chan *chan, *_chan;
+	unsigned long chans_per_mux = fsl_edma->n_chans / DMAMUX_NR;
 
 	if (dma_spec->args_count != 2)
 		return NULL;
@@ -732,7 +734,7 @@ static struct dma_chan *fsl_edma_xlate(struct of_phandle_args *dma_spec,
 	list_for_each_entry_safe(chan, _chan, &fsl_edma->dma_dev.channels, device_node) {
 		if (chan->client_count)
 			continue;
-		if ((chan->chan_id / DMAMUX_NR) == dma_spec->args[0]) {
+		if ((chan->chan_id / chans_per_mux) == dma_spec->args[0]) {
 			chan = dma_get_slave_channel(chan);
 			if (chan) {
 				chan->device->privatecnt++;
-- 
1.8.0
