From: broonie@kernel.org (Mark Brown)
Date: Tue, 25 Oct 2016 20:24:06 +0100
Subject: Applied "ASoC: s3c24xx_uda134x: Move global variables to driver's
 data structure" to the asoc tree
In-Reply-To: <1470317928-25365-9-git-send-email-s.nawrocki@samsung.com>
Message-ID: <E1bz7KQ-0004rl-Mv@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: s3c24xx_uda134x: Move global variables to driver's data structure

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 892ccf0f2173a9ede5448411e9475616fb21fb51 Mon Sep 17 00:00:00 2001
From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Date: Tue, 25 Oct 2016 12:57:57 +0200
Subject: [PATCH] ASoC: s3c24xx_uda134x: Move global variables to driver's data
 structure

Gather all driver's private variables in common data structure
and allocate the data structure dynamically.

Also unused ENFORCE_RATES symbol and local variable (leftovers
from an erroneous rebase) are removed.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/samsung/s3c24xx_uda134x.c | 79 ++++++++++++++++++++-----------------
 1 file changed, 43 insertions(+), 36 deletions(-)

diff --git a/sound/soc/samsung/s3c24xx_uda134x.c b/sound/soc/samsung/s3c24xx_uda134x.c
index 7853fbe6ccc9..81a78940967c 100644
--- a/sound/soc/samsung/s3c24xx_uda134x.c
+++ b/sound/soc/samsung/s3c24xx_uda134x.c
@@ -19,9 +19,15 @@
 #include <sound/s3c24xx_uda134x.h>
 
 #include "regs-iis.h"
-
 #include "s3c24xx-i2s.h"
 
+struct s3c24xx_uda134x {
+	struct clk *xtal;
+	struct clk *pclk;
+	struct mutex clk_lock;
+	int clk_users;
+};
+
 /* #define ENFORCE_RATES 1 */
 /*
   Unfortunately the S3C24XX in master mode has a limited capacity of
@@ -36,15 +42,6 @@
   possible an error will be returned.
 */
 
-static struct clk *xtal;
-static struct clk *pclk;
-/* this is need because we don't have a place where to keep the
- * pointers to the clocks in each substream. We get the clocks only
- * when we are actually using them so we don't block stuff like
- * frequency change or oscillator power-off */
-static int clk_users;
-static DEFINE_MUTEX(clk_lock);
-
 static unsigned int rates[33 * 2];
 #ifdef ENFORCE_RATES
 static struct snd_pcm_hw_constraint_list hw_constraints_rates = {
@@ -57,26 +54,24 @@ static struct snd_pcm_hw_constraint_list hw_constraints_rates = {
 static int s3c24xx_uda134x_startup(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct s3c24xx_uda134x *priv = snd_soc_card_get_drvdata(rtd->card);
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
-#ifdef ENFORCE_RATES
-	struct snd_pcm_runtime *runtime = substream->runtime;
-#endif
 	int ret = 0;
 
-	mutex_lock(&clk_lock);
+	mutex_lock(&priv->clk_lock);
 
-	if (clk_users == 0) {
-		xtal = clk_get(rtd->dev, "xtal");
-		if (IS_ERR(xtal)) {
+	if (priv->clk_users == 0) {
+		priv->xtal = clk_get(rtd->dev, "xtal");
+		if (IS_ERR(priv->xtal)) {
 			dev_err(rtd->dev, "%s cannot get xtal\n", __func__);
-			ret = PTR_ERR(xtal);
+			ret = PTR_ERR(priv->xtal);
 		} else {
-			pclk = clk_get(cpu_dai->dev, "iis");
-			if (IS_ERR(pclk)) {
+			priv->pclk = clk_get(cpu_dai->dev, "iis");
+			if (IS_ERR(priv->pclk)) {
 				dev_err(rtd->dev, "%s cannot get pclk\n",
 					__func__);
-				clk_put(xtal);
-				ret = PTR_ERR(pclk);
+				clk_put(priv->xtal);
+				ret = PTR_ERR(priv->pclk);
 			}
 		}
 		if (!ret) {
@@ -85,18 +80,19 @@ static int s3c24xx_uda134x_startup(struct snd_pcm_substream *substream)
 			for (i = 0; i < 2; i++) {
 				int fs = i ? 256 : 384;
 
-				rates[i*33] = clk_get_rate(xtal) / fs;
+				rates[i*33] = clk_get_rate(priv->xtal) / fs;
 				for (j = 1; j < 33; j++)
-					rates[i*33 + j] = clk_get_rate(pclk) /
+					rates[i*33 + j] = clk_get_rate(priv->pclk) /
 						(j * fs);
 			}
 		}
 	}
-	clk_users += 1;
-	mutex_unlock(&clk_lock);
+	priv->clk_users += 1;
+	mutex_unlock(&priv->clk_lock);
+
 	if (!ret) {
 #ifdef ENFORCE_RATES
-		ret = snd_pcm_hw_constraint_list(runtime, 0,
+		ret = snd_pcm_hw_constraint_list(substream->runtime, 0,
 						 SNDRV_PCM_HW_PARAM_RATE,
 						 &hw_constraints_rates);
 		if (ret < 0)
@@ -109,15 +105,18 @@ static int s3c24xx_uda134x_startup(struct snd_pcm_substream *substream)
 
 static void s3c24xx_uda134x_shutdown(struct snd_pcm_substream *substream)
 {
-	mutex_lock(&clk_lock);
-	clk_users -= 1;
-	if (clk_users == 0) {
-		clk_put(xtal);
-		xtal = NULL;
-		clk_put(pclk);
-		pclk = NULL;
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct s3c24xx_uda134x *priv = snd_soc_card_get_drvdata(rtd->card);
+
+	mutex_lock(&priv->clk_lock);
+	priv->clk_users -= 1;
+	if (priv->clk_users == 0) {
+		clk_put(priv->xtal);
+		priv->xtal = NULL;
+		clk_put(priv->pclk);
+		priv->pclk = NULL;
 	}
-	mutex_unlock(&clk_lock);
+	mutex_unlock(&priv->clk_lock);
 }
 
 static int s3c24xx_uda134x_hw_params(struct snd_pcm_substream *substream,
@@ -228,10 +227,18 @@ static struct snd_soc_card snd_soc_s3c24xx_uda134x = {
 static int s3c24xx_uda134x_probe(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = &snd_soc_s3c24xx_uda134x;
+	struct s3c24xx_uda134x *priv;
 	int ret;
 
-	platform_set_drvdata(pdev, card);
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	mutex_init(&priv->clk_lock);
+
 	card->dev = &pdev->dev;
+	platform_set_drvdata(pdev, card);
+	snd_soc_card_set_drvdata(card, priv);
 
 	ret = devm_snd_soc_register_card(&pdev->dev, card);
 	if (ret)
-- 
2.8.1
