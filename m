From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Thu, 12 Aug 2010 11:48:00 +0800
Subject: [PATCH 3/5] ASoC: update setting for pxa ssp slave mode
Message-ID: <mailman.169.1281707738.27306.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SCFR bit is required to be always set if pxa ssp is in slave mode. This bit
indicates clock input to SSPSCLK is only active during data transfers.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 sound/soc/pxa/pxa-ssp.c |   23 +++++++++++++++--------
 1 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/sound/soc/pxa/pxa-ssp.c b/sound/soc/pxa/pxa-ssp.c
index c4f480d..8dfbcda 100644
--- a/sound/soc/pxa/pxa-ssp.c
+++ b/sound/soc/pxa/pxa-ssp.c
@@ -462,9 +462,7 @@ static int pxa_ssp_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 {
 	struct ssp_priv *priv = snd_soc_dai_get_drvdata(cpu_dai);
 	struct ssp_device *ssp = priv->ssp;
-	u32 sscr0;
-	u32 sscr1;
-	u32 sspsp;
+	u32 sscr0, sscr1, sspsp, scfr;

 	/* check if we need to change anything at all */
 	if (priv->dai_fmt == fmt)
@@ -479,16 +477,16 @@ static int pxa_ssp_set_dai_fmt(struct
snd_soc_dai *cpu_dai,

 	/* reset port settings */
 	sscr0 = pxa_ssp_read_reg(ssp, SSCR0) &
-		(SSCR0_ECS |  SSCR0_NCS | SSCR0_MOD | SSCR0_ACS);
+		~(SSCR0_ECS |  SSCR0_NCS | SSCR0_MOD | SSCR0_ACS);
 	sscr1 = SSCR1_RxTresh(8) | SSCR1_TxTresh(7);
 	sspsp = 0;

 	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
 	case SND_SOC_DAIFMT_CBM_CFM:
-		sscr1 |= SSCR1_SCLKDIR | SSCR1_SFRMDIR;
+		sscr1 |= SSCR1_SCLKDIR | SSCR1_SFRMDIR | SSCR1_SCFR;
 		break;
 	case SND_SOC_DAIFMT_CBM_CFS:
-		sscr1 |= SSCR1_SCLKDIR;
+		sscr1 |= SSCR1_SCLKDIR | SSCR1_SCFR;
 		break;
 	case SND_SOC_DAIFMT_CBS_CFS:
 		break;
@@ -534,6 +532,17 @@ static int pxa_ssp_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 	pxa_ssp_write_reg(ssp, SSCR1, sscr1);
 	pxa_ssp_write_reg(ssp, SSPSP, sspsp);

+	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+	case SND_SOC_DAIFMT_CBM_CFM:
+	case SND_SOC_DAIFMT_CBM_CFS:
+		scfr = pxa_ssp_read_reg(ssp, SSCR1) | SSCR1_SCFR;
+		pxa_ssp_write_reg(ssp, SSCR1, scfr);
+
+		while (pxa_ssp_read_reg(ssp, SSSR) & SSSR_BSY)
+			cpu_relax();
+		break;
+	}
+
 	dump_registers(ssp);

 	/* Since we are configuring the timings for the format by hand
@@ -583,10 +592,8 @@ static int pxa_ssp_hw_params(struct
snd_pcm_substream *substream,

 	/* clear selected SSP bits */
 	sscr0 = pxa_ssp_read_reg(ssp, SSCR0) & ~(SSCR0_DSS | SSCR0_EDSS);
-	pxa_ssp_write_reg(ssp, SSCR0, sscr0);

 	/* bit size */
-	sscr0 = pxa_ssp_read_reg(ssp, SSCR0);
 	switch (params_format(params)) {
 	case SNDRV_PCM_FORMAT_S16_LE:
 #ifdef CONFIG_PXA3xx
-- 
1.5.6.5
