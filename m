From: petrcvekcz@gmail.com (petrcvekcz at gmail.com)
Date: Fri, 17 Aug 2018 21:48:11 +0200
Subject: ASoC: pxa: remove pxa2xx-pcm driver, which caused regression
Message-ID: <f12148b7c9102c67d92a0467f1d653e37c6548ee.1534534854.git.petrcvekcz@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Petr Cvek <petrcvekcz@gmail.com>

The switch of PXA to dmaengine caused a regression for devices which are
using SSP/I2S and probably AC97. The problem is in multiple allocation
of DMA by function pxa2xx_soc_pcm_new() called by pxa-pcm-audio and
(SSP/I2S/AC97). The regression was found on HTC Magician and after playback
kernel generates an oops:

	WARNING: CPU: 0 PID: 892 at drivers/dma/dmaengine.c:788 dma_release_channel+0x44/0xa0
	chan reference count 0 != 1
	Modules linked in: ... snd_soc_magician snd_soc_uda1380 snd_soc_pxa2xx_i2s spi_pxa2xx_platform snd_soc_pxa2xx snd_soc_pxa_ssp snd_pxa2xx_lib snd_pcm_dmaengine i2c_pxa snd_soc_core snd_pcm snd_timer i2c_core snd ssp soundcore [last unloaded: pwm_bl]
	CPU: 0 PID: 892 Comm: aplay Tainted: G         C        4.18.0-rc6-next-20180726-magician+ #16
	Hardware name: HTC Magician
	[<c0107d90>] (unwind_backtrace) from [<c010594c>] (show_stack+0x10/0x14)
	[<c010594c>] (show_stack) from [<c0111680>] (__warn+0xd4/0xec)
	[<c0111680>] (__warn) from [<c01112d0>] (warn_slowpath_fmt+0x44/0x6c)
	[<c01112d0>] (warn_slowpath_fmt) from [<c034908c>] (dma_release_channel+0x44/0xa0)
	[<c034908c>] (dma_release_channel) from [<bf330528>] (snd_dmaengine_pcm_close_release_chan+0x44/0xb1c [snd_pcm_dmaengine])
	[<bf330528>] (snd_dmaengine_pcm_close_release_chan [snd_pcm_dmaengine]) from [<bf26c29c>] (soc_pcm_components_close+0x8c/0xac [snd_soc_core])
	[<bf26c29c>] (soc_pcm_components_close [snd_soc_core]) from [<bf26c3a0>] (soc_pcm_close+0xe4/0xd44 [snd_soc_core])
	[<bf26c3a0>] (soc_pcm_close [snd_soc_core]) from [<bf167254>] (snd_pcm_release_substream+0x88/0x108 [snd_pcm])
	[<bf167254>] (snd_pcm_release_substream [snd_pcm]) from [<bf167330>] (snd_pcm_release+0x5c/0xd2c [snd_pcm])
	[<bf167330>] (snd_pcm_release [snd_pcm]) from [<c01c39e4>] (__fput+0xdc/0x1e8)
	[<c01c39e4>] (__fput) from [<c0129e7c>] (task_work_run+0xc4/0xd4)
	[<c0129e7c>] (task_work_run) from [<c01053ac>] (do_work_pending+0xc0/0xc8)
	[<c01053ac>] (do_work_pending) from [<c0101068>] (slow_work_pending+0xc/0x20)
	Exception stack(0xc2fdffb0 to 0xc2fdfff8)
	ffa0:                                     00000000 0154d1a0 01542a3c 00000000
	ffc0: 0154d150 00000000 0009283c 00000006 000003f0 0154d4c8 00000000 0154d4c8
	ffe0: b6ee7d70 bef13960 b6e547b8 b6cfe018 60000010 00000004

Removing bindings for snd_soc_magician fixes the problem (tested). Other
machines should have the same problem if they use at least one of
pxa-ssp-dai or pxa2xx-i2s. Considering pxa2xx-ac97 uses the function
pxa2xx_soc_pcm_new() too it should produce the same problem (untested).

After removal from I2S/SSP/AC97 machines there seems to be no user of
pxa2xx-pcm, so remove the driver completely, change platform device in
arch/arm/mach-pxa/devices.c to snd-soc-dummy and an example in the
documentation.

