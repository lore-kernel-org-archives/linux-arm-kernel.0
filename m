From: codekipper@gmail.com (codekipper at gmail.com)
Date: Sat, 30 Jul 2016 16:27:16 +0200
Subject: [PATCH 2/2] ASoC: sunxi: compatibility for sun6i to SPDIF
In-Reply-To: <20160730142716.29377-1-codekipper@gmail.com>
References: <20160730142716.29377-1-codekipper@gmail.com>
Message-ID: <20160730142716.29377-3-codekipper@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcus Cooper <codekipper@gmail.com>

The A31 SoC uses the same SPDIF block as found in earlier SoCs, but its
reset is controlled via a separate reset controller.

The DMA also complains when the maxburst is set to 4 so it's been adjusted
to 8 which suites both the older and newer SoCs.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
---
 sound/soc/sunxi/sun4i-spdif.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sunxi/sun4i-spdif.c b/sound/soc/sunxi/sun4i-spdif.c
index 0b04fb0..88fbb3a 100644
--- a/sound/soc/sunxi/sun4i-spdif.c
+++ b/sound/soc/sunxi/sun4i-spdif.c
@@ -29,6 +29,7 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/reset.h>
 #include <sound/dmaengine_pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
@@ -162,6 +163,7 @@ struct sun4i_spdif_dev {
 	struct platform_device *pdev;
 	struct clk *spdif_clk;
 	struct clk *apb_clk;
+	struct reset_control *rst;
 	struct snd_soc_dai_driver cpu_dai_drv;
 	struct regmap *regmap;
 	struct snd_dmaengine_dai_dma_data dma_params_tx;
@@ -411,6 +413,7 @@ static const struct snd_soc_dapm_route dit_routes[] = {
 
 static const struct of_device_id sun4i_spdif_of_match[] = {
 	{ .compatible = "allwinner,sun4i-a10-spdif", },
+	{ .compatible = "allwinner,sun6i-a31-spdif", },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, sun4i_spdif_of_match);
@@ -482,11 +485,23 @@ static int sun4i_spdif_probe(struct platform_device *pdev)
 	}
 
 	host->dma_params_tx.addr = res->start + SUN4I_SPDIF_TXFIFO;
-	host->dma_params_tx.maxburst = 4;
+	host->dma_params_tx.maxburst = 8;
 	host->dma_params_tx.addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
 
 	platform_set_drvdata(pdev, host);
 
+	if (of_device_is_compatible(pdev->dev.of_node,
+				    "allwinner,sun6i-a31-spdif")) {
+		host->rst = devm_reset_control_get_optional(&pdev->dev, NULL);
+		if (IS_ERR(host->rst) && PTR_ERR(host->rst) == -EPROBE_DEFER) {
+			ret = -EPROBE_DEFER;
+			dev_err(&pdev->dev, "Failed to get reset: %d\n", ret);
+			goto err_disable_apb_clk;
+		}
+		if (!IS_ERR(host->rst))
+			reset_control_deassert(host->rst);
+	}
+
 	ret = devm_snd_soc_register_component(&pdev->dev,
 				&sun4i_spdif_component, &sun4i_spdif_dai, 1);
 	if (ret)
-- 
2.9.2
