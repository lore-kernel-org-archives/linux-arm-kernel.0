From: codekipper@gmail.com (codekipper at gmail.com)
Date: Thu, 24 Sep 2015 16:30:05 +0200
Subject: [linux-sunxi][alsa-devel][PATCH 3/3] ASOC: sunxi: Add support for the
 spdif block
Message-ID: <1443105005-4083-1-git-send-email-codekipper@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcus Cooper <codekipper@gmail.com>

The sun4i, sun6i and sun7i SoC families have an SPDIF
block which is capable of playback and capture.

This patch enables the playback of this block for
the sun4i and sun7i families.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
---
 sound/soc/sunxi/Kconfig               |  10 +
 sound/soc/sunxi/Makefile              |   4 +
 sound/soc/sunxi/sunxi-machine-spdif.c | 110 +++++
 sound/soc/sunxi/sunxi-spdif.c         | 801 ++++++++++++++++++++++++++++++++++
 4 files changed, 925 insertions(+)
 create mode 100644 sound/soc/sunxi/sunxi-machine-spdif.c
 create mode 100644 sound/soc/sunxi/sunxi-spdif.c

diff --git a/sound/soc/sunxi/Kconfig b/sound/soc/sunxi/Kconfig
index 84c72ec..053db02 100644
--- a/sound/soc/sunxi/Kconfig
+++ b/sound/soc/sunxi/Kconfig
@@ -8,4 +8,14 @@ config SND_SUN4I_CODEC
 	  Select Y or M to add support for the Codec embedded in the Allwinner
 	  A10 and affiliated SoCs.
 
+config SND_SOC_SUNXI_DAI_SPDIF
+        tristate
+        select SND_SOC_GENERIC_DMAENGINE_PCM
+        select REGMAP_MMIO
+
+config SND_SOC_SUNXI_MACHINE_SPDIF
+        tristate "APB on-chip sun4i/sun5i/sun7i SPDIF"
+        select SND_SOC_SUNXI_DAI_SPDIF
+        help
+          Say Y if you want to add support for SoC S/PDIF audio as simple audio card.
 endmenu
diff --git a/sound/soc/sunxi/Makefile b/sound/soc/sunxi/Makefile
index ea8a08c..7849a75 100644
--- a/sound/soc/sunxi/Makefile
+++ b/sound/soc/sunxi/Makefile
@@ -1,2 +1,6 @@
 obj-$(CONFIG_SND_SUN4I_CODEC) += sun4i-codec.o
 
