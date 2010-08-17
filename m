From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Tue, 17 Aug 2010 13:53:14 +0800
Subject: [PATCH 3/3] ASoC: add saarb machine driver for 88pm860x
Message-ID: <mailman.180.1282031303.27306.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

88PM860x codec is used in Marvell saarb development board. 88PM860x codec
is used as master mode for SSP communication. Only I2S format is supported.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 sound/soc/pxa/Kconfig  |    9 +++
 sound/soc/pxa/Makefile |    2 +
 sound/soc/pxa/saarb.c  |  178 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 189 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/pxa/saarb.c

diff --git a/sound/soc/pxa/Kconfig b/sound/soc/pxa/Kconfig
index 04ddc7b..37f191b 100644
--- a/sound/soc/pxa/Kconfig
+++ b/sound/soc/pxa/Kconfig
@@ -117,6 +117,15 @@ config SND_PXA2XX_SOC_PALM27X
 	  Say Y if you want to add support for SoC audio on
 	  Palm T|X, T5, E2 or LifeDrive handheld computer.

+config SND_SOC_SAARB
+	tristate "SoC Audio support for Marvell Saarb"
+	depends on SND_PXA2XX_SOC && MACH_SAARB
+	select SND_PXA_SOC_SSP
+	select SND_SOC_88PM860X
+	help
+	  Say Y if you want to add support for SoC audio on the
+	  Marvell Saarb reference platform.
+
 config SND_SOC_TAVOREVB3
 	tristate "SoC Audio support for Marvell Tavor EVB3"
 	depends on SND_PXA2XX_SOC && MACH_TAVOREVB3
diff --git a/sound/soc/pxa/Makefile b/sound/soc/pxa/Makefile
index 315941f..0766016 100644
--- a/sound/soc/pxa/Makefile
+++ b/sound/soc/pxa/Makefile
@@ -19,6 +19,7 @@ snd-soc-e800-objs := e800_wm9712.o
 snd-soc-spitz-objs := spitz.o
 snd-soc-em-x270-objs := em-x270.o
 snd-soc-palm27x-objs := palm27x.o
+snd-soc-saarb-objs := saarb.o
 snd-soc-tavorevb3-objs := tavorevb3.o
 snd-soc-zylonite-objs := zylonite.o
 snd-soc-magician-objs := magician.o
@@ -39,6 +40,7 @@ obj-$(CONFIG_SND_PXA2XX_SOC_PALM27X) += snd-soc-palm27x.o
 obj-$(CONFIG_SND_PXA2XX_SOC_MAGICIAN) += snd-soc-magician.o
 obj-$(CONFIG_SND_PXA2XX_SOC_MIOA701) += snd-soc-mioa701.o
 obj-$(CONFIG_SND_PXA2XX_SOC_Z2) += snd-soc-z2.o
+obj-$(CONFIG_SND_SOC_SAARB) += snd-soc-saarb.o
 obj-$(CONFIG_SND_SOC_TAVOREVB3) += snd-soc-tavorevb3.o
 obj-$(CONFIG_SND_SOC_ZYLONITE) += snd-soc-zylonite.o
 obj-$(CONFIG_SND_PXA2XX_SOC_IMOTE2) += snd-soc-imote2.o
