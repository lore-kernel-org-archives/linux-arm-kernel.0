From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 19 Nov 2009 16:48:17 +0100
Subject: [PATCH 03/12] add a mc13783 codec driver
In-Reply-To: <1258645706-9071-3-git-send-email-s.hauer@pengutronix.de>
References: <1258645706-9071-1-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-2-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-3-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1258645706-9071-4-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 sound/soc/codecs/Kconfig   |    3 +
 sound/soc/codecs/Makefile  |    2 +
 sound/soc/codecs/mc13783.c |  739 ++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/mc13783.h |   29 ++
 4 files changed, 773 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/codecs/mc13783.c
 create mode 100644 sound/soc/codecs/mc13783.h

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 0edca93..bed402e 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -114,6 +114,9 @@ config SND_SOC_CX20442
 config SND_SOC_L3
        tristate
 
+config SND_SOC_MC13783
+	tristate
+
 config SND_SOC_PCM3008
        tristate
 
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index fb4af28..d524e90 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -9,6 +9,7 @@ snd-soc-ak4642-objs := ak4642.o
 snd-soc-cs4270-objs := cs4270.o
 snd-soc-cx20442-objs := cx20442.o
 snd-soc-l3-objs := l3.o
+snd-soc-mc13783-objs := mc13783.o
 snd-soc-pcm3008-objs := pcm3008.o
 snd-soc-spdif-objs := spdif_transciever.o
 snd-soc-ssm2602-objs := ssm2602.o
@@ -59,6 +60,7 @@ obj-$(CONFIG_SND_SOC_AK4642)	+= snd-soc-ak4642.o
 obj-$(CONFIG_SND_SOC_CS4270)	+= snd-soc-cs4270.o
 obj-$(CONFIG_SND_SOC_CX20442)	+= snd-soc-cx20442.o
 obj-$(CONFIG_SND_SOC_L3)	+= snd-soc-l3.o
+obj-$(CONFIG_SND_SOC_MC13783)	+= snd-soc-mc13783.o
 obj-$(CONFIG_SND_SOC_PCM3008)	+= snd-soc-pcm3008.o
 obj-$(CONFIG_SND_SOC_SPDIF)	+= snd-soc-spdif.o
 obj-$(CONFIG_SND_SOC_SSM2602)	+= snd-soc-ssm2602.o
