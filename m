From: acgzxing@gmail.com (Xing Zheng)
Date: Tue, 12 May 2015 17:26:34 +0800
Subject: [PATCH 1/4] ASoC: rockchip: add rockchip machine driver
In-Reply-To: <1431422797-31903-1-git-send-email-zhengxing@rock-chips.com>
References: <1431422797-31903-1-git-send-email-zhengxing@rock-chips.com>
Message-ID: <1431422797-31903-2-git-send-email-zhengxing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: zhengxing <zhengxing@rock-chips.com>

In most cases, we maybe use simple-card as generic machine driver
on next kernel, but there are some issue that jack detection and
widgets extandable on simple-card.

Own machine drvier can select one valid codec from supported codecs,
and add needful function from dts on rockchip platform.

Signed-off-by: zhengxing <zhengxing@rock-chips.com>
---

 sound/soc/rockchip/Kconfig                   |    7 +
 sound/soc/rockchip/Makefile                  |    5 +
 sound/soc/rockchip/rockchip_machine_driver.c |  210 ++++++++++++++++++++++++++
 sound/soc/rockchip/rockchip_machine_driver.h |   30 ++++
 4 files changed, 252 insertions(+)
 create mode 100644 sound/soc/rockchip/rockchip_machine_driver.c
 create mode 100644 sound/soc/rockchip/rockchip_machine_driver.h

diff --git a/sound/soc/rockchip/Kconfig b/sound/soc/rockchip/Kconfig
index e181826..e3f51cf 100644
--- a/sound/soc/rockchip/Kconfig
+++ b/sound/soc/rockchip/Kconfig
@@ -14,3 +14,10 @@ config SND_SOC_ROCKCHIP_I2S
 	  Say Y or M if you want to add support for I2S driver for
 	  Rockchip I2S device. The device supports upto maximum of
 	  8 channels each for play and record.
+
+config SND_SOC_ROCKCHIP_MACHINE
+	tristate "Rockchip Generic Machine Driver"
+	depends on CLKDEV_LOOKUP && SND_SOC_ROCKCHIP
+	help
+	  Say Y or M if you want to add support for Machine driver
+	  for Rockchip I2S device.
diff --git a/sound/soc/rockchip/Makefile b/sound/soc/rockchip/Makefile
index b921909..47d7c84 100644
--- a/sound/soc/rockchip/Makefile
+++ b/sound/soc/rockchip/Makefile
@@ -2,3 +2,8 @@
 snd-soc-i2s-objs := rockchip_i2s.o
 
 obj-$(CONFIG_SND_SOC_ROCKCHIP_I2S) += snd-soc-i2s.o
