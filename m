From: codekipper@gmail.com (codekipper at gmail.com)
Date: Wed,  5 Jul 2017 17:43:23 +0200
Subject: [PATCH 2/3] ASoC: sun4i-i2s: Get startup to call set_fmt
In-Reply-To: <20170705154324.14565-1-codekipper@gmail.com>
References: <20170705154324.14565-1-codekipper@gmail.com>
Message-ID: <20170705154324.14565-3-codekipper@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcus Cooper <codekipper@gmail.com>

The set_fmt function pointer is called during probing and this is whilst
the block is disabled. It is over writing the default register values with
the same settings so isn't noticed.
This wasn't a problem with the older SoCs but with the desire to reuse as
much functionlity as possible for the newer devices then set_fmt needs to
be called whilst the block is enabled.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
---
 sound/soc/sunxi/sun4i-i2s.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index 38ab0144f897..bb7affd53002 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -351,6 +351,15 @@ static int sun4i_i2s_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 			   SUN4I_I2S_FIFO_CTRL_RX_MODE_MASK,
 			   SUN4I_I2S_FIFO_CTRL_TX_MODE(1) |
 			   SUN4I_I2S_FIFO_CTRL_RX_MODE(1));
+
+	/* Enable the first two channels */
+	regmap_write(i2s->regmap, SUN4I_I2S_TX_CHAN_SEL_REG,
+		     SUN4I_I2S_TX_CHAN_SEL(2));
+
+	/* Map them to the two first samples coming in */
+	regmap_write(i2s->regmap, SUN4I_I2S_TX_CHAN_MAP_REG,
+		     SUN4I_I2S_TX_CHAN_MAP(0, 0) | SUN4I_I2S_TX_CHAN_MAP(1, 1));
+
 	return 0;
 }
 
@@ -457,6 +466,9 @@ static int sun4i_i2s_startup(struct snd_pcm_substream *substream,
 			     struct snd_soc_dai *dai)
 {
 	struct sun4i_i2s *i2s = snd_soc_dai_get_drvdata(dai);
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct device *dev = rtd->card->dev;
+	int ret = 0;
 
 	/* Enable the whole hardware block */
 	regmap_write(i2s->regmap, SUN4I_I2S_CTRL_REG,
@@ -467,13 +479,11 @@ static int sun4i_i2s_startup(struct snd_pcm_substream *substream,
 			   SUN4I_I2S_CTRL_SDO_EN_MASK,
 			   SUN4I_I2S_CTRL_SDO_EN(0));
 
-	/* Enable the first two channels */
-	regmap_write(i2s->regmap, SUN4I_I2S_TX_CHAN_SEL_REG,
-		     SUN4I_I2S_TX_CHAN_SEL(2));
-
-	/* Map them to the two first samples coming in */
-	regmap_write(i2s->regmap, SUN4I_I2S_TX_CHAN_MAP_REG,
-		     SUN4I_I2S_TX_CHAN_MAP(0, 0) | SUN4I_I2S_TX_CHAN_MAP(1, 1));
+	ret = snd_soc_dai_set_fmt(rtd->cpu_dai, rtd->dai_link->dai_fmt);
+	if (ret < 0) {
+		dev_err(dev, "can't set cpu_dai set fmt: %d\n", ret);
+		return ret;
+	}
 
 	return clk_prepare_enable(i2s->mod_clk);
 }
-- 
2.13.2
