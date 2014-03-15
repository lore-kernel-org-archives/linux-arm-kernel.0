From: mpa@pengutronix.de (Markus Pargmann)
Date: Sat, 15 Mar 2014 13:44:21 +0100
Subject: [PATCH v2 13/16] ASoC: fsl-ssi: Set default dai-fmts
In-Reply-To: <1394887464-969-1-git-send-email-mpa@pengutronix.de>
References: <1394887464-969-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1394887464-969-14-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The old fsl_ssi_setup function was replaced by a set_dai_fmt function.
As the fsl-ssi driver has a 'fsl,mode' DT binding we should keep the
backward compatibility for the moment.

This patch sets default dai-fmt for backwards compatibility and
initializes the DAI using _fsl_ssi_set_dai_fmt().

The fsl,mode property parsing is moved, so it can directly set the
correct dai-fmt in ssi_private.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 sound/soc/fsl/fsl_ssi.c | 43 ++++++++++++++++++++++++++++---------------
 1 file changed, 28 insertions(+), 15 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index ab17055..bb6d607 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -600,12 +600,9 @@ static int fsl_ssi_hw_params(struct snd_pcm_substream *substream,
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
@@ -746,6 +743,17 @@ static int fsl_ssi_set_dai_fmt(struct snd_soc_dai *cpu_dai, unsigned int fmt)
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
@@ -1199,7 +1207,6 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 	const uint32_t *iprop;
 	struct resource res;
 	char name[64];
-	bool ac97 = false;
 
 	/* SSIs that are not connected on the board should have a
 	 *      status = "disabled"
@@ -1213,14 +1220,6 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 		return -EINVAL;
 	hw_type = (enum fsl_ssi_type) of_id->data;
 
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
@@ -1228,11 +1227,22 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
+	sprop = of_get_property(np, "fsl,mode", NULL);
+	if (!sprop) {
+		dev_err(&pdev->dev, "fsl,mode property is necessary\n");
+		return -EINVAL;
+	}
+	if (!strcmp(sprop, "ac97-slave"))
+		ssi_private->dai_fmt = SND_SOC_DAIFMT_AC97;
+	else if (!strcmp(sprop, "i2s-slave"))
+		ssi_private->dai_fmt = SND_SOC_DAIFMT_I2S |
+			SND_SOC_DAIFMT_CBM_CFM;
+
 	ssi_private->use_dma = !of_property_read_bool(np,
 			"fsl,fiq-stream-filter");
 	ssi_private->hw_type = hw_type;
 
-	if (ac97) {
+	if (fsl_ssi_is_ac97(ssi_private)) {
 		memcpy(&ssi_private->cpu_dai_drv, &fsl_ssi_ac97_dai,
 				sizeof(fsl_ssi_ac97_dai));
 
@@ -1342,6 +1352,9 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 	}
 
 done:
+	if (ssi_private->dai_fmt)
+		_fsl_ssi_set_dai_fmt(ssi_private, ssi_private->dai_fmt);
+
 	return 0;
 
 error_sound_card:
-- 
1.9.0
