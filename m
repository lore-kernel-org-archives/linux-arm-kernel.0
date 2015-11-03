From: wxt@rock-chips.com (Caesar Wang)
Date: Tue,  3 Nov 2015 09:33:58 +0800
Subject: [PATCH v1 5/5] ASoC: rockchip-rt5645: Add the divider clock for cpu
In-Reply-To: <1446514438-13922-1-git-send-email-wxt@rock-chips.com>
References: <1446514438-13922-1-git-send-email-wxt@rock-chips.com>
Message-ID: <1446514438-13922-6-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add to set the cpu/codec DAI configure, let's divider the
Transmit/Receive clock for cpu.

In master mode, The SCLK and LRCK are configured as output,
this patch should can set each divider to arrange the clock distribution.

Signed-off-by: Caesar Wang <wxt@rock-chips.com>

---

Changes in v1:
- Fix a subject missspell.

 sound/soc/rockchip/rockchip_rt5645.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/sound/soc/rockchip/rockchip_rt5645.c b/sound/soc/rockchip/rockchip_rt5645.c
index edff07f..4c1a693 100644
--- a/sound/soc/rockchip/rockchip_rt5645.c
+++ b/sound/soc/rockchip/rockchip_rt5645.c
@@ -74,8 +74,25 @@ static int rk_aif1_hw_params(struct snd_pcm_substream *substream,
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
@@ -109,6 +126,21 @@ static int rk_aif1_hw_params(struct snd_pcm_substream *substream,
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