Signed-off-by: Petr Cvek <petrcvekcz@gmail.com>
---
 Documentation/sound/soc/machine.rst |  2 +-
 arch/arm/mach-pxa/devices.c         |  2 +-
 sound/soc/pxa/Kconfig               | 43 ++++++++++----------------
 sound/soc/pxa/Makefile              |  2 --
 sound/soc/pxa/corgi.c               |  1 -
 sound/soc/pxa/e740_wm9705.c         |  2 --
 sound/soc/pxa/e750_wm9705.c         |  2 --
 sound/soc/pxa/e800_wm9712.c         |  2 --
 sound/soc/pxa/em-x270.c             |  2 --
 sound/soc/pxa/hx4700.c              |  1 -
 sound/soc/pxa/imote2.c              |  1 -
 sound/soc/pxa/magician.c            |  2 --
 sound/soc/pxa/mioa701_wm9713.c      |  2 --
 sound/soc/pxa/palm27x.c             |  2 --
 sound/soc/pxa/poodle.c              |  1 -
 sound/soc/pxa/pxa2xx-pcm.c          | 48 -----------------------------
 sound/soc/pxa/raumfeld.c            |  2 --
 sound/soc/pxa/spitz.c               |  1 -
 sound/soc/pxa/tosa.c                |  2 --
 sound/soc/pxa/z2.c                  |  1 -
 sound/soc/pxa/zylonite.c            |  3 --
 21 files changed, 18 insertions(+), 106 deletions(-)
 delete mode 100644 sound/soc/pxa/pxa2xx-pcm.c

diff --git a/Documentation/sound/soc/machine.rst b/Documentation/sound/soc/machine.rst
index 515c9444deaf..a65f41ade2ca 100644
--- a/Documentation/sound/soc/machine.rst
+++ b/Documentation/sound/soc/machine.rst
@@ -65,7 +65,7 @@ struct snd_soc_dai_link is used to set up each DAI in your machine. e.g.
 	.stream_name = "WM8731",
 	.cpu_dai_name = "pxa-is2-dai",
 	.codec_dai_name = "wm8731-hifi",
-	.platform_name = "pxa-pcm-audio",
+	.platform_name = "snd-soc-dummy",
 	.codec_name = "wm8713-codec.0-001a",
 	.init = corgi_wm8731_init,
 	.ops = &corgi_ops,
diff --git a/arch/arm/mach-pxa/devices.c b/arch/arm/mach-pxa/devices.c
index a24783a03827..82ee7f6c1dcf 100644
--- a/arch/arm/mach-pxa/devices.c
+++ b/arch/arm/mach-pxa/devices.c
@@ -371,7 +371,7 @@ struct platform_device pxa_device_asoc_ssp4 = {
 };
 
 struct platform_device pxa_device_asoc_platform = {
-	.name		= "pxa-pcm-audio",
+	.name		= "snd-soc-dummy",
 	.id		= -1,
 };
 
diff --git a/sound/soc/pxa/Kconfig b/sound/soc/pxa/Kconfig
index 776e148b0aa2..d865c1041c6b 100644
--- a/sound/soc/pxa/Kconfig
+++ b/sound/soc/pxa/Kconfig
@@ -1,12 +1,3 @@
-config SND_PXA2XX_SOC
-	tristate "SoC Audio for the Intel PXA2xx chip"
-	depends on ARCH_PXA || COMPILE_TEST
-	select SND_PXA2XX_LIB
-	help
-	  Say Y or M if you want to add support for codecs attached to
-	  the PXA2xx AC97, I2S or SSP interface. You will also need
-	  to select the audio interfaces to support below.
-
 config SND_MMP_SOC
 	bool "Soc Audio for Marvell MMP chips"
 	depends on ARCH_MMP
@@ -43,7 +34,7 @@ config SND_MMP_SOC_SSPA
 
 config SND_PXA2XX_SOC_CORGI
 	tristate "SoC Audio support for Sharp Zaurus SL-C7x0"
-	depends on SND_PXA2XX_SOC && PXA_SHARP_C7xx && I2C
+	depends on PXA_SHARP_C7xx && I2C
 	select SND_PXA2XX_SOC_I2S
 	select SND_SOC_WM8731
 	help
@@ -52,7 +43,7 @@ config SND_PXA2XX_SOC_CORGI
 
 config SND_PXA2XX_SOC_SPITZ
 	tristate "SoC Audio support for Sharp Zaurus SL-Cxx00"
