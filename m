From: juergen.lambrecht@gmail.com (=?UTF-8?q?J=C3=BCrgen=20Lambrecht?=)
Date: Fri,  8 Jul 2011 15:19:58 +0200
Subject: [RFC PATCH] ASoC: codecs: add codec driver for MFD mc13783
Message-ID: <1310131198-493-1-git-send-email-J.Lambrecht@televic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sascha Hauer's driver from Pengutronix' imx-sound branch.
Added some code found in a linux 2.6.33.
Needs further work and cleanup.

Signed-off-by: J?rgen Lambrecht <J.Lambrecht@televic.com>
---
 sound/soc/codecs/Kconfig   |    4 +
 sound/soc/codecs/Makefile  |    2 +
 sound/soc/codecs/mc13783.c |  781 ++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/mc13783.h |   29 ++
 4 files changed, 816 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/codecs/mc13783.c
 create mode 100644 sound/soc/codecs/mc13783.h

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 98175a0..77fb7b2 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -37,6 +37,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_MAX98095 if I2C
 	select SND_SOC_MAX9850 if I2C
 	select SND_SOC_MAX9877 if I2C
+	select SND_SOC_MC13783 if SPI
 	select SND_SOC_PCM3008
 	select SND_SOC_SGTL5000 if I2C
 	select SND_SOC_SN95031 if INTEL_SCU_IPC
@@ -200,6 +201,9 @@ config SND_SOC_MAX98095
 config SND_SOC_MAX9850
 	tristate
 
+config SND_SOC_MC13783
+	tristate
+
 config SND_SOC_PCM3008
        tristate
 
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index fd85584..a129af2 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -22,6 +22,7 @@ snd-soc-l3-objs := l3.o
 snd-soc-max98088-objs := max98088.o
 snd-soc-max98095-objs := max98095.o
 snd-soc-max9850-objs := max9850.o
+snd-soc-mc13783-objs := mc13783.o
 snd-soc-pcm3008-objs := pcm3008.o
 snd-soc-sgtl5000-objs := sgtl5000.o
 snd-soc-alc5623-objs := alc5623.o
@@ -115,6 +116,7 @@ obj-$(CONFIG_SND_SOC_JZ4740_CODEC)	+= snd-soc-jz4740-codec.o
 obj-$(CONFIG_SND_SOC_MAX98088)	+= snd-soc-max98088.o
 obj-$(CONFIG_SND_SOC_MAX98095)	+= snd-soc-max98095.o
 obj-$(CONFIG_SND_SOC_MAX9850)	+= snd-soc-max9850.o
+obj-$(CONFIG_SND_SOC_MC13783)	+= snd-soc-mc13783.o
 obj-$(CONFIG_SND_SOC_PCM3008)	+= snd-soc-pcm3008.o
 obj-$(CONFIG_SND_SOC_SGTL5000)  += snd-soc-sgtl5000.o
 obj-$(CONFIG_SND_SOC_SN95031)	+=snd-soc-sn95031.o
