From: broonie@kernel.org (Mark Brown)
Date: Mon, 04 Dec 2017 18:48:42 +0000
Subject: Applied "ASoC: uniphier: add support for UniPhier EVEA codec" to the
 asoc tree
In-Reply-To: <20171122114321.29196-5-suzuki.katsuhiro@socionext.com>
Message-ID: <E1eLvnG-0000IG-7F@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: uniphier: add support for UniPhier EVEA codec

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 3a47b1dfa2913038623cec3164adfb2448269fa6 Mon Sep 17 00:00:00 2001
From: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Date: Wed, 22 Nov 2017 20:43:17 +0900
Subject: [PATCH] ASoC: uniphier: add support for UniPhier EVEA codec

This patch adds EVEA codec driver. This codec core is in inside of
UniPhier SoC.

Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/Kconfig           |   1 +
 sound/soc/Makefile          |   1 +
 sound/soc/uniphier/Kconfig  |  19 ++
 sound/soc/uniphier/Makefile |   3 +
 sound/soc/uniphier/evea.c   | 567 ++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 591 insertions(+)
 create mode 100644 sound/soc/uniphier/Kconfig
 create mode 100644 sound/soc/uniphier/Makefile
 create mode 100644 sound/soc/uniphier/evea.c

diff --git a/sound/soc/Kconfig b/sound/soc/Kconfig
index d22758165496..84c3582f3982 100644
--- a/sound/soc/Kconfig
+++ b/sound/soc/Kconfig
@@ -71,6 +71,7 @@ source "sound/soc/stm/Kconfig"
 source "sound/soc/sunxi/Kconfig"
 source "sound/soc/tegra/Kconfig"
 source "sound/soc/txx9/Kconfig"
+source "sound/soc/uniphier/Kconfig"
 source "sound/soc/ux500/Kconfig"
 source "sound/soc/xtensa/Kconfig"
 source "sound/soc/zte/Kconfig"
diff --git a/sound/soc/Makefile b/sound/soc/Makefile
index 5327f4d6c668..74cd1858d38b 100644
--- a/sound/soc/Makefile
+++ b/sound/soc/Makefile
@@ -55,6 +55,7 @@ obj-$(CONFIG_SND_SOC)	+= stm/
 obj-$(CONFIG_SND_SOC)	+= sunxi/
 obj-$(CONFIG_SND_SOC)	+= tegra/
 obj-$(CONFIG_SND_SOC)	+= txx9/
+obj-$(CONFIG_SND_SOC)	+= uniphier/
 obj-$(CONFIG_SND_SOC)	+= ux500/
 obj-$(CONFIG_SND_SOC)	+= xtensa/
 obj-$(CONFIG_SND_SOC)	+= zte/