-	depends on SND_PXA2XX_SOC && PXA_SHARP_Cxx00 && I2C
+	depends on PXA_SHARP_Cxx00 && I2C
 	select SND_PXA2XX_SOC_I2S
 	select SND_SOC_WM8750
 	help
@@ -61,7 +52,7 @@ config SND_PXA2XX_SOC_SPITZ
 
 config SND_PXA2XX_SOC_Z2
 	tristate "SoC Audio support for Zipit Z2"
-	depends on SND_PXA2XX_SOC && MACH_ZIPIT2 && I2C
+	depends on MACH_ZIPIT2 && I2C
 	select SND_PXA2XX_SOC_I2S
 	select SND_SOC_WM8750
 	help
@@ -69,7 +60,7 @@ config SND_PXA2XX_SOC_Z2
 
 config SND_PXA2XX_SOC_POODLE
 	tristate "SoC Audio support for Poodle"
-	depends on SND_PXA2XX_SOC && MACH_POODLE && I2C
+	depends on MACH_POODLE && I2C
 	select SND_PXA2XX_SOC_I2S
 	select SND_SOC_WM8731
 	help
@@ -78,7 +69,7 @@ config SND_PXA2XX_SOC_POODLE
 
 config SND_PXA2XX_SOC_TOSA
 	tristate "SoC AC97 Audio support for Tosa"
-	depends on SND_PXA2XX_SOC && MACH_TOSA
+	depends on MACH_TOSA
 	depends on MFD_TC6393XB
 	select SND_PXA2XX_SOC_AC97
 	select SND_SOC_WM9712
@@ -88,7 +79,7 @@ config SND_PXA2XX_SOC_TOSA
 
 config SND_PXA2XX_SOC_E740
 	tristate "SoC AC97 Audio support for e740"
-	depends on SND_PXA2XX_SOC && MACH_E740
+	depends on MACH_E740
 	select SND_SOC_WM9705
 	select SND_PXA2XX_SOC_AC97
 	help
@@ -97,7 +88,7 @@ config SND_PXA2XX_SOC_E740
 
 config SND_PXA2XX_SOC_E750
 	tristate "SoC AC97 Audio support for e750"
-	depends on SND_PXA2XX_SOC && MACH_E750
+	depends on MACH_E750
 	select SND_SOC_WM9705
 	select SND_PXA2XX_SOC_AC97
 	help
@@ -106,7 +97,7 @@ config SND_PXA2XX_SOC_E750
 
 config SND_PXA2XX_SOC_E800
 	tristate "SoC AC97 Audio support for e800"
-	depends on SND_PXA2XX_SOC && MACH_E800
+	depends on MACH_E800
 	select SND_SOC_WM9712
 	select SND_PXA2XX_SOC_AC97
 	help
@@ -115,8 +106,7 @@ config SND_PXA2XX_SOC_E800
 
 config SND_PXA2XX_SOC_EM_X270
 	tristate "SoC Audio support for CompuLab EM-x270, eXeda and CM-X300"
-	depends on SND_PXA2XX_SOC && (MACH_EM_X270 || MACH_EXEDA || \
-			MACH_CM_X300)
+	depends on MACH_EM_X270 || MACH_EXEDA || MACH_CM_X300
 	select SND_PXA2XX_SOC_AC97
 	select SND_SOC_WM9712
 	help
@@ -125,8 +115,7 @@ config SND_PXA2XX_SOC_EM_X270
 
 config SND_PXA2XX_SOC_PALM27X
 	bool "SoC Audio support for Palm T|X, T5, E2 and LifeDrive"
-	depends on SND_PXA2XX_SOC && (MACH_PALMLD || MACH_PALMTX || \
-			MACH_PALMT5 || MACH_PALMTE2)
+	depends on MACH_PALMLD || MACH_PALMTX || MACH_PALMT5 || MACH_PALMTE2
 	select SND_PXA2XX_SOC_AC97
 	select SND_SOC_WM9712
 	help
@@ -155,7 +144,7 @@ config SND_SOC_TTC_DKB
 
 config SND_SOC_ZYLONITE
 	tristate "SoC Audio support for Marvell Zylonite"
