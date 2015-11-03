From: wxt@rock-chips.com (Caesar Wang)
Date: Tue,  3 Nov 2015 09:33:57 +0800
Subject: [PATCH v1 4/5] ASoC: rockchip-max98090: Add the divider clock for cpu
In-Reply-To: <1446514438-13922-1-git-send-email-wxt@rock-chips.com>
References: <1446514438-13922-1-git-send-email-wxt@rock-chips.com>
Message-ID: <1446514438-13922-5-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add to set the cpu/codec DAI configure, let's divider the
Transmit/Receive clocks for cpu.

In master mode, The SCLK and LRCK are configured as output,
this patch should can set each divider to arrange the clock distribution.

Signed-off-by: Caesar Wang <wxt@rock-chips.com>
---

Changes in v1: None

 sound/soc/rockchip/rockchip_max98090.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/sound/soc/rockchip/rockchip_max98090.c b/sound/soc/rockchip/rockchip_max98090.c
index a6ff221..e1cdd40 100644
--- a/sound/soc/rockchip/rockchip_max98090.c
+++ b/sound/soc/rockchip/rockchip_max98090.c
@@ -75,8 +75,25 @@ static int rk_aif1_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	int dai_fmt = rtd->card->dai_link->dai_fmt;
 	int mclk;
 
+	/* set codec DAI configuration */
+	ret = snd_soc_dai_set_fmt(codec_dai, dai_fmt);
+	if (ret < 0) {
+		dev_err(codec_dai->dev,
+			"failed to set the format for codec side\n");
+		return ret;
+	}
+
+	/* set cpu DAI configuration */
+	ret = snd_soc_dai_set_fmt(cpu_dai, dai_fmt);
+	if (ret < 0) {
+		dev_err(codec_dai->dev,
+			"failed to set the format for cpu side\n");
+		return ret;
+	}
+
 	switch (params_rate(params)) {
 	case 8000:
 	case 16000:
@@ -110,6 +127,21 @@ static int rk_aif1_hw_params(struct snd_pcm_substream *substream,
 		return ret;
 	}
 
+	/* The codec is master mode, that's not needed set clkdiv for cpu */
+	if ((dai_fmt & SND_SOC_DAIFMT_MASTER_MASK) == SND_SOC_DAIFMT_CBM_CFM)
+		return ret;
+
+	/* the LRCK clock for cpu */
+	ret = snd_soc_dai_set_clkdiv(cpu_dai, ROCKCHIP_DIV_BCLK,
+				     (mclk / 4) / params_rate(params));
+	if (ret < 0)
+		return ret;
+
+	/* the SCLK clock for cpu */
+	snd_soc_dai_set_clkdiv(cpu_dai, ROCKCHIP_DIV_MCLK, 4);
+	if (ret < 0)
+		return ret;
+
 	return ret;
 }
 
-- 
1.9.1