diff --git a/sound/soc/uniphier/Kconfig b/sound/soc/uniphier/Kconfig
new file mode 100644
index 000000000000..02886a457eaf
--- /dev/null
+++ b/sound/soc/uniphier/Kconfig
@@ -0,0 +1,19 @@
+# SPDX-License-Identifier: GPL-2.0
+config SND_SOC_UNIPHIER
+	tristate "ASoC support for UniPhier"
+	depends on (ARCH_UNIPHIER || COMPILE_TEST)
+	help
+	  Say Y or M if you want to add support for the Socionext
+	  UniPhier SoC audio interfaces. You will also need to select the
+	  audio interfaces to support below.
+	  If unsure select "N".
+
+config SND_SOC_UNIPHIER_EVEA_CODEC
+	tristate "UniPhier SoC internal audio codec"
+	depends on SND_SOC_UNIPHIER
+	select REGMAP_MMIO
+	help
+	  This adds Codec driver for Socionext UniPhier LD11/20 SoC
+	  internal DAC. This driver supports Line In / Out and HeadPhone.
+	  Select Y if you use such device.
+	  If unsure select "N".
diff --git a/sound/soc/uniphier/Makefile b/sound/soc/uniphier/Makefile
new file mode 100644
index 000000000000..3be00d72f5e5
--- /dev/null
+++ b/sound/soc/uniphier/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+snd-soc-uniphier-evea-objs := evea.o
+obj-$(CONFIG_SND_SOC_UNIPHIER_EVEA_CODEC) += snd-soc-uniphier-evea.o
diff --git a/sound/soc/uniphier/evea.c b/sound/soc/uniphier/evea.c
new file mode 100644
index 000000000000..0cc9efff1d9a
--- /dev/null
+++ b/sound/soc/uniphier/evea.c
@@ -0,0 +1,567 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Socionext UniPhier EVEA ADC/DAC codec driver.
+ *
+ * Copyright (c) 2016-2017 Socionext Inc.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; version 2
+ * of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/clk.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/regmap.h>
+#include <linux/reset.h>
+#include <sound/pcm.h>
+#include <sound/soc.h>
+
+#define DRV_NAME        "evea"
+#define EVEA_RATES      SNDRV_PCM_RATE_48000
+#define EVEA_FORMATS    SNDRV_PCM_FMTBIT_S32_LE
+
+#define AADCPOW(n)                           (0x0078 + 0x04 * (n))
+#define   AADCPOW_AADC_POWD                   BIT(0)
+#define AHPOUTPOW                            0x0098
+#define   AHPOUTPOW_HP_ON                     BIT(4)
+#define ALINEPOW                             0x009c
+#define   ALINEPOW_LIN2_POWD                  BIT(3)
+#define   ALINEPOW_LIN1_POWD                  BIT(4)
+#define ALO1OUTPOW                           0x00a8
+#define   ALO1OUTPOW_LO1_ON                   BIT(4)
+#define ALO2OUTPOW                           0x00ac
+#define   ALO2OUTPOW_ADAC2_MUTE               BIT(0)
+#define   ALO2OUTPOW_LO2_ON                   BIT(4)
+#define AANAPOW                              0x00b8
+#define   AANAPOW_A_POWD                      BIT(4)
+#define ADACSEQ1(n)                          (0x0144 + 0x40 * (n))
+#define   ADACSEQ1_MMUTE                      BIT(1)
+#define ADACSEQ2(n)                          (0x0160 + 0x40 * (n))
+#define   ADACSEQ2_ADACIN_FIX                 BIT(0)
+#define ADAC1ODC                             0x0200
+#define   ADAC1ODC_HP_DIS_RES_MASK            GENMASK(2, 1)
+#define   ADAC1ODC_HP_DIS_RES_OFF             (0x0 << 1)
+#define   ADAC1ODC_HP_DIS_RES_ON              (0x3 << 1)
+#define   ADAC1ODC_ADAC_RAMPCLT_MASK          GENMASK(8, 7)
+#define   ADAC1ODC_ADAC_RAMPCLT_NORMAL        (0x0 << 7)
+#define   ADAC1ODC_ADAC_RAMPCLT_REDUCE        (0x1 << 7)
+
+struct evea_priv {
+	struct clk *clk, *clk_exiv;
+	struct reset_control *rst, *rst_exiv, *rst_adamv;
+	struct regmap *regmap;
+
+	int switch_lin;
+	int switch_lo;
+	int switch_hp;
+};
+
+static const struct snd_soc_dapm_widget evea_widgets[] = {
+	SND_SOC_DAPM_ADC("ADC", "Capture", SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_INPUT("LIN1_LP"),
+	SND_SOC_DAPM_INPUT("LIN1_RP"),
+	SND_SOC_DAPM_INPUT("LIN2_LP"),
+	SND_SOC_DAPM_INPUT("LIN2_RP"),
+	SND_SOC_DAPM_INPUT("LIN3_LP"),
+	SND_SOC_DAPM_INPUT("LIN3_RP"),
+
+	SND_SOC_DAPM_DAC("DAC", "Playback", SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_OUTPUT("HP1_L"),
+	SND_SOC_DAPM_OUTPUT("HP1_R"),
+	SND_SOC_DAPM_OUTPUT("LO2_L"),
+	SND_SOC_DAPM_OUTPUT("LO2_R"),
+};
+
+static const struct snd_soc_dapm_route evea_routes[] = {
+	{ "ADC", NULL, "LIN1_LP" },
+	{ "ADC", NULL, "LIN1_RP" },
+	{ "ADC", NULL, "LIN2_LP" },
+	{ "ADC", NULL, "LIN2_RP" },
+	{ "ADC", NULL, "LIN3_LP" },
+	{ "ADC", NULL, "LIN3_RP" },
+
+	{ "HP1_L", NULL, "DAC" },
+	{ "HP1_R", NULL, "DAC" },
+	{ "LO2_L", NULL, "DAC" },
+	{ "LO2_R", NULL, "DAC" },
+};
+
+static void evea_set_power_state_on(struct evea_priv *evea)
+{
+	struct regmap *map = evea->regmap;
+
+	regmap_update_bits(map, AANAPOW, AANAPOW_A_POWD,
+			   AANAPOW_A_POWD);
+
+	regmap_update_bits(map, ADAC1ODC, ADAC1ODC_HP_DIS_RES_MASK,
+			   ADAC1ODC_HP_DIS_RES_ON);
+
+	regmap_update_bits(map, ADAC1ODC, ADAC1ODC_ADAC_RAMPCLT_MASK,
+			   ADAC1ODC_ADAC_RAMPCLT_REDUCE);
+
+	regmap_update_bits(map, ADACSEQ2(0), ADACSEQ2_ADACIN_FIX, 0);
+	regmap_update_bits(map, ADACSEQ2(1), ADACSEQ2_ADACIN_FIX, 0);
+	regmap_update_bits(map, ADACSEQ2(2), ADACSEQ2_ADACIN_FIX, 0);
+}
+
+static void evea_set_power_state_off(struct evea_priv *evea)
+{
+	struct regmap *map = evea->regmap;
+
+	regmap_update_bits(map, ADAC1ODC, ADAC1ODC_HP_DIS_RES_MASK,
+			   ADAC1ODC_HP_DIS_RES_ON);
+
+	regmap_update_bits(map, ADACSEQ1(0), ADACSEQ1_MMUTE,
+			   ADACSEQ1_MMUTE);
+	regmap_update_bits(map, ADACSEQ1(1), ADACSEQ1_MMUTE,
+			   ADACSEQ1_MMUTE);
+	regmap_update_bits(map, ADACSEQ1(2), ADACSEQ1_MMUTE,
+			   ADACSEQ1_MMUTE);
+
+	regmap_update_bits(map, ALO1OUTPOW, ALO1OUTPOW_LO1_ON, 0);
+	regmap_update_bits(map, ALO2OUTPOW, ALO2OUTPOW_LO2_ON, 0);
+	regmap_update_bits(map, AHPOUTPOW, AHPOUTPOW_HP_ON, 0);
+}
+
+static int evea_update_switch_lin(struct evea_priv *evea)
+{
+	struct regmap *map = evea->regmap;
+
+	if (evea->switch_lin) {
+		regmap_update_bits(map, ALINEPOW,
+				   ALINEPOW_LIN2_POWD | ALINEPOW_LIN1_POWD,
+				   ALINEPOW_LIN2_POWD | ALINEPOW_LIN1_POWD);
+
+		regmap_update_bits(map, AADCPOW(0), AADCPOW_AADC_POWD,
+				   AADCPOW_AADC_POWD);
+		regmap_update_bits(map, AADCPOW(1), AADCPOW_AADC_POWD,
+				   AADCPOW_AADC_POWD);
+	} else {
+		regmap_update_bits(map, AADCPOW(0), AADCPOW_AADC_POWD, 0);
+		regmap_update_bits(map, AADCPOW(1), AADCPOW_AADC_POWD, 0);
+
+		regmap_update_bits(map, ALINEPOW,
+				   ALINEPOW_LIN2_POWD | ALINEPOW_LIN1_POWD, 0);
+	}
+
+	return 0;
+}
+
+static int evea_update_switch_lo(struct evea_priv *evea)
+{
+	struct regmap *map = evea->regmap;
+
+	if (evea->switch_lo) {
+		regmap_update_bits(map, ADACSEQ1(0), ADACSEQ1_MMUTE, 0);
+		regmap_update_bits(map, ADACSEQ1(2), ADACSEQ1_MMUTE, 0);
+
+		regmap_update_bits(map, ALO1OUTPOW, ALO1OUTPOW_LO1_ON,
+				   ALO1OUTPOW_LO1_ON);
+		regmap_update_bits(map, ALO2OUTPOW,
+				   ALO2OUTPOW_ADAC2_MUTE | ALO2OUTPOW_LO2_ON,
+				   ALO2OUTPOW_ADAC2_MUTE | ALO2OUTPOW_LO2_ON);
+	} else {
+		regmap_update_bits(map, ADACSEQ1(0), ADACSEQ1_MMUTE,
+				   ADACSEQ1_MMUTE);
+		regmap_update_bits(map, ADACSEQ1(2), ADACSEQ1_MMUTE,
+				   ADACSEQ1_MMUTE);
+
+		regmap_update_bits(map, ALO1OUTPOW, ALO1OUTPOW_LO1_ON, 0);
+		regmap_update_bits(map, ALO2OUTPOW,
+				   ALO2OUTPOW_ADAC2_MUTE | ALO2OUTPOW_LO2_ON,
+				   0);
+	}
+
+	return 0;
+}
+
+static int evea_update_switch_hp(struct evea_priv *evea)
+{
+	struct regmap *map = evea->regmap;
+
+	if (evea->switch_hp) {
+		regmap_update_bits(map, ADACSEQ1(1), ADACSEQ1_MMUTE, 0);
+
+		regmap_update_bits(map, AHPOUTPOW, AHPOUTPOW_HP_ON,
+				   AHPOUTPOW_HP_ON);
+
+		regmap_update_bits(map, ADAC1ODC, ADAC1ODC_HP_DIS_RES_MASK,
+				   ADAC1ODC_HP_DIS_RES_OFF);
+	} else {
+		regmap_update_bits(map, ADAC1ODC, ADAC1ODC_HP_DIS_RES_MASK,
+				   ADAC1ODC_HP_DIS_RES_ON);
+
+		regmap_update_bits(map, ADACSEQ1(1), ADACSEQ1_MMUTE,
+				   ADACSEQ1_MMUTE);
+
+		regmap_update_bits(map, AHPOUTPOW, AHPOUTPOW_HP_ON, 0);
+	}
+
+	return 0;
+}
+
+static void evea_update_switch_all(struct evea_priv *evea)
+{
+	evea_update_switch_lin(evea);
+	evea_update_switch_lo(evea);
+	evea_update_switch_hp(evea);
+}
+
+static int evea_get_switch_lin(struct snd_kcontrol *kcontrol,
+			       struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
+	struct evea_priv *evea = snd_soc_codec_get_drvdata(codec);
+
+	ucontrol->value.integer.value[0] = evea->switch_lin;
+
+	return 0;
+}
+
+static int evea_set_switch_lin(struct snd_kcontrol *kcontrol,
+			       struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
+	struct evea_priv *evea = snd_soc_codec_get_drvdata(codec);
+
+	if (evea->switch_lin == ucontrol->value.integer.value[0])
+		return 0;
+
+	evea->switch_lin = ucontrol->value.integer.value[0];
+
+	return evea_update_switch_lin(evea);
+}
+
+static int evea_get_switch_lo(struct snd_kcontrol *kcontrol,
+			      struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
+	struct evea_priv *evea = snd_soc_codec_get_drvdata(codec);
+
+	ucontrol->value.integer.value[0] = evea->switch_lo;
+
+	return 0;
+}
+
+static int evea_set_switch_lo(struct snd_kcontrol *kcontrol,
+			      struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
+	struct evea_priv *evea = snd_soc_codec_get_drvdata(codec);
+
+	if (evea->switch_lo == ucontrol->value.integer.value[0])
+		return 0;
+
+	evea->switch_lo = ucontrol->value.integer.value[0];
+
+	return evea_update_switch_lo(evea);
+}
+
+static int evea_get_switch_hp(struct snd_kcontrol *kcontrol,
+			      struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
+	struct evea_priv *evea = snd_soc_codec_get_drvdata(codec);
+
+	ucontrol->value.integer.value[0] = evea->switch_hp;
+
+	return 0;
+}
+
+static int evea_set_switch_hp(struct snd_kcontrol *kcontrol,
+			      struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
+	struct evea_priv *evea = snd_soc_codec_get_drvdata(codec);
+
+	if (evea->switch_hp == ucontrol->value.integer.value[0])
+		return 0;
+
+	evea->switch_hp = ucontrol->value.integer.value[0];
+
+	return evea_update_switch_hp(evea);
+}
+
+static const struct snd_kcontrol_new eva_controls[] = {
+	SOC_SINGLE_BOOL_EXT("Line Capture Switch", 0,
+			    evea_get_switch_lin, evea_set_switch_lin),
+	SOC_SINGLE_BOOL_EXT("Line Playback Switch", 0,
+			    evea_get_switch_lo, evea_set_switch_lo),
+	SOC_SINGLE_BOOL_EXT("Headphone Playback Switch", 0,
+			    evea_get_switch_hp, evea_set_switch_hp),
+};
+
+static int evea_codec_probe(struct snd_soc_codec *codec)
+{
+	struct evea_priv *evea = snd_soc_codec_get_drvdata(codec);
+
+	evea->switch_lin = 1;
+	evea->switch_lo = 1;
+	evea->switch_hp = 1;
+
+	evea_set_power_state_on(evea);
+	evea_update_switch_all(evea);
+
+	return 0;
+}
+
+static int evea_codec_suspend(struct snd_soc_codec *codec)
+{
+	struct evea_priv *evea = snd_soc_codec_get_drvdata(codec);
+
+	evea_set_power_state_off(evea);
+
+	reset_control_assert(evea->rst_adamv);
+	reset_control_assert(evea->rst_exiv);
+	reset_control_assert(evea->rst);
+
+	clk_disable_unprepare(evea->clk_exiv);
+	clk_disable_unprepare(evea->clk);
+
+	return 0;
+}
+
+static int evea_codec_resume(struct snd_soc_codec *codec)
+{
+	struct evea_priv *evea = snd_soc_codec_get_drvdata(codec);
+	int ret;
+
+	ret = clk_prepare_enable(evea->clk);
+	if (ret)
+		return ret;
+
+	ret = clk_prepare_enable(evea->clk_exiv);
+	if (ret)
+		goto err_out_clock;
+
+	ret = reset_control_deassert(evea->rst);
+	if (ret)
+		goto err_out_clock_exiv;
+
+	ret = reset_control_deassert(evea->rst_exiv);
+	if (ret)
+		goto err_out_reset;
+
+	ret = reset_control_deassert(evea->rst_adamv);
+	if (ret)
+		goto err_out_reset_exiv;
+
+	evea_set_power_state_on(evea);
+	evea_update_switch_all(evea);
+
+	return 0;
+
+err_out_reset_exiv:
+	reset_control_assert(evea->rst_exiv);
+
+err_out_reset:
+	reset_control_assert(evea->rst);
+
+err_out_clock_exiv:
+	clk_disable_unprepare(evea->clk_exiv);
+
+err_out_clock:
+	clk_disable_unprepare(evea->clk);
+
+	return ret;
+}
+
+static struct snd_soc_codec_driver soc_codec_evea = {
+	.probe   = evea_codec_probe,
+	.suspend = evea_codec_suspend,
+	.resume  = evea_codec_resume,
+
+	.component_driver = {
+		.dapm_widgets = evea_widgets,
+		.num_dapm_widgets = ARRAY_SIZE(evea_widgets),
+		.dapm_routes = evea_routes,
+		.num_dapm_routes = ARRAY_SIZE(evea_routes),
+		.controls = eva_controls,
+		.num_controls = ARRAY_SIZE(eva_controls),
+	},
+};
+
+static struct snd_soc_dai_driver soc_dai_evea[] = {
+	{
+		.name     = DRV_NAME "-line1",
+		.playback = {
+			.stream_name  = "Line Out 1",
+			.formats      = EVEA_FORMATS,
+			.rates        = EVEA_RATES,
+			.channels_min = 2,
+			.channels_max = 2,
+		},
+		.capture = {
+			.stream_name  = "Line In 1",
+			.formats      = EVEA_FORMATS,
+			.rates        = EVEA_RATES,
+			.channels_min = 2,
+			.channels_max = 2,
+		},
+	},
+	{
+		.name     = DRV_NAME "-hp1",
+		.playback = {
+			.stream_name  = "Headphone 1",
+			.formats      = EVEA_FORMATS,
+			.rates        = EVEA_RATES,
+			.channels_min = 2,
+			.channels_max = 2,
+		},
+	},
+	{
+		.name     = DRV_NAME "-lo2",
+		.playback = {
+			.stream_name  = "Line Out 2",
+			.formats      = EVEA_FORMATS,
+			.rates        = EVEA_RATES,
+			.channels_min = 2,
+			.channels_max = 2,
+		},
+	},
+};
+
+static const struct regmap_config evea_regmap_config = {
+	.reg_bits      = 32,
+	.reg_stride    = 4,
+	.val_bits      = 32,
+	.max_register  = 0xffc,
+	.cache_type    = REGCACHE_NONE,
+};
+
+static int evea_probe(struct platform_device *pdev)
+{
+	struct evea_priv *evea;
+	struct resource *res;
+	void __iomem *preg;
+	int ret;
+
+	evea = devm_kzalloc(&pdev->dev, sizeof(struct evea_priv), GFP_KERNEL);
+	if (!evea)
+		return -ENOMEM;
+
+	evea->clk = devm_clk_get(&pdev->dev, "evea");
+	if (IS_ERR(evea->clk))
+		return PTR_ERR(evea->clk);
+
+	evea->clk_exiv = devm_clk_get(&pdev->dev, "exiv");
+	if (IS_ERR(evea->clk_exiv))
+		return PTR_ERR(evea->clk_exiv);
+
+	evea->rst = devm_reset_control_get_shared(&pdev->dev, "evea");
+	if (IS_ERR(evea->rst))
+		return PTR_ERR(evea->rst);
+
+	evea->rst_exiv = devm_reset_control_get_shared(&pdev->dev, "exiv");
+	if (IS_ERR(evea->rst_exiv))
+		return PTR_ERR(evea->rst_exiv);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	preg = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(preg))
+		return PTR_ERR(preg);
+
+	evea->regmap = devm_regmap_init_mmio(&pdev->dev, preg,
+					     &evea_regmap_config);
+	if (IS_ERR(evea->regmap))
+		return PTR_ERR(evea->regmap);
+
+	ret = clk_prepare_enable(evea->clk);
+	if (ret)
+		return ret;
+
+	ret = clk_prepare_enable(evea->clk_exiv);
+	if (ret)
+		goto err_out_clock;
+
+	ret = reset_control_deassert(evea->rst);
+	if (ret)
+		goto err_out_clock_exiv;
+
+	ret = reset_control_deassert(evea->rst_exiv);
+	if (ret)
+		goto err_out_reset;
+
+	/* ADAMV will hangup if EXIV reset is asserted */
+	evea->rst_adamv = devm_reset_control_get_shared(&pdev->dev, "adamv");
+	if (IS_ERR(evea->rst_adamv)) {
+		ret = PTR_ERR(evea->rst_adamv);
+		goto err_out_reset_exiv;
+	}
+
+	ret = reset_control_deassert(evea->rst_adamv);
+	if (ret)
+		goto err_out_reset_exiv;
+
+	platform_set_drvdata(pdev, evea);
+
+	ret = snd_soc_register_codec(&pdev->dev, &soc_codec_evea,
+				     soc_dai_evea, ARRAY_SIZE(soc_dai_evea));
+	if (ret)
+		goto err_out_reset_adamv;
+
+	return 0;
+
+err_out_reset_adamv:
+	reset_control_assert(evea->rst_adamv);
+
+err_out_reset_exiv:
+	reset_control_assert(evea->rst_exiv);
+
+err_out_reset:
+	reset_control_assert(evea->rst);
+
+err_out_clock_exiv:
+	clk_disable_unprepare(evea->clk_exiv);
+
+err_out_clock:
+	clk_disable_unprepare(evea->clk);
+
+	return ret;
+}
+
+static int evea_remove(struct platform_device *pdev)
+{
+	struct evea_priv *evea = platform_get_drvdata(pdev);
+
+	snd_soc_unregister_codec(&pdev->dev);
+
+	reset_control_assert(evea->rst_adamv);
+	reset_control_assert(evea->rst_exiv);
+	reset_control_assert(evea->rst);
+
+	clk_disable_unprepare(evea->clk_exiv);
+	clk_disable_unprepare(evea->clk);
+
+	return 0;
+}
+
+static const struct of_device_id evea_of_match[] = {
+	{ .compatible = "socionext,uniphier-evea", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, evea_of_match);
+
+static struct platform_driver evea_codec_driver = {
+	.driver = {
+		.name = DRV_NAME,
+		.of_match_table = of_match_ptr(evea_of_match),
+	},
+	.probe  = evea_probe,
+	.remove = evea_remove,
+};
+module_platform_driver(evea_codec_driver);
+
+MODULE_AUTHOR("Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>");
+MODULE_DESCRIPTION("UniPhier EVEA codec driver");
+MODULE_LICENSE("GPL v2");
-- 
2.15.0