diff --git a/sound/soc/pxa/saarb.c b/sound/soc/pxa/saarb.c
new file mode 100644
index 0000000..3f6ec57
--- /dev/null
+++ b/sound/soc/pxa/saarb.c
@@ -0,0 +1,178 @@
+/*
+ * saarb.c -- SoC audio for saarb
+ *
+ * Copyright (C) 2010 Marvell International Ltd.
+ * 	Haojian Zhuang <haojian.zhuang@marvell.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/device.h>
+#include <linux/clk.h>
+#include <linux/i2c.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+
+#include <asm/mach-types.h>
+
+#include "../codecs/88pm860x-codec.h"
+#include "pxa-ssp.h"
+
+static int saarb_pm860x_init(struct snd_soc_pcm_runtime *rtd);
+
+static struct platform_device *saarb_snd_device;
+/* saarb machine dapm widgets */
+static const struct snd_soc_dapm_widget saarb_dapm_widgets[] = {
+	SND_SOC_DAPM_HP("Headphone", NULL),
+	SND_SOC_DAPM_LINE("Lineout Out 1", NULL),
+	SND_SOC_DAPM_LINE("Lineout Out 2", NULL),
+	SND_SOC_DAPM_SPK("Board Speaker", NULL),
+	SND_SOC_DAPM_MIC("Board Mic 1", NULL),
+	SND_SOC_DAPM_MIC("Headset Mic", NULL),
+	SND_SOC_DAPM_MIC("Board Mic 3", NULL),
+};
+
+/* saarb machine audio map */
+static const struct snd_soc_dapm_route audio_map[] = {
+	{"Headphone", NULL, "HS1"},
+	{"Headphone", NULL, "HS2"},
+
+	{"Board Speaker", NULL, "LSP"},
+	{"Board Speaker", NULL, "LSN"},
+
+	{"Lineout Out 1", NULL, "LINEOUT1"},
+	{"Lineout Out 2", NULL, "LINEOUT2"},
+
+	{"MIC1P", NULL, "Mic1 Bias"},
+	{"MIC1N", NULL, "Mic1 Bias"},
+	{"Mic1 Bias", NULL, "Board Mic 1"},
+
+	{"MIC2P", NULL, "Mic1 Bias"},
+	{"MIC2N", NULL, "Mic1 Bias"},
+	{"Mic1 Bias", NULL, "Headset Mic"},
+
+	{"MIC3P", NULL, "Mic3 Bias"},
+	{"MIC3N", NULL, "Mic3 Bias"},
+	{"Mic3 Bias", NULL, "Board Mic 3"},
+};
+
+static const struct snd_kcontrol_new pm860x_saarb_controls[] = {
+	SOC_DAPM_PIN_SWITCH("Board Speaker"),
+	SOC_DAPM_PIN_SWITCH("Board Mic 1"),
+	SOC_DAPM_PIN_SWITCH("Board Mic 3"),
+};
+
+static int saarb_i2s_hw_params(struct snd_pcm_substream *substream,
+				struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	int width = snd_pcm_format_physical_width(params_format(params));
+	int ret;
+
+	ret = snd_soc_dai_set_sysclk(cpu_dai, PXA_SSP_CLK_NET_PLL, 0,
+				     PM860X_CLK_DIR_OUT);
+	if (ret < 0)
+		return ret;
+
+	ret = snd_soc_dai_set_sysclk(codec_dai, 0, 0, PM860X_CLK_DIR_OUT);
+	if (ret < 0)
+		return ret;
+
+	ret = snd_soc_dai_set_fmt(cpu_dai, SND_SOC_DAIFMT_I2S |
+			SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBM_CFM);
+	if (ret < 0)
+		return ret;
+	ret = snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_I2S |
+			SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBM_CFM);
+	if (ret < 0)
+		return ret;
+
+	ret = snd_soc_dai_set_tdm_slot(cpu_dai, 3, 3, 2, width);
+
+	return ret;
+}
+
+static struct snd_soc_ops saarb_i2s_ops = {
+	.hw_params	= saarb_i2s_hw_params,
+};
+
+static struct snd_soc_dai_link saarb_dai[] = {
+	{
+		.name		= "88PM860x I2S",
+		.stream_name	= "I2S Audio",
+		.cpu_dai_name	= "pxa-ssp-dai.1",
+		.codec_dai_name	= "88pm860x-i2s",
+		.platform_name	= "pxa-pcm-audio",
+		.codec_name	= "88pm860x-codec",
+		.init		= saarb_pm860x_init,
+		.ops		= &saarb_i2s_ops,
+	},
+};
+
+static struct snd_soc_card snd_soc_card_saarb = {
+	.name = "Saarb",
+	.dai_link = saarb_dai,
+	.num_links = ARRAY_SIZE(saarb_dai),
+};
+
+static int saarb_pm860x_init(struct snd_soc_pcm_runtime *rtd)
+{
+	struct snd_soc_codec *codec = rtd->codec;
+	int ret;
+
+	ret = snd_soc_add_controls(codec, pm860x_saarb_controls,
+				   ARRAY_SIZE(pm860x_saarb_controls));
+	if (ret < 0)
+		return ret;
+
+	snd_soc_dapm_new_controls(codec, saarb_dapm_widgets,
+				  ARRAY_SIZE(saarb_dapm_widgets));
+	snd_soc_dapm_add_routes(codec, audio_map, ARRAY_SIZE(audio_map));
+
+	snd_soc_dapm_disable_pin(codec, "Board Speaker");
+	snd_soc_dapm_disable_pin(codec, "Board Mic 1");
+	snd_soc_dapm_disable_pin(codec, "Board Mic 3");
+	snd_soc_dapm_enable_pin(codec, "Headset Mic");
+
+	return snd_soc_dapm_sync(codec);
+}
+
+static int __init saarb_init(void)
+{
+	int ret;
+
+	if (!machine_is_saarb())
+		return -ENODEV;
+	saarb_snd_device = platform_device_alloc("soc-audio", -1);
+	if (!saarb_snd_device)
+		return -ENOMEM;
+
+	platform_set_drvdata(saarb_snd_device, &snd_soc_card_saarb);
+
+	ret = platform_device_add(saarb_snd_device);
+	if (ret)
+		platform_device_put(saarb_snd_device);
+
+	return ret;
+}
+
+static void __exit saarb_exit(void)
+{
+	platform_device_unregister(saarb_snd_device);
+}
+
+module_init(saarb_init);
+module_exit(saarb_exit);
+
+MODULE_AUTHOR("Haojian Zhuang <haojian.zhuang@marvell.com>");
+MODULE_DESCRIPTION("ALSA SoC 88PM860x Saarb");
+MODULE_LICENSE("GPL");
-- 
1.5.6.5

