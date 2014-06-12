From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 12 Jun 2014 15:16:27 +0200
Subject: [PATCH 1/2] [RFC] ASoC: samsung: move s3c24xx over to dmaengine
In-Reply-To: <4306380.m7SZhHfhaK@wuerfel>
References: <6123933.aGtaUr149J@wuerfel> <20140605133606.GX2520@sirena.org.uk>
 <4306380.m7SZhHfhaK@wuerfel>
Message-ID: <5498575.LeGAfDJTRA@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 05 June 2014 16:04:03 Arnd Bergmann wrote:
> On Thursday 05 June 2014 14:36:06 Mark Brown wrote:
> > On Thu, Jun 05, 2014 at 03:20:50PM +0200, Arnd Bergmann wrote:
> > > The s3c24xx sound support keeps giving randconfig build errors, this
> > > is a new attempt to solve it by moving the driver over to use dmaengine
> > > exclusively.
> > 
> > We already have a patch pending for this, it's just waiting until after
> > the merge window to avoid bisection breakage since it depends on
> > dmaengine changes.
> 
> Ok, very good.

Actually, I think it would still be good to do something about the
samsung/ac97.c file, which is the only reason we are keeping the
SAMSUNG_DMADEV code around that is part of the dependency chain
Russell posted, and it's definitely broken on anything but s3c24xx.

If we do something like the patch below, we can just disable
SAMSUNG_DMADEV already, which simplifies the dependency chains
a lot. We can then remove that code entirely in 3.17.

Note that for !CONFIG_S3C24XX_DMA, the code is currently broken,
as samsung_dma_get_ops()->started is a NULL pointer for dmadev.

	Arnd

diff --git a/sound/soc/samsung/ac97.c b/sound/soc/samsung/ac97.c
index 68d9303..1db1028 100644
--- a/sound/soc/samsung/ac97.c
+++ b/sound/soc/samsung/ac97.c
@@ -225,9 +225,11 @@ static int s3c_ac97_trigger(struct snd_pcm_substream *substream, int cmd,
 				struct snd_soc_dai *dai)
 {
 	u32 ac_glbctrl;
+#ifdef CONFIG_S3C24XX_DMA
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct s3c_dma_params *dma_data =
 		snd_soc_dai_get_dma_data(rtd->cpu_dai, substream);
+#endif
 
 	ac_glbctrl = readl(s3c_ac97.regs + S3C_AC97_GLBCTRL);
 	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
@@ -253,10 +255,9 @@ static int s3c_ac97_trigger(struct snd_pcm_substream *substream, int cmd,
 
 	writel(ac_glbctrl, s3c_ac97.regs + S3C_AC97_GLBCTRL);
 
-	if (!dma_data->ops)
-		dma_data->ops = samsung_dma_get_ops();
-
-	dma_data->ops->started(dma_data->channel);
+#ifdef CONFIG_S3C24XX_DMA
+	s3c2410_dma_ctrl(dma_data->channel, S3C2410_DMAOP_STARTED);
+#endif
 
 	return 0;
 }
@@ -265,9 +266,11 @@ static int s3c_ac97_mic_trigger(struct snd_pcm_substream *substream,
 				    int cmd, struct snd_soc_dai *dai)
 {
 	u32 ac_glbctrl;
+#ifdef CONFIG_S3C24XX_DMA
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct s3c_dma_params *dma_data =
 		snd_soc_dai_get_dma_data(rtd->cpu_dai, substream);
+#endif
 
 	ac_glbctrl = readl(s3c_ac97.regs + S3C_AC97_GLBCTRL);
 	ac_glbctrl &= ~S3C_AC97_GLBCTRL_MICINTM_MASK;
@@ -287,10 +290,9 @@ static int s3c_ac97_mic_trigger(struct snd_pcm_substream *substream,
 
 	writel(ac_glbctrl, s3c_ac97.regs + S3C_AC97_GLBCTRL);
 
-	if (!dma_data->ops)
-		dma_data->ops = samsung_dma_get_ops();
-
-	dma_data->ops->started(dma_data->channel);
+#ifdef CONFIG_S3C24XX_DMA
+	s3c2410_dma_ctrl(dma_data->channel, S3C2410_DMAOP_STARTED);
+#endif
 
 	return 0;
 }
