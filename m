From: broonie@kernel.org (Mark Brown)
Date: Mon, 14 Aug 2017 17:43:05 +0100
Subject: Applied "ASoC: sun4i-i2s: Add TX FIFO offset to quirks" to the asoc
 tree
In-Reply-To: <20170729141753.20174-5-codekipper@gmail.com>
Message-ID: <E1dhISH-0005DC-Lv@finisterre>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: sun4i-i2s: Add TX FIFO offset to quirks

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

>From 3509476e522baaa68813609801c48aa428bae81a Mon Sep 17 00:00:00 2001
From: Marcus Cooper <codekipper@gmail.com>
Date: Sat, 12 Aug 2017 13:00:51 +0200
Subject: [PATCH] ASoC: sun4i-i2s: Add TX FIFO offset to quirks

It has been seen that the newer SoCs have a different TX FIFO
address. Add this to the quirks structure.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sunxi/sun4i-i2s.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index f6f3c409f25e..dfb794ffff92 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -94,12 +94,14 @@
  * struct sun4i_i2s_quirks - Differences between SoC variants.
  *
  * @has_reset: SoC needs reset deasserted.
+ * @reg_offset_txdata: offset of the tx fifo.
  * @sun4i_i2s_regmap: regmap config to use.
  * @mclk_offset: Value by which mclkdiv needs to be adjusted.
  * @bclk_offset: Value by which bclkdiv needs to be adjusted.
  */
 struct sun4i_i2s_quirks {
 	bool				has_reset;
+	unsigned int			reg_offset_txdata;	/* TX FIFO */
 	const struct regmap_config	*sun4i_i2s_regmap;
 	unsigned int			mclk_offset;
 	unsigned int			bclk_offset;
@@ -677,11 +679,13 @@ static int sun4i_i2s_runtime_suspend(struct device *dev)
 
 static const struct sun4i_i2s_quirks sun4i_a10_i2s_quirks = {
 	.has_reset		= false,
+	.reg_offset_txdata	= SUN4I_I2S_FIFO_TX_REG,
 	.sun4i_i2s_regmap	= &sun4i_i2s_regmap_config,
 };
 
 static const struct sun4i_i2s_quirks sun6i_a31_i2s_quirks = {
 	.has_reset		= true,
+	.reg_offset_txdata	= SUN4I_I2S_FIFO_TX_REG,
 	.sun4i_i2s_regmap	= &sun4i_i2s_regmap_config,
 };
 
@@ -750,7 +754,8 @@ static int sun4i_i2s_probe(struct platform_device *pdev)
 		}
 	}
 
-	i2s->playback_dma_data.addr = res->start + SUN4I_I2S_FIFO_TX_REG;
+	i2s->playback_dma_data.addr = res->start +
+					i2s->variant->reg_offset_txdata;
 	i2s->playback_dma_data.maxburst = 8;
 
 	i2s->capture_dma_data.addr = res->start + SUN4I_I2S_FIFO_RX_REG;
-- 
2.13.2
