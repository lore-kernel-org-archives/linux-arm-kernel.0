From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 25 Jun 2014 13:00:33 +0100
Subject: [PATCH] Update imx-sdma cyclic handling to report residue
Message-ID: <20140625120032.GI32514@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I received a report this morning from one of the Novena developers that
the behaviour of the iMX6 ASoC codec driver (using imx-pcm-dma.c) was
sub-optimal under high system load.

While there are issues relating to system load remaining, upon reviewing
the ASoC imx-pcm-dma.c driver, it was noticed that it not using the
residue support, because SDMA doesn't support it.  This has the effect
that SDMA has to make multiple calls into the ASoC and ALSA code, one
for each period.

Since ALSA's snd_pcm_elapsed() does not need to be called multiple times
and it is entirely sufficient to call it once to update ALSA with the
current buffer position via the pointer method, we can do better here.
We can also avoid stopping the DMA entirely, just like real cyclic DMA
implementations behave.  While this means that we replay some old samples,
this is a nicer behaviour than having audio stop and restart.

The changes to achieve this are relatively minor - imx-sdma.c can track
where the DMA is to the nearest descriptor boundary - it does this
already when deciding how many callbacks to issue.  In doing this,
buf_tail always points at the descriptor which will complete next.

The residue is defined by the bytes remaining to the end of the buffer,
when the buffer is viewed as a single block of memory [start...end].
So, when we start out, there's a full buffer worth of residue, and this
counts down as we approach the end of the buffer, eventually becoming
zero at the end, before returning to the full buffer worth when we
wrap back to the start.

Moving the walking of the descriptors into the interrupt handler means
that we can update the BD_DONE flag at interrupt time, thus avoiding
a delayed tasklet stopping the cyclic DMA.

This means that the residue can be calculated from (total descriptors -
buf_tail) * descriptor size.  This is what the change below does.  We
update imx-pcm-dma.c to remove the NO_RESIDUE flag since we now provide
the residue.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
IMHO, ASoC should encourage all DMA engine drivers to do this just the
same way that ASoC requires cyclic DMA support - if the DMA engine
driver knows how many times it needs to issue the callback (which is
strictly incorrect behaviour to the DMA engine documentation) then it
has enough information to be able to provide the residue information
and avoid that loop.

Note that these two files can't be split into separate patches - both
changes are mutually dependent.

 drivers/dma/imx-sdma.c      | 22 ++++++++++++++++++----
 sound/soc/fsl/imx-pcm-dma.c |  1 -
 2 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 128714622bf5..14867e3ac8ff 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -255,6 +255,7 @@ struct sdma_channel {
 	enum dma_slave_buswidth		word_size;
 	unsigned int			buf_tail;
 	unsigned int			num_bd;
+	unsigned int			period_len;
 	struct sdma_buffer_descriptor	*bd;
 	dma_addr_t			bd_phys;
 	unsigned int			pc_from_device, pc_to_device;
@@ -593,6 +594,12 @@ static void sdma_event_disable(struct sdma_channel *sdmac, unsigned int event)
 
 static void sdma_handle_channel_loop(struct sdma_channel *sdmac)
 {
+	if (sdmac->desc.callback)
+		sdmac->desc.callback(sdmac->desc.callback_param);
+}
+
+static void sdma_update_channel_loop(struct sdma_channel *sdmac)
+{
 	struct sdma_buffer_descriptor *bd;
 
 	/*
@@ -611,9 +618,6 @@ static void sdma_handle_channel_loop(struct sdma_channel *sdmac)
 		bd->mode.status |= BD_DONE;
 		sdmac->buf_tail++;
 		sdmac->buf_tail %= sdmac->num_bd;
-
-		if (sdmac->desc.callback)
-			sdmac->desc.callback(sdmac->desc.callback_param);
 	}
 }
 
@@ -669,6 +673,9 @@ static irqreturn_t sdma_int_handler(int irq, void *dev_id)
 		int channel = fls(stat) - 1;
 		struct sdma_channel *sdmac = &sdma->channel[channel];
 
+		if (sdmac->flags & IMX_DMA_SG_LOOP)
+			sdma_update_channel_loop(sdmac);
+
 		tasklet_schedule(&sdmac->tasklet);
 
 		__clear_bit(channel, &stat);
@@ -1129,6 +1136,7 @@ static struct dma_async_tx_descriptor *sdma_prep_dma_cyclic(
 	sdmac->status = DMA_IN_PROGRESS;
 
 	sdmac->buf_tail = 0;
+	sdmac->period_len = period_len;
 
 	sdmac->flags |= IMX_DMA_SG_LOOP;
 	sdmac->direction = direction;
@@ -1225,9 +1233,15 @@ static enum dma_status sdma_tx_status(struct dma_chan *chan,
 				      struct dma_tx_state *txstate)
 {
 	struct sdma_channel *sdmac = to_sdma_chan(chan);
+	u32 residue;
+
+	if (sdmac->flags & IMX_DMA_SG_LOOP)
+		residue = (sdmac->num_bd - sdmac->buf_tail) * sdmac->period_len;
+	else
+		residue = sdmac->chn_count - sdmac->chn_real_count;
 
 	dma_set_tx_state(txstate, chan->completed_cookie, chan->cookie,
-			sdmac->chn_count - sdmac->chn_real_count);
+			 residue);
 
 	return sdmac->status;
 }
diff --git a/sound/soc/fsl/imx-pcm-dma.c b/sound/soc/fsl/imx-pcm-dma.c
index a545cbf8d16e..1f4ad080b907 100644
--- a/sound/soc/fsl/imx-pcm-dma.c
+++ b/sound/soc/fsl/imx-pcm-dma.c
@@ -59,7 +59,6 @@ int imx_pcm_dma_init(struct platform_device *pdev)
 {
 	return devm_snd_dmaengine_pcm_register(&pdev->dev,
 		&imx_dmaengine_pcm_config,
-		SND_DMAENGINE_PCM_FLAG_NO_RESIDUE |
 		SND_DMAENGINE_PCM_FLAG_COMPAT);
 }
 EXPORT_SYMBOL_GPL(imx_pcm_dma_init);


-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