+snd-soc-sunxi-dai-spdif-objs := sunxi-spdif.o
+obj-$(CONFIG_SND_SOC_SUNXI_DAI_SPDIF) += snd-soc-sunxi-dai-spdif.o
+snd-soc-sunxi-machine-spdif-objs := sunxi-machine-spdif.o
+obj-$(CONFIG_SND_SOC_SUNXI_MACHINE_SPDIF) += snd-soc-sunxi-machine-spdif.o
diff --git a/sound/soc/sunxi/sunxi-machine-spdif.c b/sound/soc/sunxi/sunxi-machine-spdif.c
new file mode 100644
index 0000000..f8f6bd8
--- /dev/null
+++ b/sound/soc/sunxi/sunxi-machine-spdif.c
@@ -0,0 +1,110 @@
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
+#ifdef CONFIG_OF
+static const struct of_device_id sunxi_machine_spdif_dt_ids[] = {
+	{ .compatible = "allwinner,sunxi-audio-spdif", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, sunxi_machine_spdif_dt_ids);
+#endif
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
diff --git a/sound/soc/sunxi/sunxi-spdif.c b/sound/soc/sunxi/sunxi-spdif.c
new file mode 100644
index 0000000..cae9261
--- /dev/null
+++ b/sound/soc/sunxi/sunxi-spdif.c
@@ -0,0 +1,801 @@
+/*
+ * ALSA SoC SPDIF Audio Layer
+ *
+ * Copyright 2015 Andrea Venturi <be17068@iperbole.bo.it>
+ * Copyright 2015 Marcus Cooper <codekipper@gmail.com>
+ *
+ * Based on the Allwinner SDK driver, released under the GPL.
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
+/*
+ * this is SPDIF sunxi simple audio card DAI driver that uses the codec
+ * "dummy driver" as per sound/soc/fsl/imx-spdif.c
+ */
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/regmap.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/ioport.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <sound/dmaengine_pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+
+#define	SUNXI_SPDIF_CTL		(0x00)
+	#define SUNXI_SPDIF_CTL_MCLKDIV(v)		((v) << 4) /* v even */
+	#define SUNXI_SPDIF_CTL_MCLKOUTEN		BIT(2)
+	#define SUNXI_SPDIF_CTL_GEN			BIT(1)
+	#define SUNXI_SPDIF_CTL_RESET			BIT(0)
+
+#define SUNXI_SPDIF_TXCFG	(0x04)
+	#define SUNXI_SPDIF_TXCFG_SINGLEMOD		BIT(31)
+	#define SUNXI_SPDIF_TXCFG_ASS			BIT(17)
+	#define SUNXI_SPDIF_TXCFG_NONAUDIO		BIT(16)
+	#define SUNXI_SPDIF_TXCFG_TXRATIO(v)		((v) << 4)
+	#define SUNXI_SPDIF_TXCFG_TXRATIO_MASK		GENMASK(8, 4)
+	#define SUNXI_SPDIF_TXCFG_FMTRVD		GENMASK(3, 2)
+	#define SUNXI_SPDIF_TXCFG_FMT16BIT		(0 << 2)
+	#define SUNXI_SPDIF_TXCFG_FMT20BIT		(1 << 2)
+	#define SUNXI_SPDIF_TXCFG_FMT24BIT		(2 << 2)
+	#define SUNXI_SPDIF_TXCFG_CHSTMODE		BIT(1)
+	#define SUNXI_SPDIF_TXCFG_TXEN			BIT(0)
+
+#define SUNXI_SPDIF_RXCFG	(0x08)
+	#define SUNXI_SPDIF_RXCFG_LOCKFLAG		BIT(4)
+	#define SUNXI_SPDIF_RXCFG_CHSTSRC		BIT(3)
+	#define SUNXI_SPDIF_RXCFG_CHSTCP		BIT(1)
+	#define SUNXI_SPDIF_RXCFG_RXEN			BIT(0)
+
+#define SUNXI_SPDIF_TXFIFO	(0x0C)
+
+#define SUNXI_SPDIF_RXFIFO	(0x10)
+
+#define SUNXI_SPDIF_FCTL	(0x14)
+	#define SUNXI_SPDIF_FCTL_FIFOSRC		BIT(31)
+	#define SUNXI_SPDIF_FCTL_FTX			BIT(17)
+	#define SUNXI_SPDIF_FCTL_FRX			BIT(16)
+	#define SUNXI_SPDIF_FCTL_TXTL(v)		((v) << 8)
+	#define SUNXI_SPDIF_FCTL_TXTL_MASK		GENMASK(12, 8)
+	#define SUNXI_SPDIF_FCTL_RXTL(v)		((v) << 3)
+	#define SUNXI_SPDIF_FCTL_RXTL_MASK		GENMASK(7, 3)
+	#define SUNXI_SPDIF_FCTL_TXIM			BIT(2)
+	#define SUNXI_SPDIF_FCTL_RXOM(v)		((v) << 0)
+	#define SUNXI_SPDIF_FCTL_RXOM_MASK		GENMASK(1, 0)
+
+#define SUNXI_SPDIF_FSTA	(0x18)
+	#define SUNXI_SPDIF_FSTA_TXE			BIT(14)
+	#define SUNXI_SPDIF_FSTA_TXECNTSHT		(8)
+	#define SUNXI_SPDIF_FSTA_RXA			BIT(6)
+	#define SUNXI_SPDIF_FSTA_RXACNTSHT		(0)
+
+#define SUNXI_SPDIF_INT		(0x1C)
+	#define SUNXI_SPDIF_INT_RXLOCKEN		BIT(18)
+	#define SUNXI_SPDIF_INT_RXUNLOCKEN		BIT(17)
+	#define SUNXI_SPDIF_INT_RXPARERREN		BIT(16)
+	#define SUNXI_SPDIF_INT_TXDRQEN			BIT(7)
+	#define SUNXI_SPDIF_INT_TXUIEN			BIT(6)
+	#define SUNXI_SPDIF_INT_TXOIEN			BIT(5)
+	#define SUNXI_SPDIF_INT_TXEIEN			BIT(4)
+	#define SUNXI_SPDIF_INT_RXDRQEN			BIT(2)
+	#define SUNXI_SPDIF_INT_RXOIEN			BIT(1)
+	#define SUNXI_SPDIF_INT_RXAIEN			BIT(0)
+
+#define SUNXI_SPDIF_ISTA	(0x20)
+	#define SUNXI_SPDIF_ISTA_RXLOCKSTA		BIT(18)
+	#define SUNXI_SPDIF_ISTA_RXUNLOCKSTA		BIT(17)
+	#define SUNXI_SPDIF_ISTA_RXPARERRSTA		BIT(16)
+	#define SUNXI_SPDIF_ISTA_TXUSTA			BIT(6)
+	#define SUNXI_SPDIF_ISTA_TXOSTA			BIT(5)
+	#define SUNXI_SPDIF_ISTA_TXESTA			BIT(4)
+	#define SUNXI_SPDIF_ISTA_RXOSTA			BIT(1)
+	#define SUNXI_SPDIF_ISTA_RXASTA			BIT(0)
+
+#define SUNXI_SPDIF_TXCNT	(0x24)
+
+#define SUNXI_SPDIF_RXCNT	(0x28)
+
+#define SUNXI_SPDIF_TXCHSTA0	(0x2C)
+	#define SUNXI_SPDIF_TXCHSTA0_CLK(v)		((v) << 28)
+	#define SUNXI_SPDIF_TXCHSTA0_SAMFREQ(v)		((v) << 24)
+	#define SUNXI_SPDIF_TXCHSTA0_SAMFREQ_MASK	GENMASK(27, 24)
+	#define SUNXI_SPDIF_TXCHSTA0_CHNUM(v)		((v) << 20)
+	#define SUNXI_SPDIF_TXCHSTA0_CHNUM_MASK		GENMASK(23, 20)
+	#define SUNXI_SPDIF_TXCHSTA0_SRCNUM(v)		((v) << 16)
+	#define SUNXI_SPDIF_TXCHSTA0_CATACOD(v)		((v) << 8)
+	#define SUNXI_SPDIF_TXCHSTA0_MODE(v)		((v) << 6)
+	#define SUNXI_SPDIF_TXCHSTA0_EMPHASIS(v)	((v) << 3)
+	#define SUNXI_SPDIF_TXCHSTA0_CP			BIT(2)
+	#define SUNXI_SPDIF_TXCHSTA0_AUDIO		BIT(1)
+	#define SUNXI_SPDIF_TXCHSTA0_PRO		BIT(0)
+
+#define SUNXI_SPDIF_TXCHSTA1	(0x30)
+	#define SUNXI_SPDIF_TXCHSTA1_CGMSA(v)		((v) << 8)
+	#define SUNXI_SPDIF_TXCHSTA1_ORISAMFREQ(v)	((v) << 4)
+	#define SUNXI_SPDIF_TXCHSTA1_ORISAMFREQ_MASK	GENMASK(7, 4)
+	#define SUNXI_SPDIF_TXCHSTA1_SAMWORDLEN(v)	((v) << 1)
+	#define SUNXI_SPDIF_TXCHSTA1_MAXWORDLEN		BIT(0)
+
+#define SUNXI_SPDIF_RXCHSTA0	(0x34)
+	#define SUNXI_SPDIF_RXCHSTA0_CLK(v)		((v) << 28)
+	#define SUNXI_SPDIF_RXCHSTA0_SAMFREQ(v)		((v) << 24)
+	#define SUNXI_SPDIF_RXCHSTA0_CHNUM(v)		((v) << 20)
+	#define SUNXI_SPDIF_RXCHSTA0_SRCNUM(v)		((v) << 16)
+	#define SUNXI_SPDIF_RXCHSTA0_CATACOD(v)		((v) << 8)
+	#define SUNXI_SPDIF_RXCHSTA0_MODE(v)		((v) << 6)
+	#define SUNXI_SPDIF_RXCHSTA0_EMPHASIS(v)	((v) << 3)
+	#define SUNXI_SPDIF_RXCHSTA0_CP			BIT(2)
+	#define SUNXI_SPDIF_RXCHSTA0_AUDIO		BIT(1)
+	#define SUNXI_SPDIF_RXCHSTA0_PRO		BIT(0)
+
+#define SUNXI_SPDIF_RXCHSTA1	(0x38)
+	#define SUNXI_SPDIF_RXCHSTA1_CGMSA(v)		((v) << 8)
+	#define SUNXI_SPDIF_RXCHSTA1_ORISAMFREQ(v)	((v) << 4)
+	#define SUNXI_SPDIF_RXCHSTA1_SAMWORDLEN(v)	((v) << 1)
+	#define SUNXI_SPDIF_RXCHSTA1_MAXWORDLEN		BIT(0)
+
+/* Defines for Sampling Frequency */
+enum sunxi_spdif_sampling_freq {
+	SUNXI_SPDIF_SAMFREQ_44_1KHZ		= 0x0,
+	SUNXI_SPDIF_SAMFREQ_NOT_INDICATED	= 0x1,
+	SUNXI_SPDIF_SAMFREQ_48KHZ		= 0x2,
+	SUNXI_SPDIF_SAMFREQ_32KHZ		= 0x3,
+	SUNXI_SPDIF_SAMFREQ_22_05KHZ		= 0x4,
+	SUNXI_SPDIF_SAMFREQ_24KHZ		= 0x6,
+	SUNXI_SPDIF_SAMFREQ_88_2KHZ		= 0x8,
+	SUNXI_SPDIF_SAMFREQ_768KHZ		= 0x9,
+	SUNXI_SPDIF_SAMFREQ_96KHZ		= 0xa,
+	SUNXI_SPDIF_SAMFREQ_176_4KHZ		= 0xc,
+	SUNXI_SPDIF_SAMFREQ_192KHZ		= 0xe,
+};
+
+/*
+ * Original sampling frequency can be represented by inverting the value of the
+ * sampling frequency.
+ */
+#define ORIGINAL(v) ((~v) & 0xf)
+
+struct sunxi_spdif_dev {
+	struct platform_device *pdev;
+	struct clk *clk;
+	struct clk *apb_clk;
+	struct clk *audio_clk;
+	struct snd_soc_dai_driver cpu_dai_drv;
+	bool running;
+	struct regmap *regmap;
+	struct snd_dmaengine_dai_dma_data dma_params_tx;
+	struct snd_dmaengine_dai_dma_data dma_params_rx;
+	bool playback_supported;
+	bool capture_supported;
+};
+
+static void sunxi_spdif_configure(struct sunxi_spdif_dev *host)
+{
+	u32 reg_val;
+
+	/* soft reset SPDIF */
+	regmap_write(host->regmap, SUNXI_SPDIF_CTL, SUNXI_SPDIF_CTL_RESET);
+
+	/* MCLK OUTPUT enable */
+	regmap_update_bits(host->regmap, SUNXI_SPDIF_CTL,
+			SUNXI_SPDIF_CTL_MCLKOUTEN, SUNXI_SPDIF_CTL_MCLKOUTEN);
+
+	/* flush TX FIFO */
+	regmap_update_bits(host->regmap, SUNXI_SPDIF_FCTL, SUNXI_SPDIF_FCTL_FTX,
+							SUNXI_SPDIF_FCTL_FTX);
+
+	/* clear interrupt status */
+	regmap_read(host->regmap, SUNXI_SPDIF_ISTA, &reg_val);
+	regmap_write(host->regmap, SUNXI_SPDIF_ISTA, reg_val);
+
+	/* clear TX counter */
+	regmap_write(host->regmap, SUNXI_SPDIF_TXCNT, 0);
+
+}
+
+void sunxi_snd_txctrl(struct snd_pcm_substream *substream,
+					struct sunxi_spdif_dev *host, int on)
+{
+	u32 tmp;
+
+	regmap_read(host->regmap, SUNXI_SPDIF_TXCNT, &tmp);
+	if (substream->runtime->channels == 1)
+		regmap_update_bits(host->regmap, SUNXI_SPDIF_TXCFG,
+						SUNXI_SPDIF_TXCFG_SINGLEMOD,
+						SUNXI_SPDIF_TXCFG_SINGLEMOD);
+
+	if (on) {
+		/* SPDIF TX ENABLE */
+		regmap_update_bits(host->regmap, SUNXI_SPDIF_TXCFG,
+						SUNXI_SPDIF_TXCFG_TXEN,
+						SUNXI_SPDIF_TXCFG_TXEN);
+
+		/* DRQ ENABLE */
+		regmap_update_bits(host->regmap, SUNXI_SPDIF_INT,
+						SUNXI_SPDIF_INT_TXDRQEN,
+						SUNXI_SPDIF_INT_TXDRQEN);
+
+		/* Global enable */
+		regmap_update_bits(host->regmap, SUNXI_SPDIF_CTL,
+						SUNXI_SPDIF_CTL_GEN,
+						SUNXI_SPDIF_CTL_GEN);
+	} else {
+		/* SPDIF TX DISABLE */
+		regmap_update_bits(host->regmap, SUNXI_SPDIF_TXCFG,
+						SUNXI_SPDIF_TXCFG_TXEN, 0);
+
+		/* DRQ DISABLE */
+		regmap_update_bits(host->regmap, SUNXI_SPDIF_INT,
+						SUNXI_SPDIF_INT_TXDRQEN, 0);
+
+		/* Global disable */
+		regmap_update_bits(host->regmap, SUNXI_SPDIF_CTL,
+						SUNXI_SPDIF_CTL_GEN, 0);
+	}
+}
+
+static int sunxi_spdif_startup(struct snd_pcm_substream *substream,
+		struct snd_soc_dai *cpu_dai)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct sunxi_spdif_dev *host = snd_soc_dai_get_drvdata(rtd->cpu_dai);
+	int ret;
+
+	if (substream->stream != SNDRV_PCM_STREAM_PLAYBACK)
+		return -EINVAL;
+
+	/* Reset module and interrupts only for first initialization */
+	if (!cpu_dai->active) {
+		ret = clk_prepare_enable(host->clk);
+		if (ret)
+			return ret;
+	}
+
+	host->running = true;
+	sunxi_spdif_configure(host);
+
+	return 0;
+}
+
+static void sunxi_spdif_shutdown(struct snd_pcm_substream *substream,
+		struct snd_soc_dai *dai)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct sunxi_spdif_dev *host = snd_soc_dai_get_drvdata(rtd->cpu_dai);
+
+	if (substream->stream != SNDRV_PCM_STREAM_PLAYBACK)
+		return;
+
+	clk_disable_unprepare(host->clk);
+	host->running = false;
+}
+
+static int sunxi_spdif_set_fmt(struct snd_soc_dai *cpu_dai, unsigned int fmt)
+{
+	u32 reg_val;
+	struct sunxi_spdif_dev *host = snd_soc_dai_get_drvdata(cpu_dai);
+
+	reg_val = 0;
+	reg_val &= ~SUNXI_SPDIF_TXCFG_SINGLEMOD;
+	reg_val |= SUNXI_SPDIF_TXCFG_ASS;
+	reg_val |= fmt; /* set non audio and bit depth */
+	reg_val |= SUNXI_SPDIF_TXCFG_CHSTMODE;
+	regmap_write(host->regmap, SUNXI_SPDIF_TXCFG, reg_val);
+	reg_val = 0;
+	reg_val &= ~SUNXI_SPDIF_FCTL_FIFOSRC;
+	reg_val |= SUNXI_SPDIF_FCTL_TXTL_MASK;
+	reg_val |= SUNXI_SPDIF_FCTL_RXTL_MASK;
+	reg_val |= SUNXI_SPDIF_FCTL_TXIM;
+	reg_val |= SUNXI_SPDIF_FCTL_RXOM_MASK;
+	regmap_write(host->regmap, SUNXI_SPDIF_FCTL, reg_val);
+	reg_val = 0;
+	reg_val |= (SUNXI_SPDIF_TXCHSTA0_CHNUM(2));
+	regmap_write(host->regmap, SUNXI_SPDIF_TXCHSTA0, reg_val);
+
+	reg_val = 0;
+	reg_val |= (SUNXI_SPDIF_TXCHSTA1_SAMWORDLEN(1));
+	if ((fmt & SUNXI_SPDIF_TXCFG_FMT24BIT) == SUNXI_SPDIF_TXCFG_FMT24BIT)
+		reg_val |= SUNXI_SPDIF_TXCHSTA1_MAXWORDLEN;
+	regmap_write(host->regmap, SUNXI_SPDIF_TXCHSTA1, reg_val);
+	return 0;
+}
+
+static int sunxi_spdif_set_sysclk(struct snd_soc_dai *cpu_dai, unsigned int freq)
+{
+	struct sunxi_spdif_dev *host = snd_soc_dai_get_drvdata(cpu_dai);
+	struct platform_device *pdev = host->pdev;
+
+	if (clk_set_rate(host->audio_clk, freq))
+		dev_err(&pdev->dev,
+			"Setting pll2 clock rate for %d Hz failed!\n", freq);
+	if (clk_set_rate(host->clk, freq))
+		dev_err(&pdev->dev,
+			"Setting SPDIF clock rate for %d Hz failed!\n", freq);
+	return 0;
+}
+
+static int sunxi_spdif_set_clkdiv(struct snd_soc_dai *cpu_dai,
+						unsigned int rate, int div)
+{
+	struct sunxi_spdif_dev *host = snd_soc_dai_get_drvdata(cpu_dai);
+	int sample_freq, original_sample_freq;
+
+	regmap_update_bits(host->regmap, SUNXI_SPDIF_TXCHSTA0,
+				SUNXI_SPDIF_TXCHSTA0_SAMFREQ_MASK, 0);
+
+	regmap_update_bits(host->regmap, SUNXI_SPDIF_TXCHSTA1,
+				SUNXI_SPDIF_TXCHSTA1_ORISAMFREQ_MASK, 0);
+
+	regmap_update_bits(host->regmap, SUNXI_SPDIF_TXCFG,
+				SUNXI_SPDIF_TXCFG_TXRATIO_MASK,
+				SUNXI_SPDIF_TXCFG_TXRATIO(div - 1));
+
+	if (rate == 24576000) {
+		switch (div) {
+		/* 24KHZ */
+		case 8:
+			sample_freq = SUNXI_SPDIF_SAMFREQ_24KHZ;
+			original_sample_freq
+				= ORIGINAL(SUNXI_SPDIF_SAMFREQ_24KHZ);
+			break;
+
+		/* 32KHZ */
+		case 6:
+			sample_freq = SUNXI_SPDIF_SAMFREQ_32KHZ;
+			original_sample_freq
+				= ORIGINAL(SUNXI_SPDIF_SAMFREQ_32KHZ);
+			break;
+
+		/* 48KHZ */
+		case 4:
+			sample_freq = SUNXI_SPDIF_SAMFREQ_48KHZ;
+			original_sample_freq
+				= ORIGINAL(SUNXI_SPDIF_SAMFREQ_48KHZ);
+			break;
+
+		/* 96KHZ */
+		case 2:
+			sample_freq = SUNXI_SPDIF_SAMFREQ_96KHZ;
+			original_sample_freq
+				= ORIGINAL(SUNXI_SPDIF_SAMFREQ_96KHZ);
+			break;
+
+		/* 192KHZ */
+		case 1:
+			sample_freq = SUNXI_SPDIF_SAMFREQ_192KHZ;
+			original_sample_freq
+				= ORIGINAL(SUNXI_SPDIF_SAMFREQ_192KHZ);
+			break;
+
+		default:
+			sample_freq = SUNXI_SPDIF_SAMFREQ_NOT_INDICATED;
+			original_sample_freq = 0;
+			break;
+		}
+	} else {
+		/* 22.5792MHz */
+		switch (div) {
+		/* 22.05KHZ */
+		case 8:
+			sample_freq = SUNXI_SPDIF_SAMFREQ_22_05KHZ;
+			original_sample_freq
+				= ORIGINAL(SUNXI_SPDIF_SAMFREQ_22_05KHZ);
+			break;
+
+		/* 44.1KHZ */
+		case 4:
+			sample_freq = SUNXI_SPDIF_SAMFREQ_44_1KHZ;
+			original_sample_freq
+				= ORIGINAL(SUNXI_SPDIF_SAMFREQ_44_1KHZ);
+			break;
+
+		/* 88.2KHZ */
+		case 2:
+			sample_freq = SUNXI_SPDIF_SAMFREQ_88_2KHZ;
+			original_sample_freq
+				= ORIGINAL(SUNXI_SPDIF_SAMFREQ_88_2KHZ);
+			break;
+
+		/* 176.4KHZ */
+		case 1:
+			sample_freq = SUNXI_SPDIF_SAMFREQ_176_4KHZ;
+			original_sample_freq
+				= ORIGINAL(SUNXI_SPDIF_SAMFREQ_176_4KHZ);
+			break;
+
+		default:
+			sample_freq = SUNXI_SPDIF_SAMFREQ_NOT_INDICATED;
+			original_sample_freq = 0;
+			break;
+		}
+	}
+
+	regmap_update_bits(host->regmap, SUNXI_SPDIF_TXCHSTA0,
+			SUNXI_SPDIF_TXCHSTA0_SAMFREQ_MASK,
+			SUNXI_SPDIF_TXCHSTA0_SAMFREQ(sample_freq));
+
+	regmap_update_bits(host->regmap, SUNXI_SPDIF_TXCHSTA1,
+			SUNXI_SPDIF_TXCHSTA1_ORISAMFREQ_MASK,
+			SUNXI_SPDIF_TXCHSTA1_ORISAMFREQ(original_sample_freq));
+
+	return 0;
+}
+
+static int sunxi_spdif_hw_params(struct snd_pcm_substream *substream,
+					struct snd_pcm_hw_params *params,
+					struct snd_soc_dai *cpu_dai)
+{
+	int ret = 0;
+	int fmt;
+	unsigned long rate = params_rate(params);
+	u32 mclk_div = 0;
+	unsigned int mclk = 0;
+
+	/* Add the PCM and raw data select interface */
+	switch (params_channels(params)) {
+	case 1: /* PCM mode */
+	case 2:
+		fmt = 0;
+		break;
+	case 4: /* raw data mode */
+		fmt = SUNXI_SPDIF_TXCFG_NONAUDIO;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (params_format(params)) {
+	case SNDRV_PCM_FORMAT_S16_LE:
+		fmt |= SUNXI_SPDIF_TXCFG_FMT16BIT;
+		break;
+	case SNDRV_PCM_FORMAT_S20_3LE:
+		fmt |= SUNXI_SPDIF_TXCFG_FMT20BIT;
+		break;
+	case SNDRV_PCM_FORMAT_S24_LE:
+		fmt |= SUNXI_SPDIF_TXCFG_FMT24BIT;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret = snd_soc_dai_set_fmt(cpu_dai, fmt);
+	if (ret < 0)
+		return ret;
+
+	switch (rate) {
+	case 22050:
+	case 44100:
+	case 88200:
+	case 176400:
+		mclk = 22579200;
+		break;
+	case 24000:
+	case 32000:
+	case 48000:
+	case 96000:
+	case 192000:
+		mclk = 24576000;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret = sunxi_spdif_set_sysclk(cpu_dai, mclk);
+	if (ret < 0)
+		return ret;
+
+	switch (rate) {
+	case 22050:
+	case 24000:
+		mclk_div = 8;
+		break;
+	case 32000:
+		mclk_div = 6;
+		break;
+	case 44100:
+	case 48000:
+		mclk_div = 4;
+		break;
+	case 88200:
+	case 96000:
+		mclk_div = 2;
+		break;
+	case 176400:
+	case 192000:
+		mclk_div = 1;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret = sunxi_spdif_set_clkdiv(cpu_dai, mclk, mclk_div);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int sunxi_spdif_trigger(struct snd_pcm_substream *substream, int cmd,
+		struct snd_soc_dai *dai)
+{
+	int ret = 0;
+	struct sunxi_spdif_dev *host = snd_soc_dai_get_drvdata(dai);
+
+	if (substream->stream != SNDRV_PCM_STREAM_PLAYBACK)
+		return -EINVAL;
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_RESUME:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		sunxi_snd_txctrl(substream, host, 1);
+		break;
+
+	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		sunxi_snd_txctrl(substream, host, 0);
+		break;
+
+	default:
+		ret = -EINVAL;
+		break;
+	}
+	return ret;
+}
+
+static int sunxi_spdif_soc_dai_probe(struct snd_soc_dai *dai)
+{
+	struct sunxi_spdif_dev *host = snd_soc_dai_get_drvdata(dai);
+
+	snd_soc_dai_init_dma_data(dai, &host->dma_params_tx,
+						&host->dma_params_rx);
+	return 0;
+}
+
+static const struct snd_soc_dai_ops sunxi_spdif_dai_ops = {
+	.startup	= sunxi_spdif_startup,
+	.shutdown	= sunxi_spdif_shutdown,
+	.trigger	= sunxi_spdif_trigger,
+	.hw_params	= sunxi_spdif_hw_params,
+	.set_fmt	= sunxi_spdif_set_fmt,
+};
+
+static const struct regmap_config sunxi_spdif_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = SUNXI_SPDIF_RXCHSTA1,
+};
+
+#define SUNXI_RATES	(SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100 | \
+				SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_96000 | \
+				SNDRV_PCM_RATE_192000)
+#define SUNXI_FORMATS	(SNDRV_PCM_FORMAT_S16_LE | SNDRV_PCM_FORMAT_S20_3LE | \
+				SNDRV_PCM_FORMAT_S24_LE)
+
+static struct snd_soc_dai_driver sunxi_spdif_dai = {
+	.playback = {
+		.channels_min = 2,
+		.channels_max = 2,
+		.rates = SUNXI_RATES,
+		.formats = SUNXI_FORMATS,
+	},
+	.probe = sunxi_spdif_soc_dai_probe,
+	.ops = &sunxi_spdif_dai_ops,
+	.name = "spdif",
+};
+
+static const struct snd_soc_dapm_widget dit_widgets[] = {
+	SND_SOC_DAPM_OUTPUT("spdif-out"),
+};
+
+static const struct snd_soc_dapm_route dit_routes[] = {
+	{ "spdif-out", NULL, "Playback" },
+};
+
+#ifdef CONFIG_OF
+static const struct of_device_id sunxi_spdif_of_match[] = {
+	{ .compatible = "allwinner,sun4i-a10-spdif", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, sunxi_spdif_of_match);
+#endif
+
+static const struct snd_soc_component_driver sunxi_spdif_component = {
+	.name		= "sunxi-spdif",
+};
+
+static int sunxi_spdif_probe(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct sunxi_spdif_dev *host;
+	struct resource *res;
+	int ret;
+	const struct of_device_id *of_id;
+	void __iomem *base;
+
+	dev_dbg(&pdev->dev, "Entered %s\n", __func__);
+
+	if (!np)
+		return -ENODEV;
+
+	of_id = of_match_device(sunxi_spdif_of_match, &pdev->dev);
+	if (!of_id) {
+		dev_err(&pdev->dev, "No matched devices found.\n");
+		return -EINVAL;
+	}
+
+	host = devm_kzalloc(&pdev->dev, sizeof(*host), GFP_KERNEL);
+	if (!host)
+		return -ENOMEM;
+
+	host->pdev = pdev;
+
+	/* Initialize this copy of the CPU DAI driver structure */
+	memcpy(&host->cpu_dai_drv, &sunxi_spdif_dai, sizeof(sunxi_spdif_dai));
+	host->cpu_dai_drv.name = dev_name(&pdev->dev);
+
+	/* Get the addresses */
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	host->regmap = devm_regmap_init_mmio(&pdev->dev, base,
+						&sunxi_spdif_regmap_config);
+
+	/* Clocks */
+	host->apb_clk = devm_clk_get(&pdev->dev, "apb");
+	if (IS_ERR(host->apb_clk)) {
+		dev_err(&pdev->dev, "failed to get a apb clock.\n");
+		return PTR_ERR(host->apb_clk);
+	}
+
+	if (clk_prepare_enable(host->apb_clk)) {
+		dev_err(&pdev->dev, "try to enable apb_spdif_clk failed\n");
+		return -EINVAL;
+	}
+
+	host->audio_clk = devm_clk_get(&pdev->dev, "audio");
+	if (IS_ERR(host->audio_clk)) {
+		dev_err(&pdev->dev, "failed to get an audio clock.\n");
+		return PTR_ERR(host->audio_clk);
+	}
+
+	host->clk = devm_clk_get(&pdev->dev, "spdif");
+	if (IS_ERR(host->clk)) {
+		dev_err(&pdev->dev, "failed to get a spdif clock.\n");
+		return PTR_ERR(host->clk);
+	}
+
+	ret = clk_set_rate(host->audio_clk, 24576000);
+	if (ret) {
+		dev_err(&pdev->dev, "set spdif base clock failed!\n");
+		return ret;
+	}
+
+	if (clk_prepare_enable(host->audio_clk)) {
+		dev_err(&pdev->dev, "try to enable audio clk failed\n");
+		ret = -EINVAL;
+		goto exit_clkdisable_apb_clk;
+	}
+
+	host->playback_supported = false;
+	host->capture_supported = false;
+
+	if (of_property_read_bool(np, "spdif-out"))
+		host->playback_supported = true;
+
+	if (!host->playback_supported) {
+		dev_err(&pdev->dev, "no enabled S/PDIF DAI link\n");
+		goto exit_clkdisable_clk;
+	}
+
+	host->dma_params_tx.addr = res->start + SUNXI_SPDIF_TXFIFO;
+	host->dma_params_tx.maxburst = 4;
+	host->dma_params_tx.addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
+	host->dma_params_rx.addr = res->start + SUNXI_SPDIF_RXFIFO;
+	host->dma_params_rx.maxburst = 4;
+	host->dma_params_rx.addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
+
+	/* Register with ASoC */
+	dev_set_drvdata(&pdev->dev, host);
+
+	ret = devm_snd_soc_register_component(&pdev->dev,
+				&sunxi_spdif_component, &sunxi_spdif_dai, 1);
+	if (ret)
+		goto exit_clkdisable_clk;
+
+	ret = devm_snd_dmaengine_pcm_register(&pdev->dev, NULL, 0);
+	if (ret)
+		goto exit_clkdisable_clk;
+	return 0;
+
+exit_clkdisable_clk:
+	clk_disable_unprepare(host->clk);
+exit_clkdisable_apb_clk:
+	clk_disable_unprepare(host->apb_clk);
+	return ret;
+}
+
+static int sunxi_spdif_remove(struct platform_device *pdev)
+{
+	struct sunxi_spdif_dev *host = dev_get_drvdata(&pdev->dev);
+
+	snd_soc_unregister_platform(&pdev->dev);
+	snd_soc_unregister_component(&pdev->dev);
+
+	if (!IS_ERR(host->clk)) {
+		clk_disable_unprepare(host->clk);
+		clk_disable_unprepare(host->apb_clk);
+	}
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int sunxi_spdif_suspend(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct sunxi_spdif_dev *host = dev_get_drvdata(&pdev->dev);
+
+	if (host->running)
+		clk_disable(host->clk);
+
+	return 0;
+}
+
+static int sunxi_spdif_resume(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct sunxi_spdif_dev *host = dev_get_drvdata(&pdev->dev);
+
+	if (host->running) {
+		clk_enable(host->clk);
+		sunxi_spdif_configure(host);
+	}
+	return 0;
+}
+
+static SIMPLE_DEV_PM_OPS(spdif_dev_pm_ops, sunxi_spdif_suspend,
+						sunxi_spdif_resume);
+
+#define SPDIF_DEV_PM_OPS (&spdif_dev_pm_ops)
+#else
+#define SPDIF_DEV_PM_OPS NULL
+
+#endif
+
+static struct platform_driver sunxi_spdif_driver = {
+	.driver		= {
+		.name	= "sunxi-spdif",
+		.owner	= THIS_MODULE,
+		.pm	= SPDIF_DEV_PM_OPS,
+		.of_match_table = of_match_ptr(sunxi_spdif_of_match),
+	},
+	.probe		= sunxi_spdif_probe,
+	.remove		= sunxi_spdif_remove,
+};
+
+module_platform_driver(sunxi_spdif_driver);
+
+MODULE_AUTHOR("Marcus Cooper <codekipper@gmail.com>");
+MODULE_AUTHOR("Andrea Venturi <be17068@iperbole.bo.it>");
+MODULE_DESCRIPTION("Allwinner Sunxi SPDIF SoC Interface");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:sunxi-spdif");
-- 
1.9.1
