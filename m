From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Thu, 12 Aug 2010 12:01:47 +0800
Subject: [PATCH 1/3] ASoC: add 88pm860x codec driver
Message-ID: <mailman.219.1283432327.27306.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add 88PM860x codec driver. 88PM860x codec supports two interfaces. And it
also supports headset/mic/hook/short detection.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 sound/soc/codecs/88pm860x-codec.c | 1410 +++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/88pm860x-codec.h |   92 +++
 sound/soc/codecs/Kconfig          |    4 +
 sound/soc/codecs/Makefile         |    2 +
 4 files changed, 1508 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/codecs/88pm860x-codec.c
 create mode 100644 sound/soc/codecs/88pm860x-codec.h

diff --git a/sound/soc/codecs/88pm860x-codec.c
b/sound/soc/codecs/88pm860x-codec.c
new file mode 100644
index 0000000..1acb1f1
--- /dev/null
+++ b/sound/soc/codecs/88pm860x-codec.c
@@ -0,0 +1,1410 @@
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
+#define SUPPLY_MASK		(LDO15_EN | CPUMP_EN | AUDIO_EN)
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
+struct pm860x_priv {
+	unsigned int		sysclk;
+	unsigned int		pcmclk;
+	unsigned int		dir;
+	unsigned int		filter;
+	struct snd_soc_codec	*codec;
+	struct i2c_client	*i2c;
+	struct pm860x_chip	*chip;
+
+	int			irq[4];
+	unsigned char		name[4][MAX_NAME_LEN];
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
+/* DAPM Widget Events */
+static int pm860x_rsync_event(struct snd_soc_dapm_widget *w,
+			      struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_codec *codec = w->codec;
+
+	/* unmute DAC */
+	snd_soc_update_bits(codec, PM860X_DAC_OFFSET, DAC_MUTE, 0);
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
+	unsigned int dac = 0;
+	int data;
+
+	if (!strcmp(w->name, "Left DAC"))
+		dac = DAC_LEFT;
+	if (!strcmp(w->name, "Right DAC"))
+		dac = DAC_RIGHT;
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		if (dac) {
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
+static int pm860x_mic1_event(struct snd_soc_dapm_widget *w,
+			     struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_codec *codec = w->codec;
+
+	switch (event) {
+	case SND_SOC_DAPM_POST_PMU:
+		/* Enable Mic1 Bias & MICDET, HSDET */
+		snd_soc_update_bits(codec, PM860X_ADC_ANA_1, MIC1BIAS_MASK,
+				    MIC1BIAS_MASK);
+		pm860x_set_bits(codec->control_data, REG_MIC_DET,
+				MICDET_MASK, MICDET_MASK);
+		pm860x_set_bits(codec->control_data, REG_HS_DET,
+				EN_HS_DET, EN_HS_DET);
+		break;
+	case SND_SOC_DAPM_PRE_PMD:
+		/* disable Mic1 Bias & MICDET, HSDET */
+		pm860x_set_bits(codec->control_data, REG_MIC_DET,
+				MICDET_MASK, 0);
+		pm860x_set_bits(codec->control_data, REG_HS_DET,
+				EN_HS_DET, 0);
+		snd_soc_update_bits(codec, PM860X_ADC_ANA_1, MIC1BIAS_MASK, 0);
+		break;
+	}
+	return 0;
+}
+
+static const char *pm860x_opamp_texts[] = {"-50%", "-25%", "0%", "75%"};
+
+static const char *pm860x_pa_texts[] = {"-33%", "0%", "33%", "66%"};
+
+static const struct soc_enum pm860x_hs1_opamp_enum =
+	SOC_ENUM_SINGLE(PM860X_HS1_CTRL, 5, 4, pm860x_opamp_texts);
+
+static const struct soc_enum pm860x_hs2_opamp_enum =
+	SOC_ENUM_SINGLE(PM860X_HS2_CTRL, 5, 4, pm860x_opamp_texts);
+
+static const struct soc_enum pm860x_hs1_pa_enum =
+	SOC_ENUM_SINGLE(PM860X_HS1_CTRL, 3, 4, pm860x_pa_texts);
+
+static const struct soc_enum pm860x_hs2_pa_enum =
+	SOC_ENUM_SINGLE(PM860X_HS2_CTRL, 3, 4, pm860x_pa_texts);
+
+static const struct soc_enum pm860x_lo1_opamp_enum =
+	SOC_ENUM_SINGLE(PM860X_LO1_CTRL, 5, 4, pm860x_opamp_texts);
+
+static const struct soc_enum pm860x_lo2_opamp_enum =
+	SOC_ENUM_SINGLE(PM860X_LO2_CTRL, 5, 4, pm860x_opamp_texts);
+
+static const struct soc_enum pm860x_lo1_pa_enum =
+	SOC_ENUM_SINGLE(PM860X_LO1_CTRL, 3, 4, pm860x_pa_texts);
+
+static const struct soc_enum pm860x_lo2_pa_enum =
+	SOC_ENUM_SINGLE(PM860X_LO2_CTRL, 3, 4, pm860x_pa_texts);
+
+static const struct soc_enum pm860x_spk_pa_enum =
+	SOC_ENUM_SINGLE(PM860X_EAR_CTRL_1, 5, 4, pm860x_pa_texts);
+
+static const struct soc_enum pm860x_ear_pa_enum =
+	SOC_ENUM_SINGLE(PM860X_EAR_CTRL_2, 0, 4, pm860x_pa_texts);
+
+static const struct soc_enum pm860x_spk_ear_opamp_enum =
+	SOC_ENUM_SINGLE(PM860X_EAR_CTRL_1, 3, 4, pm860x_opamp_texts);
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
+	SOC_DOUBLE_R_EXT_TLV("Sidetone Volume", PM860X_SIDETONE_L_GAIN,
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
+	SOC_ENUM("Headset1 Operational Amplifier Current",
+		 pm860x_hs1_opamp_enum),
+	SOC_ENUM("Headset2 Operational Amplifier Current",
+		 pm860x_hs2_opamp_enum),
+	SOC_ENUM("Headset1 Amplifier Current", pm860x_hs1_pa_enum),
+	SOC_ENUM("Headset2 Amplifier Current", pm860x_hs2_pa_enum),
+	SOC_ENUM("Lineout1 Operational Amplifier Current",
+		 pm860x_lo1_opamp_enum),
+	SOC_ENUM("Lineout2 Operational Amplifier Current",
+		 pm860x_lo2_opamp_enum),
+	SOC_ENUM("Lineout1 Amplifier Current", pm860x_lo1_pa_enum),
+	SOC_ENUM("Lineout2 Amplifier Current", pm860x_lo2_pa_enum),
+	SOC_ENUM("Speaker Operational Amplifier Current",
+		 pm860x_spk_ear_opamp_enum),
+	SOC_ENUM("Speaker Amplifier Current", pm860x_spk_pa_enum),
+	SOC_ENUM("Earpiece Amplifier Current", pm860x_ear_pa_enum),
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
+	"Digital", "Analog",
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
+	SND_SOC_DAPM_AIF_IN("PCM SDI", "PCM Playback", 0,
+			    PM860X_ADC_EN_2, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("PCM SDO", "PCM Capture", 0,
+			     PM860X_PCM_IFACE_3, 1, 1),
+
+
+	SND_SOC_DAPM_AIF_IN("I2S DIN", "I2S Playback", 0,
+			    PM860X_DAC_EN_2, 0, 0),
+	SND_SOC_DAPM_AIF_IN("I2S DIN1", "I2S Playback", 0,
+			    PM860X_DAC_EN_2, 0, 0),
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
+	SND_SOC_DAPM_MICBIAS_E("Mic1 Bias", SND_SOC_NOPM, 0, 0,
+			       &pm860x_mic1_event,
+			       SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
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
+	SND_SOC_DAPM_MUX("Speaker Earpiece Demux", SND_SOC_NOPM, 0, 0,
+			 &spk_demux),
+
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
+	SND_SOC_DAPM_REG(snd_soc_dapm_supply, "VCODEC", PM860X_AUDIO_SUPPLIES_2,
+			 0, SUPPLY_MASK, SUPPLY_MASK, 0),
+
+	SND_SOC_DAPM_POST("RSYNC", pm860x_rsync_event),
+};
+
+static const struct snd_soc_dapm_route audio_map[] = {
+	/* supply */
+	{"Left DAC", NULL, "VCODEC"},
+	{"Right DAC", NULL, "VCODEC"},
+	{"Left ADC", NULL, "VCODEC"},
+	{"Right ADC", NULL, "VCODEC"},
+
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
+	{"Headset1 Mux", "Digital", "DAC HS1 Mux"},
+	{"Headset2 Mux", "Digital", "DAC HS2 Mux"},
+	{"Lineout1 Mux", "Digital", "DAC LO1 Mux"},
+	{"Lineout2 Mux", "Digital", "DAC LO2 Mux"},
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
+	*mask |= PCM_INF2_BCLK | PCM_INF2_FS | PCM_INF2_MASTER;
+
+	/* set master/slave audio interface */
+	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+	case SND_SOC_DAIFMT_CBM_CFM:
+	case SND_SOC_DAIFMT_CBM_CFS:
+		if (pm860x->dir == PM860X_CLK_DIR_OUT)
+			*inf |= PCM_INF2_MASTER;
+		else
+			return -EINVAL;
+		break;
+	case SND_SOC_DAIFMT_CBS_CFS:
+		if (pm860x->dir == PM860X_CLK_DIR_IN)
+			*inf &= ~PCM_INF2_MASTER;
+		else
+			return -EINVAL;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_I2S:
+		*inf |= PCM_EXACT_I2S;
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
+	snd_soc_update_bits(codec, PM860X_PCM_IFACE_2, mask, inf);
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
+	return 0;
+}
+
+static int pm860x_pcm_set_dai_fmt(struct snd_soc_dai *codec_dai,
+				  unsigned int fmt)
+{
+	struct snd_soc_codec *codec = codec_dai->codec;
+	struct pm860x_priv *pm860x = snd_soc_codec_get_drvdata(codec);
+	unsigned char inf = 0, mask = 0;
+	int ret;
+
+	ret = set_dai_fmt(pm860x, fmt, &inf, &mask);
+	if (!ret)
+		snd_soc_update_bits(codec, PM860X_PCM_IFACE_2, mask, inf);
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
+	return 0;
+}
+
+static int pm860x_i2s_set_dai_fmt(struct snd_soc_dai *codec_dai,
+				  unsigned int fmt)
+{
+	struct snd_soc_codec *codec = codec_dai->codec;
+	struct pm860x_priv *pm860x = snd_soc_codec_get_drvdata(codec);
+	unsigned char inf = 0, mask = 0;
+	int ret;
+
+	ret = set_dai_fmt(pm860x, fmt, &inf, &mask);
+	if (!ret)
+		snd_soc_update_bits(codec, PM860X_I2S_IFACE_2, mask, inf);
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
+		}
+		break;
+
+	case SND_SOC_BIAS_OFF:
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
+	.set_fmt	= pm860x_pcm_set_dai_fmt,
+	.set_sysclk	= pm860x_set_dai_sysclk,
+};
+
+static struct snd_soc_dai_ops pm860x_i2s_dai_ops = {
+	.digital_mute	= pm860x_digital_mute,
+	.hw_params	= pm860x_i2s_hw_params,
+	.set_fmt	= pm860x_i2s_set_dai_fmt,
+	.set_sysclk	= pm860x_set_dai_sysclk,
+};
+
+#define PM860X_RATES	(SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_16000 |	\
+			 SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_48000)
+
+static struct snd_soc_dai_driver pm860x_dai[] = {
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
+
+static irqreturn_t pm860x_codec_handler(int irq, void *data)
+{
+	struct pm860x_priv *pm860x = data;
+	int status, shrt, report = 0;
+
+	status = pm860x_reg_read(pm860x->i2c, REG_STATUS_1);
+	shrt = pm860x_reg_read(pm860x->i2c, REG_SHORTS);
+
+	if (status & HEADSET_STATUS)
+		report |= PM860X_DET_HEADSET;
+	if (status & MIC_STATUS)
+		report |= PM860X_DET_MIC;
+	if (status & HOOK_STATUS)
+		report |= PM860X_DET_HOOK;
+	if (shrt & (SHORT_LO1 | SHORT_LO2))
+		report |= PM860X_SHORT_LINEOUT;
+	if (shrt & (SHORT_HS1 | SHORT_HS2))
+		report |= PM860X_SHORT_HEADSET;
+	dev_dbg(pm860x->codec->dev, "report:0x%x\n", report);
+	return IRQ_HANDLED;
+}
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
index 0000000..b034de2
--- /dev/null
+++ b/sound/soc/codecs/88pm860x-codec.h
@@ -0,0 +1,92 @@
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
+#define PM860X_CLK_DIR_IN		0
+#define PM860X_CLK_DIR_OUT		1
+
+#define PM860X_DET_HEADSET		(1 << 0)
+#define PM860X_DET_MIC			(1 << 1)
+#define PM860X_DET_HOOK			(1 << 2)
+#define PM860X_SHORT_HEADSET		(1 << 3)
+#define PM860X_SHORT_LINEOUT		(1 << 4)
+#define PM860X_DET_MASK			0x1F
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

--0016e6d63f44021a1f048e002b69
Content-Type: text/x-patch; charset=US-ASCII; 
	name="0001-ASoC-add-88pm860x-codec-driver.patch"
Content-Disposition: attachment; 
	filename="0001-ASoC-add-88pm860x-codec-driver.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gcyfxo2w0

RnJvbSBjMDBjZmU3NDU2MjQyYWNjY2I1NjFiYzVhMTY4MzAwMTU4ZWNkNGE0IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBIYW9qaWFuIFpodWFuZyA8aGFvamlhbi56aHVhbmdAbWFydmVs
bC5jb20+CkRhdGU6IFRodSwgMTIgQXVnIDIwMTAgMTI6MDE6NDcgKzA4MDAKU3ViamVjdDogW1BB
VENIIDEvM10gQVNvQzogYWRkIDg4cG04NjB4IGNvZGVjIGRyaXZlcgoKQWRkIDg4UE04NjB4IGNv
ZGVjIGRyaXZlci4gODhQTTg2MHggY29kZWMgc3VwcG9ydHMgdHdvIGludGVyZmFjZXMuIEFuZCBp
dAphbHNvIHN1cHBvcnRzIGhlYWRzZXQvbWljL2hvb2svc2hvcnQgZGV0ZWN0aW9uLgoKU2lnbmVk
LW9mZi1ieTogSGFvamlhbiBaaHVhbmcgPGhhb2ppYW4uemh1YW5nQG1hcnZlbGwuY29tPgotLS0K
IHNvdW5kL3NvYy9jb2RlY3MvODhwbTg2MHgtY29kZWMuYyB8IDE0MTAgKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKwogc291bmQvc29jL2NvZGVjcy84OHBtODYweC1jb2RlYy5o
IHwgICA5MiArKysKIHNvdW5kL3NvYy9jb2RlY3MvS2NvbmZpZyAgICAgICAgICB8ICAgIDQgKwog
c291bmQvc29jL2NvZGVjcy9NYWtlZmlsZSAgICAgICAgIHwgICAgMiArCiA0IGZpbGVzIGNoYW5n
ZWQsIDE1MDggaW5zZXJ0aW9ucygrKSwgMCBkZWxldGlvbnMoLSkKIGNyZWF0ZSBtb2RlIDEwMDY0
NCBzb3VuZC9zb2MvY29kZWNzLzg4cG04NjB4LWNvZGVjLmMKIGNyZWF0ZSBtb2RlIDEwMDY0NCBz
b3VuZC9zb2MvY29kZWNzLzg4cG04NjB4LWNvZGVjLmgKCmRpZmYgLS1naXQgYS9zb3VuZC9zb2Mv
Y29kZWNzLzg4cG04NjB4LWNvZGVjLmMgYi9zb3VuZC9zb2MvY29kZWNzLzg4cG04NjB4LWNvZGVj
LmMKbmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXggMDAwMDAwMC4uMWFjYjFmMQotLS0gL2Rldi9u
dWxsCisrKyBiL3NvdW5kL3NvYy9jb2RlY3MvODhwbTg2MHgtY29kZWMuYwpAQCAtMCwwICsxLDE0
MTAgQEAKKy8qCisgKiA4OHBtODYweC1jb2RlYy5jIC0tIDg4UE04NjB4IEFMU0EgU29DIEF1ZGlv
IERyaXZlcgorICoKKyAqIENvcHlyaWdodCAyMDEwIE1hcnZlbGwgSW50ZXJuYXRpb25hbCBMdGQu
CisgKiBBdXRob3I6IEhhb2ppYW4gWmh1YW5nIDxoYW9qaWFuLnpodWFuZ0BtYXJ2ZWxsLmNvbT4K
KyAqCisgKiBUaGlzIHByb2dyYW0gaXMgZnJlZSBzb2Z0d2FyZTsgeW91IGNhbiByZWRpc3RyaWJ1
dGUgaXQgYW5kL29yIG1vZGlmeQorICogaXQgdW5kZXIgdGhlIHRlcm1zIG9mIHRoZSBHTlUgR2Vu
ZXJhbCBQdWJsaWMgTGljZW5zZSB2ZXJzaW9uIDIgYXMKKyAqIHB1Ymxpc2hlZCBieSB0aGUgRnJl
ZSBTb2Z0d2FyZSBGb3VuZGF0aW9uLgorICovCisKKyNpbmNsdWRlIDxsaW51eC9rZXJuZWwuaD4K
KyNpbmNsdWRlIDxsaW51eC9tb2R1bGUuaD4KKyNpbmNsdWRlIDxsaW51eC9pMmMuaD4KKyNpbmNs
dWRlIDxsaW51eC9wbGF0Zm9ybV9kZXZpY2UuaD4KKyNpbmNsdWRlIDxsaW51eC9tZmQvODhwbTg2
MHguaD4KKyNpbmNsdWRlIDxsaW51eC9zbGFiLmg+CisjaW5jbHVkZSA8c291bmQvY29yZS5oPgor
I2luY2x1ZGUgPHNvdW5kL3BjbS5oPgorI2luY2x1ZGUgPHNvdW5kL3BjbV9wYXJhbXMuaD4KKyNp
bmNsdWRlIDxzb3VuZC9zb2MuaD4KKyNpbmNsdWRlIDxzb3VuZC9zb2MtZGFwbS5oPgorI2luY2x1
ZGUgPHNvdW5kL3Rsdi5oPgorI2luY2x1ZGUgPHNvdW5kL2luaXR2YWwuaD4KKworI2luY2x1ZGUg
Ijg4cG04NjB4LWNvZGVjLmgiCisKKyNkZWZpbmUgTUFYX05BTUVfTEVOCQkyMAorI2RlZmluZSBS
RUdfQ0FDSEVfU0laRQkJMHg0MAorI2RlZmluZSBSRUdfQ0FDSEVfQkFTRQkJMHhiMAorCisvKiBT
dGF0dXMgUmVnaXN0ZXIgMSAoMHgwMSkgKi8KKyNkZWZpbmUgUkVHX1NUQVRVU18xCQkweDAxCisj
ZGVmaW5lIE1JQ19TVEFUVVMJCSgxIDw8IDcpCisjZGVmaW5lIEhPT0tfU1RBVFVTCQkoMSA8PCA2
KQorI2RlZmluZSBIRUFEU0VUX1NUQVRVUwkJKDEgPDwgNSkKKworLyogTWljIERldGVjdGlvbiBS
ZWdpc3RlciAoMHgzNykgKi8KKyNkZWZpbmUgUkVHX01JQ19ERVQJCTB4MzcKKyNkZWZpbmUgQ09O
VElOVU9VU19QT0xMSU5HCSgzIDw8IDEpCisjZGVmaW5lIEVOX01JQ19ERVQJCSgxIDw8IDApCisj
ZGVmaW5lIE1JQ0RFVF9NQVNLCQkweDA3CisKKy8qIEhlYWRzZXQgRGV0ZWN0aW9uIFJlZ2lzdGVy
ICgweDM4KSAqLworI2RlZmluZSBSRUdfSFNfREVUCQkweDM4CisjZGVmaW5lIEVOX0hTX0RFVAkJ
KDEgPDwgMCkKKworLyogTWlzYzIgUmVnaXN0ZXIgKDB4NDIpICovCisjZGVmaW5lIFJFR19NSVND
MgkJMHg0MgorI2RlZmluZSBBVURJT19QTEwJCSgxIDw8IDUpCisjZGVmaW5lIEFVRElPX1NFQ1RJ
T05fUkVTRVQJKDEgPDwgNCkKKyNkZWZpbmUgQVVESU9fU0VDVElPTl9PTgkoMSA8PCAzKQorCisv
KiBQQ00gSW50ZXJmYWNlIFJlZ2lzdGVyIDIgKDB4YjEpICovCisjZGVmaW5lIFBDTV9JTkYyX0JD
TEsJCSgxIDw8IDYpCS8qIEJpdCBjbG9jayBwb2xhcml0eSAqLworI2RlZmluZSBQQ01fSU5GMl9G
UwkJKDEgPDwgNSkJLyogRnJhbWUgU3luYyBwb2xhcml0eSAqLworI2RlZmluZSBQQ01fSU5GMl9N
QVNURVIJCSgxIDw8IDQpCS8qIE1hc3RlciAvIFNsYXZlICovCisjZGVmaW5lIFBDTV9JTkYyXzE4
V0wJCSgxIDw8IDMpCS8qIDE4IC8gMTYgYml0cyAqLworI2RlZmluZSBQQ01fR0VORVJBTF9JMlMJ
CTAKKyNkZWZpbmUgUENNX0VYQUNUX0kyUwkJMQorI2RlZmluZSBQQ01fTEVGVF9JMlMJCTIKKyNk
ZWZpbmUgUENNX1JJR0hUX0kyUwkJMworI2RlZmluZSBQQ01fU0hPUlRfRlMJCTQKKyNkZWZpbmUg
UENNX0xPTkdfRlMJCTUKKyNkZWZpbmUgUENNX01PREVfTUFTSwkJNworCisvKiBJMlMgSW50ZXJm
YWNlIFJlZ2lzdGVyIDQgKDB4YmUpICovCisjZGVmaW5lIEkyU19FUVVfQllQCQkoMSA8PCA2KQor
CisvKiBEQUMgT2Zmc2V0IFJlZ2lzdGVyICgweGNiKSAqLworI2RlZmluZSBEQUNfTVVURQkJKDEg
PDwgNykKKworLyogQURDIEFuYWxvZyBSZWdpc3RlciAxICgweGQwKSAqLworI2RlZmluZSBSRUdf
QURDX0FOQV8xCQkweGQwCisjZGVmaW5lIE1JQzFCSUFTX01BU0sJCTB4NjAKKworLyogRWFycGll
Y2UvU3BlYWtlciBDb250cm9sIFJlZ2lzdGVyIDIgKDB4ZGEpICovCisjZGVmaW5lIFJFR19FQVIy
CQkweGRhCisjZGVmaW5lIFJTWU5DX0NIQU5HRQkJKDEgPDwgMikKKworLyogQXVkaW8gU3VwcGxp
ZXMgUmVnaXN0ZXIgMiAoMHhkYykgKi8KKyNkZWZpbmUgUkVHX1NVUFBMSUVTMgkJMHhkYworI2Rl
ZmluZSBMRE8xNV9SRUFEWQkJKDEgPDwgNCkKKyNkZWZpbmUgTERPMTVfRU4JCSgxIDw8IDMpCisj
ZGVmaW5lIENQVU1QX1JFQURZCQkoMSA8PCAyKQorI2RlZmluZSBDUFVNUF9FTgkJKDEgPDwgMSkK
KyNkZWZpbmUgQVVESU9fRU4JCSgxIDw8IDApCisjZGVmaW5lIFNVUFBMWV9NQVNLCQkoTERPMTVf
RU4gfCBDUFVNUF9FTiB8IEFVRElPX0VOKQorCisvKiBBdWRpbyBFbmFibGUgUmVnaXN0ZXIgMSAo
MHhkZCkgKi8KKyNkZWZpbmUgQURDX01PRF9SSUdIVAkJKDEgPDwgMSkKKyNkZWZpbmUgQURDX01P
RF9MRUZUCQkoMSA8PCAwKQorCisvKiBBdWRpbyBFbmFibGUgUmVnaXN0ZXIgMiAoMHhkZSkgKi8K
KyNkZWZpbmUgQURDX0xFRlQJCSgxIDw8IDUpCisjZGVmaW5lIEFEQ19SSUdIVAkJKDEgPDwgNCkK
KworLyogREFDIEVuYWJsZSBSZWdpc3RlciAyICgweGUxKSAqLworI2RlZmluZSBEQUNfTEVGVAkJ
KDEgPDwgNSkKKyNkZWZpbmUgREFDX1JJR0hUCQkoMSA8PCA0KQorI2RlZmluZSBNT0RVTEFUT1IJ
CSgxIDw8IDMpCisKKy8qIFNob3J0cyBSZWdpc3RlciAoMHhlYikgKi8KKyNkZWZpbmUgUkVHX1NI
T1JUUwkJMHhlYgorI2RlZmluZSBTSE9SVF9MTzIJCSgxIDw8IDYpCisjZGVmaW5lIFNIT1JUX0xP
MQkJKDEgPDwgNCkKKyNkZWZpbmUgU0hPUlRfSFMyCQkoMSA8PCAyKQorI2RlZmluZSBTSE9SVF9I
UzEJCSgxIDw8IDApCisKK2VudW0geworCUZJTFRFUl9CWVBBU1MgPSAwLAorCUZJTFRFUl9MT1df
UEFTU18xLAorCUZJTFRFUl9MT1dfUEFTU18yLAorCUZJTFRFUl9ISUdIX1BBU1NfMywKKwlGSUxU
RVJfTUFYLAorfTsKKworc3RydWN0IHBtODYweF9wcml2IHsKKwl1bnNpZ25lZCBpbnQJCXN5c2Ns
azsKKwl1bnNpZ25lZCBpbnQJCXBjbWNsazsKKwl1bnNpZ25lZCBpbnQJCWRpcjsKKwl1bnNpZ25l
ZCBpbnQJCWZpbHRlcjsKKwlzdHJ1Y3Qgc25kX3NvY19jb2RlYwkqY29kZWM7CisJc3RydWN0IGky
Y19jbGllbnQJKmkyYzsKKwlzdHJ1Y3QgcG04NjB4X2NoaXAJKmNoaXA7CisKKwlpbnQJCQlpcnFb
NF07CisJdW5zaWduZWQgY2hhcgkJbmFtZVs0XVtNQVhfTkFNRV9MRU5dOworCXVuc2lnbmVkIGNo
YXIJCXJlZ19jYWNoZVtSRUdfQ0FDSEVfU0laRV07Cit9OworCisvKiAtOTQ1MGRCIHRvIDBkQiBp
biAxNTBkQiBzdGVwcyAoIG11dGUgaW5zdGVhZCBvZiAtOTQ1MGRCKSAqLworc3RhdGljIGNvbnN0
IERFQ0xBUkVfVExWX0RCX1NDQUxFKGRwZ2FfdGx2LCAtOTQ1MCwgMTUwLCAxKTsKKworLyogLTlk
QiB0byAwZGIgaW4gM2RCIHN0ZXBzICovCitzdGF0aWMgY29uc3QgREVDTEFSRV9UTFZfREJfU0NB
TEUoYWRjX3RsdiwgLTkwMCwgMzAwLCAwKTsKKworLyogey0yMywgLTE3LCAtMTMuNSwgLTExLCAt
OSwgLTYsIC0zLCAwfWRCICovCitzdGF0aWMgY29uc3QgdW5zaWduZWQgaW50IG1pY190bHZbXSA9
IHsKKwlUTFZfREJfUkFOR0VfSEVBRCg1KSwKKwkwLCAwLCBUTFZfREJfU0NBTEVfSVRFTSgtMjMw
MCwgMCwgMCksCisJMSwgMSwgVExWX0RCX1NDQUxFX0lURU0oLTE3MDAsIDAsIDApLAorCTIsIDIs
IFRMVl9EQl9TQ0FMRV9JVEVNKC0xMzUwLCAwLCAwKSwKKwkzLCAzLCBUTFZfREJfU0NBTEVfSVRF
TSgtMTEwMCwgMCwgMCksCisJNCwgNywgVExWX0RCX1NDQUxFX0lURU0oLTkwMCwgMzAwLCAwKSwK
K307CisKKy8qIHswLCAwLCAwLCAtNiwgMCwgNiwgMTIsIDE4fWRCICovCitzdGF0aWMgY29uc3Qg
dW5zaWduZWQgaW50IGF1eF90bHZbXSA9IHsKKwlUTFZfREJfUkFOR0VfSEVBRCgyKSwKKwkwLCAy
LCBUTFZfREJfU0NBTEVfSVRFTSgwLCAwLCAwKSwKKwkzLCA3LCBUTFZfREJfU0NBTEVfSVRFTSgt
NjAwLCA2MDAsIDApLAorfTsKKworLyogey0xNiwgLTEzLCAtMTAsIC03LCAtNS4yLCAtMywzLCAt
Mi4yLCAwfWRCLCBtdXRlIGluc3RlYWQgb2YgLTE2ZEIgKi8KK3N0YXRpYyBjb25zdCB1bnNpZ25l
ZCBpbnQgb3V0X3RsdltdID0geworCVRMVl9EQl9SQU5HRV9IRUFEKDQpLAorCTAsIDMsIFRMVl9E
Ql9TQ0FMRV9JVEVNKC0xNjAwLCAzMDAsIDEpLAorCTQsIDQsIFRMVl9EQl9TQ0FMRV9JVEVNKC01
MjAsIDAsIDApLAorCTUsIDUsIFRMVl9EQl9TQ0FMRV9JVEVNKC0zMzAsIDAsIDApLAorCTYsIDcs
IFRMVl9EQl9TQ0FMRV9JVEVNKC0yMjAsIDIyMCwgMCksCit9OworCitzdGF0aWMgY29uc3QgdW5z
aWduZWQgaW50IHN0X3RsdltdID0geworCVRMVl9EQl9SQU5HRV9IRUFEKDgpLAorCTAsIDEsIFRM
Vl9EQl9TQ0FMRV9JVEVNKC0xMjA0MSwgNjAyLCAwKSwKKwkyLCAzLCBUTFZfREJfU0NBTEVfSVRF
TSgtMTEwODcsIDI1MCwgMCksCisJNCwgNSwgVExWX0RCX1NDQUxFX0lURU0oLTEwNjQzLCAxNTgs
IDApLAorCTYsIDcsIFRMVl9EQl9TQ0FMRV9JVEVNKC0xMDM1MSwgMTE2LCAwKSwKKwk4LCA5LCBU
TFZfREJfU0NBTEVfSVRFTSgtMTAxMzMsIDkyLCAwKSwKKwkxMCwgMTMsIFRMVl9EQl9TQ0FMRV9J
VEVNKC05OTU4LCA3MCwgMCksCisJMTQsIDE3LCBUTFZfREJfU0NBTEVfSVRFTSgtOTY4OSwgNTMs
IDApLAorCTE4LCAyNzEsIFRMVl9EQl9TQ0FMRV9JVEVNKC05NDg0LCAzNywgMCksCit9OworCisv
KiBTaWRldG9uZSBHYWluID0gTSAqIDJeKC01LU4pICovCitzdHJ1Y3Qgc3RfZ2FpbiB7CisJdW5z
aWduZWQgaW50CWRiOworCXVuc2lnbmVkIGludAltOworCXVuc2lnbmVkIGludAluOworfTsKKwor
c3RhdGljIHN0cnVjdCBzdF9nYWluIHN0X3RhYmxlW10gPSB7CisJey0xMjA0MSwgIDEsIDE1fSwg
ey0xMTQzOSwgIDEsIDE0fSwgey0xMTA4NywgIDMsIDE1fSwgey0xMDgzNywgIDEsIDEzfSwKKwl7
LTEwNjQzLCAgNSwgMTV9LCB7LTEwNDg1LCAgMywgMTR9LCB7LTEwMzUxLCAgNywgMTV9LCB7LTEw
MjM1LCAgMSwgMTJ9LAorCXstMTAxMzMsICA5LCAxNX0sIHstMTAwNDEsICA1LCAxNH0sIHsgLTk5
NTgsIDExLCAxNX0sIHsgLTk4ODMsICAzLCAxM30sCisJeyAtOTgxMywgMTMsIDE1fSwgeyAtOTc0
OSwgIDcsIDE0fSwgeyAtOTY4OSwgMTUsIDE1fSwgeyAtOTYzMywgIDEsIDExfSwKKwl7IC05NTgw
LCAxNywgMTV9LCB7IC05NTMxLCAgOSwgMTR9LCB7IC05NDg0LCAxOSwgMTV9LCB7IC05NDM5LCAg
NSwgMTN9LAorCXsgLTkzOTcsIDIxLCAxNX0sIHsgLTkzNTYsIDExLCAxNH0sIHsgLTkzMTgsIDIz
LCAxNX0sIHsgLTkyODEsICAzLCAxMn0sCisJeyAtOTI0NSwgMjUsIDE1fSwgeyAtOTIxMSwgMTMs
IDE0fSwgeyAtOTE3OCwgMjcsIDE1fSwgeyAtOTE0NywgIDcsIDEzfSwKKwl7IC05MTE2LCAyOSwg
MTV9LCB7IC05MDg3LCAxNSwgMTR9LCB7IC05MDU4LCAzMSwgMTV9LCB7IC05MDMxLCAgMSwgMTB9
LAorCXsgLTg5NzgsIDE3LCAxNH0sIHsgLTg5MjksICA5LCAxM30sIHsgLTg4ODIsIDE5LCAxNH0s
IHsgLTg4MzcsICA1LCAxMn0sCisJeyAtODc5NSwgMjEsIDE0fSwgeyAtODc1NCwgMTEsIDEzfSwg
eyAtODcxNiwgMjMsIDE0fSwgeyAtODY3OSwgIDMsIDExfSwKKwl7IC04NjQzLCAyNSwgMTR9LCB7
IC04NjA5LCAxMywgMTN9LCB7IC04NTc2LCAyNywgMTR9LCB7IC04NTQ1LCAgNywgMTJ9LAorCXsg
LTg1MTQsIDI5LCAxNH0sIHsgLTg0ODUsIDE1LCAxM30sIHsgLTg0NTYsIDMxLCAxNH0sIHsgLTg0
MjksICAxLCAgOX0sCisJeyAtODM3NiwgMTcsIDEzfSwgeyAtODMyNywgIDksIDEyfSwgeyAtODI4
MCwgMTksIDEzfSwgeyAtODIzNSwgIDUsIDExfSwKKwl7IC04MTkzLCAyMSwgMTN9LCB7IC04MTUy
LCAxMSwgMTJ9LCB7IC04MTE0LCAyMywgMTN9LCB7IC04MDc3LCAgMywgMTB9LAorCXsgLTgwNDEs
IDI1LCAxM30sIHsgLTgwMDcsIDEzLCAxMn0sIHsgLTc5NzQsIDI3LCAxM30sIHsgLTc5NDMsICA3
LCAxMX0sCisJeyAtNzkxMiwgMjksIDEzfSwgeyAtNzg4MywgMTUsIDEyfSwgeyAtNzg1NCwgMzEs
IDEzfSwgeyAtNzgyNywgIDEsICA4fSwKKwl7IC03Nzc0LCAxNywgMTJ9LCB7IC03NzI0LCAgOSwg
MTF9LCB7IC03Njc4LCAxOSwgMTJ9LCB7IC03NjMzLCAgNSwgMTB9LAorCXsgLTc1OTEsIDIxLCAx
Mn0sIHsgLTc1NTAsIDExLCAxMX0sIHsgLTc1MTIsIDIzLCAxMn0sIHsgLTc0NzUsICAzLCAgOX0s
CisJeyAtNzQzOSwgMjUsIDEyfSwgeyAtNzQwNSwgMTMsIDExfSwgeyAtNzM3MiwgMjcsIDEyfSwg
eyAtNzM0MSwgIDcsIDEwfSwKKwl7IC03MzEwLCAyOSwgMTJ9LCB7IC03MjgxLCAxNSwgMTF9LCB7
IC03MjUyLCAzMSwgMTJ9LCB7IC03MjI1LCAgMSwgIDd9LAorCXsgLTcxNzIsIDE3LCAxMX0sIHsg
LTcxMjIsICA5LCAxMH0sIHsgLTcwNzUsIDE5LCAxMX0sIHsgLTcwMzEsICA1LCAgOX0sCisJeyAt
Njk4OSwgMjEsIDExfSwgeyAtNjk0OCwgMTEsIDEwfSwgeyAtNjkxMCwgMjMsIDExfSwgeyAtNjg3
MywgIDMsICA4fSwKKwl7IC02ODM3LCAyNSwgMTF9LCB7IC02ODAzLCAxMywgMTB9LCB7IC02Nzcw
LCAyNywgMTF9LCB7IC02NzM5LCAgNywgIDl9LAorCXsgLTY3MDgsIDI5LCAxMX0sIHsgLTY2Nzks
IDE1LCAxMH0sIHsgLTY2NTAsIDMxLCAxMX0sIHsgLTY2MjMsICAxLCAgNn0sCisJeyAtNjU3MCwg
MTcsIDEwfSwgeyAtNjUyMCwgIDksICA5fSwgeyAtNjQ3MywgMTksIDEwfSwgeyAtNjQyOSwgIDUs
ICA4fSwKKwl7IC02Mzg2LCAyMSwgMTB9LCB7IC02MzQ2LCAxMSwgIDl9LCB7IC02MzA3LCAyMywg
MTB9LCB7IC02MjcwLCAgMywgIDd9LAorCXsgLTYyMzUsIDI1LCAxMH0sIHsgLTYyMDEsIDEzLCAg
OX0sIHsgLTYxNjgsIDI3LCAxMH0sIHsgLTYxMzcsICA3LCAgOH0sCisJeyAtNjEwNiwgMjksIDEw
fSwgeyAtNjA3NywgMTUsICA5fSwgeyAtNjA0OCwgMzEsIDEwfSwgeyAtNjAyMSwgIDEsICA1fSwK
Kwl7IC01OTY4LCAxNywgIDl9LCB7IC01OTE4LCAgOSwgIDh9LCB7IC01ODcxLCAxOSwgIDl9LCB7
IC01ODI3LCAgNSwgIDd9LAorCXsgLTU3ODQsIDIxLCAgOX0sIHsgLTU3NDQsIDExLCAgOH0sIHsg
LTU3MDUsIDIzLCAgOX0sIHsgLTU2NjgsICAzLCAgNn0sCisJeyAtNTYzMywgMjUsICA5fSwgeyAt
NTU5OSwgMTMsICA4fSwgeyAtNTU2NiwgMjcsICA5fSwgeyAtNTUzNSwgIDcsICA3fSwKKwl7IC01
NTA0LCAyOSwgIDl9LCB7IC01NDc1LCAxNSwgIDh9LCB7IC01NDQ2LCAzMSwgIDl9LCB7IC01NDE5
LCAgMSwgIDR9LAorCXsgLTUzNjYsIDE3LCAgOH0sIHsgLTUzMTYsICA5LCAgN30sIHsgLTUyNjks
IDE5LCAgOH0sIHsgLTUyMjUsICA1LCAgNn0sCisJeyAtNTE4MiwgMjEsICA4fSwgeyAtNTE0Miwg
MTEsICA3fSwgeyAtNTEwMywgMjMsICA4fSwgeyAtNTA2NiwgIDMsICA1fSwKKwl7IC01MDMxLCAy
NSwgIDh9LCB7IC00OTk3LCAxMywgIDd9LCB7IC00OTY0LCAyNywgIDh9LCB7IC00OTMyLCAgNywg
IDZ9LAorCXsgLTQ5MDIsIDI5LCAgOH0sIHsgLTQ4NzMsIDE1LCAgN30sIHsgLTQ4NDQsIDMxLCAg
OH0sIHsgLTQ4MTYsICAxLCAgM30sCisJeyAtNDc2NCwgMTcsICA3fSwgeyAtNDcxNCwgIDksICA2
fSwgeyAtNDY2NywgMTksICA3fSwgeyAtNDYyMywgIDUsICA1fSwKKwl7IC00NTgwLCAyMSwgIDd9
LCB7IC00NTQwLCAxMSwgIDZ9LCB7IC00NTAxLCAyMywgIDd9LCB7IC00NDY0LCAgMywgIDR9LAor
CXsgLTQ0MjksIDI1LCAgN30sIHsgLTQzOTUsIDEzLCAgNn0sIHsgLTQzNjIsIDI3LCAgN30sIHsg
LTQzMzAsICA3LCAgNX0sCisJeyAtNDMwMCwgMjksICA3fSwgeyAtNDI3MCwgMTUsICA2fSwgeyAt
NDI0MiwgMzEsICA3fSwgeyAtNDIxNCwgIDEsICAyfSwKKwl7IC00MTYyLCAxNywgIDZ9LCB7IC00
MTEyLCAgOSwgIDV9LCB7IC00MDY1LCAxOSwgIDZ9LCB7IC00MDIxLCAgNSwgIDR9LAorCXsgLTM5
NzgsIDIxLCAgNn0sIHsgLTM5MzgsIDExLCAgNX0sIHsgLTM4OTksIDIzLCAgNn0sIHsgLTM4NjIs
ICAzLCAgM30sCisJeyAtMzgyNywgMjUsICA2fSwgeyAtMzc5MywgMTMsICA1fSwgeyAtMzc2MCwg
MjcsICA2fSwgeyAtMzcyOCwgIDcsICA0fSwKKwl7IC0zNjk4LCAyOSwgIDZ9LCB7IC0zNjY4LCAx
NSwgIDV9LCB7IC0zNjQwLCAzMSwgIDZ9LCB7IC0zNjEyLCAgMSwgIDF9LAorCXsgLTM1NjAsIDE3
LCAgNX0sIHsgLTM1MTAsICA5LCAgNH0sIHsgLTM0NjMsIDE5LCAgNX0sIHsgLTM0MTksICA1LCAg
M30sCisJeyAtMzM3NiwgMjEsICA1fSwgeyAtMzMzNiwgMTEsICA0fSwgeyAtMzI5NywgMjMsICA1
fSwgeyAtMzI2MCwgIDMsICAyfSwKKwl7IC0zMjI1LCAyNSwgIDV9LCB7IC0zMTkxLCAxMywgIDR9
LCB7IC0zMTU4LCAyNywgIDV9LCB7IC0zMTI2LCAgNywgIDN9LAorCXsgLTMwOTYsIDI5LCAgNX0s
IHsgLTMwNjYsIDE1LCAgNH0sIHsgLTMwMzgsIDMxLCAgNX0sIHsgLTMwMTAsICAxLCAgMH0sCisJ
eyAtMjk1OCwgMTcsICA0fSwgeyAtMjkwOCwgIDksICAzfSwgeyAtMjg2MSwgMTksICA0fSwgeyAt
MjgxNiwgIDUsICAyfSwKKwl7IC0yNzc0LCAyMSwgIDR9LCB7IC0yNzM0LCAxMSwgIDN9LCB7IC0y
Njk1LCAyMywgIDR9LCB7IC0yNjU4LCAgMywgIDF9LAorCXsgLTI2MjMsIDI1LCAgNH0sIHsgLTI1
ODksIDEzLCAgM30sIHsgLTI1NTYsIDI3LCAgNH0sIHsgLTI1MjQsICA3LCAgMn0sCisJeyAtMjQ5
NCwgMjksICA0fSwgeyAtMjQ2NCwgMTUsICAzfSwgeyAtMjQzNiwgMzEsICA0fSwgeyAtMjQwOCwg
IDIsICAwfSwKKwl7IC0yMzU2LCAxNywgIDN9LCB7IC0yMzA2LCAgOSwgIDJ9LCB7IC0yMjU5LCAx
OSwgIDN9LCB7IC0yMjE0LCAgNSwgIDF9LAorCXsgLTIxNzIsIDIxLCAgM30sIHsgLTIxMzIsIDEx
LCAgMn0sIHsgLTIwOTMsIDIzLCAgM30sIHsgLTIwNTYsICAzLCAgMH0sCisJeyAtMjAyMSwgMjUs
ICAzfSwgeyAtMTk4NywgMTMsICAyfSwgeyAtMTk1NCwgMjcsICAzfSwgeyAtMTkyMiwgIDcsICAx
fSwKKwl7IC0xODkyLCAyOSwgIDN9LCB7IC0xODYyLCAxNSwgIDJ9LCB7IC0xODM0LCAzMSwgIDN9
LCB7IC0xODA2LCAgNCwgIDB9LAorCXsgLTE3NTQsIDE3LCAgMn0sIHsgLTE3MDQsICA5LCAgMX0s
IHsgLTE2NTcsIDE5LCAgMn0sIHsgLTE2MTIsICA1LCAgMH0sCisJeyAtMTU3MCwgMjEsICAyfSwg
eyAtMTUzMCwgMTEsICAxfSwgeyAtMTQ5MSwgMjMsICAyfSwgeyAtMTQ1NCwgIDYsICAwfSwKKwl7
IC0xNDE5LCAyNSwgIDJ9LCB7IC0xMzg0LCAxMywgIDF9LCB7IC0xMzUyLCAyNywgIDJ9LCB7IC0x
MzIwLCAgNywgIDB9LAorCXsgLTEyOTAsIDI5LCAgMn0sIHsgLTEyNjAsIDE1LCAgMX0sIHsgLTEy
MzIsIDMxLCAgMn0sIHsgLTEyMDQsICA4LCAgMH0sCisJeyAtMTE1MSwgMTcsICAxfSwgeyAtMTEw
MiwgIDksICAwfSwgeyAtMTA1NSwgMTksICAxfSwgeyAtMTAxMCwgMTAsICAwfSwKKwl7ICAtOTY4
LCAyMSwgIDF9LCB7ICAtOTI4LCAxMSwgIDB9LCB7ICAtODg5LCAyMywgIDF9LCB7ICAtODUyLCAx
MiwgIDB9LAorCXsgIC04MTYsIDI1LCAgMX0sIHsgIC03ODIsIDEzLCAgMH0sIHsgIC03NTAsIDI3
LCAgMX0sIHsgIC03MTgsIDE0LCAgMH0sCisJeyAgLTY4OCwgMjksICAxfSwgeyAgLTY1OCwgMTUs
ICAwfSwgeyAgLTYzMCwgMzEsICAxfSwgeyAgLTYwMiwgMTYsICAwfSwKKwl7ICAtNTQ5LCAxNywg
IDB9LCB7ICAtNTAwLCAxOCwgIDB9LCB7ICAtNDUzLCAxOSwgIDB9LCB7ICAtNDA4LCAyMCwgIDB9
LAorCXsgIC0zNjYsIDIxLCAgMH0sIHsgIC0zMjUsIDIyLCAgMH0sIHsgIC0yODcsIDIzLCAgMH0s
IHsgIC0yNTAsIDI0LCAgMH0sCisJeyAgLTIxNCwgMjUsICAwfSwgeyAgLTE4MCwgMjYsICAwfSwg
eyAgLTE0OCwgMjcsICAwfSwgeyAgLTExNiwgMjgsICAwfSwKKwl7ICAgLTg2LCAyOSwgIDB9LCB7
ICAgLTU2LCAzMCwgIDB9LCB7ICAgLTI4LCAzMSwgIDB9LCB7ICAgICAwLCAgMCwgIDB9LAorfTsK
Kworc3RhdGljIGludCBwbTg2MHhfdm9sYXRpbGUodW5zaWduZWQgaW50IHJlZykKK3sKKwlCVUdf
T04ocmVnID49IFJFR19DQUNIRV9TSVpFKTsKKworCXN3aXRjaCAocmVnKSB7CisJY2FzZSBQTTg2
MFhfQVVESU9fU1VQUExJRVNfMjoKKwkJcmV0dXJuIDE7CisJfQorCisJcmV0dXJuIDA7Cit9CisK
K3N0YXRpYyB1bnNpZ25lZCBpbnQgcG04NjB4X3JlYWRfcmVnX2NhY2hlKHN0cnVjdCBzbmRfc29j
X2NvZGVjICpjb2RlYywKKwkJCQkJICB1bnNpZ25lZCBpbnQgcmVnKQoreworCXVuc2lnbmVkIGNo
YXIgKmNhY2hlID0gY29kZWMtPnJlZ19jYWNoZTsKKworCUJVR19PTihyZWcgPj0gUkVHX0NBQ0hF
X1NJWkUpOworCisJaWYgKHBtODYweF92b2xhdGlsZShyZWcpKQorCQlyZXR1cm4gY2FjaGVbcmVn
XTsKKworCXJlZyArPSBSRUdfQ0FDSEVfQkFTRTsKKworCXJldHVybiBwbTg2MHhfcmVnX3JlYWQo
Y29kZWMtPmNvbnRyb2xfZGF0YSwgcmVnKTsKK30KKworc3RhdGljIGludCBwbTg2MHhfd3JpdGVf
cmVnX2NhY2hlKHN0cnVjdCBzbmRfc29jX2NvZGVjICpjb2RlYywKKwkJCQkgIHVuc2lnbmVkIGlu
dCByZWcsIHVuc2lnbmVkIGludCB2YWx1ZSkKK3sKKwl1bnNpZ25lZCBjaGFyICpjYWNoZSA9IGNv
ZGVjLT5yZWdfY2FjaGU7CisKKwlCVUdfT04ocmVnID49IFJFR19DQUNIRV9TSVpFKTsKKworCWlm
ICghcG04NjB4X3ZvbGF0aWxlKHJlZykpCisJCWNhY2hlW3JlZ10gPSAodW5zaWduZWQgY2hhcil2
YWx1ZTsKKworCXJlZyArPSBSRUdfQ0FDSEVfQkFTRTsKKworCXJldHVybiBwbTg2MHhfcmVnX3dy
aXRlKGNvZGVjLT5jb250cm9sX2RhdGEsIHJlZywgdmFsdWUpOworfQorCitzdGF0aWMgaW50IHNu
ZF9zb2NfZ2V0X3ZvbHN3XzJyX3N0KHN0cnVjdCBzbmRfa2NvbnRyb2wgKmtjb250cm9sLAorCQkJ
CSAgIHN0cnVjdCBzbmRfY3RsX2VsZW1fdmFsdWUgKnVjb250cm9sKQoreworCXN0cnVjdCBzb2Nf
bWl4ZXJfY29udHJvbCAqbWMgPQorCQkoc3RydWN0IHNvY19taXhlcl9jb250cm9sICopa2NvbnRy
b2wtPnByaXZhdGVfdmFsdWU7CisJc3RydWN0IHNuZF9zb2NfY29kZWMgKmNvZGVjID0gc25kX2tj
b250cm9sX2NoaXAoa2NvbnRyb2wpOworCXVuc2lnbmVkIGludCByZWcgPSBtYy0+cmVnOworCXVu
c2lnbmVkIGludCByZWcyID0gbWMtPnJyZWc7CisJaW50IHZhbFsyXSwgdmFsMlsyXSwgaTsKKwor
CXZhbFswXSA9IHNuZF9zb2NfcmVhZChjb2RlYywgcmVnKSAmIDB4M2Y7CisJdmFsWzFdID0gKHNu
ZF9zb2NfcmVhZChjb2RlYywgUE04NjBYX1NJREVUT05FX1NISUZUKSA+PiA0KSAmIDB4ZjsKKwl2
YWwyWzBdID0gc25kX3NvY19yZWFkKGNvZGVjLCByZWcyKSAmIDB4M2Y7CisJdmFsMlsxXSA9IChz
bmRfc29jX3JlYWQoY29kZWMsIFBNODYwWF9TSURFVE9ORV9TSElGVCkpICYgMHhmOworCisJZm9y
IChpID0gMDsgaSA8IEFSUkFZX1NJWkUoc3RfdGFibGUpOyBpKyspIHsKKwkJaWYgKChzdF90YWJs
ZVtpXS5tID09IHZhbFswXSkgJiYgKHN0X3RhYmxlW2ldLm4gPT0gdmFsWzFdKSkKKwkJCXVjb250
cm9sLT52YWx1ZS5pbnRlZ2VyLnZhbHVlWzBdID0gaTsKKwkJaWYgKChzdF90YWJsZVtpXS5tID09
IHZhbDJbMF0pICYmIChzdF90YWJsZVtpXS5uID09IHZhbDJbMV0pKQorCQkJdWNvbnRyb2wtPnZh
bHVlLmludGVnZXIudmFsdWVbMV0gPSBpOworCX0KKwlyZXR1cm4gMDsKK30KKworc3RhdGljIGlu
dCBzbmRfc29jX3B1dF92b2xzd18ycl9zdChzdHJ1Y3Qgc25kX2tjb250cm9sICprY29udHJvbCwK
KwkJCQkgICBzdHJ1Y3Qgc25kX2N0bF9lbGVtX3ZhbHVlICp1Y29udHJvbCkKK3sKKwlzdHJ1Y3Qg
c29jX21peGVyX2NvbnRyb2wgKm1jID0KKwkJKHN0cnVjdCBzb2NfbWl4ZXJfY29udHJvbCAqKWtj
b250cm9sLT5wcml2YXRlX3ZhbHVlOworCXN0cnVjdCBzbmRfc29jX2NvZGVjICpjb2RlYyA9IHNu
ZF9rY29udHJvbF9jaGlwKGtjb250cm9sKTsKKwl1bnNpZ25lZCBpbnQgcmVnID0gbWMtPnJlZzsK
Kwl1bnNpZ25lZCBpbnQgcmVnMiA9IG1jLT5ycmVnOworCWludCBlcnI7CisJdW5zaWduZWQgaW50
IHZhbCwgdmFsMjsKKworCXZhbCA9IHVjb250cm9sLT52YWx1ZS5pbnRlZ2VyLnZhbHVlWzBdOwor
CXZhbDIgPSB1Y29udHJvbC0+dmFsdWUuaW50ZWdlci52YWx1ZVsxXTsKKworCWVyciA9IHNuZF9z
b2NfdXBkYXRlX2JpdHMoY29kZWMsIHJlZywgMHgzZiwgc3RfdGFibGVbdmFsXS5tKTsKKwlpZiAo
ZXJyIDwgMCkKKwkJcmV0dXJuIGVycjsKKwllcnIgPSBzbmRfc29jX3VwZGF0ZV9iaXRzKGNvZGVj
LCBQTTg2MFhfU0lERVRPTkVfU0hJRlQsIDB4ZjAsCisJCQkJICBzdF90YWJsZVt2YWxdLm4gPDwg
NCk7CisJaWYgKGVyciA8IDApCisJCXJldHVybiBlcnI7CisKKwllcnIgPSBzbmRfc29jX3VwZGF0
ZV9iaXRzKGNvZGVjLCByZWcyLCAweDNmLCBzdF90YWJsZVt2YWwyXS5tKTsKKwlpZiAoZXJyIDwg
MCkKKwkJcmV0dXJuIGVycjsKKwllcnIgPSBzbmRfc29jX3VwZGF0ZV9iaXRzKGNvZGVjLCBQTTg2
MFhfU0lERVRPTkVfU0hJRlQsIDB4MGYsCisJCQkJICBzdF90YWJsZVt2YWwyXS5uKTsKKwlyZXR1
cm4gZXJyOworfQorCitzdGF0aWMgaW50IHNuZF9zb2NfZ2V0X3ZvbHN3XzJyX291dChzdHJ1Y3Qg
c25kX2tjb250cm9sICprY29udHJvbCwKKwkJCQkgICAgc3RydWN0IHNuZF9jdGxfZWxlbV92YWx1
ZSAqdWNvbnRyb2wpCit7CisJc3RydWN0IHNvY19taXhlcl9jb250cm9sICptYyA9CisJCShzdHJ1
Y3Qgc29jX21peGVyX2NvbnRyb2wgKilrY29udHJvbC0+cHJpdmF0ZV92YWx1ZTsKKwlzdHJ1Y3Qg
c25kX3NvY19jb2RlYyAqY29kZWMgPSBzbmRfa2NvbnRyb2xfY2hpcChrY29udHJvbCk7CisJdW5z
aWduZWQgaW50IHJlZyA9IG1jLT5yZWc7CisJdW5zaWduZWQgaW50IHJlZzIgPSBtYy0+cnJlZzsK
Kwl1bnNpZ25lZCBpbnQgc2hpZnQgPSBtYy0+c2hpZnQ7CisJaW50IG1heCA9IG1jLT5tYXgsIHZh
bCwgdmFsMjsKKwl1bnNpZ25lZCBpbnQgbWFzayA9ICgxIDw8IGZscyhtYXgpKSAtIDE7CisKKwl2
YWwgPSBzbmRfc29jX3JlYWQoY29kZWMsIHJlZykgPj4gc2hpZnQ7CisJdmFsMiA9IHNuZF9zb2Nf
cmVhZChjb2RlYywgcmVnMikgPj4gc2hpZnQ7CisJdWNvbnRyb2wtPnZhbHVlLmludGVnZXIudmFs
dWVbMF0gPSAobWF4IC0gdmFsKSAmIG1hc2s7CisJdWNvbnRyb2wtPnZhbHVlLmludGVnZXIudmFs
dWVbMV0gPSAobWF4IC0gdmFsMikgJiBtYXNrOworCisJcmV0dXJuIDA7Cit9CisKK3N0YXRpYyBp
bnQgc25kX3NvY19wdXRfdm9sc3dfMnJfb3V0KHN0cnVjdCBzbmRfa2NvbnRyb2wgKmtjb250cm9s
LAorCQkJCSAgICBzdHJ1Y3Qgc25kX2N0bF9lbGVtX3ZhbHVlICp1Y29udHJvbCkKK3sKKwlzdHJ1
Y3Qgc29jX21peGVyX2NvbnRyb2wgKm1jID0KKwkJKHN0cnVjdCBzb2NfbWl4ZXJfY29udHJvbCAq
KWtjb250cm9sLT5wcml2YXRlX3ZhbHVlOworCXN0cnVjdCBzbmRfc29jX2NvZGVjICpjb2RlYyA9
IHNuZF9rY29udHJvbF9jaGlwKGtjb250cm9sKTsKKwl1bnNpZ25lZCBpbnQgcmVnID0gbWMtPnJl
ZzsKKwl1bnNpZ25lZCBpbnQgcmVnMiA9IG1jLT5ycmVnOworCXVuc2lnbmVkIGludCBzaGlmdCA9
IG1jLT5zaGlmdDsKKwlpbnQgbWF4ID0gbWMtPm1heDsKKwl1bnNpZ25lZCBpbnQgbWFzayA9ICgx
IDw8IGZscyhtYXgpKSAtIDE7CisJaW50IGVycjsKKwl1bnNpZ25lZCBpbnQgdmFsLCB2YWwyLCB2
YWxfbWFzazsKKworCXZhbF9tYXNrID0gbWFzayA8PCBzaGlmdDsKKwl2YWwgPSAoKG1heCAtIHVj
b250cm9sLT52YWx1ZS5pbnRlZ2VyLnZhbHVlWzBdKSAmIG1hc2spOworCXZhbDIgPSAoKG1heCAt
IHVjb250cm9sLT52YWx1ZS5pbnRlZ2VyLnZhbHVlWzFdKSAmIG1hc2spOworCisJdmFsID0gdmFs
IDw8IHNoaWZ0OworCXZhbDIgPSB2YWwyIDw8IHNoaWZ0OworCisJZXJyID0gc25kX3NvY191cGRh
dGVfYml0cyhjb2RlYywgcmVnLCB2YWxfbWFzaywgdmFsKTsKKwlpZiAoZXJyIDwgMCkKKwkJcmV0
dXJuIGVycjsKKworCWVyciA9IHNuZF9zb2NfdXBkYXRlX2JpdHMoY29kZWMsIHJlZzIsIHZhbF9t
YXNrLCB2YWwyKTsKKwlyZXR1cm4gZXJyOworfQorCisvKiBEQVBNIFdpZGdldCBFdmVudHMgKi8K
K3N0YXRpYyBpbnQgcG04NjB4X3JzeW5jX2V2ZW50KHN0cnVjdCBzbmRfc29jX2RhcG1fd2lkZ2V0
ICp3LAorCQkJICAgICAgc3RydWN0IHNuZF9rY29udHJvbCAqa2NvbnRyb2wsIGludCBldmVudCkK
K3sKKwlzdHJ1Y3Qgc25kX3NvY19jb2RlYyAqY29kZWMgPSB3LT5jb2RlYzsKKworCS8qIHVubXV0
ZSBEQUMgKi8KKwlzbmRfc29jX3VwZGF0ZV9iaXRzKGNvZGVjLCBQTTg2MFhfREFDX09GRlNFVCwg
REFDX01VVEUsIDApOworCXNuZF9zb2NfdXBkYXRlX2JpdHMoY29kZWMsIFBNODYwWF9FQVJfQ1RS
TF8yLAorCQkJICAgIFJTWU5DX0NIQU5HRSwgUlNZTkNfQ0hBTkdFKTsKKwlyZXR1cm4gMDsKK30K
Kworc3RhdGljIGludCBwbTg2MHhfYWRjX2V2ZW50KHN0cnVjdCBzbmRfc29jX2RhcG1fd2lkZ2V0
ICp3LAorCQkJICAgIHN0cnVjdCBzbmRfa2NvbnRyb2wgKmtjb250cm9sLCBpbnQgZXZlbnQpCit7
CisJc3RydWN0IHNuZF9zb2NfY29kZWMgKmNvZGVjID0gdy0+Y29kZWM7CisJdW5zaWduZWQgaW50
IGVuMSA9IDAsIGVuMiA9IDA7CisKKwlpZiAoIXN0cmNtcCh3LT5uYW1lLCAiTGVmdCBBREMiKSkg
eworCQllbjEgPSBBRENfTU9EX0xFRlQ7CisJCWVuMiA9IEFEQ19MRUZUOworCX0KKwlpZiAoIXN0
cmNtcCh3LT5uYW1lLCAiUmlnaHQgQURDIikpIHsKKwkJZW4xID0gQURDX01PRF9SSUdIVDsKKwkJ
ZW4yID0gQURDX1JJR0hUOworCX0KKwlzd2l0Y2ggKGV2ZW50KSB7CisJY2FzZSBTTkRfU09DX0RB
UE1fUFJFX1BNVToKKwkJc25kX3NvY191cGRhdGVfYml0cyhjb2RlYywgUE04NjBYX0FEQ19FTl8x
LCBlbjEsIGVuMSk7CisJCXNuZF9zb2NfdXBkYXRlX2JpdHMoY29kZWMsIFBNODYwWF9BRENfRU5f
MiwgZW4yLCBlbjIpOworCQlicmVhazsKKwljYXNlIFNORF9TT0NfREFQTV9QUkVfUE1EOgorCQlz
bmRfc29jX3VwZGF0ZV9iaXRzKGNvZGVjLCBQTTg2MFhfQURDX0VOXzEsIGVuMSwgMCk7CisJCXNu
ZF9zb2NfdXBkYXRlX2JpdHMoY29kZWMsIFBNODYwWF9BRENfRU5fMiwgZW4yLCAwKTsKKwkJYnJl
YWs7CisJfQorCXJldHVybiAwOworfQorCitzdGF0aWMgaW50IHBtODYweF9kYWNfZXZlbnQoc3Ry
dWN0IHNuZF9zb2NfZGFwbV93aWRnZXQgKncsCisJCQkgICAgc3RydWN0IHNuZF9rY29udHJvbCAq
a2NvbnRyb2wsIGludCBldmVudCkKK3sKKwlzdHJ1Y3Qgc25kX3NvY19jb2RlYyAqY29kZWMgPSB3
LT5jb2RlYzsKKwl1bnNpZ25lZCBpbnQgZGFjID0gMDsKKwlpbnQgZGF0YTsKKworCWlmICghc3Ry
Y21wKHctPm5hbWUsICJMZWZ0IERBQyIpKQorCQlkYWMgPSBEQUNfTEVGVDsKKwlpZiAoIXN0cmNt
cCh3LT5uYW1lLCAiUmlnaHQgREFDIikpCisJCWRhYyA9IERBQ19SSUdIVDsKKwlzd2l0Y2ggKGV2
ZW50KSB7CisJY2FzZSBTTkRfU09DX0RBUE1fUFJFX1BNVToKKwkJaWYgKGRhYykgeworCQkJZGFj
IHw9IE1PRFVMQVRPUjsKKwkJCS8qIG11dGUgKi8KKwkJCXNuZF9zb2NfdXBkYXRlX2JpdHMoY29k
ZWMsIFBNODYwWF9EQUNfT0ZGU0VULAorCQkJCQkgICAgREFDX01VVEUsIERBQ19NVVRFKTsKKwkJ
CXNuZF9zb2NfdXBkYXRlX2JpdHMoY29kZWMsIFBNODYwWF9FQVJfQ1RSTF8yLAorCQkJCQkgICAg
UlNZTkNfQ0hBTkdFLCBSU1lOQ19DSEFOR0UpOworCQkJLyogdXBkYXRlIGRhYyAqLworCQkJc25k
X3NvY191cGRhdGVfYml0cyhjb2RlYywgUE04NjBYX0RBQ19FTl8yLAorCQkJCQkgICAgZGFjLCBk
YWMpOworCQl9CisJCWJyZWFrOworCWNhc2UgU05EX1NPQ19EQVBNX1BSRV9QTUQ6CisJCWlmIChk
YWMpIHsKKwkJCS8qIG11dGUgKi8KKwkJCXNuZF9zb2NfdXBkYXRlX2JpdHMoY29kZWMsIFBNODYw
WF9EQUNfT0ZGU0VULAorCQkJCQkgICAgREFDX01VVEUsIERBQ19NVVRFKTsKKwkJCXNuZF9zb2Nf
dXBkYXRlX2JpdHMoY29kZWMsIFBNODYwWF9FQVJfQ1RSTF8yLAorCQkJCQkgICAgUlNZTkNfQ0hB
TkdFLCBSU1lOQ19DSEFOR0UpOworCQkJLyogdXBkYXRlIGRhYyAqLworCQkJZGF0YSA9IHNuZF9z
b2NfcmVhZChjb2RlYywgUE04NjBYX0RBQ19FTl8yKTsKKwkJCWRhdGEgJj0gfmRhYzsKKwkJCWlm
ICghKGRhdGEgJiAoREFDX0xFRlQgfCBEQUNfUklHSFQpKSkKKwkJCQlkYXRhICY9IH5NT0RVTEFU
T1I7CisJCQlzbmRfc29jX3dyaXRlKGNvZGVjLCBQTTg2MFhfREFDX0VOXzIsIGRhdGEpOworCQl9
CisJCWJyZWFrOworCX0KKwlyZXR1cm4gMDsKK30KKworc3RhdGljIGludCBwbTg2MHhfbWljMV9l
dmVudChzdHJ1Y3Qgc25kX3NvY19kYXBtX3dpZGdldCAqdywKKwkJCSAgICAgc3RydWN0IHNuZF9r
Y29udHJvbCAqa2NvbnRyb2wsIGludCBldmVudCkKK3sKKwlzdHJ1Y3Qgc25kX3NvY19jb2RlYyAq
Y29kZWMgPSB3LT5jb2RlYzsKKworCXN3aXRjaCAoZXZlbnQpIHsKKwljYXNlIFNORF9TT0NfREFQ
TV9QT1NUX1BNVToKKwkJLyogRW5hYmxlIE1pYzEgQmlhcyAmIE1JQ0RFVCwgSFNERVQgKi8KKwkJ
c25kX3NvY191cGRhdGVfYml0cyhjb2RlYywgUE04NjBYX0FEQ19BTkFfMSwgTUlDMUJJQVNfTUFT
SywKKwkJCQkgICAgTUlDMUJJQVNfTUFTSyk7CisJCXBtODYweF9zZXRfYml0cyhjb2RlYy0+Y29u
dHJvbF9kYXRhLCBSRUdfTUlDX0RFVCwKKwkJCQlNSUNERVRfTUFTSywgTUlDREVUX01BU0spOwor
CQlwbTg2MHhfc2V0X2JpdHMoY29kZWMtPmNvbnRyb2xfZGF0YSwgUkVHX0hTX0RFVCwKKwkJCQlF
Tl9IU19ERVQsIEVOX0hTX0RFVCk7CisJCWJyZWFrOworCWNhc2UgU05EX1NPQ19EQVBNX1BSRV9Q
TUQ6CisJCS8qIGRpc2FibGUgTWljMSBCaWFzICYgTUlDREVULCBIU0RFVCAqLworCQlwbTg2MHhf
c2V0X2JpdHMoY29kZWMtPmNvbnRyb2xfZGF0YSwgUkVHX01JQ19ERVQsCisJCQkJTUlDREVUX01B
U0ssIDApOworCQlwbTg2MHhfc2V0X2JpdHMoY29kZWMtPmNvbnRyb2xfZGF0YSwgUkVHX0hTX0RF
VCwKKwkJCQlFTl9IU19ERVQsIDApOworCQlzbmRfc29jX3VwZGF0ZV9iaXRzKGNvZGVjLCBQTTg2
MFhfQURDX0FOQV8xLCBNSUMxQklBU19NQVNLLCAwKTsKKwkJYnJlYWs7CisJfQorCXJldHVybiAw
OworfQorCitzdGF0aWMgY29uc3QgY2hhciAqcG04NjB4X29wYW1wX3RleHRzW10gPSB7Ii01MCUi
LCAiLTI1JSIsICIwJSIsICI3NSUifTsKKworc3RhdGljIGNvbnN0IGNoYXIgKnBtODYweF9wYV90
ZXh0c1tdID0geyItMzMlIiwgIjAlIiwgIjMzJSIsICI2NiUifTsKKworc3RhdGljIGNvbnN0IHN0
cnVjdCBzb2NfZW51bSBwbTg2MHhfaHMxX29wYW1wX2VudW0gPQorCVNPQ19FTlVNX1NJTkdMRShQ
TTg2MFhfSFMxX0NUUkwsIDUsIDQsIHBtODYweF9vcGFtcF90ZXh0cyk7CisKK3N0YXRpYyBjb25z
dCBzdHJ1Y3Qgc29jX2VudW0gcG04NjB4X2hzMl9vcGFtcF9lbnVtID0KKwlTT0NfRU5VTV9TSU5H
TEUoUE04NjBYX0hTMl9DVFJMLCA1LCA0LCBwbTg2MHhfb3BhbXBfdGV4dHMpOworCitzdGF0aWMg
Y29uc3Qgc3RydWN0IHNvY19lbnVtIHBtODYweF9oczFfcGFfZW51bSA9CisJU09DX0VOVU1fU0lO
R0xFKFBNODYwWF9IUzFfQ1RSTCwgMywgNCwgcG04NjB4X3BhX3RleHRzKTsKKworc3RhdGljIGNv
bnN0IHN0cnVjdCBzb2NfZW51bSBwbTg2MHhfaHMyX3BhX2VudW0gPQorCVNPQ19FTlVNX1NJTkdM
RShQTTg2MFhfSFMyX0NUUkwsIDMsIDQsIHBtODYweF9wYV90ZXh0cyk7CisKK3N0YXRpYyBjb25z
dCBzdHJ1Y3Qgc29jX2VudW0gcG04NjB4X2xvMV9vcGFtcF9lbnVtID0KKwlTT0NfRU5VTV9TSU5H
TEUoUE04NjBYX0xPMV9DVFJMLCA1LCA0LCBwbTg2MHhfb3BhbXBfdGV4dHMpOworCitzdGF0aWMg
Y29uc3Qgc3RydWN0IHNvY19lbnVtIHBtODYweF9sbzJfb3BhbXBfZW51bSA9CisJU09DX0VOVU1f
U0lOR0xFKFBNODYwWF9MTzJfQ1RSTCwgNSwgNCwgcG04NjB4X29wYW1wX3RleHRzKTsKKworc3Rh
dGljIGNvbnN0IHN0cnVjdCBzb2NfZW51bSBwbTg2MHhfbG8xX3BhX2VudW0gPQorCVNPQ19FTlVN
X1NJTkdMRShQTTg2MFhfTE8xX0NUUkwsIDMsIDQsIHBtODYweF9wYV90ZXh0cyk7CisKK3N0YXRp
YyBjb25zdCBzdHJ1Y3Qgc29jX2VudW0gcG04NjB4X2xvMl9wYV9lbnVtID0KKwlTT0NfRU5VTV9T
SU5HTEUoUE04NjBYX0xPMl9DVFJMLCAzLCA0LCBwbTg2MHhfcGFfdGV4dHMpOworCitzdGF0aWMg
Y29uc3Qgc3RydWN0IHNvY19lbnVtIHBtODYweF9zcGtfcGFfZW51bSA9CisJU09DX0VOVU1fU0lO
R0xFKFBNODYwWF9FQVJfQ1RSTF8xLCA1LCA0LCBwbTg2MHhfcGFfdGV4dHMpOworCitzdGF0aWMg
Y29uc3Qgc3RydWN0IHNvY19lbnVtIHBtODYweF9lYXJfcGFfZW51bSA9CisJU09DX0VOVU1fU0lO
R0xFKFBNODYwWF9FQVJfQ1RSTF8yLCAwLCA0LCBwbTg2MHhfcGFfdGV4dHMpOworCitzdGF0aWMg
Y29uc3Qgc3RydWN0IHNvY19lbnVtIHBtODYweF9zcGtfZWFyX29wYW1wX2VudW0gPQorCVNPQ19F
TlVNX1NJTkdMRShQTTg2MFhfRUFSX0NUUkxfMSwgMywgNCwgcG04NjB4X29wYW1wX3RleHRzKTsK
Kworc3RhdGljIGNvbnN0IHN0cnVjdCBzbmRfa2NvbnRyb2xfbmV3IHBtODYweF9zbmRfY29udHJv
bHNbXSA9IHsKKwlTT0NfRE9VQkxFX1JfVExWKCJBREMgQ2FwdHVyZSBWb2x1bWUiLCBQTTg2MFhf
QURDX0FOQV8yLAorCQkJUE04NjBYX0FEQ19BTkFfMywgNiwgMywgMCwgYWRjX3RsdiksCisJU09D
X0RPVUJMRV9UTFYoIkFVWCBDYXB0dXJlIFZvbHVtZSIsIFBNODYwWF9BRENfQU5BXzMsIDAsIDMs
IDcsIDAsCisJCQlhdXhfdGx2KSwKKwlTT0NfU0lOR0xFX1RMVigiTUlDMSBDYXB0dXJlIFZvbHVt
ZSIsIFBNODYwWF9BRENfQU5BXzIsIDAsIDcsIDAsCisJCQltaWNfdGx2KSwKKwlTT0NfU0lOR0xF
X1RMVigiTUlDMyBDYXB0dXJlIFZvbHVtZSIsIFBNODYwWF9BRENfQU5BXzIsIDMsIDcsIDAsCisJ
CQltaWNfdGx2KSwKKwlTT0NfRE9VQkxFX1JfRVhUX1RMVigiU2lkZXRvbmUgVm9sdW1lIiwgUE04
NjBYX1NJREVUT05FX0xfR0FJTiwKKwkJCSAgICAgUE04NjBYX1NJREVUT05FX1JfR0FJTiwgMCwg
QVJSQVlfU0laRShzdF90YWJsZSktMSwKKwkJCSAgICAgMCwgc25kX3NvY19nZXRfdm9sc3dfMnJf
c3QsCisJCQkgICAgIHNuZF9zb2NfcHV0X3ZvbHN3XzJyX3N0LCBzdF90bHYpLAorCVNPQ19TSU5H
TEVfVExWKCJTcGVha2VyIFBsYXliYWNrIFZvbHVtZSIsIFBNODYwWF9FQVJfQ1RSTF8xLAorCQkJ
MCwgNywgMCwgb3V0X3RsdiksCisJU09DX0RPVUJMRV9SX1RMVigiTGluZSBQbGF5YmFjayBWb2x1
bWUiLCBQTTg2MFhfTE8xX0NUUkwsCisJCQkgUE04NjBYX0xPMl9DVFJMLCAwLCA3LCAwLCBvdXRf
dGx2KSwKKwlTT0NfRE9VQkxFX1JfVExWKCJIZWFkc2V0IFBsYXliYWNrIFZvbHVtZSIsIFBNODYw
WF9IUzFfQ1RSTCwKKwkJCSBQTTg2MFhfSFMyX0NUUkwsIDAsIDcsIDAsIG91dF90bHYpLAorCVNP
Q19ET1VCTEVfUl9FWFRfVExWKCJIaWZpIExlZnQgUGxheWJhY2sgVm9sdW1lIiwKKwkJCSAgICAg
UE04NjBYX0hJRklMX0dBSU5fTEVGVCwKKwkJCSAgICAgUE04NjBYX0hJRklMX0dBSU5fUklHSFQs
IDAsIDYzLCAwLAorCQkJICAgICBzbmRfc29jX2dldF92b2xzd18ycl9vdXQsCisJCQkgICAgIHNu
ZF9zb2NfcHV0X3ZvbHN3XzJyX291dCwgZHBnYV90bHYpLAorCVNPQ19ET1VCTEVfUl9FWFRfVExW
KCJIaWZpIFJpZ2h0IFBsYXliYWNrIFZvbHVtZSIsCisJCQkgICAgIFBNODYwWF9ISUZJUl9HQUlO
X0xFRlQsCisJCQkgICAgIFBNODYwWF9ISUZJUl9HQUlOX1JJR0hULCAwLCA2MywgMCwKKwkJCSAg
ICAgc25kX3NvY19nZXRfdm9sc3dfMnJfb3V0LAorCQkJICAgICBzbmRfc29jX3B1dF92b2xzd18y
cl9vdXQsIGRwZ2FfdGx2KSwKKwlTT0NfRE9VQkxFX1JfRVhUX1RMVigiTG9maSBQbGF5YmFjayBW
b2x1bWUiLCBQTTg2MFhfTE9GSV9HQUlOX0xFRlQsCisJCQkgICAgIFBNODYwWF9MT0ZJX0dBSU5f
UklHSFQsIDAsIDYzLCAwLAorCQkJICAgICBzbmRfc29jX2dldF92b2xzd18ycl9vdXQsCisJCQkg
ICAgIHNuZF9zb2NfcHV0X3ZvbHN3XzJyX291dCwgZHBnYV90bHYpLAorCVNPQ19FTlVNKCJIZWFk
c2V0MSBPcGVyYXRpb25hbCBBbXBsaWZpZXIgQ3VycmVudCIsCisJCSBwbTg2MHhfaHMxX29wYW1w
X2VudW0pLAorCVNPQ19FTlVNKCJIZWFkc2V0MiBPcGVyYXRpb25hbCBBbXBsaWZpZXIgQ3VycmVu
dCIsCisJCSBwbTg2MHhfaHMyX29wYW1wX2VudW0pLAorCVNPQ19FTlVNKCJIZWFkc2V0MSBBbXBs
aWZpZXIgQ3VycmVudCIsIHBtODYweF9oczFfcGFfZW51bSksCisJU09DX0VOVU0oIkhlYWRzZXQy
IEFtcGxpZmllciBDdXJyZW50IiwgcG04NjB4X2hzMl9wYV9lbnVtKSwKKwlTT0NfRU5VTSgiTGlu
ZW91dDEgT3BlcmF0aW9uYWwgQW1wbGlmaWVyIEN1cnJlbnQiLAorCQkgcG04NjB4X2xvMV9vcGFt
cF9lbnVtKSwKKwlTT0NfRU5VTSgiTGluZW91dDIgT3BlcmF0aW9uYWwgQW1wbGlmaWVyIEN1cnJl
bnQiLAorCQkgcG04NjB4X2xvMl9vcGFtcF9lbnVtKSwKKwlTT0NfRU5VTSgiTGluZW91dDEgQW1w
bGlmaWVyIEN1cnJlbnQiLCBwbTg2MHhfbG8xX3BhX2VudW0pLAorCVNPQ19FTlVNKCJMaW5lb3V0
MiBBbXBsaWZpZXIgQ3VycmVudCIsIHBtODYweF9sbzJfcGFfZW51bSksCisJU09DX0VOVU0oIlNw
ZWFrZXIgT3BlcmF0aW9uYWwgQW1wbGlmaWVyIEN1cnJlbnQiLAorCQkgcG04NjB4X3Nwa19lYXJf
b3BhbXBfZW51bSksCisJU09DX0VOVU0oIlNwZWFrZXIgQW1wbGlmaWVyIEN1cnJlbnQiLCBwbTg2
MHhfc3BrX3BhX2VudW0pLAorCVNPQ19FTlVNKCJFYXJwaWVjZSBBbXBsaWZpZXIgQ3VycmVudCIs
IHBtODYweF9lYXJfcGFfZW51bSksCit9OworCisvKgorICogREFQTSBDb250cm9scworICovCisK
Ky8qIFBDTSBTd2l0Y2ggLyBQQ00gSW50ZXJmYWNlICovCitzdGF0aWMgY29uc3Qgc3RydWN0IHNu
ZF9rY29udHJvbF9uZXcgcGNtX3N3aXRjaF9jb250cm9scyA9CisJU09DX0RBUE1fU0lOR0xFKCJT
d2l0Y2giLCBQTTg2MFhfQURDX0VOXzIsIDAsIDEsIDApOworCisvKiBBVVgxIFN3aXRjaCAqLwor
c3RhdGljIGNvbnN0IHN0cnVjdCBzbmRfa2NvbnRyb2xfbmV3IGF1eDFfc3dpdGNoX2NvbnRyb2xz
ID0KKwlTT0NfREFQTV9TSU5HTEUoIlN3aXRjaCIsIFBNODYwWF9BTkFfVE9fQU5BLCA0LCAxLCAw
KTsKKworLyogQVVYMiBTd2l0Y2ggKi8KK3N0YXRpYyBjb25zdCBzdHJ1Y3Qgc25kX2tjb250cm9s
X25ldyBhdXgyX3N3aXRjaF9jb250cm9scyA9CisJU09DX0RBUE1fU0lOR0xFKCJTd2l0Y2giLCBQ
TTg2MFhfQU5BX1RPX0FOQSwgNSwgMSwgMCk7CisKKy8qIExlZnQgRXguIFBBIFN3aXRjaCAqLwor
c3RhdGljIGNvbnN0IHN0cnVjdCBzbmRfa2NvbnRyb2xfbmV3IGxlcGFfc3dpdGNoX2NvbnRyb2xz
ID0KKwlTT0NfREFQTV9TSU5HTEUoIlN3aXRjaCIsIFBNODYwWF9EQUNfRU5fMiwgMiwgMSwgMCk7
CisKKy8qIFJpZ2h0IEV4LiBQQSBTd2l0Y2ggKi8KK3N0YXRpYyBjb25zdCBzdHJ1Y3Qgc25kX2tj
b250cm9sX25ldyByZXBhX3N3aXRjaF9jb250cm9scyA9CisJU09DX0RBUE1fU0lOR0xFKCJTd2l0
Y2giLCBQTTg2MFhfREFDX0VOXzIsIDEsIDEsIDApOworCisvKiBQQ00gTXV4IC8gTXV4NyAqLwor
c3RhdGljIGNvbnN0IGNoYXIgKmFpZjFfdGV4dFtdID0geworCSJQQ00gTCIsICJQQ00gUiIsCit9
OworCitzdGF0aWMgY29uc3Qgc3RydWN0IHNvY19lbnVtIGFpZjFfZW51bSA9CisJU09DX0VOVU1f
U0lOR0xFKFBNODYwWF9QQ01fSUZBQ0VfMywgNiwgMiwgYWlmMV90ZXh0KTsKKworc3RhdGljIGNv
bnN0IHN0cnVjdCBzbmRfa2NvbnRyb2xfbmV3IGFpZjFfbXV4ID0KKwlTT0NfREFQTV9FTlVNKCJQ
Q00gTXV4IiwgYWlmMV9lbnVtKTsKKworLyogSTJTIE11eCAvIE11eDkgKi8KK3N0YXRpYyBjb25z
dCBjaGFyICppMnNfZGluX3RleHRbXSA9IHsKKwkiRElOIiwgIkRJTjEiLAorfTsKKworc3RhdGlj
IGNvbnN0IHN0cnVjdCBzb2NfZW51bSBpMnNfZGluX2VudW0gPQorCVNPQ19FTlVNX1NJTkdMRShQ
TTg2MFhfSTJTX0lGQUNFXzMsIDEsIDIsIGkyc19kaW5fdGV4dCk7CisKK3N0YXRpYyBjb25zdCBz
dHJ1Y3Qgc25kX2tjb250cm9sX25ldyBpMnNfZGluX211eCA9CisJU09DX0RBUE1fRU5VTSgiSTJT
IERJTiBNdXgiLCBpMnNfZGluX2VudW0pOworCisvKiBJMlMgTWljIE11eCAvIE11eDggKi8KK3N0
YXRpYyBjb25zdCBjaGFyICppMnNfbWljX3RleHRbXSA9IHsKKwkiRXggUEEiLCAiQURDIiwKK307
CisKK3N0YXRpYyBjb25zdCBzdHJ1Y3Qgc29jX2VudW0gaTJzX21pY19lbnVtID0KKwlTT0NfRU5V
TV9TSU5HTEUoUE04NjBYX0kyU19JRkFDRV8zLCA0LCAyLCBpMnNfbWljX3RleHQpOworCitzdGF0
aWMgY29uc3Qgc3RydWN0IHNuZF9rY29udHJvbF9uZXcgaTJzX21pY19tdXggPQorCVNPQ19EQVBN
X0VOVU0oIkkyUyBNaWMgTXV4IiwgaTJzX21pY19lbnVtKTsKKworLyogQURDTCBNdXggLyBNdXgy
ICovCitzdGF0aWMgY29uc3QgY2hhciAqYWRjbF90ZXh0W10gPSB7CisJIkFEQ1IiLCAiQURDTCIs
Cit9OworCitzdGF0aWMgY29uc3Qgc3RydWN0IHNvY19lbnVtIGFkY2xfZW51bSA9CisJU09DX0VO
VU1fU0lOR0xFKFBNODYwWF9QQ01fSUZBQ0VfMywgNCwgMiwgYWRjbF90ZXh0KTsKKworc3RhdGlj
IGNvbnN0IHN0cnVjdCBzbmRfa2NvbnRyb2xfbmV3IGFkY2xfbXV4ID0KKwlTT0NfREFQTV9FTlVN
KCJBREMgTGVmdCBNdXgiLCBhZGNsX2VudW0pOworCisvKiBBRENSIE11eCAvIE11eDMgKi8KK3N0
YXRpYyBjb25zdCBjaGFyICphZGNyX3RleHRbXSA9IHsKKwkiQURDTCIsICJBRENSIiwKK307CisK
K3N0YXRpYyBjb25zdCBzdHJ1Y3Qgc29jX2VudW0gYWRjcl9lbnVtID0KKwlTT0NfRU5VTV9TSU5H
TEUoUE04NjBYX1BDTV9JRkFDRV8zLCAyLCAyLCBhZGNyX3RleHQpOworCitzdGF0aWMgY29uc3Qg
c3RydWN0IHNuZF9rY29udHJvbF9uZXcgYWRjcl9tdXggPQorCVNPQ19EQVBNX0VOVU0oIkFEQyBS
aWdodCBNdXgiLCBhZGNyX2VudW0pOworCisvKiBBRENSIEVDIE11eCAvIE11eDYgKi8KK3N0YXRp
YyBjb25zdCBjaGFyICphZGNyX2VjX3RleHRbXSA9IHsKKwkiQURDUiIsICJFQyIsCit9OworCitz
dGF0aWMgY29uc3Qgc3RydWN0IHNvY19lbnVtIGFkY3JfZWNfZW51bSA9CisJU09DX0VOVU1fU0lO
R0xFKFBNODYwWF9BRENfRU5fMiwgMywgMiwgYWRjcl9lY190ZXh0KTsKKworc3RhdGljIGNvbnN0
IHN0cnVjdCBzbmRfa2NvbnRyb2xfbmV3IGFkY3JfZWNfbXV4ID0KKwlTT0NfREFQTV9FTlVNKCJB
RENSIEVDIE11eCIsIGFkY3JfZWNfZW51bSk7CisKKy8qIEVDIE11eCAvIE11eDQgKi8KK3N0YXRp
YyBjb25zdCBjaGFyICplY190ZXh0W10gPSB7CisJIkxlZnQiLCAiUmlnaHQiLCAiTGVmdCArIFJp
Z2h0IiwKK307CisKK3N0YXRpYyBjb25zdCBzdHJ1Y3Qgc29jX2VudW0gZWNfZW51bSA9CisJU09D
X0VOVU1fU0lOR0xFKFBNODYwWF9FQ19QQVRILCAxLCAzLCBlY190ZXh0KTsKKworc3RhdGljIGNv
bnN0IHN0cnVjdCBzbmRfa2NvbnRyb2xfbmV3IGVjX211eCA9CisJU09DX0RBUE1fRU5VTSgiRUMg
TXV4IiwgZWNfZW51bSk7CisKK3N0YXRpYyBjb25zdCBjaGFyICpkYWNfdGV4dFtdID0geworCSJO
byBpbnB1dCIsICJSaWdodCIsICJMZWZ0IiwgIk5vIGlucHV0IiwKK307CisKKy8qIERBQyBIZWFk
c2V0IDEgTXV4IC8gTXV4MTAgKi8KK3N0YXRpYyBjb25zdCBzdHJ1Y3Qgc29jX2VudW0gZGFjX2hz
MV9lbnVtID0KKwlTT0NfRU5VTV9TSU5HTEUoUE04NjBYX0FOQV9JTlBVVF9TRUxfMSwgMCwgNCwg
ZGFjX3RleHQpOworCitzdGF0aWMgY29uc3Qgc3RydWN0IHNuZF9rY29udHJvbF9uZXcgZGFjX2hz
MV9tdXggPQorCVNPQ19EQVBNX0VOVU0oIkRBQyBIUzEgTXV4IiwgZGFjX2hzMV9lbnVtKTsKKwor
LyogREFDIEhlYWRzZXQgMiBNdXggLyBNdXgxMSAqLworc3RhdGljIGNvbnN0IHN0cnVjdCBzb2Nf
ZW51bSBkYWNfaHMyX2VudW0gPQorCVNPQ19FTlVNX1NJTkdMRShQTTg2MFhfQU5BX0lOUFVUX1NF
TF8xLCAyLCA0LCBkYWNfdGV4dCk7CisKK3N0YXRpYyBjb25zdCBzdHJ1Y3Qgc25kX2tjb250cm9s
X25ldyBkYWNfaHMyX211eCA9CisJU09DX0RBUE1fRU5VTSgiREFDIEhTMiBNdXgiLCBkYWNfaHMy
X2VudW0pOworCisvKiBEQUMgTGluZW91dCAxIE11eCAvIE11eDEyICovCitzdGF0aWMgY29uc3Qg
c3RydWN0IHNvY19lbnVtIGRhY19sbzFfZW51bSA9CisJU09DX0VOVU1fU0lOR0xFKFBNODYwWF9B
TkFfSU5QVVRfU0VMXzEsIDQsIDQsIGRhY190ZXh0KTsKKworc3RhdGljIGNvbnN0IHN0cnVjdCBz
bmRfa2NvbnRyb2xfbmV3IGRhY19sbzFfbXV4ID0KKwlTT0NfREFQTV9FTlVNKCJEQUMgTE8xIE11
eCIsIGRhY19sbzFfZW51bSk7CisKKy8qIERBQyBMaW5lb3V0IDIgTXV4IC8gTXV4MTMgKi8KK3N0
YXRpYyBjb25zdCBzdHJ1Y3Qgc29jX2VudW0gZGFjX2xvMl9lbnVtID0KKwlTT0NfRU5VTV9TSU5H
TEUoUE04NjBYX0FOQV9JTlBVVF9TRUxfMSwgNiwgNCwgZGFjX3RleHQpOworCitzdGF0aWMgY29u
c3Qgc3RydWN0IHNuZF9rY29udHJvbF9uZXcgZGFjX2xvMl9tdXggPQorCVNPQ19EQVBNX0VOVU0o
IkRBQyBMTzIgTXV4IiwgZGFjX2xvMl9lbnVtKTsKKworLyogREFDIFNwZWFya2VyIEVhcnBob25l
IE11eCAvIE11eDE0ICovCitzdGF0aWMgY29uc3Qgc3RydWN0IHNvY19lbnVtIGRhY19zcGtfZWFy
X2VudW0gPQorCVNPQ19FTlVNX1NJTkdMRShQTTg2MFhfQU5BX0lOUFVUX1NFTF8yLCAwLCA0LCBk
YWNfdGV4dCk7CisKK3N0YXRpYyBjb25zdCBzdHJ1Y3Qgc25kX2tjb250cm9sX25ldyBkYWNfc3Br
X2Vhcl9tdXggPQorCVNPQ19EQVBNX0VOVU0oIkRBQyBTUCBNdXgiLCBkYWNfc3BrX2Vhcl9lbnVt
KTsKKworLyogSGVhZHNldCAxIE11eCAvIE11eDE1ICovCitzdGF0aWMgY29uc3QgY2hhciAqaW5f
dGV4dFtdID0geworCSJEaWdpdGFsIiwgIkFuYWxvZyIsCit9OworCitzdGF0aWMgY29uc3Qgc3Ry
dWN0IHNvY19lbnVtIGhzMV9lbnVtID0KKwlTT0NfRU5VTV9TSU5HTEUoUE04NjBYX0FOQV9UT19B
TkEsIDAsIDIsIGluX3RleHQpOworCitzdGF0aWMgY29uc3Qgc3RydWN0IHNuZF9rY29udHJvbF9u
ZXcgaHMxX211eCA9CisJU09DX0RBUE1fRU5VTSgiSGVhZHNldDEgTXV4IiwgaHMxX2VudW0pOwor
CisvKiBIZWFkc2V0IDIgTXV4IC8gTXV4MTYgKi8KK3N0YXRpYyBjb25zdCBzdHJ1Y3Qgc29jX2Vu
dW0gaHMyX2VudW0gPQorCVNPQ19FTlVNX1NJTkdMRShQTTg2MFhfQU5BX1RPX0FOQSwgMSwgMiwg
aW5fdGV4dCk7CisKK3N0YXRpYyBjb25zdCBzdHJ1Y3Qgc25kX2tjb250cm9sX25ldyBoczJfbXV4
ID0KKwlTT0NfREFQTV9FTlVNKCJIZWFkc2V0MiBNdXgiLCBoczJfZW51bSk7CisKKy8qIExpbmVv
dXQgMSBNdXggLyBNdXgxNyAqLworc3RhdGljIGNvbnN0IHN0cnVjdCBzb2NfZW51bSBsbzFfZW51
bSA9CisJU09DX0VOVU1fU0lOR0xFKFBNODYwWF9BTkFfVE9fQU5BLCAyLCAyLCBpbl90ZXh0KTsK
Kworc3RhdGljIGNvbnN0IHN0cnVjdCBzbmRfa2NvbnRyb2xfbmV3IGxvMV9tdXggPQorCVNPQ19E
QVBNX0VOVU0oIkxpbmVvdXQxIE11eCIsIGxvMV9lbnVtKTsKKworLyogTGluZW91dCAyIE11eCAv
IE11eDE4ICovCitzdGF0aWMgY29uc3Qgc3RydWN0IHNvY19lbnVtIGxvMl9lbnVtID0KKwlTT0Nf
RU5VTV9TSU5HTEUoUE04NjBYX0FOQV9UT19BTkEsIDMsIDIsIGluX3RleHQpOworCitzdGF0aWMg
Y29uc3Qgc3RydWN0IHNuZF9rY29udHJvbF9uZXcgbG8yX211eCA9CisJU09DX0RBUE1fRU5VTSgi
TGluZW91dDIgTXV4IiwgbG8yX2VudW0pOworCisvKiBTcGVha2VyIEVhcnBpZWNlIERlbXV4ICov
CitzdGF0aWMgY29uc3QgY2hhciAqc3BrX3RleHRbXSA9IHsKKwkiRWFycGllY2UiLCAiU3BlYWtl
ciIsCit9OworCitzdGF0aWMgY29uc3Qgc3RydWN0IHNvY19lbnVtIHNwa19lbnVtID0KKwlTT0Nf
RU5VTV9TSU5HTEUoUE04NjBYX0FOQV9UT19BTkEsIDYsIDIsIHNwa190ZXh0KTsKKworc3RhdGlj
IGNvbnN0IHN0cnVjdCBzbmRfa2NvbnRyb2xfbmV3IHNwa19kZW11eCA9CisJU09DX0RBUE1fRU5V
TSgiU3BlYWtlciBFYXJwaWVjZSBEZW11eCIsIHNwa19lbnVtKTsKKworLyogTUlDIE11eCAvIE11
eDEgKi8KK3N0YXRpYyBjb25zdCBjaGFyICptaWNfdGV4dFtdID0geworCSJNaWMgMSIsICJNaWMg
MiIsCit9OworCitzdGF0aWMgY29uc3Qgc3RydWN0IHNvY19lbnVtIG1pY19lbnVtID0KKwlTT0Nf
RU5VTV9TSU5HTEUoUE04NjBYX0FEQ19BTkFfNCwgNCwgMiwgbWljX3RleHQpOworCitzdGF0aWMg
Y29uc3Qgc3RydWN0IHNuZF9rY29udHJvbF9uZXcgbWljX211eCA9CisJU09DX0RBUE1fRU5VTSgi
TUlDIE11eCIsIG1pY19lbnVtKTsKKworc3RhdGljIGNvbnN0IHN0cnVjdCBzbmRfc29jX2RhcG1f
d2lkZ2V0IHBtODYweF9kYXBtX3dpZGdldHNbXSA9IHsKKwlTTkRfU09DX0RBUE1fQUlGX0lOKCJQ
Q00gU0RJIiwgIlBDTSBQbGF5YmFjayIsIDAsCisJCQkgICAgUE04NjBYX0FEQ19FTl8yLCAwLCAw
KSwKKwlTTkRfU09DX0RBUE1fQUlGX09VVCgiUENNIFNETyIsICJQQ00gQ2FwdHVyZSIsIDAsCisJ
CQkgICAgIFBNODYwWF9QQ01fSUZBQ0VfMywgMSwgMSksCisKKworCVNORF9TT0NfREFQTV9BSUZf
SU4oIkkyUyBESU4iLCAiSTJTIFBsYXliYWNrIiwgMCwKKwkJCSAgICBQTTg2MFhfREFDX0VOXzIs
IDAsIDApLAorCVNORF9TT0NfREFQTV9BSUZfSU4oIkkyUyBESU4xIiwgIkkyUyBQbGF5YmFjayIs
IDAsCisJCQkgICAgUE04NjBYX0RBQ19FTl8yLCAwLCAwKSwKKwlTTkRfU09DX0RBUE1fQUlGX09V
VCgiSTJTIERPVVQiLCAiSTJTIENhcHR1cmUiLCAwLAorCQkJICAgICBQTTg2MFhfSTJTX0lGQUNF
XzMsIDUsIDEpLAorCVNORF9TT0NfREFQTV9NVVgoIkkyUyBNaWMgTXV4IiwgU05EX1NPQ19OT1BN
LCAwLCAwLCAmaTJzX21pY19tdXgpLAorCVNORF9TT0NfREFQTV9NVVgoIkFEQyBMZWZ0IE11eCIs
IFNORF9TT0NfTk9QTSwgMCwgMCwgJmFkY2xfbXV4KSwKKwlTTkRfU09DX0RBUE1fTVVYKCJBREMg
UmlnaHQgTXV4IiwgU05EX1NPQ19OT1BNLCAwLCAwLCAmYWRjcl9tdXgpLAorCVNORF9TT0NfREFQ
TV9NVVgoIkVDIE11eCIsIFNORF9TT0NfTk9QTSwgMCwgMCwgJmVjX211eCksCisJU05EX1NPQ19E
QVBNX01VWCgiQURDUiBFQyBNdXgiLCBTTkRfU09DX05PUE0sIDAsIDAsICZhZGNyX2VjX211eCks
CisJU05EX1NPQ19EQVBNX1NXSVRDSCgiTGVmdCBFUEEiLCBTTkRfU09DX05PUE0sIDAsIDAsCisJ
CQkgICAgJmxlcGFfc3dpdGNoX2NvbnRyb2xzKSwKKwlTTkRfU09DX0RBUE1fU1dJVENIKCJSaWdo
dCBFUEEiLCBTTkRfU09DX05PUE0sIDAsIDAsCisJCQkgICAgJnJlcGFfc3dpdGNoX2NvbnRyb2xz
KSwKKworCVNORF9TT0NfREFQTV9BRENfRSgiTGVmdCBBREMiLCBOVUxMLCBTTkRfU09DX05PUE0s
IDAsIDAsCisJCQkgICBwbTg2MHhfYWRjX2V2ZW50LAorCQkJICAgU05EX1NPQ19EQVBNX1BSRV9Q
TVUgfCBTTkRfU09DX0RBUE1fUFJFX1BNRCksCisJU05EX1NPQ19EQVBNX0FEQ19FKCJSaWdodCBB
REMiLCBOVUxMLCBTTkRfU09DX05PUE0sIDAsIDAsCisJCQkgICBwbTg2MHhfYWRjX2V2ZW50LAor
CQkJICAgU05EX1NPQ19EQVBNX1BSRV9QTVUgfCBTTkRfU09DX0RBUE1fUFJFX1BNRCksCisKKwlT
TkRfU09DX0RBUE1fU1dJVENIKCJBVVgxIFN3aXRjaCIsIFNORF9TT0NfTk9QTSwgMCwgMCwKKwkJ
CSAgICAmYXV4MV9zd2l0Y2hfY29udHJvbHMpLAorCVNORF9TT0NfREFQTV9TV0lUQ0goIkFVWDIg
U3dpdGNoIiwgU05EX1NPQ19OT1BNLCAwLCAwLAorCQkJICAgICZhdXgyX3N3aXRjaF9jb250cm9s
cyksCisKKwlTTkRfU09DX0RBUE1fTVVYKCJNSUMgTXV4IiwgU05EX1NPQ19OT1BNLCAwLCAwLCAm
bWljX211eCksCisJU05EX1NPQ19EQVBNX01JQ0JJQVNfRSgiTWljMSBCaWFzIiwgU05EX1NPQ19O
T1BNLCAwLCAwLAorCQkJICAgICAgICZwbTg2MHhfbWljMV9ldmVudCwKKwkJCSAgICAgICBTTkRf
U09DX0RBUE1fUE9TVF9QTVUgfCBTTkRfU09DX0RBUE1fUFJFX1BNRCksCisJU05EX1NPQ19EQVBN
X01JQ0JJQVMoIk1pYzMgQmlhcyIsIFBNODYwWF9BRENfQU5BXzEsIDcsIDApLAorCVNORF9TT0Nf
REFQTV9QR0EoIk1JQzEgVm9sdW1lIiwgUE04NjBYX0FEQ19FTl8xLCAyLCAwLCBOVUxMLCAwKSwK
KwlTTkRfU09DX0RBUE1fUEdBKCJNSUMzIFZvbHVtZSIsIFBNODYwWF9BRENfRU5fMSwgMywgMCwg
TlVMTCwgMCksCisJU05EX1NPQ19EQVBNX1BHQSgiQVVYMSBWb2x1bWUiLCBQTTg2MFhfQURDX0VO
XzEsIDQsIDAsIE5VTEwsIDApLAorCVNORF9TT0NfREFQTV9QR0EoIkFVWDIgVm9sdW1lIiwgUE04
NjBYX0FEQ19FTl8xLCA1LCAwLCBOVUxMLCAwKSwKKwlTTkRfU09DX0RBUE1fUEdBKCJTaWRldG9u
ZSBQR0EiLCBQTTg2MFhfQURDX0VOXzIsIDEsIDAsIE5VTEwsIDApLAorCVNORF9TT0NfREFQTV9Q
R0EoIkxvZmkgUEdBIiwgUE04NjBYX0FEQ19FTl8yLCAyLCAwLCBOVUxMLCAwKSwKKworCVNORF9T
T0NfREFQTV9JTlBVVCgiQVVYMSIpLAorCVNORF9TT0NfREFQTV9JTlBVVCgiQVVYMiIpLAorCVNO
RF9TT0NfREFQTV9JTlBVVCgiTUlDMVAiKSwKKwlTTkRfU09DX0RBUE1fSU5QVVQoIk1JQzFOIiks
CisJU05EX1NPQ19EQVBNX0lOUFVUKCJNSUMyUCIpLAorCVNORF9TT0NfREFQTV9JTlBVVCgiTUlD
Mk4iKSwKKwlTTkRfU09DX0RBUE1fSU5QVVQoIk1JQzNQIiksCisJU05EX1NPQ19EQVBNX0lOUFVU
KCJNSUMzTiIpLAorCisJU05EX1NPQ19EQVBNX0RBQ19FKCJMZWZ0IERBQyIsIE5VTEwsIFNORF9T
T0NfTk9QTSwgMCwgMCwKKwkJCSAgIHBtODYweF9kYWNfZXZlbnQsCisJCQkgICBTTkRfU09DX0RB
UE1fUFJFX1BNVSB8IFNORF9TT0NfREFQTV9QUkVfUE1EKSwKKwlTTkRfU09DX0RBUE1fREFDX0Uo
IlJpZ2h0IERBQyIsIE5VTEwsIFNORF9TT0NfTk9QTSwgMCwgMCwKKwkJCSAgIHBtODYweF9kYWNf
ZXZlbnQsCisJCQkgICBTTkRfU09DX0RBUE1fUFJFX1BNVSB8IFNORF9TT0NfREFQTV9QUkVfUE1E
KSwKKworCVNORF9TT0NfREFQTV9NVVgoIkkyUyBESU4gTXV4IiwgU05EX1NPQ19OT1BNLCAwLCAw
LCAmaTJzX2Rpbl9tdXgpLAorCVNORF9TT0NfREFQTV9NVVgoIkRBQyBIUzEgTXV4IiwgU05EX1NP
Q19OT1BNLCAwLCAwLCAmZGFjX2hzMV9tdXgpLAorCVNORF9TT0NfREFQTV9NVVgoIkRBQyBIUzIg
TXV4IiwgU05EX1NPQ19OT1BNLCAwLCAwLCAmZGFjX2hzMl9tdXgpLAorCVNORF9TT0NfREFQTV9N
VVgoIkRBQyBMTzEgTXV4IiwgU05EX1NPQ19OT1BNLCAwLCAwLCAmZGFjX2xvMV9tdXgpLAorCVNO
RF9TT0NfREFQTV9NVVgoIkRBQyBMTzIgTXV4IiwgU05EX1NPQ19OT1BNLCAwLCAwLCAmZGFjX2xv
Ml9tdXgpLAorCVNORF9TT0NfREFQTV9NVVgoIkRBQyBTUCBNdXgiLCBTTkRfU09DX05PUE0sIDAs
IDAsICZkYWNfc3BrX2Vhcl9tdXgpLAorCVNORF9TT0NfREFQTV9NVVgoIkhlYWRzZXQxIE11eCIs
IFNORF9TT0NfTk9QTSwgMCwgMCwgJmhzMV9tdXgpLAorCVNORF9TT0NfREFQTV9NVVgoIkhlYWRz
ZXQyIE11eCIsIFNORF9TT0NfTk9QTSwgMCwgMCwgJmhzMl9tdXgpLAorCVNORF9TT0NfREFQTV9N
VVgoIkxpbmVvdXQxIE11eCIsIFNORF9TT0NfTk9QTSwgMCwgMCwgJmxvMV9tdXgpLAorCVNORF9T
T0NfREFQTV9NVVgoIkxpbmVvdXQyIE11eCIsIFNORF9TT0NfTk9QTSwgMCwgMCwgJmxvMl9tdXgp
LAorCVNORF9TT0NfREFQTV9NVVgoIlNwZWFrZXIgRWFycGllY2UgRGVtdXgiLCBTTkRfU09DX05P
UE0sIDAsIDAsCisJCQkgJnNwa19kZW11eCksCisKKworCVNORF9TT0NfREFQTV9QR0EoIkhlYWRz
ZXQxIFBHQSIsIFBNODYwWF9EQUNfRU5fMSwgMCwgMCwgTlVMTCwgMCksCisJU05EX1NPQ19EQVBN
X1BHQSgiSGVhZHNldDIgUEdBIiwgUE04NjBYX0RBQ19FTl8xLCAxLCAwLCBOVUxMLCAwKSwKKwlT
TkRfU09DX0RBUE1fT1VUUFVUKCJIUzEiKSwKKwlTTkRfU09DX0RBUE1fT1VUUFVUKCJIUzIiKSwK
KwlTTkRfU09DX0RBUE1fUEdBKCJMaW5lb3V0MSBQR0EiLCBQTTg2MFhfREFDX0VOXzEsIDIsIDAs
IE5VTEwsIDApLAorCVNORF9TT0NfREFQTV9QR0EoIkxpbmVvdXQyIFBHQSIsIFBNODYwWF9EQUNf
RU5fMSwgMywgMCwgTlVMTCwgMCksCisJU05EX1NPQ19EQVBNX09VVFBVVCgiTElORU9VVDEiKSwK
KwlTTkRfU09DX0RBUE1fT1VUUFVUKCJMSU5FT1VUMiIpLAorCVNORF9TT0NfREFQTV9QR0EoIkVh
cnBpZWNlIFBHQSIsIFBNODYwWF9EQUNfRU5fMSwgNCwgMCwgTlVMTCwgMCksCisJU05EX1NPQ19E
QVBNX09VVFBVVCgiRUFSUCIpLAorCVNORF9TT0NfREFQTV9PVVRQVVQoIkVBUk4iKSwKKwlTTkRf
U09DX0RBUE1fUEdBKCJTcGVha2VyIFBHQSIsIFBNODYwWF9EQUNfRU5fMSwgNSwgMCwgTlVMTCwg
MCksCisJU05EX1NPQ19EQVBNX09VVFBVVCgiTFNQIiksCisJU05EX1NPQ19EQVBNX09VVFBVVCgi
TFNOIiksCisJU05EX1NPQ19EQVBNX1JFRyhzbmRfc29jX2RhcG1fc3VwcGx5LCAiVkNPREVDIiwg
UE04NjBYX0FVRElPX1NVUFBMSUVTXzIsCisJCQkgMCwgU1VQUExZX01BU0ssIFNVUFBMWV9NQVNL
LCAwKSwKKworCVNORF9TT0NfREFQTV9QT1NUKCJSU1lOQyIsIHBtODYweF9yc3luY19ldmVudCks
Cit9OworCitzdGF0aWMgY29uc3Qgc3RydWN0IHNuZF9zb2NfZGFwbV9yb3V0ZSBhdWRpb19tYXBb
XSA9IHsKKwkvKiBzdXBwbHkgKi8KKwl7IkxlZnQgREFDIiwgTlVMTCwgIlZDT0RFQyJ9LAorCXsi
UmlnaHQgREFDIiwgTlVMTCwgIlZDT0RFQyJ9LAorCXsiTGVmdCBBREMiLCBOVUxMLCAiVkNPREVD
In0sCisJeyJSaWdodCBBREMiLCBOVUxMLCAiVkNPREVDIn0sCisKKwkvKiBQQ00vQUlGMSBJbnB1
dHMgKi8KKwl7IlBDTSBTRE8iLCBOVUxMLCAiQURDIExlZnQgTXV4In0sCisJeyJQQ00gU0RPIiwg
TlVMTCwgIkFEQ1IgRUMgTXV4In0sCisKKwkvKiBQQ00vQUZJMiBPdXRwdXRzICovCisJeyJMb2Zp
IFBHQSIsIE5VTEwsICJQQ00gU0RJIn0sCisJeyJMb2ZpIFBHQSIsIE5VTEwsICJTaWRldG9uZSBQ
R0EifSwKKwl7IkxlZnQgREFDIiwgTlVMTCwgIkxvZmkgUEdBIn0sCisJeyJSaWdodCBEQUMiLCBO
VUxMLCAiTG9maSBQR0EifSwKKworCS8qIEkyUy9BSUYyIElucHV0cyAqLworCXsiTUlDIE11eCIs
ICJNaWMgMSIsICJNSUMxUCJ9LAorCXsiTUlDIE11eCIsICJNaWMgMSIsICJNSUMxTiJ9LAorCXsi
TUlDIE11eCIsICJNaWMgMiIsICJNSUMyUCJ9LAorCXsiTUlDIE11eCIsICJNaWMgMiIsICJNSUMy
TiJ9LAorCXsiTUlDMSBWb2x1bWUiLCBOVUxMLCAiTUlDIE11eCJ9LAorCXsiTUlDMyBWb2x1bWUi
LCBOVUxMLCAiTUlDM1AifSwKKwl7Ik1JQzMgVm9sdW1lIiwgTlVMTCwgIk1JQzNOIn0sCisJeyJM
ZWZ0IEFEQyIsIE5VTEwsICJNSUMxIFZvbHVtZSJ9LAorCXsiUmlnaHQgQURDIiwgTlVMTCwgIk1J
QzMgVm9sdW1lIn0sCisJeyJBREMgTGVmdCBNdXgiLCAiQURDUiIsICJSaWdodCBBREMifSwKKwl7
IkFEQyBMZWZ0IE11eCIsICJBRENMIiwgIkxlZnQgQURDIn0sCisJeyJBREMgUmlnaHQgTXV4Iiwg
IkFEQ0wiLCAiTGVmdCBBREMifSwKKwl7IkFEQyBSaWdodCBNdXgiLCAiQURDUiIsICJSaWdodCBB
REMifSwKKwl7IkxlZnQgRVBBIiwgIlN3aXRjaCIsICJMZWZ0IERBQyJ9LAorCXsiUmlnaHQgRVBB
IiwgIlN3aXRjaCIsICJSaWdodCBEQUMifSwKKwl7IkVDIE11eCIsICJMZWZ0IiwgIkxlZnQgREFD
In0sCisJeyJFQyBNdXgiLCAiUmlnaHQiLCAiUmlnaHQgREFDIn0sCisJeyJFQyBNdXgiLCAiTGVm
dCArIFJpZ2h0IiwgIkxlZnQgREFDIn0sCisJeyJFQyBNdXgiLCAiTGVmdCArIFJpZ2h0IiwgIlJp
Z2h0IERBQyJ9LAorCXsiQURDUiBFQyBNdXgiLCAiQURDUiIsICJBREMgUmlnaHQgTXV4In0sCisJ
eyJBRENSIEVDIE11eCIsICJFQyIsICJFQyBNdXgifSwKKwl7IkkyUyBNaWMgTXV4IiwgIkV4IFBB
IiwgIkxlZnQgRVBBIn0sCisJeyJJMlMgTWljIE11eCIsICJFeCBQQSIsICJSaWdodCBFUEEifSwK
Kwl7IkkyUyBNaWMgTXV4IiwgIkFEQyIsICJBREMgTGVmdCBNdXgifSwKKwl7IkkyUyBNaWMgTXV4
IiwgIkFEQyIsICJBRENSIEVDIE11eCJ9LAorCXsiSTJTIERPVVQiLCBOVUxMLCAiSTJTIE1pYyBN
dXgifSwKKworCS8qIEkyUy9BSUYyIE91dHB1dHMgKi8KKwl7IkkyUyBESU4gTXV4IiwgIkRJTiIs
ICJJMlMgRElOIn0sCisJeyJJMlMgRElOIE11eCIsICJESU4xIiwgIkkyUyBESU4xIn0sCisJeyJM
ZWZ0IERBQyIsIE5VTEwsICJJMlMgRElOIE11eCJ9LAorCXsiUmlnaHQgREFDIiwgTlVMTCwgIkky
UyBESU4gTXV4In0sCisJeyJEQUMgSFMxIE11eCIsICJMZWZ0IiwgIkxlZnQgREFDIn0sCisJeyJE
QUMgSFMxIE11eCIsICJSaWdodCIsICJSaWdodCBEQUMifSwKKwl7IkRBQyBIUzIgTXV4IiwgIkxl
ZnQiLCAiTGVmdCBEQUMifSwKKwl7IkRBQyBIUzIgTXV4IiwgIlJpZ2h0IiwgIlJpZ2h0IERBQyJ9
LAorCXsiREFDIExPMSBNdXgiLCAiTGVmdCIsICJMZWZ0IERBQyJ9LAorCXsiREFDIExPMSBNdXgi
LCAiUmlnaHQiLCAiUmlnaHQgREFDIn0sCisJeyJEQUMgTE8yIE11eCIsICJMZWZ0IiwgIkxlZnQg
REFDIn0sCisJeyJEQUMgTE8yIE11eCIsICJSaWdodCIsICJSaWdodCBEQUMifSwKKwl7IkhlYWRz
ZXQxIE11eCIsICJEaWdpdGFsIiwgIkRBQyBIUzEgTXV4In0sCisJeyJIZWFkc2V0MiBNdXgiLCAi
RGlnaXRhbCIsICJEQUMgSFMyIE11eCJ9LAorCXsiTGluZW91dDEgTXV4IiwgIkRpZ2l0YWwiLCAi
REFDIExPMSBNdXgifSwKKwl7IkxpbmVvdXQyIE11eCIsICJEaWdpdGFsIiwgIkRBQyBMTzIgTXV4
In0sCisJeyJIZWFkc2V0MSBQR0EiLCBOVUxMLCAiSGVhZHNldDEgTXV4In0sCisJeyJIZWFkc2V0
MiBQR0EiLCBOVUxMLCAiSGVhZHNldDIgTXV4In0sCisJeyJMaW5lb3V0MSBQR0EiLCBOVUxMLCAi
TGluZW91dDEgTXV4In0sCisJeyJMaW5lb3V0MiBQR0EiLCBOVUxMLCAiTGluZW91dDIgTXV4In0s
CisJeyJEQUMgU1AgTXV4IiwgIkxlZnQiLCAiTGVmdCBEQUMifSwKKwl7IkRBQyBTUCBNdXgiLCAi
UmlnaHQiLCAiUmlnaHQgREFDIn0sCisJeyJTcGVha2VyIEVhcnBpZWNlIERlbXV4IiwgIlNwZWFr
ZXIiLCAiREFDIFNQIE11eCJ9LAorCXsiU3BlYWtlciBQR0EiLCBOVUxMLCAiU3BlYWtlciBFYXJw
aWVjZSBEZW11eCJ9LAorCXsiRWFycGllY2UgUEdBIiwgTlVMTCwgIlNwZWFrZXIgRWFycGllY2Ug
RGVtdXgifSwKKworCXsiSFMxIiwgTlVMTCwgIkhlYWRzZXQxIFBHQSJ9LAorCXsiSFMyIiwgTlVM
TCwgIkhlYWRzZXQyIFBHQSJ9LAorCXsiTElORU9VVDEiLCBOVUxMLCAiTGluZW91dDEgUEdBIn0s
CisJeyJMSU5FT1VUMiIsIE5VTEwsICJMaW5lb3V0MiBQR0EifSwKKwl7IkxTUCIsIE5VTEwsICJT
cGVha2VyIFBHQSJ9LAorCXsiTFNOIiwgTlVMTCwgIlNwZWFrZXIgUEdBIn0sCisJeyJFQVJQIiwg
TlVMTCwgIkVhcnBpZWNlIFBHQSJ9LAorCXsiRUFSTiIsIE5VTEwsICJFYXJwaWVjZSBQR0EifSwK
K307CisKK3N0YXRpYyBpbnQgcG04NjB4X2RpZ2l0YWxfbXV0ZShzdHJ1Y3Qgc25kX3NvY19kYWkg
KmNvZGVjX2RhaSwgaW50IG11dGUpCit7CisJc3RydWN0IHNuZF9zb2NfY29kZWMgKmNvZGVjID0g
Y29kZWNfZGFpLT5jb2RlYzsKKwlpbnQgZGF0YSA9IDA7CisKKwlpZiAobXV0ZSkKKwkJZGF0YSA9
IERBQ19NVVRFOworCXNuZF9zb2NfdXBkYXRlX2JpdHMoY29kZWMsIFBNODYwWF9EQUNfT0ZGU0VU
LCBEQUNfTVVURSwgZGF0YSk7CisJc25kX3NvY191cGRhdGVfYml0cyhjb2RlYywgUE04NjBYX0VB
Ul9DVFJMXzIsCisJCQkgICAgUlNZTkNfQ0hBTkdFLCBSU1lOQ19DSEFOR0UpOworCXJldHVybiAw
OworfQorCitzdGF0aWMgaW50IHNldF9kYWlfZm10KHN0cnVjdCBwbTg2MHhfcHJpdiAqcG04NjB4
LCB1bnNpZ25lZCBpbnQgZm10LAorCQkgICAgICAgdW5zaWduZWQgY2hhciAqaW5mLCB1bnNpZ25l
ZCBjaGFyICptYXNrKQoreworCSptYXNrIHw9IFBDTV9JTkYyX0JDTEsgfCBQQ01fSU5GMl9GUyB8
IFBDTV9JTkYyX01BU1RFUjsKKworCS8qIHNldCBtYXN0ZXIvc2xhdmUgYXVkaW8gaW50ZXJmYWNl
ICovCisJc3dpdGNoIChmbXQgJiBTTkRfU09DX0RBSUZNVF9NQVNURVJfTUFTSykgeworCWNhc2Ug
U05EX1NPQ19EQUlGTVRfQ0JNX0NGTToKKwljYXNlIFNORF9TT0NfREFJRk1UX0NCTV9DRlM6CisJ
CWlmIChwbTg2MHgtPmRpciA9PSBQTTg2MFhfQ0xLX0RJUl9PVVQpCisJCQkqaW5mIHw9IFBDTV9J
TkYyX01BU1RFUjsKKwkJZWxzZQorCQkJcmV0dXJuIC1FSU5WQUw7CisJCWJyZWFrOworCWNhc2Ug
U05EX1NPQ19EQUlGTVRfQ0JTX0NGUzoKKwkJaWYgKHBtODYweC0+ZGlyID09IFBNODYwWF9DTEtf
RElSX0lOKQorCQkJKmluZiAmPSB+UENNX0lORjJfTUFTVEVSOworCQllbHNlCisJCQlyZXR1cm4g
LUVJTlZBTDsKKwkJYnJlYWs7CisJZGVmYXVsdDoKKwkJcmV0dXJuIC1FSU5WQUw7CisJfQorCisJ
c3dpdGNoIChmbXQgJiBTTkRfU09DX0RBSUZNVF9GT1JNQVRfTUFTSykgeworCWNhc2UgU05EX1NP
Q19EQUlGTVRfSTJTOgorCQkqaW5mIHw9IFBDTV9FWEFDVF9JMlM7CisJCWJyZWFrOworCWRlZmF1
bHQ6CisJCXJldHVybiAtRUlOVkFMOworCX0KKwkqbWFzayB8PSBQQ01fTU9ERV9NQVNLOworCXJl
dHVybiAwOworfQorCitzdGF0aWMgaW50IHBtODYweF9wY21faHdfcGFyYW1zKHN0cnVjdCBzbmRf
cGNtX3N1YnN0cmVhbSAqc3Vic3RyZWFtLAorCQkJCXN0cnVjdCBzbmRfcGNtX2h3X3BhcmFtcyAq
cGFyYW1zLAorCQkJCXN0cnVjdCBzbmRfc29jX2RhaSAqZGFpKQoreworCXN0cnVjdCBzbmRfc29j
X2NvZGVjICpjb2RlYyA9IGRhaS0+Y29kZWM7CisJdW5zaWduZWQgY2hhciBpbmYgPSAwLCBtYXNr
ID0gMDsKKworCS8qIGJpdCBzaXplICovCisJc3dpdGNoIChwYXJhbXNfZm9ybWF0KHBhcmFtcykp
IHsKKwljYXNlIFNORFJWX1BDTV9GT1JNQVRfUzE2X0xFOgorCQlpbmYgJj0gflBDTV9JTkYyXzE4
V0w7CisJCWJyZWFrOworCWNhc2UgU05EUlZfUENNX0ZPUk1BVF9TMThfM0xFOgorCQlpbmYgfD0g
UENNX0lORjJfMThXTDsKKwkJYnJlYWs7CisJZGVmYXVsdDoKKwkJcmV0dXJuIC1FSU5WQUw7CisJ
fQorCW1hc2sgfD0gUENNX0lORjJfMThXTDsKKwlzbmRfc29jX3VwZGF0ZV9iaXRzKGNvZGVjLCBQ
TTg2MFhfUENNX0lGQUNFXzIsIG1hc2ssIGluZik7CisKKwkvKiBzYW1wbGUgcmF0ZSAqLworCXN3
aXRjaCAocGFyYW1zX3JhdGUocGFyYW1zKSkgeworCWNhc2UgODAwMDoKKwkJaW5mID0gMDsKKwkJ
YnJlYWs7CisJY2FzZSAxNjAwMDoKKwkJaW5mID0gMzsKKwkJYnJlYWs7CisJY2FzZSAzMjAwMDoK
KwkJaW5mID0gNjsKKwkJYnJlYWs7CisJY2FzZSA0ODAwMDoKKwkJaW5mID0gODsKKwkJYnJlYWs7
CisJZGVmYXVsdDoKKwkJcmV0dXJuIC1FSU5WQUw7CisJfQorCXNuZF9zb2NfdXBkYXRlX2JpdHMo
Y29kZWMsIFBNODYwWF9QQ01fUkFURSwgMHgwZiwgaW5mKTsKKworCXJldHVybiAwOworfQorCitz
dGF0aWMgaW50IHBtODYweF9wY21fc2V0X2RhaV9mbXQoc3RydWN0IHNuZF9zb2NfZGFpICpjb2Rl
Y19kYWksCisJCQkJICB1bnNpZ25lZCBpbnQgZm10KQoreworCXN0cnVjdCBzbmRfc29jX2NvZGVj
ICpjb2RlYyA9IGNvZGVjX2RhaS0+Y29kZWM7CisJc3RydWN0IHBtODYweF9wcml2ICpwbTg2MHgg
PSBzbmRfc29jX2NvZGVjX2dldF9kcnZkYXRhKGNvZGVjKTsKKwl1bnNpZ25lZCBjaGFyIGluZiA9
IDAsIG1hc2sgPSAwOworCWludCByZXQ7CisKKwlyZXQgPSBzZXRfZGFpX2ZtdChwbTg2MHgsIGZt
dCwgJmluZiwgJm1hc2spOworCWlmICghcmV0KQorCQlzbmRfc29jX3VwZGF0ZV9iaXRzKGNvZGVj
LCBQTTg2MFhfUENNX0lGQUNFXzIsIG1hc2ssIGluZik7CisJcmV0dXJuIHJldDsKK30KKworc3Rh
dGljIGludCBwbTg2MHhfc2V0X2RhaV9zeXNjbGsoc3RydWN0IHNuZF9zb2NfZGFpICpjb2RlY19k
YWksCisJCQkJIGludCBjbGtfaWQsIHVuc2lnbmVkIGludCBmcmVxLCBpbnQgZGlyKQoreworCXN0
cnVjdCBzbmRfc29jX2NvZGVjICpjb2RlYyA9IGNvZGVjX2RhaS0+Y29kZWM7CisJc3RydWN0IHBt
ODYweF9wcml2ICpwbTg2MHggPSBzbmRfc29jX2NvZGVjX2dldF9kcnZkYXRhKGNvZGVjKTsKKwor
CWlmIChkaXIgPT0gUE04NjBYX0NMS19ESVJfT1VUKQorCQlwbTg2MHgtPmRpciA9IFBNODYwWF9D
TEtfRElSX09VVDsKKwllbHNlCisJCXBtODYweC0+ZGlyID0gUE04NjBYX0NMS19ESVJfSU47CisK
KwlyZXR1cm4gMDsKK30KKworc3RhdGljIGludCBwbTg2MHhfaTJzX2h3X3BhcmFtcyhzdHJ1Y3Qg
c25kX3BjbV9zdWJzdHJlYW0gKnN1YnN0cmVhbSwKKwkJCQlzdHJ1Y3Qgc25kX3BjbV9od19wYXJh
bXMgKnBhcmFtcywKKwkJCQlzdHJ1Y3Qgc25kX3NvY19kYWkgKmRhaSkKK3sKKwlzdHJ1Y3Qgc25k
X3NvY19jb2RlYyAqY29kZWMgPSBkYWktPmNvZGVjOworCXVuc2lnbmVkIGNoYXIgaW5mOworCisJ
LyogYml0IHNpemUgKi8KKwlzd2l0Y2ggKHBhcmFtc19mb3JtYXQocGFyYW1zKSkgeworCWNhc2Ug
U05EUlZfUENNX0ZPUk1BVF9TMTZfTEU6CisJCWluZiA9IDA7CisJCWJyZWFrOworCWNhc2UgU05E
UlZfUENNX0ZPUk1BVF9TMThfM0xFOgorCQlpbmYgPSBQQ01fSU5GMl8xOFdMOworCQlicmVhazsK
KwlkZWZhdWx0OgorCQlyZXR1cm4gLUVJTlZBTDsKKwl9CisJc25kX3NvY191cGRhdGVfYml0cyhj
b2RlYywgUE04NjBYX0kyU19JRkFDRV8yLCBQQ01fSU5GMl8xOFdMLCBpbmYpOworCisJLyogc2Ft
cGxlIHJhdGUgKi8KKwlzd2l0Y2ggKHBhcmFtc19yYXRlKHBhcmFtcykpIHsKKwljYXNlIDgwMDA6
CisJCWluZiA9IDA7CisJCWJyZWFrOworCWNhc2UgMTEwMjU6CisJCWluZiA9IDE7CisJCWJyZWFr
OworCWNhc2UgMTYwMDA6CisJCWluZiA9IDM7CisJCWJyZWFrOworCWNhc2UgMjIwNTA6CisJCWlu
ZiA9IDQ7CisJCWJyZWFrOworCWNhc2UgMzIwMDA6CisJCWluZiA9IDY7CisJCWJyZWFrOworCWNh
c2UgNDQxMDA6CisJCWluZiA9IDc7CisJCWJyZWFrOworCWNhc2UgNDgwMDA6CisJCWluZiA9IDg7
CisJCWJyZWFrOworCWRlZmF1bHQ6CisJCXJldHVybiAtRUlOVkFMOworCX0KKwlzbmRfc29jX3Vw
ZGF0ZV9iaXRzKGNvZGVjLCBQTTg2MFhfSTJTX0lGQUNFXzQsIDB4ZiwgaW5mKTsKKworCXJldHVy
biAwOworfQorCitzdGF0aWMgaW50IHBtODYweF9pMnNfc2V0X2RhaV9mbXQoc3RydWN0IHNuZF9z
b2NfZGFpICpjb2RlY19kYWksCisJCQkJICB1bnNpZ25lZCBpbnQgZm10KQoreworCXN0cnVjdCBz
bmRfc29jX2NvZGVjICpjb2RlYyA9IGNvZGVjX2RhaS0+Y29kZWM7CisJc3RydWN0IHBtODYweF9w
cml2ICpwbTg2MHggPSBzbmRfc29jX2NvZGVjX2dldF9kcnZkYXRhKGNvZGVjKTsKKwl1bnNpZ25l
ZCBjaGFyIGluZiA9IDAsIG1hc2sgPSAwOworCWludCByZXQ7CisKKwlyZXQgPSBzZXRfZGFpX2Zt
dChwbTg2MHgsIGZtdCwgJmluZiwgJm1hc2spOworCWlmICghcmV0KQorCQlzbmRfc29jX3VwZGF0
ZV9iaXRzKGNvZGVjLCBQTTg2MFhfSTJTX0lGQUNFXzIsIG1hc2ssIGluZik7CisJcmV0dXJuIHJl
dDsKK30KKworc3RhdGljIGludCBwbTg2MHhfc2V0X2JpYXNfbGV2ZWwoc3RydWN0IHNuZF9zb2Nf
Y29kZWMgKmNvZGVjLAorCQkJCSBlbnVtIHNuZF9zb2NfYmlhc19sZXZlbCBsZXZlbCkKK3sKKwlp
bnQgZGF0YTsKKworCXN3aXRjaCAobGV2ZWwpIHsKKwljYXNlIFNORF9TT0NfQklBU19PTjoKKwkJ
YnJlYWs7CisKKwljYXNlIFNORF9TT0NfQklBU19QUkVQQVJFOgorCQlicmVhazsKKworCWNhc2Ug
U05EX1NPQ19CSUFTX1NUQU5EQlk6CisJCWlmIChjb2RlYy0+Ymlhc19sZXZlbCA9PSBTTkRfU09D
X0JJQVNfT0ZGKSB7CisJCQkvKiBFbmFibGUgQXVkaW8gUExMICYgQXVkaW8gc2VjdGlvbiAqLwor
CQkJZGF0YSA9IEFVRElPX1BMTCB8IEFVRElPX1NFQ1RJT05fUkVTRVQKKwkJCQl8IEFVRElPX1NF
Q1RJT05fT047CisJCQlwbTg2MHhfcmVnX3dyaXRlKGNvZGVjLT5jb250cm9sX2RhdGEsIFJFR19N
SVNDMiwgZGF0YSk7CisJCX0KKwkJYnJlYWs7CisKKwljYXNlIFNORF9TT0NfQklBU19PRkY6CisJ
CWRhdGEgPSBBVURJT19QTEwgfCBBVURJT19TRUNUSU9OX1JFU0VUIHwgQVVESU9fU0VDVElPTl9P
TjsKKwkJcG04NjB4X3NldF9iaXRzKGNvZGVjLT5jb250cm9sX2RhdGEsIFJFR19NSVNDMiwgZGF0
YSwgMCk7CisJCWJyZWFrOworCX0KKwljb2RlYy0+Ymlhc19sZXZlbCA9IGxldmVsOworCXJldHVy
biAwOworfQorCitzdGF0aWMgc3RydWN0IHNuZF9zb2NfZGFpX29wcyBwbTg2MHhfcGNtX2RhaV9v
cHMgPSB7CisJLmRpZ2l0YWxfbXV0ZQk9IHBtODYweF9kaWdpdGFsX211dGUsCisJLmh3X3BhcmFt
cwk9IHBtODYweF9wY21faHdfcGFyYW1zLAorCS5zZXRfZm10CT0gcG04NjB4X3BjbV9zZXRfZGFp
X2ZtdCwKKwkuc2V0X3N5c2Nsawk9IHBtODYweF9zZXRfZGFpX3N5c2NsaywKK307CisKK3N0YXRp
YyBzdHJ1Y3Qgc25kX3NvY19kYWlfb3BzIHBtODYweF9pMnNfZGFpX29wcyA9IHsKKwkuZGlnaXRh
bF9tdXRlCT0gcG04NjB4X2RpZ2l0YWxfbXV0ZSwKKwkuaHdfcGFyYW1zCT0gcG04NjB4X2kyc19o
d19wYXJhbXMsCisJLnNldF9mbXQJPSBwbTg2MHhfaTJzX3NldF9kYWlfZm10LAorCS5zZXRfc3lz
Y2xrCT0gcG04NjB4X3NldF9kYWlfc3lzY2xrLAorfTsKKworI2RlZmluZSBQTTg2MFhfUkFURVMJ
KFNORFJWX1BDTV9SQVRFXzgwMDAgfCBTTkRSVl9QQ01fUkFURV8xNjAwMCB8CVwKKwkJCSBTTkRS
Vl9QQ01fUkFURV8zMjAwMCB8IFNORFJWX1BDTV9SQVRFXzQ4MDAwKQorCitzdGF0aWMgc3RydWN0
IHNuZF9zb2NfZGFpX2RyaXZlciBwbTg2MHhfZGFpW10gPSB7CisJeworCQkvKiBEQUkgUENNICov
CisJCS5uYW1lCT0gIjg4cG04NjB4LXBjbSIsCisJCS5pZAk9IDEsCisJCS5wbGF5YmFjayA9IHsK
KwkJCS5zdHJlYW1fbmFtZQk9ICJQQ00gUGxheWJhY2siLAorCQkJLmNoYW5uZWxzX21pbgk9IDIs
CisJCQkuY2hhbm5lbHNfbWF4CT0gMiwKKwkJCS5yYXRlcwkJPSBQTTg2MFhfUkFURVMsCisJCQku
Zm9ybWF0cwk9IFNORFJWX1BDTV9GT1JNQVRfUzE2X0xFIHwgXAorCQkJCQkgIFNORFJWX1BDTV9G
T1JNQVRfUzE4XzNMRSwKKwkJfSwKKwkJLmNhcHR1cmUgPSB7CisJCQkuc3RyZWFtX25hbWUJPSAi
UENNIENhcHR1cmUiLAorCQkJLmNoYW5uZWxzX21pbgk9IDIsCisJCQkuY2hhbm5lbHNfbWF4CT0g
MiwKKwkJCS5yYXRlcwkJPSBQTTg2MFhfUkFURVMsCisJCQkuZm9ybWF0cwk9IFNORFJWX1BDTV9G
T1JNQVRfUzE2X0xFIHwgXAorCQkJCQkgIFNORFJWX1BDTV9GT1JNQVRfUzE4XzNMRSwKKwkJfSwK
KwkJLm9wcwk9ICZwbTg2MHhfcGNtX2RhaV9vcHMsCisJfSwgeworCQkvKiBEQUkgSTJTICovCisJ
CS5uYW1lCT0gIjg4cG04NjB4LWkycyIsCisJCS5pZAk9IDIsCisJCS5wbGF5YmFjayA9IHsKKwkJ
CS5zdHJlYW1fbmFtZQk9ICJJMlMgUGxheWJhY2siLAorCQkJLmNoYW5uZWxzX21pbgk9IDIsCisJ
CQkuY2hhbm5lbHNfbWF4CT0gMiwKKwkJCS5yYXRlcwkJPSBTTkRSVl9QQ01fUkFURV84MDAwXzQ4
MDAwLAorCQkJLmZvcm1hdHMJPSBTTkRSVl9QQ01fRk9STUFUX1MxNl9MRSB8IFwKKwkJCQkJICBT
TkRSVl9QQ01fRk9STUFUX1MxOF8zTEUsCisJCX0sCisJCS5jYXB0dXJlID0geworCQkJLnN0cmVh
bV9uYW1lCT0gIkkyUyBDYXB0dXJlIiwKKwkJCS5jaGFubmVsc19taW4JPSAyLAorCQkJLmNoYW5u
ZWxzX21heAk9IDIsCisJCQkucmF0ZXMJCT0gU05EUlZfUENNX1JBVEVfODAwMF80ODAwMCwKKwkJ
CS5mb3JtYXRzCT0gU05EUlZfUENNX0ZPUk1BVF9TMTZfTEUgfCBcCisJCQkJCSAgU05EUlZfUENN
X0ZPUk1BVF9TMThfM0xFLAorCQl9LAorCQkub3BzCT0gJnBtODYweF9pMnNfZGFpX29wcywKKwl9
LAorfTsKKworc3RhdGljIGlycXJldHVybl90IHBtODYweF9jb2RlY19oYW5kbGVyKGludCBpcnEs
IHZvaWQgKmRhdGEpCit7CisJc3RydWN0IHBtODYweF9wcml2ICpwbTg2MHggPSBkYXRhOworCWlu
dCBzdGF0dXMsIHNocnQsIHJlcG9ydCA9IDA7CisKKwlzdGF0dXMgPSBwbTg2MHhfcmVnX3JlYWQo
cG04NjB4LT5pMmMsIFJFR19TVEFUVVNfMSk7CisJc2hydCA9IHBtODYweF9yZWdfcmVhZChwbTg2
MHgtPmkyYywgUkVHX1NIT1JUUyk7CisKKwlpZiAoc3RhdHVzICYgSEVBRFNFVF9TVEFUVVMpCisJ
CXJlcG9ydCB8PSBQTTg2MFhfREVUX0hFQURTRVQ7CisJaWYgKHN0YXR1cyAmIE1JQ19TVEFUVVMp
CisJCXJlcG9ydCB8PSBQTTg2MFhfREVUX01JQzsKKwlpZiAoc3RhdHVzICYgSE9PS19TVEFUVVMp
CisJCXJlcG9ydCB8PSBQTTg2MFhfREVUX0hPT0s7CisJaWYgKHNocnQgJiAoU0hPUlRfTE8xIHwg
U0hPUlRfTE8yKSkKKwkJcmVwb3J0IHw9IFBNODYwWF9TSE9SVF9MSU5FT1VUOworCWlmIChzaHJ0
ICYgKFNIT1JUX0hTMSB8IFNIT1JUX0hTMikpCisJCXJlcG9ydCB8PSBQTTg2MFhfU0hPUlRfSEVB
RFNFVDsKKwlkZXZfZGJnKHBtODYweC0+Y29kZWMtPmRldiwgInJlcG9ydDoweCV4XG4iLCByZXBv
cnQpOworCXJldHVybiBJUlFfSEFORExFRDsKK30KKworc3RhdGljIGludCBwbTg2MHhfcHJvYmUo
c3RydWN0IHNuZF9zb2NfY29kZWMgKmNvZGVjKQoreworCXN0cnVjdCBwbTg2MHhfcHJpdiAqcG04
NjB4ID0gc25kX3NvY19jb2RlY19nZXRfZHJ2ZGF0YShjb2RlYyk7CisJaW50IGksIHJldDsKKwor
CXBtODYweC0+Y29kZWMgPSBjb2RlYzsKKworCWNvZGVjLT5jb250cm9sX2RhdGEgPSBwbTg2MHgt
PmkyYzsKKworCWZvciAoaSA9IDA7IGkgPCA0OyBpKyspIHsKKwkJcmV0ID0gcmVxdWVzdF90aHJl
YWRlZF9pcnEocG04NjB4LT5pcnFbaV0sIE5VTEwsCisJCQkJCSAgIHBtODYweF9jb2RlY19oYW5k
bGVyLCBJUlFGX09ORVNIT1QsCisJCQkJCSAgIHBtODYweC0+bmFtZVtpXSwgcG04NjB4KTsKKwkJ
aWYgKHJldCA8IDApIHsKKwkJCWRldl9lcnIoY29kZWMtPmRldiwgIkZhaWxlZCB0byByZXF1ZXN0
IElSUSFcbiIpOworCQkJZ290byBvdXRfaXJxOworCQl9CisJfQorCisJcG04NjB4X3NldF9iaWFz
X2xldmVsKGNvZGVjLCBTTkRfU09DX0JJQVNfU1RBTkRCWSk7CisKKwlyZXQgPSBwbTg2MHhfYnVs
a19yZWFkKGNvZGVjLT5jb250cm9sX2RhdGEsIFJFR19DQUNIRV9CQVNFLAorCQkJICAgICAgIFJF
R19DQUNIRV9TSVpFLCBjb2RlYy0+cmVnX2NhY2hlKTsKKwlpZiAocmV0IDwgMCkgeworCQlkZXZf
ZXJyKGNvZGVjLT5kZXYsICJGYWlsZWQgdG8gZmlsbCByZWdpc3RlciBjYWNoZTogJWRcbiIsCisJ
CQlyZXQpOworCQlnb3RvIG91dF9jb2RlYzsKKwl9CisKKwlzbmRfc29jX2FkZF9jb250cm9scyhj
b2RlYywgcG04NjB4X3NuZF9jb250cm9scywKKwkJCSAgICAgQVJSQVlfU0laRShwbTg2MHhfc25k
X2NvbnRyb2xzKSk7CisJc25kX3NvY19kYXBtX25ld19jb250cm9scyhjb2RlYywgcG04NjB4X2Rh
cG1fd2lkZ2V0cywKKwkJCQkgIEFSUkFZX1NJWkUocG04NjB4X2RhcG1fd2lkZ2V0cykpOworCXNu
ZF9zb2NfZGFwbV9hZGRfcm91dGVzKGNvZGVjLCBhdWRpb19tYXAsIEFSUkFZX1NJWkUoYXVkaW9f
bWFwKSk7CisJcmV0dXJuIDA7CisKK291dF9jb2RlYzoKKwlpID0gMzsKK291dF9pcnE6CisJZm9y
ICg7IGkgPj0gMDsgaS0tKQorCQlmcmVlX2lycShwbTg2MHgtPmlycVtpXSwgcG04NjB4KTsKKwly
ZXR1cm4gLUVJTlZBTDsKK30KKworc3RhdGljIGludCBwbTg2MHhfcmVtb3ZlKHN0cnVjdCBzbmRf
c29jX2NvZGVjICpjb2RlYykKK3sKKwlzdHJ1Y3QgcG04NjB4X3ByaXYgKnBtODYweCA9IHNuZF9z
b2NfY29kZWNfZ2V0X2RydmRhdGEoY29kZWMpOworCWludCBpOworCisJZm9yIChpID0gMzsgaSA+
PSAwOyBpLS0pCisJCWZyZWVfaXJxKHBtODYweC0+aXJxW2ldLCBwbTg2MHgpOworCXBtODYweF9z
ZXRfYmlhc19sZXZlbChjb2RlYywgU05EX1NPQ19CSUFTX09GRik7CisJcmV0dXJuIDA7Cit9CisK
K3N0YXRpYyBzdHJ1Y3Qgc25kX3NvY19jb2RlY19kcml2ZXIgc29jX2NvZGVjX2Rldl9wbTg2MHgg
PSB7CisJLnByb2JlCQk9IHBtODYweF9wcm9iZSwKKwkucmVtb3ZlCQk9IHBtODYweF9yZW1vdmUs
CisJLnJlYWQJCT0gcG04NjB4X3JlYWRfcmVnX2NhY2hlLAorCS53cml0ZQkJPSBwbTg2MHhfd3Jp
dGVfcmVnX2NhY2hlLAorCS5yZWdfY2FjaGVfc2l6ZQk9IFJFR19DQUNIRV9TSVpFLAorCS5yZWdf
d29yZF9zaXplCT0gc2l6ZW9mKHU4KSwKKwkuc2V0X2JpYXNfbGV2ZWwJPSBwbTg2MHhfc2V0X2Jp
YXNfbGV2ZWwsCit9OworCitzdGF0aWMgaW50IF9fZGV2aW5pdCBwbTg2MHhfY29kZWNfcHJvYmUo
c3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikKK3sKKwlzdHJ1Y3QgcG04NjB4X2NoaXAgKmNo
aXAgPSBkZXZfZ2V0X2RydmRhdGEocGRldi0+ZGV2LnBhcmVudCk7CisJc3RydWN0IHBtODYweF9w
cml2ICpwbTg2MHg7CisJc3RydWN0IHJlc291cmNlICpyZXM7CisJaW50IGksIHJldDsKKworCXBt
ODYweCA9IGt6YWxsb2Moc2l6ZW9mKHN0cnVjdCBwbTg2MHhfcHJpdiksIEdGUF9LRVJORUwpOwor
CWlmIChwbTg2MHggPT0gTlVMTCkKKwkJcmV0dXJuIC1FTk9NRU07CisKKwlwbTg2MHgtPmNoaXAg
PSBjaGlwOworCXBtODYweC0+aTJjID0gKGNoaXAtPmlkID09IENISVBfUE04NjA3KSA/IGNoaXAt
PmNsaWVudAorCQkJOiBjaGlwLT5jb21wYW5pb247CisJcGxhdGZvcm1fc2V0X2RydmRhdGEocGRl
diwgcG04NjB4KTsKKworCWZvciAoaSA9IDA7IGkgPCA0OyBpKyspIHsKKwkJcmVzID0gcGxhdGZv
cm1fZ2V0X3Jlc291cmNlKHBkZXYsIElPUkVTT1VSQ0VfSVJRLCBpKTsKKwkJaWYgKCFyZXMpIHsK
KwkJCWRldl9lcnIoJnBkZXYtPmRldiwgIkZhaWxlZCB0byBnZXQgSVJRIHJlc291cmNlc1xuIik7
CisJCQlnb3RvIG91dDsKKwkJfQorCQlwbTg2MHgtPmlycVtpXSA9IHJlcy0+c3RhcnQgKyBjaGlw
LT5pcnFfYmFzZTsKKwkJc3RybmNweShwbTg2MHgtPm5hbWVbaV0sIHJlcy0+bmFtZSwgTUFYX05B
TUVfTEVOKTsKKwl9CisKKwlyZXQgPSBzbmRfc29jX3JlZ2lzdGVyX2NvZGVjKCZwZGV2LT5kZXYs
ICZzb2NfY29kZWNfZGV2X3BtODYweCwKKwkJCQkgICAgIHBtODYweF9kYWksIEFSUkFZX1NJWkUo
cG04NjB4X2RhaSkpOworCWlmIChyZXQpIHsKKwkJZGV2X2VycigmcGRldi0+ZGV2LCAiRmFpbGVk
IHRvIHJlZ2lzdGVyIGNvZGVjXG4iKTsKKwkJZ290byBvdXQ7CisJfQorCXJldHVybiByZXQ7CisK
K291dDoKKwlwbGF0Zm9ybV9zZXRfZHJ2ZGF0YShwZGV2LCBOVUxMKTsKKwlrZnJlZShwbTg2MHgp
OworCXJldHVybiAtRUlOVkFMOworfQorCitzdGF0aWMgaW50IF9fZGV2ZXhpdCBwbTg2MHhfY29k
ZWNfcmVtb3ZlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpCit7CisJc3RydWN0IHBtODYw
eF9wcml2ICpwbTg2MHggPSBwbGF0Zm9ybV9nZXRfZHJ2ZGF0YShwZGV2KTsKKworCXNuZF9zb2Nf
dW5yZWdpc3Rlcl9jb2RlYygmcGRldi0+ZGV2KTsKKwlwbGF0Zm9ybV9zZXRfZHJ2ZGF0YShwZGV2
LCBOVUxMKTsKKwlrZnJlZShwbTg2MHgpOworCXJldHVybiAwOworfQorCitzdGF0aWMgc3RydWN0
IHBsYXRmb3JtX2RyaXZlciBwbTg2MHhfY29kZWNfZHJpdmVyID0geworCS5kcml2ZXIJPSB7CisJ
CS5uYW1lCT0gIjg4cG04NjB4LWNvZGVjIiwKKwkJLm93bmVyCT0gVEhJU19NT0RVTEUsCisJfSwK
KwkucHJvYmUJPSBwbTg2MHhfY29kZWNfcHJvYmUsCisJLnJlbW92ZQk9IF9fZGV2ZXhpdF9wKHBt
ODYweF9jb2RlY19yZW1vdmUpLAorfTsKKworc3RhdGljIF9faW5pdCBpbnQgcG04NjB4X2luaXQo
dm9pZCkKK3sKKwlyZXR1cm4gcGxhdGZvcm1fZHJpdmVyX3JlZ2lzdGVyKCZwbTg2MHhfY29kZWNf
ZHJpdmVyKTsKK30KK21vZHVsZV9pbml0KHBtODYweF9pbml0KTsKKworc3RhdGljIF9fZXhpdCB2
b2lkIHBtODYweF9leGl0KHZvaWQpCit7CisJcGxhdGZvcm1fZHJpdmVyX3VucmVnaXN0ZXIoJnBt
ODYweF9jb2RlY19kcml2ZXIpOworfQorbW9kdWxlX2V4aXQocG04NjB4X2V4aXQpOworCitNT0RV
TEVfREVTQ1JJUFRJT04oIkFTb0MgODhQTTg2MHggZHJpdmVyIik7CitNT0RVTEVfQVVUSE9SKCJI
YW9qaWFuIFpodWFuZyA8aGFvamlhbi56aHVhbmdAbWFydmVsbC5jb20+Iik7CitNT0RVTEVfTElD
RU5TRSgiR1BMIik7CitNT0RVTEVfQUxJQVMoInBsYXRmb3JtOjg4cG04NjB4LWNvZGVjIik7CisK
ZGlmZiAtLWdpdCBhL3NvdW5kL3NvYy9jb2RlY3MvODhwbTg2MHgtY29kZWMuaCBiL3NvdW5kL3Nv
Yy9jb2RlY3MvODhwbTg2MHgtY29kZWMuaApuZXcgZmlsZSBtb2RlIDEwMDY0NAppbmRleCAwMDAw
MDAwLi5iMDM0ZGUyCi0tLSAvZGV2L251bGwKKysrIGIvc291bmQvc29jL2NvZGVjcy84OHBtODYw
eC1jb2RlYy5oCkBAIC0wLDAgKzEsOTIgQEAKKy8qCisgKiA4OHBtODYweC1jb2RlYy5oIC0tIDg4
UE04NjB4IEFMU0EgU29DIEF1ZGlvIERyaXZlcgorICoKKyAqIENvcHlyaWdodCAyMDEwIE1hcnZl
bGwgSW50ZXJuYXRpb25hbCBMdGQuCisgKglIYW9qaWFuIFpodWFuZyA8aGFvamlhbi56aHVhbmdA
bWFydmVsbC5jb20+CisgKgorICogVGhpcyBwcm9ncmFtIGlzIGZyZWUgc29mdHdhcmU7IHlvdSBj
YW4gcmVkaXN0cmlidXRlIGl0IGFuZC9vciBtb2RpZnkKKyAqIGl0IHVuZGVyIHRoZSB0ZXJtcyBv
ZiB0aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UgdmVyc2lvbiAyIGFzCisgKiBwdWJsaXNo
ZWQgYnkgdGhlIEZyZWUgU29mdHdhcmUgRm91bmRhdGlvbi4KKyAqLworCisjaWZuZGVmIF9fODhQ
TTg2MFhfSAorI2RlZmluZSBfXzg4UE04NjBYX0gKKworLyogVGhlIG9mZnNldCBvZiB0aGVzZSBy
ZWdpc3RlcnMgYXJlIDB4YjAgKi8KKyNkZWZpbmUgUE04NjBYX1BDTV9JRkFDRV8xCQkweDAwCisj
ZGVmaW5lIFBNODYwWF9QQ01fSUZBQ0VfMgkJMHgwMQorI2RlZmluZSBQTTg2MFhfUENNX0lGQUNF
XzMJCTB4MDIKKyNkZWZpbmUgUE04NjBYX1BDTV9SQVRFCQkJMHgwMworI2RlZmluZSBQTTg2MFhf
RUNfUEFUSAkJCTB4MDQKKyNkZWZpbmUgUE04NjBYX1NJREVUT05FX0xfR0FJTgkJMHgwNQorI2Rl
ZmluZSBQTTg2MFhfU0lERVRPTkVfUl9HQUlOCQkweDA2CisjZGVmaW5lIFBNODYwWF9TSURFVE9O
RV9TSElGVAkJMHgwNworI2RlZmluZSBQTTg2MFhfQURDX09GRlNFVF8xCQkweDA4CisjZGVmaW5l
IFBNODYwWF9BRENfT0ZGU0VUXzIJCTB4MDkKKyNkZWZpbmUgUE04NjBYX0RNSUNfREVMQVkJCTB4
MGEKKworI2RlZmluZSBQTTg2MFhfSTJTX0lGQUNFXzEJCTB4MGIKKyNkZWZpbmUgUE04NjBYX0ky
U19JRkFDRV8yCQkweDBjCisjZGVmaW5lIFBNODYwWF9JMlNfSUZBQ0VfMwkJMHgwZAorI2RlZmlu
ZSBQTTg2MFhfSTJTX0lGQUNFXzQJCTB4MGUKKyNkZWZpbmUgUE04NjBYX0VRVUFMSVpFUl9OMF8x
CQkweDBmCisjZGVmaW5lIFBNODYwWF9FUVVBTElaRVJfTjBfMgkJMHgxMAorI2RlZmluZSBQTTg2
MFhfRVFVQUxJWkVSX04xXzEJCTB4MTEKKyNkZWZpbmUgUE04NjBYX0VRVUFMSVpFUl9OMV8yCQkw
eDEyCisjZGVmaW5lIFBNODYwWF9FUVVBTElaRVJfRDFfMQkJMHgxMworI2RlZmluZSBQTTg2MFhf
RVFVQUxJWkVSX0QxXzIJCTB4MTQKKyNkZWZpbmUgUE04NjBYX0xPRklfR0FJTl9MRUZUCQkweDE1
CisjZGVmaW5lIFBNODYwWF9MT0ZJX0dBSU5fUklHSFQJCTB4MTYKKyNkZWZpbmUgUE04NjBYX0hJ
RklMX0dBSU5fTEVGVAkJMHgxNworI2RlZmluZSBQTTg2MFhfSElGSUxfR0FJTl9SSUdIVAkJMHgx
OAorI2RlZmluZSBQTTg2MFhfSElGSVJfR0FJTl9MRUZUCQkweDE5CisjZGVmaW5lIFBNODYwWF9I
SUZJUl9HQUlOX1JJR0hUCQkweDFhCisjZGVmaW5lIFBNODYwWF9EQUNfT0ZGU0VUCQkweDFiCisj
ZGVmaW5lIFBNODYwWF9PRkZTRVRfTEVGVF8xCQkweDFjCisjZGVmaW5lIFBNODYwWF9PRkZTRVRf
TEVGVF8yCQkweDFkCisjZGVmaW5lIFBNODYwWF9PRkZTRVRfUklHSFRfMQkJMHgxZQorI2RlZmlu
ZSBQTTg2MFhfT0ZGU0VUX1JJR0hUXzIJCTB4MWYKKyNkZWZpbmUgUE04NjBYX0FEQ19BTkFfMQkJ
MHgyMAorI2RlZmluZSBQTTg2MFhfQURDX0FOQV8yCQkweDIxCisjZGVmaW5lIFBNODYwWF9BRENf
QU5BXzMJCTB4MjIKKyNkZWZpbmUgUE04NjBYX0FEQ19BTkFfNAkJMHgyMworI2RlZmluZSBQTTg2
MFhfQU5BX1RPX0FOQQkJMHgyNAorI2RlZmluZSBQTTg2MFhfSFMxX0NUUkwJCQkweDI1CisjZGVm
aW5lIFBNODYwWF9IUzJfQ1RSTAkJCTB4MjYKKyNkZWZpbmUgUE04NjBYX0xPMV9DVFJMCQkJMHgy
NworI2RlZmluZSBQTTg2MFhfTE8yX0NUUkwJCQkweDI4CisjZGVmaW5lIFBNODYwWF9FQVJfQ1RS
TF8xCQkweDI5CisjZGVmaW5lIFBNODYwWF9FQVJfQ1RSTF8yCQkweDJhCisjZGVmaW5lIFBNODYw
WF9BVURJT19TVVBQTElFU18xCQkweDJiCisjZGVmaW5lIFBNODYwWF9BVURJT19TVVBQTElFU18y
CQkweDJjCisjZGVmaW5lIFBNODYwWF9BRENfRU5fMQkJCTB4MmQKKyNkZWZpbmUgUE04NjBYX0FE
Q19FTl8yCQkJMHgyZQorI2RlZmluZSBQTTg2MFhfREFDX0VOXzEJCQkweDJmCisjZGVmaW5lIFBN
ODYwWF9EQUNfRU5fMgkJCTB4MzEKKyNkZWZpbmUgUE04NjBYX0FVRElPX0NBTF8xCQkweDMyCisj
ZGVmaW5lIFBNODYwWF9BVURJT19DQUxfMgkJMHgzMworI2RlZmluZSBQTTg2MFhfQVVESU9fQ0FM
XzMJCTB4MzQKKyNkZWZpbmUgUE04NjBYX0FVRElPX0NBTF80CQkweDM1CisjZGVmaW5lIFBNODYw
WF9BVURJT19DQUxfNQkJMHgzNgorI2RlZmluZSBQTTg2MFhfQU5BX0lOUFVUX1NFTF8xCQkweDM3
CisjZGVmaW5lIFBNODYwWF9BTkFfSU5QVVRfU0VMXzIJCTB4MzgKKworI2RlZmluZSBQTTg2MFhf
UENNX0lGQUNFXzQJCTB4MzkKKyNkZWZpbmUgUE04NjBYX0kyU19JRkFDRV81CQkweDNhCisKKyNk
ZWZpbmUgUE04NjBYX1NIT1JUUwkJCTB4M2IKKyNkZWZpbmUgUE04NjBYX1BMTF9BREpfMQkJMHgz
YworI2RlZmluZSBQTTg2MFhfUExMX0FESl8yCQkweDNkCisKKy8qIGJpdHMgZGVmaW5pdGlvbiAq
LworI2RlZmluZSBQTTg2MFhfQ0xLX0RJUl9JTgkJMAorI2RlZmluZSBQTTg2MFhfQ0xLX0RJUl9P
VVQJCTEKKworI2RlZmluZSBQTTg2MFhfREVUX0hFQURTRVQJCSgxIDw8IDApCisjZGVmaW5lIFBN
ODYwWF9ERVRfTUlDCQkJKDEgPDwgMSkKKyNkZWZpbmUgUE04NjBYX0RFVF9IT09LCQkJKDEgPDwg
MikKKyNkZWZpbmUgUE04NjBYX1NIT1JUX0hFQURTRVQJCSgxIDw8IDMpCisjZGVmaW5lIFBNODYw
WF9TSE9SVF9MSU5FT1VUCQkoMSA8PCA0KQorI2RlZmluZSBQTTg2MFhfREVUX01BU0sJCQkweDFG
CisKKyNlbmRpZgkvKiBfXzg4UE04NjBYX0ggKi8KZGlmZiAtLWdpdCBhL3NvdW5kL3NvYy9jb2Rl
Y3MvS2NvbmZpZyBiL3NvdW5kL3NvYy9jb2RlY3MvS2NvbmZpZwppbmRleCBiZmRkOTJiLi5hM2Nm
YzE4IDEwMDY0NAotLS0gYS9zb3VuZC9zb2MvY29kZWNzL0tjb25maWcKKysrIGIvc291bmQvc29j
L2NvZGVjcy9LY29uZmlnCkBAIC0xMCw2ICsxMCw3IEBAIGNvbmZpZyBTTkRfU09DX0kyQ19BTkRf
U1BJCiAKIGNvbmZpZyBTTkRfU09DX0FMTF9DT0RFQ1MKIAl0cmlzdGF0ZSAiQnVpbGQgYWxsIEFT
b0MgQ09ERUMgZHJpdmVycyIKKwlzZWxlY3QgU05EX1NPQ184OFBNODYwWCBpZiBNRkRfODhQTTg2
MFgKIAlzZWxlY3QgU05EX1NPQ19MMwogCXNlbGVjdCBTTkRfU09DX0FDOTdfQ09ERUMgaWYgU05E
X1NPQ19BQzk3X0JVUwogCXNlbGVjdCBTTkRfU09DX0FEMTgzNiBpZiBTUElfTUFTVEVSCkBAIC04
NSw2ICs4Niw5IEBAIGNvbmZpZyBTTkRfU09DX0FMTF9DT0RFQ1MKIAogICAgICAgICAgIElmIHVu
c3VyZSBzZWxlY3QgIk4iLgogCitjb25maWcgU05EX1NPQ184OFBNODYwWAorCXRyaXN0YXRlCisK
IGNvbmZpZyBTTkRfU09DX1dNX0hVQlMKIAl0cmlzdGF0ZQogCWRlZmF1bHQgeSBpZiBTTkRfU09D
X1dNODk5Mz15IHx8IFNORF9TT0NfV004OTk0PXkKZGlmZiAtLWdpdCBhL3NvdW5kL3NvYy9jb2Rl
Y3MvTWFrZWZpbGUgYi9zb3VuZC9zb2MvY29kZWNzL01ha2VmaWxlCmluZGV4IDljM2MzOWYuLmI5
YzQzNTggMTAwNjQ0Ci0tLSBhL3NvdW5kL3NvYy9jb2RlY3MvTWFrZWZpbGUKKysrIGIvc291bmQv
c29jL2NvZGVjcy9NYWtlZmlsZQpAQCAtMSwzICsxLDQgQEAKK3NuZC1zb2MtODhwbTg2MHgtb2Jq
cyA6PSA4OHBtODYweC1jb2RlYy5vCiBzbmQtc29jLWFjOTctb2JqcyA6PSBhYzk3Lm8KIHNuZC1z
b2MtYWQxODM2LW9ianMgOj0gYWQxODM2Lm8KIHNuZC1zb2MtYWQxOTN4LW9ianMgOj0gYWQxOTN4
Lm8KQEAgLTY3LDYgKzY4LDcgQEAgc25kLXNvYy10cGE2MTMwYTItb2JqcyA6PSB0cGE2MTMwYTIu
bwogc25kLXNvYy13bTIwMDAtb2JqcyA6PSB3bTIwMDAubwogc25kLXNvYy13bTkwOTAtb2JqcyA6
PSB3bTkwOTAubwogCitvYmotJChDT05GSUdfU05EX1NPQ184OFBNODYwWCkJKz0gc25kLXNvYy04
OHBtODYweC5vCiBvYmotJChDT05GSUdfU05EX1NPQ19BQzk3X0NPREVDKQkrPSBzbmQtc29jLWFj
OTcubwogb2JqLSQoQ09ORklHX1NORF9TT0NfQUQxODM2KQkrPSBzbmQtc29jLWFkMTgzNi5vCiBv
YmotJChDT05GSUdfU05EX1NPQ19BRDE5M1gpCSs9IHNuZC1zb2MtYWQxOTN4Lm8KLS0gCjEuNS42
LjUKCg==
--0016e6d63f44021a1f048e002b69--
