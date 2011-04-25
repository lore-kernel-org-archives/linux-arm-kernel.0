From: sbkim73@samsung.com (Sangbeom Kim)
Date: Mon, 25 Apr 2011 15:47:38 +0900
Subject: [PATCH] ASoC: SAMSUNG: Add quirk to support Exynos4 PCM audio
Message-ID: <1303714058-647-1-git-send-email-sbkim73@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Exynos4 pcm block is different from previous one.
Unlike previous one, Exynos4 doesn't have SCLK divider in the pcm block.
For this reason, This patch added quirk handling for Exynos4 pcm cpu driver.

Signed-off-by: Sangbeom Kim <sbkim73@samsung.com>
---
 sound/soc/samsung/pcm.c |   44 ++++++++++++++++++++++++++++----------------
 1 files changed, 28 insertions(+), 16 deletions(-)

diff --git a/sound/soc/samsung/pcm.c b/sound/soc/samsung/pcm.c
index 9c7e8b4..f007a5b 100644
--- a/sound/soc/samsung/pcm.c
+++ b/sound/soc/samsung/pcm.c
@@ -10,7 +10,6 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
-
 #include <linux/clk.h>
 #include <linux/io.h>
 
@@ -128,6 +127,7 @@ struct s3c_pcm_info {
 
 	struct s3c_dma_params	*dma_playback;
 	struct s3c_dma_params	*dma_capture;
+	u32	quirks;
 };
 
 static struct s3c2410_dma_client s3c_pcm_dma_client_out = {
@@ -299,25 +299,34 @@ static int s3c_pcm_hw_params(struct snd_pcm_substream *substream,
 
 	spin_lock_irqsave(&pcm->lock, flags);
 
-	/* Get hold of the PCMSOURCE_CLK */
-	clkctl = readl(regs + S3C_PCM_CLKCTL);
-	if (clkctl & S3C_PCM_CLKCTL_SERCLKSEL_PCLK)
-		clk = pcm->pclk;
-	else
+	if (pcm->quirks == QUIRK_NO_DIV) {
 		clk = pcm->cclk;
+		if (clk_get_rate(clk) != (pcm->sclk_per_fs*params_rate(params))) {
+			clk_set_rate(clk, pcm->sclk_per_fs*params_rate(params));
+		}
+		sync_div = clk_get_rate(clk)/(params_rate(params))-1;
+	}
+	else {
+		/* Get hold of the PCMSOURCE_CLK */
+		clkctl = readl(regs + S3C_PCM_CLKCTL);
+		if (clkctl & S3C_PCM_CLKCTL_SERCLKSEL_PCLK)
+			clk = pcm->pclk;
+		else
+			clk = pcm->cclk;
 
-	/* Set the SCLK divider */
-	sclk_div = clk_get_rate(clk) / pcm->sclk_per_fs /
-					params_rate(params) / 2 - 1;
+		/* Set the SCLK divider */
+		sclk_div = clk_get_rate(clk) / pcm->sclk_per_fs /
+				params_rate(params) / 2 - 1;
 
-	clkctl &= ~(S3C_PCM_CLKCTL_SCLKDIV_MASK
-			<< S3C_PCM_CLKCTL_SCLKDIV_SHIFT);
-	clkctl |= ((sclk_div & S3C_PCM_CLKCTL_SCLKDIV_MASK)
-			<< S3C_PCM_CLKCTL_SCLKDIV_SHIFT);
+		clkctl &= ~(S3C_PCM_CLKCTL_SCLKDIV_MASK
+				<< S3C_PCM_CLKCTL_SCLKDIV_SHIFT);
+		clkctl |= ((sclk_div & S3C_PCM_CLKCTL_SCLKDIV_MASK)
+				<< S3C_PCM_CLKCTL_SCLKDIV_SHIFT);
 
-	/* Set the SYNC divider */
-	sync_div = pcm->sclk_per_fs - 1;
+		sync_div = pcm->sclk_per_fs - 1;
+	}
 
+	/* Set the SYNC divider */
 	clkctl &= ~(S3C_PCM_CLKCTL_SYNCDIV_MASK
 				<< S3C_PCM_CLKCTL_SYNCDIV_SHIFT);
 	clkctl |= ((sync_div & S3C_PCM_CLKCTL_SYNCDIV_MASK)
@@ -330,7 +339,6 @@ static int s3c_pcm_hw_params(struct snd_pcm_substream *substream,
 	dev_dbg(pcm->dev, "PCMSOURCE_CLK-%lu SCLK=%ufs SCLK_DIV=%d SYNC_DIV=%d\n",
 				clk_get_rate(clk), pcm->sclk_per_fs,
 				sclk_div, sync_div);
-
 	return 0;
 }
 
@@ -494,6 +502,7 @@ static __devinit int s3c_pcm_dev_probe(struct platform_device *pdev)
 	struct s3c_pcm_info *pcm;
 	struct resource *mem_res, *dmatx_res, *dmarx_res;
 	struct s3c_audio_pdata *pcm_pdata;
+	struct samsung_i2s *pcm_cfg;
 	int ret;
 
 	/* Check for valid device index */
@@ -531,6 +540,9 @@ static __devinit int s3c_pcm_dev_probe(struct platform_device *pdev)
 	pcm = &s3c_pcm[pdev->id];
 	pcm->dev = &pdev->dev;
 
+	pcm_cfg = &pcm_pdata->type.i2s;
+	pcm->quirks = pcm_cfg->quirks;
+
 	spin_lock_init(&pcm->lock);
 
 	/* Default is 128fs */
-- 
1.7.1
