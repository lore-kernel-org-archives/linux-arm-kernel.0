From: suzuki.katsuhiro@socionext.com (Katsuhiro Suzuki)
Date: Wed, 22 Nov 2017 20:43:19 +0900
Subject: [PATCH 6/8] ASoC: uniphier: add support for UniPhier LD11/LD20 AIO
 driver
In-Reply-To: <20171122114321.29196-1-suzuki.katsuhiro@socionext.com>
References: <20171122114321.29196-1-suzuki.katsuhiro@socionext.com>
Message-ID: <20171122114321.29196-7-suzuki.katsuhiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for UniPhier AIO sound driver
which is included in UniPhier LD11/LD20 SoCs.

Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
---
 sound/soc/uniphier/Kconfig    |  10 ++
 sound/soc/uniphier/Makefile   |   1 +
 sound/soc/uniphier/aio-ld11.c | 343 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 354 insertions(+)
 create mode 100644 sound/soc/uniphier/aio-ld11.c

diff --git a/sound/soc/uniphier/Kconfig b/sound/soc/uniphier/Kconfig
index 38a02879b9d5..8da628a46a9b 100644
--- a/sound/soc/uniphier/Kconfig
+++ b/sound/soc/uniphier/Kconfig
@@ -13,6 +13,16 @@ config SND_SOC_UNIPHIER_AIO
 	select REGMAP_MMIO
 	depends on SND_SOC_UNIPHIER
 
+config SND_SOC_UNIPHIER_LD11
+	tristate "UniPhier LD11/LD20 Device Driver"
+	depends on SND_SOC_UNIPHIER
+	select SND_SOC_UNIPHIER_AIO
+	help
+	  This adds ASoC driver for Socionext UniPhier LD11/LD20
+	  input and output that can be used with other codecs.
+	  Select Y if you use such device.
+	  If unsure select "N".
+
 config SND_SOC_UNIPHIER_EVEA_CODEC
 	tristate "UniPhier SoC internal audio codec"
 	depends on SND_SOC_UNIPHIER
diff --git a/sound/soc/uniphier/Makefile b/sound/soc/uniphier/Makefile
index 705a60cb2aa5..55a77ad1192e 100644
--- a/sound/soc/uniphier/Makefile
+++ b/sound/soc/uniphier/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 snd-soc-uniphier-aio-objs := aio-regctrl.o aio-dma.o aio-core.o
+snd-soc-uniphier-aio-$(CONFIG_SND_SOC_UNIPHIER_LD11) += aio-ld11.o
 
 obj-$(CONFIG_SND_SOC_UNIPHIER_AIO) += snd-soc-uniphier-aio.o
 
