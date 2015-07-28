From: sjoerd.simons@collabora.co.uk (Sjoerd Simons)
Date: Tue, 28 Jul 2015 14:03:29 +0200
Subject: [PATCH 2/4] ASoc: rockchip: Add rockchip SPDIF transceiver driver
In-Reply-To: <1438085011-16577-1-git-send-email-sjoerd.simons@collabora.co.uk>
References: <1438085011-16577-1-git-send-email-sjoerd.simons@collabora.co.uk>
Message-ID: <1438085011-16577-3-git-send-email-sjoerd.simons@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a driver for the SDPIF transceiver available on RK3066, RK3188 and
RK3288. Heavily based on the rockchip i2s driver.

Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
---
 sound/soc/rockchip/Kconfig          |   9 +
 sound/soc/rockchip/Makefile         |   3 +
 sound/soc/rockchip/rockchip_spdif.c | 375 ++++++++++++++++++++++++++++++++++++
 sound/soc/rockchip/rockchip_spdif.h |  63 ++++++
 4 files changed, 450 insertions(+)
 create mode 100644 sound/soc/rockchip/rockchip_spdif.c
 create mode 100644 sound/soc/rockchip/rockchip_spdif.h

diff --git a/sound/soc/rockchip/Kconfig b/sound/soc/rockchip/Kconfig
index 58bae8e..20bc676 100644
--- a/sound/soc/rockchip/Kconfig
+++ b/sound/soc/rockchip/Kconfig
@@ -15,6 +15,14 @@ config SND_SOC_ROCKCHIP_I2S
 	  Rockchip I2S device. The device supports upto maximum of
 	  8 channels each for play and record.
 
+config SND_SOC_ROCKCHIP_SPDIF
+	tristate "Rockchip SPDIF Device Driver"
+	depends on CLKDEV_LOOKUP && SND_SOC_ROCKCHIP
+	select SND_SOC_GENERIC_DMAENGINE_PCM
+	help
+	  Say Y or M if you want to add support for SPDIF driver for
+	  Rockchip SPDIF transceiver device.
+
 config SND_SOC_ROCKCHIP_MAX98090
 	tristate "ASoC support for Rockchip boards using a MAX98090 codec"
 	depends on SND_SOC_ROCKCHIP && I2C && GPIOLIB
@@ -33,3 +41,4 @@ config SND_SOC_ROCKCHIP_RT5645
 	help
 	  Say Y or M here if you want to add support for SoC audio on Rockchip
 	  boards using the RT5645/RT5650 codec, such as Veyron.
+
diff --git a/sound/soc/rockchip/Makefile b/sound/soc/rockchip/Makefile
index 1bc1dc3..b02ab69 100644
--- a/sound/soc/rockchip/Makefile
+++ b/sound/soc/rockchip/Makefile
@@ -1,10 +1,13 @@
 # ROCKCHIP Platform Support
 snd-soc-i2s-objs := rockchip_i2s.o
+snd-soc-spdif-objs := rockchip_spdif.o
 
 obj-$(CONFIG_SND_SOC_ROCKCHIP_I2S) += snd-soc-i2s.o
+obj-$(CONFIG_SND_SOC_ROCKCHIP_SPDIF) += snd-soc-spdif.o
 
 snd-soc-rockchip-max98090-objs := rockchip_max98090.o
 snd-soc-rockchip-rt5645-objs := rockchip_rt5645.o
 
 obj-$(CONFIG_SND_SOC_ROCKCHIP_MAX98090) += snd-soc-rockchip-max98090.o
 obj-$(CONFIG_SND_SOC_ROCKCHIP_RT5645) += snd-soc-rockchip-rt5645.o
