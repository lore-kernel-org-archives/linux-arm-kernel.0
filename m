From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Thu, 04 Aug 2016 15:38:47 +0200
Subject: [PATCH 7/8] ASoC: samsung: s3c24xx_uda134x: debug/error trace cleanup
In-Reply-To: <1470317928-25365-1-git-send-email-s.nawrocki@samsung.com>
References: <1470317928-25365-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <1470317928-25365-8-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Switch from pr_* to dev_* macros and drop some debug traces.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 sound/soc/samsung/s3c24xx_uda134x.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/sound/soc/samsung/s3c24xx_uda134x.c b/sound/soc/samsung/s3c24xx_uda134x.c
index a8102a7..7853fbe 100644
--- a/sound/soc/samsung/s3c24xx_uda134x.c
+++ b/sound/soc/samsung/s3c24xx_uda134x.c
@@ -64,17 +64,17 @@ static int s3c24xx_uda134x_startup(struct snd_pcm_substream *substream)
 	int ret = 0;
 
 	mutex_lock(&clk_lock);
-	pr_debug("%s %d\n", __func__, clk_users);
+
 	if (clk_users == 0) {
 		xtal = clk_get(rtd->dev, "xtal");
 		if (IS_ERR(xtal)) {
-			printk(KERN_ERR "%s cannot get xtal\n", __func__);
+			dev_err(rtd->dev, "%s cannot get xtal\n", __func__);
 			ret = PTR_ERR(xtal);
 		} else {
 			pclk = clk_get(cpu_dai->dev, "iis");
 			if (IS_ERR(pclk)) {
-				printk(KERN_ERR "%s cannot get pclk\n",
-				       __func__);
+				dev_err(rtd->dev, "%s cannot get pclk\n",
+					__func__);
 				clk_put(xtal);
 				ret = PTR_ERR(pclk);
 			}
@@ -100,8 +100,8 @@ static int s3c24xx_uda134x_startup(struct snd_pcm_substream *substream)
 						 SNDRV_PCM_HW_PARAM_RATE,
 						 &hw_constraints_rates);
 		if (ret < 0)
-			printk(KERN_ERR "%s cannot set constraints\n",
-			       __func__);
+			dev_err(rtd->dev, "%s cannot set constraints\n",
+				__func__);
 #endif
 	}
 	return ret;
@@ -110,7 +110,6 @@ static int s3c24xx_uda134x_startup(struct snd_pcm_substream *substream)
 static void s3c24xx_uda134x_shutdown(struct snd_pcm_substream *substream)
 {
 	mutex_lock(&clk_lock);
-	pr_debug("%s %d\n", __func__, clk_users);
 	clk_users -= 1;
 	if (clk_users == 0) {
 		clk_put(xtal);
@@ -157,18 +156,19 @@ static int s3c24xx_uda134x_hw_params(struct snd_pcm_substream *substream,
 		clk_source = S3C24XX_CLKSRC_PCLK;
 		div = bi % 33;
 	}
-	pr_debug("%s desired rate %lu, %d\n", __func__, rate, bi);
+
+	dev_dbg(rtd->dev, "%s desired rate %lu, %d\n", __func__, rate, bi);
 
 	clk = (fs_mode == S3C2410_IISMOD_384FS ? 384 : 256) * rate;
-	pr_debug("%s will use: %s %s %d sysclk %d err %ld\n", __func__,
-		 fs_mode == S3C2410_IISMOD_384FS ? "384FS" : "256FS",
-		 clk_source == S3C24XX_CLKSRC_MPLL ? "MPLLin" : "PCLK",
-		 div, clk, err);
+
+	dev_dbg(rtd->dev, "%s will use: %s %s %d sysclk %d err %ld\n", __func__,
+		fs_mode == S3C2410_IISMOD_384FS ? "384FS" : "256FS",
+		clk_source == S3C24XX_CLKSRC_MPLL ? "MPLLin" : "PCLK",
+		div, clk, err);
 
 	if ((err * 100 / rate) > 5) {
-		printk(KERN_ERR "S3C24XX_UDA134X: effective frequency "
-		       "too different from desired (%ld%%)\n",
-		       err * 100 / rate);
+		dev_err(rtd->dev, "effective frequency too different "
+				  "from desired (%ld%%)\n", err * 100 / rate);
 		return -EINVAL;
 	}
 
-- 
1.9.1