diff --git a/sound/soc/codecs/mc13783.c b/sound/soc/codecs/mc13783.c
new file mode 100644
index 0000000..af7603a
--- /dev/null
+++ b/sound/soc/codecs/mc13783.c
@@ -0,0 +1,781 @@
+/*
+ * Copyright 2008 Juergen Beisert, kernel at pengutronix.de
+ * Copyright 2009 Sascha Hauer, s.hauer at pengutronix.de
+ *
+ * Initial development of this code was funded by
+ * Phytec Messtechnik GmbH, http://www.phytec.de
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+ * MA  02110-1301, USA.
+ */
+#include <linux/device.h>
+#include <linux/mfd/mc13783.h>
+#include <linux/slab.h>
+#include <sound/core.h>
+#include <sound/control.h>
+#include <sound/pcm.h>
+#include <sound/soc.h>
+#include <sound/initval.h>
+#include <sound/soc-dapm.h>
+
+#include "mc13783.h"
+
+#define PMIC_AUDIO_RX_0		36
+#define PMIC_AUDIO_RX_1		37
+#define PMIC_AUDIO_TX		38
+#define PMIC_SSI_NETWORK	39
+#define PMIC_AUDIO_CODEC	40
+#define PMIC_AUDIO_DAC		41
+
+#define SSI_NETWORK_CDCTXRXSLOT(x)	(((x) & 0x3) << 2)
+#define SSI_NETWORK_CDCTXSECSLOT(x)	(((x) & 0x3) << 4)
+#define SSI_NETWORK_CDCRXSECSLOT(x)	(((x) & 0x3) << 6)
+#define SSI_NETWORK_CDCRXSECGAIN(x)	(((x) & 0x3) << 8)
+#define SSI_NETWORK_CDCSUMGAIN(x)	(1 << 10)
+#define SSI_NETWORK_CDCFSDLY(x)		(1 << 11)
+#define SSI_NETWORK_STDCSLOT(x)		(((x) & 0x3) << 12)
+#define SSI_NETWORK_STDCRXSLOT(x)	(((x) & 0x3) << 14)
+#define SSI_NETWORK_STDCRXSECSLOT(x)	(((x) & 0x3) << 16)
+#define SSI_NETWORK_STDCRXSECGAIN(x)	(((x) & 0x3) << 18)
+#define SSI_NETWORK_STDCSUMGAIN		(1 << 20)
+
+#define STEREO_DAC_STD_SSI_SEL		(1 << 0)
+#define STEREO_DAC_STD_CLK_SEL		(1 << 1)
+#define STEREO_DAC_STD_CSM		(1 << 2)
+#define STEREO_DAC_STD_BCL_INV		(1 << 3)
+#define STEREO_DAC_STD_CFS_INV		(1 << 4)
+#define STEREO_DAC_STD_CFS(x)		(((x) & 0x3) << 5)
+#define STEREO_DAC_STD_CLK(x)		(((x) & 0x7) << 7)
+#define STEREO_DAC_STD_CFS_DLY_B	(1 << 10)
+#define STEREO_DAC_STD_C_EN		(1 << 11)
+#define STEREO_DAC_STD_C_CLK_EN		(1 << 12)
+#define STEREO_DAC_STD_C_RESET		(1 << 15)
+#define STEREO_DAC_SPDIF		(1 << 16)
+#define STEREO_DAC_SR(x)		(((x) & 0xf) << 17)
+
+#define RX_0_VAUDIOON	0
+#define RX_0_BIASEN	1
+#define RX_0_BIASSPEED	2
+#define RX_0_ASPEN	3
+#define RX_0_ASPSEL	4
+#define RX_0_ALSPEN	5
+#define RX_0_ALSPREF	6
+#define RX_0_ALSPSEL	7
+#define RX_0_LSPLEN	8
+#define RX_0_AHSREN	9
+#define RX_0_AHSLEN	10
+#define RX_0_AHSSEL	11
+#define RX_0_HSPGDIG	12
+#define RX_0_HSDETEN	13
+#define RX_0_HSDETAUTOB	14
+#define RX_0_ARXOUTREN	15
+#define RX_0_ARXOUTLEN	16
+#define RX_0_ARXOUTSEL	17
+#define RX_0_CDCOUTEN	18
+#define RX_0_HSLDETEN	19
+#define RX_0_ADDCDC	21
+#define RX_0_ADDSTDC	22
+#define RX_0_ADDRXIN	23
+
+#define RX_1_PGASTEN	5
+#define RX_1_PGAST	6
+#define RX_1_ARXINEN	10
+#define RX_1_ARXIN	11
+#define RX_1_PGARXIN	12
+
+#define MC13783_REG_CACHE_SIZE	42
+
+struct mc13783_priv {
+	struct snd_soc_codec codec;
+	struct mc13783 *mc13783;
+
+	u32 reg_cache[MC13783_REG_CACHE_SIZE];
+
+	int mc13783_asp_val;
+	int mc13783_alsp_val;
+	int mc13783_ahsx_val;
+};
+
+static unsigned int mc13783_read(struct snd_soc_codec *codec,
+	unsigned int reg)
+{
+	u32 ret;
+	struct mc13783_priv *priv = snd_soc_codec_get_drvdata(codec);
+	if (reg >= MC13783_REG_CACHE_SIZE)	{
+		ret = 0;
+		printk(KERN_WARNING "%s Invalid register R%u\n", __func__, reg);
+	} else {
+		ret = priv->reg_cache[reg];
+	}
+	return ret;
+}
+
+static int mc13783_write(struct snd_soc_codec *codec,
+	unsigned int reg, unsigned int value)
+{
+	struct mc13783_priv *priv = snd_soc_codec_get_drvdata(codec);
+	int ret;
+
+	if (reg >= MC13783_REG_CACHE_SIZE) {
+		printk(KERN_WARNING "%s Invalid register R%u\n", __func__, reg);
+		ret = -1;
+	} else {
+		mc13783_lock(priv->mc13783);
+		priv->reg_cache[reg] = value;
+
+		ret = mc13783_reg_write(priv->mc13783, reg, value);
+
+		mc13783_unlock(priv->mc13783);
+	}
+	return ret;
+}
+
+/* Mapping between sample rates and register value */
+static unsigned int mc13783_rates[] = {
+	8000, 11025, 12000, 16000,
+	22050, 24000, 32000, 44100,
+	48000, 64000, 96000
+};
+
+static int mc13783_pcm_hw_params(struct snd_pcm_substream *substream,
+				struct snd_pcm_hw_params *params,
+				struct snd_soc_dai *dai)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_codec *codec = rtd->codec;
+	unsigned int rate = params_rate(params);
+	int i;
+	unsigned int reg;
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		for (i = 0; i < ARRAY_SIZE(mc13783_rates); i++) {
+			if (rate == mc13783_rates[i]) {
+				snd_soc_update_bits(codec, PMIC_AUDIO_DAC,
+						0xf << 17, i << 17);
+				return 0;
+			}
+		}
+	} else {
+		if (rate == 8000)
+			reg = 0;
+		else
+			reg = (1 << 10);
+
+		snd_soc_update_bits(codec, PMIC_AUDIO_CODEC,
+				0x1 << 10, reg);
+
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+static int mc13783_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	unsigned int reg;
+
+	if (dai->id == MC13783_ID_STEREO_DAC)
+		reg = mc13783_read(codec, PMIC_AUDIO_DAC);
+	else
+		reg = mc13783_read(codec, PMIC_AUDIO_CODEC);
+
+	reg &= ~STEREO_DAC_STD_CFS(3);
+	reg &= ~STEREO_DAC_STD_BCL_INV;
+	reg &= ~STEREO_DAC_STD_CFS_INV;
+	reg &= ~STEREO_DAC_STD_CSM;
+	reg &= ~STEREO_DAC_STD_C_CLK_EN;
+
+	/* DAI mode */
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_I2S:
+		reg |= STEREO_DAC_STD_CFS(2);
+		break;
+	case SND_SOC_DAIFMT_DSP_A:
+		reg |= STEREO_DAC_STD_CFS(1);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* DAI clock inversion */
+	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
+	case SND_SOC_DAIFMT_NB_NF:
+		reg |= STEREO_DAC_STD_BCL_INV;
+		break;
+	case SND_SOC_DAIFMT_NB_IF:
+		reg |= STEREO_DAC_STD_BCL_INV;
+		reg |= STEREO_DAC_STD_CFS_INV;
+		break;
+	case SND_SOC_DAIFMT_IB_NF:
+		break;
+	case SND_SOC_DAIFMT_IB_IF:
+		reg |= STEREO_DAC_STD_CFS_INV;
+		break;
+	}
+
+	/* DAI clock master masks */
+	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+	case SND_SOC_DAIFMT_CBM_CFM:
+		reg |= STEREO_DAC_STD_C_CLK_EN;
+		break;
+	case SND_SOC_DAIFMT_CBS_CFS:
+		reg |= STEREO_DAC_STD_CSM;
+	case SND_SOC_DAIFMT_CBM_CFS:
+	case SND_SOC_DAIFMT_CBS_CFM:
+		return -EINVAL;
+	}
+
+	reg |= STEREO_DAC_STD_C_EN;	/* DAC power up */
+	reg |= STEREO_DAC_STD_C_RESET;	/* reset filter */
+
+	if (dai->id == MC13783_ID_STEREO_DAC)
+		mc13783_write(codec, PMIC_AUDIO_DAC, reg);
+	else
+		mc13783_write(codec, PMIC_AUDIO_CODEC, reg);
+
+	return 0;
+}
+
+static int mc13783_set_sysclk(struct snd_soc_dai *dai,
+				  int clk_id, unsigned int freq, int dir)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	int clk;
+	unsigned int reg;
+
+	if (dai->id == MC13783_ID_STEREO_DAC)
+		reg = mc13783_read(codec, PMIC_AUDIO_DAC);
+	else
+		reg = mc13783_read(codec, PMIC_AUDIO_CODEC);
+
+	reg &= ~STEREO_DAC_STD_CLK(0x7);
+	reg &= ~STEREO_DAC_STD_CLK_SEL;
+
+	switch (freq) {
+	case 13000000:
+		clk = 0;
+		break;
+	case 15360000:
+		clk = 1;
+		break;
+	case 16800000:
+		clk = 2;
+		break;
+	case 26000000:
+		clk = 4;
+		break;
+	case 12000000:
+		clk = 5;
+		break;
+	case  3686400:
+		clk = 6;
+		break;
+	case 33600000:
+		clk = 7;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (clk_id == MC13783_CLK_CLIB)
+		reg |= STEREO_DAC_STD_CLK_SEL;
+
+	reg |= STEREO_DAC_STD_CLK(clk);
+
+	if (dai->id == MC13783_ID_STEREO_DAC)
+		mc13783_write(codec, PMIC_AUDIO_DAC, reg);
+	else
+		mc13783_write(codec, PMIC_AUDIO_CODEC, reg);
+
+	return 0;
+}
+
+static int mc13783_set_tdm_slot_codec(struct snd_soc_dai *dai,
+	unsigned int tx_mask, unsigned int rx_mask, int slots,
+	int slot_width)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	unsigned int reg;
+
+	if (slots != 4)
+		return -EINVAL;
+
+	reg = mc13783_read(codec, PMIC_SSI_NETWORK);
+
+	reg &= ~(0xfff << 0);
+	reg |= (0x00 << 2);	/* primary timeslot RX/TX(?) is 0 */
+	reg |= (0x01 << 4);	/* secondary timeslot TX is 1 */
+	reg |= (0x01 << 6);	/* secondary timeslot RX is 1 */
+
+	mc13783_write(codec, PMIC_SSI_NETWORK, reg);
+
+	return 0;
+}
+
+static int mc13783_get_alsp(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct mc13783_priv *priv = snd_soc_codec_get_drvdata(codec);
+
+	ucontrol->value.integer.value[0] = priv->mc13783_alsp_val;
+
+	return 0;
+}
+
+static int mc13783_put_alsp(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec =  snd_kcontrol_chip(kcontrol);
+	struct mc13783_priv *priv = snd_soc_codec_get_drvdata(codec);
+	unsigned int reg;
+
+	priv->mc13783_alsp_val = ucontrol->value.integer.value[0];
+
+	reg = mc13783_read(codec, PMIC_AUDIO_RX_0);
+
+	reg &= ~((1 << RX_0_ALSPEN) | (1 << RX_0_ALSPSEL));
+
+	if (priv->mc13783_alsp_val)
+		reg |= 1 << RX_0_ALSPEN;
+
+	if (priv->mc13783_alsp_val == 2)
+		reg |= 1 << RX_0_ALSPSEL;
+
+	mc13783_write(codec, PMIC_AUDIO_RX_0, reg);
+
+	return 0;
+}
+
+static int mc13783_get_ahsx(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct mc13783_priv *priv = snd_soc_codec_get_drvdata(codec);
+
+	ucontrol->value.integer.value[0] = priv->mc13783_ahsx_val;
+
+	return 0;
+}
+
+static int mc13783_put_ahsx(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec =  snd_kcontrol_chip(kcontrol);
+	struct mc13783_priv *priv = snd_soc_codec_get_drvdata(codec);
+	unsigned int reg;
+
+	priv->mc13783_ahsx_val = ucontrol->value.integer.value[0];
+
+	reg = mc13783_read(codec, PMIC_AUDIO_RX_0);
+
+	reg &= ~((1 << RX_0_AHSREN) | (1 << RX_0_AHSLEN) | (1 << RX_0_AHSSEL));
+
+	if (priv->mc13783_ahsx_val)
+		reg |= (1 << RX_0_AHSREN) | (1 << RX_0_AHSLEN);
+
+	if (priv->mc13783_ahsx_val == 2)
+		reg |= 1 << RX_0_AHSSEL;
+
+ 	mc13783_write(codec, PMIC_AUDIO_RX_0, reg);
+
+ 	return 0;
+ }
+
+static int mc13783_pcm_get(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec =  snd_kcontrol_chip(kcontrol);
+	int val;
+
+	val = mc13783_read(codec, PMIC_AUDIO_RX_0);
+	ucontrol->value.enumerated.item[0] = (val >> RX_0_ADDSTDC) & 1;
+	printk(KERN_DEBUG "pcm_get %d\n", ucontrol->value.enumerated.item[0]);
+
+	return 0;
+}
+
+static int mc13783_pcm_put(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec =  snd_kcontrol_chip(kcontrol);
+	unsigned int r36, r37;
+
+	r36 = mc13783_read(codec, PMIC_AUDIO_RX_0);
+	r37 = mc13783_read(codec, PMIC_AUDIO_RX_1);
+
+	r36 &= ~(1 << RX_0_ADDSTDC);
+	r37 &= ~(1 << RX_1_PGASTEN);
+
+	if (ucontrol->value.enumerated.item[0]) {
+		printk(KERN_DEBUG "pcm_put on %d\n", ucontrol->value.enumerated.item[0]);
+		r36 |= (1 << RX_0_ADDSTDC);
+		r37 |= (1 << RX_1_PGASTEN);
+	} else {
+		printk(KERN_DEBUG "pcm_put off\n");
+		r36 &= ~(1 << RX_0_ADDSTDC);
+		r37 &= ~(1 << RX_1_PGASTEN);
+	}
+
+	mc13783_write(codec, PMIC_AUDIO_RX_0, r36);
+	mc13783_write(codec, PMIC_AUDIO_RX_1, r37);
+
+	return 0;
+}
+
+static int mc13783_linein_get(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec =  snd_kcontrol_chip(kcontrol);
+	int val;
+
+	val = mc13783_read(codec, PMIC_AUDIO_RX_0);
+	ucontrol->value.enumerated.item[0] = (val >> RX_0_ADDRXIN) & 1;
+
+	return 0;
+}
+
+static int mc13783_linein_put(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec =  snd_kcontrol_chip(kcontrol);
+	unsigned int r36, r37;
+
+	r36 = mc13783_read(codec, PMIC_AUDIO_RX_0);
+	r37 = mc13783_read(codec, PMIC_AUDIO_RX_1);
+
+	r36 &= ~(1 << RX_0_ADDRXIN);
+	r37 &= ~(1 << RX_1_ARXINEN);
+
+	if (ucontrol->value.enumerated.item[0]) {
+		r36 |= (1 << RX_0_ADDRXIN);
+		r37 |= (1 << RX_1_ARXINEN);
+	} else {
+		r36 &= ~(1 << RX_0_ADDRXIN);
+		r37 &= ~(1 << RX_1_ARXINEN);
+	}
+
+	mc13783_write(codec, PMIC_AUDIO_RX_0, r36);
+	mc13783_write(codec, PMIC_AUDIO_RX_1, r37);
+
+	return 0;
+}
+
+static int mc13783_capure_cache;
+
+static int mc13783_get_capture(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	ucontrol->value.enumerated.item[0] = mc13783_capure_cache;
+	return 0;
+}
+
+#define AMC1REN (1 << 5)
+#define AMC2EN  (1 << 9)
+#define ATXINEN (1 << 11)
+#define RXINREC (1 << 13)
+#define AMC1LEN (1 << 7)
+
+static int mc13783_put_capture(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec =  snd_kcontrol_chip(kcontrol);
+	unsigned int r38, change;
+
+	r38 = mc13783_read(codec, PMIC_AUDIO_TX);
+
+	change = (mc13783_capure_cache != ucontrol->value.enumerated.item[0]);
+	mc13783_capure_cache = ucontrol->value.enumerated.item[0];
+	r38 &= ~(AMC1REN | AMC2EN | ATXINEN | RXINREC | AMC1LEN);
+
+	switch (mc13783_capure_cache) {
+	case 0:
+		break;
+	case 1:
+		r38 |= RXINREC;
+		break;
+	case 2:
+		r38 |= AMC1REN | AMC1LEN;
+		break;
+	case 3:
+		r38 |= AMC1REN;
+		break;
+	case 4:
+		r38 |= AMC2EN;
+		break;
+	case 5:
+		r38 |= AMC1LEN | AMC2EN;
+		break;
+	case 6:
+		r38 |= ATXINEN;
+		break;
+	case 7:
+		r38 |= AMC1LEN | ATXINEN;
+		break;
+	case 8:
+		r38 |= AMC1LEN | RXINREC;
+		break;
+	case 9:
+		r38 |= AMC1LEN;
+		break;
+	default:
+		break;
+	}
+
+	mc13783_write(codec, PMIC_AUDIO_TX, r38);
+
+	return change;
+}
+
+static const char *mc13783_asp[] = {"Off", "Codec", "Right"};
+static const char *mc13783_alsp[] = {"Off", "Codec", "Right"};
+
+static const char *mc13783_ahs[] = {"Codec", "Mixer"};
+
+//static const char *mc13783_ahsx[] = {"Off", "Codec", "Right"};
+
+static const char *mc13783_arxout[] = {"Codec", "Mixer"};
+
+static const char *mc13783_capture[] = {"off/off", "rxinl/rxinr",
+	"mc1lin/mc1rin", "off/mc1rin", "off/mc2in", "mc1lin/mc2in",
+	"off/txin", "mc1lin/txin", "mc1lin/rxinr", "mc1lin/off"};
+
+static const char *mc13783_3d_mixer[] =	{"Stereo", "Phase Mix",
+	"Mono", "Mono Mix"};
+
+//static const char *mc13783_pcms[] = {"Off", "On"};
+
+static const struct soc_enum mc13783_enum_asp =
+	SOC_ENUM_SINGLE(PMIC_AUDIO_RX_0, 3, ARRAY_SIZE(mc13783_asp), mc13783_asp);
+
+static const struct soc_enum mc13783_enum_alsp =
+	SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(mc13783_alsp), mc13783_alsp);
+
+static const struct soc_enum mc13783_enum_ahs =
+	SOC_ENUM_SINGLE(PMIC_AUDIO_RX_0, 11, ARRAY_SIZE(mc13783_ahs),
+			mc13783_ahs);
+
+static const struct soc_enum mc13783_enum_arxout =
+	SOC_ENUM_SINGLE(PMIC_AUDIO_RX_0, 17, ARRAY_SIZE(mc13783_arxout),
+			mc13783_arxout);
+
+static const struct soc_enum mc13783_enum_capture =
+	SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(mc13783_capture), mc13783_capture);
+
+static const struct soc_enum mc13783_enum_3d_mixer =
+	SOC_ENUM_SINGLE(PMIC_AUDIO_RX_1, 16, ARRAY_SIZE(mc13783_3d_mixer),
+			mc13783_3d_mixer);
+
+//static const struct soc_enum mc13783_enum_ahsx =
+//	SOC_ENUM_SINGLE(PMIC_AUDIO_RX_0, 9, ARRAY_SIZE(mc13783_ahsx),
+//			mc13783_ahsx);
+//
+//static const struct soc_enum mc13783_enum_pcms =
+//	SOC_ENUM_SINGLE(PMIC_AUDIO_RX_1, 5, ARRAY_SIZE(mc13783_pcms),
+//			mc13783_pcms);
+
+static struct snd_kcontrol_new mc13783_control_list[] = {
+	/* Output Routing */
+	SOC_ENUM("Asp Source", mc13783_enum_asp),
+	SOC_ENUM_EXT("Alsp Source", mc13783_enum_alsp, mc13783_get_alsp,
+			mc13783_put_alsp),
+	SOC_ENUM("Ahs Source", mc13783_enum_ahs),
+	SOC_SINGLE("Ahsr enable", PMIC_AUDIO_RX_0, 9, 1, 0),
+	SOC_SINGLE("Ahsl enable", PMIC_AUDIO_RX_0, 10, 1, 0),
+/* instead of the above 3 lines, could put this line: */
+//	SOC_ENUM_EXT("Ahs Source", mc13783_enum_ahsx, mc13783_get_ahsx,
+//			mc13783_put_ahsx),
+////	SOC_ENUM("Ahs Source", mc13783_enum_ahs),
+////	SOC_SINGLE("Ahsr enable", PMIC_AUDIO_RX_0, 9, 2, 0),
+////	SOC_SINGLE("Ahsl enable", PMIC_AUDIO_RX_0, 10, 2, 0),
+////	SOC_ENUM("Ahsr enable", mc13783_enum_ahsr),
+////	SOC_ENUM("Ahsl enable", mc13783_enum_ahsl),
+	SOC_ENUM("Arxout Source", mc13783_enum_arxout),
+	SOC_SINGLE("ArxoutR enable", PMIC_AUDIO_RX_0, 16, 1, 0),
+	SOC_SINGLE("ArxoutL enable", PMIC_AUDIO_RX_0, 15, 1, 0),
+	SOC_SINGLE_EXT("PCM Playback Switch", 0, 0, 1, 0, mc13783_pcm_get,
+//	SOC_ENUM_EXT("PCMS Playback Switch", mc13783_enum_pcms, mc13783_pcm_get,
+			mc13783_pcm_put),
+	SOC_SINGLE("PCM Playback Volume", PMIC_AUDIO_RX_1, 6, 15, 0),
+//	SOC_SINGLE("PCMP Playback Volume", PMIC_AUDIO_RX_1, RX_1_PGAST, 15, 0),
+	SOC_SINGLE_EXT("Line in Switch", 0, 0, 1, 0, mc13783_linein_get,
+			mc13783_linein_put),
+	SOC_SINGLE("Line in Volume", PMIC_AUDIO_RX_1, 12, 15, 0),
+//	SOC_SINGLE("Line in Volume", PMIC_AUDIO_RX_1, RX_1_PGARXIN, 15, 0),
+	SOC_ENUM_EXT("Capture Source", mc13783_enum_capture, mc13783_get_capture,
+			mc13783_put_capture),
+	SOC_DOUBLE("PCM Capture Volume", PMIC_AUDIO_TX, 19, 14, 31, 0),
+	SOC_ENUM("3D Control", mc13783_enum_3d_mixer),
+};
+
+static int mc13783_probe(struct snd_soc_codec *codec)
+{
+	struct mc13783_priv *priv = snd_soc_codec_get_drvdata(codec);
+	int i, ret = 0;
+
+	/* these are the reset values */
+	priv->reg_cache[PMIC_AUDIO_RX_0]  = (1 << RX_0_HSPGDIG); //0x001000;
+	priv->reg_cache[PMIC_AUDIO_RX_1]  = 0x00d35A;
+	priv->reg_cache[PMIC_AUDIO_TX]    = 0x420000;
+	priv->reg_cache[PMIC_SSI_NETWORK] = 0x013060;
+	priv->reg_cache[PMIC_AUDIO_CODEC] = 0x180027;
+	priv->reg_cache[PMIC_AUDIO_DAC]   = 0x0e0004;
+
+	/* VAUDIOON -> supply audio part, BIAS enable */
+	priv->reg_cache[PMIC_AUDIO_RX_0] |= (1 << RX_0_VAUDIOON) | (1 << RX_0_BIASEN); //0x3;
+
+	for (i = 36; i < 42; i++)
+		mc13783_write(codec, i, priv->reg_cache[i]);
+
+	snd_soc_add_controls(codec, mc13783_control_list,
+			     ARRAY_SIZE(mc13783_control_list));
+
+	return ret;
+}
+
+static int mc13783_remove(struct snd_soc_codec *codec)
+{
+	unsigned int reg;
+
+	reg = mc13783_read(codec, PMIC_AUDIO_RX_0);
+
+	/* VAUDIOON -> switch off audio part, BIAS disable */
+	reg &= ~0x3;
+
+	mc13783_write(codec, PMIC_AUDIO_RX_0, reg);
+
+	return 0;
+}
+
+#define MC13783_RATES_RECORD (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_16000)
+
+#define MC13783_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE |\
+	SNDRV_PCM_FMTBIT_S24_LE)
+/*Other functions (soc_dai.h):
+ * set_pll, set_clkdiv
+ * set_tdm_slot, set_channel_map, set_tristate
+ * digital_mute
+ * startup, shutdown, hw_free, prepare, trigger
+*/
+static struct snd_soc_dai_ops mc13783_ops = {
+	.hw_params	= mc13783_pcm_hw_params,
+	.set_fmt	= mc13783_set_fmt,
+	.set_sysclk	= mc13783_set_sysclk,
+	.set_tdm_slot	= mc13783_set_tdm_slot_codec,
+};
+
+static struct snd_soc_dai_driver mc13783_dai = {
+	.name = "mc13783-hifi",
+	.playback = {
+		.stream_name = "Playback",
+		.channels_min = 1,
+		.channels_max = 2,
+		.rates = SNDRV_PCM_RATE_8000_96000,
+		.formats = MC13783_FORMATS,
+	},
+	.capture = {
+		.stream_name = "Capture",
+		.channels_min = 1,
+		.channels_max = 2,
+		.rates = MC13783_RATES_RECORD,
+		.formats = MC13783_FORMATS,
+	},
+	.ops = &mc13783_ops,
+};
+
+/*
+ * ASoC codec device structure
+ *
+ * Assign this variable to the codec_dev field of the machine driver's
+ * snd_soc_device structure.
+ */
+static struct snd_soc_codec_driver soc_codec_dev_mc13783 = {
+	.probe = 	mc13783_probe,
+	.remove = 	mc13783_remove,
+//  .suspend
+//  .resume
+	.read = 	mc13783_read,
+	.write = 	mc13783_write,
+//	.display_register
+//	.volatile_register
+//	.readable_register
+//	.reg_cache_size = MC13783_REG_CACHE_SIZE, TODO: use codec->reg_cache instead of privately
+//	reg_cache_step
+//	.reg_word_size = sizeof(u32), TODO: else: kmemdup error in soc-core.c::snd_soc_register_codec
+//	.reg_cache_default = wm8960_reg,
+//	.compress_type
+//	.set_bias_level
+};
+
+static int mc13783_codec_probe(struct platform_device *pdev)
+{
+	struct mc13783 *mc13783;
+	struct mc13783_priv *priv;
+	int ret;
+
+	mc13783 = dev_get_drvdata(pdev->dev.parent);
+
+	priv = kzalloc(sizeof(struct mc13783_priv), GFP_KERNEL);
+	if (priv == NULL)
+		return -ENOMEM;
+
+	dev_set_drvdata(&pdev->dev, priv);
+	priv->mc13783 = mc13783;
+
+	ret = snd_soc_register_codec(&pdev->dev, &soc_codec_dev_mc13783, &mc13783_dai, 1);
+	if (ret)
+		goto err_register_codec;
+
+	return 0;
+
+err_register_codec:
+	dev_err(&pdev->dev, "register codec failed with %d\n", ret);
+	kfree(priv);
+
+	return ret;
+}
+
+static int mc13783_codec_remove(struct platform_device *pdev)
+{
+	snd_soc_unregister_codec(&pdev->dev);
+
+	return 0;
+}
+
+static struct platform_driver mc13783_codec_driver = {
+	.driver = {
+		   .name = "mc13783-codec",
+		   .owner = THIS_MODULE,
+		   },
+	.probe = mc13783_codec_probe,
+	.remove = __devexit_p(mc13783_codec_remove),
+};
+
+static __init int mc13783_init(void)
+{
+	return platform_driver_register(&mc13783_codec_driver);
+}
+
+static __exit void mc13783_exit(void)
+{
+	platform_driver_unregister(&mc13783_codec_driver);
+}
+
+module_init(mc13783_init);
+module_exit(mc13783_exit);
+
+MODULE_DESCRIPTION("ASoC MC13783 driver");
+MODULE_AUTHOR("Sascha Hauer, Pengutronix <s.hauer@pengutronix.de>");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/mc13783.h b/sound/soc/codecs/mc13783.h
new file mode 100644
index 0000000..7285370
--- /dev/null
+++ b/sound/soc/codecs/mc13783.h
@@ -0,0 +1,29 @@
+/*
+ * Copyright 2008 Juergen Beisert, kernel at pengutronix.de
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
+ */
+
+#ifndef MC13783_MIXER_H
+#define MC13783_MIXER_H
+
+extern int mc13783_add_ctl(struct snd_card*, void *);
+
+#define MC13783_CLK_CLIA	1
+#define MC13783_CLK_CLIB	2
+
+#define MC13783_ID_STEREO_DAC	1
+#define MC13783_ID_STEREO_CODEC	2
+
+#endif /* MC13783_MIXER_H */
-- 
1.7.1
