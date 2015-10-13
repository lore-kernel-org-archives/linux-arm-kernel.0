From: zhengsq@rock-chips.com (Shunqian Zheng)
Date: Tue, 13 Oct 2015 09:01:06 +0800
Subject: [PATCH v1 1/4] ASoC: codec: Inno codec driver for RK3036 SoC
In-Reply-To: <1444698070-4191-1-git-send-email-zhengsq@rock-chips.com>
References: <1444698070-4191-1-git-send-email-zhengsq@rock-chips.com>
Message-ID: <1444698070-4191-2-git-send-email-zhengsq@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: ZhengShunQian <zhengsq@rock-chips.com>

RK3036 SoC integrated with an Inno audio codec. This driver
config the base function of codec. And the dapm is still WIP.

Signed-off-by: ZhengShunQian <zhengsq@rock-chips.com>
---
 sound/soc/codecs/Kconfig       |   4 +
 sound/soc/codecs/Makefile      |   2 +
 sound/soc/codecs/inno_rk3036.c | 439 +++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/inno_rk3036.h | 308 +++++++++++++++++++++++++++++
 4 files changed, 753 insertions(+)
 create mode 100644 sound/soc/codecs/inno_rk3036.c
 create mode 100644 sound/soc/codecs/inno_rk3036.h

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index cfdafc4..e3cd3e7 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -471,6 +471,10 @@ config SND_SOC_GTM601
 config SND_SOC_ICS43432
 	tristate
 
+config SND_SOC_INNO_RK3036
+	tristate "Inno codec driver for RK3036 SoC"
+	depends on ARCH_ROCKCHIP
+
 config SND_SOC_ISABELLE
         tristate
 
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index f632fc4..2f6bc6c 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -60,6 +60,7 @@ snd-soc-es8328-i2c-objs := es8328-i2c.o
 snd-soc-es8328-spi-objs := es8328-spi.o
 snd-soc-gtm601-objs := gtm601.o
 snd-soc-ics43432-objs := ics43432.o
+snd-soc-inno-rk3036-objs := inno_rk3036.o
 snd-soc-isabelle-objs := isabelle.o
 snd-soc-jz4740-codec-objs := jz4740.o
 snd-soc-l3-objs := l3.o
@@ -255,6 +256,7 @@ obj-$(CONFIG_SND_SOC_ES8328_I2C)+= snd-soc-es8328-i2c.o
 obj-$(CONFIG_SND_SOC_ES8328_SPI)+= snd-soc-es8328-spi.o
 obj-$(CONFIG_SND_SOC_GTM601)    += snd-soc-gtm601.o
 obj-$(CONFIG_SND_SOC_ICS43432)	+= snd-soc-ics43432.o
+obj-$(CONFIG_SND_SOC_INNO_RK3036)	+= snd-soc-inno-rk3036.o
 obj-$(CONFIG_SND_SOC_ISABELLE)	+= snd-soc-isabelle.o
 obj-$(CONFIG_SND_SOC_JZ4740_CODEC)	+= snd-soc-jz4740-codec.o
 obj-$(CONFIG_SND_SOC_L3)	+= snd-soc-l3.o
