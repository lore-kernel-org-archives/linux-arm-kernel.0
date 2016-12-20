From: codekipper@gmail.com (codekipper at gmail.com)
Date: Tue, 20 Dec 2016 15:55:24 +0100
Subject: [PATCH] ASoC: sun4i-i2s: Add quirks for newer SoCs
Message-ID: <20161220145524.31047-1-codekipper@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcus Cooper <codekipper@gmail.com>

Newer SoCs have additional functionality so a quirks structure
has been added to handle them. So far we've seen the use of a
reset controller, a different address for the TXFIFO and varying
register changes.

This patch prepares the driver for these changes and adds the
reset specifier.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
---
 .../devicetree/bindings/sound/sun4i-i2s.txt        |  2 +
 sound/soc/sunxi/sun4i-i2s.c                        | 47 ++++++++++++++++++++--
 2 files changed, 45 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/sun4i-i2s.txt b/Documentation/devicetree/bindings/sound/sun4i-i2s.txt
index 7a2c0945fd22..494a881ccd21 100644
--- a/Documentation/devicetree/bindings/sound/sun4i-i2s.txt
+++ b/Documentation/devicetree/bindings/sound/sun4i-i2s.txt
@@ -18,6 +18,8 @@ Required properties:
    - "apb" : clock for the I2S bus interface
    - "mod" : module clock for the I2S controller
 - #sound-dai-cells : Must be equal to 0
+- resets: reset specifier for the ahb reset (A31 and newer only)
+
 
 Example:
 
diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index f24d19526603..80fe4f1d6e3b 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -14,9 +14,11 @@
 #include <linux/clk.h>
 #include <linux/dmaengine.h>
 #include <linux/module.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
+#include <linux/reset.h>
 
 #include <sound/dmaengine_pcm.h>
 #include <sound/pcm_params.h>
@@ -92,6 +94,7 @@ struct sun4i_i2s {
 	struct clk	*bus_clk;
 	struct clk	*mod_clk;
 	struct regmap	*regmap;
+	struct reset_control *rst;
 
 	unsigned int	mclk_freq;
 
@@ -104,6 +107,13 @@ struct sun4i_i2s_clk_div {
 	u8	val;
 };
 
+struct sun4i_i2s_quirks {
+	unsigned int	reg_dac_txdata;	/* TX FIFO offset for DMA config */
+	bool 		has_reset;
+	const struct regmap_config	*sun4i_i2s_regmap;
+	const struct snd_soc_dai_ops	*ops;
+};
+
 static const struct sun4i_i2s_clk_div sun4i_i2s_bclk_div[] = {
 	{ .div = 2, .val = 0 },
 	{ .div = 4, .val = 1 },
@@ -541,7 +551,6 @@ static struct snd_soc_dai_driver sun4i_i2s_dai = {
 		.rates = SNDRV_PCM_RATE_8000_192000,
 		.formats = SNDRV_PCM_FMTBIT_S16_LE,
 	},
-	.ops = &sun4i_i2s_dai_ops,
 	.symmetric_rates = 1,
 };
 
@@ -655,6 +664,7 @@ static int sun4i_i2s_probe(struct platform_device *pdev)
 {
 	struct sun4i_i2s *i2s;
 	struct resource *res;
+	const struct sun4i_i2s_quirks *quirks;
 	void __iomem *regs;
 	int irq, ret;
 
@@ -680,8 +690,14 @@ static int sun4i_i2s_probe(struct platform_device *pdev)
 		return PTR_ERR(i2s->bus_clk);
 	}
 
+	quirks = of_device_get_match_data(&pdev->dev);
+	if (quirks == NULL) {
+		dev_err(&pdev->dev, "Failed to determine the quirks to use\n");
+		return -ENODEV;
+	}
+
 	i2s->regmap = devm_regmap_init_mmio(&pdev->dev, regs,
-					    &sun4i_i2s_regmap_config);
+					    quirks->sun4i_i2s_regmap);
 	if (IS_ERR(i2s->regmap)) {
 		dev_err(&pdev->dev, "Regmap initialisation failed\n");
 		return PTR_ERR(i2s->regmap);
@@ -692,13 +708,25 @@ static int sun4i_i2s_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "Can't get our mod clock\n");
 		return PTR_ERR(i2s->mod_clk);
 	}
+
 	
-	i2s->playback_dma_data.addr = res->start + SUN4I_I2S_FIFO_TX_REG;
+	i2s->playback_dma_data.addr = res->start + quirks->reg_dac_txdata;
 	i2s->playback_dma_data.maxburst = 4;
 
 	i2s->capture_dma_data.addr = res->start + SUN4I_I2S_FIFO_RX_REG;
 	i2s->capture_dma_data.maxburst = 4;
 
+	if (quirks->has_reset) {
+		i2s->rst = devm_reset_control_get_optional(&pdev->dev, NULL);
+		if (IS_ERR(i2s->rst) && PTR_ERR(i2s->rst) == -EPROBE_DEFER) {
+			ret = -EPROBE_DEFER;
+			dev_err(&pdev->dev, "Failed to get reset: %d\n", ret);
+			goto err_pm_disable;
+		}
+		if (!IS_ERR(i2s->rst))
+			reset_control_deassert(i2s->rst);
+	}
+
 	pm_runtime_enable(&pdev->dev);
 	if (!pm_runtime_enabled(&pdev->dev)) {
 		ret = sun4i_i2s_runtime_resume(&pdev->dev);
@@ -706,6 +734,8 @@ static int sun4i_i2s_probe(struct platform_device *pdev)
 			goto err_pm_disable;
 	}
 
+	/* Register ops with dai */
+	sun4i_i2s_dai.ops = quirks->ops;
 	ret = devm_snd_soc_register_component(&pdev->dev,
 					      &sun4i_i2s_component,
 					      &sun4i_i2s_dai, 1);
@@ -742,8 +772,17 @@ static int sun4i_i2s_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct sun4i_i2s_quirks sun4i_a10_i2s_quirks = {
+	.reg_dac_txdata		= SUN4I_I2S_FIFO_TX_REG,
+	.sun4i_i2s_regmap	= &sun4i_i2s_regmap_config,
+	.ops			= &sun4i_i2s_dai_ops,
+};
+
 static const struct of_device_id sun4i_i2s_match[] = {
-	{ .compatible = "allwinner,sun4i-a10-i2s", },
+	{
+		.compatible = "allwinner,sun4i-a10-i2s",
+		.data = &sun4i_a10_i2s_quirks,
+	},
 	{}
 };
 MODULE_DEVICE_TABLE(of, sun4i_i2s_match);
-- 
2.11.0
