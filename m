From: broonie@kernel.org (Mark Brown)
Date: Thu, 03 Nov 2016 14:33:53 -0600
Subject: Applied "ASoC: sun4i-codec: Increase DMA max burst to 8" to the asoc
 tree
In-Reply-To: <20161103075556.29018-5-wens@csie.org>
Message-ID: <E1c2Ohu-0004P5-01@finisterre>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: sun4i-codec: Increase DMA max burst to 8

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

>From 730e2dd0cbc7a7ec10174d9d291cdd8e8082a948 Mon Sep 17 00:00:00 2001
From: Chen-Yu Tsai <wens@csie.org>
Date: Thu, 3 Nov 2016 15:55:46 +0800
Subject: [PATCH] ASoC: sun4i-codec: Increase DMA max burst to 8

According to the DMA engine API documentation, maxburst denotes the
largest possible size of a single transfer, so as not to overflow
destination FIFOs as explained in this excerpt from dmaengine.h

 * @src_maxburst: the maximum number of words (note: words, as in
 * units of the src_addr_width member, not bytes) that can be sent
 * in one burst to the device. Typically something like half the
 * FIFO depth on I/O peripherals so you don't overflow it. This
 * may or may not be applicable on memory sources.
 * @dst_maxburst: same as src_maxburst but for destination target
 * mutatis mutandis.

The TX FIFO is 64 samples deep for stereo, and the RX FIFO is 16
samples deep. So maxburst could be 32 and 8 for TX and RX respectively.

Unfortunately the sunxi DMA controller driver takes maxburst as
the requested burst size, rather than a limit, and returns an error
for unsupported values. The original value was 4, but some later
SoCs do not officially support this burst size.

This patch increases maxburst on the TX side to 8, which is supported
by all variants of the sunxi DMA controller.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sunxi/sun4i-codec.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
index 61ae502a5061..d867b96d367b 100644
--- a/sound/soc/sunxi/sun4i-codec.c
+++ b/sound/soc/sunxi/sun4i-codec.c
@@ -886,12 +886,12 @@ static int sun4i_codec_probe(struct platform_device *pdev)
 
 	/* DMA configuration for TX FIFO */
 	scodec->playback_dma_data.addr = res->start + quirks->reg_dac_txdata;
-	scodec->playback_dma_data.maxburst = 4;
+	scodec->playback_dma_data.maxburst = 8;
 	scodec->playback_dma_data.addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
 
 	/* DMA configuration for RX FIFO */
 	scodec->capture_dma_data.addr = res->start + quirks->reg_adc_rxdata;
-	scodec->capture_dma_data.maxburst = 4;
+	scodec->capture_dma_data.maxburst = 8;
 	scodec->capture_dma_data.addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
 
 	ret = snd_soc_register_codec(&pdev->dev, quirks->codec,
-- 
2.10.1
