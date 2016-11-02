From: broonie@kernel.org (Mark Brown)
Date: Wed, 02 Nov 2016 10:50:48 -0600
Subject: Applied "ASoC: sun4i-codec: Enable bus clock after getting GPIO" to
 the asoc tree
In-Reply-To: <20161101063155.15826-1-wens@csie.org>
Message-ID: <E1c1ykS-0006Gt-1N@finisterre>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: sun4i-codec: Enable bus clock after getting GPIO

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

>From 3716a891d65cc04217da1af5f2bccb7eaf6092c2 Mon Sep 17 00:00:00 2001
From: Chen-Yu Tsai <wens@csie.org>
Date: Tue, 1 Nov 2016 14:31:55 +0800
Subject: [PATCH] ASoC: sun4i-codec: Enable bus clock after getting GPIO

In the current probe function the GPIO is acquired after the codec's
bus clock is enabled. However if it fails to acquire the GPIO due to
a deferred probe, it does not disable the bus clock before bailing out.
This would result in the clock being enabled multiple times.

Move the code that enables the bus clock after the part that gets the
GPIO, maintaining a separation between resource acquisition and device
enablement in the probe function.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sunxi/sun4i-codec.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
index a60707761abf..56ed9472e89f 100644
--- a/sound/soc/sunxi/sun4i-codec.c
+++ b/sound/soc/sunxi/sun4i-codec.c
@@ -829,12 +829,6 @@ static int sun4i_codec_probe(struct platform_device *pdev)
 		return PTR_ERR(scodec->clk_module);
 	}
 
-	/* Enable the bus clock */
-	if (clk_prepare_enable(scodec->clk_apb)) {
-		dev_err(&pdev->dev, "Failed to enable the APB clock\n");
-		return -EINVAL;
-	}
-
 	scodec->gpio_pa = devm_gpiod_get_optional(&pdev->dev, "allwinner,pa",
 						  GPIOD_OUT_LOW);
 	if (IS_ERR(scodec->gpio_pa)) {
@@ -844,6 +838,12 @@ static int sun4i_codec_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	/* Enable the bus clock */
+	if (clk_prepare_enable(scodec->clk_apb)) {
+		dev_err(&pdev->dev, "Failed to enable the APB clock\n");
+		return -EINVAL;
+	}
+
 	/* DMA configuration for TX FIFO */
 	scodec->playback_dma_data.addr = res->start + SUN4I_CODEC_DAC_TXDATA;
 	scodec->playback_dma_data.maxburst = 4;
-- 
2.10.1
