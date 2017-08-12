From: codekipper@gmail.com (codekipper at gmail.com)
Date: Sat, 12 Aug 2017 13:00:51 +0200
Subject: [PATCH v3 03/11] ASoC: sun4i-i2s: Add TX FIFO offset to quirks
In-Reply-To: <20170812110059.5115-1-codekipper@gmail.com>
References: <20170812110059.5115-1-codekipper@gmail.com>
Message-ID: <20170812110059.5115-4-codekipper@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcus Cooper <codekipper@gmail.com>

It has been seen that the newer SoCs have a different TX FIFO
address. Add this to the quirks structure.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
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
2.14.1
