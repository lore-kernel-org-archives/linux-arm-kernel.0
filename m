From: broonie@kernel.org (Mark Brown)
Date: Fri, 12 Aug 2016 13:29:43 +0100
Subject: Applied "ASoC: sunxi: compatibility for sun6i to SPDIF" to the asoc
 tree
In-Reply-To: <20160730142716.29377-3-codekipper@gmail.com>
Message-ID: <E1bYBap-0002gQ-6T@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: sunxi: compatibility for sun6i to SPDIF

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

>From 2f6963cb52bee440105f732b3411f18e38ed6e52 Mon Sep 17 00:00:00 2001
From: Marcus Cooper <codekipper@gmail.com>
Date: Sat, 30 Jul 2016 17:56:38 +0200
Subject: [PATCH] ASoC: sunxi: compatibility for sun6i to SPDIF

The A31 SoC uses the same SPDIF block as found in earlier SoCs, but its
reset is controlled via a separate reset controller.

The DMA also complains when the maxburst is set to 4 so it's been adjusted
to 8 which suites both the older and newer SoCs.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sunxi/sun4i-spdif.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sunxi/sun4i-spdif.c b/sound/soc/sunxi/sun4i-spdif.c
index 0b04fb02125c..88fbb3a1e660 100644
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
2.8.1
