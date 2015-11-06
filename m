From: zhengsq@rock-chips.com (Shunqian Zheng)
Date: Fri,  6 Nov 2015 16:39:21 +0800
Subject: [PATCH v3 1/2] ASoC: codec: Inno codec driver for RK3036 SoC
In-Reply-To: <1446799162-15635-1-git-send-email-zhengsq@rock-chips.com>
References: <1446799162-15635-1-git-send-email-zhengsq@rock-chips.com>
Message-ID: <1446799162-15635-2-git-send-email-zhengsq@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: ZhengShunQian <zhengsq@rock-chips.com>

RK3036 SoC integrated with an Inno audio codec.
This driver implements the functions of it.

There is not need a special machine driver, since the
simple-card machine driver works perfect in this case.

Signed-off-by: ZhengShunQian <zhengsq@rock-chips.com>
---
 sound/soc/codecs/Kconfig       |   4 +
 sound/soc/codecs/Makefile      |   2 +
 sound/soc/codecs/inno_rk3036.c | 438 +++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/inno_rk3036.h | 120 +++++++++++
 4 files changed, 564 insertions(+)
 create mode 100644 sound/soc/codecs/inno_rk3036.c
 create mode 100644 sound/soc/codecs/inno_rk3036.h

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 0c9733e..2de6cbc 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -65,6 +65,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_ES8328_I2C if I2C
 	select SND_SOC_GTM601
 	select SND_SOC_ICS43432
+	select SND_SOC_INNO_RK3036
 	select SND_SOC_ISABELLE if I2C
 	select SND_SOC_JZ4740_CODEC
 	select SND_SOC_LM4857 if I2C
@@ -462,6 +463,9 @@ config SND_SOC_GTM601
 config SND_SOC_ICS43432
 	tristate
 
+config SND_SOC_INNO_RK3036
+	tristate "Inno codec driver for RK3036 SoC"
+
 config SND_SOC_ISABELLE
         tristate
 
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 4a32077..c321489 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -58,6 +58,7 @@ snd-soc-es8328-i2c-objs := es8328-i2c.o
 snd-soc-es8328-spi-objs := es8328-spi.o
 snd-soc-gtm601-objs := gtm601.o
 snd-soc-ics43432-objs := ics43432.o
+snd-soc-inno-rk3036-objs := inno_rk3036.o
 snd-soc-isabelle-objs := isabelle.o
 snd-soc-jz4740-codec-objs := jz4740.o
 snd-soc-l3-objs := l3.o
@@ -250,6 +251,7 @@ obj-$(CONFIG_SND_SOC_ES8328_I2C)+= snd-soc-es8328-i2c.o
 obj-$(CONFIG_SND_SOC_ES8328_SPI)+= snd-soc-es8328-spi.o
 obj-$(CONFIG_SND_SOC_GTM601)    += snd-soc-gtm601.o
 obj-$(CONFIG_SND_SOC_ICS43432)	+= snd-soc-ics43432.o
+obj-$(CONFIG_SND_SOC_INNO_RK3036)	+= snd-soc-inno-rk3036.o
 obj-$(CONFIG_SND_SOC_ISABELLE)	+= snd-soc-isabelle.o
 obj-$(CONFIG_SND_SOC_JZ4740_CODEC)	+= snd-soc-jz4740-codec.o
 obj-$(CONFIG_SND_SOC_L3)	+= snd-soc-l3.o