diff --git a/sound/soc/codecs/inno_rk3036.c b/sound/soc/codecs/inno_rk3036.c
new file mode 100644
index 0000000..e8e7356
--- /dev/null
+++ b/sound/soc/codecs/inno_rk3036.c
@@ -0,0 +1,439 @@
+/*
+ * Driver of Inno codec for rk3036 by Rockchip Inc.
+ *
+ * Author: Rockchip Inc.
+ * Author: Zheng ShunQian<zhengsq@rock-chips.com>
+ */
+
+#define DEBUG
+
+#include <sound/soc.h>
+#include <sound/soc-dai.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+
+#include <linux/platform_device.h>
+#include <linux/of.h>
+#include <linux/clk.h>
+#include <linux/regmap.h>
+#include <linux/device.h>
+#include <linux/delay.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/io.h>
+
+#include "inno_rk3036.h"
+
+struct rk3036_codec_priv {
+	void __iomem *base;
+	struct clk *pclk;
+	struct regmap *regmap;
+	struct device *dev;
+};
+
+static int rk3036_codec_dai_set_sysclk(struct snd_soc_dai *dai, int clk_id,
+				       unsigned int fre, int dir)
+{
+	/* Nothing to be done here */
+	return 0;
+}
+
+static int rk3036_codec_dai_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	unsigned int reg01_val = 0,  reg02_val = 0, reg03_val = 0;
+
+	dev_dbg(codec->dev, "rk3036_codec dai set fmt : %08x\n", fmt);
+
+	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+	case SND_SOC_DAIFMT_CBS_CFS:
+		reg01_val |= INNO_REG_01_PINDIR_IN_SLAVE |
+			     INNO_REG_01_I2SMODE_SLAVE;
+		break;
+	case SND_SOC_DAIFMT_CBM_CFM:
+		reg01_val |= INNO_REG_01_PINDIR_OUT_MASTER |
+			     INNO_REG_01_I2SMODE_MASTER;
+		break;
+	default:
+		dev_err(codec->dev, "invalid fmt\n");
+		return -EINVAL;
+	}
+
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_DSP_A:
+		reg02_val |= INNO_REG_02_DACM_PCM;
+		break;
+	case SND_SOC_DAIFMT_I2S:
+		reg02_val |= INNO_REG_02_DACM_I2S;
+		break;
+	case SND_SOC_DAIFMT_RIGHT_J:
+		reg02_val |= INNO_REG_02_DACM_RJM;
+		break;
+	case SND_SOC_DAIFMT_LEFT_J:
+		reg02_val |= INNO_REG_02_DACM_LJM;
+		break;
+	default:
+		dev_err(codec->dev, "set dai format failed\n");
+		return -EINVAL;
+	}
+
+	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
+	case SND_SOC_DAIFMT_NB_NF:
+		reg02_val |= INNO_REG_02_LRCP_NORMAL;
+		reg03_val |= INNO_REG_03_BCP_NORMAL;
+		break;
+	case SND_SOC_DAIFMT_IB_IF:
+		reg02_val |= INNO_REG_02_LRCP_REVERSAL;
+		reg03_val |= INNO_REG_03_BCP_REVERSAL;
+		break;
+	case SND_SOC_DAIFMT_IB_NF:
+		reg02_val |= INNO_REG_02_LRCP_REVERSAL;
+		reg03_val |= INNO_REG_03_BCP_NORMAL;
+		break;
+	case SND_SOC_DAIFMT_NB_IF:
+		reg02_val |= INNO_REG_02_LRCP_NORMAL;
+		reg03_val |= INNO_REG_03_BCP_REVERSAL;
+		break;
+	default:
+		dev_err(codec->dev, "set dai format failed\n");
+		return -EINVAL;
+	}
+
+	snd_soc_update_bits(codec, INNO_REG_01, INNO_REG_01_I2SMODE_MASK |
+			    INNO_REG_01_PINDIR_MASK, reg01_val);
+	snd_soc_update_bits(codec, INNO_REG_02, INNO_REG_02_LRCP_MASK |
+			    INNO_REG_02_DACM_MASK, reg02_val);
+	snd_soc_update_bits(codec, INNO_REG_03, INNO_REG_03_BCP_MASK,
+			    reg03_val);
+	return 0;
+}
+
+static int rk3036_codec_dai_digital_mute(struct snd_soc_dai *dai, int mute)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	unsigned int val = 0;
+
+	dev_dbg(codec->dev, "rk3036_codec dai mute : %d\n", mute);
+	if (mute)
+		val |= INNO_REG_09_HP_OUTR_MUTE_YES |
+		       INNO_REG_09_HP_OUTL_MUTE_YES;
+	else
+		val |= INNO_REG_09_HP_OUTR_MUTE_NO |
+		       INNO_REG_09_HP_OUTL_MUTE_NO;
+
+	snd_soc_update_bits(codec, INNO_REG_09, INNO_REG_09_HP_OUTR_MUTE_MASK |
+			    INNO_REG_09_HP_OUTL_MUTE_MASK, val);
+	return 0;
+}
+
+static int rk3036_codec_dai_hw_params(struct snd_pcm_substream *substream,
+				      struct snd_pcm_hw_params *hw_params,
+				      struct snd_soc_dai *dai)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	unsigned int reg02_val = 0, reg03_val = 0;
+
+	dev_dbg(codec->dev, "rk3036_codec dai hw_params");
+
+	switch (params_format(hw_params)) {
+	case SNDRV_PCM_FORMAT_S16_LE:
+		reg02_val |= INNO_REG_02_VWL_16BIT;
+		break;
+	case SNDRV_PCM_FORMAT_S20_3LE:
+		reg02_val |= INNO_REG_02_VWL_20BIT;
+		break;
+	case SNDRV_PCM_FORMAT_S24_LE:
+		reg02_val |= INNO_REG_02_VWL_24BIT;
+		break;
+	case SNDRV_PCM_FORMAT_S32_LE:
+		reg02_val |= INNO_REG_02_VWL_32BIT;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	reg02_val |= INNO_REG_02_LRCP_NORMAL;
+	reg03_val |= INNO_REG_03_FWL_32BIT | INNO_REG_03_DACR_WORK;
+
+	snd_soc_update_bits(codec, INNO_REG_02, INNO_REG_02_LRCP_MASK |
+			    INNO_REG_02_VWL_MASK, reg02_val);
+	snd_soc_update_bits(codec, INNO_REG_03, INNO_REG_03_DACR_MASK |
+			    INNO_REG_03_FWL_MASK, reg03_val);
+	return 0;
+}
+
+#define RK3036_CODEC_RATES (SNDRV_PCM_RATE_8000  | \
+			    SNDRV_PCM_RATE_16000 | \
+			    SNDRV_PCM_RATE_32000 | \
+			    SNDRV_PCM_RATE_44100 | \
+			    SNDRV_PCM_RATE_48000 | \
+			    SNDRV_PCM_RATE_96000)
+
+#define RK3036_CODEC_FMTS (SNDRV_PCM_FMTBIT_S16_LE  | \
+			   SNDRV_PCM_FMTBIT_S20_3LE | \
+			   SNDRV_PCM_FMTBIT_S24_LE  | \
+			   SNDRV_PCM_FMTBIT_S32_LE)
+
+struct snd_soc_dai_ops rk3036_codec_dai_ops = {
+	.set_sysclk	= rk3036_codec_dai_set_sysclk,
+	.set_fmt	= rk3036_codec_dai_set_fmt,
+	.digital_mute	= rk3036_codec_dai_digital_mute,
+	.hw_params	= rk3036_codec_dai_hw_params,
+};
+
+struct snd_soc_dai_driver rk3036_codec_dai_driver[] = {
+	{
+		.name = "rk3036-codec-dai",
+		.playback = {
+			.stream_name = "Playback",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = RK3036_CODEC_RATES,
+			.formats = RK3036_CODEC_FMTS,
+		},
+		.ops = &rk3036_codec_dai_ops,
+		.symmetric_rates = 1,
+	},
+};
+
+static void rk3036_codec_reset(struct snd_soc_codec *codec)
+{
+	dev_dbg(codec->dev, "rk3036_codec reset\n");
+	snd_soc_write(codec, INNO_REG_00,
+		      INNO_REG_00_CSR_RESET | INNO_REG_00_CDCR_RESET);
+	mdelay(10);
+	snd_soc_write(codec, INNO_REG_00,
+		      INNO_REG_00_CSR_WORK | INNO_REG_00_CDCR_WORK);
+	mdelay(10);
+}
+
+static void rk3036_codec_power_off(struct snd_soc_codec *codec)
+{
+	struct inno_reg_val *reg_val;
+	int i;
+
+	dev_dbg(codec->dev, "rk3036_codec power off\n");
+	/* set a big current for capacitor charging. */
+	snd_soc_write(codec, INNO_REG_10, INNO_REG_10_MAX_CUR);
+	/* start discharge. */
+	snd_soc_write(codec, INNO_REG_06, INNO_REG_06_DAC_DISCHARGE);
+
+	for (i = 0; i < ARRAY_SIZE(inno_codec_close_path); i++) {
+		reg_val = &inno_codec_open_path[i];
+		snd_soc_write(codec, reg_val->reg, reg_val->val);
+		mdelay(5);
+	}
+}
+
+static void rk3036_codec_power_on(struct snd_soc_codec *codec)
+{
+	struct inno_reg_val *reg_val;
+	int i;
+
+	dev_dbg(codec->dev, "rk3036_codec power on\n");
+	/* set a big current for capacitor discharging. */
+	snd_soc_write(codec, INNO_REG_10, INNO_REG_10_MAX_CUR);
+	mdelay(10);
+	/* start precharge */
+	snd_soc_write(codec, INNO_REG_06, INNO_REG_06_DAC_PRECHARGE);
+	mdelay(100);
+
+	for (i = 0; i < ARRAY_SIZE(inno_codec_open_path); i++) {
+		reg_val = &inno_codec_open_path[i];
+		snd_soc_write(codec, reg_val->reg, reg_val->val);
+		mdelay(5);
+	}
+}
+
+static int rk3036_codec_probe(struct snd_soc_codec *codec)
+{
+	dev_dbg(codec->dev, "rk3036_codec probe\n");
+
+	rk3036_codec_reset(codec);
+
+	rk3036_codec_power_off(codec);
+	/* wait for capacitor discharge finished. */
+	mdelay(10);
+
+	rk3036_codec_power_on(codec);
+
+	return 0;
+}
+
+static int rk3036_codec_remove(struct snd_soc_codec *codec)
+{
+	dev_dbg(codec->dev, "rk3036_codec remove\n");
+	rk3036_codec_power_off(codec);
+
+	return 0;
+}
+
+static int rk3036_codec_set_bias_level(struct snd_soc_codec *codec,
+				       enum snd_soc_bias_level level)
+{
+	dev_dbg(codec->dev, "rk3036_codec set bias\n");
+	switch (level) {
+	case SND_SOC_BIAS_ON:
+		break;
+
+	case SND_SOC_BIAS_PREPARE:
+		break;
+
+	case SND_SOC_BIAS_STANDBY:
+		break;
+
+	case SND_SOC_BIAS_OFF:
+		break;
+	}
+
+	return 0;
+}
+
+static struct regmap *rk3036_codec_get_regmap(struct device *dev)
+{
+	struct rk3036_codec_priv *priv = dev_get_drvdata(dev);
+
+	dev_dbg(dev, "rk3036_codec get regmap\n");
+	return priv->regmap;
+}
+
+static struct snd_soc_codec_driver rk3036_codec_driver = {
+	.probe		= rk3036_codec_probe,
+	.remove		= rk3036_codec_remove,
+	.set_bias_level	= rk3036_codec_set_bias_level,
+	.get_regmap	= rk3036_codec_get_regmap,
+};
+
+static int codec_reg_read(void *context, unsigned int reg, unsigned int *val)
+{
+	struct rk3036_codec_priv *priv = context;
+	void __iomem *base = priv->base;
+
+	*val = readl(base + reg);
+	return 0;
+}
+
+static int codec_reg_write(void *context, unsigned int reg, unsigned int val)
+{
+	struct rk3036_codec_priv *priv = context;
+	void __iomem *base = priv->base;
+
+	dev_dbg(priv->dev, "write %08x to %08x\n", val, reg);
+	writel(val, base + reg);
+	return 0;
+}
+
+static struct regmap_bus codec_regmap_bus = {
+	.reg_read = codec_reg_read,
+	.reg_write = codec_reg_write,
+	.reg_format_endian_default = REGMAP_ENDIAN_NATIVE,
+	.val_format_endian_default = REGMAP_ENDIAN_NATIVE,
+};
+
+static struct regmap_config rk3036_codec_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 8,
+};
+
+static int rk3036_codec_platform_probe(struct platform_device *pdev)
+{
+	struct rk3036_codec_priv *priv;
+	struct device_node *of_node = pdev->dev.of_node;
+	struct resource *res;
+	void __iomem *base;
+	struct regmap *grf;
+	int ret;
+
+	dev_dbg(&pdev->dev, "rk3036_codec platform probe\n");
+	priv = devm_kzalloc(&pdev->dev, sizeof(struct rk3036_codec_priv),
+			    GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	priv->base = base;
+	priv->regmap = devm_regmap_init(&pdev->dev, &codec_regmap_bus, priv,
+					&rk3036_codec_regmap_config);
+	if (IS_ERR(priv->regmap)) {
+		dev_err(&pdev->dev, "init regmap failed\n");
+		return PTR_ERR(priv->regmap);
+	}
+
+	grf = syscon_regmap_lookup_by_phandle(of_node, "rockchip,grf");
+	if (IS_ERR(grf)) {
+		dev_err(&pdev->dev, "needs 'rockchip,grf' property\n");
+		return PTR_ERR(grf);
+	}
+	ret = regmap_write(grf, 0x00140, BIT(16 + 10) | BIT(10));
+	if (ret != 0) {
+		dev_err(&pdev->dev, "Could not write to GRF: %d\n", ret);
+		return ret;
+	}
+
+	priv->pclk = devm_clk_get(&pdev->dev, "acodec_pclk");
+	if (IS_ERR(priv->pclk))
+		return PTR_ERR(priv->pclk);
+
+	ret = clk_prepare_enable(priv->pclk);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "failed to enable clk\n");
+		return ret;
+	}
+
+	priv->dev = &pdev->dev;
+	dev_set_drvdata(&pdev->dev, priv);
+
+	ret = snd_soc_register_codec(&pdev->dev, &rk3036_codec_driver,
+				     rk3036_codec_dai_driver,
+				     ARRAY_SIZE(rk3036_codec_dai_driver));
+	if (ret) {
+		clk_disable_unprepare(priv->pclk);
+		dev_set_drvdata(&pdev->dev, NULL);
+	}
+
+	return ret;
+}
+
+static int rk3036_codec_platform_remove(struct platform_device *pdev)
+{
+	struct rk3036_codec_priv *priv = dev_get_drvdata(&pdev->dev);
+
+	dev_dbg(&pdev->dev, "rk3036_codec platform remove\n");
+	snd_soc_unregister_codec(&pdev->dev);
+	clk_disable_unprepare(priv->pclk);
+
+	return 0;
+}
+
+static void rk3036_codec_platform_shutdown(struct platform_device *pdev)
+{
+	/*TODO:*/
+}
+
+static const struct of_device_id rk3036_codec_of_match[] = {
+	{ .compatible = "rk3036-codec", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, rk3036_codec_of_match);
+
+static struct platform_driver rk3036_codec_platform_driver = {
+	.driver = {
+		.name = "rk3036-codec-platform",
+		.owner = THIS_MODULE,
+		.of_match_table = of_match_ptr(rk3036_codec_of_match),
+	},
+	.probe = rk3036_codec_platform_probe,
+	.remove = rk3036_codec_platform_remove,
+	.shutdown = rk3036_codec_platform_shutdown,
+};
+
+module_platform_driver(rk3036_codec_platform_driver);
+
+MODULE_AUTHOR("Rockchip Inc.");
+MODULE_DESCRIPTION("Rockchip rk3036 codec driver");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/inno_rk3036.h b/sound/soc/codecs/inno_rk3036.h
new file mode 100644
index 0000000..8b01a9b
--- /dev/null
+++ b/sound/soc/codecs/inno_rk3036.h
@@ -0,0 +1,308 @@
+/*
+ * Driver of Inno Codec for rk3036 by Rockchip Inc.
+ * Author: Zheng ShunQian<zhengsq@rock-chips.com>
+ */
+
+#ifndef _INNO_RK3036_CODEC_H
+#define _INNO_RK3036_CODEC_H
+
+/* codec registers */
+#define INNO_REG_00	0x00
+#define INNO_REG_01	0x0c
+#define INNO_REG_02	0x10
+#define INNO_REG_03	0x14
+#define INNO_REG_04	0x88
+#define INNO_REG_05	0x8c
+#define INNO_REG_06	0x90
+#define INNO_REG_07	0x94
+#define INNO_REG_08	0x98
+#define INNO_REG_09	0x9c
+#define INNO_REG_10	0xa0
+
+/* register bit filed */
+#define INNO_REG_00_CSR_RESET		(0x0 << 0) /*codec system reset*/
+#define INNO_REG_00_CSR_WORK		(0x1 << 0)
+#define INNO_REG_00_CDCR_RESET		(0x0 << 1) /*codec digital core reset*/
+#define INNO_REG_00_CDCR_WORK		(0x1 << 1)
+#define INNO_REG_00_PRB_DISABLE		(0x0 << 6) /*power reset bypass*/
+#define INNO_REG_00_PRB_ENABLE		(0x1 << 6)
+
+#define INNO_REG_01_I2SMODE_MASK	(0x1 << 4)
+#define INNO_REG_01_I2SMODE_SLAVE	(0x0 << 4)
+#define INNO_REG_01_I2SMODE_MASTER	(0x1 << 4)
+#define INNO_REG_01_PINDIR_MASK		(0x1 << 5)
+#define INNO_REG_01_PINDIR_IN_SLAVE	(0x0 << 5) /*direction of pin*/
+#define INNO_REG_01_PINDIR_OUT_MASTER	(0x1 << 5)
+
+#define INNO_REG_02_LRS_MASK		(0x1 << 2)
+#define INNO_REG_02_LRS_NORMAL		(0x0 << 2) /*DAC Left Right Swap*/
+#define INNO_REG_02_LRS_SWAP		(0x1 << 2)
+#define INNO_REG_02_DACM_MASK		(0x3 << 3)
+#define INNO_REG_02_DACM_PCM		(0x3 << 3) /*DAC Mode*/
+#define INNO_REG_02_DACM_I2S		(0x2 << 3)
+#define INNO_REG_02_DACM_LJM		(0x1 << 3)
+#define INNO_REG_02_DACM_RJM		(0x0 << 3)
+#define INNO_REG_02_VWL_MASK		(0x3 << 5)
+#define INNO_REG_02_VWL_32BIT		(0x3 << 5) /*1/2Frame Valid Word Len*/
+#define INNO_REG_02_VWL_24BIT		(0x2 << 5)
+#define INNO_REG_02_VWL_20BIT		(0x1 << 5)
+#define INNO_REG_02_VWL_16BIT		(0x0 << 5)
+#define INNO_REG_02_LRCP_MASK		(0x1 << 7)
+#define INNO_REG_02_LRCP_NORMAL		(0x0 << 7) /*Left Right Polarity*/
+#define INNO_REG_02_LRCP_REVERSAL	(0x1 << 7)
+
+#define INNO_REG_03_BCP_MASK		(0x1 << 0)
+#define INNO_REG_03_BCP_NORMAL		(0x0 << 0) /*DAC bit clock polarity*/
+#define INNO_REG_03_BCP_REVERSAL	(0x1 << 0)
+#define INNO_REG_03_DACR_MASK		(0x1 << 1)
+#define INNO_REG_03_DACR_RESET		(0x0 << 1) /*DAC Reset*/
+#define INNO_REG_03_DACR_WORK		(0x1 << 1)
+#define INNO_REG_03_FWL_MASK		(0x3 << 2)
+#define INNO_REG_03_FWL_32BIT		(0x3 << 2) /*1/2Frame Word Length*/
+#define INNO_REG_03_FWL_24BIT		(0x2 << 2)
+#define INNO_REG_03_FWL_20BIT		(0x1 << 2)
+#define INNO_REG_03_FWL_16BIT		(0x0 << 2)
+
+#define INNO_REG_04_DACR_WORK		(0x1 << 0) /*DAC Right Module*/
+#define INNO_REG_04_DACR_STOP		(0x0 << 0)
+#define INNO_REG_04_DACL_WORK		(0x1 << 1) /*DAC Left Module*/
+#define INNO_REG_04_DACL_STOP		(0x0 << 1)
+#define INNO_REG_04_DACR_CLK_WORK	(0x1 << 2) /*DAC Right CLK*/
+#define INNO_REG_04_DACR_CLK_STOP	(0x0 << 2)
+#define INNO_REG_04_DACL_CLK_WORK	(0x1 << 3) /*DAC Left CLK*/
+#define INNO_REG_04_DACL_CLK_STOP	(0x0 << 3)
+#define INNO_REG_04_DACR_RV_WORK	(0x1 << 4) /*DAC Right Ref Voltage*/
+#define INNO_REG_04_DACR_RV_STOP	(0x0 << 4)
+#define INNO_REG_04_DACL_RV_WORK	(0x1 << 5) /*DAC Left Ref Voltage*/
+#define INNO_REG_04_DACL_RV_STOP	(0x0 << 5)
+
+#define INNO_REG_05_HPOUTR_EN_WORK	(0x1 << 0) /*HeadPhone Output Right*/
+#define INNO_REG_05_HPOUTR_EN_STOP	(0x0 << 0)
+#define INNO_REG_05_HPOUTL_EN_WORK	(0x1 << 1) /*HeadPhone Output Left*/
+#define INNO_REG_05_HPOUTL_EN_STOP	(0x0 << 1)
+#define INNO_REG_05_HPOUTR_WORK		(0x1 << 2) /*Init HP out right*/
+#define INNO_REG_05_HPOUTR_INIT		(0x0 << 2)
+#define INNO_REG_05_HPOUTL_WORK		(0x1 << 3) /*Init HP out left*/
+#define INNO_REG_05_HPOUTL_INIT		(0x0 << 3)
+
+#define INNO_REG_06_VOUTR_CZ_WORK	(0x1 << 0) /*Cross-Zero detection*/
+#define INNO_REG_06_VOUTR_CZ_STOP	(0x0 << 0)
+#define INNO_REG_06_VOUTL_CZ_WORK	(0x1 << 1) /*Cross-Zero detection*/
+#define INNO_REG_06_VOUTL_CZ_STOP	(0x0 << 1)
+#define INNO_REG_06_DACR_HL_RV_WORK	(0x1 << 2) /*High & Low Ref Voltage*/
+#define INNO_REG_06_DACR_HL_RV_STOP	(0x0 << 2)
+#define INNO_REG_06_DACL_HL_RV_WORK	(0x1 << 3) /*High & Low Ref Voltage*/
+#define INNO_REG_06_DACL_HL_RV_STOP	(0x0 << 3)
+#define INNO_REG_06_DAC_PRECHARGE	(0x0 << 4) /*PreCharge control for DAC*/
+#define INNO_REG_06_DAC_DISCHARGE	(0x1 << 4)
+#define INNO_REG_06_DAC_EN_WORK		(0x1 << 5) /*Enable Signal for DAC*/
+#define INNO_REG_06_DAC_EN_STOP		(0x0 << 5)
+
+/* Gain of output, 1.5db step: -39db(0x0) ~ 0db(0x1a) ~ 6db(0x1f) */
+#define INNO_REG_07_HPOUTL_GAIN_0DB	0x1a
+#define INNO_REG_07_HPOUTL_GAIN_N39DB	0x0
+#define INNO_REG_08_HPOUTR_GAIN_0DB	0x1a
+#define INNO_REG_08_HPOUTR_GAIN_N39DB	0x0
+
+#define INNO_REG_09_HP_OUTR_POP_PRECHARGE	(0x1 << 0)
+#define INNO_REG_09_HP_OUTR_POP_WORK		(0x2 << 0)
+#define INNO_REG_09_HP_OUTL_POP_PRECHARGE	(0x1 << 2)
+#define INNO_REG_09_HP_OUTL_POP_WORK		(0x2 << 2)
+#define INNO_REG_09_HP_OUTR_MUTE_MASK	(0x1 << 4)
+#define INNO_REG_09_HP_OUTR_MUTE_NO	(0x1 << 4)
+#define INNO_REG_09_HP_OUTR_MUTE_YES	(0x0 << 4)
+#define INNO_REG_09_HP_OUTL_MUTE_MASK	(0x1 << 5)
+#define INNO_REG_09_HP_OUTL_MUTE_NO	(0x1 << 5)
+#define INNO_REG_09_HP_OUTL_MUTE_YES	(0x0 << 5)
+#define INNO_REG_09_DACR_INIT		(0x0 << 6)
+#define INNO_REG_09_DACR_WORK		(0x1 << 6)
+#define INNO_REG_09_DACL_INIT		(0x0 << 7)
+#define INNO_REG_09_DACL_WORK		(0x1 << 7)
+
+#define INNO_REG_09_POWERON (INNO_REG_09_HP_OUTR_POP_WORK | \
+			      INNO_REG_09_HP_OUTL_POP_WORK | \
+			      INNO_REG_09_HP_OUTR_MUTE_YES | \
+			      INNO_REG_09_HP_OUTL_MUTE_YES | \
+			      INNO_REG_09_DACR_WORK        | \
+			      INNO_REG_09_DACL_WORK)
+
+#define INNO_REG_10_CHARGE_SEL_CUR_400I_YES	(0x0 << 0)
+#define INNO_REG_10_CHARGE_SEL_CUR_400I_NO	(0x1 << 0)
+#define INNO_REG_10_CHARGE_SEL_CUR_260I_YES	(0x0 << 1)
+#define INNO_REG_10_CHARGE_SEL_CUR_260I_NO	(0x1 << 1)
+#define INNO_REG_10_CHARGE_SEL_CUR_130I_YES	(0x0 << 2)
+#define INNO_REG_10_CHARGE_SEL_CUR_130I_NO	(0x1 << 2)
+#define INNO_REG_10_CHARGE_SEL_CUR_100I_YES	(0x0 << 3)
+#define INNO_REG_10_CHARGE_SEL_CUR_100I_NO	(0x1 << 3)
+#define INNO_REG_10_CHARGE_SEL_CUR_050I_YES	(0x0 << 4)
+#define INNO_REG_10_CHARGE_SEL_CUR_050I_NO	(0x1 << 4)
+#define INNO_REG_10_CHARGE_SEL_CUR_027I_YES	(0x0 << 5)
+#define INNO_REG_10_CHARGE_SEL_CUR_027I_NO	(0x1 << 5)
+
+#define INNO_REG_10_MAX_CUR (INNO_REG_10_CHARGE_SEL_CUR_400I_YES | \
+			     INNO_REG_10_CHARGE_SEL_CUR_260I_YES | \
+			     INNO_REG_10_CHARGE_SEL_CUR_130I_YES | \
+			     INNO_REG_10_CHARGE_SEL_CUR_100I_YES | \
+			     INNO_REG_10_CHARGE_SEL_CUR_050I_YES | \
+			     INNO_REG_10_CHARGE_SEL_CUR_027I_YES)
+
+struct inno_reg_val {
+	int reg;
+	int val;
+};
+
+struct inno_reg_val inno_codec_open_path[] = {
+	{ /* open current source */
+		.reg = INNO_REG_06,
+		.val = INNO_REG_06_DAC_EN_WORK     |
+		       INNO_REG_06_DAC_PRECHARGE   |
+		       INNO_REG_06_DACL_HL_RV_STOP |
+		       INNO_REG_06_DACR_HL_RV_STOP |
+		       INNO_REG_06_VOUTR_CZ_STOP   |
+		       INNO_REG_06_VOUTL_CZ_STOP,
+	},
+	{ /* power on DAC path reference voltage */
+		.reg = INNO_REG_04,
+		.val = INNO_REG_04_DACR_RV_WORK    |
+		       INNO_REG_04_DACL_RV_WORK    |
+		       INNO_REG_04_DACL_CLK_STOP   |
+		       INNO_REG_04_DACR_CLK_STOP   |
+		       INNO_REG_04_DACL_STOP       |
+		       INNO_REG_04_DACR_STOP,
+	},
+	{ /* PoP precharge work */
+		.reg = INNO_REG_09,
+		.val = INNO_REG_09_DACL_INIT        |
+		       INNO_REG_09_DACR_INIT        |
+		       INNO_REG_09_HP_OUTL_MUTE_YES |
+		       INNO_REG_09_HP_OUTR_MUTE_YES |
+		       INNO_REG_09_HP_OUTR_POP_WORK |
+		       INNO_REG_09_HP_OUTL_POP_WORK,
+	},
+	{ /* start up HPOUTL HPOUTR */
+		.reg = INNO_REG_05,
+		.val = INNO_REG_05_HPOUTR_EN_WORK  |
+		       INNO_REG_05_HPOUTL_EN_WORK  |
+		       INNO_REG_05_HPOUTR_INIT     |
+		       INNO_REG_05_HPOUTL_INIT,
+	},
+	{ /* now the HPOUTL HPOUTR init OK */
+		.reg = INNO_REG_05,
+		.val = INNO_REG_05_HPOUTR_EN_WORK  |
+		       INNO_REG_05_HPOUTL_EN_WORK  |
+		       INNO_REG_05_HPOUTR_WORK     |
+		       INNO_REG_05_HPOUTL_WORK,
+	},
+	{ /* start up special reference voltage of DACL DACR */
+		.reg = INNO_REG_06,
+		.val = INNO_REG_06_DAC_EN_WORK     |
+		       INNO_REG_06_DAC_PRECHARGE   |
+		       INNO_REG_06_DACL_HL_RV_WORK |
+		       INNO_REG_06_DACR_HL_RV_WORK |
+		       INNO_REG_06_VOUTL_CZ_STOP   |
+		       INNO_REG_06_VOUTR_CZ_STOP,
+	},
+	{ /* start up clock module of LR channel */
+		.reg = INNO_REG_04,
+		.val = INNO_REG_04_DACR_STOP       |
+		       INNO_REG_04_DACL_STOP       |
+		       INNO_REG_04_DACR_CLK_WORK   |
+		       INNO_REG_04_DACL_CLK_WORK   |
+		       INNO_REG_04_DACR_RV_WORK    |
+		       INNO_REG_04_DACL_RV_WORK,
+	},
+	{ /* start up DACL DACR module */
+		.reg = INNO_REG_04,
+		.val = INNO_REG_04_DACR_WORK       |
+		       INNO_REG_04_DACL_WORK       |
+		       INNO_REG_04_DACR_CLK_WORK   |
+		       INNO_REG_04_DACL_CLK_WORK   |
+		       INNO_REG_04_DACR_RV_WORK    |
+		       INNO_REG_04_DACL_RV_WORK,
+	},
+	{ /* end of the init state of DACL DACR */
+		.reg = INNO_REG_09,
+		.val = INNO_REG_09_POWERON,
+	},
+	{ /* set the gain of headphone output */
+		.reg = INNO_REG_07,
+		.val = INNO_REG_07_HPOUTL_GAIN_0DB,
+	},
+	{ /* set the gain of headphone output */
+		.reg = INNO_REG_08,
+		.val = INNO_REG_08_HPOUTR_GAIN_0DB,
+	},
+	{ /* end of the init state of DACL DACR */
+		.reg = INNO_REG_09,
+		.val = INNO_REG_09_DACL_WORK       |
+		       INNO_REG_09_DACR_WORK       |
+		       INNO_REG_09_HP_OUTL_MUTE_NO |
+		       INNO_REG_09_HP_OUTR_MUTE_NO |
+		       INNO_REG_09_HP_OUTR_POP_WORK |
+		       INNO_REG_09_HP_OUTL_POP_WORK,
+	},
+};
+
+struct inno_reg_val inno_codec_close_path[] = {
+	{
+		.reg = INNO_REG_06,
+		.val = INNO_REG_06_DAC_EN_WORK     |
+		       INNO_REG_06_DAC_PRECHARGE   |
+		       INNO_REG_06_DACL_HL_RV_WORK |
+		       INNO_REG_06_DACR_HL_RV_WORK |
+		       INNO_REG_06_VOUTL_CZ_STOP   |
+		       INNO_REG_06_VOUTR_CZ_STOP,
+	},
+	{
+		.reg = INNO_REG_07,
+		.val = INNO_REG_07_HPOUTL_GAIN_N39DB,
+	},
+	{
+		.reg = INNO_REG_08,
+		.val = INNO_REG_08_HPOUTR_GAIN_N39DB,
+	},
+	{
+		.reg = INNO_REG_09,
+		.val = INNO_REG_09_POWERON,
+	},
+	{
+		.reg = INNO_REG_05,
+		.val = INNO_REG_05_HPOUTR_EN_WORK  |
+		       INNO_REG_05_HPOUTL_EN_WORK  |
+		       INNO_REG_05_HPOUTR_INIT     |
+		       INNO_REG_05_HPOUTL_INIT,
+	},
+	{
+		.reg = INNO_REG_09,
+		.val = INNO_REG_09_DACL_WORK       |
+		       INNO_REG_09_DACR_WORK       |
+		       INNO_REG_09_HP_OUTL_MUTE_YES |
+		       INNO_REG_09_HP_OUTR_MUTE_YES |
+		       INNO_REG_09_HP_OUTR_POP_PRECHARGE |
+		       INNO_REG_09_HP_OUTL_POP_PRECHARGE,
+	},
+	{
+		.reg = INNO_REG_04,
+		.val = INNO_REG_04_DACR_RV_STOP    |
+		       INNO_REG_04_DACL_RV_STOP    |
+		       INNO_REG_04_DACL_CLK_STOP   |
+		       INNO_REG_04_DACR_CLK_STOP   |
+		       INNO_REG_04_DACL_STOP       |
+		       INNO_REG_04_DACR_STOP,
+	},
+	{
+		.reg = INNO_REG_06,
+		.val = INNO_REG_06_DAC_DISCHARGE,
+	},
+	{
+		.reg = INNO_REG_09,
+		.val = INNO_REG_09_DACL_INIT       |
+		       INNO_REG_09_DACR_INIT       |
+		       INNO_REG_09_HP_OUTL_MUTE_YES |
+		       INNO_REG_09_HP_OUTR_MUTE_YES |
+		       INNO_REG_09_HP_OUTR_POP_PRECHARGE |
+		       INNO_REG_09_HP_OUTL_POP_PRECHARGE,
+	},
+};
+
+#endif
-- 
1.9.1
