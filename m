From: olivier.moysan@st.com (olivier moysan)
Date: Fri, 16 Jun 2017 14:15:34 +0200
Subject: [PATCH 7/7] ASoC: stm32: sai: manage master clock
In-Reply-To: <1497615334-7156-1-git-send-email-olivier.moysan@st.com>
References: <1497615334-7156-1-git-send-email-olivier.moysan@st.com>
Message-ID: <1497615334-7156-8-git-send-email-olivier.moysan@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Disable master clock by default, and activate
it only when requested.

Signed-off-by: olivier moysan <olivier.moysan@st.com>
---
 sound/soc/stm/stm32_sai_sub.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/sound/soc/stm/stm32_sai_sub.c b/sound/soc/stm/stm32_sai_sub.c
index 2466af0..ce48c02 100644
--- a/sound/soc/stm/stm32_sai_sub.c
+++ b/sound/soc/stm/stm32_sai_sub.c
@@ -220,8 +220,15 @@ static int stm32_sai_set_sysclk(struct snd_soc_dai *cpu_dai,
 				int clk_id, unsigned int freq, int dir)
 {
 	struct stm32_sai_sub_data *sai = snd_soc_dai_get_drvdata(cpu_dai);
+	int ret;
 
 	if ((dir == SND_SOC_CLOCK_OUT) && sai->master) {
+		ret = regmap_update_bits(sai->regmap, STM_SAI_CR1_REGX,
+					 SAI_XCR1_NODIV,
+					 (unsigned int)~SAI_XCR1_NODIV);
+		if (ret < 0)
+			return ret;
+
 		sai->mclk_rate = freq;
 		dev_dbg(cpu_dai->dev, "SAI MCLK frequency is %uHz\n", freq);
 	}
@@ -356,6 +363,10 @@ static int stm32_sai_set_dai_fmt(struct snd_soc_dai *cpu_dai, unsigned int fmt)
 	}
 	cr1_mask |= SAI_XCR1_SLAVE;
 
+	/* do not generate master by default */
+	cr1 |= SAI_XCR1_NODIV;
+	cr1_mask |= SAI_XCR1_NODIV;
+
 	ret = regmap_update_bits(sai->regmap, STM_SAI_CR1_REGX, cr1_mask, cr1);
 	if (ret < 0) {
 		dev_err(cpu_dai->dev, "Failed to update CR1 register\n");
@@ -652,6 +663,9 @@ static void stm32_sai_shutdown(struct snd_pcm_substream *substream,
 
 	regmap_update_bits(sai->regmap, STM_SAI_IMR_REGX, SAI_XIMR_MASK, 0);
 
+	regmap_update_bits(sai->regmap, STM_SAI_CR1_REGX, SAI_XCR1_NODIV,
+			   SAI_XCR1_NODIV);
+
 	clk_disable_unprepare(sai->sai_ck);
 	sai->substream = NULL;
 }
-- 
1.9.1
