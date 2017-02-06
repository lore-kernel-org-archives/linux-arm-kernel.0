From: baoyou.xie@linaro.org (Baoyou Xie)
Date: Mon,  6 Feb 2017 21:50:20 +0800
Subject: [PATCH v1 3/3] ASoC: zx-i2s: support zx296718 SoC for ZTE's i2s
 controller driver
In-Reply-To: <1486389020-29432-1-git-send-email-baoyou.xie@linaro.org>
References: <1486389020-29432-1-git-send-email-baoyou.xie@linaro.org>
Message-ID: <1486389020-29432-3-git-send-email-baoyou.xie@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds zx296718 SoC support for ZTE's i2s controller driver.

Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
---
 sound/soc/zte/zx-i2s.c | 49 ++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 40 insertions(+), 9 deletions(-)

diff --git a/sound/soc/zte/zx-i2s.c b/sound/soc/zte/zx-i2s.c
index ed7a56d..68d590be 100644
--- a/sound/soc/zte/zx-i2s.c
+++ b/sound/soc/zte/zx-i2s.c
@@ -95,12 +95,13 @@
 struct zx_i2s_info {
 	struct snd_dmaengine_dai_dma_data	dma_playback;
 	struct snd_dmaengine_dai_dma_data	dma_capture;
-	struct clk				*dai_clk;
+	struct clk				*dai_wclk, *dai_pclk;
 	void __iomem				*reg_base;
 	int					master;
 	resource_size_t				mapbase;
 };
 
+
 static void zx_i2s_tx_en(void __iomem *base, bool on)
 {
 	unsigned long val;
@@ -218,6 +219,17 @@ static int zx_i2s_set_fmt(struct snd_soc_dai *cpu_dai, unsigned int fmt)
 	return 0;
 }
 
+static void zx_i2s_set_clk(struct zx_i2s_info *i2s,
+			   unsigned int ch_num, unsigned int sample_rate)
+{
+	unsigned long val = sample_rate * ch_num * CLK_RAT;
+
+	clk_set_rate(i2s->dai_wclk, val);
+
+	if (i2s->dai_pclk)
+		clk_set_rate(i2s->dai_pclk, val);
+}
+
 static int zx_i2s_hw_params(struct snd_pcm_substream *substream,
 			    struct snd_pcm_hw_params *params,
 			    struct snd_soc_dai *socdai)
@@ -275,8 +287,8 @@ static int zx_i2s_hw_params(struct snd_pcm_substream *substream,
 	writel_relaxed(val, i2s->reg_base + ZX_I2S_TIMING_CTRL);
 
 	if (i2s->master)
-		ret = clk_set_rate(i2s->dai_clk,
-				   params_rate(params) * ch_num * CLK_RAT);
+		zx_i2s_set_clk(i2s, ch_num, params_rate(params));
+
 	return ret;
 }
 
@@ -328,8 +340,19 @@ static int zx_i2s_startup(struct snd_pcm_substream *substream,
 			  struct snd_soc_dai *dai)
 {
 	struct zx_i2s_info *zx_i2s = dev_get_drvdata(dai->dev);
+	int ret;
+
+	ret = clk_prepare_enable(zx_i2s->dai_wclk);
+	if (ret)
+		return ret;
 
-	return clk_prepare_enable(zx_i2s->dai_clk);
+	ret = clk_prepare_enable(zx_i2s->dai_pclk);
+	if (ret) {
+		clk_disable_unprepare(zx_i2s->dai_wclk);
+		return ret;
+	}
+
+	return ret;
 }
 
 static void zx_i2s_shutdown(struct snd_pcm_substream *substream,
@@ -337,7 +360,8 @@ static void zx_i2s_shutdown(struct snd_pcm_substream *substream,
 {
 	struct zx_i2s_info *zx_i2s = dev_get_drvdata(dai->dev);
 
-	clk_disable_unprepare(zx_i2s->dai_clk);
+	clk_disable_unprepare(zx_i2s->dai_wclk);
+	clk_disable_unprepare(zx_i2s->dai_pclk);
 }
 
 static struct snd_soc_dai_ops zx_i2s_dai_ops = {
@@ -381,10 +405,16 @@ static int zx_i2s_probe(struct platform_device *pdev)
 	if (!zx_i2s)
 		return -ENOMEM;
 
-	zx_i2s->dai_clk = devm_clk_get(&pdev->dev, "tx");
-	if (IS_ERR(zx_i2s->dai_clk)) {
-		dev_err(&pdev->dev, "Fail to get clk\n");
-		return PTR_ERR(zx_i2s->dai_clk);
+	zx_i2s->dai_wclk = devm_clk_get(&pdev->dev, "tx");
+	if (IS_ERR(zx_i2s->dai_wclk)) {
+		dev_err(&pdev->dev, "Fail to get wclk\n");
+		return PTR_ERR(zx_i2s->dai_wclk);
+	}
+
+	zx_i2s->dai_pclk = devm_clk_get(&pdev->dev, "pclk");
+	if (IS_ERR(zx_i2s->dai_pclk)) {
+		dev_info(&pdev->dev, "have no pclk\n");
+		zx_i2s->dai_pclk = NULL;
 	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -414,6 +444,7 @@ static int zx_i2s_probe(struct platform_device *pdev)
 
 static const struct of_device_id zx_i2s_dt_ids[] = {
 	{ .compatible = "zte,zx296702-i2s", },
+	{ .compatible = "zte,zx296718-i2s", },
 	{}
 };
 MODULE_DEVICE_TABLE(of, zx_i2s_dt_ids);
-- 
2.7.4
