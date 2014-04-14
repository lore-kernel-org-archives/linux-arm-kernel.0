From: mpa@pengutronix.de (Markus Pargmann)
Date: Mon, 14 Apr 2014 15:35:40 +0200
Subject: [PATCH v3 10/18] ASoC: fsl-ssi: make fsl,mode property optional
In-Reply-To: <1397482548-28463-1-git-send-email-mpa@pengutronix.de>
References: <1397482548-28463-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1397482548-28463-11-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The simple soundcard binding has its own way for specifying the dai
format. To be able to use this binding we have to make the fsl,mode
property optional. As the property is used in existing devicetrees
keep the option around for compatibility reasons.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 sound/soc/fsl/fsl_ssi.c | 43 +++++++++++++++++++++++++++----------------
 1 file changed, 27 insertions(+), 16 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index d6d3f0a3..5c4b4bb 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -588,12 +588,9 @@ static int fsl_ssi_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-/**
- * fsl_ssi_set_dai_fmt - configure Digital Audio Interface Format.
- */
-static int fsl_ssi_set_dai_fmt(struct snd_soc_dai *cpu_dai, unsigned int fmt)
+static int _fsl_ssi_set_dai_fmt(struct fsl_ssi_private *ssi_private,
+		unsigned int fmt)
 {
-	struct fsl_ssi_private *ssi_private = snd_soc_dai_get_drvdata(cpu_dai);
 	struct ccsr_ssi __iomem *ssi = ssi_private->ssi;
 	u32 strcr = 0, stcr, srcr, scr, mask;
 	u8 wm;
@@ -601,7 +598,7 @@ static int fsl_ssi_set_dai_fmt(struct snd_soc_dai *cpu_dai, unsigned int fmt)
 	ssi_private->dai_fmt = fmt;
 
 	if (fsl_ssi_is_i2s_master(ssi_private) && IS_ERR(ssi_private->baudclk)) {
-		dev_err(cpu_dai->dev, "no baudclk needed for master mode\n");
+		dev_err(&ssi_private->pdev->dev, "no baudclk needed for master mode\n");
 		return -EINVAL;
 	}
 
@@ -736,6 +733,17 @@ static int fsl_ssi_set_dai_fmt(struct snd_soc_dai *cpu_dai, unsigned int fmt)
 		fsl_ssi_setup_ac97(ssi_private);
 
 	return 0;
+
+}
+
+/**
+ * fsl_ssi_set_dai_fmt - configure Digital Audio Interface Format.
+ */
+static int fsl_ssi_set_dai_fmt(struct snd_soc_dai *cpu_dai, unsigned int fmt)
+{
+	struct fsl_ssi_private *ssi_private = snd_soc_dai_get_drvdata(cpu_dai);
+
+	return _fsl_ssi_set_dai_fmt(ssi_private, fmt);
 }
 
 /**
@@ -1153,7 +1161,6 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 	const uint32_t *iprop;
 	struct resource res;
 	char name[64];
-	bool ac97 = false;
 
 	/* SSIs that are not connected on the board should have a
 	 *      status = "disabled"
@@ -1166,14 +1173,6 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 	if (!of_id || !of_id->data)
 		return -EINVAL;
 
-	sprop = of_get_property(np, "fsl,mode", NULL);
-	if (!sprop) {
-		dev_err(&pdev->dev, "fsl,mode property is necessary\n");
-		return -EINVAL;
-	}
-	if (!strcmp(sprop, "ac97-slave"))
-		ac97 = true;
-
 	ssi_private = devm_kzalloc(&pdev->dev, sizeof(*ssi_private),
 			GFP_KERNEL);
 	if (!ssi_private) {
@@ -1183,10 +1182,19 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 
 	ssi_private->soc = of_id->data;
 
+	sprop = of_get_property(np, "fsl,mode", NULL);
+	if (sprop) {
+		if (!strcmp(sprop, "ac97-slave"))
+			ssi_private->dai_fmt = SND_SOC_DAIFMT_AC97;
+		else if (!strcmp(sprop, "i2s-slave"))
+			ssi_private->dai_fmt = SND_SOC_DAIFMT_I2S |
+				SND_SOC_DAIFMT_CBM_CFM;
+	}
+
 	ssi_private->use_dma = !of_property_read_bool(np,
 			"fsl,fiq-stream-filter");
 
-	if (ac97) {
+	if (fsl_ssi_is_ac97(ssi_private)) {
 		memcpy(&ssi_private->cpu_dai_drv, &fsl_ssi_ac97_dai,
 				sizeof(fsl_ssi_ac97_dai));
 
@@ -1297,6 +1305,9 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 	}
 
 done:
+	if (ssi_private->dai_fmt)
+		_fsl_ssi_set_dai_fmt(ssi_private, ssi_private->dai_fmt);
+
 	return 0;
 
 error_sound_card:
-- 
1.9.1
