From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Wed, 14 Jan 2015 19:42:30 +0100
Subject: [PATCH V3 03/15] ASoC: samsung: i2s: Request memory region in driver
 probe()
In-Reply-To: <1421260962-16892-1-git-send-email-s.nawrocki@samsung.com>
References: <1421260962-16892-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <1421260962-16892-4-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The memory mapped registers region is common for both DAIs so request
it in the I2S platform device driver's probe for the platform device
corresponding to the primary DAI, rather than in the ASoC DAI's probe
callback. While at it switch to devm_ioremap_resource(). This also
drops the hard coded (0x100) register region size in the driver.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 sound/soc/samsung/i2s.c |   45 +++++++--------------------------------------
 1 file changed, 7 insertions(+), 38 deletions(-)

diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index aa52b41..366b720 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -59,10 +59,8 @@ struct samsung_i2s_dai_data {
 struct i2s_dai {
 	/* Platform device for this DAI */
 	struct platform_device *pdev;
-	/* IOREMAP'd SFRs */
+	/* Memory mapped SFR region */
 	void __iomem	*addr;
-	/* Physical base address of SFRs */
-	u32	base;
 	/* Rate of RCLK source clock */
 	unsigned long rclk_srcrate;
 	/* Frame Clock */
@@ -979,16 +977,9 @@ static int samsung_i2s_dai_probe(struct snd_soc_dai *dai)
 		goto probe_exit;
 	}
 
-	i2s->addr = ioremap(i2s->base, 0x100);
-	if (i2s->addr == NULL) {
-		dev_err(&i2s->pdev->dev, "cannot ioremap registers\n");
-		return -ENXIO;
-	}
-
 	i2s->clk = clk_get(&i2s->pdev->dev, "iis");
 	if (IS_ERR(i2s->clk)) {
 		dev_err(&i2s->pdev->dev, "failed to get i2s_clock\n");
-		iounmap(i2s->addr);
 		return PTR_ERR(i2s->clk);
 	}
 
@@ -1001,7 +992,6 @@ static int samsung_i2s_dai_probe(struct snd_soc_dai *dai)
 	samsung_asoc_init_dma_data(dai, &i2s->dma_playback, &i2s->dma_capture);
 
 	if (other) {
-		other->addr = i2s->addr;
 		other->clk = i2s->clk;
 	}
 
@@ -1043,8 +1033,6 @@ static int samsung_i2s_dai_remove(struct snd_soc_dai *dai)
 
 		clk_disable_unprepare(i2s->clk);
 		clk_put(i2s->clk);
-
-		iounmap(i2s->addr);
 	}
 
 	i2s->clk = NULL;
@@ -1162,7 +1150,6 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 	u32 regs_base, quirks = 0, idma_addr = 0;
 	struct device_node *np = pdev->dev.of_node;
 	const struct samsung_i2s_dai_data *i2s_dai_data;
-	int ret = 0;
 
 	/* Call during Seconday interface registration */
 	i2s_dai_data = samsung_i2s_get_driver_data(pdev);
@@ -1229,16 +1216,10 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		dev_err(&pdev->dev, "Unable to get I2S SFR address\n");
-		return -ENXIO;
-	}
+	pri_dai->addr = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(pri_dai->addr))
+		return PTR_ERR(pri_dai->addr);
 
-	if (!request_mem_region(res->start, resource_size(res),
-							"samsung-i2s")) {
-		dev_err(&pdev->dev, "Unable to request SFR region\n");
-		return -EBUSY;
-	}
 	regs_base = res->start;
 
 	pri_dai->dma_playback.dma_addr = regs_base + I2STXD;
@@ -1247,7 +1228,6 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 	pri_dai->dma_capture.ch_name = "rx";
 	pri_dai->dma_playback.dma_size = 4;
 	pri_dai->dma_capture.dma_size = 4;
-	pri_dai->base = regs_base;
 	pri_dai->quirks = quirks;
 	pri_dai->variant_regs = i2s_dai_data->i2s_variant_regs;
 
@@ -1258,8 +1238,7 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 		sec_dai = i2s_alloc_dai(pdev, true);
 		if (!sec_dai) {
 			dev_err(&pdev->dev, "Unable to alloc I2S_sec\n");
-			ret = -ENOMEM;
-			goto err;
+			return -ENOMEM;
 		}
 
 		sec_dai->variant_regs = pri_dai->variant_regs;
@@ -1273,7 +1252,7 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 		}
 
 		sec_dai->dma_playback.dma_size = 4;
-		sec_dai->base = regs_base;
+		sec_dai->addr = pri_dai->addr;
 		sec_dai->quirks = quirks;
 		sec_dai->idma_playback.dma_addr = idma_addr;
 		sec_dai->pri_dai = pri_dai;
@@ -1282,8 +1261,7 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 
 	if (i2s_pdata && i2s_pdata->cfg_gpio && i2s_pdata->cfg_gpio(pdev)) {
 		dev_err(&pdev->dev, "Unable to configure gpio\n");
-		ret = -EINVAL;
-		goto err;
+		return -EINVAL;
 	}
 
 	devm_snd_soc_register_component(&pri_dai->pdev->dev,
@@ -1297,17 +1275,11 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 		return ret;
 
 	return 0;
-err:
-	if (res)
-		release_mem_region(regs_base, resource_size(res));
-
-	return ret;
 }
 
 static int samsung_i2s_remove(struct platform_device *pdev)
 {
 	struct i2s_dai *i2s, *other;
-	struct resource *res;
 
 	i2s = dev_get_drvdata(&pdev->dev);
 	other = i2s->pri_dai ? : i2s->sec_dai;
@@ -1317,9 +1289,6 @@ static int samsung_i2s_remove(struct platform_device *pdev)
 		other->sec_dai = NULL;
 	} else {
 		pm_runtime_disable(&pdev->dev);
-		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-		if (res)
-			release_mem_region(res->start, resource_size(res));
 	}
 
 	i2s->pri_dai = NULL;
-- 
1.7.9.5
