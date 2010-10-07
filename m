From: ryan@bluewatersys.com (Ryan Mallon)
Date: Thu, 07 Oct 2010 13:39:01 +1300
Subject: [PATCH 1/2] ASoC: Add CS4271 codec support
Message-ID: <4CAD16A5.1090501@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Alexander Sverdlin <subaparts@yandex.ru>

Added support for Cirrus CS4271 codec to ALSA SoC subsystem.

Applies on: 2.6.36-rc6

Signed-off-by: Alexander Sverdlin <subaparts@yandex.ru>

---

 sound/soc/codecs/Kconfig  |    3 +
 sound/soc/codecs/Makefile |    2 +
 sound/soc/codecs/cs4271.c |  840 +++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/cs4271.h |   27 ++
 4 files changed, 872 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 83f5c67..608cf88 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -138,6 +138,9 @@ config SND_SOC_CS4270_VD33_ERRATA
 	bool
 	depends on SND_SOC_CS4270
 
+config SND_SOC_CS4271
+	tristate
+
 config SND_SOC_CX20442
 	tristate
 
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 5352409..d7dd676 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -11,6 +11,7 @@ snd-soc-ak4671-objs := ak4671.o
 snd-soc-cq93vc-objs := cq93vc.o
 snd-soc-cs42l51-objs := cs42l51.o
 snd-soc-cs4270-objs := cs4270.o
+snd-soc-cs4271-objs := cs4271.o
 snd-soc-cx20442-objs := cx20442.o
 snd-soc-da7210-objs := da7210.o
 snd-soc-l3-objs := l3.o
@@ -79,6 +80,7 @@ obj-$(CONFIG_SND_SOC_AK4671)	+= snd-soc-ak4671.o
 obj-$(CONFIG_SND_SOC_CQ0093VC) += snd-soc-cq93vc.o
 obj-$(CONFIG_SND_SOC_CS42L51)	+= snd-soc-cs42l51.o
 obj-$(CONFIG_SND_SOC_CS4270)	+= snd-soc-cs4270.o
+obj-$(CONFIG_SND_SOC_CS4271)	+= snd-soc-cs4271.o
 obj-$(CONFIG_SND_SOC_CX20442)	+= snd-soc-cx20442.o
 obj-$(CONFIG_SND_SOC_DA7210)	+= snd-soc-da7210.o
 obj-$(CONFIG_SND_SOC_L3)	+= snd-soc-l3.o
