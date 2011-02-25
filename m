From: javier.martin@vista-silicon.com (Javier Martin)
Date: Fri, 25 Feb 2011 14:42:47 +0100
Subject: [PATCH 1/4] ASoC: Add TI tlv320aic32x4 codec support.
Message-ID: <1298641370-17461-1-git-send-email-javier.martin@vista-silicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for tlv320aic3205 and tlv320aic3254 codecs.
It doesn't include miniDSP support for aic3254.

Signed-off-by: Javier Martin <javier.martin@vista-silicon.com>
---
 sound/soc/codecs/Kconfig         |    4 +
 sound/soc/codecs/Makefile        |    2 +
 sound/soc/codecs/tlv320aic32x4.c |  884 ++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/tlv320aic32x4.h |  138 ++++++
 4 files changed, 1028 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/codecs/tlv320aic32x4.c
 create mode 100644 sound/soc/codecs/tlv320aic32x4.h

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 3b5690d..497c9a6 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -36,6 +36,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_STAC9766 if SND_SOC_AC97_BUS
 	select SND_SOC_TLV320AIC23 if I2C
 	select SND_SOC_TLV320AIC26 if SPI_MASTER
+	select SND_SOC_TVL320AIC32X4 if I2C
 	select SND_SOC_TLV320AIC3X if I2C
 	select SND_SOC_TPA6130A2 if I2C
 	select SND_SOC_TLV320DAC33 if I2C
@@ -182,6 +183,9 @@ config SND_SOC_TLV320AIC26
 	tristate "TI TLV320AIC26 Codec support" if SND_SOC_OF_SIMPLE
 	depends on SPI
 
+config SND_SOC_TVL320AIC32X4
+	tristate
+
 config SND_SOC_TLV320AIC3X
 	tristate
 
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index f67a2d6..5709ca6 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -23,6 +23,7 @@ snd-soc-stac9766-objs := stac9766.o
 snd-soc-tlv320aic23-objs := tlv320aic23.o
 snd-soc-tlv320aic26-objs := tlv320aic26.o
 snd-soc-tlv320aic3x-objs := tlv320aic3x.o
+snd-soc-tlv320aic32x4-objs := tlv320aic32x4.o
 snd-soc-tlv320dac33-objs := tlv320dac33.o
 snd-soc-twl4030-objs := twl4030.o
 snd-soc-twl6040-objs := twl6040.o
@@ -98,6 +99,7 @@ obj-$(CONFIG_SND_SOC_STAC9766)	+= snd-soc-stac9766.o
 obj-$(CONFIG_SND_SOC_TLV320AIC23)	+= snd-soc-tlv320aic23.o
 obj-$(CONFIG_SND_SOC_TLV320AIC26)	+= snd-soc-tlv320aic26.o
 obj-$(CONFIG_SND_SOC_TLV320AIC3X)	+= snd-soc-tlv320aic3x.o
+obj-$(CONFIG_SND_SOC_TVL320AIC32X4)     += snd-soc-tlv320aic32x4.o
 obj-$(CONFIG_SND_SOC_TLV320DAC33)	+= snd-soc-tlv320dac33.o
 obj-$(CONFIG_SND_SOC_TWL4030)	+= snd-soc-twl4030.o
 obj-$(CONFIG_SND_SOC_TWL6040)	+= snd-soc-twl6040.o