+
diff --git a/sound/soc/rockchip/rockchip_spdif.c b/sound/soc/rockchip/rockchip_spdif.c
new file mode 100644
index 0000000..e60ccf6
--- /dev/null
+++ b/sound/soc/rockchip/rockchip_spdif.c
@@ -0,0 +1,375 @@
+/* sound/soc/rockchip/rockchip_spdif.c
+ *
+ * ALSA SoC Audio Layer - Rockchip I2S Controller driver
+ *
+ * Copyright (c) 2014 Rockchip Electronics Co. Ltd.
+ * Author: Jianqun <jay.xu@rock-chips.com>
+ * Copyright (c) 2015 Collabora Ltd.
+ * Author: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/delay.h>
+#include <linux/of_gpio.h>
+#include <linux/clk.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+#include <sound/pcm_params.h>
+#include <sound/dmaengine_pcm.h>
+
+#include "rockchip_spdif.h"
+
+#define DRV_NAME "rockchip-spdif"
+
+struct rk_spdif_dev {
+	struct device *dev;
+
+	struct clk *mclk;
+	struct clk *hclk;
+
+	struct snd_dmaengine_dai_dma_data playback_dma_data;
+
+	struct regmap *regmap;
+};
+
+static int spdif_runtime_suspend(struct device *dev)
+{
+	struct rk_spdif_dev *spdif = dev_get_drvdata(dev);
+
+	clk_disable_unprepare(spdif->mclk);
+
+	return 0;
+}
+
+static int spdif_runtime_resume(struct device *dev)
+{
+	struct rk_spdif_dev *spdif = dev_get_drvdata(dev);
+	int ret;
+
+	ret = clk_prepare_enable(spdif->mclk);
+	if (ret) {
+		dev_err(spdif->dev, "clock enable failed %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static inline struct rk_spdif_dev *to_info(struct snd_soc_dai *dai)
+{
+	return snd_soc_dai_get_drvdata(dai);
+}
+
+static void rockchip_snd_txctrl(struct rk_spdif_dev *spdif, int on)
+{
+	if (on) {
+		regmap_update_bits(spdif->regmap, SPDIF_DMACR,
+				   SPDIF_DMACR_TDE_ENABLE,
+				   SPDIF_DMACR_TDE_ENABLE);
+
+		regmap_update_bits(spdif->regmap, SPDIF_XFER,
+				   SPDIF_XFER_TXS_START,
+				   SPDIF_XFER_TXS_START);
+	} else {
+		regmap_update_bits(spdif->regmap, SPDIF_DMACR,
+				   SPDIF_DMACR_TDE_ENABLE,
+				   SPDIF_DMACR_TDE_DISABLE);
+
+		regmap_update_bits(spdif->regmap, SPDIF_XFER,
+				   SPDIF_XFER_TXS_START,
+				   SPDIF_XFER_TXS_STOP);
+	}
+}
+
+static int rockchip_spdif_hw_params(struct snd_pcm_substream *substream,
+				  struct snd_pcm_hw_params *params,
+				  struct snd_soc_dai *dai)
+{
+	struct rk_spdif_dev *spdif = to_info(dai);
+	unsigned int val = SPDIF_CFGR_HALFWORD_ENABLE;
+	int srate, mclk;
+
+	srate = params_rate(params);
+	switch (srate) {
+	case 32000:
+	case 48000:
+	case 96000:
+		mclk = 12288000;
+		break;
+	case 44100:
+		mclk = 11289600;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (params_format(params)) {
+	case SNDRV_PCM_FORMAT_S16_LE:
+		val |= SPDIF_CFGR_VDW_16;
+		break;
+	case SNDRV_PCM_FORMAT_S20_3LE:
+		val |= SPDIF_CFGR_VDW_20;
+		break;
+	case SNDRV_PCM_FORMAT_S24_LE:
+		val |= SPDIF_CFGR_VDW_24;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* Set clock and calculate divider */
+	clk_set_rate(spdif->mclk, mclk);
+	val |= SPDIF_CFGR_CLK_DIV(mclk/(srate * 256));
+
+	regmap_update_bits(spdif->regmap, SPDIF_CFGR,
+		SPDIF_CFGR_CLK_DIV_MASK | SPDIF_CFGR_HALFWORD_ENABLE |
+		SDPIF_CFGR_VDW_MASK,
+		val);
+
+	return 0;
+}
+
+static int rockchip_spdif_trigger(struct snd_pcm_substream *substream,
+				int cmd, struct snd_soc_dai *dai)
+{
+	struct rk_spdif_dev *spdif = to_info(dai);
+	int ret = 0;
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_RESUME:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		rockchip_snd_txctrl(spdif, 1);
+		break;
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		rockchip_snd_txctrl(spdif, 0);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+static int rockchip_spdif_dai_probe(struct snd_soc_dai *dai)
+{
+	struct rk_spdif_dev *spdif = snd_soc_dai_get_drvdata(dai);
+
+	dai->playback_dma_data = &spdif->playback_dma_data;
+
+	return 0;
+}
+
+static const struct snd_soc_dai_ops rockchip_spdif_dai_ops = {
+	.hw_params = rockchip_spdif_hw_params,
+	.trigger = rockchip_spdif_trigger,
+};
+
+static struct snd_soc_dai_driver rockchip_spdif_dai = {
+	.probe = rockchip_spdif_dai_probe,
+	.playback = {
+		.stream_name = "Playback",
+		.channels_min = 2,
+		.channels_max = 2,
+		.rates = (SNDRV_PCM_RATE_32000 |
+			  SNDRV_PCM_RATE_44100 |
+			  SNDRV_PCM_RATE_48000 |
+			  SNDRV_PCM_RATE_96000),
+		.formats = (SNDRV_PCM_FMTBIT_S16_LE |
+			    SNDRV_PCM_FMTBIT_S20_3LE |
+			    SNDRV_PCM_FMTBIT_S24_LE),
+	},
+	.ops = &rockchip_spdif_dai_ops,
+};
+
+static const struct snd_soc_component_driver rockchip_spdif_component = {
+	.name = DRV_NAME,
+};
+
+static bool rockchip_spdif_wr_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case SPDIF_CFGR:
+	case SPDIF_DMACR:
+	case SPDIF_INTCR:
+	case SPDIF_XFER:
+	case SPDIF_SMPDR:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool rockchip_spdif_rd_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case SPDIF_CFGR:
+	case SPDIF_SDBLR:
+	case SPDIF_INTCR:
+	case SPDIF_INTSR:
+	case SPDIF_XFER:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool rockchip_spdif_volatile_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case SPDIF_INTSR:
+	case SPDIF_SDBLR:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static const struct regmap_config rockchip_spdif_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = SPDIF_SMPDR,
+	.writeable_reg = rockchip_spdif_wr_reg,
+	.readable_reg = rockchip_spdif_rd_reg,
+	.volatile_reg = rockchip_spdif_volatile_reg,
+	.cache_type = REGCACHE_FLAT,
+};
+
+static int rockchip_spdif_probe(struct platform_device *pdev)
+{
+	struct rk_spdif_dev *spdif;
+	struct resource *res;
+	void __iomem *regs;
+	int ret;
+
+	spdif = devm_kzalloc(&pdev->dev, sizeof(*spdif), GFP_KERNEL);
+	if (!spdif)
+		return -ENOMEM;
+
+	spdif->hclk = devm_clk_get(&pdev->dev, "spdif_hclk");
+	if (IS_ERR(spdif->hclk)) {
+		dev_err(&pdev->dev, "Can't retrieve spdif bus clock\n");
+		return PTR_ERR(spdif->hclk);
+	}
+	ret = clk_prepare_enable(spdif->hclk);
+	if (ret) {
+		dev_err(spdif->dev, "hclock enable failed %d\n", ret);
+		return ret;
+	}
+
+	spdif->mclk = devm_clk_get(&pdev->dev, "spdif_clk");
+	if (IS_ERR(spdif->mclk)) {
+		dev_err(&pdev->dev, "Can't retrieve spdif master clock\n");
+		return PTR_ERR(spdif->hclk);
+	}
+
+	ret = clk_prepare_enable(spdif->mclk);
+	if (ret) {
+		dev_err(spdif->dev, "clock enable failed %d\n", ret);
+		return ret;
+	}
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	regs = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(regs))
+		return PTR_ERR(regs);
+
+	spdif->regmap = devm_regmap_init_mmio(&pdev->dev, regs,
+					    &rockchip_spdif_regmap_config);
+	if (IS_ERR(spdif->regmap)) {
+		dev_err(&pdev->dev,
+			"Failed to initialise managed register map\n");
+		return PTR_ERR(spdif->regmap);
+	}
+
+	spdif->playback_dma_data.addr = res->start + SPDIF_SMPDR;
+	spdif->playback_dma_data.addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+	spdif->playback_dma_data.maxburst = 4;
+
+	spdif->dev = &pdev->dev;
+	dev_set_drvdata(&pdev->dev, spdif);
+
+	pm_runtime_enable(&pdev->dev);
+	if (!pm_runtime_enabled(&pdev->dev)) {
+		ret = spdif_runtime_resume(&pdev->dev);
+		if (ret)
+			goto err_pm_disable;
+	}
+
+	ret = devm_snd_soc_register_component(&pdev->dev,
+					      &rockchip_spdif_component,
+					      &rockchip_spdif_dai, 1);
+	if (ret) {
+		dev_err(&pdev->dev, "Could not register DAI\n");
+		goto err_suspend;
+	}
+
+	ret = snd_dmaengine_pcm_register(&pdev->dev, NULL, 0);
+	if (ret) {
+		dev_err(&pdev->dev, "Could not register PCM\n");
+		goto err_pcm_register;
+	}
+
+	return 0;
+
+err_pcm_register:
+	snd_dmaengine_pcm_unregister(&pdev->dev);
+err_suspend:
+	if (!pm_runtime_status_suspended(&pdev->dev))
+		spdif_runtime_suspend(&pdev->dev);
+err_pm_disable:
+	pm_runtime_disable(&pdev->dev);
+
+	return ret;
+}
+
+static int rockchip_spdif_remove(struct platform_device *pdev)
+{
+	struct rk_spdif_dev *spdif = dev_get_drvdata(&pdev->dev);
+
+	pm_runtime_disable(&pdev->dev);
+	if (!pm_runtime_status_suspended(&pdev->dev))
+		spdif_runtime_suspend(&pdev->dev);
+
+	clk_disable_unprepare(spdif->mclk);
+	clk_disable_unprepare(spdif->hclk);
+	snd_dmaengine_pcm_unregister(&pdev->dev);
+	snd_soc_unregister_component(&pdev->dev);
+
+	return 0;
+}
+
+static const struct of_device_id rockchip_spdif_match[] = {
+	{ .compatible = "rockchip,rk3066-spdif", },
+	{},
+};
+
+static const struct dev_pm_ops rockchip_spdif_pm_ops = {
+	SET_RUNTIME_PM_OPS(spdif_runtime_suspend, spdif_runtime_resume,
+			   NULL)
+};
+
+static struct platform_driver rockchip_spdif_driver = {
+	.probe = rockchip_spdif_probe,
+	.remove = rockchip_spdif_remove,
+	.driver = {
+		.name = DRV_NAME,
+		.of_match_table = of_match_ptr(rockchip_spdif_match),
+		.pm = &rockchip_spdif_pm_ops,
+	},
+};
+module_platform_driver(rockchip_spdif_driver);
+
+MODULE_DESCRIPTION("ROCKCHIP SPDIF transceiver Interface");
+MODULE_AUTHOR("Sjoerd Simons <sjoerd.simons@collabora.co.uk>");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:" DRV_NAME);
+MODULE_DEVICE_TABLE(of, rockchip_spdif_match);
diff --git a/sound/soc/rockchip/rockchip_spdif.h b/sound/soc/rockchip/rockchip_spdif.h
new file mode 100644
index 0000000..07f86a2
--- /dev/null
+++ b/sound/soc/rockchip/rockchip_spdif.h
@@ -0,0 +1,63 @@
+/*
+ * ALSA SoC Audio Layer - Rockchip SPDIF transceiver driver
+ *
+ * Copyright (c) 2015 Collabora Ltd.
+ * Author: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef _ROCKCHIP_SPDIF_H
+#define _ROCKCHIP_SPDIF_H
+
+/*
+ * CFGR
+ * transfer configuration register
+*/
+#define SPDIF_CFGR_CLK_DIV_SHIFT	(16)
+#define SPDIF_CFGR_CLK_DIV_MASK		(0xff << SPDIF_CFGR_CLK_DIV_SHIFT)
+#define SPDIF_CFGR_CLK_DIV(x)		(x << SPDIF_CFGR_CLK_DIV_SHIFT)
+
+#define SPDIF_CFGR_HALFWORD_SHIFT	2
+#define SPDIF_CFGR_HALFWORD_DISABLE	(0 << SPDIF_CFGR_HALFWORD_SHIFT)
+#define SPDIF_CFGR_HALFWORD_ENABLE	(1 << SPDIF_CFGR_HALFWORD_SHIFT)
+
+#define SPDIF_CFGR_VDW_SHIFT	0
+#define SPDIF_CFGR_VDW(x)	(x << SPDIF_CFGR_VDW_SHIFT)
+#define SDPIF_CFGR_VDW_MASK	(0xf << SPDIF_CFGR_VDW_SHIFT)
+
+#define SPDIF_CFGR_VDW_16	SPDIF_CFGR_VDW(0x00)
+#define SPDIF_CFGR_VDW_20	SPDIF_CFGR_VDW(0x01)
+#define SPDIF_CFGR_VDW_24	SPDIF_CFGR_VDW(0x10)
+
+/*
+ * DMACR
+ * DMA control register
+*/
+#define SPDIF_DMACR_TDE_SHIFT	5
+#define SPDIF_DMACR_TDE_DISABLE	(0 << SPDIF_DMACR_TDE_SHIFT)
+#define SPDIF_DMACR_TDE_ENABLE	(1 << SPDIF_DMACR_TDE_SHIFT)
+
+#define SPDIF_DMACR_TDL_SHIFT	0
+#define SPDIF_DMACR_TDL(x)	((x) << SPDIF_DMACR_TDL_SHIFT)
+#define SPDIF_DMACR_TDL_MASK	(0x1f << SDPIF_DMACR_TDL_SHIFT)
+
+/*
+ * XFER
+ * Transfer control register
+*/
+#define SPDIF_XFER_TXS_SHIFT	0
+#define SPDIF_XFER_TXS_STOP	(0 << SPDIF_XFER_TXS_SHIFT)
+#define SPDIF_XFER_TXS_START	(1 << SPDIF_XFER_TXS_SHIFT)
+
+#define SPDIF_CFGR	(0x0000)
+#define SPDIF_SDBLR	(0x0004)
+#define SPDIF_DMACR	(0x0008)
+#define SPDIF_INTCR	(0x000c)
+#define SPDIF_INTSR	(0x0010)
+#define SPDIF_XFER	(0x0018)
+#define SPDIF_SMPDR	(0x0020)
+
+#endif /* _ROCKCHIP_SPDIF_H */
-- 
2.4.6