-	depends on SND_PXA2XX_SOC && MACH_ZYLONITE
+	depends on MACH_ZYLONITE
 	select SND_PXA2XX_SOC_AC97
 	select SND_PXA_SOC_SSP
 	select SND_SOC_WM9713
@@ -165,7 +154,7 @@ config SND_SOC_ZYLONITE
 
 config SND_SOC_RAUMFELD
 	tristate "SoC Audio support Raumfeld audio adapter"
-	depends on SND_PXA2XX_SOC && (MACH_RAUMFELD_SPEAKER || MACH_RAUMFELD_CONNECTOR)
+	depends on MACH_RAUMFELD_SPEAKER || MACH_RAUMFELD_CONNECTOR
 	depends on I2C && SPI_MASTER
 	select SND_PXA_SOC_SSP
 	select SND_SOC_CS4270
@@ -175,7 +164,7 @@ config SND_SOC_RAUMFELD
 
 config SND_PXA2XX_SOC_HX4700
 	tristate "SoC Audio support for HP iPAQ hx4700"
-	depends on SND_PXA2XX_SOC && MACH_H4700 && I2C
+	depends on MACH_H4700 && I2C
 	select SND_PXA2XX_SOC_I2S
 	select SND_SOC_AK4641
 	help
@@ -184,7 +173,7 @@ config SND_PXA2XX_SOC_HX4700
 
 config SND_PXA2XX_SOC_MAGICIAN
 	tristate "SoC Audio support for HTC Magician"
-	depends on SND_PXA2XX_SOC && MACH_MAGICIAN && I2C
+	depends on MACH_MAGICIAN && I2C
 	select SND_PXA2XX_SOC_I2S
 	select SND_PXA_SOC_SSP
 	select SND_SOC_UDA1380
@@ -194,7 +183,7 @@ config SND_PXA2XX_SOC_MAGICIAN
 
 config SND_PXA2XX_SOC_MIOA701
         tristate "SoC Audio support for MIO A701"
-        depends on SND_PXA2XX_SOC && MACH_MIOA701
+        depends on MACH_MIOA701
         select SND_PXA2XX_SOC_AC97
         select SND_SOC_WM9713
         help
@@ -203,7 +192,7 @@ config SND_PXA2XX_SOC_MIOA701
 
 config SND_PXA2XX_SOC_IMOTE2
        tristate "SoC Audio support for IMote 2"
-       depends on SND_PXA2XX_SOC && MACH_INTELMOTE2 && I2C
+       depends on MACH_INTELMOTE2 && I2C
        select SND_PXA2XX_SOC_I2S
        select SND_SOC_WM8940
        help
diff --git a/sound/soc/pxa/Makefile b/sound/soc/pxa/Makefile
index 5b265662f04f..93c0fdd041ed 100644
--- a/sound/soc/pxa/Makefile
+++ b/sound/soc/pxa/Makefile
@@ -1,13 +1,11 @@
 # SPDX-License-Identifier: GPL-2.0
 # PXA Platform Support
-snd-soc-pxa2xx-objs := pxa2xx-pcm.o
 snd-soc-pxa2xx-ac97-objs := pxa2xx-ac97.o
 snd-soc-pxa2xx-i2s-objs := pxa2xx-i2s.o
 snd-soc-pxa-ssp-objs := pxa-ssp.o
 snd-soc-mmp-objs := mmp-pcm.o
 snd-soc-mmp-sspa-objs := mmp-sspa.o
 
-obj-$(CONFIG_SND_PXA2XX_SOC) += snd-soc-pxa2xx.o
 obj-$(CONFIG_SND_PXA2XX_SOC_AC97) += snd-soc-pxa2xx-ac97.o
 obj-$(CONFIG_SND_PXA2XX_SOC_I2S) += snd-soc-pxa2xx-i2s.o
 obj-$(CONFIG_SND_PXA_SOC_SSP) += snd-soc-pxa-ssp.o
