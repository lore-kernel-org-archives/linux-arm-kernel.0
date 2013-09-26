From: tiwai@suse.de (Takashi Iwai)
Date: Thu, 26 Sep 2013 10:25:13 +0200
Subject: [PATCH 28/51] DMA-API: sound: fix dma mask handling in a lot	of
 drivers
In-Reply-To: <20130926075425.GX25647@n2100.arm.linux.org.uk>
References: <20130919212235.GD12758@n2100.arm.linux.org.uk>
 <E1VMm9m-0007ij-ER@rmk-PC.arm.linux.org.uk>
 <s5h1u4cf2bo.wl%tiwai@suse.de>
 <20130926075425.GX25647@n2100.arm.linux.org.uk>
Message-ID: <s5hob7gdm6u.wl%tiwai@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

At Thu, 26 Sep 2013 08:54:25 +0100,
Russell King - ARM Linux wrote:
> 
> On Thu, Sep 26, 2013 at 09:51:23AM +0200, Takashi Iwai wrote:
> > Hi,
> > 
> > sorry for the lat response, as I've been traveling in the last weeks.
> > 
> > At Thu, 19 Sep 2013 22:53:02 +0100,
> > Russell King wrote:
> > > 
> > > This code sequence is unsafe in modules:
> > > 
> > > static u64 mask = DMA_BIT_MASK(something);
> > > ...
> > > 	if (!dev->dma_mask)
> > > 		dev->dma_mask = &mask;
> > > 
> > > as if a module is reloaded, the mask will be pointing at the original
> > > module's mask address, and this can lead to oopses.  Moreover, they
> > > all follow this with:
> > > 
> > > 	if (!dev->coherent_dma_mask)
> > > 		dev->coherent_dma_mask = mask;
> > > 
> > > where 'mask' is the same value as the statically defined mask, and this
> > > bypasses the architecture's check on whether the DMA mask is possible.
> > > 
> > > Fix these issues by using the new dma_coerce_coherent_and_mask()
> > > function.
> > > 
> > > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> > 
> > Applied with Mark's ack now.
> 
> Which is a very stupid thing to do because you won't have
> dma_coerce_coherent_and_mask() in your tree, so all these drivers
> will fail to build for you.

Ah, silly me, I missed the very first thing.  Reverted it now...

FWIW, below is the missing piece.  Please apply it in your side if
necessary.


Takashi

---
 sound/soc/fsl/imx-pcm-fiq.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/sound/soc/fsl/imx-pcm-fiq.c b/sound/soc/fsl/imx-pcm-fiq.c
index 34043c5..fd5f2fb 100644
--- a/sound/soc/fsl/imx-pcm-fiq.c
+++ b/sound/soc/fsl/imx-pcm-fiq.c
@@ -272,18 +272,16 @@ static int imx_pcm_preallocate_dma_buffer(struct snd_pcm *pcm, int stream)
 	return 0;
 }
 
-static u64 imx_pcm_dmamask = DMA_BIT_MASK(32);
-
 static int imx_pcm_new(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_card *card = rtd->card->snd_card;
 	struct snd_pcm *pcm = rtd->pcm;
-	int ret = 0;
+	int ret;
+
+	ret = dma_coerce_mask_and_coherent(card->dev, DMA_BIT_MASK(32));
+	if (ret)
+		return ret;
 
-	if (!card->dev->dma_mask)
-		card->dev->dma_mask = &imx_pcm_dmamask;
-	if (!card->dev->coherent_dma_mask)
-		card->dev->coherent_dma_mask = DMA_BIT_MASK(32);
 	if (pcm->streams[SNDRV_PCM_STREAM_PLAYBACK].substream) {
 		ret = imx_pcm_preallocate_dma_buffer(pcm,
 			SNDRV_PCM_STREAM_PLAYBACK);
-- 
1.8.4
