From: broonie@kernel.org (Mark Brown)
Date: Wed, 27 Apr 2016 17:36:13 +0100
Subject: Applied "ASoC: bcm2835: Add S16_LE support via packed DMA transfers"
 to the asoc tree
In-Reply-To: <1461763613-28714-2-git-send-email-hias@horus.com>
Message-ID: <E1avSRh-0004md-40@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: bcm2835: Add S16_LE support via packed DMA transfers

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From beff053c0ef6983897e3481169292e6435ef0a2d Mon Sep 17 00:00:00 2001
From: Matthias Reichl <hias@horus.com>
Date: Wed, 27 Apr 2016 15:26:52 +0200
Subject: [PATCH] ASoC: bcm2835: Add S16_LE support via packed DMA transfers

The bcm2835-i2s driver already has support for the S16_LE format but
that format hasn't been made available because dmaengine_pcm didn't
support packed data transfers.

bcm2835-i2s needs 16-bit left+right channel data to be packed into
a 32-bit word, the FIFO register is 32-bit only and doesn't support
16-bit access.

Now that dmaengine_pcm supports packed transfers the format can
be made available by setting the SND_DMAENGINE_PCM_DAI_FLAG_PACK flag.

No further configuration is necessary:
- snd_dmaengine_dai_dma_data.addr_width is already set to
  DMA_SLAVE_BUSWIDTH_4_BYTES to force 32-bit DMA transfers
- dmaengine_pcm will pick up the S16_LE format from the DAI
  configuration and make it available since it's no longer
  masked out due to the PACK flag.
- there are no further corner cases to catch in hw_params,
  since the channel count is fixed at 2 we always have two
  16-bit stereo samples that can be transferred via 32-bit DMA

Signed-off-by: Matthias Reichl <hias@horus.com>
Tested-by: Martin Sperl <kernel@martin.sperl.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/bcm/bcm2835-i2s.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/soc/bcm/bcm2835-i2s.c b/sound/soc/bcm/bcm2835-i2s.c
index a0026e2d2f0a..6ba20498202e 100644
--- a/sound/soc/bcm/bcm2835-i2s.c
+++ b/sound/soc/bcm/bcm2835-i2s.c
@@ -690,6 +690,15 @@ static int bcm2835_i2s_probe(struct platform_device *pdev)
 	dev->dma_data[SNDRV_PCM_STREAM_PLAYBACK].maxburst = 2;
 	dev->dma_data[SNDRV_PCM_STREAM_CAPTURE].maxburst = 2;
 
+	/*
+	 * Set the PACK flag to enable S16_LE support (2 S16_LE values
+	 * packed into 32-bit transfers).
+	 */
+	dev->dma_data[SNDRV_PCM_STREAM_PLAYBACK].flags =
+		SND_DMAENGINE_PCM_DAI_FLAG_PACK;
+	dev->dma_data[SNDRV_PCM_STREAM_CAPTURE].flags =
+		SND_DMAENGINE_PCM_DAI_FLAG_PACK;
+
 	/* BCLK ratio - use default */
 	dev->bclk_ratio = 0;
 
-- 
2.8.0.rc3