diff --git a/sound/soc/codecs/inno_rk3036.c b/sound/soc/codecs/inno_rk3036.c
new file mode 100644
index 0000000..e0f7832
--- /dev/null
+++ b/sound/soc/codecs/inno_rk3036.c
@@ -0,0 +1,438 @@
+/*
+ * Driver of Inno codec for rk3036 by Rockchip Inc.
+ *
+ * Author: Rockchip Inc.
+ * Author: Zheng ShunQian<zhengsq@rock-chips.com>
+ */
+
+#include <sound/soc.h>
+#include <sound/tlv.h>
+#include <sound/soc-dapm.h>
+#include <sound/soc-dai.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+
+#include <linux/platform_device.h>
+#include <linux/of.h>
+#include <linux/clk.h>
+#include <linux/regmap.h>
+#include <linux/device.h>
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
+static const DECLARE_TLV_DB_MINMAX(rk3036_codec_hp_tlv, -39, 0);
+
+static const char * const rk3036_codec_antipop_text[] = {"none", "work"};
+static const unsigned int rk3036_codec_antipop_values[] = {0x1, 0x2};
+
+static SOC_VALUE_ENUM_DOUBLE_DECL(rk3036_codec_antipop_enum, INNO_R09,
+		INNO_R09_HPL_ANITPOP_SHIFT, INNO_R09_HPR_ANITPOP_SHIFT, 0x3,
+		rk3036_codec_antipop_text, rk3036_codec_antipop_values);
+
+static const struct snd_kcontrol_new rk3036_codec_dapm_controls[] = {
+	SOC_DOUBLE_R_RANGE_TLV("Headphone Volume", INNO_R07, INNO_R08,
+		INNO_HP_GAIN_SHIFT, INNO_HP_GAIN_N39DB,
+		INNO_HP_GAIN_0DB, 0, rk3036_codec_hp_tlv),
+	SOC_DOUBLE("Zero Cross Switch", INNO_R06, INNO_R06_VOUTL_CZ_SHIFT,
+		INNO_R06_VOUTR_CZ_SHIFT, 1, 0),
+	SOC_DOUBLE("Headphone Switch", INNO_R09, INNO_R09_HPL_MUTE_SHIFT,
+		INNO_R09_HPR_MUTE_SHIFT, 1, 0),
+	SOC_ENUM("Anti-pop", rk3036_codec_antipop_enum),
+};
+
+static const struct snd_kcontrol_new rk3036_codec_hpl_mixer_controls[] = {
+	SOC_DAPM_SINGLE("DAC Left Out Switch", INNO_R09,
+			INNO_R09_DACL_SWITCH_SHIFT, 1, 0),
+};
+
+static const struct snd_kcontrol_new rk3036_codec_hpr_mixer_controls[] = {
+	SOC_DAPM_SINGLE("DAC Right Out Switch", INNO_R09,
+			INNO_R09_DACR_SWITCH_SHIFT, 1, 0),
+};
+
+static const struct snd_kcontrol_new rk3036_codec_hpl_switch_controls[] = {
+	SOC_DAPM_SINGLE("HP Left Out Switch", INNO_R05,
+			INNO_R05_HPL_WORK_SHIFT, 1, 0),
+};
+
+static const struct snd_kcontrol_new rk3036_codec_hpr_switch_controls[] = {
+	SOC_DAPM_SINGLE("HP Right Out Switch", INNO_R05,
+			INNO_R05_HPR_WORK_SHIFT, 1, 0),
+};
+
+static const struct snd_soc_dapm_widget rk3036_codec_dapm_widgets[] = {
+	SND_SOC_DAPM_SUPPLY_S("DAC PWR", 1, INNO_R06,
+			      INNO_R06_DAC_EN_SHIFT, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY_S("DACL VREF", 2, INNO_R04,
+			      INNO_R04_DACL_VREF_SHIFT, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY_S("DACR VREF", 2, INNO_R04,
+			      INNO_R04_DACR_VREF_SHIFT, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY_S("DACL HiLo VREF", 3, INNO_R06,
+			      INNO_R06_DACL_HILO_VREF_SHIFT, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY_S("DACR HiLo VREF", 3, INNO_R06,
+			      INNO_R06_DACR_HILO_VREF_SHIFT, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY_S("DACR CLK", 3, INNO_R04,
+			      INNO_R04_DACR_CLK_SHIFT, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY_S("DACL CLK", 3, INNO_R04,
+			      INNO_R04_DACL_CLK_SHIFT, 0, NULL, 0),
+
+	SND_SOC_DAPM_DAC("DACL", "Left Playback", INNO_R04,
+			 INNO_R04_DACL_SW_SHIFT, 0),
+	SND_SOC_DAPM_DAC("DACR", "Right Playback", INNO_R04,
+			 INNO_R04_DACR_SW_SHIFT, 0),
+
+	SND_SOC_DAPM_MIXER("Left Headphone Mixer", SND_SOC_NOPM, 0, 0,
+		rk3036_codec_hpl_mixer_controls,
+		ARRAY_SIZE(rk3036_codec_hpl_mixer_controls)),
+	SND_SOC_DAPM_MIXER("Right Headphone Mixer", SND_SOC_NOPM, 0, 0,
+		rk3036_codec_hpr_mixer_controls,
+		ARRAY_SIZE(rk3036_codec_hpr_mixer_controls)),
+
+	SND_SOC_DAPM_PGA("HP Left Out", INNO_R05,
+			 INNO_R05_HPL_EN_SHIFT, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("HP Right Out", INNO_R05,
+			 INNO_R05_HPR_EN_SHIFT, 0, NULL, 0),
+
+	SND_SOC_DAPM_MIXER("HP Left Switch",  SND_SOC_NOPM, 0, 0,
+			   rk3036_codec_hpl_switch_controls,
+			   ARRAY_SIZE(rk3036_codec_hpl_switch_controls)),
+	SND_SOC_DAPM_MIXER("HP Right Switch",  SND_SOC_NOPM, 0, 0,
+			   rk3036_codec_hpr_switch_controls,
+			   ARRAY_SIZE(rk3036_codec_hpr_switch_controls)),
+
+	SND_SOC_DAPM_OUTPUT("HPL"),
+	SND_SOC_DAPM_OUTPUT("HPR"),
+};
+
+static const struct snd_soc_dapm_route rk3036_codec_dapm_routes[] = {
+	{"DACL VREF", NULL, "DAC PWR"},
+	{"DACR VREF", NULL, "DAC PWR"},
+	{"DACL HiLo VREF", NULL, "DAC PWR"},
+	{"DACR HiLo VREF", NULL, "DAC PWR"},
+	{"DACL CLK", NULL, "DAC PWR"},
+	{"DACR CLK", NULL, "DAC PWR"},
+
+	{"DACL", NULL, "DACL VREF"},
+	{"DACL", NULL, "DACL HiLo VREF"},
+	{"DACL", NULL, "DACL CLK"},
+	{"DACR", NULL, "DACR VREF"},
+	{"DACR", NULL, "DACR HiLo VREF"},
+	{"DACR", NULL, "DACR CLK"},
+
+	{"Left Headphone Mixer", "DAC Left Out Switch", "DACL"},
+	{"Right Headphone Mixer", "DAC Right Out Switch", "DACR"},
+	{"HP Left Out", NULL, "Left Headphone Mixer"},
+	{"HP Right Out", NULL, "Right Headphone Mixer"},
+
+	{"HP Left Switch", "HP Left Out Switch", "HP Left Out"},
+	{"HP Right Switch", "HP Right Out Switch", "HP Right Out"},
+
+	{"HPL", NULL, "HP Left Switch"},
+	{"HPR", NULL, "HP Right Switch"},
+};
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
+		reg01_val |= INNO_R01_PINDIR_IN_SLAVE |
+			     INNO_R01_I2SMODE_SLAVE;
+		break;
+	case SND_SOC_DAIFMT_CBM_CFM:
+		reg01_val |= INNO_R01_PINDIR_OUT_MASTER |
+			     INNO_R01_I2SMODE_MASTER;
+		break;
+	default:
+		dev_err(codec->dev, "invalid fmt\n");
+		return -EINVAL;
+	}
+
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_DSP_A:
+		reg02_val |= INNO_R02_DACM_PCM;
+		break;
+	case SND_SOC_DAIFMT_I2S:
+		reg02_val |= INNO_R02_DACM_I2S;
+		break;
+	case SND_SOC_DAIFMT_RIGHT_J:
+		reg02_val |= INNO_R02_DACM_RJM;
+		break;
+	case SND_SOC_DAIFMT_LEFT_J:
+		reg02_val |= INNO_R02_DACM_LJM;
+		break;
+	default:
+		dev_err(codec->dev, "set dai format failed\n");
+		return -EINVAL;
+	}
+
+	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
+	case SND_SOC_DAIFMT_NB_NF:
+		reg02_val |= INNO_R02_LRCP_NORMAL;
+		reg03_val |= INNO_R03_BCP_NORMAL;
+		break;
+	case SND_SOC_DAIFMT_IB_IF:
+		reg02_val |= INNO_R02_LRCP_REVERSAL;
+		reg03_val |= INNO_R03_BCP_REVERSAL;
+		break;
+	case SND_SOC_DAIFMT_IB_NF:
+		reg02_val |= INNO_R02_LRCP_REVERSAL;
+		reg03_val |= INNO_R03_BCP_NORMAL;
+		break;
+	case SND_SOC_DAIFMT_NB_IF:
+		reg02_val |= INNO_R02_LRCP_NORMAL;
+		reg03_val |= INNO_R03_BCP_REVERSAL;
+		break;
+	default:
+		dev_err(codec->dev, "set dai format failed\n");
+		return -EINVAL;
+	}
+
+	snd_soc_update_bits(codec, INNO_R01, INNO_R01_I2SMODE_MSK |
+			    INNO_R01_PINDIR_MSK, reg01_val);
+	snd_soc_update_bits(codec, INNO_R02, INNO_R02_LRCP_MSK |
+			    INNO_R02_DACM_MSK, reg02_val);
+	snd_soc_update_bits(codec, INNO_R03, INNO_R03_BCP_MSK, reg03_val);
+
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
+	switch (params_format(hw_params)) {
+	case SNDRV_PCM_FORMAT_S16_LE:
+		reg02_val |= INNO_R02_VWL_16BIT;
+		break;
+	case SNDRV_PCM_FORMAT_S20_3LE:
+		reg02_val |= INNO_R02_VWL_20BIT;
+		break;
+	case SNDRV_PCM_FORMAT_S24_LE:
+		reg02_val |= INNO_R02_VWL_24BIT;
+		break;
+	case SNDRV_PCM_FORMAT_S32_LE:
+		reg02_val |= INNO_R02_VWL_32BIT;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	reg02_val |= INNO_R02_LRCP_NORMAL;
+	reg03_val |= INNO_R03_FWL_32BIT | INNO_R03_DACR_WORK;
+
+	snd_soc_update_bits(codec, INNO_R02, INNO_R02_LRCP_MSK |
+			    INNO_R02_VWL_MSK, reg02_val);
+	snd_soc_update_bits(codec, INNO_R03, INNO_R03_DACR_MSK |
+			    INNO_R03_FWL_MSK, reg03_val);
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
+static struct snd_soc_dai_ops rk3036_codec_dai_ops = {
+	.set_fmt	= rk3036_codec_dai_set_fmt,
+	.hw_params	= rk3036_codec_dai_hw_params,
+};
+
+static struct snd_soc_dai_driver rk3036_codec_dai_driver[] = {
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
+	snd_soc_write(codec, INNO_R00,
+		      INNO_R00_CSR_RESET | INNO_R00_CDCR_RESET);
+	snd_soc_write(codec, INNO_R00,
+		      INNO_R00_CSR_WORK | INNO_R00_CDCR_WORK);
+}
+
+static int rk3036_codec_probe(struct snd_soc_codec *codec)
+{
+	rk3036_codec_reset(codec);
+	return 0;
+}
+
+static int rk3036_codec_remove(struct snd_soc_codec *codec)
+{
+	rk3036_codec_reset(codec);
+	return 0;
+}
+
+static int rk3036_codec_set_bias_level(struct snd_soc_codec *codec,
+				       enum snd_soc_bias_level level)
+{
+	switch (level) {
+	case SND_SOC_BIAS_STANDBY:
+		/* set a big current for capacitor charging. */
+		snd_soc_write(codec, INNO_R10, INNO_R10_MAX_CUR);
+		/* start precharge */
+		snd_soc_write(codec, INNO_R06, INNO_R06_DAC_PRECHARGE);
+
+		break;
+
+	case SND_SOC_BIAS_OFF:
+		/* set a big current for capacitor discharging. */
+		snd_soc_write(codec, INNO_R10, INNO_R10_MAX_CUR);
+		/* start discharge. */
+		snd_soc_write(codec, INNO_R06, INNO_R06_DAC_DISCHARGE);
+
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static struct snd_soc_codec_driver rk3036_codec_driver = {
+	.probe			= rk3036_codec_probe,
+	.remove			= rk3036_codec_remove,
+	.set_bias_level		= rk3036_codec_set_bias_level,
+	.controls		= rk3036_codec_dapm_controls,
+	.num_controls		= ARRAY_SIZE(rk3036_codec_dapm_controls),
+	.dapm_routes		= rk3036_codec_dapm_routes,
+	.num_dapm_routes	= ARRAY_SIZE(rk3036_codec_dapm_routes),
+	.dapm_widgets		= rk3036_codec_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(rk3036_codec_dapm_widgets),
+};
+
+static const struct regmap_config rk3036_codec_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+};
+
+#define GRF_SOC_CON0		0x00140
+#define GRF_ACODEC_SEL		(BIT(10) | BIT(16 + 10))
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
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	priv->base = base;
+	priv->regmap = devm_regmap_init_mmio(&pdev->dev, priv->base,
+					     &rk3036_codec_regmap_config);
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
+	ret = regmap_write(grf, GRF_SOC_CON0, GRF_ACODEC_SEL);
+	if (ret) {
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
+	snd_soc_unregister_codec(&pdev->dev);
+	clk_disable_unprepare(priv->pclk);
+
+	return 0;
+}
+
+static const struct of_device_id rk3036_codec_of_match[] = {
+	{ .compatible = "rockchip,rk3036-codec", },
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
+};
+
+module_platform_driver(rk3036_codec_platform_driver);
+
+MODULE_AUTHOR("Rockchip Inc.");
+MODULE_DESCRIPTION("Rockchip rk3036 codec driver");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/inno_rk3036.h b/sound/soc/codecs/inno_rk3036.h
new file mode 100644
index 0000000..92528a3
--- /dev/null
+++ b/sound/soc/codecs/inno_rk3036.h
@@ -0,0 +1,120 @@
+/*
+ * Driver of Inno Codec for rk3036 by Rockchip Inc.
+ *
+ * Author: Zheng ShunQian<zhengsq@rock-chips.com>
+ */
+
+#ifndef _INNO_RK3036_CODEC_H
+#define _INNO_RK3036_CODEC_H
+
+/* codec registers */
+#define INNO_R00	0x00
+#define INNO_R01	0x0c
+#define INNO_R02	0x10
+#define INNO_R03	0x14
+#define INNO_R04	0x88
+#define INNO_R05	0x8c
+#define INNO_R06	0x90
+#define INNO_R07	0x94
+#define INNO_R08	0x98
+#define INNO_R09	0x9c
+#define INNO_R10	0xa0
+
+/* register bit filed */
+#define INNO_R00_CSR_RESET		(0x0 << 0) /*codec system reset*/
+#define INNO_R00_CSR_WORK		(0x1 << 0)
+#define INNO_R00_CDCR_RESET		(0x0 << 1) /*codec digital core reset*/
+#define INNO_R00_CDCR_WORK		(0x1 << 1)
+#define INNO_R00_PRB_DISABLE		(0x0 << 6) /*power reset bypass*/
+#define INNO_R00_PRB_ENABLE		(0x1 << 6)
+
+#define INNO_R01_I2SMODE_MSK		(0x1 << 4)
+#define INNO_R01_I2SMODE_SLAVE		(0x0 << 4)
+#define INNO_R01_I2SMODE_MASTER		(0x1 << 4)
+#define INNO_R01_PINDIR_MSK		(0x1 << 5)
+#define INNO_R01_PINDIR_IN_SLAVE	(0x0 << 5) /*direction of pin*/
+#define INNO_R01_PINDIR_OUT_MASTER	(0x1 << 5)
+
+#define INNO_R02_LRS_MSK		(0x1 << 2)
+#define INNO_R02_LRS_NORMAL		(0x0 << 2) /*DAC Left Right Swap*/
+#define INNO_R02_LRS_SWAP		(0x1 << 2)
+#define INNO_R02_DACM_MSK		(0x3 << 3)
+#define INNO_R02_DACM_PCM		(0x3 << 3) /*DAC Mode*/
+#define INNO_R02_DACM_I2S		(0x2 << 3)
+#define INNO_R02_DACM_LJM		(0x1 << 3)
+#define INNO_R02_DACM_RJM		(0x0 << 3)
+#define INNO_R02_VWL_MSK		(0x3 << 5)
+#define INNO_R02_VWL_32BIT		(0x3 << 5) /*1/2Frame Valid Word Len*/
+#define INNO_R02_VWL_24BIT		(0x2 << 5)
+#define INNO_R02_VWL_20BIT		(0x1 << 5)
+#define INNO_R02_VWL_16BIT		(0x0 << 5)
+#define INNO_R02_LRCP_MSK		(0x1 << 7)
+#define INNO_R02_LRCP_NORMAL		(0x0 << 7) /*Left Right Polarity*/
+#define INNO_R02_LRCP_REVERSAL		(0x1 << 7)
+
+#define INNO_R03_BCP_MSK		(0x1 << 0)
+#define INNO_R03_BCP_NORMAL		(0x0 << 0) /*DAC bit clock polarity*/
+#define INNO_R03_BCP_REVERSAL		(0x1 << 0)
+#define INNO_R03_DACR_MSK		(0x1 << 1)
+#define INNO_R03_DACR_RESET		(0x0 << 1) /*DAC Reset*/
+#define INNO_R03_DACR_WORK		(0x1 << 1)
+#define INNO_R03_FWL_MSK		(0x3 << 2)
+#define INNO_R03_FWL_32BIT		(0x3 << 2) /*1/2Frame Word Length*/
+#define INNO_R03_FWL_24BIT		(0x2 << 2)
+#define INNO_R03_FWL_20BIT		(0x1 << 2)
+#define INNO_R03_FWL_16BIT		(0x0 << 2)
+
+#define INNO_R04_DACR_SW_SHIFT		0
+#define INNO_R04_DACL_SW_SHIFT		1
+#define INNO_R04_DACR_CLK_SHIFT		2
+#define INNO_R04_DACL_CLK_SHIFT		3
+#define INNO_R04_DACR_VREF_SHIFT	4
+#define INNO_R04_DACL_VREF_SHIFT	5
+
+#define INNO_R05_HPR_EN_SHIFT		0
+#define INNO_R05_HPL_EN_SHIFT		1
+#define INNO_R05_HPR_WORK_SHIFT		2
+#define INNO_R05_HPL_WORK_SHIFT		3
+
+#define INNO_R06_VOUTR_CZ_SHIFT		0
+#define INNO_R06_VOUTL_CZ_SHIFT		1
+#define INNO_R06_DACR_HILO_VREF_SHIFT	2
+#define INNO_R06_DACL_HILO_VREF_SHIFT	3
+#define INNO_R06_DAC_EN_SHIFT		5
+
+#define INNO_R06_DAC_PRECHARGE		(0x0 << 4) /*PreCharge control for DAC*/
+#define INNO_R06_DAC_DISCHARGE		(0x1 << 4)
+
+#define INNO_HP_GAIN_SHIFT		0
+/* Gain of output, 1.5db step: -39db(0x0) ~ 0db(0x1a) ~ 6db(0x1f) */
+#define INNO_HP_GAIN_0DB		0x1a
+#define INNO_HP_GAIN_N39DB		0x0
+
+#define INNO_R09_HPR_ANITPOP_SHIFT	0
+#define INNO_R09_HPL_ANITPOP_SHIFT	2
+#define INNO_R09_HPR_MUTE_SHIFT		4
+#define INNO_R09_HPL_MUTE_SHIFT		5
+#define INNO_R09_DACR_SWITCH_SHIFT	6
+#define INNO_R09_DACL_SWITCH_SHIFT	7
+
+#define INNO_R10_CHARGE_SEL_CUR_400I_YES	(0x0 << 0)
+#define INNO_R10_CHARGE_SEL_CUR_400I_NO		(0x1 << 0)
+#define INNO_R10_CHARGE_SEL_CUR_260I_YES	(0x0 << 1)
+#define INNO_R10_CHARGE_SEL_CUR_260I_NO		(0x1 << 1)
+#define INNO_R10_CHARGE_SEL_CUR_130I_YES	(0x0 << 2)
+#define INNO_R10_CHARGE_SEL_CUR_130I_NO		(0x1 << 2)
+#define INNO_R10_CHARGE_SEL_CUR_100I_YES	(0x0 << 3)
+#define INNO_R10_CHARGE_SEL_CUR_100I_NO		(0x1 << 3)
+#define INNO_R10_CHARGE_SEL_CUR_050I_YES	(0x0 << 4)
+#define INNO_R10_CHARGE_SEL_CUR_050I_NO		(0x1 << 4)
+#define INNO_R10_CHARGE_SEL_CUR_027I_YES	(0x0 << 5)
+#define INNO_R10_CHARGE_SEL_CUR_027I_NO		(0x1 << 5)
+
+#define INNO_R10_MAX_CUR (INNO_R10_CHARGE_SEL_CUR_400I_YES | \
+			  INNO_R10_CHARGE_SEL_CUR_260I_YES | \
+			  INNO_R10_CHARGE_SEL_CUR_130I_YES | \
+			  INNO_R10_CHARGE_SEL_CUR_100I_YES | \
+			  INNO_R10_CHARGE_SEL_CUR_050I_YES | \
+			  INNO_R10_CHARGE_SEL_CUR_027I_YES)
+
+#endif
-- 
1.9.1
