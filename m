From: codekipper@gmail.com (codekipper at gmail.com)
Date: Wed, 30 Sep 2015 19:50:57 +0200
Subject: [PATCH v2 3/4] ASoC: sunxi: Add S/PDIF machine driver.
In-Reply-To: <1443635458-8873-1-git-send-email-codekipper@gmail.com>
References: <1443635458-8873-1-git-send-email-codekipper@gmail.com>
Message-ID: <1443635458-8873-4-git-send-email-codekipper@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcus Cooper <codekipper@gmail.com>

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
---
 sound/soc/sunxi/sunxi-machine-spdif.c | 108 ++++++++++++++++++++++++++++++++++
 1 file changed, 108 insertions(+)
 create mode 100644 sound/soc/sunxi/sunxi-machine-spdif.c

diff --git a/sound/soc/sunxi/sunxi-machine-spdif.c b/sound/soc/sunxi/sunxi-machine-spdif.c
new file mode 100644
index 0000000..2adb727
--- /dev/null
+++ b/sound/soc/sunxi/sunxi-machine-spdif.c
@@ -0,0 +1,108 @@
+/*
+ * Copyright (C) 2015 Andrea Venturi <be17068@iperbole.bo.it>
+ * From code by (C) 2013 Freescale Semiconductor, Inc.
+ * (sound/soc/fsl/imx-spdif.c)
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/module.h>
+#include <linux/of_platform.h>
+#include <sound/soc.h>
+
+struct sunxi_machine_spdif_data {
+	struct snd_soc_dai_link dai;
+	struct snd_soc_card card;
+};
+
+static int sunxi_machine_spdif_audio_probe(struct platform_device *pdev)
+{
+	struct device_node *spdif_np, *np = pdev->dev.of_node;
+	struct sunxi_machine_spdif_data *data;
+	int ret = 0;
+
+	dev_dbg(&pdev->dev, "%s: Looking for spdif-controller\n", __func__);
+	spdif_np = of_parse_phandle(np, "spdif-controller", 0);
+	if (!spdif_np) {
+		dev_err(&pdev->dev, "failed to find spdif-controller\n");
+		ret = -EINVAL;
+		goto end;
+	}
+
+	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
+	if (!data) {
+		ret = -ENOMEM;
+		goto end;
+	}
+
+	data->dai.name = "S/PDIF PCM";
+	data->dai.stream_name = "S/PDIF PCM";
+	data->dai.codec_dai_name = "snd-soc-dummy-dai";
+	data->dai.codec_name = "snd-soc-dummy";
+	data->dai.cpu_of_node = spdif_np;
+	data->dai.platform_of_node = spdif_np;
+	data->dai.playback_only = true;
+	data->dai.capture_only = true;
+
+	if (of_property_read_bool(np, "spdif-out"))
+		data->dai.capture_only = false;
+
+	if (of_property_read_bool(np, "spdif-in"))
+		data->dai.playback_only = false;
+
+	if (data->dai.playback_only && data->dai.capture_only) {
+		dev_err(&pdev->dev, "no enabled S/PDIF DAI link\n");
+		goto end;
+	}
+
+	data->card.dev = &pdev->dev;
+	data->card.dai_link = &data->dai;
+	data->card.num_links = 1;
+	data->card.owner = THIS_MODULE;
+
+	ret = snd_soc_of_parse_card_name(&data->card, "model");
+	if (ret)
+		goto end;
+
+	ret = devm_snd_soc_register_card(&pdev->dev, &data->card);
+	if (ret) {
+		dev_err(&pdev->dev, "snd_soc_register_card failed: %d\n", ret);
+		goto end;
+	}
+
+	platform_set_drvdata(pdev, data);
+
+end:
+	of_node_put(spdif_np);
+
+	return ret;
+}
+
+static const struct of_device_id sunxi_machine_spdif_dt_ids[] = {
+	{ .compatible = "allwinner,sunxi-audio-spdif", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, sunxi_machine_spdif_dt_ids);
+
+static struct platform_driver sunxi_machine_spdif_driver = {
+	.driver = {
+		.name = "sunxi-machine-spdif",
+		.of_match_table = sunxi_machine_spdif_dt_ids,
+	},
+	.probe = sunxi_machine_spdif_audio_probe,
+};
+
+module_platform_driver(sunxi_machine_spdif_driver);
+
+MODULE_AUTHOR("Marcus Cooper <codekipper@gmail.com>");
+MODULE_AUTHOR("Andrea Venturi, <be17068@iperbole.bo.it>");
+MODULE_DESCRIPTION("Allwinner sunxi S/PDIF machine driver");
+MODULE_LICENSE("GPL v2");
-- 
1.9.1