+
+# ROCKCHIP Machine Support
+snd-soc-rockchip-machine-objs := rockchip_machine_driver.o
+
+obj-$(CONFIG_SND_SOC_ROCKCHIP_MACHINE) += snd-soc-rockchip-machine.o
diff --git a/sound/soc/rockchip/rockchip_machine_driver.c b/sound/soc/rockchip/rockchip_machine_driver.c
new file mode 100644
index 0000000..34cae3f
--- /dev/null
+++ b/sound/soc/rockchip/rockchip_machine_driver.c
@@ -0,0 +1,210 @@
+/*
+ * Rockchip machine ASoC driver for boards for multi-codecs.
+ *
+ * Copyright (c) 2015, ROCKCHIP CORPORATION.  All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/gpio.h>
+#include <linux/of_gpio.h>
+#include <linux/delay.h>
+#include <sound/core.h>
+#include <sound/jack.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+
+#include "rockchip_i2s.h"
+#include "rockchip_machine_driver.h"
+
+#define DRV_NAME "rockchip-snd-machine"
+
+/* the sound cards of rockchp supports. */
+static struct rk_snd_soc_cards rk_snd_cards[] = {
+};
+
+static int snd_rk_mc_preinit(void)
+{
+	int id, ret;
+
+	for (id = 0; id < ARRAY_SIZE(rk_snd_cards); ++id) {
+		struct rk_snd_soc_cards *rk_snd_card = &rk_snd_cards[id];
+
+		ret = rk_snd_card->preinit(rk_snd_card);
+		if (ret < 0)
+			pr_warn("card: %s preinit failed!\n",
+				rk_snd_card->name);
+	}
+
+	return 0;
+}
+
+static int snd_rk_mc_probe(struct platform_device *pdev)
+{
+	struct rk_mc_private *drv;
+	struct snd_soc_card *card;
+	struct device_node *parent = pdev->dev.of_node;
+	struct device_node *node;
+	int found = 0;
+	int ret;
+
+	/* pre-init sound cards that rockchip supports. */
+	snd_rk_mc_preinit();
+
+	drv = devm_kzalloc(&pdev->dev, sizeof(*drv), GFP_KERNEL);
+	if (!drv)
+		return -ENOMEM;
+
+	/* attach matched codec. */
+	for_each_available_child_of_node(parent, node) {
+		int id;
+
+		for (id = 0; id < ARRAY_SIZE(rk_snd_cards); ++id) {
+			struct rk_snd_soc_cards *rk_snd_card =
+					&rk_snd_cards[id];
+
+			ret = of_device_is_compatible(node,
+						      rk_snd_card->compatible);
+			if (ret) {
+				/* match compatible. */
+				card = rk_snd_card->card;
+				if (!card || !card->dai_link) {
+					dev_err(&pdev->dev,
+						"card or dai_link is null!\n");
+					continue;
+				}
+
+				card->dev = &pdev->dev;
+				platform_set_drvdata(pdev, card);
+				snd_soc_card_set_drvdata(card, drv);
+
+				/* set dai link node. */
+				card->dai_link->codec_of_node =
+					of_parse_phandle(node,
+							 "rockchip,audio-codec",
+							 0);
+				if (!card->dai_link->codec_of_node) {
+					dev_err(&pdev->dev,
+						"rockchip,audio-codec invalid\n");
+					continue;
+				}
+
+				card->dai_link->cpu_of_node =
+					of_parse_phandle(node,
+							 "rockchip,i2s-controller",
+							 0);
+				if (!card->dai_link->cpu_of_node) {
+					dev_err(&pdev->dev,
+						"rockchip,i2s-controller invalid\n");
+					continue;
+				}
+
+				if (card->aux_dev) {
+					/* set aux_dev for max98090. */
+					card->aux_dev->codec_of_node =
+						of_parse_phandle(node,
+								 "rockchip,headset-codec",
+								 0);
+					if (!card->aux_dev->codec_of_node) {
+						dev_err(&pdev->dev,
+							"rockchip,headset-codec invalid\n");
+						continue;
+					}
+				}
+
+				card->dai_link->platform_of_node =
+					card->dai_link->cpu_of_node;
+
+				ret = snd_soc_of_parse_card_name(card,
+								 "rockchip,model");
+				if (ret)
+					continue;
+
+				/* register the soc card. */
+				ret = snd_soc_register_card(card);
+				if (!ret) {
+					/*
+					 * register sound card ok,
+					 * and found matched codec.
+					 */
+					dev_info(&pdev->dev,
+						 "card:[%s] register success!\n",
+						 card->name);
+
+					found = 1;
+					goto found_codec;
+				} else {
+					/* register sound card failed */
+					dev_err(&pdev->dev,
+						"card:[%s] register failed(%d)!\n",
+						card->name, ret);
+
+					card->dev = NULL;
+				}
+			}
+		}
+	}
+
+	if (!found) {
+		dev_err(&pdev->dev,
+			"Not found matched codec!\n");
+		return -ENODEV;
+	}
+
+found_codec:
+	dev_info(&pdev->dev,
+		 "Found matched codec: %s!\n",
+		 card->name);
+
+	return 0;
+}
+
+static int snd_rk_mc_remove(struct platform_device *pdev)
+{
+	struct snd_soc_card *card = platform_get_drvdata(pdev);
+
+	snd_soc_card_set_drvdata(card, NULL);
+	snd_soc_unregister_card(card);
+	platform_set_drvdata(pdev, NULL);
+
+	return 0;
+}
+
+static const struct of_device_id rockchip_machine_of_match[] = {
+	{ .compatible = "rockchip,rockchip-audio-machine", },
+	{},
+};
+
+static struct platform_driver snd_rk_mc_driver = {
+	.probe = snd_rk_mc_probe,
+	.remove = snd_rk_mc_remove,
+	.driver = {
+		.name = DRV_NAME,
+		.owner = THIS_MODULE,
+		.pm = &snd_soc_pm_ops,
+		.of_match_table = rockchip_machine_of_match,
+	},
+};
+
+module_platform_driver(snd_rk_mc_driver);
+
+MODULE_AUTHOR("Xing Zheng <zhengxing@rock-chips.com>");
+MODULE_DESCRIPTION("Rockchip general machine ASoC driver");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:" DRV_NAME);
+MODULE_DEVICE_TABLE(of, rockchip_machine_of_match);
diff --git a/sound/soc/rockchip/rockchip_machine_driver.h b/sound/soc/rockchip/rockchip_machine_driver.h
new file mode 100644
index 0000000..39a7a77
--- /dev/null
+++ b/sound/soc/rockchip/rockchip_machine_driver.h
@@ -0,0 +1,30 @@
+/*
+ * sound/soc/rockchip/rockchip_machine_driver.h
+ *
+ * ALSA SoC Audio Layer - Rockchip Machine driver
+ *
+ * Copyright (c) 2015 Rockchip Electronics Co. Ltd.
+ * Author: Xing Zheng <zhengxing@rock-chips.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __ROCKCHIP_MACHINE_DRIVER_H__
+#define __ROCKCHIP_MACHINE_DRIVER_H__
+
+struct rk_mc_private {
+	struct snd_soc_jack headphone_jack;
+	struct snd_soc_jack mic_jack;
+	struct snd_soc_jack btn_jack;
+};
+
+struct rk_snd_soc_cards {
+	char name[32];
+	char compatible[128];
+	struct snd_soc_card *card;
+	int (*preinit)(struct rk_snd_soc_cards *soc_card);
+};
+
+#endif /* __ROCKCHIP_MACHINE_DRIVER_H__ */
-- 
1.7.9.5
