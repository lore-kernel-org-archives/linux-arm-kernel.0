From: subaparts@yandex.ru (Alexander)
Date: Wed, 08 Dec 2010 15:02:52 +0300
Subject: [PATCH 2/3] ASoC: CS4271 codec support
Message-ID: <1291809772.31916.4.camel@r60e>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Alexander Sverdlin <subaparts@yandex.ru>

Added support for CS4271 codec to ASoC.

Signed-off-by: Alexander Sverdlin <subaparts@yandex.ru>
---
 include/sound/cs4271.h    |   25 ++
 sound/soc/codecs/Kconfig  |    4 +
 sound/soc/codecs/Makefile |    2 +
 sound/soc/codecs/cs4271.c |  607 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 638 insertions(+), 0 deletions(-)

diff --git a/include/sound/cs4271.h b/include/sound/cs4271.h
new file mode 100644
index 0000000..16f8d32
--- /dev/null
+++ b/include/sound/cs4271.h
@@ -0,0 +1,25 @@
+/*
+ * Definitions for CS4271 ASoC codec driver
+ *
+ * Copyright (c) 2010 Alexander Sverdlin <subaparts@yandex.ru>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef __CS4271_H
+#define __CS4271_H
+
+struct cs4271_platform_data {
+	int gpio_nreset;	/* GPIO driving Reset pin, if any */
+	int gpio_disable;	/* GPIO that disable serial bus, if any */
+};
+
+#endif /* __CS4271_H */
diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 0f33db2..b7d7d3c 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -26,6 +26,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_CQ0093VC if MFD_DAVINCI_VOICECODEC
 	select SND_SOC_CS42L51 if I2C
 	select SND_SOC_CS4270 if I2C
+	select SND_SOC_CS4271 if SND_SOC_I2C_AND_SPI
 	select SND_SOC_CX20442
 	select SND_SOC_DA7210 if I2C
 	select SND_SOC_JZ4740_CODEC if SOC_JZ4740
@@ -154,6 +155,9 @@ config SND_SOC_CS4270_VD33_ERRATA
 	bool
 	depends on SND_SOC_CS4270
 
+config SND_SOC_CS4271
+	tristate
+
 config SND_SOC_CX20442
 	tristate
 
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 10e5e09..ec8d0ff 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -12,6 +12,7 @@ snd-soc-ak4671-objs := ak4671.o
 snd-soc-cq93vc-objs := cq93vc.o
 snd-soc-cs42l51-objs := cs42l51.o
 snd-soc-cs4270-objs := cs4270.o
+snd-soc-cs4271-objs := cs4271.o
 snd-soc-cx20442-objs := cx20442.o
 snd-soc-da7210-objs := da7210.o
 snd-soc-l3-objs := l3.o
@@ -89,6 +90,7 @@ obj-$(CONFIG_SND_SOC_AK4671)	+= snd-soc-ak4671.o
 obj-$(CONFIG_SND_SOC_CQ0093VC) += snd-soc-cq93vc.o
 obj-$(CONFIG_SND_SOC_CS42L51)	+= snd-soc-cs42l51.o
 obj-$(CONFIG_SND_SOC_CS4270)	+= snd-soc-cs4270.o
+obj-$(CONFIG_SND_SOC_CS4271)	+= snd-soc-cs4271.o
 obj-$(CONFIG_SND_SOC_CX20442)	+= snd-soc-cx20442.o
 obj-$(CONFIG_SND_SOC_DA7210)	+= snd-soc-da7210.o
 obj-$(CONFIG_SND_SOC_L3)	+= snd-soc-l3.o
