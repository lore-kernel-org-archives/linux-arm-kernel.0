From: yong.deng@magewell.com (Yong Deng)
Date: Mon, 26 Feb 2018 11:12:18 +0800
Subject: [PATCH] ASoC: sun4i-i2s: Fix offset tune for SUN8I
Message-ID: <1519614738-10959-1-git-send-email-yong.deng@magewell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SUN8I_I2S_TX_CHAN_OFFSET_MASK should be GENMASK(13, 12).
And offset tune of RX should also be updated.

Fixes: 7d2993811a1e ("ASoC: sun4i-i2s: Add support for H3")

Signed-off-by: Yong Deng <yong.deng@magewell.com>
---
 sound/soc/sunxi/sun4i-i2s.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index a4aa931ebfae..797cafffaac8 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -110,12 +110,15 @@
 
 #define SUN8I_I2S_TX_CHAN_MAP_REG	0x44
 #define SUN8I_I2S_TX_CHAN_SEL_REG	0x34
-#define SUN8I_I2S_TX_CHAN_OFFSET_MASK		GENMASK(13, 11)
+#define SUN8I_I2S_TX_CHAN_OFFSET_MASK		GENMASK(13, 12)
 #define SUN8I_I2S_TX_CHAN_OFFSET(offset)	(offset << 12)
 #define SUN8I_I2S_TX_CHAN_EN_MASK		GENMASK(11, 4)
 #define SUN8I_I2S_TX_CHAN_EN(num_chan)		(((1 << num_chan) - 1) << 4)
 
 #define SUN8I_I2S_RX_CHAN_SEL_REG	0x54
+#define SUN8I_I2S_RX_CHAN_OFFSET_MASK		GENMASK(13, 12)
+#define SUN8I_I2S_RX_CHAN_OFFSET(offset)	(offset << 12)
+
 #define SUN8I_I2S_RX_CHAN_MAP_REG	0x58
 
 /**
@@ -460,6 +463,9 @@ static int sun4i_i2s_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 		regmap_update_bits(i2s->regmap, SUN8I_I2S_TX_CHAN_SEL_REG,
 				   SUN8I_I2S_TX_CHAN_OFFSET_MASK,
 				   SUN8I_I2S_TX_CHAN_OFFSET(offset));
+		regmap_update_bits(i2s->regmap, SUN8I_I2S_RX_CHAN_SEL_REG,
+				   SUN8I_I2S_RX_CHAN_OFFSET_MASK,
+				   SUN8I_I2S_RX_CHAN_OFFSET(offset));
 	}
 
 	regmap_field_write(i2s->field_fmt_mode, val);
-- 
1.8.3.1