diff --git a/sound/soc/pxa/corgi.c b/sound/soc/pxa/corgi.c
index 054e0d65db9d..d36193e45be9 100644
--- a/sound/soc/pxa/corgi.c
+++ b/sound/soc/pxa/corgi.c
@@ -265,7 +265,6 @@ static struct snd_soc_dai_link corgi_dai = {
 	.stream_name = "WM8731",
 	.cpu_dai_name = "pxa2xx-i2s",
 	.codec_dai_name = "wm8731-hifi",
-	.platform_name = "pxa-pcm-audio",
 	.codec_name = "wm8731.0-001b",
 	.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
 		   SND_SOC_DAIFMT_CBS_CFS,
diff --git a/sound/soc/pxa/e740_wm9705.c b/sound/soc/pxa/e740_wm9705.c
index 8ab7032631b7..cfae28571ec7 100644
--- a/sound/soc/pxa/e740_wm9705.c
+++ b/sound/soc/pxa/e740_wm9705.c
@@ -90,7 +90,6 @@ static struct snd_soc_dai_link e740_dai[] = {
 		.stream_name = "AC97 HiFi",
 		.cpu_dai_name = "pxa2xx-ac97",
 		.codec_dai_name = "wm9705-hifi",
-		.platform_name = "pxa-pcm-audio",
 		.codec_name = "wm9705-codec",
 	},
 	{
@@ -98,7 +97,6 @@ static struct snd_soc_dai_link e740_dai[] = {
 		.stream_name = "AC97 Aux",
 		.cpu_dai_name = "pxa2xx-ac97-aux",
 		.codec_dai_name = "wm9705-aux",
-		.platform_name = "pxa-pcm-audio",
 		.codec_name = "wm9705-codec",
 	},
 };
diff --git a/sound/soc/pxa/e750_wm9705.c b/sound/soc/pxa/e750_wm9705.c
index 82bcbbb1841b..21c1f504a141 100644
--- a/sound/soc/pxa/e750_wm9705.c
+++ b/sound/soc/pxa/e750_wm9705.c
@@ -73,7 +73,6 @@ static struct snd_soc_dai_link e750_dai[] = {
 		.stream_name = "AC97 HiFi",
 		.cpu_dai_name = "pxa2xx-ac97",
 		.codec_dai_name = "wm9705-hifi",
-		.platform_name = "pxa-pcm-audio",
 		.codec_name = "wm9705-codec",
 		/* use ops to check startup state */
 	},
@@ -82,7 +81,6 @@ static struct snd_soc_dai_link e750_dai[] = {
 		.stream_name = "AC97 Aux",
 		.cpu_dai_name = "pxa2xx-ac97-aux",
 		.codec_dai_name = "wm9705-aux",
-		.platform_name = "pxa-pcm-audio",
 		.codec_name = "wm9705-codec",
 	},
 };
diff --git a/sound/soc/pxa/e800_wm9712.c b/sound/soc/pxa/e800_wm9712.c
index 1ed8aa2348f1..2475366f0e0b 100644
--- a/sound/soc/pxa/e800_wm9712.c
+++ b/sound/soc/pxa/e800_wm9712.c
@@ -74,7 +74,6 @@ static struct snd_soc_dai_link e800_dai[] = {
 		.stream_name = "AC97 HiFi",
 		.cpu_dai_name = "pxa2xx-ac97",
 		.codec_dai_name = "wm9712-hifi",
-		.platform_name = "pxa-pcm-audio",
 		.codec_name = "wm9712-codec",
 	},
 	{
@@ -82,7 +81,6 @@ static struct snd_soc_dai_link e800_dai[] = {
 		.stream_name = "AC97 Aux",
 		.cpu_dai_name = "pxa2xx-ac97-aux",
 		.codec_dai_name = "wm9712-aux",
-		.platform_name = "pxa-pcm-audio",
 		.codec_name = "wm9712-codec",
 	},
 };
diff --git a/sound/soc/pxa/em-x270.c b/sound/soc/pxa/em-x270.c
index e046770ce70e..76b466b3eaee 100644
--- a/sound/soc/pxa/em-x270.c
+++ b/sound/soc/pxa/em-x270.c
@@ -36,7 +36,6 @@ static struct snd_soc_dai_link em_x270_dai[] = {
 		.stream_name = "AC97 HiFi",
 		.cpu_dai_name = "pxa2xx-ac97",
 		.codec_dai_name = "wm9712-hifi",
-		.platform_name = "pxa-pcm-audio",
 		.codec_name = "wm9712-codec",
 	},
 	{
@@ -44,7 +43,6 @@ static struct snd_soc_dai_link em_x270_dai[] = {
 		.stream_name = "AC97 Aux",
 		.cpu_dai_name = "pxa2xx-ac97-aux",
 		.codec_dai_name = "wm9712-aux",
-		.platform_name = "pxa-pcm-audio",
 		.codec_name = "wm9712-codec",
 	},
 };