diff --git a/sound/soc/codecs/cs4271.c b/sound/soc/codecs/cs4271.c
new file mode 100644
index 0000000..c0d74da
--- /dev/null
+++ b/sound/soc/codecs/cs4271.c
@@ -0,0 +1,607 @@
+/*
+ * CS4271 ASoC codec driver
+ *
+ * Copyright (c) 2010 Alexander Sverdlin <subaparts@yandex.ru>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * This driver support CS4271 codec being master or slave, working
+ * in control port mode, connected either via SPI or I2C.
+ * The data format accepted is I2S or left-justified.
+ * DAPM support not implemented.
+ */
+
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/delay.h>
+#include <sound/pcm.h>
+#include <sound/soc.h>
+#include <sound/tlv.h>
+#include <linux/gpio.h>
+#include <linux/i2c.h>
+#include <linux/spi/spi.h>
+#include <sound/cs4271.h>
+
+#define CS4271_PCM_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | \
+			    SNDRV_PCM_FMTBIT_S24_LE | \
+			    SNDRV_PCM_FMTBIT_S32_LE)
+
+/*
+ * CS4271 registers
+ * High byte represents SPI chip address (0x10) + write command (0)
+ * Low byte - codec register address
+ */
+#define CS4271_MODE1	0x2001	/* Mode Control 1 */
+#define CS4271_DACCTL	0x2002	/* DAC Control */
+#define CS4271_DACVOL	0x2003	/* DAC Volume & Mixing Control */
+#define CS4271_VOLA	0x2004	/* DAC Channel A Volume Control */
+#define CS4271_VOLB	0x2005	/* DAC Channel B Volume Control */
+#define CS4271_ADCCTL	0x2006	/* ADC Control */
+#define CS4271_MODE2	0x2007	/* Mode Control 2 */
+#define CS4271_CHIPID	0x2008	/* Chip ID */
+
+#define CS4271_FIRSTREG	CS4271_MODE1
+#define CS4271_LASTREG	CS4271_MODE2
+#define CS4271_NR_REGS	((CS4271_LASTREG & 0xFF) + 1)
+
+/* Bit masks for the CS4271 registers */
+#define CS4271_MODE1_MODE_MASK	0xC0
+#define CS4271_MODE1_MODE_1X	0x00
+#define CS4271_MODE1_MODE_2X	0x80
+#define CS4271_MODE1_MODE_4X	0xC0
+
+#define CS4271_MODE1_DIV_MASK	0x30
+#define CS4271_MODE1_DIV_1	0x00
+#define CS4271_MODE1_DIV_15	0x10
+#define CS4271_MODE1_DIV_2	0x20
+#define CS4271_MODE1_DIV_3	0x30
+
+#define CS4271_MODE1_MASTER	0x08
+
+#define CS4271_MODE1_DAC_DIF_MASK	0x07
+#define CS4271_MODE1_DAC_DIF_LJ		0x00
+#define CS4271_MODE1_DAC_DIF_I2S	0x01
+#define CS4271_MODE1_DAC_DIF_RJ16	0x02
+#define CS4271_MODE1_DAC_DIF_RJ24	0x03
+#define CS4271_MODE1_DAC_DIF_RJ20	0x04
+#define CS4271_MODE1_DAC_DIF_RJ18	0x05
+
+#define CS4271_DACCTL_AMUTE	0x80
+#define CS4271_DACCTL_IF_SLOW	0x40
+
+#define CS4271_DACCTL_DEM_MASK	0x30
+#define CS4271_DACCTL_DEM_DIS	0x00
+#define CS4271_DACCTL_DEM_441	0x10
+#define CS4271_DACCTL_DEM_48	0x20
+#define CS4271_DACCTL_DEM_32	0x30
+
+#define CS4271_DACCTL_SVRU	0x08
+#define CS4271_DACCTL_SRD	0x04
+#define CS4271_DACCTL_INVA	0x02
+#define CS4271_DACCTL_INVB	0x01
+
+#define CS4271_DACVOL_BEQUA	0x40
+#define CS4271_DACVOL_SOFT	0x20
+#define CS4271_DACVOL_ZEROC	0x10
+
+#define CS4271_DACVOL_ATAPI_MASK	0x0F
+#define CS4271_DACVOL_ATAPI_M_M		0x00
+#define CS4271_DACVOL_ATAPI_M_BR	0x01
+#define CS4271_DACVOL_ATAPI_M_BL	0x02
+#define CS4271_DACVOL_ATAPI_M_BLR2	0x03
+#define CS4271_DACVOL_ATAPI_AR_M	0x04
+#define CS4271_DACVOL_ATAPI_AR_BR	0x05
+#define CS4271_DACVOL_ATAPI_AR_BL	0x06
+#define CS4271_DACVOL_ATAPI_AR_BLR2	0x07
+#define CS4271_DACVOL_ATAPI_AL_M	0x08
+#define CS4271_DACVOL_ATAPI_AL_BR	0x09
+#define CS4271_DACVOL_ATAPI_AL_BL	0x0A
+#define CS4271_DACVOL_ATAPI_AL_BLR2	0x0B
+#define CS4271_DACVOL_ATAPI_ALR2_M	0x0C
+#define CS4271_DACVOL_ATAPI_ALR2_BR	0x0D
+#define CS4271_DACVOL_ATAPI_ALR2_BL	0x0E
+#define CS4271_DACVOL_ATAPI_ALR2_BLR2	0x0F
+
+#define CS4271_VOLA_MUTE	0x80
+#define CS4271_VOLA_VOL_MASK	0x7F
+#define CS4271_VOLB_MUTE	0x80
+#define CS4271_VOLB_VOL_MASK	0x7F
+
+#define CS4271_ADCCTL_DITHER16	0x20
+
+#define CS4271_ADCCTL_ADC_DIF_MASK	0x10
+#define CS4271_ADCCTL_ADC_DIF_LJ	0x00
+#define CS4271_ADCCTL_ADC_DIF_I2S	0x10
+
+#define CS4271_ADCCTL_MUTEA	0x08
+#define CS4271_ADCCTL_MUTEB	0x04
+#define CS4271_ADCCTL_HPFDA	0x02
+#define CS4271_ADCCTL_HPFDB	0x01
+
+#define CS4271_MODE2_LOOP	0x10
+#define CS4271_MODE2_MUTECAEQUB	0x08
+#define CS4271_MODE2_FREEZE	0x04
+#define CS4271_MODE2_CPEN	0x02
+#define CS4271_MODE2_PDN	0x01
+
+#define CS4271_CHIPID_PART_MASK	0xF0
+#define CS4271_CHIPID_REV_MASK	0x0F
+
+/* CS4271 default register settings, except auto-mute is off */
+static const u8 cs4271_dflt_reg[CS4271_NR_REGS] = {
+	0, 0, 0, CS4271_DACVOL_ATAPI_AL_BR, 0, 0, 0,
+	CS4271_MODE2_CPEN | CS4271_MODE2_PDN,
+};
+
+struct cs4271_private {
+	/* SND_SOC_I2C or SND_SOC_SPI */
+	enum snd_soc_control_type	bus_type;
+	void				*control_data;
+	unsigned int			mclk;
+	/* SND_SOC_DAIFMT_I2S or SND_SOC_DAIFMT_LEFT_J */
+	unsigned int			mode;
+	unsigned int			master;
+	/* GPIO driving Reset pin, if any */
+	int gpio_nreset;
+	/* GPIO that disable serial bus, if any */
+	int gpio_disable;
+};
+
+struct cs4271_clk_cfg {
+	unsigned int	ratio;		/* MCLK / sample rate */
+	u8		speed_mode;	/* codec speed mode: 1x, 2x, 4x */
+	u8		mclk_master;	/* ratio bit mask for Master mode */
+	u8		mclk_slave;	/* ratio bit mask for Slave mode */
+};
+
+static struct cs4271_clk_cfg cs4271_clk_tab[] = {
+	{64,   CS4271_MODE1_MODE_4X, CS4271_MODE1_DIV_1,  CS4271_MODE1_DIV_1},
+	{96,   CS4271_MODE1_MODE_4X, CS4271_MODE1_DIV_15, CS4271_MODE1_DIV_1},
+	{128,  CS4271_MODE1_MODE_2X, CS4271_MODE1_DIV_1,  CS4271_MODE1_DIV_1},
+	{192,  CS4271_MODE1_MODE_2X, CS4271_MODE1_DIV_15, CS4271_MODE1_DIV_1},
+	{256,  CS4271_MODE1_MODE_1X, CS4271_MODE1_DIV_1,  CS4271_MODE1_DIV_1},
+	{384,  CS4271_MODE1_MODE_1X, CS4271_MODE1_DIV_15, CS4271_MODE1_DIV_1},
+	{512,  CS4271_MODE1_MODE_1X, CS4271_MODE1_DIV_2,  CS4271_MODE1_DIV_1},
+	{768,  CS4271_MODE1_MODE_1X, CS4271_MODE1_DIV_3,  CS4271_MODE1_DIV_3},
+	{1024, CS4271_MODE1_MODE_1X, CS4271_MODE1_DIV_3,  CS4271_MODE1_DIV_3}
+};
+
+#define CS4171_NR_RATIOS ARRAY_SIZE(cs4271_clk_tab)
+
+/*
+ * @freq is the desired MCLK rate
+ * MCLK rate should (c) be the sample rate, multiplied by one of the
+ * ratios listed in cs4271_mclk_fs_ratios table
+ */
+static int cs4271_set_dai_sysclk(struct snd_soc_dai *codec_dai,
+				 int clk_id, unsigned int freq, int dir)
+{
+	struct snd_soc_codec *codec = codec_dai->codec;
+	struct cs4271_private *cs4271 = snd_soc_codec_get_drvdata(codec);
+
+	cs4271->mclk = freq;
+	return 0;
+}
+
+static int cs4271_set_dai_fmt(struct snd_soc_dai *codec_dai,
+			      unsigned int format)
+{
+	struct snd_soc_codec *codec = codec_dai->codec;
+	struct cs4271_private *cs4271 = snd_soc_codec_get_drvdata(codec);
+
+	cs4271->mode = format & SND_SOC_DAIFMT_FORMAT_MASK;
+
+	switch (format & SND_SOC_DAIFMT_MASTER_MASK) {
+	default:
+		dev_err(codec->dev, "Invalid DAI format\n");
+		return -EINVAL;
+	case SND_SOC_DAIFMT_CBS_CFS:
+		cs4271->master = 0;
+		break;
+	case SND_SOC_DAIFMT_CBM_CFM:
+		cs4271->master = 1;
+	}
+
+	return 0;
+}
+
+static int cs4271_hw_params(struct snd_pcm_substream *substream,
+			    struct snd_pcm_hw_params *params,
+			    struct snd_soc_dai *dai)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_codec *codec = rtd->codec;
+	struct cs4271_private *cs4271 = snd_soc_codec_get_drvdata(codec);
+	unsigned int i, ratio, val;
+
+	ratio = cs4271->mclk / params_rate(params);
+	for (i = 0; i < CS4171_NR_RATIOS; i++)
+		if (cs4271_clk_tab[i].ratio == ratio)
+			break;
+
+	if ((i == CS4171_NR_RATIOS) || ((ratio == 1024) && cs4271->master)) {
+		dev_err(codec->dev, "Invalid sample rate\n");
+		return -EINVAL;
+	}
+
+	/* Configure DAC */
+	val = cs4271_clk_tab[i].speed_mode;
+
+	if (cs4271->master)
+		val |= cs4271_clk_tab[i].mclk_master | CS4271_MODE1_MASTER;
+	else
+		val |= cs4271_clk_tab[i].mclk_slave;
+
+	switch (cs4271->mode) {
+	default:
+		dev_err(codec->dev, "Invalid DAI format\n");
+		return -EINVAL;
+	case SND_SOC_DAIFMT_LEFT_J:
+		val |= CS4271_MODE1_DAC_DIF_LJ;
+		break;
+	case SND_SOC_DAIFMT_I2S:
+		val |= CS4271_MODE1_DAC_DIF_I2S;
+	}
+
+	snd_soc_update_bits(codec, CS4271_MODE1,
+		CS4271_MODE1_MODE_MASK | CS4271_MODE1_DIV_MASK |
+		CS4271_MODE1_DAC_DIF_MASK | CS4271_MODE1_MASTER, val);
+
+	/* Configure ADC */
+	snd_soc_update_bits(codec, CS4271_ADCCTL, CS4271_ADCCTL_ADC_DIF_MASK,
+		(cs4271->mode == SND_SOC_DAIFMT_I2S) ?
+		CS4271_ADCCTL_ADC_DIF_I2S : CS4271_ADCCTL_ADC_DIF_LJ);
+
+	return 0;
+}
+
+static int cs4271_digital_mute(struct snd_soc_dai *dai, int mute)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	int val_a = 0;
+	int val_b = 0;
+
+	if (mute) {
+		val_a = CS4271_VOLA_MUTE;
+		val_b = CS4271_VOLB_MUTE;
+	}
+
+	snd_soc_update_bits(codec, CS4271_VOLA, CS4271_VOLA_MUTE, val_a);
+	snd_soc_update_bits(codec, CS4271_VOLB, CS4271_VOLB_MUTE, val_b);
+
+	return 0;
+}
+
+/* CS4271 controls */
+static DECLARE_TLV_DB_SCALE(cs4271_dac_tlv, -12700, 100, 0);
+
+static const char *cs4271_de_texts[] = {"None", "44.1KHz", "48KHz", "32KHz"};
+static const struct soc_enum cs4271_de_enum =
+	SOC_ENUM_SINGLE(CS4271_DACCTL, 4, 4, cs4271_de_texts);
+
+static const struct snd_kcontrol_new cs4271_snd_controls[] = {
+	SOC_DOUBLE_R_TLV("Master Playback Volume", CS4271_VOLA, CS4271_VOLB,
+		0, 0x7F, 1, cs4271_dac_tlv),
+	SOC_SINGLE("Digital Loopback Switch", CS4271_MODE2, 4, 1, 0),
+	SOC_SINGLE("Soft Ramp Switch", CS4271_DACVOL, 5, 1, 0),
+	SOC_SINGLE("Zero Cross Switch", CS4271_DACVOL, 4, 1, 0),
+	SOC_ENUM("De-emphasis filter", cs4271_de_enum),
+	SOC_SINGLE("Auto-Mute Switch", CS4271_DACCTL, 7, 1, 0),
+	SOC_SINGLE("Slow Roll Off Filter Switch", CS4271_DACCTL, 6, 1, 0),
+	SOC_SINGLE("Soft Volume Ramp-Up Switch", CS4271_DACCTL, 3, 1, 0),
+	SOC_SINGLE("Soft Ramp-Down Switch", CS4271_DACCTL, 2, 1, 0),
+	SOC_SINGLE("Left Channel Inversion Switch", CS4271_DACCTL, 1, 1, 0),
+	SOC_SINGLE("Right Channel Inversion Switch", CS4271_DACCTL, 0, 1, 0),
+	SOC_DOUBLE("Master Capture Switch", CS4271_ADCCTL, 3, 2, 1, 1),
+	SOC_SINGLE("Dither 16-Bit Data Switch", CS4271_ADCCTL, 5, 1, 0),
+	SOC_DOUBLE("High Pass Filter Switch", CS4271_ADCCTL, 1, 0, 1, 1),
+	SOC_DOUBLE_R("Master Playback Switch", CS4271_VOLA, CS4271_VOLB,
+		7, 1, 1),
+};
+
+static struct snd_soc_dai_ops cs4271_dai_ops = {
+	.hw_params	= cs4271_hw_params,
+	.set_sysclk	= cs4271_set_dai_sysclk,
+	.set_fmt	= cs4271_set_dai_fmt,
+	.digital_mute	= cs4271_digital_mute,
+};
+
+struct snd_soc_dai_driver cs4271_dai = {
+	.name = "cs4271-hifi",
+	.playback = {
+		.stream_name = "Playback",
+		.channels_min = 2,
+		.channels_max = 2,
+		.rates = SNDRV_PCM_RATE_8000_96000,
+		.rate_min = 8000,
+		.rate_max = 96000,
+		.formats = CS4271_PCM_FORMATS,
+	},
+	.capture = {
+		.stream_name = "Capture",
+		.channels_min = 2,
+		.channels_max = 2,
+		.rates = SNDRV_PCM_RATE_8000_96000,
+		.rate_min = 8000,
+		.rate_max = 96000,
+		.formats = CS4271_PCM_FORMATS,
+	},
+	.ops = &cs4271_dai_ops,
+};
+
+/*
+ * This function writes all writeble registers from cache to codec.
+ * It's used to setup initial config and restore after suspend.
+ */
+static int cs4271_write_cache(struct snd_soc_codec *codec)
+{
+	int i, ret;
+
+	for (i = CS4271_LASTREG; i >= CS4271_FIRSTREG; i--) {
+		ret = snd_soc_write(codec, i, snd_soc_read(codec, i));
+		if (ret) {
+			dev_err(codec->dev, "Cache write failed\n");
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int cs4271_soc_suspend(struct snd_soc_codec *codec, pm_message_t mesg)
+{
+	/* Set power-down bit */
+	snd_soc_update_bits(codec, CS4271_MODE2, CS4271_MODE2_PDN,
+		CS4271_MODE2_PDN);
+
+	return 0;
+}
+#else
+#define cs4271_soc_suspend	NULL
+#endif /* CONFIG_PM */
+
+static int cs4271_soc_resume(struct snd_soc_codec *codec)
+{
+	int ret;
+
+	/* Restore codec state */
+	ret = cs4271_write_cache(codec);
+	if (ret < 0)
+		return ret;
+
+	/* then disable the power-down bit */
+	snd_soc_update_bits(codec, CS4271_MODE2, CS4271_MODE2_PDN, 0);
+
+	return 0;
+}
+
+static int cs4271_probe(struct snd_soc_codec *codec)
+{
+	struct cs4271_private *cs4271 = snd_soc_codec_get_drvdata(codec);
+	struct cs4271_platform_data *cs4271plat = codec->dev->platform_data;
+	int ret;
+	int gpio_nreset = -EINVAL;
+	int gpio_disable = -EINVAL;
+
+	codec->control_data = cs4271->control_data;
+
+	if (cs4271plat) {
+		if (gpio_is_valid(cs4271plat->gpio_nreset))
+			gpio_nreset = cs4271plat->gpio_nreset;
+		if (gpio_is_valid(cs4271plat->gpio_disable))
+			gpio_disable = cs4271plat->gpio_disable;
+	}
+
+	if ((gpio_disable >= 0) &&
+		gpio_request(gpio_disable, "CS4271 Disable"))
+		gpio_disable = -EINVAL;
+	if (gpio_disable >= 0)
+		gpio_direction_output(gpio_disable, 0);
+
+	if ((gpio_nreset >= 0) &&
+		gpio_request(gpio_nreset, "CS4271 Reset"))
+		gpio_nreset = -EINVAL;
+	if (gpio_nreset >= 0) {
+		gpio_direction_output(gpio_nreset, 1);
+		/* Give the codec time to wake up */
+		udelay(1);
+	}
+
+	cs4271->gpio_nreset = gpio_nreset;
+	cs4271->gpio_disable = gpio_disable;
+
+	/*
+	 * In case of I2C, chip address specified in board data.
+	 * So cache IO operations use 8 bit codec register address.
+	 * In case of SPI, chip address and register address
+	 * passed together as 16 bit value.
+	 * Anyway, register address is masked with 0xFF inside
+	 * soc-cache code.
+	 */
+	ret = snd_soc_codec_set_cache_io(codec,
+		(cs4271->bus_type == SND_SOC_SPI) ? 16 : 8, 8,
+		cs4271->bus_type);
+	if (ret) {
+		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
+		return ret;
+	}
+
+	ret = cs4271_soc_resume(codec);
+	if (ret < 0)
+		return ret;
+
+	return snd_soc_add_controls(codec, cs4271_snd_controls,
+				    ARRAY_SIZE(cs4271_snd_controls));
+}
+
+static int cs4271_remove(struct snd_soc_codec *codec)
+{
+	struct cs4271_private *cs4271 = snd_soc_codec_get_drvdata(codec);
+	int gpio_nreset, gpio_disable;
+
+	gpio_nreset = cs4271->gpio_nreset;
+	gpio_disable = cs4271->gpio_disable;
+
+	if (gpio_is_valid(gpio_nreset)) {
+		/* Set codec to the reset state */
+		gpio_set_value(gpio_nreset, 0);
+		gpio_free(gpio_nreset);
+	}
+
+	if (gpio_is_valid(gpio_disable))
+		gpio_free(gpio_disable);
+
+	return 0;
+};
+
+struct snd_soc_codec_driver soc_codec_dev_cs4271 = {
+	.probe			= cs4271_probe,
+	.remove			= cs4271_remove,
+	.suspend		= cs4271_soc_suspend,
+	.resume			= cs4271_soc_resume,
+	.reg_cache_default	= &cs4271_dflt_reg,
+	.reg_cache_size		= ARRAY_SIZE(cs4271_dflt_reg),
+	.reg_word_size		= sizeof(cs4271_dflt_reg[0]),
+	.compress_type		= SND_SOC_FLAT_COMPRESSION,
+	.reg_cache_step		= 1,
+};
+
+#if defined(CONFIG_SPI_MASTER)
+static int __devinit cs4271_spi_probe(struct spi_device *spi)
+{
+	struct cs4271_private *cs4271;
+	int ret;
+
+	cs4271 = kzalloc(sizeof(*cs4271), GFP_KERNEL);
+	if (!cs4271)
+		return -ENOMEM;
+
+	spi_set_drvdata(spi, cs4271);
+	cs4271->control_data = spi;
+	cs4271->bus_type = SND_SOC_SPI;
+
+	ret = snd_soc_register_codec(&spi->dev, &soc_codec_dev_cs4271,
+				     &cs4271_dai, 1);
+	if (ret < 0)
+		kfree(cs4271);
+	return ret;
+}
+
+static int __devexit cs4271_spi_remove(struct spi_device *spi)
+{
+	snd_soc_unregister_codec(&spi->dev);
+	kfree(spi_get_drvdata(spi));
+	return 0;
+}
+
+static struct spi_driver cs4271_spi_driver = {
+	.driver = {
+		.name	= "cs4271-codec",
+		.owner	= THIS_MODULE,
+	},
+	.probe		= cs4271_spi_probe,
+	.remove		= __devexit_p(cs4271_spi_remove),
+};
+#endif /* defined(CONFIG_SPI_MASTER) */
+
+#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
+static struct i2c_device_id cs4271_i2c_id[] = {
+	{"cs4271", 0},
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, cs4271_i2c_id);
+
+static int __devinit cs4271_i2c_probe(struct i2c_client *client,
+				      const struct i2c_device_id *id)
+{
+	struct cs4271_private *cs4271;
+	int ret;
+
+	cs4271 = kzalloc(sizeof(*cs4271), GFP_KERNEL);
+	if (!cs4271)
+		return -ENOMEM;
+
+	i2c_set_clientdata(client, cs4271);
+	cs4271->control_data = client;
+	cs4271->bus_type = SND_SOC_I2C;
+
+	ret = snd_soc_register_codec(&client->dev, &soc_codec_dev_cs4271,
+				     &cs4271_dai, 1);
+	if (ret < 0)
+		kfree(cs4271);
+	return ret;
+}
+
+static int __devexit cs4271_i2c_remove(struct i2c_client *client)
+{
+	snd_soc_unregister_codec(&client->dev);
+	kfree(i2c_get_clientdata(client));
+	return 0;
+}
+
+static struct i2c_driver cs4271_i2c_driver = {
+	.driver = {
+		.name	= "cs4271-codec",
+		.owner	= THIS_MODULE,
+	},
+	.id_table	= cs4271_i2c_id,
+	.probe		= cs4271_i2c_probe,
+	.remove		= __devexit_p(cs4271_i2c_remove),
+};
+#endif /* defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE) */
+
+/*
+ * We only register our serial bus driver here without
+ * assignment to particular chip. So if any of the below
+ * fails, there is some problem with I2C or SPI subsystem.
+ * In most cases this module will be compiled with support
+ * of only one serial bus.
+ */
+static int __init cs4271_modinit(void)
+{
+	int ret;
+
+#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
+	ret = i2c_add_driver(&cs4271_i2c_driver);
+	if (ret) {
+		pr_err("Failed to register CS4271 I2C driver: %d\n", ret);
+		return ret;
+	}
+#endif
+
+#if defined(CONFIG_SPI_MASTER)
+	ret = spi_register_driver(&cs4271_spi_driver);
+	if (ret) {
+		pr_err("Failed to register CS4271 SPI driver: %d\n", ret);
+		return ret;
+	}
+#endif
+
+	return 0;
+}
+module_init(cs4271_modinit);
+
+static void __exit cs4271_modexit(void)
+{
+#if defined(CONFIG_SPI_MASTER)
+	spi_unregister_driver(&cs4271_spi_driver);
+#endif
+
+#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
+	i2c_del_driver(&cs4271_i2c_driver);
+#endif
+}
+module_exit(cs4271_modexit);
+
+MODULE_AUTHOR("Alexander Sverdlin <subaparts@yandex.ru>");
+MODULE_DESCRIPTION("Cirrus Logic CS4271 ALSA SoC Codec Driver");
+MODULE_LICENSE("GPL");