diff --git a/sound/soc/codecs/mc13783.c b/sound/soc/codecs/mc13783.c
new file mode 100644
index 0000000..278ee65
--- /dev/null
+++ b/sound/soc/codecs/mc13783.c
@@ -0,0 +1,739 @@
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
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
+ */
+#include <linux/device.h>
+#include <linux/mfd/mc13783-private.h>
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
+static struct mc13783 *mc13783;
+
+struct mc13783_priv {
+	struct snd_soc_codec codec;
+
+	u32 reg_cache[42];
+};
+
+static unsigned int mc13783_read(struct snd_soc_codec *codec,
+	unsigned int reg)
+{
+	struct mc13783_priv *priv = codec->private_data;
+
+	return priv->reg_cache[reg];
+}
+
+static int mc13783_write(struct snd_soc_codec *codec,
+	unsigned int reg, unsigned int value)
+{
+	struct mc13783_priv *priv = codec->private_data;
+
+	priv->reg_cache[reg] = value;
+
+	mc13783_reg_write(mc13783, reg, value);
+
+	return 0;
+}
+
+/* sample rates supported by PMIC for stereo playback operations on StDac. */
+static unsigned int mc13783_rates[] = {
+	8000, 11025, 12000, 16000,
+	22050, 24000, 32000,44100,
+	48000, 64000, 96000
+};
+
+static int mc13783_pcm_hw_params(struct snd_pcm_substream *substream,
+				struct snd_pcm_hw_params *params,
+				struct snd_soc_dai *dai)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_device *socdev = rtd->socdev;
+	struct snd_soc_codec *codec = socdev->card->codec;
+	unsigned int rate = params_rate(params);
+	int i;
+	unsigned int reg;
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		for (i = 0; i < ARRAY_SIZE(mc13783_rates); i++) {
+			if (rate == mc13783_rates[i]) {
+				reg = mc13783_read(codec, PMIC_AUDIO_DAC);
+				/* setup the clock speed */
+				reg &= ~(0xf << 17);
+				reg |= i << 17;
+				mc13783_write(codec, PMIC_AUDIO_DAC, reg);
+				return 0;
+			}
+		}
+	} else {
+		reg = mc13783_read(codec, PMIC_AUDIO_CODEC);
+
+		if (rate == 8000)
+			reg &= ~(1 << 10);
+		else
+			reg |= (1 << 10);
+
+		mc13783_write(codec, PMIC_AUDIO_CODEC, reg);
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
+	if (dai->id == 1)
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
+	if (dai->id == 1)
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
+	if (dai->id == 1)
+		reg = mc13783_read(codec, PMIC_AUDIO_DAC);
+	else
+		reg = mc13783_read(codec, PMIC_AUDIO_CODEC);
+
+	reg &= ~STEREO_DAC_STD_CLK(0x7);
+	reg &= ~STEREO_DAC_STD_CLK_SEL;
+
+	switch (freq) {
+		case 13000000:
+			clk = 0;
+			break;
+		case 15360000:
+			clk = 1;
+			break;
+		case 16800000:
+			clk = 2;
+			break;
+		case 26000000:
+			clk = 4;
+			break;
+		case 12000000:
+			clk = 5;
+			break;
+		case  3686400:
+			clk = 6;
+			break;
+		case 33600000:
+			clk = 7;
+			break;
+		default:
+			return -EINVAL;
+	}
+
+	if (clk_id == MC13783_CLK_CLIB)
+		reg |= STEREO_DAC_STD_CLK_SEL;
+
+	reg |= STEREO_DAC_STD_CLK(clk);
+
+	if (dai->id == 1)
+		mc13783_write(codec, PMIC_AUDIO_DAC, reg);
+	else
+		mc13783_write(codec, PMIC_AUDIO_CODEC, reg);
+
+	return 0;
+}
+
+static int mc13783_set_tdm_slot_codec(struct snd_soc_dai *dai,
+	unsigned int tx_mask, unsigned int rx_mask, int slots, int slot_width)
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
+static int mc13783_asp_val;
+
+static int mc13783_get_asp(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	ucontrol->value.integer.value[0] = mc13783_asp_val;
+	return 0;
+}
+
+static int mc13783_put_asp(struct snd_kcontrol *kcontrol,
+        struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec =  snd_kcontrol_chip(kcontrol);
+	unsigned int reg;
+
+	mc13783_asp_val = ucontrol->value.integer.value[0];
+
+	reg = mc13783_read(codec, PMIC_AUDIO_RX_0);
+
+	reg &= ~(0x3 << 3);
+	reg |= mc13783_asp_val << 3;
+
+	mc13783_write(codec, PMIC_AUDIO_RX_0, reg);
+
+	return 0;
+}
+
+static int mc13783_alsp_val;
+
+static int mc13783_get_alsp(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	ucontrol->value.integer.value[0] = mc13783_alsp_val;
+	return 0;
+}
+
+static int mc13783_put_alsp(struct snd_kcontrol *kcontrol,
+        struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec =  snd_kcontrol_chip(kcontrol);
+	unsigned int reg;
+	mc13783_alsp_val = ucontrol->value.integer.value[0];
+
+	reg = mc13783_read(codec, PMIC_AUDIO_RX_0);
+
+	reg &= ~((1 << 5) | (1 << 7));
+
+	if (mc13783_alsp_val)
+		reg |= 1 << 5;
+
+	if (mc13783_alsp_val == 2)
+		reg |= 1 << 7;
+
+	mc13783_write(codec, PMIC_AUDIO_RX_0, reg);
+
+	return 0;
+}
+
+static int mc13783_pcm_get(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec =  snd_kcontrol_chip(kcontrol);
+	int val;
+
+	val = mc13783_read(codec, PMIC_AUDIO_RX_0);
+	ucontrol->value.enumerated.item[0] = (val >> 22) & 1;
+
+        return 0;
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
+	r36 &= ~(1 << 22);
+	r37 &= ~(1 << 5);
+
+	if (ucontrol->value.enumerated.item[0]) {
+		r36 |= (1 << 22);
+		r37 |= (1 << 5);
+	} else {
+		r36 &= ~(1 << 22);
+		r37 &= ~(1 << 5);
+	}
+
+	mc13783_write(codec, PMIC_AUDIO_RX_0, r36);
+	mc13783_write(codec, PMIC_AUDIO_RX_1, r37);
+
+        return 0;
+}
+
+static int mc13783_linein_get(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec =  snd_kcontrol_chip(kcontrol);
+	int val;
+
+	val = mc13783_read(codec, PMIC_AUDIO_RX_0);
+	ucontrol->value.enumerated.item[0] = (val >> 23) & 1;
+
+        return 0;
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
+	r36 &= ~(1 << 23);
+	r37 &= ~(1 << 10);
+
+	if (ucontrol->value.enumerated.item[0]) {
+		r36 |= (1 << 23);
+		r37 |= (1 << 10);
+	} else {
+		r36 &= ~(1 << 23);
+		r37 &= ~(1 << 10);
+	}
+
+	mc13783_write(codec, PMIC_AUDIO_RX_0, r36);
+	mc13783_write(codec, PMIC_AUDIO_RX_1, r37);
+
+        return 0;
+}
+
+static int mc13783_capure_cache;
+
+static int mc13783_get_capture(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	ucontrol->value.enumerated.item[0] = mc13783_capure_cache;
+        return 0;
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
+static const char *mc13783_arxout[] = {"Codec", "Mixer"};
+
+static const char *mc13783_capture[] = {"off/off", "rxinl/rxinr",
+	"mc1lin/mc1rin", "off/mc1rin", "off/mc2in", "mc1lin/mc2in",
+	"off/txin", "mc1lin/txin", "mc1lin/rxinr", "mc1lin/off"};
+
+static const char *mc13783_3d_mixer[] = {"Stereo", "Phase Mix", "Mono", "Mono Mix"};
+
+static const struct soc_enum mc13783_enum[] = {
+	SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(mc13783_asp), mc13783_asp),
+	SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(mc13783_alsp), mc13783_alsp),
+
+	SOC_ENUM_SINGLE(PMIC_AUDIO_RX_0, 11, ARRAY_SIZE(mc13783_ahs), mc13783_ahs),
+	SOC_ENUM_SINGLE(PMIC_AUDIO_RX_0, 17, ARRAY_SIZE(mc13783_arxout), mc13783_arxout),
+
+	SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(mc13783_capture), mc13783_capture),
+	SOC_ENUM_SINGLE(PMIC_AUDIO_RX_1, 16, ARRAY_SIZE(mc13783_3d_mixer), mc13783_3d_mixer),
+};
+
+static struct snd_kcontrol_new mc13783_control_list[] = {
+	/* Output Routing */
+	SOC_ENUM_EXT("Asp Source", mc13783_enum[0], mc13783_get_asp, mc13783_put_asp),
+	SOC_ENUM_EXT("Alsp Source", mc13783_enum[1], mc13783_get_alsp, mc13783_put_alsp),
+	SOC_ENUM("Ahs Source", mc13783_enum[2]),
+	SOC_SINGLE("Ahsr enable", PMIC_AUDIO_RX_0, 9, 1, 0),
+	SOC_SINGLE("Ahsl enable", PMIC_AUDIO_RX_0, 10, 1, 0),
+	SOC_ENUM("Arxout Source", mc13783_enum[3]),
+	SOC_SINGLE("ArxoutR enable", PMIC_AUDIO_RX_0, 16, 1, 0),
+	SOC_SINGLE("ArxoutL enable", PMIC_AUDIO_RX_0, 15, 1, 0),
+	SOC_SINGLE_EXT("PCM Playback Switch", 0, 0, 1, 0, mc13783_pcm_get, mc13783_pcm_put),
+	SOC_SINGLE("PCM Playback Volume", PMIC_AUDIO_RX_1, 6, 15, 0),
+	SOC_SINGLE_EXT("Line in Switch", 0, 0, 1, 0, mc13783_linein_get, mc13783_linein_put),
+	SOC_SINGLE("Line in Volume", PMIC_AUDIO_RX_1, 12, 15, 0),
+	SOC_ENUM_EXT("Capture Source", mc13783_enum[4], mc13783_get_capture, mc13783_put_capture),
+	SOC_DOUBLE("PCM Capture Volume", PMIC_AUDIO_TX, 19, 14, 31, 0),
+	SOC_ENUM("3D Control - Switch", mc13783_enum[5]),
+};
+
+static struct snd_soc_codec *mc13783_codec;
+
+static int mc13783_probe(struct platform_device *pdev)
+{
+	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
+	struct snd_soc_codec *codec = mc13783_codec;
+	struct mc13783_priv *priv = codec->private_data;
+	int i, ret = 0;
+
+	if (mc13783_codec == NULL) {
+		dev_err(&pdev->dev, "Codec device not registered\n");
+		return -ENODEV;
+	}
+
+	/* these are the reset values */
+	priv->reg_cache[PMIC_AUDIO_RX_0]  = 0x001000;
+	priv->reg_cache[PMIC_AUDIO_RX_1]  = 0x00d35A;
+	priv->reg_cache[PMIC_AUDIO_TX]    = 0x420000;
+	priv->reg_cache[PMIC_SSI_NETWORK] = 0x013060;
+	priv->reg_cache[PMIC_AUDIO_CODEC] = 0x180027;
+	priv->reg_cache[PMIC_AUDIO_DAC]   = 0x0e0004;
+
+	/* VAUDIOON -> supply audio part, BIAS enable */
+	priv->reg_cache[PMIC_AUDIO_RX_0] |= 0x3;
+
+	for (i = 36; i < 42; i++)
+		mc13783_write(codec, i, priv->reg_cache[i]);
+
+	socdev->card->codec = mc13783_codec;
+
+	/* register pcms */
+	ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
+	if (ret < 0) {
+		dev_err(codec->dev, "failed to create pcms: %d\n", ret);
+		goto pcm_err;
+	}
+
+	snd_soc_add_controls(codec, mc13783_control_list,
+			     ARRAY_SIZE(mc13783_control_list));
+	ret = snd_soc_init_card(socdev);
+	if (ret < 0) {
+		dev_err(codec->dev, "failed to register card: %d\n", ret);
+		goto card_err;
+	}
+
+	return ret;
+
+card_err:
+	snd_soc_free_pcms(socdev);
+	snd_soc_dapm_free(socdev);
+pcm_err:
+	return ret;
+}
+
+static int mc13783_remove(struct platform_device *pdev)
+{
+	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
+	struct snd_soc_codec *codec = mc13783_codec;
+	unsigned int reg;
+
+	reg = mc13783_read(codec, PMIC_AUDIO_RX_0);
+
+	/* VAUDIOON -> switch off audio part, BIAS disable */
+	reg &= ~0x3;
+
+	mc13783_write(codec, PMIC_AUDIO_RX_0, reg);
+
+	snd_soc_free_pcms(socdev);
+	snd_soc_dapm_free(socdev);
+
+	return 0;
+}
+
+#define MC13783_RATES_PLAYBACK (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_11025 |\
+	SNDRV_PCM_RATE_16000 | SNDRV_PCM_RATE_22050 | SNDRV_PCM_RATE_44100 | \
+	SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_88200 | SNDRV_PCM_RATE_96000)
+
+#define MC13783_RATES_RECORD (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_16000)
+
+#define MC13783_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE |\
+	SNDRV_PCM_FMTBIT_S24_LE)
+
+static struct snd_soc_dai_ops mc13783_ops_dac = {
+	.hw_params	= mc13783_pcm_hw_params,
+	.set_fmt	= mc13783_set_fmt,
+	.set_sysclk	= mc13783_set_sysclk,
+};
+
+static struct snd_soc_dai_ops mc13783_ops_voice_codec = {
+	.hw_params	= mc13783_pcm_hw_params,
+	.set_fmt	= mc13783_set_fmt,
+	.set_sysclk	= mc13783_set_sysclk,
+	.set_tdm_slot	= mc13783_set_tdm_slot_codec,
+};
+
+struct snd_soc_dai mc13783_dai[] = {
+	{
+		.name	= "MC13783 Playback",
+		.id	= 1,
+		.playback = {
+			.stream_name	= "Playback",
+			.channels_min	= 1,
+			.channels_max	= 2,
+			.rates		= MC13783_RATES_PLAYBACK,
+			.formats	= MC13783_FORMATS,
+		},
+		.ops	= &mc13783_ops_dac,
+	}, {
+		.name	= "MC13783 Capture",
+		.id	= 2,
+		.capture = {
+			.stream_name	= "Capture",
+			.channels_min	= 1,
+			.channels_max	= 2,
+			.rates		= MC13783_RATES_RECORD,
+			.formats	= MC13783_FORMATS,
+		},
+		.ops	= &mc13783_ops_voice_codec,
+	},
+};
+EXPORT_SYMBOL_GPL(mc13783_dai);
+
+struct snd_soc_codec_device soc_codec_dev_mc13783 = {
+	.probe = 	mc13783_probe,
+	.remove = 	mc13783_remove,
+};
+EXPORT_SYMBOL_GPL(soc_codec_dev_mc13783);
+
+/*
+ * OK, this stinks. We currently only can support one MC13783.
+ * Lets take it as an intermediate to turn this stuff into SoC
+ * Audio.
+ */
+static int mc13783_codec_probe(struct platform_device *pdev)
+{
+	struct mc13783_priv *priv;
+	struct snd_soc_codec *codec;
+	int ret;
+
+	printk(KERN_INFO "MC13783 Audio Codec\n");
+
+	if (mc13783)
+		return -EBUSY;
+
+	mc13783 = dev_get_drvdata(pdev->dev.parent);
+
+	priv = kzalloc(sizeof(struct mc13783_priv), GFP_KERNEL);
+	if (priv == NULL)
+		return -ENOMEM;
+
+	codec = &priv->codec;
+	codec->private_data = priv;
+	mc13783_codec = codec;
+
+	mutex_init(&codec->mutex);
+	INIT_LIST_HEAD(&codec->dapm_widgets);
+	INIT_LIST_HEAD(&codec->dapm_paths);
+
+	codec->name = "mc13783";
+	codec->owner = THIS_MODULE;
+	codec->read = mc13783_read;
+	codec->write = mc13783_write;
+	codec->dai = mc13783_dai;
+	codec->num_dai = ARRAY_SIZE(mc13783_dai);
+	codec->control_data = priv;
+	codec->dev = &pdev->dev;
+
+	mc13783_dai[0].dev = codec->dev;
+	mc13783_dai[1].dev = codec->dev;
+
+	ret = snd_soc_register_dais(mc13783_dai, ARRAY_SIZE(mc13783_dai));
+	if (ret)
+		goto out;
+
+	ret = snd_soc_register_codec(codec);
+	if (ret)
+		goto out;
+
+	return 0;
+out:
+	printk("register codec failed with %d\n", ret);
+	kfree(priv);
+	return ret;
+}
+
+static int mc13783_codec_remove(struct platform_device *pdev)
+{
+	mc13783 = NULL;
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
index 0000000..f0da0ee
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
+extern struct snd_soc_dai mc13783_dai[];
+extern struct snd_soc_codec_device soc_codec_dev_mc13783;
+
+#define MC13783_CLK_CLIA	1
+#define MC13783_CLK_CLIB	2
+
+#endif /* MC13783_MIXER_H */
-- 
1.6.5.2
