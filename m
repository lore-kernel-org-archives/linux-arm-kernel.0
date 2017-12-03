From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Sun,  3 Dec 2017 12:41:49 -0800
Subject: [PATCH 1/9] ASoC: sun4i-i2s: Add quirk to handle fixed WSS
In-Reply-To: <20171203204157.20829-1-anarsoul@gmail.com>
References: <20171203204157.20829-1-anarsoul@gmail.com>
Message-ID: <20171203204157.20829-2-anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I2S for audio codec on sun50i-A64 always uses fixed word select size value,
no matter what is sample width. Add quirk to support that.

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 sound/soc/sunxi/sun4i-i2s.c | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index 04f92583a969..54c16eb64713 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -132,6 +132,8 @@
  * @mclk_offset: Value by which mclkdiv needs to be adjusted.
  * @bclk_offset: Value by which bclkdiv needs to be adjusted.
  * @fmt_offset: Value by which wss and sr needs to be adjusted.
+ * @fixed_wss: Hardcoded 'word select size' value needs to be used
+ * @wss_value: Value to be used as WSS if fixed_wss is set
  * @field_clkdiv_mclk_en: regmap field to enable mclk output.
  * @field_fmt_wss: regmap field to set word select size.
  * @field_fmt_sr: regmap field to set sample resolution.
@@ -150,11 +152,13 @@ struct sun4i_i2s_quirks {
 	bool				has_chcfg;
 	bool				has_chsel_tx_chen;
 	bool				has_chsel_offset;
+	bool				fixed_wss;
 	unsigned int			reg_offset_txdata;	/* TX FIFO */
 	const struct regmap_config	*sun4i_i2s_regmap;
 	unsigned int			mclk_offset;
 	unsigned int			bclk_offset;
 	unsigned int			fmt_offset;
+	unsigned int			wss_value;
 
 	/* Register fields for i2s */
 	struct reg_field		field_clkdiv_mclk_en;
@@ -345,7 +349,7 @@ static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
 			       struct snd_soc_dai *dai)
 {
 	struct sun4i_i2s *i2s = snd_soc_dai_get_drvdata(dai);
-	int sr, wss, channels;
+	int sr, wss, channels, pwidth;
 	u32 width;
 
 	channels = params_channels(params);
@@ -386,7 +390,8 @@ static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
 	}
 	i2s->playback_dma_data.addr_width = width;
 
-	switch (params_width(params)) {
+	pwidth = params_width(params);
+	switch (pwidth) {
 	case 16:
 		sr = 0;
 		wss = 0;
@@ -396,13 +401,30 @@ static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
+	if (i2s->variant->fixed_wss) {
+		wss = i2s->variant->wss_value;
+		switch (wss) {
+		case 0:
+			pwidth = 16;
+			break;
+		case 1:
+			pwidth = 20;
+			break;
+		case 2:
+			pwidth = 24;
+			break;
+		case 3:
+			pwidth = 32;
+			break;
+		}
+	}
+
 	regmap_field_write(i2s->field_fmt_wss,
 			   wss + i2s->variant->fmt_offset);
 	regmap_field_write(i2s->field_fmt_sr,
 			   sr + i2s->variant->fmt_offset);
 
-	return sun4i_i2s_set_clk_rate(i2s, params_rate(params),
-				      params_width(params));
+	return sun4i_i2s_set_clk_rate(i2s, params_rate(params), pwidth);
 }
 
 static int sun4i_i2s_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
-- 
2.15.0
