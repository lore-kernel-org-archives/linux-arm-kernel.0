From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Fri, 19 Dec 2014 14:55:26 +0100
Subject: [PATCH v2 06/16] ASoC: samsung: i2s: Move clk enable to the platform
 driver probe()
In-Reply-To: <1418997336-17777-1-git-send-email-s.nawrocki@samsung.com>
References: <1418997336-17777-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <1418997336-17777-7-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Gating the I2S bus clock in the driver's runtime PM callbacks has
currently really no effect since the clock is being enabled
in the DAI's probe() and thus is permanently turned on. Now we just
move the enable to the platform driver's probe(), which doesn't
change the situation much. It will allow us to register a clock
provider already in samsung_i2s_probe() function.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 sound/soc/samsung/i2s.c |   25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index 7f967b2..80b5362 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -969,7 +969,6 @@ static int samsung_i2s_dai_probe(struct snd_soc_dai *dai)
 {
 	struct i2s_dai *i2s = to_info(dai);
 	struct i2s_dai *other = i2s->pri_dai ? : i2s->sec_dai;
-	int ret;
 
 	if (is_secondary(i2s)) { /* If this is probe on the secondary DAI */
 		samsung_asoc_init_dma_data(dai, &other->sec_dai->dma_playback,
@@ -977,12 +976,6 @@ static int samsung_i2s_dai_probe(struct snd_soc_dai *dai)
 		goto probe_exit;
 	}
 
-	ret = clk_prepare_enable(i2s->clk);
-	if (ret != 0) {
-		dev_err(&i2s->pdev->dev, "failed to enable clock: %d\n", ret);
-		return ret;
-	}
-
 	samsung_asoc_init_dma_data(dai, &i2s->dma_playback, &i2s->dma_capture);
 
 	if (i2s->quirks & QUIRK_NEED_RSTCLR)
@@ -1014,18 +1007,12 @@ probe_exit:
 static int samsung_i2s_dai_remove(struct snd_soc_dai *dai)
 {
 	struct i2s_dai *i2s = snd_soc_dai_get_drvdata(dai);
-	struct i2s_dai *other = i2s->pri_dai ? : i2s->sec_dai;
-
-	if (!other || !other->clk) {
 
+	if (!is_secondary(i2s)) {
 		if (i2s->quirks & QUIRK_NEED_RSTCLR)
 			writel(0, i2s->addr + I2SCON);
-
-		clk_disable_unprepare(i2s->clk);
 	}
 
-	i2s->clk = NULL;
-
 	return 0;
 }
 
@@ -1139,6 +1126,7 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 	u32 regs_base, quirks = 0, idma_addr = 0;
 	struct device_node *np = pdev->dev.of_node;
 	const struct samsung_i2s_dai_data *i2s_dai_data;
+	int ret;
 
 	/* Call during Seconday interface registration */
 	i2s_dai_data = samsung_i2s_get_driver_data(pdev);
@@ -1216,6 +1204,12 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "Failed to get iis clock\n");
 		return PTR_ERR(pri_dai->clk);
 	}
+
+	ret = clk_prepare_enable(pri_dai->clk);
+	if (ret != 0) {
+		dev_err(&pdev->dev, "failed to enable clock: %d\n", ret);
+		return ret;
+	}
 	pri_dai->dma_playback.dma_addr = regs_base + I2STXD;
 	pri_dai->dma_capture.dma_addr = regs_base + I2SRXD;
 	pri_dai->dma_playback.ch_name = "tx";
@@ -1286,6 +1280,9 @@ static int samsung_i2s_remove(struct platform_device *pdev)
 		pm_runtime_disable(&pdev->dev);
 	}
 
+	if (!is_secondary(i2s))
+		clk_disable_unprepare(i2s->clk);
+
 	i2s->pri_dai = NULL;
 	i2s->sec_dai = NULL;
 
-- 
1.7.9.5
