From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Tue, 17 Aug 2010 13:24:35 +0800
Subject: [PATCH 2/3] ASoC: add tavorevb3 machine driver for 88pm860x
Message-ID: <mailman.179.1282031294.27306.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

88PM860x codec is used in Marvell tavorevb3 development board. 88PM860x
codec is used as master mode of SSP communication. Only I2S format is
supported.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 sound/soc/pxa/Kconfig     |    9 ++
 sound/soc/pxa/Makefile    |    2 +
 sound/soc/pxa/tavorevb3.c |  180 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 191 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/pxa/tavorevb3.c

diff --git a/sound/soc/pxa/Kconfig b/sound/soc/pxa/Kconfig
index e30c832..04ddc7b 100644
--- a/sound/soc/pxa/Kconfig
+++ b/sound/soc/pxa/Kconfig
@@ -117,6 +117,15 @@ config SND_PXA2XX_SOC_PALM27X
 	  Say Y if you want to add support for SoC audio on
 	  Palm T|X, T5, E2 or LifeDrive handheld computer.

+config SND_SOC_TAVOREVB3
+	tristate "SoC Audio support for Marvell Tavor EVB3"
+	depends on SND_PXA2XX_SOC && MACH_TAVOREVB3
+	select SND_PXA_SOC_SSP
+	select SND_SOC_88PM860X
+	help
+	  Say Y if you want to add support for SoC audio on the
+	  Marvell Saarb reference platform.
+
 config SND_SOC_ZYLONITE
 	tristate "SoC Audio support for Marvell Zylonite"
 	depends on SND_PXA2XX_SOC && MACH_ZYLONITE
diff --git a/sound/soc/pxa/Makefile b/sound/soc/pxa/Makefile
index caa03d8..315941f 100644
--- a/sound/soc/pxa/Makefile
+++ b/sound/soc/pxa/Makefile
@@ -19,6 +19,7 @@ snd-soc-e800-objs := e800_wm9712.o
 snd-soc-spitz-objs := spitz.o
 snd-soc-em-x270-objs := em-x270.o
 snd-soc-palm27x-objs := palm27x.o
+snd-soc-tavorevb3-objs := tavorevb3.o
 snd-soc-zylonite-objs := zylonite.o
 snd-soc-magician-objs := magician.o
 snd-soc-mioa701-objs := mioa701_wm9713.o
@@ -38,6 +39,7 @@ obj-$(CONFIG_SND_PXA2XX_SOC_PALM27X) += snd-soc-palm27x.o
 obj-$(CONFIG_SND_PXA2XX_SOC_MAGICIAN) += snd-soc-magician.o
 obj-$(CONFIG_SND_PXA2XX_SOC_MIOA701) += snd-soc-mioa701.o
 obj-$(CONFIG_SND_PXA2XX_SOC_Z2) += snd-soc-z2.o
+obj-$(CONFIG_SND_SOC_TAVOREVB3) += snd-soc-tavorevb3.o
 obj-$(CONFIG_SND_SOC_ZYLONITE) += snd-soc-zylonite.o
 obj-$(CONFIG_SND_PXA2XX_SOC_IMOTE2) += snd-soc-imote2.o
 obj-$(CONFIG_SND_SOC_RAUMFELD) += snd-soc-raumfeld.o
