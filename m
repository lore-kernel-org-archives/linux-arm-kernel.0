From: codekipper@gmail.com (codekipper at gmail.com)
Date: Wed,  5 Jul 2017 17:43:22 +0200
Subject: [PATCH 1/3] ASoC: sun4i-i2s: Add more quirks for newer SoCs
In-Reply-To: <20170705154324.14565-1-codekipper@gmail.com>
References: <20170705154324.14565-1-codekipper@gmail.com>
Message-ID: <20170705154324.14565-2-codekipper@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcus Cooper <codekipper@gmail.com>

The Allwinner H3 has some differences to its I2S block such as a
different address for the TXFIFO and various register changes.

This patch prepares the driver for these changes.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
---
 sound/soc/sunxi/sun4i-i2s.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index 3635bbc72cbc..38ab0144f897 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -544,7 +544,6 @@ static struct snd_soc_dai_driver sun4i_i2s_dai = {
 		.rates = SNDRV_PCM_RATE_8000_192000,
 		.formats = SNDRV_PCM_FMTBIT_S16_LE,
 	},
-	.ops = &sun4i_i2s_dai_ops,
 	.symmetric_rates = 1,
 };
 
@@ -655,15 +654,24 @@ static int sun4i_i2s_runtime_suspend(struct device *dev)
 }
 
 struct sun4i_i2s_quirks {
-	bool has_reset;
+	bool				has_reset;
+	unsigned int			reg_offset_txdata;	/* TX FIFO */
+	const struct regmap_config	*sun4i_i2s_regmap;
+	const struct snd_soc_dai_ops	*ops;
 };
 
 static const struct sun4i_i2s_quirks sun4i_a10_i2s_quirks = {
-	.has_reset	= false,
+	.has_reset		= false,
+	.reg_offset_txdata	= SUN4I_I2S_FIFO_TX_REG,
+	.sun4i_i2s_regmap	= &sun4i_i2s_regmap_config,
+	.ops			= &sun4i_i2s_dai_ops,
 };
 
 static const struct sun4i_i2s_quirks sun6i_a31_i2s_quirks = {
-	.has_reset	= true,
+	.has_reset		= true,
+	.reg_offset_txdata	= SUN4I_I2S_FIFO_TX_REG,
+	.sun4i_i2s_regmap	= &sun4i_i2s_regmap_config,
+	.ops			= &sun4i_i2s_dai_ops,
 };
 
 static int sun4i_i2s_probe(struct platform_device *pdev)
@@ -702,8 +710,14 @@ static int sun4i_i2s_probe(struct platform_device *pdev)
 		return PTR_ERR(i2s->bus_clk);
 	}
 
+	quirks = of_device_get_match_data(&pdev->dev);
+	if (quirks == NULL) {
+		dev_err(&pdev->dev, "Failed to determine the quirks to use\n");
+		return -ENODEV;
+	}
+
 	i2s->regmap = devm_regmap_init_mmio(&pdev->dev, regs,
-					    &sun4i_i2s_regmap_config);
+					    quirks->sun4i_i2s_regmap);
 	if (IS_ERR(i2s->regmap)) {
 		dev_err(&pdev->dev, "Regmap initialisation failed\n");
 		return PTR_ERR(i2s->regmap);
@@ -732,7 +746,7 @@ static int sun4i_i2s_probe(struct platform_device *pdev)
 		}
 	}
 
-	i2s->playback_dma_data.addr = res->start + SUN4I_I2S_FIFO_TX_REG;
+	i2s->playback_dma_data.addr = res->start + quirks->reg_offset_txdata;
 	i2s->playback_dma_data.maxburst = 8;
 
 	i2s->capture_dma_data.addr = res->start + SUN4I_I2S_FIFO_RX_REG;
@@ -745,6 +759,8 @@ static int sun4i_i2s_probe(struct platform_device *pdev)
 			goto err_pm_disable;
 	}
 
+	/* Register ops with dai */
+	sun4i_i2s_dai.ops = quirks->ops;
 	ret = devm_snd_soc_register_component(&pdev->dev,
 					      &sun4i_i2s_component,
 					      &sun4i_i2s_dai, 1);
-- 
2.13.2
