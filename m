From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Sun, 21 May 2017 02:42:38 +0900
Subject: [PATCH] ASoC: remove NULL pointer check for clk_disable_unprepare
Message-ID: <1495302158-30951-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After long term efforts of fixing non-common clock implementations,
clk_disable() is a no-op for a NULL pointer input, and this is now
tree-wide consistent.

All clock consumers can safely call clk_disable(_unprepare) without
NULL pointer check.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 sound/soc/codecs/adau17x1.c                | 3 +--
 sound/soc/codecs/da7213.c                  | 3 +--
 sound/soc/codecs/da7218.c                  | 3 +--
 sound/soc/codecs/da7219-aad.c              | 5 ++---
 sound/soc/codecs/da7219.c                  | 3 +--
 sound/soc/codecs/es8328.c                  | 3 +--
 sound/soc/codecs/wm8731.c                  | 3 +--
 sound/soc/davinci/davinci-evm.c            | 3 +--
 sound/soc/fsl/imx-audmux.c                 | 6 ++----
 sound/soc/intel/boards/bytcr_rt5640.c      | 2 +-
 sound/soc/intel/boards/cht_bsw_rt5645.c    | 3 +--
 sound/soc/mediatek/mt8173/mt8173-afe-pcm.c | 6 ++----
 sound/soc/samsung/i2s.c                    | 3 +--
 13 files changed, 16 insertions(+), 30 deletions(-)

diff --git a/sound/soc/codecs/adau17x1.c b/sound/soc/codecs/adau17x1.c
index 2c1bd27..f50739b 100644
--- a/sound/soc/codecs/adau17x1.c
+++ b/sound/soc/codecs/adau17x1.c
@@ -977,8 +977,7 @@ void adau17x1_remove(struct device *dev)
 	struct adau *adau = dev_get_drvdata(dev);
 
 	snd_soc_unregister_codec(dev);
-	if (adau->mclk)
-		clk_disable_unprepare(adau->mclk);
+	clk_disable_unprepare(adau->mclk);
 }
 EXPORT_SYMBOL_GPL(adau17x1_remove);
 
diff --git a/sound/soc/codecs/da7213.c b/sound/soc/codecs/da7213.c
index 6dd7578..130e16a 100644
--- a/sound/soc/codecs/da7213.c
+++ b/sound/soc/codecs/da7213.c
@@ -1516,8 +1516,7 @@ static int da7213_set_bias_level(struct snd_soc_codec *codec,
 					    DA7213_VMID_EN | DA7213_BIAS_EN);
 		} else {
 			/* Remove MCLK */
-			if (da7213->mclk)
-				clk_disable_unprepare(da7213->mclk);
+			clk_disable_unprepare(da7213->mclk);
 		}
 		break;
 	case SND_SOC_BIAS_OFF:
diff --git a/sound/soc/codecs/da7218.c b/sound/soc/codecs/da7218.c
index d256ebf..eeb0bb6 100644
--- a/sound/soc/codecs/da7218.c
+++ b/sound/soc/codecs/da7218.c
@@ -2611,8 +2611,7 @@ static int da7218_set_bias_level(struct snd_soc_codec *codec,
 					    DA7218_LDO_EN_MASK);
 		} else {
 			/* Remove MCLK */
-			if (da7218->mclk)
-				clk_disable_unprepare(da7218->mclk);
+			clk_disable_unprepare(da7218->mclk);
 		}
 		break;
 	case SND_SOC_BIAS_OFF:
diff --git a/sound/soc/codecs/da7219-aad.c b/sound/soc/codecs/da7219-aad.c
index 6274d79..31518df 100644
--- a/sound/soc/codecs/da7219-aad.c
+++ b/sound/soc/codecs/da7219-aad.c
@@ -302,9 +302,8 @@ static void da7219_aad_hptest_work(struct work_struct *work)
 	snd_soc_update_bits(codec, DA7219_HP_R_CTRL, DA7219_HP_R_AMP_OE_MASK,
 			    DA7219_HP_R_AMP_OE_MASK);
 
-	/* Remove MCLK, if previously enabled */
-	if (da7219->mclk)
-		clk_disable_unprepare(da7219->mclk);
+	/* Remove MCLK */
+	clk_disable_unprepare(da7219->mclk);
 
 	mutex_unlock(&da7219->lock);
 	snd_soc_dapm_mutex_unlock(dapm);