diff --git a/sound/soc/codecs/cs4271.c b/sound/soc/codecs/cs4271.c
new file mode 100644
index 0000000..305281a
--- /dev/null
+++ b/sound/soc/codecs/cs4271.c
@@ -0,0 +1,840 @@
+/*
+ * CS4271 ALSA SoC (ASoC) codec driver
+ *
+ * Copyright (c) 2010 Alexander Sverdlin <subaparts@yandex.ru>
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2. This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ *
+ * This is an ASoC device driver for the Cirrus Logic CS4271 codec.
+ *
+ * Current features/limitations:
+ *
+ * - I2C and SPI are supported
+ * - Software mode is supported.  Stand-alone mode is not supported
+ * - Support for master and slave mode
+ * - The machine driver's 'startup' function must call
+ *   cs4271_set_dai_sysclk() with the value of MCLK
+ * - Only I2S and left-justified modes are supported
+ */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <sound/core.h>
+#include <sound/soc.h>
+#include <sound/initval.h>
+#include <linux/i2c.h>
+#include <linux/spi/spi.h>
+
+#include "cs4271.h"
+
+#define CS4271_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | \
+			SNDRV_PCM_FMTBIT_S24_LE | \
+			SNDRV_PCM_FMTBIT_S32_LE)
+
+/*
+ * CS4271 registers addresses 
+ * High byte represents SPI address (0x10) + write command (0)
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
+#define CS4271_MODE1_FUNCMODE_MASK	0xC0
+#define CS4271_MODE1_FUNCMODE_1X	0x00
+#define CS4271_MODE1_FUNCMODE_2X	0x80
+#define CS4271_MODE1_FUNCMODE_4X	0xC0
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
+/* Private data for the CS4271 */
+struct cs4271_private {
+	struct snd_soc_codec	codec;
+	u8			reg_cache[CS4271_NR_REGS];
+	unsigned int		mclk; /* Input frequency of the MCLK pin */
+	unsigned int		mode; /* The mode (I2S or left-justified) */
+	unsigned int		slave_mode;
+};
+
+/*
+ * struct cs4271_mode_ratios - clock ratio tables
+ * @ratio: the ratio of MCLK to the sample rate
+ * @speed_mode: the Speed Mode bits to set in the Mode Control register for
+ *              this ratio
+ * @mclk_master: the Ratio Select bits to set in the Mode Control register
+ *               for this ratio while in Master mode
+ * @mclk_slave: the Ratio Select bits to set in the Mode Control register 
+ *              for this ratio while in Slave mode
+ *
+ * This table is used to determine how to program the Mode Control register
+ * It is also used by cs4271_set_dai_sysclk() to tell ALSA which sampling
+ * rates the CS4271 currently supports.
+ */
+struct cs4271_mode_ratios {
+	unsigned int	ratio;
+	u8		speed_mode;
+	u8		mclk_master;
+	u8		mclk_slave;
+};
+
+static struct cs4271_mode_ratios cs4271_mode_ratios[] = {
+	{64,   CS4271_MODE1_FUNCMODE_4X, CS4271_MODE1_DIV_1,  CS4271_MODE1_DIV_1},
+	{96,   CS4271_MODE1_FUNCMODE_4X, CS4271_MODE1_DIV_15, CS4271_MODE1_DIV_1},
+	{128,  CS4271_MODE1_FUNCMODE_2X, CS4271_MODE1_DIV_1,  CS4271_MODE1_DIV_1},
+	{192,  CS4271_MODE1_FUNCMODE_2X, CS4271_MODE1_DIV_15, CS4271_MODE1_DIV_1},
+	{256,  CS4271_MODE1_FUNCMODE_1X, CS4271_MODE1_DIV_1,  CS4271_MODE1_DIV_1},
+	{384,  CS4271_MODE1_FUNCMODE_1X, CS4271_MODE1_DIV_15, CS4271_MODE1_DIV_1},
+	{512,  CS4271_MODE1_FUNCMODE_1X, CS4271_MODE1_DIV_2,  CS4271_MODE1_DIV_1},
+	{768,  CS4271_MODE1_FUNCMODE_1X, CS4271_MODE1_DIV_3,  CS4271_MODE1_DIV_3},
+	{1024, CS4271_MODE1_FUNCMODE_1X, CS4271_MODE1_DIV_3,  CS4271_MODE1_DIV_3}
+};
+
+/* The number of MCLK/LRCK ratios supported by the CS4271 */
+#define NUM_MCLK_RATIOS		ARRAY_SIZE(cs4271_mode_ratios)
+
+/*
+ * cs4271_set_dai_sysclk - determine the CS4271 MCLK rate.
+ * @codec_dai: the codec DAI
+ * @clk_id: the clock ID (ignored)
+ * @freq: the MCLK input frequency
+ * @dir: the clock direction (ignored)
+ *
+ * This function is used to tell the codec driver what the input MCLK
+ * frequency is.
+ *
+ * The value of MCLK is used to determine which sample rates are supported
+ * by the CS4271.  The ratio of MCLK / Fs must be equal to one of
+ * supported values - 64, 96, 128, 192, 256, 384, 512, 768 and
+ * for Slave mode 1024. 256 is the best value and widely recommended.
+ *
+ * This function must be called by the machine driver's 'startup' function,
+ * otherwise the list of supported sample rates will not be available in
+ * time for ALSA.
+ *
+ * For setups with variable MCLKs, pass 0 as 'freq' argument. This will cause
+ * theoretically possible sample rates to be enabled. Call it again with a
+ * proper value set one the external clock is set (most probably you would do
+ * that from a machine's driver 'hw_param' hook.
+ */
+static int cs4271_set_dai_sysclk(struct snd_soc_dai *codec_dai,
+				 int clk_id, unsigned int freq, int dir)
+{
+	struct snd_soc_codec *codec = codec_dai->codec;
+	struct cs4271_private *cs4271 = snd_soc_codec_get_drvdata(codec);
+	unsigned int rates = 0;
+	unsigned int rate_min = -1;
+	unsigned int rate_max = 0;
+	unsigned int i;
+
+	cs4271->mclk = freq;
+
+	if (cs4271->mclk) {
+		for (i = 0; i < NUM_MCLK_RATIOS; i++) {
+			unsigned int rate = freq / cs4271_mode_ratios[i].ratio;
+			rates |= snd_pcm_rate_to_rate_bit(rate);
+			if (rate < rate_min)
+				rate_min = rate;
+			if (rate > rate_max)
+				rate_max = rate;
+		}
+
+		rates &= ~SNDRV_PCM_RATE_KNOT;
+
+		if (!rates) {
+			dev_err(codec->dev, "could not find a valid sample rate\n");
+			return -EINVAL;
+		}
+	} else {
+		/* enable all possible rates */
+		rates = SNDRV_PCM_RATE_8000_96000;
+		rate_min = 8000;
+		rate_max = 96000;
+	}
+
+	codec_dai->playback.rates = rates;
+	codec_dai->playback.rate_min = rate_min;
+	codec_dai->playback.rate_max = rate_max;
+
+	codec_dai->capture.rates = rates;
+	codec_dai->capture.rate_min = rate_min;
+	codec_dai->capture.rate_max = rate_max;
+
+	return 0;
+}
+
+/*
+ * cs4271_set_dai_fmt - configure the codec for the selected audio format
+ * @codec_dai: the codec DAI
+ * @format: a SND_SOC_DAIFMT_x value indicating the data format
+ *
+ * Currently, this function only supports SND_SOC_DAIFMT_I2S and
+ * SND_SOC_DAIFMT_LEFT_J.
+ */
+static int cs4271_set_dai_fmt(struct snd_soc_dai *codec_dai,
+			      unsigned int format)
+{
+	struct snd_soc_codec *codec = codec_dai->codec;
+	struct cs4271_private *cs4271 = snd_soc_codec_get_drvdata(codec);
+	int ret = 0;
+
+	/* set DAI format */
+	switch (format & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_I2S:
+	case SND_SOC_DAIFMT_LEFT_J:
+		cs4271->mode = format & SND_SOC_DAIFMT_FORMAT_MASK;
+		break;
+	default:
+		dev_err(codec->dev, "invalid dai format\n");
+		ret = -EINVAL;
+	}
+
+	/* set master/slave audio interface */
+	switch (format & SND_SOC_DAIFMT_MASTER_MASK) {
+	case SND_SOC_DAIFMT_CBS_CFS:
+		cs4271->slave_mode = 1;
+		break;
+	case SND_SOC_DAIFMT_CBM_CFM:
+		cs4271->slave_mode = 0;
+		break;
+	default:
+		/* all other modes are unsupported by the hardware */
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+/*
+ * cs4271_hw_params - program the CS4271 with the given hardware parameters.
+ * @substream: the audio stream
+ * @params: the hardware parameters to set
+ * @dai: the SOC DAI (ignored)
+ */
+static int cs4271_hw_params(struct snd_pcm_substream *substream,
+			    struct snd_pcm_hw_params *params,
+			    struct snd_soc_dai *dai)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_device *socdev = rtd->socdev;
+	struct snd_soc_codec *codec = socdev->card->codec;
+	struct cs4271_private *cs4271 = snd_soc_codec_get_drvdata(codec);
+	int ret;
+	unsigned int i, ratio;
+
+	/* Figure out which MCLK/LRCK ratio to use */
+	ratio = cs4271->mclk / params_rate(params);
+
+	for (i = 0; i < NUM_MCLK_RATIOS; i++) 
+		if (cs4271_mode_ratios[i].ratio == ratio)
+			break;
+
+	if ((i == NUM_MCLK_RATIOS) || ((ratio == 1024) && (!cs4271->slave_mode))) {
+		dev_err(codec->dev, "could not find matching ratio\n");
+		return -EINVAL;
+	}
+
+	/* Set the sample rate */
+	ret = snd_soc_read(codec, CS4271_MODE1);
+	ret &= ~(CS4271_MODE1_FUNCMODE_MASK | CS4271_MODE1_DIV_MASK | CS4271_MODE1_DAC_DIF_MASK);
+	ret |= cs4271_mode_ratios[i].speed_mode;
+
+	if (cs4271->slave_mode) {
+		ret &= ~CS4271_MODE1_MASTER;
+		ret |= cs4271_mode_ratios[i].mclk_slave;
+	}
+	else {
+		ret |= CS4271_MODE1_MASTER;
+		ret |= cs4271_mode_ratios[i].mclk_master;
+	}
+
+	switch (cs4271->mode) {
+	case SND_SOC_DAIFMT_I2S:
+		ret |= CS4271_MODE1_DAC_DIF_I2S;
+		break;
+	case SND_SOC_DAIFMT_LEFT_J:
+		ret |= CS4271_MODE1_DAC_DIF_LJ;
+		break;
+	default:
+		dev_err(codec->dev, "unknown dai format\n");
+		return -EINVAL;
+	}
+
+	ret = snd_soc_write(codec, CS4271_MODE1, ret);
+	if (ret < 0) {
+		dev_err(codec->dev, "Codec write failed\n");
+		return ret;
+	}
+
+	/* Set the DAI format */
+	ret = snd_soc_read(codec, CS4271_ADCCTL);
+	ret &= ~CS4271_ADCCTL_ADC_DIF_MASK;
+	ret |= (cs4271->mode == SND_SOC_DAIFMT_I2S) ? CS4271_ADCCTL_ADC_DIF_I2S : CS4271_ADCCTL_ADC_DIF_LJ;
+	ret = snd_soc_write(codec, CS4271_ADCCTL, ret);
+	if (ret < 0) 
+		dev_err(codec->dev, "Codec write failed\n");
+
+	return ret;
+}
+
+/*
+ * cs4271_dai_mute - enable/disable the CS4271 external mute
+ * @dai: the SOC DAI
+ * @mute: 0 = disable mute, 1 = enable mute
+ */
+static int cs4271_dai_mute(struct snd_soc_dai *dai, int mute)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	int ret1, ret2;
+
+	ret1 = snd_soc_read(codec, CS4271_VOLA);
+	ret2 = snd_soc_read(codec, CS4271_VOLB);
+
+	if (mute) {
+		ret1 |= CS4271_VOLA_MUTE;
+		ret2 |= CS4271_VOLB_MUTE;
+	} 
+	else {
+		ret1 &= ~(CS4271_VOLA_MUTE);
+		ret2 &= ~(CS4271_VOLB_MUTE);
+	}
+
+	ret1 = snd_soc_write(codec, CS4271_VOLA, ret1);
+	if (ret1)
+		return ret1;
+	return snd_soc_write(codec, CS4271_VOLB, ret2);
+}
+
+/*
+ * A list of non-DAPM controls that the CS4271 supports 
+ */
+static const char *cs4271_de_texts[] = {"None", "44.1KHz", "48KHz", "32KHz"};
+static const struct soc_enum cs4271_de_enum =
+	SOC_ENUM_SINGLE(CS4271_DACCTL, 4, 4, cs4271_de_texts);
+
+static const struct snd_kcontrol_new cs4271_snd_controls[] = {
+	SOC_DOUBLE_R("Master Playback Volume", CS4271_VOLA, CS4271_VOLB, 0, 0x7F, 1),
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
+	SOC_DOUBLE_R("Master Playback Switch", CS4271_VOLA, CS4271_VOLB, 7, 1, 1),
+};
+
+/*
+ * cs4271_codec - global variable to store codec for the ASoC probe function
+ *
+ * For now, we also only allow cs4271_i2c_probe() to be run once. That means
+ * that we do not support more than one cs4271 device in the system, at least 
+ * for now.
+ */
+static struct snd_soc_codec *cs4271_codec;
+
+static struct snd_soc_dai_ops cs4271_dai_ops = {
+	.hw_params	= cs4271_hw_params,
+	.set_sysclk	= cs4271_set_dai_sysclk,
+	.set_fmt	= cs4271_set_dai_fmt,
+	.digital_mute	= cs4271_dai_mute,
+};
+
+struct snd_soc_dai cs4271_dai = {
+	.name = "cs4271",
+	.playback = {
+		.stream_name = "Playback",
+		.channels_min = 2,
+		.channels_max = 2,
+		.rates = 0,
+		.formats = CS4271_FORMATS,
+	},
+	.capture = {
+		.stream_name = "Capture",
+		.channels_min = 2,
+		.channels_max = 2,
+		.rates = 0,
+		.formats = CS4271_FORMATS,
+	},
+	.ops = &cs4271_dai_ops,
+};
+EXPORT_SYMBOL_GPL(cs4271_dai);
+
+/*
+ * This function writes all writeble registers from cache to codec.
+ * It's used te setup initial config and restore after suspend.
+ */
+static int cs4271_write_cache(struct snd_soc_codec *codec)
+{
+	int i, ret;
+
+	for (i = CS4271_FIRSTREG; i <= CS4271_LASTREG; i++) {
+	    ret = snd_soc_write(codec, i, snd_soc_read(codec, i));
+	    if (ret)
+		return ret;
+	}
+
+	return 0;
+}
+
+/*
+ * cs4271_probe - ASoC probe function
+ * @pdev: platform device
+ *
+ * This function is called when ASoC has all the pieces it needs to
+ * instantiate a sound driver.
+ * This function actually configure the codec, so MCLK must be enabled
+ * already and reset must be inactive. This is probably done by
+ * machine drivers.
+ */
+static int cs4271_probe(struct platform_device *pdev)
+{
+	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
+	struct snd_soc_codec *codec = cs4271_codec;
+	int ret;
+	u8 *cache;
+
+	/* Turn control port on and set power down mode for a while */
+	ret = snd_soc_write(codec, CS4271_MODE2, CS4271_MODE2_CPEN | CS4271_MODE2_PDN);
+	if (ret < 0) {
+		dev_err(codec->dev, "Codec write failed\n");
+		return ret;
+	}
+
+	cache = codec->reg_cache;
+	/*
+	 * Almost default power up configuration of codec, except auto
+	 * mute feature which is turned off.
+	 * We need to mask register address, because it contains
+	 * SPI address also.
+	 */
+	cache[CS4271_MODE1  & 0xFF] = 0x00;
+	cache[CS4271_DACCTL & 0xFF] = 0x00;
+	cache[CS4271_DACVOL & 0xFF] = CS4271_DACVOL_ATAPI_AL_BR;
+	cache[CS4271_VOLA   & 0xFF] = 0x00;
+	cache[CS4271_VOLB   & 0xFF] = 0x00;
+	cache[CS4271_ADCCTL & 0xFF] = 0x00;
+	cache[CS4271_MODE2  & 0xFF] = CS4271_MODE2_CPEN;
+	
+	ret = cs4271_write_cache(codec);
+	if (ret < 0) {
+		dev_err(codec->dev, "Cache write failed\n");
+		return ret;
+	}
+
+	/* Connect the codec to the socdev.  snd_soc_new_pcms() needs this. */
+	socdev->card->codec = codec;
+
+	/* Register PCMs */
+	ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
+	if (ret < 0) {
+		dev_err(codec->dev, "failed to create pcms\n");
+		return ret;
+	}
+
+	/* Add the non-DAPM controls */
+	ret = snd_soc_add_controls(codec, cs4271_snd_controls,
+				ARRAY_SIZE(cs4271_snd_controls));
+	if (ret < 0) {
+		dev_err(codec->dev, "failed to add controls\n");
+		goto error_free_pcms;
+	}
+
+	return 0;
+
+error_free_pcms:
+	snd_soc_free_pcms(socdev);
+
+	return ret;
+}
+
+/*
+ * cs4271_remove - ASoC remove function
+ * @pdev: platform device
+ *
+ * This function is the counterpart to cs4271_probe().
+ */
+static int cs4271_remove(struct platform_device *pdev)
+{
+	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
+
+	snd_soc_free_pcms(socdev);
+
+	return 0;
+};
+
+#ifdef CONFIG_PM
+
+/*
+ * The codec's own power saving features are enabled in the suspend callback,
+ * and all registers are written back to the hardware when resuming.
+ */
+static int cs4271_soc_suspend(struct platform_device *pdev, pm_message_t mesg)
+{
+	struct snd_soc_codec *codec = cs4271_codec;
+	struct cs4271_private *cs4271 = snd_soc_codec_get_drvdata(codec);
+	int ret;
+
+	ret = snd_soc_read(codec, CS4271_MODE2);
+	ret |= CS4271_MODE2_PDN;
+
+	return snd_soc_write(codec, CS4271_MODE2, ret);
+}
+
+static int cs4271_soc_resume(struct platform_device *pdev)
+{
+	struct snd_soc_codec *codec = cs4271_codec;
+	struct cs4271_private *cs4271 = snd_soc_codec_get_drvdata(codec);
+	int ret;
+
+	ret = cs4271_write_cache(codec);
+	if (ret < 0) {
+		dev_err(pdev, "Cache write failed\n");
+		return ret;
+	}
+	
+	/* ... then disable the power-down bits */
+	ret = snd_soc_read(codec, CS4271_MODE2);
+	ret &= ~CS4271_MODE2_PDN;
+
+	return snd_soc_write(codec, CS4271_MODE2, ret);
+}
+#else
+#define cs4271_soc_suspend	NULL
+#define cs4271_soc_resume	NULL
+#endif /* CONFIG_PM */
+
+/*
+ * ASoC codec device structure
+ *
+ * Assign this variable to the codec_dev field of the machine driver's
+ * snd_soc_device structure.
+ */
+struct snd_soc_codec_device soc_codec_device_cs4271 = {
+	.probe = 	cs4271_probe,
+	.remove = 	cs4271_remove,
+	.suspend =	cs4271_soc_suspend,
+	.resume =	cs4271_soc_resume,
+};
+EXPORT_SYMBOL_GPL(soc_codec_device_cs4271);
+
+/*
+ * Serial bus independent probe function. It's called both for
+ * I2C and SPI -connected codecs.
+ */
+static int cs4271_bus_probe(struct device *dev, void *ctrl_data, int bus_type)
+{
+	struct cs4271_private *cs4271;
+	struct snd_soc_codec *codec;
+	int ret;
+
+	/*
+	 * For now, we only support one cs4271 device in the system.  See the
+	 * comment for cs4271_codec.
+	 */
+	if (cs4271_codec) {
+		dev_err(dev, "Only one CS4271 per board allowed\n");
+		return -ENODEV;
+	}
+
+	/*
+	 * Allocate enough space for the snd_soc_codec structure
+	 * and our private data together.
+	 */
+	cs4271 = kzalloc(sizeof(struct cs4271_private), GFP_KERNEL);
+	if (!cs4271) {
+		dev_err(dev, "Could not allocate codec\n");
+		return -ENOMEM;
+	}
+
+	dev_set_drvdata(dev, cs4271);
+
+	codec = &cs4271->codec;
+	mutex_init(&codec->mutex);
+	INIT_LIST_HEAD(&codec->dapm_widgets);
+	INIT_LIST_HEAD(&codec->dapm_paths);
+
+	codec->dev = dev;
+	codec->name = "CS4271";
+	codec->owner = THIS_MODULE;
+	codec->dai = &cs4271_dai;
+	codec->num_dai = 1;
+	snd_soc_codec_set_drvdata(codec, cs4271);
+	codec->control_data = ctrl_data;
+	codec->reg_cache = cs4271->reg_cache;
+	codec->reg_cache_size = ARRAY_SIZE(cs4271->reg_cache);
+
+	/*
+	 * In case of I2C, chip address specified in board data.
+	 * So cache IO operations use 8 bit codec register address.
+	 * In case of SPI, chip address and register address
+	 * passed together as 16 bit value.
+	 * Anyway, register address is masked with 0xFF inside
+	 * soc_cache code.
+	 */
+	ret = snd_soc_codec_set_cache_io(codec, 
+		(bus_type == SND_SOC_SPI) ? 16 : 8, 8, bus_type);
+	if (ret) {
+		dev_err(dev, "Failed to set cache I/O: %d\n", ret);
+		goto error_free_codec;
+	}
+
+	/*
+	 * Initialize the DAI. Normally, we'd prefer to have a kmalloc'd DAI
+	 * structure for each CS4271 device, but the machine driver needs to
+	 * have a pointer to the DAI structure, so for now it must be a global
+	 * variable.
+	 */
+	cs4271_dai.dev = dev;
+
+	/*
+	 * Register the DAI.  If all the other ASoC driver have already
+	 * registered, then this will call our probe function, so
+	 * cs4271_codec needs to be ready.
+	 */
+	cs4271_codec = codec;
+
+	ret = snd_soc_register_codec(codec);
+	if (ret) {
+		dev_err(dev, "Failed to register codec: %d\n", ret);
+		goto error_free_codec;
+	}
+
+	ret = snd_soc_register_dai(&cs4271_dai);
+	if (ret) {
+		dev_err(dev, "failed to register DAI\n");
+		goto error_reg;
+	}
+
+	return 0;
+
+error_reg:
+	snd_soc_unregister_codec(codec);
+error_free_codec:
+	kfree(cs4271);
+	cs4271_codec = NULL;
+	cs4271_dai.dev = NULL;
+
+	return ret;
+}
+
+static int cs4271_bus_remove(struct device *dev)
+{
+	struct cs4271_private *cs4271 = dev_get_drvdata(dev);
+
+	snd_soc_unregister_dai(&cs4271_dai);
+	kfree(cs4271);
+	cs4271_codec = NULL;
+	cs4271_dai.dev = NULL;
+
+	return 0;
+}
+
+
+#if defined(CONFIG_SPI_MASTER)
+
+static struct spi_device_id cs4271_spi_id[] = {
+	{"cs4271", 0},
+	{}
+};
+MODULE_DEVICE_TABLE(spi, cs4271_spi_id);
+
+static int __devinit cs4271_spi_probe(struct spi_device *spi)
+{
+	return cs4271_bus_probe(&spi->dev, spi, SND_SOC_SPI);
+}
+
+static int __devexit cs4271_spi_remove(struct spi_device *spi)
+{
+	return cs4271_bus_remove(&spi->dev);
+}
+
+static struct spi_driver cs4271_spi_driver = {
+	.driver = {
+		.name	= "cs4271",
+		.owner	= THIS_MODULE,
+	},
+	.id_table	= cs4271_spi_id,
+	.probe		= cs4271_spi_probe,
+	.remove		= __devexit_p(cs4271_spi_remove),
+};
+
+#endif
+
+#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
+/*
+ * cs4271_id - I2C device IDs supported by this driver
+ */
+static struct i2c_device_id cs4271_i2c_id[] = {
+	{"cs4271", 0},
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, cs4271_i2c_id);
+
+static int __devinit cs4271_i2c_probe(struct i2c_client *client,
+			    const struct i2c_device_id *id)
+{
+	return cs4271_bus_probe(&client->dev, client, SND_SOC_I2C);
+}
+
+static int __devexit cs4271_i2c_remove(struct i2c_client *client)
+{
+	return cs4271_bus_remove(&client->dev);
+}
+
+/*
+ * cs4271_i2c_driver - I2C device identification
+ *
+ * This structure tells the I2C subsystem how to identify and support a
+ * given I2C device type.
+ */
+static struct i2c_driver cs4271_i2c_driver = {
+	.driver = {
+		.name	= "cs4271",
+		.owner	= THIS_MODULE,
+	},
+	.id_table	= cs4271_i2c_id,
+	.probe		= cs4271_i2c_probe,
+	.remove		= __devexit_p(cs4271_i2c_remove),
+};
+
+#endif
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
diff --git a/sound/soc/codecs/cs4271.h b/sound/soc/codecs/cs4271.h
new file mode 100644
index 0000000..7cf6af2
--- /dev/null
+++ b/sound/soc/codecs/cs4271.h
@@ -0,0 +1,27 @@
+/*
+ * Cirrus Logic CS4271 ALSA SoC Codec Driver
+ *
+ * Copyright (c) 2010 Alexander Sverdlin <subaparts@yandex.ru>
+ *
+ * This file is licensed under the terms of the GNU General Public License 
+ * version 2.  This program is licensed "as is" without any warranty of any 
+ * kind, whether express or implied.
+ */
+
+#ifndef _CS4271_H
+#define _CS4271_H
+
+/*
+ * The ASoC codec DAI structure for the CS4271.  Assign this structure to
+ * the .codec_dai field of your machine driver's snd_soc_dai_link structure.
+ */
+extern struct snd_soc_dai cs4271_dai;
+
+/*
+ * The ASoC codec device structure for the CS4271.  Assign this structure
+ * to the .codec_dev field of your machine driver's snd_soc_device
+ * structure.
+ */
+extern struct snd_soc_codec_device soc_codec_device_cs4271;
+
+#endif
