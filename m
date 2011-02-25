From: javier.martin@vista-silicon.com (Javier Martin)
Date: Fri, 25 Feb 2011 14:42:49 +0100
Subject: [PATCH 3/4] ASoC: Add machine driver for Visstrim_M10 board.
In-Reply-To: <1298641370-17461-1-git-send-email-javier.martin@vista-silicon.com>
References: <1298641370-17461-1-git-send-email-javier.martin@vista-silicon.com>
Message-ID: <1298641370-17461-3-git-send-email-javier.martin@vista-silicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Visstrim_M10 board uses a tlv320aic3204 codec. This driver
provides support for it.

Signed-off-by: Javier Martin <javier.martin@vista-silicon.com>
---
 sound/soc/imx/Kconfig           |   10 +++
 sound/soc/imx/Makefile          |    2 +
 sound/soc/imx/mx27vis-aic32x4.c |  137 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 149 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/imx/mx27vis-aic32x4.c

diff --git a/sound/soc/imx/Kconfig b/sound/soc/imx/Kconfig
index 642270a..15e7c04 100644
--- a/sound/soc/imx/Kconfig
+++ b/sound/soc/imx/Kconfig
@@ -30,6 +30,16 @@ config SND_MXC_SOC_WM1133_EV1
 	  Enable support for audio on the i.MX31ADS with the WM1133-EV1
 	  PMIC board with WM8835x fitted.
 
+config SND_SOC_MX27VIS_AIC32X4
+	tristate "SoC audio support for Visstrim M10 boards"
+	depends on MACH_IMX27_VISSTRIM_M10
+	select SND_SOC_TVL320AIC32X4
+	select SND_MXC_SOC_SSI
+	select SND_MXC_SOC_MX2
+	help
+	  Say Y if you want to add support for SoC audio on Visstrim SM10
+	  board with TLV320AIC32X4 codec.
+
 config SND_SOC_PHYCORE_AC97
 	tristate "SoC Audio support for Phytec phyCORE (and phyCARD) boards"
 	depends on MACH_PCM043 || MACH_PCA100
diff --git a/sound/soc/imx/Makefile b/sound/soc/imx/Makefile
index b67fc02..d6d609b 100644
--- a/sound/soc/imx/Makefile
+++ b/sound/soc/imx/Makefile
@@ -10,8 +10,10 @@ obj-$(CONFIG_SND_MXC_SOC_MX2) += snd-soc-imx-mx2.o
 # i.MX Machine Support
 snd-soc-eukrea-tlv320-objs := eukrea-tlv320.o
 snd-soc-phycore-ac97-objs := phycore-ac97.o
+snd-soc-mx27vis-aic32x4-objs := mx27vis-aic32x4.o
 snd-soc-wm1133-ev1-objs := wm1133-ev1.o
 
 obj-$(CONFIG_SND_SOC_EUKREA_TLV320) += snd-soc-eukrea-tlv320.o
 obj-$(CONFIG_SND_SOC_PHYCORE_AC97) += snd-soc-phycore-ac97.o
+obj-$(CONFIG_SND_SOC_MX27VIS_AIC32X4) += snd-soc-mx27vis-aic32x4.o
 obj-$(CONFIG_SND_MXC_SOC_WM1133_EV1) += snd-soc-wm1133-ev1.o