--0016e65aeed62e9cc9048e002c76
Content-Type: text/x-patch; charset=US-ASCII; 
	name="0003-ASoC-add-saarb-machine-driver-for-88pm860x.patch"
Content-Disposition: attachment; 
	filename="0003-ASoC-add-saarb-machine-driver-for-88pm860x.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gcyg0e4a0

RnJvbSAwMmEyOTA3NzA0MmE4YmNiNDEyMmZjYzIzOTNjYmM5ZDA3YWY4MDExIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBIYW9qaWFuIFpodWFuZyA8aGFvamlhbi56aHVhbmdAbWFydmVs
bC5jb20+CkRhdGU6IFR1ZSwgMTcgQXVnIDIwMTAgMTM6NTM6MTQgKzA4MDAKU3ViamVjdDogW1BB
VENIIDMvM10gQVNvQzogYWRkIHNhYXJiIG1hY2hpbmUgZHJpdmVyIGZvciA4OHBtODYweAoKODhQ
TTg2MHggY29kZWMgaXMgdXNlZCBpbiBNYXJ2ZWxsIHNhYXJiIGRldmVsb3BtZW50IGJvYXJkLiA4
OFBNODYweCBjb2RlYwppcyB1c2VkIGFzIG1hc3RlciBtb2RlIGZvciBTU1AgY29tbXVuaWNhdGlv
bi4gT25seSBJMlMgZm9ybWF0IGlzIHN1cHBvcnRlZC4KClNpZ25lZC1vZmYtYnk6IEhhb2ppYW4g
Wmh1YW5nIDxoYW9qaWFuLnpodWFuZ0BtYXJ2ZWxsLmNvbT4KLS0tCiBzb3VuZC9zb2MvcHhhL0tj
b25maWcgIHwgICAgOSArKysKIHNvdW5kL3NvYy9weGEvTWFrZWZpbGUgfCAgICAyICsKIHNvdW5k
L3NvYy9weGEvc2FhcmIuYyAgfCAgMTc4ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKwogMyBmaWxlcyBjaGFuZ2VkLCAxODkgaW5zZXJ0aW9ucygrKSwgMCBk
ZWxldGlvbnMoLSkKIGNyZWF0ZSBtb2RlIDEwMDY0NCBzb3VuZC9zb2MvcHhhL3NhYXJiLmMKCmRp
ZmYgLS1naXQgYS9zb3VuZC9zb2MvcHhhL0tjb25maWcgYi9zb3VuZC9zb2MvcHhhL0tjb25maWcK
aW5kZXggMDRkZGM3Yi4uMzdmMTkxYiAxMDA2NDQKLS0tIGEvc291bmQvc29jL3B4YS9LY29uZmln
CisrKyBiL3NvdW5kL3NvYy9weGEvS2NvbmZpZwpAQCAtMTE3LDYgKzExNywxNSBAQCBjb25maWcg
U05EX1BYQTJYWF9TT0NfUEFMTTI3WAogCSAgU2F5IFkgaWYgeW91IHdhbnQgdG8gYWRkIHN1cHBv
cnQgZm9yIFNvQyBhdWRpbyBvbgogCSAgUGFsbSBUfFgsIFQ1LCBFMiBvciBMaWZlRHJpdmUgaGFu
ZGhlbGQgY29tcHV0ZXIuCiAKK2NvbmZpZyBTTkRfU09DX1NBQVJCCisJdHJpc3RhdGUgIlNvQyBB
dWRpbyBzdXBwb3J0IGZvciBNYXJ2ZWxsIFNhYXJiIgorCWRlcGVuZHMgb24gU05EX1BYQTJYWF9T
T0MgJiYgTUFDSF9TQUFSQgorCXNlbGVjdCBTTkRfUFhBX1NPQ19TU1AKKwlzZWxlY3QgU05EX1NP
Q184OFBNODYwWAorCWhlbHAKKwkgIFNheSBZIGlmIHlvdSB3YW50IHRvIGFkZCBzdXBwb3J0IGZv
ciBTb0MgYXVkaW8gb24gdGhlCisJICBNYXJ2ZWxsIFNhYXJiIHJlZmVyZW5jZSBwbGF0Zm9ybS4K
KwogY29uZmlnIFNORF9TT0NfVEFWT1JFVkIzCiAJdHJpc3RhdGUgIlNvQyBBdWRpbyBzdXBwb3J0
IGZvciBNYXJ2ZWxsIFRhdm9yIEVWQjMiCiAJZGVwZW5kcyBvbiBTTkRfUFhBMlhYX1NPQyAmJiBN
QUNIX1RBVk9SRVZCMwpkaWZmIC0tZ2l0IGEvc291bmQvc29jL3B4YS9NYWtlZmlsZSBiL3NvdW5k
L3NvYy9weGEvTWFrZWZpbGUKaW5kZXggMzE1OTQxZi4uMDc2NjAxNiAxMDA2NDQKLS0tIGEvc291
bmQvc29jL3B4YS9NYWtlZmlsZQorKysgYi9zb3VuZC9zb2MvcHhhL01ha2VmaWxlCkBAIC0xOSw2
ICsxOSw3IEBAIHNuZC1zb2MtZTgwMC1vYmpzIDo9IGU4MDBfd205NzEyLm8KIHNuZC1zb2Mtc3Bp
dHotb2JqcyA6PSBzcGl0ei5vCiBzbmQtc29jLWVtLXgyNzAtb2JqcyA6PSBlbS14MjcwLm8KIHNu
ZC1zb2MtcGFsbTI3eC1vYmpzIDo9IHBhbG0yN3gubworc25kLXNvYy1zYWFyYi1vYmpzIDo9IHNh
YXJiLm8KIHNuZC1zb2MtdGF2b3JldmIzLW9ianMgOj0gdGF2b3JldmIzLm8KIHNuZC1zb2Mtenls
b25pdGUtb2JqcyA6PSB6eWxvbml0ZS5vCiBzbmQtc29jLW1hZ2ljaWFuLW9ianMgOj0gbWFnaWNp
YW4ubwpAQCAtMzksNiArNDAsNyBAQCBvYmotJChDT05GSUdfU05EX1BYQTJYWF9TT0NfUEFMTTI3
WCkgKz0gc25kLXNvYy1wYWxtMjd4Lm8KIG9iai0kKENPTkZJR19TTkRfUFhBMlhYX1NPQ19NQUdJ
Q0lBTikgKz0gc25kLXNvYy1tYWdpY2lhbi5vCiBvYmotJChDT05GSUdfU05EX1BYQTJYWF9TT0Nf
TUlPQTcwMSkgKz0gc25kLXNvYy1taW9hNzAxLm8KIG9iai0kKENPTkZJR19TTkRfUFhBMlhYX1NP
Q19aMikgKz0gc25kLXNvYy16Mi5vCitvYmotJChDT05GSUdfU05EX1NPQ19TQUFSQikgKz0gc25k
LXNvYy1zYWFyYi5vCiBvYmotJChDT05GSUdfU05EX1NPQ19UQVZPUkVWQjMpICs9IHNuZC1zb2Mt
dGF2b3JldmIzLm8KIG9iai0kKENPTkZJR19TTkRfU09DX1pZTE9OSVRFKSArPSBzbmQtc29jLXp5
bG9uaXRlLm8KIG9iai0kKENPTkZJR19TTkRfUFhBMlhYX1NPQ19JTU9URTIpICs9IHNuZC1zb2Mt
aW1vdGUyLm8KZGlmZiAtLWdpdCBhL3NvdW5kL3NvYy9weGEvc2FhcmIuYyBiL3NvdW5kL3NvYy9w
eGEvc2FhcmIuYwpuZXcgZmlsZSBtb2RlIDEwMDY0NAppbmRleCAwMDAwMDAwLi4zZjZlYzU3Ci0t
LSAvZGV2L251bGwKKysrIGIvc291bmQvc29jL3B4YS9zYWFyYi5jCkBAIC0wLDAgKzEsMTc4IEBA
CisvKgorICogc2FhcmIuYyAtLSBTb0MgYXVkaW8gZm9yIHNhYXJiCisgKgorICogQ29weXJpZ2h0
IChDKSAyMDEwIE1hcnZlbGwgSW50ZXJuYXRpb25hbCBMdGQuCisgKiAJSGFvamlhbiBaaHVhbmcg
PGhhb2ppYW4uemh1YW5nQG1hcnZlbGwuY29tPgorICoKKyAqIFRoaXMgcHJvZ3JhbSBpcyBmcmVl
IHNvZnR3YXJlOyB5b3UgY2FuIHJlZGlzdHJpYnV0ZSBpdCBhbmQvb3IgbW9kaWZ5CisgKiBpdCB1
bmRlciB0aGUgdGVybXMgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIHZlcnNpb24g
MiBhcworICogcHVibGlzaGVkIGJ5IHRoZSBGcmVlIFNvZnR3YXJlIEZvdW5kYXRpb24uCisgKi8K
KworI2luY2x1ZGUgPGxpbnV4L21vZHVsZS5oPgorI2luY2x1ZGUgPGxpbnV4L21vZHVsZXBhcmFt
Lmg+CisjaW5jbHVkZSA8bGludXgvZGV2aWNlLmg+CisjaW5jbHVkZSA8bGludXgvY2xrLmg+Cisj
aW5jbHVkZSA8bGludXgvaTJjLmg+CisjaW5jbHVkZSA8c291bmQvY29yZS5oPgorI2luY2x1ZGUg
PHNvdW5kL3BjbS5oPgorI2luY2x1ZGUgPHNvdW5kL3BjbV9wYXJhbXMuaD4KKyNpbmNsdWRlIDxz
b3VuZC9zb2MuaD4KKyNpbmNsdWRlIDxzb3VuZC9zb2MtZGFwbS5oPgorCisjaW5jbHVkZSA8YXNt
L21hY2gtdHlwZXMuaD4KKworI2luY2x1ZGUgIi4uL2NvZGVjcy84OHBtODYweC1jb2RlYy5oIgor
I2luY2x1ZGUgInB4YS1zc3AuaCIKKworc3RhdGljIGludCBzYWFyYl9wbTg2MHhfaW5pdChzdHJ1
Y3Qgc25kX3NvY19wY21fcnVudGltZSAqcnRkKTsKKworc3RhdGljIHN0cnVjdCBwbGF0Zm9ybV9k
ZXZpY2UgKnNhYXJiX3NuZF9kZXZpY2U7CisvKiBzYWFyYiBtYWNoaW5lIGRhcG0gd2lkZ2V0cyAq
Lworc3RhdGljIGNvbnN0IHN0cnVjdCBzbmRfc29jX2RhcG1fd2lkZ2V0IHNhYXJiX2RhcG1fd2lk
Z2V0c1tdID0geworCVNORF9TT0NfREFQTV9IUCgiSGVhZHBob25lIiwgTlVMTCksCisJU05EX1NP
Q19EQVBNX0xJTkUoIkxpbmVvdXQgT3V0IDEiLCBOVUxMKSwKKwlTTkRfU09DX0RBUE1fTElORSgi
TGluZW91dCBPdXQgMiIsIE5VTEwpLAorCVNORF9TT0NfREFQTV9TUEsoIkJvYXJkIFNwZWFrZXIi
LCBOVUxMKSwKKwlTTkRfU09DX0RBUE1fTUlDKCJCb2FyZCBNaWMgMSIsIE5VTEwpLAorCVNORF9T
T0NfREFQTV9NSUMoIkhlYWRzZXQgTWljIiwgTlVMTCksCisJU05EX1NPQ19EQVBNX01JQygiQm9h
cmQgTWljIDMiLCBOVUxMKSwKK307CisKKy8qIHNhYXJiIG1hY2hpbmUgYXVkaW8gbWFwICovCitz
dGF0aWMgY29uc3Qgc3RydWN0IHNuZF9zb2NfZGFwbV9yb3V0ZSBhdWRpb19tYXBbXSA9IHsKKwl7
IkhlYWRwaG9uZSIsIE5VTEwsICJIUzEifSwKKwl7IkhlYWRwaG9uZSIsIE5VTEwsICJIUzIifSwK
KworCXsiQm9hcmQgU3BlYWtlciIsIE5VTEwsICJMU1AifSwKKwl7IkJvYXJkIFNwZWFrZXIiLCBO
VUxMLCAiTFNOIn0sCisKKwl7IkxpbmVvdXQgT3V0IDEiLCBOVUxMLCAiTElORU9VVDEifSwKKwl7
IkxpbmVvdXQgT3V0IDIiLCBOVUxMLCAiTElORU9VVDIifSwKKworCXsiTUlDMVAiLCBOVUxMLCAi
TWljMSBCaWFzIn0sCisJeyJNSUMxTiIsIE5VTEwsICJNaWMxIEJpYXMifSwKKwl7Ik1pYzEgQmlh
cyIsIE5VTEwsICJCb2FyZCBNaWMgMSJ9LAorCisJeyJNSUMyUCIsIE5VTEwsICJNaWMxIEJpYXMi
fSwKKwl7Ik1JQzJOIiwgTlVMTCwgIk1pYzEgQmlhcyJ9LAorCXsiTWljMSBCaWFzIiwgTlVMTCwg
IkhlYWRzZXQgTWljIn0sCisKKwl7Ik1JQzNQIiwgTlVMTCwgIk1pYzMgQmlhcyJ9LAorCXsiTUlD
M04iLCBOVUxMLCAiTWljMyBCaWFzIn0sCisJeyJNaWMzIEJpYXMiLCBOVUxMLCAiQm9hcmQgTWlj
IDMifSwKK307CisKK3N0YXRpYyBjb25zdCBzdHJ1Y3Qgc25kX2tjb250cm9sX25ldyBwbTg2MHhf
c2FhcmJfY29udHJvbHNbXSA9IHsKKwlTT0NfREFQTV9QSU5fU1dJVENIKCJCb2FyZCBTcGVha2Vy
IiksCisJU09DX0RBUE1fUElOX1NXSVRDSCgiQm9hcmQgTWljIDEiKSwKKwlTT0NfREFQTV9QSU5f
U1dJVENIKCJCb2FyZCBNaWMgMyIpLAorfTsKKworc3RhdGljIGludCBzYWFyYl9pMnNfaHdfcGFy
YW1zKHN0cnVjdCBzbmRfcGNtX3N1YnN0cmVhbSAqc3Vic3RyZWFtLAorCQkJCXN0cnVjdCBzbmRf
cGNtX2h3X3BhcmFtcyAqcGFyYW1zKQoreworCXN0cnVjdCBzbmRfc29jX3BjbV9ydW50aW1lICpy
dGQgPSBzdWJzdHJlYW0tPnByaXZhdGVfZGF0YTsKKwlzdHJ1Y3Qgc25kX3NvY19kYWkgKmNvZGVj
X2RhaSA9IHJ0ZC0+Y29kZWNfZGFpOworCXN0cnVjdCBzbmRfc29jX2RhaSAqY3B1X2RhaSA9IHJ0
ZC0+Y3B1X2RhaTsKKwlpbnQgd2lkdGggPSBzbmRfcGNtX2Zvcm1hdF9waHlzaWNhbF93aWR0aChw
YXJhbXNfZm9ybWF0KHBhcmFtcykpOworCWludCByZXQ7CisKKwlyZXQgPSBzbmRfc29jX2RhaV9z
ZXRfc3lzY2xrKGNwdV9kYWksIFBYQV9TU1BfQ0xLX05FVF9QTEwsIDAsCisJCQkJICAgICBQTTg2
MFhfQ0xLX0RJUl9PVVQpOworCWlmIChyZXQgPCAwKQorCQlyZXR1cm4gcmV0OworCisJcmV0ID0g
c25kX3NvY19kYWlfc2V0X3N5c2Nsayhjb2RlY19kYWksIDAsIDAsIFBNODYwWF9DTEtfRElSX09V
VCk7CisJaWYgKHJldCA8IDApCisJCXJldHVybiByZXQ7CisKKwlyZXQgPSBzbmRfc29jX2RhaV9z
ZXRfZm10KGNwdV9kYWksIFNORF9TT0NfREFJRk1UX0kyUyB8CisJCQlTTkRfU09DX0RBSUZNVF9O
Ql9ORiB8IFNORF9TT0NfREFJRk1UX0NCTV9DRk0pOworCWlmIChyZXQgPCAwKQorCQlyZXR1cm4g
cmV0OworCXJldCA9IHNuZF9zb2NfZGFpX3NldF9mbXQoY29kZWNfZGFpLCBTTkRfU09DX0RBSUZN
VF9JMlMgfAorCQkJU05EX1NPQ19EQUlGTVRfTkJfTkYgfCBTTkRfU09DX0RBSUZNVF9DQk1fQ0ZN
KTsKKwlpZiAocmV0IDwgMCkKKwkJcmV0dXJuIHJldDsKKworCXJldCA9IHNuZF9zb2NfZGFpX3Nl
dF90ZG1fc2xvdChjcHVfZGFpLCAzLCAzLCAyLCB3aWR0aCk7CisKKwlyZXR1cm4gcmV0OworfQor
CitzdGF0aWMgc3RydWN0IHNuZF9zb2Nfb3BzIHNhYXJiX2kyc19vcHMgPSB7CisJLmh3X3BhcmFt
cwk9IHNhYXJiX2kyc19od19wYXJhbXMsCit9OworCitzdGF0aWMgc3RydWN0IHNuZF9zb2NfZGFp
X2xpbmsgc2FhcmJfZGFpW10gPSB7CisJeworCQkubmFtZQkJPSAiODhQTTg2MHggSTJTIiwKKwkJ
LnN0cmVhbV9uYW1lCT0gIkkyUyBBdWRpbyIsCisJCS5jcHVfZGFpX25hbWUJPSAicHhhLXNzcC1k
YWkuMSIsCisJCS5jb2RlY19kYWlfbmFtZQk9ICI4OHBtODYweC1pMnMiLAorCQkucGxhdGZvcm1f
bmFtZQk9ICJweGEtcGNtLWF1ZGlvIiwKKwkJLmNvZGVjX25hbWUJPSAiODhwbTg2MHgtY29kZWMi
LAorCQkuaW5pdAkJPSBzYWFyYl9wbTg2MHhfaW5pdCwKKwkJLm9wcwkJPSAmc2FhcmJfaTJzX29w
cywKKwl9LAorfTsKKworc3RhdGljIHN0cnVjdCBzbmRfc29jX2NhcmQgc25kX3NvY19jYXJkX3Nh
YXJiID0geworCS5uYW1lID0gIlNhYXJiIiwKKwkuZGFpX2xpbmsgPSBzYWFyYl9kYWksCisJLm51
bV9saW5rcyA9IEFSUkFZX1NJWkUoc2FhcmJfZGFpKSwKK307CisKK3N0YXRpYyBpbnQgc2FhcmJf
cG04NjB4X2luaXQoc3RydWN0IHNuZF9zb2NfcGNtX3J1bnRpbWUgKnJ0ZCkKK3sKKwlzdHJ1Y3Qg
c25kX3NvY19jb2RlYyAqY29kZWMgPSBydGQtPmNvZGVjOworCWludCByZXQ7CisKKwlyZXQgPSBz
bmRfc29jX2FkZF9jb250cm9scyhjb2RlYywgcG04NjB4X3NhYXJiX2NvbnRyb2xzLAorCQkJCSAg
IEFSUkFZX1NJWkUocG04NjB4X3NhYXJiX2NvbnRyb2xzKSk7CisJaWYgKHJldCA8IDApCisJCXJl
dHVybiByZXQ7CisKKwlzbmRfc29jX2RhcG1fbmV3X2NvbnRyb2xzKGNvZGVjLCBzYWFyYl9kYXBt
X3dpZGdldHMsCisJCQkJICBBUlJBWV9TSVpFKHNhYXJiX2RhcG1fd2lkZ2V0cykpOworCXNuZF9z
b2NfZGFwbV9hZGRfcm91dGVzKGNvZGVjLCBhdWRpb19tYXAsIEFSUkFZX1NJWkUoYXVkaW9fbWFw
KSk7CisKKwlzbmRfc29jX2RhcG1fZGlzYWJsZV9waW4oY29kZWMsICJCb2FyZCBTcGVha2VyIik7
CisJc25kX3NvY19kYXBtX2Rpc2FibGVfcGluKGNvZGVjLCAiQm9hcmQgTWljIDEiKTsKKwlzbmRf
c29jX2RhcG1fZGlzYWJsZV9waW4oY29kZWMsICJCb2FyZCBNaWMgMyIpOworCXNuZF9zb2NfZGFw
bV9lbmFibGVfcGluKGNvZGVjLCAiSGVhZHNldCBNaWMiKTsKKworCXJldHVybiBzbmRfc29jX2Rh
cG1fc3luYyhjb2RlYyk7Cit9CisKK3N0YXRpYyBpbnQgX19pbml0IHNhYXJiX2luaXQodm9pZCkK
K3sKKwlpbnQgcmV0OworCisJaWYgKCFtYWNoaW5lX2lzX3NhYXJiKCkpCisJCXJldHVybiAtRU5P
REVWOworCXNhYXJiX3NuZF9kZXZpY2UgPSBwbGF0Zm9ybV9kZXZpY2VfYWxsb2MoInNvYy1hdWRp
byIsIC0xKTsKKwlpZiAoIXNhYXJiX3NuZF9kZXZpY2UpCisJCXJldHVybiAtRU5PTUVNOworCisJ
cGxhdGZvcm1fc2V0X2RydmRhdGEoc2FhcmJfc25kX2RldmljZSwgJnNuZF9zb2NfY2FyZF9zYWFy
Yik7CisKKwlyZXQgPSBwbGF0Zm9ybV9kZXZpY2VfYWRkKHNhYXJiX3NuZF9kZXZpY2UpOworCWlm
IChyZXQpCisJCXBsYXRmb3JtX2RldmljZV9wdXQoc2FhcmJfc25kX2RldmljZSk7CisKKwlyZXR1
cm4gcmV0OworfQorCitzdGF0aWMgdm9pZCBfX2V4aXQgc2FhcmJfZXhpdCh2b2lkKQoreworCXBs
YXRmb3JtX2RldmljZV91bnJlZ2lzdGVyKHNhYXJiX3NuZF9kZXZpY2UpOworfQorCittb2R1bGVf
aW5pdChzYWFyYl9pbml0KTsKK21vZHVsZV9leGl0KHNhYXJiX2V4aXQpOworCitNT0RVTEVfQVVU
SE9SKCJIYW9qaWFuIFpodWFuZyA8aGFvamlhbi56aHVhbmdAbWFydmVsbC5jb20+Iik7CitNT0RV
TEVfREVTQ1JJUFRJT04oIkFMU0EgU29DIDg4UE04NjB4IFNhYXJiIik7CitNT0RVTEVfTElDRU5T
RSgiR1BMIik7Ci0tIAoxLjUuNi41Cgo=
--0016e65aeed62e9cc9048e002c76--
