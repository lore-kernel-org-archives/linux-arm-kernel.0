From: richard.zhao@freescale.com (Richard Zhao)
Date: Fri, 27 Apr 2012 15:02:57 +0800
Subject: [PATCH 03/11] ASoC: fsl: add sgtl5000 clock support for imx-sgtl5000
In-Reply-To: <1335510185-7906-1-git-send-email-richard.zhao@freescale.com>
References: <1335510185-7906-1-git-send-email-richard.zhao@freescale.com>
Message-ID: <1335510185-7906-4-git-send-email-richard.zhao@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Richard Zhao <richard.zhao@linaro.org>

It tries to clk_get the clock. And if it failed, it assumes the clock
by default enabled.

Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
---
 sound/soc/fsl/imx-sgtl5000.c |   40 ++++++++++++++++++++++++++++++++--------
 1 files changed, 32 insertions(+), 8 deletions(-)

diff --git a/sound/soc/fsl/imx-sgtl5000.c b/sound/soc/fsl/imx-sgtl5000.c
index 73b935e..3a729ca 100644
--- a/sound/soc/fsl/imx-sgtl5000.c
+++ b/sound/soc/fsl/imx-sgtl5000.c
@@ -13,6 +13,8 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
+#include <linux/of_i2c.h>
+#include <linux/clk.h>
 #include <sound/soc.h>
 
 #include "../codecs/sgtl5000.h"
@@ -25,6 +27,7 @@ struct imx_sgtl5000_data {
 	struct snd_soc_card card;
 	char codec_dai_name[DAI_NAME_SIZE];
 	char platform_name[DAI_NAME_SIZE];
+	struct clk *codec_clk;
 	unsigned int clk_frequency;
 };
 
@@ -58,6 +61,7 @@ static int __devinit imx_sgtl5000_probe(struct platform_device *pdev)
 	struct device_node *np = pdev->dev.of_node;
 	struct device_node *ssi_np, *codec_np;
 	struct platform_device *ssi_pdev;
+	struct i2c_client *codec_dev;
 	struct imx_sgtl5000_data *data;
 	int int_port, ext_port;
 	int ret;
@@ -113,6 +117,11 @@ static int __devinit imx_sgtl5000_probe(struct platform_device *pdev)
 		ret = -EINVAL;
 		goto fail;
 	}
+	codec_dev = of_find_i2c_device_by_node(codec_np);
+	if (!codec_dev) {
+		dev_err(&pdev->dev, "failed to find codec platform device\n");
+		return -EINVAL;
+	}
 
 	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
 	if (!data) {
@@ -120,11 +129,20 @@ static int __devinit imx_sgtl5000_probe(struct platform_device *pdev)
 		goto fail;
 	}
 
-	ret = of_property_read_u32(codec_np, "clock-frequency",
-				   &data->clk_frequency);
-	if (ret) {
-		dev_err(&pdev->dev, "clock-frequency missing or invalid\n");
-		goto fail;
+	data->codec_clk = clk_get(&codec_dev->dev, NULL);
+	if (IS_ERR(data->codec_clk)) {
+		/* assuming clock enabled by default */
+		data->codec_clk = NULL;
+		ret = of_property_read_u32(codec_np, "clock-frequency",
+					&data->clk_frequency);
+		if (ret) {
+			dev_err(&codec_dev->dev,
+				"clock-frequency missing or invalid\n");
+			goto fail;
+		}
+	} else {
+		data->clk_frequency = clk_get_rate(data->codec_clk);
+		clk_prepare_enable(data->codec_clk);
 	}
 
 	data->dai.name = "HiFi";
@@ -140,10 +158,10 @@ static int __devinit imx_sgtl5000_probe(struct platform_device *pdev)
 	data->card.dev = &pdev->dev;
 	ret = snd_soc_of_parse_card_name(&data->card, "model");
 	if (ret)
-		goto fail;
+		goto clk_fail;
 	ret = snd_soc_of_parse_audio_routing(&data->card, "audio-routing");
 	if (ret)
-		goto fail;
+		goto clk_fail;
 	data->card.num_links = 1;
 	data->card.dai_link = &data->dai;
 	data->card.dapm_widgets = imx_sgtl5000_dapm_widgets;
@@ -152,10 +170,12 @@ static int __devinit imx_sgtl5000_probe(struct platform_device *pdev)
 	ret = snd_soc_register_card(&data->card);
 	if (ret) {
 		dev_err(&pdev->dev, "snd_soc_register_card failed (%d)\n", ret);
-		goto fail;
+		goto clk_fail;
 	}
 
 	platform_set_drvdata(pdev, data);
+clk_fail:
+	clk_put(data->codec_clk);
 fail:
 	if (ssi_np)
 		of_node_put(ssi_np);
@@ -169,6 +189,10 @@ static int __devexit imx_sgtl5000_remove(struct platform_device *pdev)
 {
 	struct imx_sgtl5000_data *data = platform_get_drvdata(pdev);
 
+	if (data->codec_clk) {
+		clk_disable_unprepare(data->codec_clk);
+		clk_put(data->codec_clk);
+	}
 	snd_soc_unregister_card(&data->card);
 
 	return 0;
-- 
1.7.5.4