diff --git a/sound/soc/imx/mx27vis-aic32x4.c b/sound/soc/imx/mx27vis-aic32x4.c
new file mode 100644
index 0000000..21583fe
--- /dev/null
+++ b/sound/soc/imx/mx27vis-aic32x4.c
@@ -0,0 +1,137 @@
+/*
+ * mx27vis-aic32x4.c
+ *
+ * Copyright 2011 Vista Silicon S.L.
+ *
+ * Author: Javier Martin <javier.martin@vista-silicon.com>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
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
+#include <linux/device.h>
+#include <linux/i2c.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+#include <asm/mach-types.h>
+#include <mach/audmux.h>
+
+#include "../codecs/tlv320aic32x4.h"
+#include "imx-ssi.h"
+
+static int mx27vis_aic32x4_hw_params(struct snd_pcm_substream *substream,
+			    struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	int ret;
+	u32 dai_format;
+
+	dai_format = SND_SOC_DAIFMT_DSP_B | SND_SOC_DAIFMT_NB_NF |
+		SND_SOC_DAIFMT_CBM_CFM;
+
+	/* set codec DAI configuration */
+	snd_soc_dai_set_fmt(codec_dai, dai_format);
+
+	/* set cpu DAI configuration */
+	snd_soc_dai_set_fmt(cpu_dai, dai_format);
+
+	ret = snd_soc_dai_set_sysclk(codec_dai, 0,
+				     25000000, SND_SOC_CLOCK_OUT);
+	if (ret) {
+		pr_err("%s: failed setting codec sysclk\n", __func__);
+		return ret;
+	}
+
+	ret = snd_soc_dai_set_sysclk(cpu_dai, IMX_SSP_SYS_CLK, 0,
+				SND_SOC_CLOCK_IN);
+	if (ret) {
+		pr_err("can't set CPU system clock IMX_SSP_SYS_CLK\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static struct snd_soc_ops mx27vis_aic32x4_snd_ops = {
+	.hw_params	= mx27vis_aic32x4_hw_params,
+};
+
+static struct snd_soc_dai_link mx27vis_aic32x4_dai = {
+	.name		= "tlv320aic32x4",
+	.stream_name	= "TLV320AIC32X4",
+	.codec_dai_name	= "tlv320aic32x4-hifi",
+	.platform_name	= "imx-pcm-audio.0",
+	.codec_name	= "tlv320aic32x4-codec.0-0018",
+	.cpu_dai_name	= "imx-ssi.0",
+	.ops		= &mx27vis_aic32x4_snd_ops,
+};
+
+static struct snd_soc_card mx27vis_aic32x4 = {
+	.name		= "visstrim_m10-audio",
+	.dai_link	= &mx27vis_aic32x4_dai,
+	.num_links	= 1,
+};
+
+static struct platform_device *mx27vis_aic32x4_snd_device;
+
+static int __init mx27vis_aic32x4_init(void)
+{
+	int ret;
+
+	mx27vis_aic32x4_snd_device = platform_device_alloc("soc-audio", -1);
+	if (!mx27vis_aic32x4_snd_device)
+		return -ENOMEM;
+
+	platform_set_drvdata(mx27vis_aic32x4_snd_device, &mx27vis_aic32x4);
+	ret = platform_device_add(mx27vis_aic32x4_snd_device);
+
+	if (ret) {
+		printk(KERN_ERR "ASoC: Platform device allocation failed\n");
+		platform_device_put(mx27vis_aic32x4_snd_device);
+	}
+
+	/* Connect SSI0 as clock slave to SSI1 external pins */
+	mxc_audmux_v1_configure_port(MX27_AUDMUX_HPCR1_SSI0,
+			MXC_AUDMUX_V1_PCR_SYN |
+			MXC_AUDMUX_V1_PCR_TFSDIR |
+			MXC_AUDMUX_V1_PCR_TCLKDIR |
+			MXC_AUDMUX_V1_PCR_TFCSEL(MX27_AUDMUX_PPCR1_SSI_PINS_1) |
+			MXC_AUDMUX_V1_PCR_RXDSEL(MX27_AUDMUX_PPCR1_SSI_PINS_1)
+	);
+	mxc_audmux_v1_configure_port(MX27_AUDMUX_PPCR1_SSI_PINS_1,
+			MXC_AUDMUX_V1_PCR_SYN |
+			MXC_AUDMUX_V1_PCR_RXDSEL(MX27_AUDMUX_HPCR1_SSI0)
+	);
+
+	return ret;
+}
+
+static void __exit mx27vis_aic32x4_exit(void)
+{
+	platform_device_unregister(mx27vis_aic32x4_snd_device);
+}
+
+module_init(mx27vis_aic32x4_init);
+module_exit(mx27vis_aic32x4_exit);
+
+MODULE_AUTHOR("Javier Martin <javier.martin@vista-silicon.com>");
+MODULE_DESCRIPTION("ALSA SoC AIC32X4 mx27 visstrim");
+MODULE_LICENSE("GPL");
-- 
1.7.0.4
