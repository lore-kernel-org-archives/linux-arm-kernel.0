From: mpa@pengutronix.de (Markus Pargmann)
Date: Sat, 15 Mar 2014 13:44:20 +0100
Subject: [PATCH v2 12/16] ASoC: fsl-ssi: Only enable baudclk when used
In-Reply-To: <1394887464-969-1-git-send-email-mpa@pengutronix.de>
References: <1394887464-969-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1394887464-969-13-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable baudclk only when it is used. The baudclk should not be enabled
all the time when the SSI driver is active. Instead this patch
enables/disables the clock in the trigger function. It also limits the
use of this clock to cases where the SSI unit is the I2S master.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 sound/soc/fsl/fsl_ssi.c | 77 +++++++++++++++++++++++++++++++------------------
 1 file changed, 49 insertions(+), 28 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 0d10b7e..ab17055 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -211,6 +211,12 @@ static bool fsl_ssi_is_ac97(struct fsl_ssi_private *ssi_private)
 	return !!(ssi_private->dai_fmt & SND_SOC_DAIFMT_AC97);
 }
 
+static bool fsl_ssi_is_i2s_master(struct fsl_ssi_private *ssi_private)
+{
+	return (ssi_private->dai_fmt & SND_SOC_DAIFMT_MASTER_MASK) ==
+		SND_SOC_DAIFMT_CBS_CFS;
+}
+
 static bool fsl_ssi_on_imx(struct fsl_ssi_private *ssi_private)
 {
 	switch (ssi_private->hw_type) {
@@ -525,13 +531,6 @@ static int fsl_ssi_startup(struct snd_pcm_substream *substream,
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct fsl_ssi_private *ssi_private =
 		snd_soc_dai_get_drvdata(rtd->cpu_dai);
-	unsigned long flags;
-
-	if (!dai->active && !fsl_ssi_is_ac97(ssi_private)) {
-		spin_lock_irqsave(&ssi_private->baudclk_lock, flags);
-		ssi_private->baudclk_locked = false;
-		spin_unlock_irqrestore(&ssi_private->baudclk_lock, flags);
-	}
 
 	/* When using dual fifo mode, it is safer to ensure an even period
 	 * size. If appearing to an odd number while DMA always starts its
@@ -613,6 +612,9 @@ static int fsl_ssi_set_dai_fmt(struct snd_soc_dai *cpu_dai, unsigned int fmt)
 
 	ssi_private->dai_fmt = fmt;
 
+	if (fsl_ssi_is_i2s_master(ssi_private) && IS_ERR(ssi_private->baudclk))
+		return -EINVAL;
+
 	fsl_ssi_setup_reg_vals(ssi_private);
 
 	scr = read_ssi(&ssi->scr) & ~(CCSR_SSI_SCR_SYN | CCSR_SSI_SCR_I2S_MODE_MASK);
@@ -766,8 +768,10 @@ static int fsl_ssi_set_dai_sysclk(struct snd_soc_dai *cpu_dai,
 	u64 sub, savesub = 100000;
 
 	/* Don't apply it to any non-baudclk circumstance */
-	if (IS_ERR(ssi_private->baudclk))
+	if (IS_ERR(ssi_private->baudclk)) {
+		dev_err(cpu_dai->dev, "Failed to set clock, no baudclk present\n");
 		return -EINVAL;
+	}
 
 	/* It should be already enough to divide clock by setting pm alone */
 	psr = 0;
@@ -833,7 +837,10 @@ static int fsl_ssi_set_dai_sysclk(struct snd_soc_dai *cpu_dai,
 			dev_err(cpu_dai->dev, "failed to set baudclk rate\n");
 			return -EINVAL;
 		}
-		ssi_private->baudclk_locked = true;
+	} else {
+		spin_unlock_irqrestore(&ssi_private->baudclk_lock, flags);
+		dev_err(cpu_dai->dev, "Failed to set baudclk rate because it is in use\n");
+		return -EBUSY;
 	}
 	spin_unlock_irqrestore(&ssi_private->baudclk_lock, flags);
 
@@ -894,10 +901,34 @@ static int fsl_ssi_trigger(struct snd_pcm_substream *substream, int cmd,
 	struct fsl_ssi_private *ssi_private = snd_soc_dai_get_drvdata(rtd->cpu_dai);
 	struct ccsr_ssi __iomem *ssi = ssi_private->ssi;
 	unsigned long flags;
+	u32 val;
+	int nr_active;
+
+	val = read_ssi(&ssi->scr);
+	nr_active = !!(val & CCSR_SSI_SCR_TE) + !!(val & CCSR_SSI_SCR_RE);
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		if (fsl_ssi_is_i2s_master(ssi_private) && nr_active == 0) {
+			int ret;
+
+			spin_lock_irqsave(&ssi_private->baudclk_lock, flags);
+			ret = clk_prepare_enable(ssi_private->baudclk);
+			if (ret) {
+				spin_unlock_irqrestore(
+						&ssi_private->baudclk_lock,
+						flags);
+				dev_err(rtd->cpu_dai->dev,
+						"Failed to enable baud clock (%d)\n",
+						ret);
+				return ret;
+			}
+			ssi_private->baudclk_locked = true;
+			spin_unlock_irqrestore(&ssi_private->baudclk_lock,
+					flags);
+		}
+
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
 			fsl_ssi_tx_config(ssi_private, true);
 		else
@@ -911,11 +942,14 @@ static int fsl_ssi_trigger(struct snd_pcm_substream *substream, int cmd,
 		else
 			fsl_ssi_rx_config(ssi_private, false);
 
-		if (!fsl_ssi_is_ac97(ssi_private) && (read_ssi(&ssi->scr) &
-					(CCSR_SSI_SCR_TE | CCSR_SSI_SCR_RE)) == 0) {
+		if (fsl_ssi_is_i2s_master(ssi_private) && nr_active == 1) {
 			spin_lock_irqsave(&ssi_private->baudclk_lock, flags);
-			ssi_private->baudclk_locked = false;
-			spin_unlock_irqrestore(&ssi_private->baudclk_lock, flags);
+			if (ssi_private->baudclk_locked) {
+				clk_disable_unprepare(ssi_private->baudclk);
+				ssi_private->baudclk_locked = false;
+			}
+			spin_unlock_irqrestore(&ssi_private->baudclk_lock,
+					flags);
 		}
 		break;
 
@@ -1090,12 +1124,6 @@ static int fsl_ssi_imx_probe(struct platform_device *pdev,
 			goto error_baud_clk;
 		dev_dbg(&pdev->dev, "could not get baud clock: %ld\n",
 				PTR_ERR(ssi_private->baudclk));
-	} else {
-		ret = clk_prepare_enable(ssi_private->baudclk);
-		if (ret) {
-			dev_err(&pdev->dev, "Failed to enable baud clock\n");
-			goto error_baud_clk;
-		}
 	}
 
 	/*
@@ -1137,19 +1165,15 @@ static int fsl_ssi_imx_probe(struct platform_device *pdev,
 
 		ret = imx_pcm_fiq_init(pdev, &ssi_private->fiq_params);
 		if (ret)
-			goto error_pcm;
+			goto error_baud_clk;
 	} else {
 		ret = imx_pcm_dma_init(pdev);
 		if (ret)
-			goto error_pcm;
+			goto error_baud_clk;
 	}
 
 	return 0;
 
-error_pcm:
-	if (!IS_ERR(ssi_private->baudclk))
-		clk_disable_unprepare(ssi_private->baudclk);
-
 error_baud_clk:
 	clk_disable_unprepare(ssi_private->clk);
 
@@ -1161,8 +1185,6 @@ static void fsl_ssi_imx_clean(struct platform_device *pdev,
 {
 	if (!ssi_private->use_dma)
 		imx_pcm_fiq_exit(pdev);
-	if (!IS_ERR(ssi_private->baudclk))
-		clk_disable_unprepare(ssi_private->baudclk);
 	clk_disable_unprepare(ssi_private->clk);
 }
 
@@ -1258,7 +1280,6 @@ static int fsl_ssi_probe(struct platform_device *pdev)
                 /* Older 8610 DTs didn't have the fifo-depth property */
 		ssi_private->fifo_depth = 8;
 
-	ssi_private->baudclk_locked = false;
 	spin_lock_init(&ssi_private->baudclk_lock);
 
 	dev_set_drvdata(&pdev->dev, ssi_private);
-- 
1.9.0