diff --git a/sound/soc/codecs/tlv320aic32x4.c b/sound/soc/codecs/tlv320aic32x4.c
new file mode 100644
index 0000000..5ae7b20
--- /dev/null
+++ b/sound/soc/codecs/tlv320aic32x4.c
@@ -0,0 +1,884 @@
+/*
+ * linux/sound/soc/codecs/tlv320aic32x4.c
+ *
+ * Copyright 2011 Vista Silicon S.L.
+ *
+ * Author: Javier Martin <javier.martin@vista-silicon.com>
+ *
+ * Based on sound/soc/codecs/wm8974 and TI driver for kernel 2.6.27.
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
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+ * MA 02110-1301, USA.
+ */
+
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/pm.h>
+#include <linux/i2c.h>
+#include <linux/platform_device.h>
+#include <linux/cdev.h>
+#include <linux/slab.h>
+
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+#include <sound/initval.h>
+
+#include "tlv320aic32x4.h"
+
+#define SOC_DOUBLE_R_AIC32X4(xname, reg_left, reg_right, shift, mask, invert) \
+{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname), \
+	.info = snd_soc_info_volsw_2r_aic32x4, \
+	.get = snd_soc_get_volsw_2r_aic32x4, \
+	.put = snd_soc_put_volsw_2r_aic32x4, \
+	.private_value = (reg_left) | ((shift) << 8)  | \
+		((mask) << 12) | ((invert) << 20) | ((reg_right) << 24) }
+
+struct aic32x4_rate_divs {
+	u32 mclk;
+	u32 rate;
+	u8 p_val;
+	u8 pll_j;
+	u16 pll_d;
+	u16 dosr;
+	u8 ndac;
+	u8 mdac;
+	u8 aosr;
+	u8 nadc;
+	u8 madc;
+	u8 blck_N;
+};
+
+struct aic32x4_priv {
+	u32 sysclk;
+	s32 master;
+	u8 page_no;
+	void *control_data;
+};
+
+struct aic32x4_configs {
+	u8 reg_offset;
+	u8 reg_val;
+};
+
+#define aic32x4_reset(c) snd_soc_write(c, AIC32X4_RESET, 0x01);
+
+static int snd_soc_info_volsw_2r_aic32x4(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_info *uinfo);
+
+static int snd_soc_get_volsw_2r_aic32x4(struct snd_kcontrol *kcontrol,
+					struct snd_ctl_elem_value *ucontrol);
+
+static int snd_soc_put_volsw_2r_aic32x4(struct snd_kcontrol *kcontrol,
+					struct snd_ctl_elem_value *ucontrol);
+
+static const struct snd_kcontrol_new aic32x4_snd_controls[] = {
+	SOC_DOUBLE_R_AIC32X4("PCM Playback Volume", AIC32X4_LDACVOL,
+			AIC32X4_RDACVOL, 0, 0xAf, 0),
+	SOC_DOUBLE_R_AIC32X4("HP Driver Gain", AIC32X4_HPLGAIN,
+			AIC32X4_HPRGAIN, 0, 0x23, 0),
+	SOC_DOUBLE_R_AIC32X4("LO Driver Gain", AIC32X4_LOLGAIN,
+			AIC32X4_LORGAIN, 0, 0x23, 0),
+	SOC_DOUBLE_R("HP DAC Playback Switch", AIC32X4_HPLGAIN,
+			AIC32X4_HPRGAIN, 6, 0x01, 1),
+	SOC_DOUBLE_R("LO DAC Playback Switch", AIC32X4_LOLGAIN,
+			AIC32X4_LORGAIN, 6, 0x01, 1),
+
+	SOC_DOUBLE_R("ADC Volume Level", AIC32X4_LADCVOL,
+			AIC32X4_RADCVOL, 0, 0x28, 0),
+	SOC_DOUBLE_R("PGA Gain Level", AIC32X4_LMICPGAVOL,
+			AIC32X4_RMICPGAVOL, 0, 0x5f, 0),
+
+	SOC_SINGLE("Auto-mute", AIC32X4_DACMUTE, 4, 7, 0),
+
+	SOC_SINGLE("AGC Left Enable Switch", AIC32X4_LAGC1, 7, 1, 0),
+	SOC_SINGLE("AGC Right Enable Switch", AIC32X4_RAGC1, 7, 1, 0),
+	SOC_DOUBLE_R("AGC Target Level", AIC32X4_LAGC1, AIC32X4_RAGC1,
+			4, 0x07, 0),
+	SOC_DOUBLE_R("AGC Gain Hysteresis", AIC32X4_LAGC1, AIC32X4_RAGC1,
+			0, 0x03, 0),
+	SOC_DOUBLE_R("AGC Hysteresis", AIC32X4_LAGC2, AIC32X4_RAGC2,
+			6, 0x03, 0),
+	SOC_DOUBLE_R("AGC Noise Threshold", AIC32X4_LAGC2, AIC32X4_RAGC2,
+			1, 0x1F, 0),
+	SOC_DOUBLE_R("AGC Max PGA", AIC32X4_LAGC3, AIC32X4_RAGC3,
+			0, 0x7F, 0),
+	SOC_DOUBLE_R("AGC Attack Time", AIC32X4_LAGC4, AIC32X4_RAGC4,
+			3, 0x1F, 0),
+	SOC_DOUBLE_R("AGC Decay Time", AIC32X4_LAGC5, AIC32X4_RAGC5,
+			3, 0x1F, 0),
+	SOC_DOUBLE_R("AGC Noise Debounce", AIC32X4_LAGC6, AIC32X4_RAGC6,
+			0, 0x1F, 0),
+	SOC_DOUBLE_R("AGC Signal Debounce", AIC32X4_LAGC7, AIC32X4_RAGC7,
+			0, 0x0F, 0),
+
+	SOC_SINGLE("MIC BIAS", AIC32X4_MICBIAS, 6, 1, 0),
+};
+
+static const struct aic32x4_rate_divs aic32x4_divs[] = {
+	/* 8k rate */
+	{AIC32X4_FREQ_12000000, 8000, 1, 7, 6800, 768, 5, 3, 128, 5, 18, 24},
+	{AIC32X4_FREQ_24000000, 8000, 2, 7, 6800, 768, 15, 1, 64, 45, 4, 24},
+	{AIC32X4_FREQ_25000000, 8000, 2, 7, 3728, 768, 15, 1, 64, 45, 4, 24},
+	/* 11.025k rate */
+	{AIC32X4_FREQ_12000000, 11025, 1, 7, 5264, 512, 8, 2, 128, 8, 8, 16},
+	{AIC32X4_FREQ_24000000, 11025, 2, 7, 5264, 512, 16, 1, 64, 32, 4, 16},
+	/* 16k rate */
+	{AIC32X4_FREQ_12000000, 16000, 1, 7, 6800, 384, 5, 3, 128, 5, 9, 12},
+	{AIC32X4_FREQ_24000000, 16000, 2, 7, 6800, 384, 15, 1, 64, 18, 5, 12},
+	{AIC32X4_FREQ_25000000, 16000, 2, 7, 3728, 384, 15, 1, 64, 18, 5, 12},
+	/* 22.05k rate */
+	{AIC32X4_FREQ_12000000, 22050, 1, 7, 5264, 256, 4, 4, 128, 4, 8, 8},
+	{AIC32X4_FREQ_24000000, 22050, 2, 7, 5264, 256, 16, 1, 64, 16, 4, 8},
+	{AIC32X4_FREQ_25000000, 22050, 2, 7, 2253, 256, 16, 1, 64, 16, 4, 8},
+	/* 32k rate */
+	{AIC32X4_FREQ_12000000, 32000, 1, 7, 1680, 192, 2, 7, 64, 2, 21, 6},
+	{AIC32X4_FREQ_24000000, 32000, 2, 7, 1680, 192, 7, 2, 64, 7, 6, 6},
+	/* 44.1k rate */
+	{AIC32X4_FREQ_12000000, 44100, 1, 7, 5264, 128, 2, 8, 128, 2, 8, 4},
+	{AIC32X4_FREQ_24000000, 44100, 2, 7, 5264, 128, 8, 2, 64, 8, 4, 4},
+	{AIC32X4_FREQ_25000000, 44100, 2, 7, 2253, 128, 8, 2, 64, 8, 4, 4},
+	/* 48k rate */
+	{AIC32X4_FREQ_12000000, 48000, 1, 8, 1920, 128, 2, 8, 128, 2, 8, 4},
+	{AIC32X4_FREQ_24000000, 48000, 2, 8, 1920, 128, 8, 2, 64, 8, 4, 4},
+	{AIC32X4_FREQ_25000000, 48000, 2, 7, 8643, 128, 8, 2, 64, 8, 4, 4}
+};
+
+static const struct aic32x4_configs aic32x4_reg_init[] = {
+	{AIC32X4_PWRCFG, AIC32X4_AVDDWEAKDISABLE},
+	{AIC32X4_LDOCTL, AIC32X4_LDOCTLEN},
+	{AIC32X4_CMMODE, AIC32X4_LDOIN_18_36 | AIC32X4_LDOIN2HP},
+	{AIC32X4_CLKMUX, AIC32X4_PLLCLKIN},
+	{AIC32X4_IFACE3, AIC32X4_DACMOD2BCLK},
+	{AIC32X4_DACSETUP,
+	 AIC32X4_LDAC2LCHN | AIC32X4_RDAC2RCHN | AIC32X4_SSTEP2WCLK},
+	{AIC32X4_LMICPGANIN, AIC32X4_LMICPGANIN_IN2R_10K},
+	{AIC32X4_RMICPGANIN, AIC32X4_RMICPGANIN_IN1L_10K},
+	{AIC32X4_LMICPGAVOL, 0x00},
+	{AIC32X4_RMICPGAVOL, 0x00},
+	/* Unmute ADC left and right channels */
+	{AIC32X4_ADCFGA, 0x00},
+	/* MICBIAS = 2.075V(CM=0.75V) generated from LDOIN */
+	{AIC32X4_MICBIAS, 0x68},
+	{AIC32X4_DACSPB, AIC32X4_DACSPBLOCK_MASK & 0x1},
+	{AIC32X4_ADCSPB, AIC32X4_ADCSPBLOCK_MASK & 0x1},
+};
+
+static const struct snd_kcontrol_new hpl_output_mixer_controls[] = {
+	SOC_DAPM_SINGLE("L_DAC switch", AIC32X4_HPLROUTE, 3, 1, 0),
+	SOC_DAPM_SINGLE("IN1_L switch", AIC32X4_HPLROUTE, 2, 1, 0),
+};
+
+static const struct snd_kcontrol_new hpr_output_mixer_controls[] = {
+	SOC_DAPM_SINGLE("R_DAC switch", AIC32X4_HPRROUTE, 3, 1, 0),
+	SOC_DAPM_SINGLE("IN1_R switch", AIC32X4_HPRROUTE, 2, 1, 0),
+};
+
+static const struct snd_kcontrol_new lol_output_mixer_controls[] = {
+	SOC_DAPM_SINGLE("L_DAC switch", AIC32X4_LOLROUTE, 3, 1, 0),
+};
+
+static const struct snd_kcontrol_new lor_output_mixer_controls[] = {
+	SOC_DAPM_SINGLE("R_DAC switch", AIC32X4_LORROUTE, 3, 1, 0),
+};
+
+static const struct snd_kcontrol_new left_input_mixer_controls[] = {
+	SOC_DAPM_SINGLE("IN1_L P switch", AIC32X4_LMICPGAPIN, 6, 1, 0),
+	SOC_DAPM_SINGLE("IN2_L P switch", AIC32X4_LMICPGAPIN, 4, 1, 0),
+	SOC_DAPM_SINGLE("IN3_L P switch", AIC32X4_LMICPGAPIN, 2, 1, 0),
+};
+
+static const struct snd_kcontrol_new right_input_mixer_controls[] = {
+	SOC_DAPM_SINGLE("IN1_R P switch", AIC32X4_RMICPGAPIN, 6, 1, 0),
+	SOC_DAPM_SINGLE("IN2_R P switch", AIC32X4_RMICPGAPIN, 4, 1, 0),
+	SOC_DAPM_SINGLE("IN3_R P switch", AIC32X4_RMICPGAPIN, 2, 1, 0),
+};
+
+static const struct snd_soc_dapm_widget aic32x4_dapm_widgets[] = {
+	SND_SOC_DAPM_DAC("Left DAC", "Left Playback", AIC32X4_DACSETUP, 7, 0),
+	SND_SOC_DAPM_MIXER("HPL Output Mixer", SND_SOC_NOPM, 0, 0,
+			   &hpl_output_mixer_controls[0],
+			   ARRAY_SIZE(hpl_output_mixer_controls)),
+	SND_SOC_DAPM_PGA("HPL Power", AIC32X4_OUTPWRCTL, 5, 0, NULL, 0),
+
+	SND_SOC_DAPM_MIXER("LOL Output Mixer", SND_SOC_NOPM, 0, 0,
+			   &lol_output_mixer_controls[0],
+			   ARRAY_SIZE(lol_output_mixer_controls)),
+	SND_SOC_DAPM_PGA("LOL Power", AIC32X4_OUTPWRCTL, 3, 0, NULL, 0),
+
+	SND_SOC_DAPM_DAC("Right DAC", "Right Playback", AIC32X4_DACSETUP, 6, 0),
+	SND_SOC_DAPM_MIXER("HPR Output Mixer", SND_SOC_NOPM, 0, 0,
+			   &hpr_output_mixer_controls[0],
+			   ARRAY_SIZE(hpr_output_mixer_controls)),
+	SND_SOC_DAPM_PGA("HPR Power", AIC32X4_OUTPWRCTL, 4, 0, NULL, 0),
+	SND_SOC_DAPM_MIXER("LOR Output Mixer", SND_SOC_NOPM, 0, 0,
+			   &lor_output_mixer_controls[0],
+			   ARRAY_SIZE(lor_output_mixer_controls)),
+	SND_SOC_DAPM_PGA("LOR Power", AIC32X4_OUTPWRCTL, 2, 0, NULL, 0),
+	SND_SOC_DAPM_MIXER("Left Input Mixer", SND_SOC_NOPM, 0, 0,
+			   &left_input_mixer_controls[0],
+			   ARRAY_SIZE(left_input_mixer_controls)),
+	SND_SOC_DAPM_MIXER("Right Input Mixer", SND_SOC_NOPM, 0, 0,
+			   &right_input_mixer_controls[0],
+			   ARRAY_SIZE(right_input_mixer_controls)),
+	SND_SOC_DAPM_ADC("Left ADC", "Left Capture", AIC32X4_ADCSETUP, 7, 0),
+	SND_SOC_DAPM_ADC("Right ADC", "Right Capture", AIC32X4_ADCSETUP, 6, 0),
+
+	SND_SOC_DAPM_OUTPUT("HPL"),
+	SND_SOC_DAPM_OUTPUT("HPR"),
+	SND_SOC_DAPM_OUTPUT("LOL"),
+	SND_SOC_DAPM_OUTPUT("LOR"),
+	SND_SOC_DAPM_INPUT("IN1_L"),
+	SND_SOC_DAPM_INPUT("IN1_R"),
+	SND_SOC_DAPM_INPUT("IN2_L"),
+	SND_SOC_DAPM_INPUT("IN2_R"),
+	SND_SOC_DAPM_INPUT("IN3_L"),
+	SND_SOC_DAPM_INPUT("IN3_R"),
+};
+
+static const struct snd_soc_dapm_route aic32x4_dapm_routes[] = {
+	/* Left Output */
+	{"HPL Output Mixer", "L_DAC switch", "Left DAC"},
+	{"HPL Output Mixer", "IN1_L switch", "IN1_L"},
+
+	{"HPL Power", NULL, "HPL Output Mixer"},
+	{"HPL", NULL, "HPL Power"},
+
+	{"LOL Output Mixer", "L_DAC switch", "Left DAC"},
+
+	{"LOL Power", NULL, "LOL Output Mixer"},
+	{"LOL", NULL, "LOL Power"},
+
+	/* Right Output */
+	{"HPR Output Mixer", "R_DAC switch", "Right DAC"},
+	{"HPR Output Mixer", "IN1_R switch", "IN1_R"},
+
+	{"HPR Power", NULL, "HPR Output Mixer"},
+	{"HPR", NULL, "HPR Power"},
+
+	{"LOR Output Mixer", "R_DAC switch", "Right DAC"},
+
+	{"LOR Power", NULL, "LOR Output Mixer"},
+	{"LOR", NULL, "LOR Power"},
+
+	/* Left input */
+	{"Left Input Mixer", "IN1_L P switch", "IN1_L"},
+	{"Left Input Mixer", "IN2_L P switch", "IN2_L"},
+	{"Left Input Mixer", "IN3_L P switch", "IN3_L"},
+
+	{"Left ADC", NULL, "Left Input Mixer"},
+
+	/* Right Input */
+	{"Right Input Mixer", "IN1_R P switch", "IN1_R"},
+	{"Right Input Mixer", "IN2_R P switch", "IN2_R"},
+	{"Right Input Mixer", "IN3_R P switch", "IN3_R"},
+
+	{"Right ADC", NULL, "Right Input Mixer"},
+};
+
+static inline int aic32x4_change_page(struct snd_soc_codec *codec,
+					unsigned int new_page)
+{
+	struct aic32x4_priv *aic32x4 = snd_soc_codec_get_drvdata(codec);
+	u8 data[2];
+
+	data[0] = 0x00;
+	data[1] = new_page & 0xff;
+
+	if (codec->hw_write(codec->control_data, data, 2) == 2) {
+		aic32x4->page_no = new_page;
+		return 0;
+	} else {
+		return -EIO;
+	}
+}
+
+static int aic32x4_write(struct snd_soc_codec *codec, unsigned int reg,
+				unsigned int val)
+{
+	struct aic32x4_priv *aic32x4 = snd_soc_codec_get_drvdata(codec);
+	unsigned int page = reg / 128;
+	unsigned int fixed_reg = reg % 128;
+	u8 data[2];
+	int ret;
+
+	/* A write to AIC32X4_PSEL is really a non-explicit page change */
+	if (reg == AIC32X4_PSEL)
+		return aic32x4_change_page(codec, val);
+
+	if (aic32x4->page_no != page) {
+		ret = aic32x4_change_page(codec, page);
+		if (ret != 0)
+			return ret;
+	}
+
+	data[0] = fixed_reg & 0xff;
+	data[1] = val & 0xff;
+
+	if (codec->hw_write(codec->control_data, data, 2) == 2)
+		return 0;
+	else
+		return -EIO;
+}
+
+static unsigned int aic32x4_read(struct snd_soc_codec *codec, unsigned int reg)
+{
+	struct aic32x4_priv *aic32x4 = snd_soc_codec_get_drvdata(codec);
+	unsigned int page = reg / 128;
+	unsigned int fixed_reg = reg % 128;
+	int ret;
+
+	if (aic32x4->page_no != page) {
+		ret = aic32x4_change_page(codec, page);
+		if (ret != 0)
+			return ret;
+	}
+	return i2c_smbus_read_byte_data(codec->control_data, fixed_reg & 0xff);
+}
+
+static int snd_soc_info_volsw_2r_aic32x4(struct snd_kcontrol *kcontrol,
+					struct snd_ctl_elem_info *uinfo)
+{
+	int mask = (kcontrol->private_value >> 12) & 0xff;
+
+	uinfo->type =
+	mask == 1 ? SNDRV_CTL_ELEM_TYPE_BOOLEAN : SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->count = 2;
+	uinfo->value.integer.min = 0;
+	uinfo->value.integer.max = mask;
+	return 0;
+}
+
+int snd_soc_get_volsw_2r_aic32x4(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	int reg = kcontrol->private_value & 0xff;
+	int reg2 = (kcontrol->private_value >> 24) & 0xff;
+	int mask;
+	int shift;
+	unsigned short val, val2;
+
+	if (!strcmp(kcontrol->id.name, "PCM Playback Volume")) {
+		mask = 0xff;
+		shift = 0;
+	} else if ((!strcmp(kcontrol->id.name, "HP Driver Gain")) ||
+		   (!strcmp(kcontrol->id.name, "LO Driver Gain"))) {
+		mask = 0x3F;
+		shift = 0;
+	} else if (!strcmp(kcontrol->id.name, "PGA Capture Volume")) {
+		mask = 0x7F;
+		shift = 0;
+	} else {
+		printk(KERN_ERR "aic32x4: invalid kcontrol name\n");
+		return -1;
+	}
+
+	val = (snd_soc_read(codec, reg) >> shift) & mask;
+	val2 = (snd_soc_read(codec, reg2) >> shift) & mask;
+
+	if (!strcmp(kcontrol->id.name, "PCM Playback Volume")) {
+		ucontrol->value.integer.value[0] =
+		    (val <= 48) ? (val + 127) : (val - 129);
+		ucontrol->value.integer.value[1] =
+		    (val2 <= 48) ? (val2 + 127) : (val2 - 129);
+	} else if ((!strcmp(kcontrol->id.name, "HP Driver Gain"))
+		   || (!strcmp(kcontrol->id.name, "LO Driver Gain"))) {
+		ucontrol->value.integer.value[0] =
+		    (val <= 29) ? (val + 6) : (val - 58);
+		ucontrol->value.integer.value[1] =
+		    (val2 <= 29) ? (val2 + 6) : (val2 - 58);
+	} else if (!strcmp(kcontrol->id.name, "PGA Capture Volume")) {
+		ucontrol->value.integer.value[0] =
+		    (val <= 38) ? (val + 25) : (val - 103);
+		ucontrol->value.integer.value[1] =
+		    (val2 <= 38) ? (val2 + 25) : (val2 - 103);
+	}
+	return 0;
+}
+
+int snd_soc_put_volsw_2r_aic32x4(struct snd_kcontrol *kcontrol,
+				 struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	int reg = kcontrol->private_value & 0xff;
+	int reg2 = (kcontrol->private_value >> 24) & 0xff;
+	int err;
+	unsigned short val, val2, val_mask;
+
+	val = ucontrol->value.integer.value[0];
+	val2 = ucontrol->value.integer.value[1];
+
+	if (!strcmp(kcontrol->id.name, "PCM Playback Volume")) {
+		val = (val >= 127) ? (val - 127) : (val + 129);
+		val2 = (val2 >= 127) ? (val2 - 127) : (val2 + 129);
+		val_mask = 0xff;	/* 8 bits */
+	} else if ((!strcmp(kcontrol->id.name, "HP Driver Gain")) ||
+		   (!strcmp(kcontrol->id.name, "LO Driver Gain"))) {
+		val = (val >= 6) ? (val - 6) : (val + 58);
+		val2 = (val2 >= 6) ? (val2 - 6) : (val2 + 58);
+		val_mask = 0x3F;	/* 6 bits */
+	} else if (!strcmp(kcontrol->id.name, "PGA Capture Volume")) {
+		val = (val >= 25) ? (val - 25) : (val + 103);
+		val2 = (val2 >= 25) ? (val2 - 25) : (val2 + 103);
+		val_mask = 0x7F;	/* 7 bits */
+	} else {
+		printk(KERN_ERR "aic32x4: invalid control name\n");
+		return -1;
+	}
+
+	err = snd_soc_update_bits(codec, reg, val_mask, val);
+	if (err < 0) {
+		printk(KERN_ERR "aic32x4: error while updating bits\n");
+		return err;
+	}
+
+	err = snd_soc_update_bits(codec, reg2, val_mask, val2);
+	return err;
+}
+
+static inline int aic32x4_get_divs(int mclk, int rate)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(aic32x4_divs); i++) {
+		if ((aic32x4_divs[i].rate == rate)
+		    && (aic32x4_divs[i].mclk == mclk)) {
+			return i;
+		}
+	}
+	printk(KERN_ERR "aic32x4: master clock and sample rate is not supported\n");
+	return -EINVAL;
+}
+
+static int aic32x4_add_widgets(struct snd_soc_codec *codec)
+{
+	snd_soc_dapm_new_controls(codec, aic32x4_dapm_widgets,
+				ARRAY_SIZE(aic32x4_dapm_widgets));
+
+	snd_soc_dapm_add_routes(codec, aic32x4_dapm_routes,
+				ARRAY_SIZE(aic32x4_dapm_routes));
+
+	snd_soc_dapm_new_widgets(codec);
+	return 0;
+}
+
+static int aic32x4_set_dai_sysclk(struct snd_soc_dai *codec_dai,
+				  int clk_id, unsigned int freq, int dir)
+{
+	struct snd_soc_codec *codec = codec_dai->codec;
+	struct aic32x4_priv *aic32x4 = snd_soc_codec_get_drvdata(codec);
+
+	switch (freq) {
+	case AIC32X4_FREQ_12000000:
+	case AIC32X4_FREQ_24000000:
+	case AIC32X4_FREQ_25000000:
+		aic32x4->sysclk = freq;
+		return 0;
+	}
+	printk(KERN_ERR "aic32x4: invalid frequency to set DAI system clock\n");
+	return -EINVAL;
+}
+
+static int aic32x4_set_dai_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
+{
+	struct snd_soc_codec *codec = codec_dai->codec;
+	struct aic32x4_priv *aic32x4 = snd_soc_codec_get_drvdata(codec);
+	u8 iface_reg_1;
+	u8 iface_reg_2;
+	u8 iface_reg_3;
+
+	iface_reg_1 = snd_soc_read(codec, AIC32X4_IFACE1);
+	iface_reg_1 = iface_reg_1 & ~(3 << 6 | 3 << 2);
+	iface_reg_2 = snd_soc_read(codec, AIC32X4_IFACE2);
+	iface_reg_2 = 0;
+	iface_reg_3 = snd_soc_read(codec, AIC32X4_IFACE3);
+	iface_reg_3 = iface_reg_3 & ~(1 << 3);
+
+	/* set master/slave audio interface */
+	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+	case SND_SOC_DAIFMT_CBM_CFM:
+		aic32x4->master = 1;
+		iface_reg_1 |= AIC32X4_BCLKMASTER | AIC32X4_WCLKMASTER;
+		break;
+	case SND_SOC_DAIFMT_CBS_CFS:
+		aic32x4->master = 0;
+		break;
+	default:
+		printk(KERN_ERR "aic32x4: invalid DAI master/slave interface\n");
+		return -EINVAL;
+	}
+
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_I2S:
+		break;
+	case SND_SOC_DAIFMT_DSP_A:
+		iface_reg_1 |= (AIC32X4_DSP_MODE << AIC32X4_PLLJ_SHIFT);
+		iface_reg_3 |= (1 << 3); /* invert bit clock */
+		iface_reg_2 = 0x01; /* add offset 1 */
+		break;
+	case SND_SOC_DAIFMT_DSP_B:
+		iface_reg_1 |= (AIC32X4_DSP_MODE << AIC32X4_PLLJ_SHIFT);
+		iface_reg_3 |= (1 << 3); /* invert bit clock */
+		break;
+	case SND_SOC_DAIFMT_RIGHT_J:
+		iface_reg_1 |=
+			(AIC32X4_RIGHT_JUSTIFIED_MODE << AIC32X4_PLLJ_SHIFT);
+		break;
+	case SND_SOC_DAIFMT_LEFT_J:
+		iface_reg_1 |=
+			(AIC32X4_LEFT_JUSTIFIED_MODE << AIC32X4_PLLJ_SHIFT);
+		break;
+	default:
+		printk(KERN_ERR "aic32x4: invalid DAI interface format\n");
+		return -EINVAL;
+	}
+
+	snd_soc_write(codec, AIC32X4_IFACE1, iface_reg_1);
+	snd_soc_write(codec, AIC32X4_IFACE2, iface_reg_2);
+	snd_soc_write(codec, AIC32X4_IFACE3, iface_reg_3);
+	return 0;
+}
+
+static int aic32x4_hw_params(struct snd_pcm_substream *substream,
+			     struct snd_pcm_hw_params *params,
+			     struct snd_soc_dai *dai)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	struct aic32x4_priv *aic32x4 = snd_soc_codec_get_drvdata(codec);
+	u8 data;
+	int i;
+
+	i = aic32x4_get_divs(aic32x4->sysclk, params_rate(params));
+	if (i < 0) {
+		printk(KERN_ERR "aic32x4: sampling rate not supported\n");
+		return i;
+	}
+
+	/* We will fix R value to 1 and will make P & J=K.D as varialble */
+	data = snd_soc_read(codec, AIC32X4_PLLPR);
+	data &= ~(7 << 4);
+	snd_soc_write(codec, AIC32X4_PLLPR,
+		      (data | (aic32x4_divs[i].p_val << 4) | 0x01));
+
+	snd_soc_write(codec, AIC32X4_PLLJ, aic32x4_divs[i].pll_j);
+
+	snd_soc_write(codec, AIC32X4_PLLDMSB, (aic32x4_divs[i].pll_d >> 8));
+	snd_soc_write(codec, AIC32X4_PLLDLSB,
+		      (aic32x4_divs[i].pll_d & 0xff));
+
+	/* NDAC divider value */
+	data = snd_soc_read(codec, AIC32X4_NDAC);
+	data &= ~(0x7f);
+	snd_soc_write(codec, AIC32X4_NDAC, data | aic32x4_divs[i].ndac);
+
+	/* MDAC divider value */
+	data = snd_soc_read(codec, AIC32X4_MDAC);
+	data &= ~(0x7f);
+	snd_soc_write(codec, AIC32X4_MDAC, data | aic32x4_divs[i].mdac);
+
+	/* DOSR MSB & LSB values */
+	snd_soc_write(codec, AIC32X4_DOSRMSB, aic32x4_divs[i].dosr >> 8);
+	snd_soc_write(codec, AIC32X4_DOSRLSB,
+		      (aic32x4_divs[i].dosr & 0xff));
+
+	/* NADC divider value */
+	data = snd_soc_read(codec, AIC32X4_NADC);
+	data &= ~(0x7f);
+	snd_soc_write(codec, AIC32X4_NADC, data | aic32x4_divs[i].nadc);
+
+	/* MADC divider value */
+	data = snd_soc_read(codec, AIC32X4_MADC);
+	data &= ~(0x7f);
+	snd_soc_write(codec, AIC32X4_MADC, data | aic32x4_divs[i].madc);
+
+	/* AOSR value */
+	snd_soc_write(codec, AIC32X4_AOSR, aic32x4_divs[i].aosr);
+
+	/* BCLK N divider */
+	data = snd_soc_read(codec, AIC32X4_BCLKN);
+	data &= ~(0x7f);
+	snd_soc_write(codec, AIC32X4_BCLKN, data | aic32x4_divs[i].blck_N);
+
+	data = snd_soc_read(codec, AIC32X4_IFACE1);
+	data = data & ~(3 << 4);
+	switch (params_format(params)) {
+	case SNDRV_PCM_FORMAT_S16_LE:
+		break;
+	case SNDRV_PCM_FORMAT_S20_3LE:
+		data |= (AIC32X4_WORD_LEN_20BITS << AIC32X4_DOSRMSB_SHIFT);
+		break;
+	case SNDRV_PCM_FORMAT_S24_LE:
+		data |= (AIC32X4_WORD_LEN_24BITS << AIC32X4_DOSRMSB_SHIFT);
+		break;
+	case SNDRV_PCM_FORMAT_S32_LE:
+		data |= (AIC32X4_WORD_LEN_32BITS << AIC32X4_DOSRMSB_SHIFT);
+		break;
+	}
+	snd_soc_write(codec, AIC32X4_IFACE1, data);
+
+	return 0;
+}
+
+static int aic32x4_mute(struct snd_soc_dai *dai, int mute)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	u8 dac_reg;
+
+	dac_reg = snd_soc_read(codec, AIC32X4_DACMUTE) & ~AIC32X4_MUTEON;
+	if (mute)
+		snd_soc_write(codec, AIC32X4_DACMUTE, dac_reg | AIC32X4_MUTEON);
+	else
+		snd_soc_write(codec, AIC32X4_DACMUTE, dac_reg);
+	return 0;
+}
+
+static int aic32x4_set_bias_level(struct snd_soc_codec *codec,
+				  enum snd_soc_bias_level level)
+{
+	struct aic32x4_priv *aic32x4 = snd_soc_codec_get_drvdata(codec);
+	u8 value;
+
+	switch (level) {
+	case SND_SOC_BIAS_ON:
+		if (aic32x4->master) {
+			/* Switch on PLL */
+			value = snd_soc_read(codec, AIC32X4_PLLPR);
+			snd_soc_write(codec, AIC32X4_PLLPR,
+				      (value | AIC32X4_PLLEN));
+
+			/* Switch on NDAC Divider */
+			value = snd_soc_read(codec, AIC32X4_NDAC);
+			snd_soc_write(codec, AIC32X4_NDAC,
+				      value | AIC32X4_NDACEN);
+
+			/* Switch on MDAC Divider */
+			value = snd_soc_read(codec, AIC32X4_MDAC);
+			snd_soc_write(codec, AIC32X4_MDAC,
+				      value | AIC32X4_MDACEN);
+
+			/* Switch on NADC Divider */
+			value = snd_soc_read(codec, AIC32X4_NADC);
+			snd_soc_write(codec, AIC32X4_NADC,
+				      value | AIC32X4_MDACEN);
+
+			/* Switch on MADC Divider */
+			value = snd_soc_read(codec, AIC32X4_MADC);
+			snd_soc_write(codec, AIC32X4_MADC,
+				      value | AIC32X4_MDACEN);
+
+			/* Switch on BCLK_N Divider */
+			value = snd_soc_read(codec, AIC32X4_BCLKN);
+			snd_soc_write(codec, AIC32X4_BCLKN,
+				      value | AIC32X4_BCLKEN);
+		}
+		break;
+	case SND_SOC_BIAS_PREPARE:
+		break;
+	case SND_SOC_BIAS_STANDBY:
+		if (aic32x4->master) {
+			/* Switch off PLL */
+			value = snd_soc_read(codec, AIC32X4_PLLPR);
+			snd_soc_write(codec, AIC32X4_PLLPR,
+				      (value & ~AIC32X4_PLLEN));
+
+			/* Switch off NDAC Divider */
+			value = snd_soc_read(codec, AIC32X4_NDAC);
+			snd_soc_write(codec, AIC32X4_NDAC,
+				      value & ~AIC32X4_NDACEN);
+
+			/* Switch off MDAC Divider */
+			value = snd_soc_read(codec, AIC32X4_MDAC);
+			snd_soc_write(codec, AIC32X4_MDAC,
+				      value & ~AIC32X4_MDACEN);
+
+			/* Switch off NADC Divider */
+			value = snd_soc_read(codec, AIC32X4_NADC);
+			snd_soc_write(codec, AIC32X4_NADC,
+				      value & ~AIC32X4_NDACEN);
+
+			/* Switch off MADC Divider */
+			value = snd_soc_read(codec, AIC32X4_MADC);
+			snd_soc_write(codec, AIC32X4_MADC,
+				      value & ~AIC32X4_MDACEN);
+			value = snd_soc_read(codec, AIC32X4_BCLKN);
+
+			/* Switch off BCLK_N Divider */
+			snd_soc_write(codec, AIC32X4_BCLKN,
+				      value & ~AIC32X4_BCLKEN);
+		}
+		break;
+	case SND_SOC_BIAS_OFF:
+		break;
+	}
+	codec->bias_level = level;
+	return 0;
+}
+
+#define AIC32X4_RATES	SNDRV_PCM_RATE_8000_48000
+#define AIC32X4_FORMATS	(SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE \
+			 | SNDRV_PCM_FMTBIT_S24_3LE | SNDRV_PCM_FMTBIT_S32_LE)
+
+static struct snd_soc_dai_ops aic32x4_ops = {
+	.hw_params = aic32x4_hw_params,
+	.digital_mute = aic32x4_mute,
+	.set_fmt = aic32x4_set_dai_fmt,
+	.set_sysclk = aic32x4_set_dai_sysclk,
+};
+
+static struct snd_soc_dai_driver aic32x4_dai = {
+	.name = "tlv320aic32x4-hifi",
+	.playback = {
+		     .stream_name = "Playback",
+		     .channels_min = 1,
+		     .channels_max = 2,
+		     .rates = AIC32X4_RATES,
+		     .formats = AIC32X4_FORMATS,},
+	.capture = {
+		    .stream_name = "Capture",
+		    .channels_min = 1,
+		    .channels_max = 2,
+		    .rates = AIC32X4_RATES,
+		    .formats = AIC32X4_FORMATS,},
+	.ops = &aic32x4_ops,
+	.symmetric_rates = 1,
+};
+
+static int aic32x4_suspend(struct snd_soc_codec *codec, pm_message_t state)
+{
+	aic32x4_set_bias_level(codec, SND_SOC_BIAS_OFF);
+	return 0;
+}
+
+static int aic32x4_resume(struct snd_soc_codec *codec)
+{
+	aic32x4_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
+	return 0;
+}
+
+static int aic32x4_probe(struct snd_soc_codec *codec)
+{
+	struct aic32x4_priv *aic32x4 = snd_soc_codec_get_drvdata(codec);
+	int i;
+
+	codec->hw_write = (hw_write_t) i2c_master_send;
+	codec->control_data = aic32x4->control_data;
+
+	aic32x4_reset(codec);
+
+	/* Initial value for some registers */
+	for (i = 0; i < ARRAY_SIZE(aic32x4_reg_init); i++)
+		snd_soc_write(codec, aic32x4_reg_init[i].reg_offset,
+			      aic32x4_reg_init[i].reg_val);
+
+	aic32x4_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
+	snd_soc_add_controls(codec, aic32x4_snd_controls,
+			     ARRAY_SIZE(aic32x4_snd_controls));
+	aic32x4_add_widgets(codec);
+
+	return 0;
+}
+
+
+static int aic32x4_remove(struct snd_soc_codec *codec)
+{
+	aic32x4_set_bias_level(codec, SND_SOC_BIAS_OFF);
+	return 0;
+}
+
+static struct snd_soc_codec_driver soc_codec_dev_aic32x4 = {
+	.read = aic32x4_read,
+	.write = aic32x4_write,
+	.probe = aic32x4_probe,
+	.remove = aic32x4_remove,
+	.suspend = aic32x4_suspend,
+	.resume = aic32x4_resume,
+	.set_bias_level = aic32x4_set_bias_level,
+};
+
+#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
+static __devinit int aic32x4_i2c_probe(struct i2c_client *i2c,
+				      const struct i2c_device_id *id)
+{
+	struct aic32x4_priv *aic32x4;
+	int ret;
+
+	aic32x4 = kzalloc(sizeof(struct aic32x4_priv), GFP_KERNEL);
+	if (aic32x4 == NULL)
+		return -ENOMEM;
+
+	aic32x4->control_data = i2c;
+	i2c_set_clientdata(i2c, aic32x4);
+
+	ret = snd_soc_register_codec(&i2c->dev,
+			&soc_codec_dev_aic32x4, &aic32x4_dai, 1);
+	if (ret < 0)
+		kfree(aic32x4);
+	return ret;
+}
+
+static __devexit int aic32x4_i2c_remove(struct i2c_client *client)
+{
+	snd_soc_unregister_codec(&client->dev);
+	kfree(i2c_get_clientdata(client));
+	return 0;
+}
+
+static const struct i2c_device_id aic32x4_i2c_id[] = {
+	{ "tlv320aic32x4", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, aic32x4_i2c_id);
+
+static struct i2c_driver aic32x4_i2c_driver = {
+	.driver = {
+		.name = "tlv320aic32x4-codec",
+		.owner = THIS_MODULE,
+	},
+	.probe =    aic32x4_i2c_probe,
+	.remove =   __devexit_p(aic32x4_i2c_remove),
+	.id_table = aic32x4_i2c_id,
+};
+#endif
+
+static int __init aic32x4_modinit(void)
+{
+	int ret = 0;
+#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
+	ret = i2c_add_driver(&aic32x4_i2c_driver);
+	if (ret != 0) {
+		printk(KERN_ERR "Failed to register aic32x4 I2C driver: %d\n",
+		       ret);
+	}
+#endif
+	return ret;
+}
+module_init(aic32x4_modinit);
+
+static void __exit aic32x4_exit(void)
+{
+#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
+	i2c_del_driver(&aic32x4_i2c_driver);
+#endif
+}
+module_exit(aic32x4_exit);
+
+MODULE_DESCRIPTION("ASoC tlv320aic32x4 codec driver");
+MODULE_AUTHOR("Javier Martin <javier.martin@vista-silicon.com>");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/tlv320aic32x4.h b/sound/soc/codecs/tlv320aic32x4.h
new file mode 100644
index 0000000..48c0a3d
--- /dev/null
+++ b/sound/soc/codecs/tlv320aic32x4.h
@@ -0,0 +1,138 @@
+/*
+ * tlv320aic32x4.h
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+
+#ifndef _TLV320AIC32X4_H
+#define _TLV320AIC32X4_H
+
+/* tlv320aic32x4 register space (in decimal to match datasheet) */
+
+#define AIC32X4_PAGE1		128
+
+#define	AIC32X4_PSEL		0
+#define	AIC32X4_RESET		1
+#define	AIC32X4_CLKMUX		4
+#define	AIC32X4_PLLPR		5
+#define	AIC32X4_PLLJ		6
+#define	AIC32X4_PLLDMSB		7
+#define	AIC32X4_PLLDLSB		8
+#define	AIC32X4_NDAC		11
+#define	AIC32X4_MDAC		12
+#define AIC32X4_DOSRMSB		13
+#define AIC32X4_DOSRLSB		14
+#define	AIC32X4_NADC		18
+#define	AIC32X4_MADC		19
+#define AIC32X4_AOSR		20
+#define AIC32X4_CLKMUX2		25
+#define AIC32X4_CLKOUTM		26
+#define AIC32X4_IFACE1		27
+#define AIC32X4_IFACE2		28
+#define AIC32X4_IFACE3		29
+#define AIC32X4_BCLKN		30
+#define AIC32X4_IFACE4		31
+#define AIC32X4_IFACE5		32
+#define AIC32X4_IFACE6		33
+#define AIC32X4_DOUTCTL		53
+#define AIC32X4_DINCTL		54
+#define AIC32X4_DACSPB		60
+#define AIC32X4_ADCSPB		61
+#define AIC32X4_DACSETUP	63
+#define AIC32X4_DACMUTE		64
+#define AIC32X4_LDACVOL		65
+#define AIC32X4_RDACVOL		66
+#define AIC32X4_ADCSETUP	81
+#define	AIC32X4_ADCFGA		82
+#define AIC32X4_LADCVOL		83
+#define AIC32X4_RADCVOL		84
+#define AIC32X4_LAGC1		86
+#define AIC32X4_LAGC2		87
+#define AIC32X4_LAGC3		88
+#define AIC32X4_LAGC4		89
+#define AIC32X4_LAGC5		90
+#define AIC32X4_LAGC6		91
+#define AIC32X4_LAGC7		92
+#define AIC32X4_RAGC1		94
+#define AIC32X4_RAGC2		95
+#define AIC32X4_RAGC3		96
+#define AIC32X4_RAGC4		97
+#define AIC32X4_RAGC5		98
+#define AIC32X4_RAGC6		99
+#define AIC32X4_RAGC7		100
+#define AIC32X4_PWRCFG		(AIC32X4_PAGE1 + 1)
+#define AIC32X4_LDOCTL		(AIC32X4_PAGE1 + 2)
+#define AIC32X4_OUTPWRCTL	(AIC32X4_PAGE1 + 9)
+#define AIC32X4_CMMODE		(AIC32X4_PAGE1 + 10)
+#define AIC32X4_HPLROUTE	(AIC32X4_PAGE1 + 12)
+#define AIC32X4_HPRROUTE	(AIC32X4_PAGE1 + 13)
+#define AIC32X4_LOLROUTE	(AIC32X4_PAGE1 + 14)
+#define AIC32X4_LORROUTE	(AIC32X4_PAGE1 + 15)
+#define	AIC32X4_HPLGAIN		(AIC32X4_PAGE1 + 16)
+#define	AIC32X4_HPRGAIN		(AIC32X4_PAGE1 + 17)
+#define	AIC32X4_LOLGAIN		(AIC32X4_PAGE1 + 18)
+#define	AIC32X4_LORGAIN		(AIC32X4_PAGE1 + 19)
+#define AIC32X4_HEADSTART	(AIC32X4_PAGE1 + 20)
+#define AIC32X4_MICBIAS		(AIC32X4_PAGE1 + 51)
+#define AIC32X4_LMICPGAPIN	(AIC32X4_PAGE1 + 52)
+#define AIC32X4_LMICPGANIN	(AIC32X4_PAGE1 + 54)
+#define AIC32X4_RMICPGAPIN	(AIC32X4_PAGE1 + 55)
+#define AIC32X4_RMICPGANIN	(AIC32X4_PAGE1 + 57)
+#define AIC32X4_FLOATINGINPUT	(AIC32X4_PAGE1 + 58)
+#define AIC32X4_LMICPGAVOL	(AIC32X4_PAGE1 + 59)
+#define AIC32X4_RMICPGAVOL	(AIC32X4_PAGE1 + 60)
+
+#define AIC32X4_FREQ_12000000 12000000
+#define AIC32X4_FREQ_24000000 24000000
+#define AIC32X4_FREQ_25000000 25000000
+
+#define AIC32X4_WORD_LEN_16BITS		0x00
+#define AIC32X4_WORD_LEN_20BITS		0x01
+#define AIC32X4_WORD_LEN_24BITS		0x02
+#define AIC32X4_WORD_LEN_32BITS		0x03
+
+#define AIC32X4_I2S_MODE		0x00
+#define AIC32X4_DSP_MODE		0x01
+#define AIC32X4_RIGHT_JUSTIFIED_MODE	0x02
+#define AIC32X4_LEFT_JUSTIFIED_MODE	0x03
+
+#define AIC32X4_AVDDWEAKDISABLE		0x08
+#define AIC32X4_LDOCTLEN		0x01
+
+#define AIC32X4_LDOIN_18_36		0x01
+#define AIC32X4_LDOIN2HP		0x02
+
+#define AIC32X4_DACSPBLOCK_MASK		0x1f
+#define AIC32X4_ADCSPBLOCK_MASK		0x1f
+
+#define AIC32X4_PLLJ_SHIFT		6
+#define AIC32X4_DOSRMSB_SHIFT		4
+
+#define AIC32X4_PLLCLKIN		0x03
+
+#define AIC32X4_LMICPGANIN_IN2R_10K	0x10
+#define AIC32X4_RMICPGANIN_IN1L_10K	0x10
+
+#define AIC32X4_LMICPGAVOL_NOGAIN	0x80
+#define AIC32X4_RMICPGAVOL_NOGAIN	0x80
+
+#define AIC32X4_BCLKMASTER		0x08
+#define AIC32X4_WCLKMASTER		0x04
+#define AIC32X4_PLLEN			(0x01 << 7)
+#define AIC32X4_NDACEN			(0x01 << 7)
+#define AIC32X4_MDACEN			(0x01 << 7)
+#define AIC32X4_NADCEN			(0x01 << 7)
+#define AIC32X4_MADCEN			(0x01 << 7)
+#define AIC32X4_BCLKEN			(0x01 << 7)
+#define AIC32X4_DACEN			(0x03 << 6)
+#define AIC32X4_LDAC2LCHN		(0x01 << 4)
+#define AIC32X4_RDAC2RCHN		(0x01 << 2)
+
+#define AIC32X4_SSTEP2WCLK		0x01
+#define AIC32X4_MUTEON			0x0C
+#define	AIC32X4_DACMOD2BCLK		0x01
+
+#endif				/* _TLV320AIC32X4_H */
-- 
1.7.0.4