diff --git a/sound/soc/codecs/da7219.c b/sound/soc/codecs/da7219.c
index 9960162..307039e 100644
--- a/sound/soc/codecs/da7219.c
+++ b/sound/soc/codecs/da7219.c
@@ -1630,8 +1630,7 @@ static int da7219_set_bias_level(struct snd_soc_codec *codec,
 
 		if (snd_soc_codec_get_bias_level(codec) == SND_SOC_BIAS_PREPARE) {
 			/* Remove MCLK */
-			if (da7219->mclk)
-				clk_disable_unprepare(da7219->mclk);
+			clk_disable_unprepare(da7219->mclk);
 		}
 		break;
 	case SND_SOC_BIAS_OFF:
diff --git a/sound/soc/codecs/es8328.c b/sound/soc/codecs/es8328.c
index ed7cc42..848e0b3 100644
--- a/sound/soc/codecs/es8328.c
+++ b/sound/soc/codecs/es8328.c
@@ -812,8 +812,7 @@ static int es8328_remove(struct snd_soc_codec *codec)
 
 	es8328 = snd_soc_codec_get_drvdata(codec);
 
-	if (es8328->clk)
-		clk_disable_unprepare(es8328->clk);
+	clk_disable_unprepare(es8328->clk);
 
 	regulator_bulk_disable(ARRAY_SIZE(es8328->supplies),
 			       es8328->supplies);
diff --git a/sound/soc/codecs/wm8731.c b/sound/soc/codecs/wm8731.c
index 4f9a1eb..302ed88 100644
--- a/sound/soc/codecs/wm8731.c
+++ b/sound/soc/codecs/wm8731.c
@@ -517,8 +517,7 @@ static int wm8731_set_bias_level(struct snd_soc_codec *codec,
 		snd_soc_write(codec, WM8731_PWR, reg | 0x0040);
 		break;
 	case SND_SOC_BIAS_OFF:
-		if (wm8731->mclk)
-			clk_disable_unprepare(wm8731->mclk);
+		clk_disable_unprepare(wm8731->mclk);
 		snd_soc_write(codec, WM8731_PWR, 0xffff);
 		regulator_bulk_disable(ARRAY_SIZE(wm8731->supplies),
 				       wm8731->supplies);
diff --git a/sound/soc/davinci/davinci-evm.c b/sound/soc/davinci/davinci-evm.c
index 7a369e0..07a91c7 100644
--- a/sound/soc/davinci/davinci-evm.c
+++ b/sound/soc/davinci/davinci-evm.c
@@ -49,8 +49,7 @@ static void evm_shutdown(struct snd_pcm_substream *substream)
 	struct snd_soc_card_drvdata_davinci *drvdata =
 		snd_soc_card_get_drvdata(soc_card);
 
-	if (drvdata->mclk)
-		clk_disable_unprepare(drvdata->mclk);
+	clk_disable_unprepare(drvdata->mclk);
 }
 
 static int evm_hw_params(struct snd_pcm_substream *substream,
diff --git a/sound/soc/fsl/imx-audmux.c b/sound/soc/fsl/imx-audmux.c
index fc57da3..a7561e3 100644
--- a/sound/soc/fsl/imx-audmux.c
+++ b/sound/soc/fsl/imx-audmux.c
@@ -79,8 +79,7 @@ static ssize_t audmux_read_file(struct file *file, char __user *user_buf,
 	ptcr = readl(audmux_base + IMX_AUDMUX_V2_PTCR(port));
 	pdcr = readl(audmux_base + IMX_AUDMUX_V2_PDCR(port));
 
-	if (audmux_clk)
-		clk_disable_unprepare(audmux_clk);
+	clk_disable_unprepare(audmux_clk);
 
 	buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
 	if (!buf)
@@ -245,8 +244,7 @@ int imx_audmux_v2_configure_port(unsigned int port, unsigned int ptcr,
 	writel(ptcr, audmux_base + IMX_AUDMUX_V2_PTCR(port));
 	writel(pdcr, audmux_base + IMX_AUDMUX_V2_PDCR(port));
 
-	if (audmux_clk)
-		clk_disable_unprepare(audmux_clk);
+	clk_disable_unprepare(audmux_clk);
 
 	return 0;
 }
diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index 4a76b09..8c2a7a8 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -199,7 +199,7 @@ static int platform_clock_control(struct snd_soc_dapm_widget *w,
 					     48000 * 512,
 					     SND_SOC_CLOCK_IN);
 		if (!ret) {
-			if ((byt_rt5640_quirk & BYT_RT5640_MCLK_EN) && priv->mclk)
+			if (byt_rt5640_quirk & BYT_RT5640_MCLK_EN)
 				clk_disable_unprepare(priv->mclk);
 		}
 	}
diff --git a/sound/soc/intel/boards/cht_bsw_rt5645.c b/sound/soc/intel/boards/cht_bsw_rt5645.c
index 5bcde01..cb6f587 100644
--- a/sound/soc/intel/boards/cht_bsw_rt5645.c
+++ b/sound/soc/intel/boards/cht_bsw_rt5645.c
@@ -122,8 +122,7 @@ static int platform_clock_control(struct snd_soc_dapm_widget *w,
 			return ret;
 		}
 
-		if (ctx->mclk)
-			clk_disable_unprepare(ctx->mclk);
+		clk_disable_unprepare(ctx->mclk);
 	}
 
 	return 0;
diff --git a/sound/soc/mediatek/mt8173/mt8173-afe-pcm.c b/sound/soc/mediatek/mt8173/mt8173-afe-pcm.c
index 8a643a3..8857c08 100644
--- a/sound/soc/mediatek/mt8173/mt8173-afe-pcm.c
+++ b/sound/soc/mediatek/mt8173/mt8173-afe-pcm.c
@@ -294,10 +294,8 @@ static int mt8173_afe_dais_set_clks(struct mtk_base_afe *afe,
 static void mt8173_afe_dais_disable_clks(struct mtk_base_afe *afe,
 					 struct clk *m_ck, struct clk *b_ck)
 {
-	if (m_ck)
-		clk_disable_unprepare(m_ck);
-	if (b_ck)
-		clk_disable_unprepare(b_ck);
+	clk_disable_unprepare(m_ck);
+	clk_disable_unprepare(b_ck);
 }
 
 static int mt8173_afe_i2s_startup(struct snd_pcm_substream *substream,
diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index af3ba4d..3a06acd 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -1122,8 +1122,7 @@ static int i2s_runtime_suspend(struct device *dev)
 	i2s->suspend_i2scon = readl(i2s->addr + I2SCON);
 	i2s->suspend_i2spsr = readl(i2s->addr + I2SPSR);
 
-	if (i2s->op_clk)
-		clk_disable_unprepare(i2s->op_clk);
+	clk_disable_unprepare(i2s->op_clk);
 	clk_disable_unprepare(i2s->clk);
 
 	return 0;
-- 
2.7.4