diff --git a/sound/soc/pxa/tavorevb3.c b/sound/soc/pxa/tavorevb3.c
new file mode 100644
index 0000000..194f81a
--- /dev/null
+++ b/sound/soc/pxa/tavorevb3.c
@@ -0,0 +1,180 @@
+/*
+ * tavorevb3.c -- SoC audio for Tavor EVB3
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
+static int evb3_pm860x_init(struct snd_soc_pcm_runtime *rtd);
+
+static struct platform_device *evb3_snd_device;
+
+/* tavorevb3 machine dapm widgets */
+static const struct snd_soc_dapm_widget evb3_dapm_widgets[] = {
+	SND_SOC_DAPM_HP("Headphone", NULL),
+	SND_SOC_DAPM_LINE("Lineout Out 1", NULL),
+	SND_SOC_DAPM_LINE("Lineout Out 2", NULL),
+	SND_SOC_DAPM_SPK("Board Speaker", NULL),
+	SND_SOC_DAPM_MIC("Board Mic 1", NULL),
+	SND_SOC_DAPM_MIC("Headset Mic", NULL),
+	SND_SOC_DAPM_MIC("Board Mic 3", NULL),
+};
+
+/* tavorevb3 machine audio map */
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
+static const struct snd_kcontrol_new pm860x_evb3_controls[] = {
+	SOC_DAPM_PIN_SWITCH("Board Speaker"),
+	SOC_DAPM_PIN_SWITCH("Board Mic 1"),
+	SOC_DAPM_PIN_SWITCH("Board Mic 3"),
+};
+
+static int evb3_i2s_hw_params(struct snd_pcm_substream *substream,
+			      struct snd_pcm_hw_params *params)
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
+
+	ret = snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_I2S |
+			SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBM_CFM);
+	if (ret < 0)
+		return ret;
+
+	ret = snd_soc_dai_set_tdm_slot(cpu_dai, 3, 3, 2, width);
+	return ret;
+}
+
+static struct snd_soc_ops evb3_i2s_ops = {
+	.hw_params	= evb3_i2s_hw_params,
+};
+
+static struct snd_soc_dai_link evb3_dai[] = {
+	{
+		.name		= "88PM860x I2S",
+		.stream_name	= "I2S Audio",
+		.cpu_dai_name	= "pxa-ssp-dai.1",
+		.codec_dai_name	= "88pm860x-i2s",
+		.platform_name	= "pxa-pcm-audio",
+		.codec_name	= "88pm860x-codec",
+		.init		= evb3_pm860x_init,
+		.ops		= &evb3_i2s_ops,
+	},
+};
+
+static struct snd_soc_card snd_soc_card_evb3 = {
+	.name = "Tavor EVB3",
+	.dai_link = evb3_dai,
+	.num_links = ARRAY_SIZE(evb3_dai),
+};
+
+static int evb3_pm860x_init(struct snd_soc_pcm_runtime *rtd)
+{
+	struct snd_soc_codec *codec = rtd->codec;
+	int ret;
+
+	ret = snd_soc_add_controls(codec, pm860x_evb3_controls,
+				   ARRAY_SIZE(pm860x_evb3_controls));
+	if (ret < 0)
+		return ret;
+
+	snd_soc_dapm_new_controls(codec, evb3_dapm_widgets,
+				  ARRAY_SIZE(evb3_dapm_widgets));
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
+static int __init tavorevb3_init(void)
+{
+	int ret;
+
+	if (!machine_is_tavorevb3())
+		return -ENODEV;
+	evb3_snd_device = platform_device_alloc("soc-audio", -1);
+	if (!evb3_snd_device)
+		return -ENOMEM;
+
+	platform_set_drvdata(evb3_snd_device, &snd_soc_card_evb3);
+
+	ret = platform_device_add(evb3_snd_device);
+	if (ret)
+		platform_device_put(evb3_snd_device);
+
+	return ret;
+}
+
+static void __exit tavorevb3_exit(void)
+{
+	platform_device_unregister(evb3_snd_device);
+}
+
+module_init(tavorevb3_init);
+module_exit(tavorevb3_exit);
+
+MODULE_AUTHOR("Haojian Zhuang <haojian.zhuang@marvell.com>");
+MODULE_DESCRIPTION("ALSA SoC 88PM860x Tavor EVB3");
+MODULE_LICENSE("GPL");
+
-- 
1.5.6.5

--0016367fb40d98bb3a048e002bbe
Content-Type: text/x-patch; charset=US-ASCII; 
	name="0002-ASoC-add-tavorevb3-machine-driver-for-88pm860x.patch"
Content-Disposition: attachment; 
	filename="0002-ASoC-add-tavorevb3-machine-driver-for-88pm860x.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gcyfzdf50

RnJvbSBhNmM2MGY0YTU2YjgyYjMwMmE4NWJjN2YyZmM5NzgyZTRkODEwNTY4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBIYW9qaWFuIFpodWFuZyA8aGFvamlhbi56aHVhbmdAbWFydmVs
bC5jb20+CkRhdGU6IFR1ZSwgMTcgQXVnIDIwMTAgMTM6MjQ6MzUgKzA4MDAKU3ViamVjdDogW1BB
VENIIDIvM10gQVNvQzogYWRkIHRhdm9yZXZiMyBtYWNoaW5lIGRyaXZlciBmb3IgODhwbTg2MHgK
Cjg4UE04NjB4IGNvZGVjIGlzIHVzZWQgaW4gTWFydmVsbCB0YXZvcmV2YjMgZGV2ZWxvcG1lbnQg
Ym9hcmQuIDg4UE04NjB4CmNvZGVjIGlzIHVzZWQgYXMgbWFzdGVyIG1vZGUgb2YgU1NQIGNvbW11
bmljYXRpb24uIE9ubHkgSTJTIGZvcm1hdCBpcwpzdXBwb3J0ZWQuCgpTaWduZWQtb2ZmLWJ5OiBI
YW9qaWFuIFpodWFuZyA8aGFvamlhbi56aHVhbmdAbWFydmVsbC5jb20+Ci0tLQogc291bmQvc29j
L3B4YS9LY29uZmlnICAgICB8ICAgIDkgKysKIHNvdW5kL3NvYy9weGEvTWFrZWZpbGUgICAgfCAg
ICAyICsKIHNvdW5kL3NvYy9weGEvdGF2b3JldmIzLmMgfCAgMTgwICsrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKwogMyBmaWxlcyBjaGFuZ2VkLCAxOTEgaW5zZXJ0
aW9ucygrKSwgMCBkZWxldGlvbnMoLSkKIGNyZWF0ZSBtb2RlIDEwMDY0NCBzb3VuZC9zb2MvcHhh
L3Rhdm9yZXZiMy5jCgpkaWZmIC0tZ2l0IGEvc291bmQvc29jL3B4YS9LY29uZmlnIGIvc291bmQv
c29jL3B4YS9LY29uZmlnCmluZGV4IGUzMGM4MzIuLjA0ZGRjN2IgMTAwNjQ0Ci0tLSBhL3NvdW5k
L3NvYy9weGEvS2NvbmZpZworKysgYi9zb3VuZC9zb2MvcHhhL0tjb25maWcKQEAgLTExNyw2ICsx
MTcsMTUgQEAgY29uZmlnIFNORF9QWEEyWFhfU09DX1BBTE0yN1gKIAkgIFNheSBZIGlmIHlvdSB3
YW50IHRvIGFkZCBzdXBwb3J0IGZvciBTb0MgYXVkaW8gb24KIAkgIFBhbG0gVHxYLCBUNSwgRTIg
b3IgTGlmZURyaXZlIGhhbmRoZWxkIGNvbXB1dGVyLgogCitjb25maWcgU05EX1NPQ19UQVZPUkVW
QjMKKwl0cmlzdGF0ZSAiU29DIEF1ZGlvIHN1cHBvcnQgZm9yIE1hcnZlbGwgVGF2b3IgRVZCMyIK
KwlkZXBlbmRzIG9uIFNORF9QWEEyWFhfU09DICYmIE1BQ0hfVEFWT1JFVkIzCisJc2VsZWN0IFNO
RF9QWEFfU09DX1NTUAorCXNlbGVjdCBTTkRfU09DXzg4UE04NjBYCisJaGVscAorCSAgU2F5IFkg
aWYgeW91IHdhbnQgdG8gYWRkIHN1cHBvcnQgZm9yIFNvQyBhdWRpbyBvbiB0aGUKKwkgIE1hcnZl
bGwgU2FhcmIgcmVmZXJlbmNlIHBsYXRmb3JtLgorCiBjb25maWcgU05EX1NPQ19aWUxPTklURQog
CXRyaXN0YXRlICJTb0MgQXVkaW8gc3VwcG9ydCBmb3IgTWFydmVsbCBaeWxvbml0ZSIKIAlkZXBl
bmRzIG9uIFNORF9QWEEyWFhfU09DICYmIE1BQ0hfWllMT05JVEUKZGlmZiAtLWdpdCBhL3NvdW5k
L3NvYy9weGEvTWFrZWZpbGUgYi9zb3VuZC9zb2MvcHhhL01ha2VmaWxlCmluZGV4IGNhYTAzZDgu
LjMxNTk0MWYgMTAwNjQ0Ci0tLSBhL3NvdW5kL3NvYy9weGEvTWFrZWZpbGUKKysrIGIvc291bmQv
c29jL3B4YS9NYWtlZmlsZQpAQCAtMTksNiArMTksNyBAQCBzbmQtc29jLWU4MDAtb2JqcyA6PSBl
ODAwX3dtOTcxMi5vCiBzbmQtc29jLXNwaXR6LW9ianMgOj0gc3BpdHoubwogc25kLXNvYy1lbS14
MjcwLW9ianMgOj0gZW0teDI3MC5vCiBzbmQtc29jLXBhbG0yN3gtb2JqcyA6PSBwYWxtMjd4Lm8K
K3NuZC1zb2MtdGF2b3JldmIzLW9ianMgOj0gdGF2b3JldmIzLm8KIHNuZC1zb2Mtenlsb25pdGUt
b2JqcyA6PSB6eWxvbml0ZS5vCiBzbmQtc29jLW1hZ2ljaWFuLW9ianMgOj0gbWFnaWNpYW4ubwog
c25kLXNvYy1taW9hNzAxLW9ianMgOj0gbWlvYTcwMV93bTk3MTMubwpAQCAtMzgsNiArMzksNyBA
QCBvYmotJChDT05GSUdfU05EX1BYQTJYWF9TT0NfUEFMTTI3WCkgKz0gc25kLXNvYy1wYWxtMjd4
Lm8KIG9iai0kKENPTkZJR19TTkRfUFhBMlhYX1NPQ19NQUdJQ0lBTikgKz0gc25kLXNvYy1tYWdp
Y2lhbi5vCiBvYmotJChDT05GSUdfU05EX1BYQTJYWF9TT0NfTUlPQTcwMSkgKz0gc25kLXNvYy1t
aW9hNzAxLm8KIG9iai0kKENPTkZJR19TTkRfUFhBMlhYX1NPQ19aMikgKz0gc25kLXNvYy16Mi5v
CitvYmotJChDT05GSUdfU05EX1NPQ19UQVZPUkVWQjMpICs9IHNuZC1zb2MtdGF2b3JldmIzLm8K
IG9iai0kKENPTkZJR19TTkRfU09DX1pZTE9OSVRFKSArPSBzbmQtc29jLXp5bG9uaXRlLm8KIG9i
ai0kKENPTkZJR19TTkRfUFhBMlhYX1NPQ19JTU9URTIpICs9IHNuZC1zb2MtaW1vdGUyLm8KIG9i
ai0kKENPTkZJR19TTkRfU09DX1JBVU1GRUxEKSArPSBzbmQtc29jLXJhdW1mZWxkLm8KZGlmZiAt
LWdpdCBhL3NvdW5kL3NvYy9weGEvdGF2b3JldmIzLmMgYi9zb3VuZC9zb2MvcHhhL3Rhdm9yZXZi
My5jCm5ldyBmaWxlIG1vZGUgMTAwNjQ0CmluZGV4IDAwMDAwMDAuLjE5NGY4MWEKLS0tIC9kZXYv
bnVsbAorKysgYi9zb3VuZC9zb2MvcHhhL3Rhdm9yZXZiMy5jCkBAIC0wLDAgKzEsMTgwIEBACisv
KgorICogdGF2b3JldmIzLmMgLS0gU29DIGF1ZGlvIGZvciBUYXZvciBFVkIzCisgKgorICogQ29w
eXJpZ2h0IChDKSAyMDEwIE1hcnZlbGwgSW50ZXJuYXRpb25hbCBMdGQuCisgKiAJSGFvamlhbiBa
aHVhbmcgPGhhb2ppYW4uemh1YW5nQG1hcnZlbGwuY29tPgorICoKKyAqIFRoaXMgcHJvZ3JhbSBp
cyBmcmVlIHNvZnR3YXJlOyB5b3UgY2FuIHJlZGlzdHJpYnV0ZSBpdCBhbmQvb3IgbW9kaWZ5Cisg
KiBpdCB1bmRlciB0aGUgdGVybXMgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIHZl
cnNpb24gMiBhcworICogcHVibGlzaGVkIGJ5IHRoZSBGcmVlIFNvZnR3YXJlIEZvdW5kYXRpb24u
CisgKi8KKworI2luY2x1ZGUgPGxpbnV4L21vZHVsZS5oPgorI2luY2x1ZGUgPGxpbnV4L21vZHVs
ZXBhcmFtLmg+CisjaW5jbHVkZSA8bGludXgvZGV2aWNlLmg+CisjaW5jbHVkZSA8bGludXgvY2xr
Lmg+CisjaW5jbHVkZSA8bGludXgvaTJjLmg+CisjaW5jbHVkZSA8c291bmQvY29yZS5oPgorI2lu
Y2x1ZGUgPHNvdW5kL3BjbS5oPgorI2luY2x1ZGUgPHNvdW5kL3BjbV9wYXJhbXMuaD4KKyNpbmNs
dWRlIDxzb3VuZC9zb2MuaD4KKyNpbmNsdWRlIDxzb3VuZC9zb2MtZGFwbS5oPgorCisjaW5jbHVk
ZSA8YXNtL21hY2gtdHlwZXMuaD4KKworI2luY2x1ZGUgIi4uL2NvZGVjcy84OHBtODYweC1jb2Rl
Yy5oIgorI2luY2x1ZGUgInB4YS1zc3AuaCIKKworc3RhdGljIGludCBldmIzX3BtODYweF9pbml0
KHN0cnVjdCBzbmRfc29jX3BjbV9ydW50aW1lICpydGQpOworCitzdGF0aWMgc3RydWN0IHBsYXRm
b3JtX2RldmljZSAqZXZiM19zbmRfZGV2aWNlOworCisvKiB0YXZvcmV2YjMgbWFjaGluZSBkYXBt
IHdpZGdldHMgKi8KK3N0YXRpYyBjb25zdCBzdHJ1Y3Qgc25kX3NvY19kYXBtX3dpZGdldCBldmIz
X2RhcG1fd2lkZ2V0c1tdID0geworCVNORF9TT0NfREFQTV9IUCgiSGVhZHBob25lIiwgTlVMTCks
CisJU05EX1NPQ19EQVBNX0xJTkUoIkxpbmVvdXQgT3V0IDEiLCBOVUxMKSwKKwlTTkRfU09DX0RB
UE1fTElORSgiTGluZW91dCBPdXQgMiIsIE5VTEwpLAorCVNORF9TT0NfREFQTV9TUEsoIkJvYXJk
IFNwZWFrZXIiLCBOVUxMKSwKKwlTTkRfU09DX0RBUE1fTUlDKCJCb2FyZCBNaWMgMSIsIE5VTEwp
LAorCVNORF9TT0NfREFQTV9NSUMoIkhlYWRzZXQgTWljIiwgTlVMTCksCisJU05EX1NPQ19EQVBN
X01JQygiQm9hcmQgTWljIDMiLCBOVUxMKSwKK307CisKKy8qIHRhdm9yZXZiMyBtYWNoaW5lIGF1
ZGlvIG1hcCAqLworc3RhdGljIGNvbnN0IHN0cnVjdCBzbmRfc29jX2RhcG1fcm91dGUgYXVkaW9f
bWFwW10gPSB7CisJeyJIZWFkcGhvbmUiLCBOVUxMLCAiSFMxIn0sCisJeyJIZWFkcGhvbmUiLCBO
VUxMLCAiSFMyIn0sCisKKwl7IkJvYXJkIFNwZWFrZXIiLCBOVUxMLCAiTFNQIn0sCisJeyJCb2Fy
ZCBTcGVha2VyIiwgTlVMTCwgIkxTTiJ9LAorCisJeyJMaW5lb3V0IE91dCAxIiwgTlVMTCwgIkxJ
TkVPVVQxIn0sCisJeyJMaW5lb3V0IE91dCAyIiwgTlVMTCwgIkxJTkVPVVQyIn0sCisKKwl7Ik1J
QzFQIiwgTlVMTCwgIk1pYzEgQmlhcyJ9LAorCXsiTUlDMU4iLCBOVUxMLCAiTWljMSBCaWFzIn0s
CisJeyJNaWMxIEJpYXMiLCBOVUxMLCAiQm9hcmQgTWljIDEifSwKKworCXsiTUlDMlAiLCBOVUxM
LCAiTWljMSBCaWFzIn0sCisJeyJNSUMyTiIsIE5VTEwsICJNaWMxIEJpYXMifSwKKwl7Ik1pYzEg
QmlhcyIsIE5VTEwsICJIZWFkc2V0IE1pYyJ9LAorCisJeyJNSUMzUCIsIE5VTEwsICJNaWMzIEJp
YXMifSwKKwl7Ik1JQzNOIiwgTlVMTCwgIk1pYzMgQmlhcyJ9LAorCXsiTWljMyBCaWFzIiwgTlVM
TCwgIkJvYXJkIE1pYyAzIn0sCit9OworCitzdGF0aWMgY29uc3Qgc3RydWN0IHNuZF9rY29udHJv
bF9uZXcgcG04NjB4X2V2YjNfY29udHJvbHNbXSA9IHsKKwlTT0NfREFQTV9QSU5fU1dJVENIKCJC
b2FyZCBTcGVha2VyIiksCisJU09DX0RBUE1fUElOX1NXSVRDSCgiQm9hcmQgTWljIDEiKSwKKwlT
T0NfREFQTV9QSU5fU1dJVENIKCJCb2FyZCBNaWMgMyIpLAorfTsKKworc3RhdGljIGludCBldmIz
X2kyc19od19wYXJhbXMoc3RydWN0IHNuZF9wY21fc3Vic3RyZWFtICpzdWJzdHJlYW0sCisJCQkg
ICAgICBzdHJ1Y3Qgc25kX3BjbV9od19wYXJhbXMgKnBhcmFtcykKK3sKKwlzdHJ1Y3Qgc25kX3Nv
Y19wY21fcnVudGltZSAqcnRkID0gc3Vic3RyZWFtLT5wcml2YXRlX2RhdGE7CisJc3RydWN0IHNu
ZF9zb2NfZGFpICpjb2RlY19kYWkgPSBydGQtPmNvZGVjX2RhaTsKKwlzdHJ1Y3Qgc25kX3NvY19k
YWkgKmNwdV9kYWkgPSBydGQtPmNwdV9kYWk7CisJaW50IHdpZHRoID0gc25kX3BjbV9mb3JtYXRf
cGh5c2ljYWxfd2lkdGgocGFyYW1zX2Zvcm1hdChwYXJhbXMpKTsKKwlpbnQgcmV0OworCisJcmV0
ID0gc25kX3NvY19kYWlfc2V0X3N5c2NsayhjcHVfZGFpLCBQWEFfU1NQX0NMS19ORVRfUExMLCAw
LAorCQkJCSAgICAgUE04NjBYX0NMS19ESVJfT1VUKTsKKwlpZiAocmV0IDwgMCkKKwkJcmV0dXJu
IHJldDsKKworCXJldCA9IHNuZF9zb2NfZGFpX3NldF9zeXNjbGsoY29kZWNfZGFpLCAwLCAwLCBQ
TTg2MFhfQ0xLX0RJUl9PVVQpOworCWlmIChyZXQgPCAwKQorCQlyZXR1cm4gcmV0OworCisJcmV0
ID0gc25kX3NvY19kYWlfc2V0X2ZtdChjcHVfZGFpLCBTTkRfU09DX0RBSUZNVF9JMlMgfAorCQkJ
U05EX1NPQ19EQUlGTVRfTkJfTkYgfCBTTkRfU09DX0RBSUZNVF9DQk1fQ0ZNKTsKKwlpZiAocmV0
IDwgMCkKKwkJcmV0dXJuIHJldDsKKworCXJldCA9IHNuZF9zb2NfZGFpX3NldF9mbXQoY29kZWNf
ZGFpLCBTTkRfU09DX0RBSUZNVF9JMlMgfAorCQkJU05EX1NPQ19EQUlGTVRfTkJfTkYgfCBTTkRf
U09DX0RBSUZNVF9DQk1fQ0ZNKTsKKwlpZiAocmV0IDwgMCkKKwkJcmV0dXJuIHJldDsKKworCXJl
dCA9IHNuZF9zb2NfZGFpX3NldF90ZG1fc2xvdChjcHVfZGFpLCAzLCAzLCAyLCB3aWR0aCk7CisJ
cmV0dXJuIHJldDsKK30KKworc3RhdGljIHN0cnVjdCBzbmRfc29jX29wcyBldmIzX2kyc19vcHMg
PSB7CisJLmh3X3BhcmFtcwk9IGV2YjNfaTJzX2h3X3BhcmFtcywKK307CisKK3N0YXRpYyBzdHJ1
Y3Qgc25kX3NvY19kYWlfbGluayBldmIzX2RhaVtdID0geworCXsKKwkJLm5hbWUJCT0gIjg4UE04
NjB4IEkyUyIsCisJCS5zdHJlYW1fbmFtZQk9ICJJMlMgQXVkaW8iLAorCQkuY3B1X2RhaV9uYW1l
CT0gInB4YS1zc3AtZGFpLjEiLAorCQkuY29kZWNfZGFpX25hbWUJPSAiODhwbTg2MHgtaTJzIiwK
KwkJLnBsYXRmb3JtX25hbWUJPSAicHhhLXBjbS1hdWRpbyIsCisJCS5jb2RlY19uYW1lCT0gIjg4
cG04NjB4LWNvZGVjIiwKKwkJLmluaXQJCT0gZXZiM19wbTg2MHhfaW5pdCwKKwkJLm9wcwkJPSAm
ZXZiM19pMnNfb3BzLAorCX0sCit9OworCitzdGF0aWMgc3RydWN0IHNuZF9zb2NfY2FyZCBzbmRf
c29jX2NhcmRfZXZiMyA9IHsKKwkubmFtZSA9ICJUYXZvciBFVkIzIiwKKwkuZGFpX2xpbmsgPSBl
dmIzX2RhaSwKKwkubnVtX2xpbmtzID0gQVJSQVlfU0laRShldmIzX2RhaSksCit9OworCitzdGF0
aWMgaW50IGV2YjNfcG04NjB4X2luaXQoc3RydWN0IHNuZF9zb2NfcGNtX3J1bnRpbWUgKnJ0ZCkK
K3sKKwlzdHJ1Y3Qgc25kX3NvY19jb2RlYyAqY29kZWMgPSBydGQtPmNvZGVjOworCWludCByZXQ7
CisKKwlyZXQgPSBzbmRfc29jX2FkZF9jb250cm9scyhjb2RlYywgcG04NjB4X2V2YjNfY29udHJv
bHMsCisJCQkJICAgQVJSQVlfU0laRShwbTg2MHhfZXZiM19jb250cm9scykpOworCWlmIChyZXQg
PCAwKQorCQlyZXR1cm4gcmV0OworCisJc25kX3NvY19kYXBtX25ld19jb250cm9scyhjb2RlYywg
ZXZiM19kYXBtX3dpZGdldHMsCisJCQkJICBBUlJBWV9TSVpFKGV2YjNfZGFwbV93aWRnZXRzKSk7
CisJc25kX3NvY19kYXBtX2FkZF9yb3V0ZXMoY29kZWMsIGF1ZGlvX21hcCwgQVJSQVlfU0laRShh
dWRpb19tYXApKTsKKworCXNuZF9zb2NfZGFwbV9kaXNhYmxlX3Bpbihjb2RlYywgIkJvYXJkIFNw
ZWFrZXIiKTsKKwlzbmRfc29jX2RhcG1fZGlzYWJsZV9waW4oY29kZWMsICJCb2FyZCBNaWMgMSIp
OworCXNuZF9zb2NfZGFwbV9kaXNhYmxlX3Bpbihjb2RlYywgIkJvYXJkIE1pYyAzIik7CisJc25k
X3NvY19kYXBtX2VuYWJsZV9waW4oY29kZWMsICJIZWFkc2V0IE1pYyIpOworCisJcmV0dXJuIHNu
ZF9zb2NfZGFwbV9zeW5jKGNvZGVjKTsKK30KKworc3RhdGljIGludCBfX2luaXQgdGF2b3JldmIz
X2luaXQodm9pZCkKK3sKKwlpbnQgcmV0OworCisJaWYgKCFtYWNoaW5lX2lzX3Rhdm9yZXZiMygp
KQorCQlyZXR1cm4gLUVOT0RFVjsKKwlldmIzX3NuZF9kZXZpY2UgPSBwbGF0Zm9ybV9kZXZpY2Vf
YWxsb2MoInNvYy1hdWRpbyIsIC0xKTsKKwlpZiAoIWV2YjNfc25kX2RldmljZSkKKwkJcmV0dXJu
IC1FTk9NRU07CisKKwlwbGF0Zm9ybV9zZXRfZHJ2ZGF0YShldmIzX3NuZF9kZXZpY2UsICZzbmRf
c29jX2NhcmRfZXZiMyk7CisKKwlyZXQgPSBwbGF0Zm9ybV9kZXZpY2VfYWRkKGV2YjNfc25kX2Rl
dmljZSk7CisJaWYgKHJldCkKKwkJcGxhdGZvcm1fZGV2aWNlX3B1dChldmIzX3NuZF9kZXZpY2Up
OworCisJcmV0dXJuIHJldDsKK30KKworc3RhdGljIHZvaWQgX19leGl0IHRhdm9yZXZiM19leGl0
KHZvaWQpCit7CisJcGxhdGZvcm1fZGV2aWNlX3VucmVnaXN0ZXIoZXZiM19zbmRfZGV2aWNlKTsK
K30KKworbW9kdWxlX2luaXQodGF2b3JldmIzX2luaXQpOworbW9kdWxlX2V4aXQodGF2b3JldmIz
X2V4aXQpOworCitNT0RVTEVfQVVUSE9SKCJIYW9qaWFuIFpodWFuZyA8aGFvamlhbi56aHVhbmdA
bWFydmVsbC5jb20+Iik7CitNT0RVTEVfREVTQ1JJUFRJT04oIkFMU0EgU29DIDg4UE04NjB4IFRh
dm9yIEVWQjMiKTsKK01PRFVMRV9MSUNFTlNFKCJHUEwiKTsKKwotLSAKMS41LjYuNQoK
--0016367fb40d98bb3a048e002bbe--
