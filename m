From: richard.zhao@freescale.com (Richard Zhao)
Date: Fri, 27 Apr 2012 15:02:56 +0800
Subject: [PATCH 02/11] ASoC: imx-sgtl5000: add of_node_put when probe fail.
In-Reply-To: <1335510185-7906-1-git-send-email-richard.zhao@freescale.com>
References: <1335510185-7906-1-git-send-email-richard.zhao@freescale.com>
Message-ID: <1335510185-7906-3-git-send-email-richard.zhao@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
---
 sound/soc/fsl/imx-sgtl5000.c |   29 ++++++++++++++++++-----------
 1 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/sound/soc/fsl/imx-sgtl5000.c b/sound/soc/fsl/imx-sgtl5000.c
index e1a7441..73b935e 100644
--- a/sound/soc/fsl/imx-sgtl5000.c
+++ b/sound/soc/fsl/imx-sgtl5000.c
@@ -103,24 +103,28 @@ static int __devinit imx_sgtl5000_probe(struct platform_device *pdev)
 	codec_np = of_parse_phandle(pdev->dev.of_node, "audio-codec", 0);
 	if (!ssi_np || !codec_np) {
 		dev_err(&pdev->dev, "phandle missing or invalid\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto fail;
 	}
 
 	ssi_pdev = of_find_device_by_node(ssi_np);
 	if (!ssi_pdev) {
 		dev_err(&pdev->dev, "failed to find SSI platform device\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto fail;
 	}
 
 	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
-	if (!data)
-		return -ENOMEM;
+	if (!data) {
+		ret = -ENOMEM;
+		goto fail;
+	}
 
 	ret = of_property_read_u32(codec_np, "clock-frequency",
 				   &data->clk_frequency);
 	if (ret) {
 		dev_err(&pdev->dev, "clock-frequency missing or invalid\n");
-		return ret;
+		goto fail;
 	}
 
 	data->dai.name = "HiFi";
@@ -136,10 +140,10 @@ static int __devinit imx_sgtl5000_probe(struct platform_device *pdev)
 	data->card.dev = &pdev->dev;
 	ret = snd_soc_of_parse_card_name(&data->card, "model");
 	if (ret)
-		return ret;
+		goto fail;
 	ret = snd_soc_of_parse_audio_routing(&data->card, "audio-routing");
 	if (ret)
-		return ret;
+		goto fail;
 	data->card.num_links = 1;
 	data->card.dai_link = &data->dai;
 	data->card.dapm_widgets = imx_sgtl5000_dapm_widgets;
@@ -148,14 +152,17 @@ static int __devinit imx_sgtl5000_probe(struct platform_device *pdev)
 	ret = snd_soc_register_card(&data->card);
 	if (ret) {
 		dev_err(&pdev->dev, "snd_soc_register_card failed (%d)\n", ret);
-		return ret;
+		goto fail;
 	}
 
 	platform_set_drvdata(pdev, data);
-	of_node_put(ssi_np);
-	of_node_put(codec_np);
+fail:
+	if (ssi_np)
+		of_node_put(ssi_np);
+	if (codec_np)
+		of_node_put(codec_np);
 
-	return 0;
+	return ret;
 }
 
 static int __devexit imx_sgtl5000_remove(struct platform_device *pdev)
-- 
1.7.5.4
