From: mgreer@animalcreek.com (Mark A. Greer)
Date: Fri, 16 Nov 2012 15:39:30 -0700
Subject: [RFC] dmaengine: omap-dma: Allow DMA controller to prefetch data
In-Reply-To: <50814B83.7090203@ti.com>
References: <20121018222046.GA28541@animalcreek.com>
 <20121018225540.GB28061@n2100.arm.linux.org.uk>
 <20121018232405.GA29064@animalcreek.com>
 <20121018233335.GC28061@n2100.arm.linux.org.uk>
 <50814B83.7090203@ti.com>
Message-ID: <20121116223930.GA25182@animalcreek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 19, 2012 at 02:45:55PM +0200, P?ter Ujfalusi wrote:
> Hi,
> 
> On 10/19/2012 01:33 AM, Russell King - ARM Linux wrote:
> > I would suggest getting some feedback from the ASoC people first, before
> > trying to invent new APIs to work around this stuff.  If they can live
> > with having prefetch enabled on OMAP then there isn't an issue here.  If
> > not, we need a solution to this.
> > 
> > I do not believe that precisely stopping and starting playback across a
> > suspend/resume event is really necessary (it's desirable but the world
> > doesn't collapse if you miss a few samples.)  It could be more of an
> > issue for pause/resume though, but as I say, that's for ASoC people to
> > comment on.
> 
> There is another issue with the prefetch in audio:
> we tend to like to know the position of the DMA and also to know how much data
> we have stored in buffers, FIFOs. This information is used by userspace to do
> echo cancellation and also used by PA for example to do runtime mixing
> directly in the audio buffer. We have means to extract this information from
> McBSP for example (and from tlv320dac33 codec) but AFAIK this information can
> not be retrieved from sDMA.
> We could assume that the sDMA FIFO is kept full and report that as a 'delay'
> or do not account this information.
> 
> For now I think the cyclic mode should not set the prefetch. If I recall right
> the cyclic mode is only used by audio at the moment.
> 
> > I'm merely pointing out here that we need their feedback here before
> > deciding if there's anything further that needs to happen.
> 
> Thanks Russell, I'll take a look at the implication of the prefetch for audio.

So how about enabling prefetch for just non-cyclic?


---
>From 04b4d7b2d940822af501ea8a6bf265098d2c1810 Mon Sep 17 00:00:00 2001
From: "Mark A. Greer" <mgreer@animalcreek.com>
Date: Wed, 17 Oct 2012 18:12:21 -0700
Subject: [PATCH] dmaengine: omap-dma: Allow DMA controller to prefetch data
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Enable DMA prefetching for non-cyclic DMAs by setting the
'OMAP_DMA_DST_SYNC_PREFETCH' flag when there is a destination
synchronized DMA transfer.  Prefetching is not allowed on
source synchronized DMA transfers.  It is not allowed on
cyclic DMAs either since that can cause issues with some
users (e.g., suspending/resuming audio).

CC: rmk+kernel at arm.linux.org.uk
CC: P?ter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Mark A. Greer <mgreer@animalcreek.com>
---
 drivers/dma/omap-dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/omap-dma.c b/drivers/dma/omap-dma.c
index bb2d8e7..e660f94 100644
--- a/drivers/dma/omap-dma.c
+++ b/drivers/dma/omap-dma.c
@@ -310,7 +310,7 @@ static struct dma_async_tx_descriptor *omap_dma_prep_slave_sg(
 		dev_addr = c->cfg.dst_addr;
 		dev_width = c->cfg.dst_addr_width;
 		burst = c->cfg.dst_maxburst;
-		sync_type = OMAP_DMA_DST_SYNC;
+		sync_type = OMAP_DMA_DST_SYNC | OMAP_DMA_DST_SYNC_PREFETCH;
 	} else {
 		dev_err(chan->device->dev, "%s: bad direction?\n", __func__);
 		return NULL;
-- 
1.7.12
