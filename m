From: baoyou.xie@linaro.org (Baoyou Xie)
Date: Thu,  9 Feb 2017 11:12:58 +0800
Subject: [PATCH v4 3/3] ASoC: zx-i2s: introduce pclk for zx2967 family
In-Reply-To: <1486609978-18482-1-git-send-email-baoyou.xie@linaro.org>
References: <1486609978-18482-1-git-send-email-baoyou.xie@linaro.org>
Message-ID: <1486609978-18482-3-git-send-email-baoyou.xie@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pclk is necessary for zx2967 I2S controller. the driver
currently doesn't handle it. This is something we need to fix.

In turn, the driver supports zx296718's I2S controller.

By the way, this patch also change the clock name from tx to wclk
to make it clear.

Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
---
 sound/soc/zte/zx-i2s.c | 38 +++++++++++++++++++++++++++++---------
 1 file changed, 29 insertions(+), 9 deletions(-)

diff --git a/sound/soc/zte/zx-i2s.c b/sound/soc/zte/zx-i2s.c
index ed7a56d..a865f37 100644
--- a/sound/soc/zte/zx-i2s.c
+++ b/sound/soc/zte/zx-i2s.c
@@ -95,7 +95,8 @@
 struct zx_i2s_info {
 	struct snd_dmaengine_dai_dma_data	dma_playback;
 	struct snd_dmaengine_dai_dma_data	dma_capture;
-	struct clk				*dai_clk;
+	struct clk				*dai_wclk;
+	struct clk				*dai_pclk;
 	void __iomem				*reg_base;
 	int					master;
 	resource_size_t				mapbase;
@@ -275,8 +276,9 @@ static int zx_i2s_hw_params(struct snd_pcm_substream *substream,
 	writel_relaxed(val, i2s->reg_base + ZX_I2S_TIMING_CTRL);
 
 	if (i2s->master)
-		ret = clk_set_rate(i2s->dai_clk,
-				   params_rate(params) * ch_num * CLK_RAT);
+		ret = clk_set_rate(i2s->dai_wclk,
+				params_rate(params) * ch_num * CLK_RAT);
+
 	return ret;
 }
 
@@ -328,8 +330,19 @@ static int zx_i2s_startup(struct snd_pcm_substream *substream,
 			  struct snd_soc_dai *dai)
 {
 	struct zx_i2s_info *zx_i2s = dev_get_drvdata(dai->dev);
+	int ret;
+
+	ret = clk_prepare_enable(zx_i2s->dai_wclk);
+	if (ret)
+		return ret;
+
+	ret = clk_prepare_enable(zx_i2s->dai_pclk);
+	if (ret) {
+		clk_disable_unprepare(zx_i2s->dai_wclk);
+		return ret;
+	}
 
-	return clk_prepare_enable(zx_i2s->dai_clk);
+	return ret;
 }
 
 static void zx_i2s_shutdown(struct snd_pcm_substream *substream,
@@ -337,7 +350,8 @@ static void zx_i2s_shutdown(struct snd_pcm_substream *substream,
 {
 	struct zx_i2s_info *zx_i2s = dev_get_drvdata(dai->dev);
 
-	clk_disable_unprepare(zx_i2s->dai_clk);
+	clk_disable_unprepare(zx_i2s->dai_wclk);
+	clk_disable_unprepare(zx_i2s->dai_pclk);
 }
 
 static struct snd_soc_dai_ops zx_i2s_dai_ops = {
@@ -381,10 +395,16 @@ static int zx_i2s_probe(struct platform_device *pdev)
 	if (!zx_i2s)
 		return -ENOMEM;
 
-	zx_i2s->dai_clk = devm_clk_get(&pdev->dev, "tx");
-	if (IS_ERR(zx_i2s->dai_clk)) {
-		dev_err(&pdev->dev, "Fail to get clk\n");
-		return PTR_ERR(zx_i2s->dai_clk);
+	zx_i2s->dai_wclk = devm_clk_get(&pdev->dev, "wclk");
+	if (IS_ERR(zx_i2s->dai_wclk)) {
+		dev_err(&pdev->dev, "Fail to get wclk\n");
+		return PTR_ERR(zx_i2s->dai_wclk);
+	}
+
+	zx_i2s->dai_pclk = devm_clk_get(&pdev->dev, "pclk");
+	if (IS_ERR(zx_i2s->dai_pclk)) {
+		dev_err(&pdev->dev, "Fail to get pclk\n");
+		return PTR_ERR(zx_i2s->dai_pclk);
 	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-- 
2.7.4
