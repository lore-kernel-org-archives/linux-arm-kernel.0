From: olivier.moysan@st.com (Olivier Moysan)
Date: Thu, 19 Oct 2017 15:03:18 +0200
Subject: [INTERNAL][PATCH 2/7] ASoC: stm32: sai: Move static settings to DAI
 init
In-Reply-To: <1508418203-16840-1-git-send-email-olivier.moysan@st.com>
References: <1508418203-16840-1-git-send-email-olivier.moysan@st.com>
Message-ID: <1508418203-16840-3-git-send-email-olivier.moysan@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Audio interface direction and protocol settings does not change
at runtime. So, these settings are moved from hw_params
function to dai_probe and set_fmt.

Signed-off-by: olivier moysan <olivier.moysan@st.com>
---
 sound/soc/stm/stm32_sai_sub.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/sound/soc/stm/stm32_sai_sub.c b/sound/soc/stm/stm32_sai_sub.c
index 90d4396..fdc1891 100644
--- a/sound/soc/stm/stm32_sai_sub.c
+++ b/sound/soc/stm/stm32_sai_sub.c
@@ -304,12 +304,15 @@ static int stm32_sai_set_dai_tdm_slot(struct snd_soc_dai *cpu_dai, u32 tx_mask,
 static int stm32_sai_set_dai_fmt(struct snd_soc_dai *cpu_dai, unsigned int fmt)
 {
 	struct stm32_sai_sub_data *sai = snd_soc_dai_get_drvdata(cpu_dai);
-	int cr1 = 0, frcr = 0;
-	int cr1_mask = 0, frcr_mask = 0;
+	int cr1, frcr = 0;
+	int cr1_mask, frcr_mask = 0;
 	int ret;
 
 	dev_dbg(cpu_dai->dev, "fmt %x\n", fmt);
 
+	cr1_mask = SAI_XCR1_PRTCFG_MASK;
+	cr1 = SAI_XCR1_PRTCFG_SET(SAI_FREE_PROTOCOL);
+
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	/* SCK active high for all protocols */
 	case SND_SOC_DAIFMT_I2S:
@@ -336,7 +339,7 @@ static int stm32_sai_set_dai_fmt(struct snd_soc_dai *cpu_dai, unsigned int fmt)
 		return -EINVAL;
 	}
 
-	cr1_mask |= SAI_XCR1_PRTCFG_MASK | SAI_XCR1_CKSTR;
+	cr1_mask |= SAI_XCR1_CKSTR;
 	frcr_mask |= SAI_XFRCR_FSPOL | SAI_XFRCR_FSOFF |
 		     SAI_XFRCR_FSDEF;
 
@@ -450,7 +453,7 @@ static int stm32_sai_set_config(struct snd_soc_dai *cpu_dai,
 			   SAI_XCR2_FFLUSH | SAI_XCR2_FTH_SET(fth));
 
 	/* Mode, data format and channel config */
-	cr1 = SAI_XCR1_PRTCFG_SET(SAI_FREE_PROTOCOL);
+	cr1_mask = SAI_XCR1_DS_MASK;
 	switch (params_format(params)) {
 	case SNDRV_PCM_FORMAT_S8:
 		cr1 |= SAI_XCR1_DS_SET(SAI_DATASIZE_8);
@@ -465,11 +468,6 @@ static int stm32_sai_set_config(struct snd_soc_dai *cpu_dai,
 		dev_err(cpu_dai->dev, "Data format not supported");
 		return -EINVAL;
 	}
-	cr1_mask = SAI_XCR1_DS_MASK | SAI_XCR1_PRTCFG_MASK;
-
-	cr1_mask |= SAI_XCR1_RX_TX;
-	if (STM_SAI_IS_CAPTURE(sai))
-		cr1 |= SAI_XCR1_RX_TX;
 
 	cr1_mask |= SAI_XCR1_MONO;
 	if ((sai->slots == 2) && (params_channels(params) == 1))
@@ -725,6 +723,7 @@ static void stm32_sai_shutdown(struct snd_pcm_substream *substream,
 static int stm32_sai_dai_probe(struct snd_soc_dai *cpu_dai)
 {
 	struct stm32_sai_sub_data *sai = dev_get_drvdata(cpu_dai->dev);
+	int cr1 = 0, cr1_mask;
 
 	sai->dma_params.addr = (dma_addr_t)(sai->phys_addr + STM_SAI_DR_REGX);
 	sai->dma_params.maxburst = 1;
@@ -736,7 +735,11 @@ static int stm32_sai_dai_probe(struct snd_soc_dai *cpu_dai)
 	else
 		snd_soc_dai_init_dma_data(cpu_dai, NULL, &sai->dma_params);
 
-	return 0;
+	cr1_mask = SAI_XCR1_RX_TX;
+	if (STM_SAI_IS_CAPTURE(sai))
+		cr1 |= SAI_XCR1_RX_TX;
+
+	return regmap_update_bits(sai->regmap, STM_SAI_CR1_REGX, cr1_mask, cr1);
 }
 
 static const struct snd_soc_dai_ops stm32_sai_pcm_dai_ops = {
-- 
1.9.1