diff --git a/sound/soc/uniphier/aio-ld11.c b/sound/soc/uniphier/aio-ld11.c
new file mode 100644
index 000000000000..b6e3bd11f23a
--- /dev/null
+++ b/sound/soc/uniphier/aio-ld11.c
@@ -0,0 +1,343 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Socionext UniPhier AIO ALSA driver for LD11/LD20.
+ *
+ * Copyright (c) 2016-2017 Socionext Inc.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; version 2
+ * of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "aio.h"
+
+static const struct uniphier_aio_spec uniphier_aio_ld11[] = {
+	/* for HDMI PCM In, Pin:AI1Dx */
+	{
+		.name = AUD_NAME_PCMIN1,
+		.gname = AUD_GNAME_HDMI,
+		.swm = {
+			.type  = PORT_TYPE_I2S,
+			.dir   = PORT_DIR_INPUT,
+			.rb    = { 21, 14, },
+			.ch    = { 21, 14, },
+			.iif   = { 5, 3, },
+			.iport = { 0, AUD_HW_PCMIN1, },
+		},
+	},
+
+	/* for SIF In, Pin:AI2Dx */
+	{
+		.name = AUD_NAME_PCMIN2,
+		.swm = {
+			.type  = PORT_TYPE_I2S,
+			.dir   = PORT_DIR_INPUT,
+			.rb    = { 22, 15, },
+			.ch    = { 22, 15, },
+			.iif   = { 6, 4, },
+			.iport = { 1, AUD_HW_PCMIN2, },
+		},
+	},
+
+	/* for Line In, Pin:AI3Dx */
+	{
+		.name = AUD_NAME_PCMIN3,
+		.gname = AUD_GNAME_LINE,
+		.swm = {
+			.type  = PORT_TYPE_EVE,
+			.dir   = PORT_DIR_INPUT,
+			.rb    = { 23, 16, },
+			.ch    = { 23, 16, },
+			.iif   = { 7, 5, },
+			.iport = { 2, AUD_HW_PCMIN3, },
+		},
+	},
+
+	/* for S/PDIF In, Pin:AI1IEC */
+	{
+		.name = AUD_NAME_IECIN1,
+		.gname = AUD_GNAME_IEC,
+		.swm = {
+			.type  = PORT_TYPE_SPDIF,
+			.dir   = PORT_DIR_INPUT,
+			.rb    = { 26, 17, },
+			.ch    = { 26, 17, },
+			.iif   = { 10, 6, },
+			.iport = { 3, AUD_HW_IECIN1, },
+		},
+	},
+
+	/* for Speaker, Pin:AO1Dx */
+	{
+		.name = AUD_NAME_HPCMOUT1,
+		.swm = {
+			.type  = PORT_TYPE_I2S,
+			.dir   = PORT_DIR_OUTPUT,
+			.rb    = { 0, 0, },
+			.ch    = { 0, 0, },
+			.oif   = { 0, 0, },
+			.oport = { 0, AUD_HW_HPCMOUT1, },
+		},
+	},
+
+	/* for HDMI PCM, Pin:AO2Dx */
+	{
+		.name = AUD_NAME_PCMOUT1,
+		.gname = AUD_GNAME_HDMI,
+		.swm = {
+			.type  = PORT_TYPE_I2S,
+			.dir   = PORT_DIR_OUTPUT,
+			.rb    = { 0, 0, },
+			.ch    = { 0, 0, },
+			.oif   = { 0, 0, },
+			.oport = { 3, AUD_HW_PCMOUT1, },
+		},
+	},
+
+	/* for Line Out, Pin:LO2_x */
+	{
+		.name = AUD_NAME_PCMOUT2,
+		.gname = AUD_GNAME_LINE,
+		.swm = {
+			.type  = PORT_TYPE_EVE,
+			.dir   = PORT_DIR_OUTPUT,
+			.rb    = { 2, 2, },
+			.ch    = { 2, 2, },
+			.oif   = { 2, 2, },
+			.oport = { 1, AUD_HW_PCMOUT2, },
+		},
+	},
+
+	/* for Headphone, Pin:HP1_x */
+	{
+		.name = AUD_NAME_PCMOUT3,
+		.swm = {
+			.type  = PORT_TYPE_EVE,
+			.dir   = PORT_DIR_OUTPUT,
+			.rb    = { 3, 3, },
+			.ch    = { 3, 3, },
+			.oif   = { 3, 3, },
+			.oport = { 2, AUD_HW_PCMOUT3, },
+		},
+	},
+
+	/* for HW Sampling Rate Converter */
+	{
+		.name = AUD_NAME_EPCMOUT2,
+		.swm = {
+			.type  = PORT_TYPE_CONV,
+			.dir   = PORT_DIR_OUTPUT,
+			.rb    = { 7, 5, },
+			.ch    = { 7, 5, },
+			.oif   = { 7, 5, },
+			.oport = { 6, AUD_HW_EPCMOUT2, },
+			.och   = { 17, 12, },
+			.iif   = { 1, 1, },
+		},
+	},
+
+	/* for HW Sampling Rate Converter 2 */
+	{
+		.name = AUD_NAME_EPCMOUT3,
+		.swm = {
+			.type  = PORT_TYPE_CONV,
+			.dir   = PORT_DIR_OUTPUT,
+			.rb    = { 8, 6, },
+			.ch    = { 8, 6, },
+			.oif   = { 8, 6, },
+			.oport = { 7, AUD_HW_EPCMOUT3, },
+			.och   = { 18, 13, },
+			.iif   = { 2, 2, },
+		},
+	},
+
+	/* for S/PDIF Out, Pin:AO1IEC */
+	{
+		.name = AUD_NAME_HIECOUT1,
+		.gname = AUD_GNAME_IEC,
+		.swm = {
+			.type  = PORT_TYPE_SPDIF,
+			.dir   = PORT_DIR_OUTPUT,
+			.rb    = { 1, 1, },
+			.ch    = { 1, 1, },
+			.oif   = { 1, 1, },
+			.oport = { 12, AUD_HW_HIECOUT1, },
+		},
+	},
+};
+
+static const struct snd_soc_dai_ops uniphier_aio_ops = {
+	.startup   = uniphier_aio_startup,
+	.shutdown  = uniphier_aio_shutdown,
+	.hw_params = uniphier_aio_hw_params,
+	.hw_free   = uniphier_aio_hw_free,
+	.prepare   = uniphier_aio_prepare,
+};
+
+static struct snd_soc_dai_driver uniphier_aio_dai_ld11[] = {
+	{
+		.name    = AUD_GNAME_HDMI,
+		.probe   = uniphier_aio_dai_probe,
+		.remove  = uniphier_aio_dai_remove,
+		.suspend = uniphier_aio_dai_suspend,
+		.resume  = uniphier_aio_dai_resume,
+		.playback = {
+			.stream_name = AUD_NAME_PCMOUT1,
+			.formats     = SNDRV_PCM_FMTBIT_S32_LE,
+			.rates       = SNDRV_PCM_RATE_48000,
+			.channels_min = 2,
+			.channels_max = 2,
+		},
+		.capture = {
+			.stream_name = AUD_NAME_PCMIN1,
+			.formats     = SNDRV_PCM_FMTBIT_S32_LE,
+			.rates       = SNDRV_PCM_RATE_48000 |
+				SNDRV_PCM_RATE_44100 |
+				SNDRV_PCM_RATE_32000,
+			.channels_min = 2,
+			.channels_max = 2,
+		},
+		.ops = &uniphier_aio_ops,
+	},
+	{
+		.name    = AUD_NAME_PCMIN2,
+		.probe   = uniphier_aio_dai_probe,
+		.remove  = uniphier_aio_dai_remove,
+		.suspend = uniphier_aio_dai_suspend,
+		.resume  = uniphier_aio_dai_resume,
+		.capture = {
+			.stream_name = AUD_NAME_PCMIN2,
+			.formats     = SNDRV_PCM_FMTBIT_S32_LE,
+			.rates       = SNDRV_PCM_RATE_48000,
+			.channels_min = 2,
+			.channels_max = 2,
+		},
+		.ops = &uniphier_aio_ops,
+	},
+	{
+		.name    = AUD_GNAME_LINE,
+		.probe   = uniphier_aio_dai_probe,
+		.remove  = uniphier_aio_dai_remove,
+		.suspend = uniphier_aio_dai_suspend,
+		.resume  = uniphier_aio_dai_resume,
+		.playback = {
+			.stream_name = AUD_NAME_PCMOUT2,
+			.formats     = SNDRV_PCM_FMTBIT_S32_LE,
+			.rates       = SNDRV_PCM_RATE_48000,
+			.channels_min = 2,
+			.channels_max = 2,
+		},
+		.capture = {
+			.stream_name = AUD_NAME_PCMIN3,
+			.formats     = SNDRV_PCM_FMTBIT_S32_LE,
+			.rates       = SNDRV_PCM_RATE_48000,
+			.channels_min = 2,
+			.channels_max = 2,
+		},
+		.ops = &uniphier_aio_ops,
+	},
+	{
+		.name    = AUD_NAME_HPCMOUT1,
+		.probe   = uniphier_aio_dai_probe,
+		.remove  = uniphier_aio_dai_remove,
+		.suspend = uniphier_aio_dai_suspend,
+		.resume  = uniphier_aio_dai_resume,
+		.playback = {
+			.stream_name = AUD_NAME_HPCMOUT1,
+			.formats     = SNDRV_PCM_FMTBIT_S32_LE,
+			.rates       = SNDRV_PCM_RATE_48000,
+			.channels_min = 2,
+			.channels_max = 2,
+		},
+		.ops = &uniphier_aio_ops,
+	},
+	{
+		.name    = AUD_NAME_PCMOUT3,
+		.probe   = uniphier_aio_dai_probe,
+		.remove  = uniphier_aio_dai_remove,
+		.suspend = uniphier_aio_dai_suspend,
+		.resume  = uniphier_aio_dai_resume,
+		.playback = {
+			.stream_name = AUD_NAME_PCMOUT3,
+			.formats     = SNDRV_PCM_FMTBIT_S32_LE,
+			.rates       = SNDRV_PCM_RATE_48000,
+			.channels_min = 2,
+			.channels_max = 2,
+		},
+		.ops = &uniphier_aio_ops,
+	},
+	{
+		.name    = AUD_NAME_HIECOUT1,
+		.probe   = uniphier_aio_dai_probe,
+		.remove  = uniphier_aio_dai_remove,
+		.suspend = uniphier_aio_dai_suspend,
+		.resume  = uniphier_aio_dai_resume,
+		.playback = {
+			.stream_name = AUD_NAME_HIECOUT1,
+			.formats     = SNDRV_PCM_FMTBIT_S32_LE,
+			.rates       = SNDRV_PCM_RATE_48000,
+			.channels_min = 2,
+			.channels_max = 2,
+		},
+		.ops = &uniphier_aio_ops,
+	},
+	{
+		.name    = AUD_NAME_EPCMOUT2,
+		.probe   = uniphier_aio_dai_probe,
+		.remove  = uniphier_aio_dai_remove,
+		.suspend = uniphier_aio_dai_suspend,
+		.resume  = uniphier_aio_dai_resume,
+		.playback = {
+			.stream_name = AUD_NAME_EPCMOUT2,
+			.formats     = SNDRV_PCM_FMTBIT_S32_LE,
+			.rates       = SNDRV_PCM_RATE_48000 |
+				SNDRV_PCM_RATE_44100 |
+				SNDRV_PCM_RATE_32000,
+			.channels_min = 2,
+			.channels_max = 2,
+		},
+		.ops = &uniphier_aio_ops,
+	},
+	{
+		.name    = AUD_NAME_EPCMOUT3,
+		.probe   = uniphier_aio_dai_probe,
+		.remove  = uniphier_aio_dai_remove,
+		.suspend = uniphier_aio_dai_suspend,
+		.resume  = uniphier_aio_dai_resume,
+		.playback = {
+			.stream_name = AUD_NAME_EPCMOUT3,
+			.formats     = SNDRV_PCM_FMTBIT_S32_LE,
+			.rates       = SNDRV_PCM_RATE_48000 |
+				SNDRV_PCM_RATE_44100 |
+				SNDRV_PCM_RATE_32000,
+			.channels_min = 2,
+			.channels_max = 2,
+		},
+		.ops = &uniphier_aio_ops,
+	},
+};
+
+const struct uniphier_aio_chip_spec uniphier_aio_ld11_spec = {
+	.aio_specs     = uniphier_aio_ld11,
+	.num_aio_specs = ARRAY_SIZE(uniphier_aio_ld11),
+	.dais          = uniphier_aio_dai_ld11,
+	.num_dais      = ARRAY_SIZE(uniphier_aio_dai_ld11),
+	.addr_ext      = 0,
+};
+
+const struct uniphier_aio_chip_spec uniphier_aio_ld20_spec = {
+	.aio_specs     = uniphier_aio_ld11,
+	.num_aio_specs = ARRAY_SIZE(uniphier_aio_ld11),
+	.dais          = uniphier_aio_dai_ld11,
+	.num_dais      = ARRAY_SIZE(uniphier_aio_dai_ld11),
+	.addr_ext      = 1,
+};
-- 
2.15.0