diff --git a/sound/soc/pxa/hx4700.c b/sound/soc/pxa/hx4700.c
index 6cdef5d4954e..79ffeab616f7 100644
--- a/sound/soc/pxa/hx4700.c
+++ b/sound/soc/pxa/hx4700.c
@@ -144,7 +144,6 @@ static struct snd_soc_dai_link hx4700_dai = {
 	.stream_name = "AK4641",
 	.cpu_dai_name = "pxa2xx-i2s",
 	.codec_dai_name = "ak4641-hifi",
-	.platform_name = "pxa-pcm-audio",
 	.codec_name = "ak4641.0-0012",
 	.init = hx4700_ak4641_init,
 	.dai_fmt = SND_SOC_DAIFMT_MSB | SND_SOC_DAIFMT_NB_NF |
diff --git a/sound/soc/pxa/imote2.c b/sound/soc/pxa/imote2.c
index 78475376f971..84dff8d34472 100644
--- a/sound/soc/pxa/imote2.c
+++ b/sound/soc/pxa/imote2.c
@@ -51,7 +51,6 @@ static struct snd_soc_dai_link imote2_dai = {
 	.stream_name = "WM8940",
 	.cpu_dai_name = "pxa2xx-i2s",
 	.codec_dai_name = "wm8940-hifi",
-	.platform_name = "pxa-pcm-audio",
 	.codec_name = "wm8940-codec.0-0034",
 	.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
 		   SND_SOC_DAIFMT_CBS_CFS,
diff --git a/sound/soc/pxa/magician.c b/sound/soc/pxa/magician.c
index 935a248e5bf6..a7e7fa08e0a4 100644
--- a/sound/soc/pxa/magician.c
+++ b/sound/soc/pxa/magician.c
@@ -296,7 +296,6 @@ static struct snd_soc_dai_link magician_dai[] = {
 	.stream_name = "UDA1380 Playback",
 	.cpu_dai_name = "pxa-ssp-dai.0",
 	.codec_dai_name = "uda1380-hifi-playback",
-	.platform_name = "pxa-pcm-audio",
 	.codec_name = "uda1380-codec.0-0018",
 	.ops = &magician_playback_ops,
 },
@@ -305,7 +304,6 @@ static struct snd_soc_dai_link magician_dai[] = {
 	.stream_name = "UDA1380 Capture",
 	.cpu_dai_name = "pxa2xx-i2s",
 	.codec_dai_name = "uda1380-hifi-capture",
-	.platform_name = "pxa-pcm-audio",
 	.codec_name = "uda1380-codec.0-0018",
 	.ops = &magician_capture_ops,
 }
diff --git a/sound/soc/pxa/mioa701_wm9713.c b/sound/soc/pxa/mioa701_wm9713.c
index 47052fe3f5f4..121dcb1def3c 100644
--- a/sound/soc/pxa/mioa701_wm9713.c
+++ b/sound/soc/pxa/mioa701_wm9713.c
@@ -150,7 +150,6 @@ static struct snd_soc_dai_link mioa701_dai[] = {
 		.codec_dai_name = "wm9713-hifi",
 		.codec_name = "wm9713-codec",
 		.init = mioa701_wm9713_init,
-		.platform_name = "pxa-pcm-audio",
 		.ops = &mioa701_ops,
 	},
 	{
@@ -159,7 +158,6 @@ static struct snd_soc_dai_link mioa701_dai[] = {
 		.cpu_dai_name = "pxa2xx-ac97-aux",
 		.codec_dai_name = "wm9713-aux",
 		.codec_name = "wm9713-codec",
-		.platform_name = "pxa-pcm-audio",
 		.ops = &mioa701_ops,
 	},
 };
diff --git a/sound/soc/pxa/palm27x.c b/sound/soc/pxa/palm27x.c
index 97167048572d..490717c7a5ce 100644
--- a/sound/soc/pxa/palm27x.c
+++ b/sound/soc/pxa/palm27x.c
@@ -94,7 +94,6 @@ static struct snd_soc_dai_link palm27x_dai[] = {
 	.cpu_dai_name = "pxa2xx-ac97",
 	.codec_dai_name =  "wm9712-hifi",
 	.codec_name = "wm9712-codec",
-	.platform_name = "pxa-pcm-audio",
 	.init = palm27x_ac97_init,
 },
 {
@@ -103,7 +102,6 @@ static struct snd_soc_dai_link palm27x_dai[] = {
 	.cpu_dai_name = "pxa2xx-ac97-aux",
 	.codec_dai_name = "wm9712-aux",
 	.codec_name = "wm9712-codec",
-	.platform_name = "pxa-pcm-audio",
 },
 };
 
diff --git a/sound/soc/pxa/poodle.c b/sound/soc/pxa/poodle.c
index b6693f32fc02..728904266930 100644
--- a/sound/soc/pxa/poodle.c
+++ b/sound/soc/pxa/poodle.c
@@ -229,7 +229,6 @@ static struct snd_soc_dai_link poodle_dai = {
 	.stream_name = "WM8731",
 	.cpu_dai_name = "pxa2xx-i2s",
 	.codec_dai_name = "wm8731-hifi",
-	.platform_name = "pxa-pcm-audio",
 	.codec_name = "wm8731.0-001b",
 	.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
 		   SND_SOC_DAIFMT_CBS_CFS,
diff --git a/sound/soc/pxa/pxa2xx-pcm.c b/sound/soc/pxa/pxa2xx-pcm.c
deleted file mode 100644
index 72eaaef1b426..000000000000
--- a/sound/soc/pxa/pxa2xx-pcm.c
+++ /dev/null
@@ -1,48 +0,0 @@
-/*
- * linux/sound/arm/pxa2xx-pcm.c -- ALSA PCM interface for the Intel PXA2xx chip
- *
- * Author:	Nicolas Pitre
- * Created:	Nov 30, 2004
- * Copyright:	(C) 2004 MontaVista Software, Inc.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#include <linux/dma-mapping.h>
-#include <linux/module.h>
-#include <linux/dmaengine.h>
-#include <linux/of.h>
-
-#include <sound/core.h>
-#include <sound/soc.h>
-#include <sound/pxa2xx-lib.h>
-#include <sound/dmaengine_pcm.h>
-
-static const struct snd_soc_component_driver pxa2xx_soc_platform = {
-	.ops		= &pxa2xx_pcm_ops,
-	.pcm_new	= pxa2xx_soc_pcm_new,
-	.pcm_free	= pxa2xx_pcm_free_dma_buffers,
-};
-
-static int pxa2xx_soc_platform_probe(struct platform_device *pdev)
-{
-	return devm_snd_soc_register_component(&pdev->dev, &pxa2xx_soc_platform,
-					       NULL, 0);
-}
-
-static struct platform_driver pxa_pcm_driver = {
-	.driver = {
-		.name = "pxa-pcm-audio",
-	},
-
-	.probe = pxa2xx_soc_platform_probe,
-};
-
-module_platform_driver(pxa_pcm_driver);
-
-MODULE_AUTHOR("Nicolas Pitre");
-MODULE_DESCRIPTION("Intel PXA2xx PCM DMA module");
-MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:pxa-pcm-audio");
diff --git a/sound/soc/pxa/raumfeld.c b/sound/soc/pxa/raumfeld.c
index 111a907c4eb9..b2ae5aec0b83 100644
--- a/sound/soc/pxa/raumfeld.c
+++ b/sound/soc/pxa/raumfeld.c
@@ -205,7 +205,6 @@ static struct snd_soc_ops raumfeld_ak4104_ops = {
 	.name		= "CS4270",			\
 	.stream_name	= "CS4270",			\
 	.cpu_dai_name	= "pxa-ssp-dai.0",		\
-	.platform_name	= "pxa-pcm-audio",		\
 	.codec_dai_name	= "cs4270-hifi",		\
 	.codec_name	= "cs4270.0-0048",	\
 	.dai_fmt	= SND_SOC_DAIFMT_I2S |		\
@@ -220,7 +219,6 @@ static struct snd_soc_ops raumfeld_ak4104_ops = {
 	.stream_name	= "Playback",			\
 	.cpu_dai_name	= "pxa-ssp-dai.1",		\
 	.codec_dai_name	= "ak4104-hifi",		\
-	.platform_name	= "pxa-pcm-audio",		\
 	.dai_fmt	= SND_SOC_DAIFMT_I2S |		\
 			  SND_SOC_DAIFMT_NB_NF |	\
 			  SND_SOC_DAIFMT_CBS_CFS,       \
diff --git a/sound/soc/pxa/spitz.c b/sound/soc/pxa/spitz.c
index 1671da648e95..57e4ecb9cbe2 100644
--- a/sound/soc/pxa/spitz.c
+++ b/sound/soc/pxa/spitz.c
@@ -262,7 +262,6 @@ static struct snd_soc_dai_link spitz_dai = {
 	.stream_name = "WM8750",
 	.cpu_dai_name = "pxa2xx-i2s",
 	.codec_dai_name = "wm8750-hifi",
-	.platform_name = "pxa-pcm-audio",
 	.codec_name = "wm8750.0-001b",
 	.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
 		   SND_SOC_DAIFMT_CBS_CFS,
diff --git a/sound/soc/pxa/tosa.c b/sound/soc/pxa/tosa.c
index ae9c12e1ea2a..b2ddfeea6b85 100644
--- a/sound/soc/pxa/tosa.c
+++ b/sound/soc/pxa/tosa.c
@@ -188,7 +188,6 @@ static struct snd_soc_dai_link tosa_dai[] = {
 	.stream_name = "AC97 HiFi",
 	.cpu_dai_name = "pxa2xx-ac97",
 	.codec_dai_name = "wm9712-hifi",
-	.platform_name = "pxa-pcm-audio",
 	.codec_name = "wm9712-codec",
 	.ops = &tosa_ops,
 },
@@ -197,7 +196,6 @@ static struct snd_soc_dai_link tosa_dai[] = {
 	.stream_name = "AC97 Aux",
 	.cpu_dai_name = "pxa2xx-ac97-aux",
 	.codec_dai_name = "wm9712-aux",
-	.platform_name = "pxa-pcm-audio",
 	.codec_name = "wm9712-codec",
 	.ops = &tosa_ops,
 },
diff --git a/sound/soc/pxa/z2.c b/sound/soc/pxa/z2.c
index 5b0eccd2b4dd..5e2307959b7b 100644
--- a/sound/soc/pxa/z2.c
+++ b/sound/soc/pxa/z2.c
@@ -162,7 +162,6 @@ static struct snd_soc_dai_link z2_dai = {
 	.stream_name	= "WM8750",
 	.cpu_dai_name	= "pxa2xx-i2s",
 	.codec_dai_name	= "wm8750-hifi",
-	.platform_name = "pxa-pcm-audio",
 	.codec_name	= "wm8750.0-001b",
 	.init		= z2_wm8750_init,
 	.dai_fmt	= SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
diff --git a/sound/soc/pxa/zylonite.c b/sound/soc/pxa/zylonite.c
index 230eee450f45..753c828ade37 100644
--- a/sound/soc/pxa/zylonite.c
+++ b/sound/soc/pxa/zylonite.c
@@ -132,7 +132,6 @@ static struct snd_soc_dai_link zylonite_dai[] = {
 	.name = "AC97",
 	.stream_name = "AC97 HiFi",
 	.codec_name = "wm9713-codec",
-	.platform_name = "pxa-pcm-audio",
 	.cpu_dai_name = "pxa2xx-ac97",
 	.codec_dai_name = "wm9713-hifi",
 	.init = zylonite_wm9713_init,
@@ -141,7 +140,6 @@ static struct snd_soc_dai_link zylonite_dai[] = {
 	.name = "AC97 Aux",
 	.stream_name = "AC97 Aux",
 	.codec_name = "wm9713-codec",
-	.platform_name = "pxa-pcm-audio",
 	.cpu_dai_name = "pxa2xx-ac97-aux",
 	.codec_dai_name = "wm9713-aux",
 },
@@ -149,7 +147,6 @@ static struct snd_soc_dai_link zylonite_dai[] = {
 	.name = "WM9713 Voice",
 	.stream_name = "WM9713 Voice",
 	.codec_name = "wm9713-codec",
-	.platform_name = "pxa-pcm-audio",
 	.cpu_dai_name = "pxa-ssp-dai.2",
 	.codec_dai_name = "wm9713-voice",
 	.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
-- 
2.18.0
