From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Thu, 12 Aug 2010 12:01:47 +0800
Subject: [PATCH 4/5] ASoC: add 88pm860x codec driver
Message-ID: <mailman.171.1281707762.27306.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add 88PM860x codec driver. 88PM860x codec supports two interfaces. And it
also supports headset/mic/hook/short detection.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 sound/soc/codecs/88pm860x-codec.c | 1567 +++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/88pm860x-codec.h |   97 +++
 sound/soc/codecs/Kconfig          |    4 +
 sound/soc/codecs/Makefile         |    2 +
 4 files changed, 1670 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/codecs/88pm860x-codec.c
 create mode 100644 sound/soc/codecs/88pm860x-codec.h

diff --git a/sound/soc/codecs/88pm860x-codec.c
b/sound/soc/codecs/88pm860x-codec.c
new file mode 100644
index 0000000..0e5b445
--- /dev/null
+++ b/sound/soc/codecs/88pm860x-codec.c
@@ -0,0 +1,1567 @@
+/*
+ * 88pm860x-codec.c -- 88PM860x ALSA SoC Audio Driver
+ *
+ * Copyright 2010 Marvell International Ltd.
+ * Author: Haojian Zhuang <haojian.zhuang@marvell.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/i2c.h>
+#include <linux/platform_device.h>
+#include <linux/mfd/88pm860x.h>
+#include <linux/slab.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+#include <sound/tlv.h>
+#include <sound/initval.h>
+
+#include "88pm860x-codec.h"
+
+#define MAX_NAME_LEN		20
+#define REG_CACHE_SIZE		0x40
+#define REG_CACHE_BASE		0xb0
+
+/* Status Register 1 (0x01) */
+#define REG_STATUS_1		0x01
+#define MIC_STATUS		(1 << 7)
+#define HOOK_STATUS		(1 << 6)
+#define HEADSET_STATUS		(1 << 5)
+
+/* Mic Detection Register (0x37) */
+#define REG_MIC_DET		0x37
+#define CONTINUOUS_POLLING	(3 << 1)
+#define EN_MIC_DET		(1 << 0)
+#define MICDET_MASK		0x07
+
+/* Headset Detection Register (0x38) */
+#define REG_HS_DET		0x38
+#define EN_HS_DET		(1 << 0)
+
+/* Misc2 Register (0x42) */
+#define REG_MISC2		0x42
+#define AUDIO_PLL		(1 << 5)
+#define AUDIO_SECTION_RESET	(1 << 4)
+#define AUDIO_SECTION_ON	(1 << 3)
+
+/* PCM Interface Register 2 (0xb1) */
+#define PCM_INF2_BCLK		(1 << 6)	/* Bit clock polarity */
+#define PCM_INF2_FS		(1 << 5)	/* Frame Sync polarity */
+#define PCM_INF2_MASTER		(1 << 4)	/* Master / Slave */
+#define PCM_INF2_18WL		(1 << 3)	/* 18 / 16 bits */
+#define PCM_GENERAL_I2S		0
+#define PCM_EXACT_I2S		1
+#define PCM_LEFT_I2S		2
+#define PCM_RIGHT_I2S		3
+#define PCM_SHORT_FS		4
+#define PCM_LONG_FS		5
+#define PCM_MODE_MASK		7
+
+/* I2S Interface Register 4 (0xbe) */
+#define I2S_EQU_BYP		(1 << 6)
+
+/* DAC Offset Register (0xcb) */
+#define DAC_MUTE		(1 << 7)
+
+/* ADC Analog Register 1 (0xd0) */
+#define REG_ADC_ANA_1		0xd0
+#define MIC1BIAS_MASK		0x60
+
+/* Earpiece/Speaker Control Register 2 (0xda) */
+#define REG_EAR2		0xda
+#define RSYNC_CHANGE		(1 << 2)
+
+/* Audio Supplies Register 2 (0xdc) */
+#define REG_SUPPLIES2		0xdc
+#define LDO15_READY		(1 << 4)
+#define LDO15_EN		(1 << 3)
+#define CPUMP_READY		(1 << 2)
+#define CPUMP_EN		(1 << 1)
+#define AUDIO_EN		(1 << 0)
+
+/* Audio Enable Register 1 (0xdd) */
+#define ADC_MOD_RIGHT		(1 << 1)
+#define ADC_MOD_LEFT		(1 << 0)
+
+/* Audio Enable Register 2 (0xde) */
+#define ADC_LEFT		(1 << 5)
+#define ADC_RIGHT		(1 << 4)
+
+/* DAC Enable Register 2 (0xe1) */
+#define DAC_LEFT		(1 << 5)
+#define DAC_RIGHT		(1 << 4)
+#define MODULATOR		(1 << 3)
+
+/* Shorts Register (0xeb) */
+#define REG_SHORTS		0xeb
+#define SHORT_LO2		(1 << 6)
+#define SHORT_LO1		(1 << 4)
+#define SHORT_HS2		(1 << 2)
+#define SHORT_HS1		(1 << 0)
+
+enum {
+	FILTER_BYPASS = 0,
+	FILTER_LOW_PASS_1,
+	FILTER_LOW_PASS_2,
+	FILTER_HIGH_PASS_3,
+	FILTER_MAX,
+};
+
+struct pm860x_hsdet {
+	struct snd_soc_jack	*jack;
+	int			det;
+};
+
+struct pm860x_priv {
+	unsigned int		sysclk;
+	unsigned int		pcmclk;
+	unsigned int		dir;
+	unsigned int		automute;
+	unsigned int		filter;
+	struct snd_soc_codec	*codec;
+	struct i2c_client	*i2c;
+	struct pm860x_chip	*chip;
+
+	int			irq[4];
+	unsigned char		name[4][MAX_NAME_LEN];
+	struct pm860x_hsdet	hsdet;
+	unsigned char		reg_cache[REG_CACHE_SIZE];
+};
+
+/* -9450dB to 0dB in 150dB steps ( mute instead of -9450dB) */
+static const DECLARE_TLV_DB_SCALE(dpga_tlv, -9450, 150, 1);
+
+/* -9dB to 0db in 3dB steps */
+static const DECLARE_TLV_DB_SCALE(adc_tlv, -900, 300, 0);
+
+/* {-23, -17, -13.5, -11, -9, -6, -3, 0}dB */
+static const unsigned int mic_tlv[] = {
+	TLV_DB_RANGE_HEAD(5),
+	0, 0, TLV_DB_SCALE_ITEM(-2300, 0, 0),
+	1, 1, TLV_DB_SCALE_ITEM(-1700, 0, 0),
+	2, 2, TLV_DB_SCALE_ITEM(-1350, 0, 0),
+	3, 3, TLV_DB_SCALE_ITEM(-1100, 0, 0),
+	4, 7, TLV_DB_SCALE_ITEM(-900, 300, 0),
+};
+
+/* {0, 0, 0, -6, 0, 6, 12, 18}dB */
+static const unsigned int aux_tlv[] = {
+	TLV_DB_RANGE_HEAD(2),
+	0, 2, TLV_DB_SCALE_ITEM(0, 0, 0),
+	3, 7, TLV_DB_SCALE_ITEM(-600, 600, 0),
+};
+
+/* {-16, -13, -10, -7, -5.2, -3,3, -2.2, 0}dB, mute instead of -16dB */
+static const unsigned int out_tlv[] = {
+	TLV_DB_RANGE_HEAD(4),
+	0, 3, TLV_DB_SCALE_ITEM(-1600, 300, 1),
+	4, 4, TLV_DB_SCALE_ITEM(-520, 0, 0),
+	5, 5, TLV_DB_SCALE_ITEM(-330, 0, 0),
+	6, 7, TLV_DB_SCALE_ITEM(-220, 220, 0),
+};
+
+static const unsigned int st_tlv[] = {
+	TLV_DB_RANGE_HEAD(8),
+	0, 1, TLV_DB_SCALE_ITEM(-12041, 602, 0),
+	2, 3, TLV_DB_SCALE_ITEM(-11087, 250, 0),
+	4, 5, TLV_DB_SCALE_ITEM(-10643, 158, 0),
+	6, 7, TLV_DB_SCALE_ITEM(-10351, 116, 0),
+	8, 9, TLV_DB_SCALE_ITEM(-10133, 92, 0),
+	10, 13, TLV_DB_SCALE_ITEM(-9958, 70, 0),
+	14, 17, TLV_DB_SCALE_ITEM(-9689, 53, 0),
+	18, 271, TLV_DB_SCALE_ITEM(-9484, 37, 0),
+};
+
+/* Sidetone Gain = M * 2^(-5-N) */
+struct st_gain {
+	unsigned int	db;
+	unsigned int	m;
+	unsigned int	n;
+};
+
+static struct st_gain st_table[] = {
+	{-12041,  1, 15}, {-11439,  1, 14}, {-11087,  3, 15}, {-10837,  1, 13},
+	{-10643,  5, 15}, {-10485,  3, 14}, {-10351,  7, 15}, {-10235,  1, 12},
+	{-10133,  9, 15}, {-10041,  5, 14}, { -9958, 11, 15}, { -9883,  3, 13},
+	{ -9813, 13, 15}, { -9749,  7, 14}, { -9689, 15, 15}, { -9633,  1, 11},
+	{ -9580, 17, 15}, { -9531,  9, 14}, { -9484, 19, 15}, { -9439,  5, 13},
+	{ -9397, 21, 15}, { -9356, 11, 14}, { -9318, 23, 15}, { -9281,  3, 12},
+	{ -9245, 25, 15}, { -9211, 13, 14}, { -9178, 27, 15}, { -9147,  7, 13},
+	{ -9116, 29, 15}, { -9087, 15, 14}, { -9058, 31, 15}, { -9031,  1, 10},
+	{ -8978, 17, 14}, { -8929,  9, 13}, { -8882, 19, 14}, { -8837,  5, 12},
+	{ -8795, 21, 14}, { -8754, 11, 13}, { -8716, 23, 14}, { -8679,  3, 11},
+	{ -8643, 25, 14}, { -8609, 13, 13}, { -8576, 27, 14}, { -8545,  7, 12},
+	{ -8514, 29, 14}, { -8485, 15, 13}, { -8456, 31, 14}, { -8429,  1,  9},
+	{ -8376, 17, 13}, { -8327,  9, 12}, { -8280, 19, 13}, { -8235,  5, 11},
+	{ -8193, 21, 13}, { -8152, 11, 12}, { -8114, 23, 13}, { -8077,  3, 10},
+	{ -8041, 25, 13}, { -8007, 13, 12}, { -7974, 27, 13}, { -7943,  7, 11},
+	{ -7912, 29, 13}, { -7883, 15, 12}, { -7854, 31, 13}, { -7827,  1,  8},
+	{ -7774, 17, 12}, { -7724,  9, 11}, { -7678, 19, 12}, { -7633,  5, 10},
+	{ -7591, 21, 12}, { -7550, 11, 11}, { -7512, 23, 12}, { -7475,  3,  9},
+	{ -7439, 25, 12}, { -7405, 13, 11}, { -7372, 27, 12}, { -7341,  7, 10},
+	{ -7310, 29, 12}, { -7281, 15, 11}, { -7252, 31, 12}, { -7225,  1,  7},
+	{ -7172, 17, 11}, { -7122,  9, 10}, { -7075, 19, 11}, { -7031,  5,  9},
+	{ -6989, 21, 11}, { -6948, 11, 10}, { -6910, 23, 11}, { -6873,  3,  8},
+	{ -6837, 25, 11}, { -6803, 13, 10}, { -6770, 27, 11}, { -6739,  7,  9},
+	{ -6708, 29, 11}, { -6679, 15, 10}, { -6650, 31, 11}, { -6623,  1,  6},
+	{ -6570, 17, 10}, { -6520,  9,  9}, { -6473, 19, 10}, { -6429,  5,  8},
+	{ -6386, 21, 10}, { -6346, 11,  9}, { -6307, 23, 10}, { -6270,  3,  7},
+	{ -6235, 25, 10}, { -6201, 13,  9}, { -6168, 27, 10}, { -6137,  7,  8},
+	{ -6106, 29, 10}, { -6077, 15,  9}, { -6048, 31, 10}, { -6021,  1,  5},
+	{ -5968, 17,  9}, { -5918,  9,  8}, { -5871, 19,  9}, { -5827,  5,  7},
+	{ -5784, 21,  9}, { -5744, 11,  8}, { -5705, 23,  9}, { -5668,  3,  6},
+	{ -5633, 25,  9}, { -5599, 13,  8}, { -5566, 27,  9}, { -5535,  7,  7},
+	{ -5504, 29,  9}, { -5475, 15,  8}, { -5446, 31,  9}, { -5419,  1,  4},
+	{ -5366, 17,  8}, { -5316,  9,  7}, { -5269, 19,  8}, { -5225,  5,  6},
+	{ -5182, 21,  8}, { -5142, 11,  7}, { -5103, 23,  8}, { -5066,  3,  5},
+	{ -5031, 25,  8}, { -4997, 13,  7}, { -4964, 27,  8}, { -4932,  7,  6},
+	{ -4902, 29,  8}, { -4873, 15,  7}, { -4844, 31,  8}, { -4816,  1,  3},
+	{ -4764, 17,  7}, { -4714,  9,  6}, { -4667, 19,  7}, { -4623,  5,  5},
+	{ -4580, 21,  7}, { -4540, 11,  6}, { -4501, 23,  7}, { -4464,  3,  4},
+	{ -4429, 25,  7}, { -4395, 13,  6}, { -4362, 27,  7}, { -4330,  7,  5},
+	{ -4300, 29,  7}, { -4270, 15,  6}, { -4242, 31,  7}, { -4214,  1,  2},
+	{ -4162, 17,  6}, { -4112,  9,  5}, { -4065, 19,  6}, { -4021,  5,  4},
+	{ -3978, 21,  6}, { -3938, 11,  5}, { -3899, 23,  6}, { -3862,  3,  3},
+	{ -3827, 25,  6}, { -3793, 13,  5}, { -3760, 27,  6}, { -3728,  7,  4},
+	{ -3698, 29,  6}, { -3668, 15,  5}, { -3640, 31,  6}, { -3612,  1,  1},
+	{ -3560, 17,  5}, { -3510,  9,  4}, { -3463, 19,  5}, { -3419,  5,  3},
+	{ -3376, 21,  5}, { -3336, 11,  4}, { -3297, 23,  5}, { -3260,  3,  2},
+	{ -3225, 25,  5}, { -3191, 13,  4}, { -3158, 27,  5}, { -3126,  7,  3},
+	{ -3096, 29,  5}, { -3066, 15,  4}, { -3038, 31,  5}, { -3010,  1,  0},
+	{ -2958, 17,  4}, { -2908,  9,  3}, { -2861, 19,  4}, { -2816,  5,  2},
+	{ -2774, 21,  4}, { -2734, 11,  3}, { -2695, 23,  4}, { -2658,  3,  1},
+	{ -2623, 25,  4}, { -2589, 13,  3}, { -2556, 27,  4}, { -2524,  7,  2},
+	{ -2494, 29,  4}, { -2464, 15,  3}, { -2436, 31,  4}, { -2408,  2,  0},
+	{ -2356, 17,  3}, { -2306,  9,  2}, { -2259, 19,  3}, { -2214,  5,  1},
+	{ -2172, 21,  3}, { -2132, 11,  2}, { -2093, 23,  3}, { -2056,  3,  0},
+	{ -2021, 25,  3}, { -1987, 13,  2}, { -1954, 27,  3}, { -1922,  7,  1},
+	{ -1892, 29,  3}, { -1862, 15,  2}, { -1834, 31,  3}, { -1806,  4,  0},
+	{ -1754, 17,  2}, { -1704,  9,  1}, { -1657, 19,  2}, { -1612,  5,  0},
+	{ -1570, 21,  2}, { -1530, 11,  1}, { -1491, 23,  2}, { -1454,  6,  0},
+	{ -1419, 25,  2}, { -1384, 13,  1}, { -1352, 27,  2}, { -1320,  7,  0},
+	{ -1290, 29,  2}, { -1260, 15,  1}, { -1232, 31,  2}, { -1204,  8,  0},
+	{ -1151, 17,  1}, { -1102,  9,  0}, { -1055, 19,  1}, { -1010, 10,  0},
+	{  -968, 21,  1}, {  -928, 11,  0}, {  -889, 23,  1}, {  -852, 12,  0},
+	{  -816, 25,  1}, {  -782, 13,  0}, {  -750, 27,  1}, {  -718, 14,  0},
+	{  -688, 29,  1}, {  -658, 15,  0}, {  -630, 31,  1}, {  -602, 16,  0},
+	{  -549, 17,  0}, {  -500, 18,  0}, {  -453, 19,  0}, {  -408, 20,  0},
+	{  -366, 21,  0}, {  -325, 22,  0}, {  -287, 23,  0}, {  -250, 24,  0},
+	{  -214, 25,  0}, {  -180, 26,  0}, {  -148, 27,  0}, {  -116, 28,  0},
+	{   -86, 29,  0}, {   -56, 30,  0}, {   -28, 31,  0}, {     0,  0,  0},
+};
+
+static int pm860x_volatile(unsigned int reg)
+{
+	BUG_ON(reg >= REG_CACHE_SIZE);
+
+	switch (reg) {
+	case PM860X_AUDIO_SUPPLIES_2:
+		return 1;
+	}
+
+	return 0;
+}
+
+static unsigned int pm860x_read_reg_cache(struct snd_soc_codec *codec,
+					  unsigned int reg)
+{
+	unsigned char *cache = codec->reg_cache;
+
+	BUG_ON(reg >= REG_CACHE_SIZE);
+
+	if (pm860x_volatile(reg))
+		return cache[reg];
+
+	reg += REG_CACHE_BASE;
+
+	return pm860x_reg_read(codec->control_data, reg);
+}
+
+static int pm860x_write_reg_cache(struct snd_soc_codec *codec,
+				  unsigned int reg, unsigned int value)
+{
+	unsigned char *cache = codec->reg_cache;
+
+	BUG_ON(reg >= REG_CACHE_SIZE);
+
+	if (!pm860x_volatile(reg))
+		cache[reg] = (unsigned char)value;
+
+	reg += REG_CACHE_BASE;
+
+	return pm860x_reg_write(codec->control_data, reg, value);
+}
+
+static int snd_soc_get_volsw_2r_st(struct snd_kcontrol *kcontrol,
+				   struct snd_ctl_elem_value *ucontrol)
+{
+	struct soc_mixer_control *mc =
+		(struct soc_mixer_control *)kcontrol->private_value;
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	unsigned int reg = mc->reg;
+	unsigned int reg2 = mc->rreg;
+	int val[2], val2[2], i;
+
+	val[0] = snd_soc_read(codec, reg) & 0x3f;
+	val[1] = (snd_soc_read(codec, PM860X_SIDETONE_SHIFT) >> 4) & 0xf;
+	val2[0] = snd_soc_read(codec, reg2) & 0x3f;
+	val2[1] = (snd_soc_read(codec, PM860X_SIDETONE_SHIFT)) & 0xf;
+
+	for (i = 0; i < ARRAY_SIZE(st_table); i++) {
+		if ((st_table[i].m == val[0]) && (st_table[i].n == val[1]))
+			ucontrol->value.integer.value[0] = i;
+		if ((st_table[i].m == val2[0]) && (st_table[i].n == val2[1]))
+			ucontrol->value.integer.value[1] = i;
+	}
+	return 0;
+}
+
+static int snd_soc_put_volsw_2r_st(struct snd_kcontrol *kcontrol,
+				   struct snd_ctl_elem_value *ucontrol)
+{
+	struct soc_mixer_control *mc =
+		(struct soc_mixer_control *)kcontrol->private_value;
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	unsigned int reg = mc->reg;
+	unsigned int reg2 = mc->rreg;
+	int err;
+	unsigned int val, val2;
+
+	val = ucontrol->value.integer.value[0];
+	val2 = ucontrol->value.integer.value[1];
+
+	err = snd_soc_update_bits(codec, reg, 0x3f, st_table[val].m);
+	if (err < 0)
+		return err;
+	err = snd_soc_update_bits(codec, PM860X_SIDETONE_SHIFT, 0xf0,
+				  st_table[val].n << 4);
+	if (err < 0)
+		return err;
+
+	err = snd_soc_update_bits(codec, reg2, 0x3f, st_table[val2].m);
+	if (err < 0)
+		return err;
+	err = snd_soc_update_bits(codec, PM860X_SIDETONE_SHIFT, 0x0f,
+				  st_table[val2].n);
+	return err;
+}
+
+static int snd_soc_get_volsw_2r_out(struct snd_kcontrol *kcontrol,
+				    struct snd_ctl_elem_value *ucontrol)
+{
+	struct soc_mixer_control *mc =
+		(struct soc_mixer_control *)kcontrol->private_value;
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	unsigned int reg = mc->reg;
+	unsigned int reg2 = mc->rreg;
+	unsigned int shift = mc->shift;
+	int max = mc->max, val, val2;
+	unsigned int mask = (1 << fls(max)) - 1;
+
+	val = snd_soc_read(codec, reg) >> shift;
+	val2 = snd_soc_read(codec, reg2) >> shift;
+	ucontrol->value.integer.value[0] = (max - val) & mask;
+	ucontrol->value.integer.value[1] = (max - val2) & mask;
+
+	return 0;
+}
+
+static int snd_soc_put_volsw_2r_out(struct snd_kcontrol *kcontrol,
+				    struct snd_ctl_elem_value *ucontrol)
+{
+	struct soc_mixer_control *mc =
+		(struct soc_mixer_control *)kcontrol->private_value;
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	unsigned int reg = mc->reg;
+	unsigned int reg2 = mc->rreg;
+	unsigned int shift = mc->shift;
+	int max = mc->max;
+	unsigned int mask = (1 << fls(max)) - 1;
+	int err;
+	unsigned int val, val2, val_mask;
+
+	val_mask = mask << shift;
+	val = ((max - ucontrol->value.integer.value[0]) & mask);
+	val2 = ((max - ucontrol->value.integer.value[1]) & mask);
+
+	val = val << shift;
+	val2 = val2 << shift;
+
+	err = snd_soc_update_bits(codec, reg, val_mask, val);
+	if (err < 0)
+		return err;
+
+	err = snd_soc_update_bits(codec, reg2, val_mask, val2);
+	return err;
+}
+
+static int snd_soc_get_equalizer(struct snd_kcontrol *kcontrol,
+				 struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct pm860x_priv *pm860x = snd_soc_codec_get_drvdata(codec);
+
+	if (pm860x->filter >= FILTER_MAX)
+		return -EINVAL;
+
+	ucontrol->value.enumerated.item[0] = pm860x->filter;
+	return 0;
+}
+
+static int snd_soc_put_equalizer(struct snd_kcontrol *kcontrol,
+				 struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct pm860x_priv *pm860x = snd_soc_codec_get_drvdata(codec);
+
+	if (ucontrol->value.integer.value[0] >= FILTER_MAX)
+		return -EINVAL;
+	pm860x->filter = ucontrol->value.integer.value[0];
+	switch (pm860x->filter) {
+	case FILTER_BYPASS:
+		snd_soc_update_bits(codec, PM860X_I2S_IFACE_4, I2S_EQU_BYP,
+				    I2S_EQU_BYP);
+		snd_soc_write(codec, PM860X_EQUALIZER_N0_1, 0);
+		snd_soc_write(codec, PM860X_EQUALIZER_N0_2, 0);
+		snd_soc_write(codec, PM860X_EQUALIZER_N1_1, 0);
+		snd_soc_write(codec, PM860X_EQUALIZER_N1_2, 0);
+		snd_soc_write(codec, PM860X_EQUALIZER_D1_1, 0);
+		snd_soc_write(codec, PM860X_EQUALIZER_D1_2, 0);
+		snd_soc_update_bits(codec, PM860X_EAR_CTRL_2, RSYNC_CHANGE,
+				    RSYNC_CHANGE);
+		return 0;
+	case FILTER_LOW_PASS_1:
+		snd_soc_write(codec, PM860X_EQUALIZER_N0_1, 0xf3);
+		snd_soc_write(codec, PM860X_EQUALIZER_N0_2, 0x3a);
+		snd_soc_write(codec, PM860X_EQUALIZER_N1_1, 0xc3);
+		snd_soc_write(codec, PM860X_EQUALIZER_N1_2, 0xf4);
+		snd_soc_write(codec, PM860X_EQUALIZER_D1_1, 0xb5);
+		snd_soc_write(codec, PM860X_EQUALIZER_D1_2, 0xaf);
+		break;
+	case FILTER_LOW_PASS_2:
+		snd_soc_write(codec, PM860X_EQUALIZER_N0_1, 0x36);
+		snd_soc_write(codec, PM860X_EQUALIZER_N0_2, 0x42);
+		snd_soc_write(codec, PM860X_EQUALIZER_N1_1, 0x3c);
+		snd_soc_write(codec, PM860X_EQUALIZER_N1_2, 0xfb);
+		snd_soc_write(codec, PM860X_EQUALIZER_D1_1, 0x73);
+		snd_soc_write(codec, PM860X_EQUALIZER_D1_2, 0xbd);
+		break;
+	case FILTER_HIGH_PASS_3:
+		snd_soc_write(codec, PM860X_EQUALIZER_N0_1, 0x55);
+		snd_soc_write(codec, PM860X_EQUALIZER_N0_2, 0x39);
+		snd_soc_write(codec, PM860X_EQUALIZER_N1_1, 0x5a);
+		snd_soc_write(codec, PM860X_EQUALIZER_N1_2, 0xf3);
+		snd_soc_write(codec, PM860X_EQUALIZER_D1_1, 0x7e);
+		snd_soc_write(codec, PM860X_EQUALIZER_D1_2, 0x53);
+		break;
+	}
+	snd_soc_update_bits(codec, PM860X_EAR_CTRL_2, RSYNC_CHANGE,
+			    RSYNC_CHANGE);
+	snd_soc_update_bits(codec, PM860X_I2S_IFACE_4, I2S_EQU_BYP, 0);
+	return 0;
+}
+
+/* DAPM Widget Events */
+static int pm860x_rsync_event(struct snd_soc_dapm_widget *w,
+			      struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_codec *codec = w->codec;
+	struct pm860x_priv *pm860x = snd_soc_codec_get_drvdata(codec);
+
+	/* unmute DAC */
+	if (pm860x->automute) {
+		snd_soc_update_bits(codec, PM860X_DAC_OFFSET, DAC_MUTE, 0);
+		pm860x->automute = 0;
+	}
+	snd_soc_update_bits(codec, PM860X_EAR_CTRL_2,
+			    RSYNC_CHANGE, RSYNC_CHANGE);
+	return 0;
+}
+
+static int pm860x_adc_event(struct snd_soc_dapm_widget *w,
+			    struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_codec *codec = w->codec;
+	unsigned int en1 = 0, en2 = 0;
+
+	if (!strcmp(w->name, "Left ADC")) {
+		en1 = ADC_MOD_LEFT;
+		en2 = ADC_LEFT;
+	}
+	if (!strcmp(w->name, "Right ADC")) {
+		en1 = ADC_MOD_RIGHT;
+		en2 = ADC_RIGHT;
+	}
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		snd_soc_update_bits(codec, PM860X_ADC_EN_1, en1, en1);
+		snd_soc_update_bits(codec, PM860X_ADC_EN_2, en2, en2);
+		break;
+	case SND_SOC_DAPM_PRE_PMD:
+		snd_soc_update_bits(codec, PM860X_ADC_EN_1, en1, 0);
+		snd_soc_update_bits(codec, PM860X_ADC_EN_2, en2, 0);
+		break;
+	}
+	return 0;
+}
+
+static int pm860x_dac_event(struct snd_soc_dapm_widget *w,
+			    struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_codec *codec = w->codec;
+	struct pm860x_priv *pm860x = snd_soc_codec_get_drvdata(codec);
+	unsigned int data, dac = 0;
+
+	if (!strcmp(w->name, "Left DAC"))
+		dac = DAC_LEFT;
+	if (!strcmp(w->name, "Right DAC"))
+		dac = DAC_RIGHT;
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		if (dac) {
+			pm860x->automute = 1;
+			dac |= MODULATOR;
+			/* mute */
+			snd_soc_update_bits(codec, PM860X_DAC_OFFSET,
+					    DAC_MUTE, DAC_MUTE);
+			snd_soc_update_bits(codec, PM860X_EAR_CTRL_2,
+					    RSYNC_CHANGE, RSYNC_CHANGE);
+			/* update dac */
+			snd_soc_update_bits(codec, PM860X_DAC_EN_2,
+					    dac, dac);
+		}
+		break;
+	case SND_SOC_DAPM_PRE_PMD:
+		if (dac) {
+			pm860x->automute = 1;
+			/* mute */
+			snd_soc_update_bits(codec, PM860X_DAC_OFFSET,
+					    DAC_MUTE, DAC_MUTE);
+			snd_soc_update_bits(codec, PM860X_EAR_CTRL_2,
+					    RSYNC_CHANGE, RSYNC_CHANGE);
+			/* update dac */
+			data = snd_soc_read(codec, PM860X_DAC_EN_2);
+			data &= ~dac;
+			if (!(data & (DAC_LEFT | DAC_RIGHT)))
+				data &= ~MODULATOR;
+			snd_soc_write(codec, PM860X_DAC_EN_2, data);
+		}
+		break;
+	}
+	return 0;
+}
+
+static int pm860x_spk_event(struct snd_soc_dapm_widget *w,
+			    struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_codec *codec = w->codec;
+
+	dev_dbg(codec->dev, "event:%x\n", event);
+	return 0;
+}
+
+static const char *pm860x_equalizer_texts[] = {"Filter Bypass",
+					       "Low Pass Filter1",
+					       "Low Pass Filter 2",
+					       "High Pass Filter 3"};
+
+static const struct soc_enum pm860x_equalizer_enum =
+	SOC_ENUM_SINGLE(SND_SOC_NOPM, 0, ARRAY_SIZE(pm860x_equalizer_texts),
+			pm860x_equalizer_texts);
+;
+
+static const char *pm860x_opamp_texts[] = {"-50%", "-25%", "0%", "75%"};
+
+static const char *pm860x_pa_texts[] = {"-33%", "0%", "33%", "66%"};
+
+static const struct soc_enum pm860x_enum[] = {
+	SOC_ENUM_SINGLE(PM860X_HS1_CTRL, 5, 4, pm860x_opamp_texts),
+	SOC_ENUM_SINGLE(PM860X_HS2_CTRL, 5, 4, pm860x_opamp_texts),
+	SOC_ENUM_SINGLE(PM860X_HS1_CTRL, 3, 4, pm860x_pa_texts),
+	SOC_ENUM_SINGLE(PM860X_HS2_CTRL, 3, 4, pm860x_pa_texts),
+	SOC_ENUM_SINGLE(PM860X_LO1_CTRL, 5, 4, pm860x_opamp_texts),
+	SOC_ENUM_SINGLE(PM860X_LO2_CTRL, 5, 4, pm860x_opamp_texts),
+	SOC_ENUM_SINGLE(PM860X_LO1_CTRL, 3, 4, pm860x_pa_texts),
+	SOC_ENUM_SINGLE(PM860X_LO2_CTRL, 3, 4, pm860x_pa_texts),
+	SOC_ENUM_SINGLE(PM860X_EAR_CTRL_1, 3, 4, pm860x_opamp_texts),
+	SOC_ENUM_SINGLE(PM860X_EAR_CTRL_1, 5, 4, pm860x_pa_texts),
+	SOC_ENUM_SINGLE(PM860X_EAR_CTRL_2, 0, 4, pm860x_pa_texts),
+};
+
+static const struct snd_kcontrol_new pm860x_snd_controls[] = {
+	SOC_DOUBLE_R_TLV("ADC Capture Volume", PM860X_ADC_ANA_2,
+			PM860X_ADC_ANA_3, 6, 3, 0, adc_tlv),
+	SOC_DOUBLE_TLV("AUX Capture Volume", PM860X_ADC_ANA_3, 0, 3, 7, 0,
+			aux_tlv),
+	SOC_SINGLE_TLV("MIC1 Capture Volume", PM860X_ADC_ANA_2, 0, 7, 0,
+			mic_tlv),
+	SOC_SINGLE_TLV("MIC3 Capture Volume", PM860X_ADC_ANA_2, 3, 7, 0,
+			mic_tlv),
+	SOC_DOUBLE_R_EXT_TLV("Sidetone Capture Volume", PM860X_SIDETONE_L_GAIN,
+			     PM860X_SIDETONE_R_GAIN, 0, ARRAY_SIZE(st_table)-1,
+			     0, snd_soc_get_volsw_2r_st,
+			     snd_soc_put_volsw_2r_st, st_tlv),
+	SOC_SINGLE_TLV("Speaker Playback Volume", PM860X_EAR_CTRL_1,
+			0, 7, 0, out_tlv),
+	SOC_DOUBLE_R_TLV("Line Playback Volume", PM860X_LO1_CTRL,
+			 PM860X_LO2_CTRL, 0, 7, 0, out_tlv),
+	SOC_DOUBLE_R_TLV("Headset Playback Volume", PM860X_HS1_CTRL,
+			 PM860X_HS2_CTRL, 0, 7, 0, out_tlv),
+	SOC_DOUBLE_R_EXT_TLV("Hifi Left Playback Volume",
+			     PM860X_HIFIL_GAIN_LEFT,
+			     PM860X_HIFIL_GAIN_RIGHT, 0, 63, 0,
+			     snd_soc_get_volsw_2r_out,
+			     snd_soc_put_volsw_2r_out, dpga_tlv),
+	SOC_DOUBLE_R_EXT_TLV("Hifi Right Playback Volume",
+			     PM860X_HIFIR_GAIN_LEFT,
+			     PM860X_HIFIR_GAIN_RIGHT, 0, 63, 0,
+			     snd_soc_get_volsw_2r_out,
+			     snd_soc_put_volsw_2r_out, dpga_tlv),
+	SOC_DOUBLE_R_EXT_TLV("Lofi Playback Volume", PM860X_LOFI_GAIN_LEFT,
+			     PM860X_LOFI_GAIN_RIGHT, 0, 63, 0,
+			     snd_soc_get_volsw_2r_out,
+			     snd_soc_put_volsw_2r_out, dpga_tlv),
+	SOC_ENUM_EXT("Equalizer", pm860x_equalizer_enum, snd_soc_get_equalizer,
+		     snd_soc_put_equalizer),
+	SOC_ENUM("Headset1 Operational Amplifier Current", pm860x_enum[0]),
+	SOC_ENUM("Headset2 Operational Amplifier Current", pm860x_enum[1]),
+	SOC_ENUM("Headset1 Amplifier Current", pm860x_enum[2]),
+	SOC_ENUM("Headset2 Amplifier Current", pm860x_enum[3]),
+	SOC_ENUM("Lineout1 Operational Amplifier Current", pm860x_enum[4]),
+	SOC_ENUM("Lineout2 Operational Amplifier Current", pm860x_enum[5]),
+	SOC_ENUM("Lineout1 Amplifier Current", pm860x_enum[6]),
+	SOC_ENUM("Lineout2 Amplifier Current", pm860x_enum[7]),
+	SOC_ENUM("Speaker Operational Amplifier Current", pm860x_enum[8]),
+	SOC_ENUM("Speaker Amplifier Current", pm860x_enum[9]),
+	SOC_ENUM("Earpiece Amplifier Current", pm860x_enum[10]),
+};
+
+/*
+ * DAPM Controls
+ */
+
+/* PCM Switch / PCM Interface */
+static const struct snd_kcontrol_new pcm_switch_controls =
+	SOC_DAPM_SINGLE("Switch", PM860X_ADC_EN_2, 0, 1, 0);
+
+/* AUX1 Switch */
+static const struct snd_kcontrol_new aux1_switch_controls =
+	SOC_DAPM_SINGLE("Switch", PM860X_ANA_TO_ANA, 4, 1, 0);
+
+/* AUX2 Switch */
+static const struct snd_kcontrol_new aux2_switch_controls =
+	SOC_DAPM_SINGLE("Switch", PM860X_ANA_TO_ANA, 5, 1, 0);
+
+/* Left Ex. PA Switch */
+static const struct snd_kcontrol_new lepa_switch_controls =
+	SOC_DAPM_SINGLE("Switch", PM860X_DAC_EN_2, 2, 1, 0);
+
+/* Right Ex. PA Switch */
+static const struct snd_kcontrol_new repa_switch_controls =
+	SOC_DAPM_SINGLE("Switch", PM860X_DAC_EN_2, 1, 1, 0);
+
+/* PCM Mux / Mux7 */
+static const char *aif1_text[] = {
+	"PCM L", "PCM R",
+};
+
+static const struct soc_enum aif1_enum =
+	SOC_ENUM_SINGLE(PM860X_PCM_IFACE_3, 6, 2, aif1_text);
+
+static const struct snd_kcontrol_new aif1_mux =
+	SOC_DAPM_ENUM("PCM Mux", aif1_enum);
+
+/* I2S Mux / Mux9 */
+static const char *i2s_din_text[] = {
+	"DIN", "DIN1",
+};
+
+static const struct soc_enum i2s_din_enum =
+	SOC_ENUM_SINGLE(PM860X_I2S_IFACE_3, 1, 2, i2s_din_text);
+
+static const struct snd_kcontrol_new i2s_din_mux =
+	SOC_DAPM_ENUM("I2S DIN Mux", i2s_din_enum);
+
+/* I2S Mic Mux / Mux8 */
+static const char *i2s_mic_text[] = {
+	"Ex PA", "ADC",
+};
+
+static const struct soc_enum i2s_mic_enum =
+	SOC_ENUM_SINGLE(PM860X_I2S_IFACE_3, 4, 2, i2s_mic_text);
+
+static const struct snd_kcontrol_new i2s_mic_mux =
+	SOC_DAPM_ENUM("I2S Mic Mux", i2s_mic_enum);
+
+/* ADCL Mux / Mux2 */
+static const char *adcl_text[] = {
+	"ADCR", "ADCL",
+};
+
+static const struct soc_enum adcl_enum =
+	SOC_ENUM_SINGLE(PM860X_PCM_IFACE_3, 4, 2, adcl_text);
+
+static const struct snd_kcontrol_new adcl_mux =
+	SOC_DAPM_ENUM("ADC Left Mux", adcl_enum);
+
+/* ADCR Mux / Mux3 */
+static const char *adcr_text[] = {
+	"ADCL", "ADCR",
+};
+
+static const struct soc_enum adcr_enum =
+	SOC_ENUM_SINGLE(PM860X_PCM_IFACE_3, 2, 2, adcr_text);
+
+static const struct snd_kcontrol_new adcr_mux =
+	SOC_DAPM_ENUM("ADC Right Mux", adcr_enum);
+
+/* ADCR EC Mux / Mux6 */
+static const char *adcr_ec_text[] = {
+	"ADCR", "EC",
+};
+
+static const struct soc_enum adcr_ec_enum =
+	SOC_ENUM_SINGLE(PM860X_ADC_EN_2, 3, 2, adcr_ec_text);
+
+static const struct snd_kcontrol_new adcr_ec_mux =
+	SOC_DAPM_ENUM("ADCR EC Mux", adcr_ec_enum);
+
+/* EC Mux / Mux4 */
+static const char *ec_text[] = {
+	"Left", "Right", "Left + Right",
+};
+
+static const struct soc_enum ec_enum =
+	SOC_ENUM_SINGLE(PM860X_EC_PATH, 1, 3, ec_text);
+
+static const struct snd_kcontrol_new ec_mux =
+	SOC_DAPM_ENUM("EC Mux", ec_enum);
+
+static const char *dac_text[] = {
+	"No input", "Right", "Left", "No input",
+};
+
+/* DAC Headset 1 Mux / Mux10 */
+static const struct soc_enum dac_hs1_enum =
+	SOC_ENUM_SINGLE(PM860X_ANA_INPUT_SEL_1, 0, 4, dac_text);
+
+static const struct snd_kcontrol_new dac_hs1_mux =
+	SOC_DAPM_ENUM("DAC HS1 Mux", dac_hs1_enum);
+
+/* DAC Headset 2 Mux / Mux11 */
+static const struct soc_enum dac_hs2_enum =
+	SOC_ENUM_SINGLE(PM860X_ANA_INPUT_SEL_1, 2, 4, dac_text);
+
+static const struct snd_kcontrol_new dac_hs2_mux =
+	SOC_DAPM_ENUM("DAC HS2 Mux", dac_hs2_enum);
+
+/* DAC Lineout 1 Mux / Mux12 */
+static const struct soc_enum dac_lo1_enum =
+	SOC_ENUM_SINGLE(PM860X_ANA_INPUT_SEL_1, 4, 4, dac_text);
+
+static const struct snd_kcontrol_new dac_lo1_mux =
+	SOC_DAPM_ENUM("DAC LO1 Mux", dac_lo1_enum);
+
+/* DAC Lineout 2 Mux / Mux13 */
+static const struct soc_enum dac_lo2_enum =
+	SOC_ENUM_SINGLE(PM860X_ANA_INPUT_SEL_1, 6, 4, dac_text);
+
+static const struct snd_kcontrol_new dac_lo2_mux =
+	SOC_DAPM_ENUM("DAC LO2 Mux", dac_lo2_enum);
+
+/* DAC Spearker Earphone Mux / Mux14 */
+static const struct soc_enum dac_spk_ear_enum =
+	SOC_ENUM_SINGLE(PM860X_ANA_INPUT_SEL_2, 0, 4, dac_text);
+
+static const struct snd_kcontrol_new dac_spk_ear_mux =
+	SOC_DAPM_ENUM("DAC SP Mux", dac_spk_ear_enum);
+
+/* Headset 1 Mux / Mux15 */
+static const char *in_text[] = {
+	"DIGITAL", "ANALOG",
+};
+
+static const struct soc_enum hs1_enum =
+	SOC_ENUM_SINGLE(PM860X_ANA_TO_ANA, 0, 2, in_text);
+
+static const struct snd_kcontrol_new hs1_mux =
+	SOC_DAPM_ENUM("Headset1 Mux", hs1_enum);
+
+/* Headset 2 Mux / Mux16 */
+static const struct soc_enum hs2_enum =
+	SOC_ENUM_SINGLE(PM860X_ANA_TO_ANA, 1, 2, in_text);
+
+static const struct snd_kcontrol_new hs2_mux =
+	SOC_DAPM_ENUM("Headset2 Mux", hs2_enum);
+
+/* Lineout 1 Mux / Mux17 */
+static const struct soc_enum lo1_enum =
+	SOC_ENUM_SINGLE(PM860X_ANA_TO_ANA, 2, 2, in_text);
+
+static const struct snd_kcontrol_new lo1_mux =
+	SOC_DAPM_ENUM("Lineout1 Mux", lo1_enum);
+
+/* Lineout 2 Mux / Mux18 */
+static const struct soc_enum lo2_enum =
+	SOC_ENUM_SINGLE(PM860X_ANA_TO_ANA, 3, 2, in_text);
+
+static const struct snd_kcontrol_new lo2_mux =
+	SOC_DAPM_ENUM("Lineout2 Mux", lo2_enum);
+
+/* Speaker Earpiece Demux */
+static const char *spk_text[] = {
+	"Earpiece", "Speaker",
+};
+
+static const struct soc_enum spk_enum =
+	SOC_ENUM_SINGLE(PM860X_ANA_TO_ANA, 6, 2, spk_text);
+
+static const struct snd_kcontrol_new spk_demux =
+	SOC_DAPM_ENUM("Speaker Earpiece Demux", spk_enum);
+
+/* MIC Mux / Mux1 */
+static const char *mic_text[] = {
+	"Mic 1", "Mic 2",
+};
+
+static const struct soc_enum mic_enum =
+	SOC_ENUM_SINGLE(PM860X_ADC_ANA_4, 4, 2, mic_text);
+
+static const struct snd_kcontrol_new mic_mux =
+	SOC_DAPM_ENUM("MIC Mux", mic_enum);
+
+static const struct snd_soc_dapm_widget pm860x_dapm_widgets[] = {
+	SND_SOC_DAPM_AIF_IN("PCM SDI", "PCM Playback", 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("PCM SDO", "PCM Capture", 0,
+			     PM860X_PCM_IFACE_3, 1, 1),
+
+
+	SND_SOC_DAPM_AIF_IN("I2S DIN", "I2S Playback", 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_IN("I2S DIN1", "I2S Playback", 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("I2S DOUT", "I2S Capture", 0,
+			     PM860X_I2S_IFACE_3, 5, 1),
+	SND_SOC_DAPM_MUX("I2S Mic Mux", SND_SOC_NOPM, 0, 0, &i2s_mic_mux),
+	SND_SOC_DAPM_MUX("ADC Left Mux", SND_SOC_NOPM, 0, 0, &adcl_mux),
+	SND_SOC_DAPM_MUX("ADC Right Mux", SND_SOC_NOPM, 0, 0, &adcr_mux),
+	SND_SOC_DAPM_MUX("EC Mux", SND_SOC_NOPM, 0, 0, &ec_mux),
+	SND_SOC_DAPM_MUX("ADCR EC Mux", SND_SOC_NOPM, 0, 0, &adcr_ec_mux),
+	SND_SOC_DAPM_SWITCH("Left EPA", SND_SOC_NOPM, 0, 0,
+			    &lepa_switch_controls),
+	SND_SOC_DAPM_SWITCH("Right EPA", SND_SOC_NOPM, 0, 0,
+			    &repa_switch_controls),
+
+	SND_SOC_DAPM_ADC_E("Left ADC", NULL, SND_SOC_NOPM, 0, 0,
+			   pm860x_adc_event,
+			   SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_PRE_PMD),
+	SND_SOC_DAPM_ADC_E("Right ADC", NULL, SND_SOC_NOPM, 0, 0,
+			   pm860x_adc_event,
+			   SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_PRE_PMD),
+
+	SND_SOC_DAPM_SWITCH("AUX1 Switch", SND_SOC_NOPM, 0, 0,
+			    &aux1_switch_controls),
+	SND_SOC_DAPM_SWITCH("AUX2 Switch", SND_SOC_NOPM, 0, 0,
+			    &aux2_switch_controls),
+
+	SND_SOC_DAPM_MUX("MIC Mux", SND_SOC_NOPM, 0, 0, &mic_mux),
+	SND_SOC_DAPM_MICBIAS("Mic1 Bias", PM860X_ADC_ANA_1, 2, 0),
+	SND_SOC_DAPM_MICBIAS("Mic3 Bias", PM860X_ADC_ANA_1, 7, 0),
+	SND_SOC_DAPM_PGA("MIC1 Volume", PM860X_ADC_EN_1, 2, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("MIC3 Volume", PM860X_ADC_EN_1, 3, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("AUX1 Volume", PM860X_ADC_EN_1, 4, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("AUX2 Volume", PM860X_ADC_EN_1, 5, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("Sidetone PGA", PM860X_ADC_EN_2, 1, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("Lofi PGA", PM860X_ADC_EN_2, 2, 0, NULL, 0),
+
+	SND_SOC_DAPM_INPUT("AUX1"),
+	SND_SOC_DAPM_INPUT("AUX2"),
+	SND_SOC_DAPM_INPUT("MIC1P"),
+	SND_SOC_DAPM_INPUT("MIC1N"),
+	SND_SOC_DAPM_INPUT("MIC2P"),
+	SND_SOC_DAPM_INPUT("MIC2N"),
+	SND_SOC_DAPM_INPUT("MIC3P"),
+	SND_SOC_DAPM_INPUT("MIC3N"),
+
+	SND_SOC_DAPM_DAC_E("Left DAC", NULL, SND_SOC_NOPM, 0, 0,
+			   pm860x_dac_event,
+			   SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_PRE_PMD),
+	SND_SOC_DAPM_DAC_E("Right DAC", NULL, SND_SOC_NOPM, 0, 0,
+			   pm860x_dac_event,
+			   SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_PRE_PMD),
+
+	SND_SOC_DAPM_MUX("I2S DIN Mux", SND_SOC_NOPM, 0, 0, &i2s_din_mux),
+	SND_SOC_DAPM_MUX("DAC HS1 Mux", SND_SOC_NOPM, 0, 0, &dac_hs1_mux),
+	SND_SOC_DAPM_MUX("DAC HS2 Mux", SND_SOC_NOPM, 0, 0, &dac_hs2_mux),
+	SND_SOC_DAPM_MUX("DAC LO1 Mux", SND_SOC_NOPM, 0, 0, &dac_lo1_mux),
+	SND_SOC_DAPM_MUX("DAC LO2 Mux", SND_SOC_NOPM, 0, 0, &dac_lo2_mux),
+	SND_SOC_DAPM_MUX("DAC SP Mux", SND_SOC_NOPM, 0, 0, &dac_spk_ear_mux),
+	SND_SOC_DAPM_MUX("Headset1 Mux", SND_SOC_NOPM, 0, 0, &hs1_mux),
+	SND_SOC_DAPM_MUX("Headset2 Mux", SND_SOC_NOPM, 0, 0, &hs2_mux),
+	SND_SOC_DAPM_MUX("Lineout1 Mux", SND_SOC_NOPM, 0, 0, &lo1_mux),
+	SND_SOC_DAPM_MUX("Lineout2 Mux", SND_SOC_NOPM, 0, 0, &lo2_mux),
+	SND_SOC_DAPM_MUX_E("Speaker Earpiece Demux", SND_SOC_NOPM, 0, 0,
+			   &spk_demux, pm860x_spk_event,
+			   SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD),
+
+	SND_SOC_DAPM_PGA("Headset1 PGA", PM860X_DAC_EN_1, 0, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("Headset2 PGA", PM860X_DAC_EN_1, 1, 0, NULL, 0),
+	SND_SOC_DAPM_OUTPUT("HS1"),
+	SND_SOC_DAPM_OUTPUT("HS2"),
+	SND_SOC_DAPM_PGA("Lineout1 PGA", PM860X_DAC_EN_1, 2, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("Lineout2 PGA", PM860X_DAC_EN_1, 3, 0, NULL, 0),
+	SND_SOC_DAPM_OUTPUT("LINEOUT1"),
+	SND_SOC_DAPM_OUTPUT("LINEOUT2"),
+	SND_SOC_DAPM_PGA("Earpiece PGA", PM860X_DAC_EN_1, 4, 0, NULL, 0),
+	SND_SOC_DAPM_OUTPUT("EARP"),
+	SND_SOC_DAPM_OUTPUT("EARN"),
+	SND_SOC_DAPM_PGA("Speaker PGA", PM860X_DAC_EN_1, 5, 0, NULL, 0),
+	SND_SOC_DAPM_OUTPUT("LSP"),
+	SND_SOC_DAPM_OUTPUT("LSN"),
+
+	SND_SOC_DAPM_POST("RSYNC", pm860x_rsync_event),
+
+};
+
+static const struct snd_soc_dapm_route audio_map[] = {
+	/* PCM/AIF1 Inputs */
+	{"PCM SDO", NULL, "ADC Left Mux"},
+	{"PCM SDO", NULL, "ADCR EC Mux"},
+
+	/* PCM/AFI2 Outputs */
+	{"Lofi PGA", NULL, "PCM SDI"},
+	{"Lofi PGA", NULL, "Sidetone PGA"},
+	{"Left DAC", NULL, "Lofi PGA"},
+	{"Right DAC", NULL, "Lofi PGA"},
+
+	/* I2S/AIF2 Inputs */
+	{"MIC Mux", "Mic 1", "MIC1P"},
+	{"MIC Mux", "Mic 1", "MIC1N"},
+	{"MIC Mux", "Mic 2", "MIC2P"},
+	{"MIC Mux", "Mic 2", "MIC2N"},
+	{"MIC1 Volume", NULL, "MIC Mux"},
+	{"MIC3 Volume", NULL, "MIC3P"},
+	{"MIC3 Volume", NULL, "MIC3N"},
+	{"Left ADC", NULL, "MIC1 Volume"},
+	{"Right ADC", NULL, "MIC3 Volume"},
+	{"ADC Left Mux", "ADCR", "Right ADC"},
+	{"ADC Left Mux", "ADCL", "Left ADC"},
+	{"ADC Right Mux", "ADCL", "Left ADC"},
+	{"ADC Right Mux", "ADCR", "Right ADC"},
+	{"Left EPA", "Switch", "Left DAC"},
+	{"Right EPA", "Switch", "Right DAC"},
+	{"EC Mux", "Left", "Left DAC"},
+	{"EC Mux", "Right", "Right DAC"},
+	{"EC Mux", "Left + Right", "Left DAC"},
+	{"EC Mux", "Left + Right", "Right DAC"},
+	{"ADCR EC Mux", "ADCR", "ADC Right Mux"},
+	{"ADCR EC Mux", "EC", "EC Mux"},
+	{"I2S Mic Mux", "Ex PA", "Left EPA"},
+	{"I2S Mic Mux", "Ex PA", "Right EPA"},
+	{"I2S Mic Mux", "ADC", "ADC Left Mux"},
+	{"I2S Mic Mux", "ADC", "ADCR EC Mux"},
+	{"I2S DOUT", NULL, "I2S Mic Mux"},
+
+	/* I2S/AIF2 Outputs */
+	{"I2S DIN Mux", "DIN", "I2S DIN"},
+	{"I2S DIN Mux", "DIN1", "I2S DIN1"},
+	{"Left DAC", NULL, "I2S DIN Mux"},
+	{"Right DAC", NULL, "I2S DIN Mux"},
+	{"DAC HS1 Mux", "Left", "Left DAC"},
+	{"DAC HS1 Mux", "Right", "Right DAC"},
+	{"DAC HS2 Mux", "Left", "Left DAC"},
+	{"DAC HS2 Mux", "Right", "Right DAC"},
+	{"DAC LO1 Mux", "Left", "Left DAC"},
+	{"DAC LO1 Mux", "Right", "Right DAC"},
+	{"DAC LO2 Mux", "Left", "Left DAC"},
+	{"DAC LO2 Mux", "Right", "Right DAC"},
+	{"Headset1 Mux", "DIGITAL", "DAC HS1 Mux"},
+	{"Headset2 Mux", "DIGITAL", "DAC HS2 Mux"},
+	{"Lineout1 Mux", "DIGITAL", "DAC LO1 Mux"},
+	{"Lineout2 Mux", "DIGITAL", "DAC LO2 Mux"},
+	{"Headset1 PGA", NULL, "Headset1 Mux"},
+	{"Headset2 PGA", NULL, "Headset2 Mux"},
+	{"Lineout1 PGA", NULL, "Lineout1 Mux"},
+	{"Lineout2 PGA", NULL, "Lineout2 Mux"},
+	{"DAC SP Mux", "Left", "Left DAC"},
+	{"DAC SP Mux", "Right", "Right DAC"},
+	{"Speaker Earpiece Demux", "Speaker", "DAC SP Mux"},
+	{"Speaker PGA", NULL, "Speaker Earpiece Demux"},
+	{"Earpiece PGA", NULL, "Speaker Earpiece Demux"},
+
+	{"HS1", NULL, "Headset1 PGA"},
+	{"HS2", NULL, "Headset2 PGA"},
+	{"LINEOUT1", NULL, "Lineout1 PGA"},
+	{"LINEOUT2", NULL, "Lineout2 PGA"},
+	{"LSP", NULL, "Speaker PGA"},
+	{"LSN", NULL, "Speaker PGA"},
+	{"EARP", NULL, "Earpiece PGA"},
+	{"EARN", NULL, "Earpiece PGA"},
+};
+
+static int pm860x_digital_mute(struct snd_soc_dai *codec_dai, int mute)
+{
+	struct snd_soc_codec *codec = codec_dai->codec;
+	int data = 0;
+
+	if (mute)
+		data = DAC_MUTE;
+	snd_soc_update_bits(codec, PM860X_DAC_OFFSET, DAC_MUTE, data);
+	snd_soc_update_bits(codec, PM860X_EAR_CTRL_2,
+			    RSYNC_CHANGE, RSYNC_CHANGE);
+	return 0;
+}
+
+static int set_dai_fmt(struct pm860x_priv *pm860x, unsigned int fmt,
+		       unsigned char *inf, unsigned char *mask)
+{
+	int ret = 0;
+
+	*mask |= PCM_INF2_BCLK | PCM_INF2_FS | PCM_INF2_MASTER;
+
+	/* set master/slave audio interface */
+	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+	case SND_SOC_DAIFMT_CBM_CFM:
+	case SND_SOC_DAIFMT_CBM_CFS:
+		if (pm860x->dir == PM860X_CLK_DIR_OUT)
+			*inf |= PCM_INF2_MASTER;
+		else
+			ret = -EINVAL;
+		break;
+	case SND_SOC_DAIFMT_CBS_CFS:
+		if (pm860x->dir == PM860X_CLK_DIR_IN)
+			*inf &= ~PCM_INF2_MASTER;
+		else
+			ret = -EINVAL;
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+	if (ret)
+		return ret;
+
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_I2S:
+		*inf |= PCM_EXACT_I2S;
+		break;
+	case SND_SOC_DAIFMT_LEFT_J:
+		*inf |= PCM_LEFT_I2S;
+		break;
+	case SND_SOC_DAIFMT_RIGHT_J:
+		*inf |= PCM_RIGHT_I2S;
+		break;
+	default:
+		return -EINVAL;
+	}
+	*mask |= PCM_MODE_MASK;
+	return 0;
+}
+
+static int pm860x_pcm_hw_params(struct snd_pcm_substream *substream,
+				struct snd_pcm_hw_params *params,
+				struct snd_soc_dai *dai)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	unsigned char inf = 0, mask = 0;
+	int data;
+
+	/* bit size */
+	switch (params_format(params)) {
+	case SNDRV_PCM_FORMAT_S16_LE:
+		inf &= ~PCM_INF2_18WL;
+		break;
+	case SNDRV_PCM_FORMAT_S18_3LE:
+		inf |= PCM_INF2_18WL;
+		break;
+	default:
+		return -EINVAL;
+	}
+	mask |= PCM_INF2_18WL;
+	data = snd_soc_read(codec, PM860X_PCM_IFACE_2) & ~mask;
+	data |= inf;
+	snd_soc_write(codec, PM860X_PCM_IFACE_2, data);
+
+	/* sample rate */
+	switch (params_rate(params)) {
+	case 8000:
+		inf = 0;
+		break;
+	case 16000:
+		inf = 3;
+		break;
+	case 32000:
+		inf = 6;
+		break;
+	case 48000:
+		inf = 8;
+		break;
+	default:
+		return -EINVAL;
+	}
+	snd_soc_update_bits(codec, PM860X_PCM_RATE, 0x0f, inf);
+
+	/* enable PCM interface */
+	snd_soc_update_bits(codec, PM860X_ADC_EN_2, 1, 1);
+	snd_soc_update_bits(codec, PM860X_EAR_CTRL_2,
+			    RSYNC_CHANGE, RSYNC_CHANGE);
+	return 0;
+}
+
+static int pm860x_pcm_hw_free(struct snd_pcm_substream *substream,
+			      struct snd_soc_dai *dai)
+{
+	struct snd_soc_codec *codec = dai->codec;
+
+	/* disable PCM interface */
+	snd_soc_update_bits(codec, PM860X_ADC_EN_2, 1, 0);
+	snd_soc_update_bits(codec, PM860X_EAR_CTRL_2,
+			    RSYNC_CHANGE, RSYNC_CHANGE);
+	return 0;
+}
+
+static int pm860x_pcm_set_dai_fmt(struct snd_soc_dai *codec_dai,
+				  unsigned int fmt)
+{
+	struct snd_soc_codec *codec = codec_dai->codec;
+	struct pm860x_priv *pm860x = snd_soc_codec_get_drvdata(codec);
+	unsigned char inf = 0, mask = 0;
+	int data, ret;
+
+	ret = set_dai_fmt(pm860x, fmt, &inf, &mask);
+	if (!ret) {
+		data = snd_soc_read(codec, PM860X_PCM_IFACE_2) & ~mask;
+		data |= inf;
+		snd_soc_write(codec, PM860X_PCM_IFACE_2, data);
+	}
+	return ret;
+}
+
+static int pm860x_set_dai_sysclk(struct snd_soc_dai *codec_dai,
+				 int clk_id, unsigned int freq, int dir)
+{
+	struct snd_soc_codec *codec = codec_dai->codec;
+	struct pm860x_priv *pm860x = snd_soc_codec_get_drvdata(codec);
+
+	if (dir == PM860X_CLK_DIR_OUT)
+		pm860x->dir = PM860X_CLK_DIR_OUT;
+	else
+		pm860x->dir = PM860X_CLK_DIR_IN;
+
+	return 0;
+}
+
+static int pm860x_i2s_hw_params(struct snd_pcm_substream *substream,
+				struct snd_pcm_hw_params *params,
+				struct snd_soc_dai *dai)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	unsigned char inf;
+	int data;
+
+	/*
+	 * Enable LDO15 for VDD_CODEC, audio charger pump for VDDSTP/VDDSTN
+	 * and reset audio module.
+	 */
+	data = LDO15_EN | CPUMP_EN | AUDIO_EN;
+	snd_soc_update_bits(codec, PM860X_AUDIO_SUPPLIES_2, data, data);
+
+	/* bit size */
+	switch (params_format(params)) {
+	case SNDRV_PCM_FORMAT_S16_LE:
+		inf = 0;
+		break;
+	case SNDRV_PCM_FORMAT_S18_3LE:
+		inf = PCM_INF2_18WL;
+		break;
+	default:
+		return -EINVAL;
+	}
+	snd_soc_update_bits(codec, PM860X_I2S_IFACE_2, PCM_INF2_18WL, inf);
+
+	/* sample rate */
+	switch (params_rate(params)) {
+	case 8000:
+		inf = 0;
+		break;
+	case 11025:
+		inf = 1;
+		break;
+	case 16000:
+		inf = 3;
+		break;
+	case 22050:
+		inf = 4;
+		break;
+	case 32000:
+		inf = 6;
+		break;
+	case 44100:
+		inf = 7;
+		break;
+	case 48000:
+		inf = 8;
+		break;
+	default:
+		return -EINVAL;
+	}
+	snd_soc_update_bits(codec, PM860X_I2S_IFACE_4, 0xf, inf);
+
+	/* enable I2S interface */
+	snd_soc_update_bits(codec, PM860X_DAC_EN_2, 1, 1);
+	snd_soc_update_bits(codec, PM860X_EAR_CTRL_2,
+			    RSYNC_CHANGE, RSYNC_CHANGE);
+	return 0;
+}
+
+static int pm860x_i2s_hw_free(struct snd_pcm_substream *substream,
+			      struct snd_soc_dai *dai)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	int data;
+
+	/* disable I2S interface */
+	snd_soc_update_bits(codec, PM860X_DAC_EN_2, 1, 0);
+	snd_soc_update_bits(codec, PM860X_EAR_CTRL_2,
+			    RSYNC_CHANGE, RSYNC_CHANGE);
+
+	/*
+	 * Disable LDO15 for VDD_CODEC, audio charger pump for VDDSTP/VDDSTN
+	 * and reset audio module.
+	 */
+	data = LDO15_EN | CPUMP_EN | AUDIO_EN;
+	snd_soc_update_bits(codec, PM860X_AUDIO_SUPPLIES_2, data, 0);
+	return 0;
+}
+
+static int pm860x_i2s_set_dai_fmt(struct snd_soc_dai *codec_dai,
+				  unsigned int fmt)
+{
+	struct snd_soc_codec *codec = codec_dai->codec;
+	struct pm860x_priv *pm860x = snd_soc_codec_get_drvdata(codec);
+	unsigned char inf = 0, mask = 0;
+	int data, ret;
+
+	ret = set_dai_fmt(pm860x, fmt, &inf, &mask);
+	if (!ret) {
+		data = snd_soc_read(codec, PM860X_I2S_IFACE_2) & ~mask;
+		data |= inf;
+		snd_soc_write(codec, PM860X_I2S_IFACE_2, data);
+	}
+	return ret;
+}
+
+static int pm860x_set_bias_level(struct snd_soc_codec *codec,
+				 enum snd_soc_bias_level level)
+{
+	int data;
+
+	switch (level) {
+	case SND_SOC_BIAS_ON:
+		break;
+
+	case SND_SOC_BIAS_PREPARE:
+		break;
+
+	case SND_SOC_BIAS_STANDBY:
+		if (codec->bias_level == SND_SOC_BIAS_OFF) {
+			/* Enable Audio PLL & Audio section */
+			data = AUDIO_PLL | AUDIO_SECTION_RESET
+				| AUDIO_SECTION_ON;
+			pm860x_reg_write(codec->control_data, REG_MISC2, data);
+
+			/* Enable Mic1 Bias & MICDET, HSDET */
+			pm860x_set_bits(codec->control_data, REG_ADC_ANA_1,
+					MIC1BIAS_MASK, MIC1BIAS_MASK);
+			pm860x_set_bits(codec->control_data, REG_MIC_DET,
+					MICDET_MASK, MICDET_MASK);
+			pm860x_set_bits(codec->control_data, REG_HS_DET,
+					EN_HS_DET, EN_HS_DET);
+		}
+		break;
+
+	case SND_SOC_BIAS_OFF:
+		/* disable Mic1 Bias & MICDET, HSDET */
+		pm860x_set_bits(codec->control_data, REG_MIC_DET,
+				MICDET_MASK, 0);
+		pm860x_set_bits(codec->control_data, REG_HS_DET,
+				EN_HS_DET, 0);
+		pm860x_set_bits(codec->control_data, REG_ADC_ANA_1,
+				MIC1BIAS_MASK, 0);
+		data = AUDIO_PLL | AUDIO_SECTION_RESET | AUDIO_SECTION_ON;
+		pm860x_set_bits(codec->control_data, REG_MISC2, data, 0);
+		break;
+	}
+	codec->bias_level = level;
+	return 0;
+}
+
+static struct snd_soc_dai_ops pm860x_pcm_dai_ops = {
+	.digital_mute	= pm860x_digital_mute,
+	.hw_params	= pm860x_pcm_hw_params,
+	.hw_free	= pm860x_pcm_hw_free,
+	.set_fmt	= pm860x_pcm_set_dai_fmt,
+	.set_sysclk	= pm860x_set_dai_sysclk,
+};
+
+static struct snd_soc_dai_ops pm860x_i2s_dai_ops = {
+	.digital_mute	= pm860x_digital_mute,
+	.hw_params	= pm860x_i2s_hw_params,
+	.hw_free	= pm860x_i2s_hw_free,
+	.set_fmt	= pm860x_i2s_set_dai_fmt,
+	.set_sysclk	= pm860x_set_dai_sysclk,
+};
+
+#define PM860X_RATES	(SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_16000 |	\
+			 SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_48000)
+
+struct snd_soc_dai_driver pm860x_dai[] = {
+	{
+		/* DAI PCM */
+		.name	= "88pm860x-pcm",
+		.id	= 1,
+		.playback = {
+			.stream_name	= "PCM Playback",
+			.channels_min	= 2,
+			.channels_max	= 2,
+			.rates		= PM860X_RATES,
+			.formats	= SNDRV_PCM_FORMAT_S16_LE | \
+					  SNDRV_PCM_FORMAT_S18_3LE,
+		},
+		.capture = {
+			.stream_name	= "PCM Capture",
+			.channels_min	= 2,
+			.channels_max	= 2,
+			.rates		= PM860X_RATES,
+			.formats	= SNDRV_PCM_FORMAT_S16_LE | \
+					  SNDRV_PCM_FORMAT_S18_3LE,
+		},
+		.ops	= &pm860x_pcm_dai_ops,
+	}, {
+		/* DAI I2S */
+		.name	= "88pm860x-i2s",
+		.id	= 2,
+		.playback = {
+			.stream_name	= "I2S Playback",
+			.channels_min	= 2,
+			.channels_max	= 2,
+			.rates		= SNDRV_PCM_RATE_8000_48000,
+			.formats	= SNDRV_PCM_FORMAT_S16_LE | \
+					  SNDRV_PCM_FORMAT_S18_3LE,
+		},
+		.capture = {
+			.stream_name	= "I2S Capture",
+			.channels_min	= 2,
+			.channels_max	= 2,
+			.rates		= SNDRV_PCM_RATE_8000_48000,
+			.formats	= SNDRV_PCM_FORMAT_S16_LE | \
+					  SNDRV_PCM_FORMAT_S18_3LE,
+		},
+		.ops	= &pm860x_i2s_dai_ops,
+	},
+};
+EXPORT_SYMBOL_GPL(pm860x_dai);
+
+static irqreturn_t pm860x_codec_handler(int irq, void *data)
+{
+	struct pm860x_priv *pm860x = data;
+	int status, shrt, report = 0;
+
+	status = pm860x_reg_read(pm860x->i2c, REG_STATUS_1);
+	shrt = pm860x_reg_read(pm860x->i2c, REG_SHORTS);
+
+	if (pm860x->hsdet.det & PM860X_DET_HEADSET) {
+		if (status & HEADSET_STATUS)
+			report |= PM860X_DET_HEADSET;
+	}
+	if (pm860x->hsdet.det & PM860X_DET_MIC) {
+		if (status & MIC_STATUS)
+			report |= PM860X_DET_MIC;
+	}
+	if (pm860x->hsdet.det & PM860X_DET_HOOK) {
+		if (status & HOOK_STATUS)
+			report |= PM860X_DET_HOOK;
+	}
+	if (pm860x->hsdet.det & PM860X_SHORT_LINEOUT) {
+		if (shrt & (SHORT_LO1 | SHORT_LO2))
+			report |= PM860X_SHORT_LINEOUT;
+	}
+	if (pm860x->hsdet.det & PM860X_SHORT_HEADSET) {
+		if (shrt & (SHORT_HS1 | SHORT_HS2))
+			report |= PM860X_SHORT_HEADSET;
+	}
+	snd_soc_jack_report(pm860x->hsdet.jack, report, PM860X_DET_MASK);
+	dev_dbg(pm860x->codec->dev, "report:0x%x\n", report);
+	return IRQ_HANDLED;
+}
+
+/*
+ * Enable headset detection via 88PM860x IRQ
+ *
+ * Enable headset detection via IRQ on 88PM860x. If GPIOs are being used to
+ * bring out signals to the processor then processor GPIOs should be
+ * configured using snd_soc_jack_add_gpios() instead.
+ */
+int pm860x_hs_detect(struct snd_soc_codec *codec, struct snd_soc_jack *jack,
+		      int det)
+{
+	struct pm860x_priv *pm860x = snd_soc_codec_get_drvdata(codec);
+
+	if (!jack) {
+		dev_err(codec->dev, "Wrong jack is specified\n");
+		return -EINVAL;
+	}
+	pm860x->hsdet.jack = jack;
+	pm860x->hsdet.det = det;
+
+	pm860x_codec_handler(0, pm860x);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pm860x_hs_detect);
+
+static int pm860x_probe(struct snd_soc_codec *codec)
+{
+	struct pm860x_priv *pm860x = snd_soc_codec_get_drvdata(codec);
+	int i, ret;
+
+	pm860x->codec = codec;
+
+	codec->control_data = pm860x->i2c;
+
+	for (i = 0; i < 4; i++) {
+		ret = request_threaded_irq(pm860x->irq[i], NULL,
+					   pm860x_codec_handler, IRQF_ONESHOT,
+					   pm860x->name[i], pm860x);
+		if (ret < 0) {
+			dev_err(codec->dev, "Failed to request IRQ!\n");
+			goto out_irq;
+		}
+	}
+
+	pm860x_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
+
+	ret = pm860x_bulk_read(codec->control_data, REG_CACHE_BASE,
+			       REG_CACHE_SIZE, codec->reg_cache);
+	if (ret < 0) {
+		dev_err(codec->dev, "Failed to fill register cache: %d\n",
+			ret);
+		goto out_codec;
+	}
+
+	snd_soc_add_controls(codec, pm860x_snd_controls,
+			     ARRAY_SIZE(pm860x_snd_controls));
+	snd_soc_dapm_new_controls(codec, pm860x_dapm_widgets,
+				  ARRAY_SIZE(pm860x_dapm_widgets));
+	snd_soc_dapm_add_routes(codec, audio_map, ARRAY_SIZE(audio_map));
+	return 0;
+
+out_codec:
+	i = 3;
+out_irq:
+	for (; i >= 0; i--)
+		free_irq(pm860x->irq[i], pm860x);
+	return -EINVAL;
+}
+
+static int pm860x_remove(struct snd_soc_codec *codec)
+{
+	struct pm860x_priv *pm860x = snd_soc_codec_get_drvdata(codec);
+	int i;
+
+	for (i = 3; i >= 0; i--)
+		free_irq(pm860x->irq[i], pm860x);
+	pm860x_set_bias_level(codec, SND_SOC_BIAS_OFF);
+	return 0;
+}
+
+static struct snd_soc_codec_driver soc_codec_dev_pm860x = {
+	.probe		= pm860x_probe,
+	.remove		= pm860x_remove,
+	.read		= pm860x_read_reg_cache,
+	.write		= pm860x_write_reg_cache,
+	.reg_cache_size	= REG_CACHE_SIZE,
+	.reg_word_size	= sizeof(u8),
+	.set_bias_level	= pm860x_set_bias_level,
+};
+
+static int __devinit pm860x_codec_probe(struct platform_device *pdev)
+{
+	struct pm860x_chip *chip = dev_get_drvdata(pdev->dev.parent);
+	struct pm860x_priv *pm860x;
+	struct resource *res;
+	int i, ret;
+
+	pm860x = kzalloc(sizeof(struct pm860x_priv), GFP_KERNEL);
+	if (pm860x == NULL)
+		return -ENOMEM;
+
+	pm860x->chip = chip;
+	pm860x->i2c = (chip->id == CHIP_PM8607) ? chip->client
+			: chip->companion;
+	platform_set_drvdata(pdev, pm860x);
+
+	for (i = 0; i < 4; i++) {
+		res = platform_get_resource(pdev, IORESOURCE_IRQ, i);
+		if (!res) {
+			dev_err(&pdev->dev, "Failed to get IRQ resources\n");
+			goto out;
+		}
+		pm860x->irq[i] = res->start + chip->irq_base;
+		strncpy(pm860x->name[i], res->name, MAX_NAME_LEN);
+	}
+
+	ret = snd_soc_register_codec(&pdev->dev, &soc_codec_dev_pm860x,
+				     pm860x_dai, ARRAY_SIZE(pm860x_dai));
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to register codec\n");
+		goto out;
+	}
+	return ret;
+
+out:
+	platform_set_drvdata(pdev, NULL);
+	kfree(pm860x);
+	return -EINVAL;
+}
+
+static int __devexit pm860x_codec_remove(struct platform_device *pdev)
+{
+	struct pm860x_priv *pm860x = platform_get_drvdata(pdev);
+
+	snd_soc_unregister_codec(&pdev->dev);
+	platform_set_drvdata(pdev, NULL);
+	kfree(pm860x);
+	return 0;
+}
+
+static struct platform_driver pm860x_codec_driver = {
+	.driver	= {
+		.name	= "88pm860x-codec",
+		.owner	= THIS_MODULE,
+	},
+	.probe	= pm860x_codec_probe,
+	.remove	= __devexit_p(pm860x_codec_remove),
+};
+
+static __init int pm860x_init(void)
+{
+	return platform_driver_register(&pm860x_codec_driver);
+}
+module_init(pm860x_init);
+
+static __exit void pm860x_exit(void)
+{
+	platform_driver_unregister(&pm860x_codec_driver);
+}
+module_exit(pm860x_exit);
+
+MODULE_DESCRIPTION("ASoC 88PM860x driver");
+MODULE_AUTHOR("Haojian Zhuang <haojian.zhuang@marvell.com>");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:88pm860x-codec");
+
diff --git a/sound/soc/codecs/88pm860x-codec.h
b/sound/soc/codecs/88pm860x-codec.h
new file mode 100644
index 0000000..8094669
--- /dev/null
+++ b/sound/soc/codecs/88pm860x-codec.h
@@ -0,0 +1,97 @@
+/*
+ * 88pm860x-codec.h -- 88PM860x ALSA SoC Audio Driver
+ *
+ * Copyright 2010 Marvell International Ltd.
+ *	Haojian Zhuang <haojian.zhuang@marvell.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __88PM860X_H
+#define __88PM860X_H
+
+/* The offset of these registers are 0xb0 */
+#define PM860X_PCM_IFACE_1		0x00
+#define PM860X_PCM_IFACE_2		0x01
+#define PM860X_PCM_IFACE_3		0x02
+#define PM860X_PCM_RATE			0x03
+#define PM860X_EC_PATH			0x04
+#define PM860X_SIDETONE_L_GAIN		0x05
+#define PM860X_SIDETONE_R_GAIN		0x06
+#define PM860X_SIDETONE_SHIFT		0x07
+#define PM860X_ADC_OFFSET_1		0x08
+#define PM860X_ADC_OFFSET_2		0x09
+#define PM860X_DMIC_DELAY		0x0a
+
+#define PM860X_I2S_IFACE_1		0x0b
+#define PM860X_I2S_IFACE_2		0x0c
+#define PM860X_I2S_IFACE_3		0x0d
+#define PM860X_I2S_IFACE_4		0x0e
+#define PM860X_EQUALIZER_N0_1		0x0f
+#define PM860X_EQUALIZER_N0_2		0x10
+#define PM860X_EQUALIZER_N1_1		0x11
+#define PM860X_EQUALIZER_N1_2		0x12
+#define PM860X_EQUALIZER_D1_1		0x13
+#define PM860X_EQUALIZER_D1_2		0x14
+#define PM860X_LOFI_GAIN_LEFT		0x15
+#define PM860X_LOFI_GAIN_RIGHT		0x16
+#define PM860X_HIFIL_GAIN_LEFT		0x17
+#define PM860X_HIFIL_GAIN_RIGHT		0x18
+#define PM860X_HIFIR_GAIN_LEFT		0x19
+#define PM860X_HIFIR_GAIN_RIGHT		0x1a
+#define PM860X_DAC_OFFSET		0x1b
+#define PM860X_OFFSET_LEFT_1		0x1c
+#define PM860X_OFFSET_LEFT_2		0x1d
+#define PM860X_OFFSET_RIGHT_1		0x1e
+#define PM860X_OFFSET_RIGHT_2		0x1f
+#define PM860X_ADC_ANA_1		0x20
+#define PM860X_ADC_ANA_2		0x21
+#define PM860X_ADC_ANA_3		0x22
+#define PM860X_ADC_ANA_4		0x23
+#define PM860X_ANA_TO_ANA		0x24
+#define PM860X_HS1_CTRL			0x25
+#define PM860X_HS2_CTRL			0x26
+#define PM860X_LO1_CTRL			0x27
+#define PM860X_LO2_CTRL			0x28
+#define PM860X_EAR_CTRL_1		0x29
+#define PM860X_EAR_CTRL_2		0x2a
+#define PM860X_AUDIO_SUPPLIES_1		0x2b
+#define PM860X_AUDIO_SUPPLIES_2		0x2c
+#define PM860X_ADC_EN_1			0x2d
+#define PM860X_ADC_EN_2			0x2e
+#define PM860X_DAC_EN_1			0x2f
+#define PM860X_DAC_EN_2			0x31
+#define PM860X_AUDIO_CAL_1		0x32
+#define PM860X_AUDIO_CAL_2		0x33
+#define PM860X_AUDIO_CAL_3		0x34
+#define PM860X_AUDIO_CAL_4		0x35
+#define PM860X_AUDIO_CAL_5		0x36
+#define PM860X_ANA_INPUT_SEL_1		0x37
+#define PM860X_ANA_INPUT_SEL_2		0x38
+
+#define PM860X_PCM_IFACE_4		0x39
+#define PM860X_I2S_IFACE_5		0x3a
+
+#define PM860X_SHORTS			0x3b
+#define PM860X_PLL_ADJ_1		0x3c
+#define PM860X_PLL_ADJ_2		0x3d
+
+/* bits definition */
+#define MUTE_ALL			(1 << 7)
+
+#define PM860X_CLK_DIR_IN		0
+#define PM860X_CLK_DIR_OUT		1
+
+#define PM860X_DET_HEADSET	(1 << 0)
+#define PM860X_DET_MIC		(1 << 1)
+#define PM860X_DET_HOOK		(1 << 2)
+#define PM860X_SHORT_HEADSET	(1 << 3)
+#define PM860X_SHORT_LINEOUT	(1 << 4)
+#define PM860X_DET_MASK		0x1F
+
+extern int pm860x_hs_detect(struct snd_soc_codec *, struct snd_soc_jack *,
+			    int);
+
+#endif	/* __88PM860X_H */
diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index bfdd92b..a3cfc18 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -10,6 +10,7 @@ config SND_SOC_I2C_AND_SPI

 config SND_SOC_ALL_CODECS
 	tristate "Build all ASoC CODEC drivers"
+	select SND_SOC_88PM860X if MFD_88PM860X
 	select SND_SOC_L3
 	select SND_SOC_AC97_CODEC if SND_SOC_AC97_BUS
 	select SND_SOC_AD1836 if SPI_MASTER
@@ -85,6 +86,9 @@ config SND_SOC_ALL_CODECS

           If unsure select "N".

+config SND_SOC_88PM860X
+	tristate
+
 config SND_SOC_WM_HUBS
 	tristate
 	default y if SND_SOC_WM8993=y || SND_SOC_WM8994=y
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 9c3c39f..b9c4358 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -1,3 +1,4 @@
+snd-soc-88pm860x-objs := 88pm860x-codec.o
 snd-soc-ac97-objs := ac97.o
 snd-soc-ad1836-objs := ad1836.o
 snd-soc-ad193x-objs := ad193x.o
@@ -67,6 +68,7 @@ snd-soc-tpa6130a2-objs := tpa6130a2.o
 snd-soc-wm2000-objs := wm2000.o
 snd-soc-wm9090-objs := wm9090.o

+obj-$(CONFIG_SND_SOC_88PM860X)	+= snd-soc-88pm860x.o
 obj-$(CONFIG_SND_SOC_AC97_CODEC)	+= snd-soc-ac97.o
 obj-$(CONFIG_SND_SOC_AD1836)	+= snd-soc-ad1836.o
 obj-$(CONFIG_SND_SOC_AD193X)	+= snd-soc-ad193x.o
-- 
1.5.6.5
