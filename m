From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 31 Jul 2012 14:38:56 +0100
Subject: [PATCH 02/19] ASoC: Ux500: Enable MOP500 driver for Device Tree
In-Reply-To: <1343741953-17828-1-git-send-email-lee.jones@linaro.org>
References: <1343741953-17828-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1343741953-17828-3-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here we ensure that the MOP500 audio driver will be probed during a
Device Tree boot. We also parse the sound node to link together the
codec, dma and the CPU-side Digital Audio Interface.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 sound/soc/ux500/mop500.c |   38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/sound/soc/ux500/mop500.c b/sound/soc/ux500/mop500.c
index 31c4d26..821f2a9 100644
--- a/sound/soc/ux500/mop500.c
+++ b/sound/soc/ux500/mop500.c
@@ -16,6 +16,7 @@
 #include <linux/module.h>
 #include <linux/io.h>
 #include <linux/spi/spi.h>
+#include <linux/of.h>
 
 #include <sound/soc.h>
 #include <sound/initval.h>
@@ -56,14 +57,45 @@ static struct snd_soc_card mop500_card = {
 	.num_links = ARRAY_SIZE(mop500_dai_links),
 };
 
+static int __devinit mop500_of_probe(struct platform_device *pdev,
+				struct device_node *np)
+{
+	struct device_node *codec_np, *msp_np[2];
+	int i;
+
+	msp_np[0] = of_parse_phandle(np, "stericsson,cpu-dai", 0);
+	msp_np[1] = of_parse_phandle(np, "stericsson,cpu-dai", 1);
+	codec_np  = of_parse_phandle(np, "stericsson,audio-codec", 0);
+
+	if (!(msp_np[0] && msp_np[1] && codec_np)) {
+		dev_err(&pdev->dev, "Phandle missing or invalid\n");
+		return -EINVAL;
+	}
+
+	for (i = 0; i < 2; i++) {
+		mop500_dai_links[i].cpu_of_node = msp_np[i];
+		mop500_dai_links[i].cpu_dai_name = NULL;
+		mop500_dai_links[i].codec_of_node = codec_np;
+		mop500_dai_links[i].codec_name = NULL;
+	}
+
+	return 0;
+}
 static int __devinit mop500_probe(struct platform_device *pdev)
 {
+	struct device_node *np = pdev->dev.of_node;
 	int ret;
 
 	pr_debug("%s: Enter.\n", __func__);
 
 	dev_dbg(&pdev->dev, "%s: Enter.\n", __func__);
 
+	if (np) {
+		ret = mop500_of_probe(pdev, np);
+		if (ret)
+			return ret;
+	}
+
 	mop500_card.dev = &pdev->dev;
 
 	dev_dbg(&pdev->dev, "%s: Card %s: Set platform drvdata.\n",
@@ -101,10 +133,16 @@ static int __devexit mop500_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id snd_soc_mop500_match[] = {
+	{ .compatible = "stericsson,snd-soc-mop500", },
+	{},
+};
+
 static struct platform_driver snd_soc_mop500_driver = {
 	.driver = {
 		.owner = THIS_MODULE,
 		.name = "snd-soc-mop500",
+		.of_match_table = snd_soc_mop500_match,
 	},
 	.probe = mop500_probe,
 	.remove = __devexit_p(mop500_remove),
-- 
1.7.9.5
