From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 23 Feb 2012 22:48:38 +0800
Subject: [PATCH 3/4] ASoC: imx: merge sound/soc/imx into sound/soc/fsl
In-Reply-To: <1330008519-3584-1-git-send-email-shawn.guo@linaro.org>
References: <1329979644-31046-1-git-send-email-shawn.guo@linaro.org>
 <1330008519-3584-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1330008519-3584-4-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Freescale PowerPC and ARM/IMX families share the same SSI IP block.
The patch merges sound/soc/imx into sound/soc/fsl, so that the possible
code sharing and consolidation can happen.

This is a plain merge, except that menuconfig SND_POWERPC_SOC is added
in Kconfig for PowerPC platform as a correspondence to SND_IMX_SOC for
IMX platform.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 sound/soc/Kconfig                        |    1 -
 sound/soc/Makefile                       |    1 -
 sound/soc/fsl/Kconfig                    |   84 ++++++++++++++++++++++++++++++
 sound/soc/fsl/Makefile                   |   19 +++++++
 sound/soc/{imx => fsl}/eukrea-tlv320.c   |    2 +-
 sound/soc/{imx => fsl}/imx-pcm-dma-mx2.c |    0
 sound/soc/{imx => fsl}/imx-pcm-fiq.c     |    0
 sound/soc/{imx => fsl}/imx-pcm.c         |    0
 sound/soc/{imx => fsl}/imx-pcm.h         |    0
 sound/soc/{imx => fsl}/imx-ssi.c         |    2 +-
 sound/soc/{imx => fsl}/imx-ssi.h         |    0
 sound/soc/{imx => fsl}/mx27vis-aic32x4.c |    0
 sound/soc/{imx => fsl}/phycore-ac97.c    |    0
 sound/soc/{imx => fsl}/wm1133-ev1.c      |    0
 sound/soc/imx/Kconfig                    |   71 -------------------------
 sound/soc/imx/Makefile                   |   19 -------
 16 files changed, 105 insertions(+), 94 deletions(-)
 rename sound/soc/{imx => fsl}/eukrea-tlv320.c (99%)
 rename sound/soc/{imx => fsl}/imx-pcm-dma-mx2.c (100%)
 rename sound/soc/{imx => fsl}/imx-pcm-fiq.c (100%)
 rename sound/soc/{imx => fsl}/imx-pcm.c (100%)
 rename sound/soc/{imx => fsl}/imx-pcm.h (100%)
 rename sound/soc/{imx => fsl}/imx-ssi.c (99%)
 rename sound/soc/{imx => fsl}/imx-ssi.h (100%)
 rename sound/soc/{imx => fsl}/mx27vis-aic32x4.c (100%)
 rename sound/soc/{imx => fsl}/phycore-ac97.c (100%)
 rename sound/soc/{imx => fsl}/wm1133-ev1.c (100%)
 delete mode 100644 sound/soc/imx/Kconfig
 delete mode 100644 sound/soc/imx/Makefile

diff --git a/sound/soc/Kconfig b/sound/soc/Kconfig
index 35e662d..2b95e6b 100644
--- a/sound/soc/Kconfig
+++ b/sound/soc/Kconfig
@@ -32,7 +32,6 @@ source "sound/soc/blackfin/Kconfig"
 source "sound/soc/davinci/Kconfig"
 source "sound/soc/ep93xx/Kconfig"
 source "sound/soc/fsl/Kconfig"
-source "sound/soc/imx/Kconfig"
 source "sound/soc/jz4740/Kconfig"
 source "sound/soc/nuc900/Kconfig"
 source "sound/soc/omap/Kconfig"
diff --git a/sound/soc/Makefile b/sound/soc/Makefile
index 9ea8ac8..d95a119 100644
--- a/sound/soc/Makefile
+++ b/sound/soc/Makefile
@@ -9,7 +9,6 @@ obj-$(CONFIG_SND_SOC)	+= blackfin/
 obj-$(CONFIG_SND_SOC)	+= davinci/
 obj-$(CONFIG_SND_SOC)	+= ep93xx/
 obj-$(CONFIG_SND_SOC)	+= fsl/
-obj-$(CONFIG_SND_SOC)   += imx/
 obj-$(CONFIG_SND_SOC)	+= jz4740/
 obj-$(CONFIG_SND_SOC)	+= mid-x86/
 obj-$(CONFIG_SND_SOC)	+= mxs/
diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index ca693b2..a62dc28 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -1,3 +1,15 @@
+config SND_SOC_FSL_SSI
+	tristate
+
+menuconfig SND_POWERPC_SOC
+	tristate "SoC Audio for Freescale PowerPC CPUs"
+	depends on FSL_SOC
+	help
+	  Say Y or M if you want to add support for codecs attached to
+	  the PowerPC CPUs.
+
+if SND_POWERPC_SOC
+
 config SND_MPC52xx_DMA
 	tristate
 
@@ -68,3 +80,75 @@ config SND_MPC52xx_SOC_EFIKA
 	help
 	  Say Y if you want to add support for sound on the Efika.
 
+endif # SND_POWERPC_SOC
+
+menuconfig SND_IMX_SOC
+	tristate "SoC Audio for Freescale i.MX CPUs"
+	depends on ARCH_MXC
+	help
+	  Say Y or M if you want to add support for codecs attached to
+	  the i.MX CPUs.
+
+if SND_IMX_SOC
+
+config SND_SOC_IMX_SSI
+	tristate
+
+config SND_SOC_IMX_PCM
+	tristate
+
+config SND_MXC_SOC_FIQ
+	tristate
+	select FIQ
+	select SND_SOC_IMX_PCM
+
+config SND_MXC_SOC_MX2
+	tristate
+	select SND_SOC_IMX_PCM
+
+config SND_MXC_SOC_WM1133_EV1
+	tristate "Audio on the the i.MX31ADS with WM1133-EV1 fitted"
+	depends on MACH_MX31ADS_WM1133_EV1 && EXPERIMENTAL
+	select SND_SOC_WM8350
+	select SND_MXC_SOC_FIQ
+	select SND_SOC_IMX_SSI
+	help
+	  Enable support for audio on the i.MX31ADS with the WM1133-EV1
+	  PMIC board with WM8835x fitted.
+
+config SND_SOC_MX27VIS_AIC32X4
+	tristate "SoC audio support for Visstrim M10 boards"
+	depends on MACH_IMX27_VISSTRIM_M10 && I2C
+	select SND_SOC_TLV320AIC32X4
+	select SND_MXC_SOC_MX2
+	select SND_SOC_IMX_SSI
+	help
+	  Say Y if you want to add support for SoC audio on Visstrim SM10
+	  board with TLV320AIC32X4 codec.
+
+config SND_SOC_PHYCORE_AC97
+	tristate "SoC Audio support for Phytec phyCORE (and phyCARD) boards"
+	depends on MACH_PCM043 || MACH_PCA100
+	select SND_SOC_AC97_BUS
+	select SND_SOC_WM9712
+	select SND_MXC_SOC_FIQ
+	select SND_SOC_IMX_SSI
+	help
+	  Say Y if you want to add support for SoC audio on Phytec phyCORE
+	  and phyCARD boards in AC97 mode
+
+config SND_SOC_EUKREA_TLV320
+	tristate "Eukrea TLV320"
+	depends on MACH_EUKREA_MBIMX27_BASEBOARD \
+		|| MACH_EUKREA_MBIMXSD25_BASEBOARD \
+		|| MACH_EUKREA_MBIMXSD35_BASEBOARD \
+		|| MACH_EUKREA_MBIMXSD51_BASEBOARD
+	depends on I2C
+	select SND_SOC_TLV320AIC23
+	select SND_MXC_SOC_FIQ
+	select SND_SOC_IMX_SSI
+	help
+	  Enable I2S based access to the TLV320AIC23B codec attached
+	  to the SSI interface
+
+endif # SND_IMX_SOC
diff --git a/sound/soc/fsl/Makefile b/sound/soc/fsl/Makefile
index 95d483f..65087b1 100644
--- a/sound/soc/fsl/Makefile
+++ b/sound/soc/fsl/Makefile
@@ -21,3 +21,22 @@ obj-$(CONFIG_SND_SOC_MPC5200_AC97) += mpc5200_psc_ac97.o
 obj-$(CONFIG_SND_MPC52xx_SOC_PCM030) += pcm030-audio-fabric.o
 obj-$(CONFIG_SND_MPC52xx_SOC_EFIKA) += efika-audio-fabric.o
 
+# i.MX Platform Support
+snd-soc-imx-ssi-objs := imx-ssi.o
+obj-$(CONFIG_SND_SOC_IMX_SSI) += snd-soc-imx-ssi.o
+
+obj-$(CONFIG_SND_SOC_IMX_PCM) += snd-soc-imx-pcm.o
+snd-soc-imx-pcm-y := imx-pcm.o
+snd-soc-imx-pcm-$(CONFIG_SND_MXC_SOC_FIQ) += imx-pcm-fiq.o
+snd-soc-imx-pcm-$(CONFIG_SND_MXC_SOC_MX2) += imx-pcm-dma-mx2.o
+
+# i.MX Machine Support
+snd-soc-eukrea-tlv320-objs := eukrea-tlv320.o
+snd-soc-phycore-ac97-objs := phycore-ac97.o
+snd-soc-mx27vis-aic32x4-objs := mx27vis-aic32x4.o
+snd-soc-wm1133-ev1-objs := wm1133-ev1.o
+
+obj-$(CONFIG_SND_SOC_EUKREA_TLV320) += snd-soc-eukrea-tlv320.o
+obj-$(CONFIG_SND_SOC_PHYCORE_AC97) += snd-soc-phycore-ac97.o
+obj-$(CONFIG_SND_SOC_MX27VIS_AIC32X4) += snd-soc-mx27vis-aic32x4.o
+obj-$(CONFIG_SND_MXC_SOC_WM1133_EV1) += snd-soc-wm1133-ev1.o
diff --git a/sound/soc/imx/eukrea-tlv320.c b/sound/soc/fsl/eukrea-tlv320.c
similarity index 99%
rename from sound/soc/imx/eukrea-tlv320.c
rename to sound/soc/fsl/eukrea-tlv320.c
index 1c1fdd1..c33a303 100644
--- a/sound/soc/imx/eukrea-tlv320.c
+++ b/sound/soc/fsl/eukrea-tlv320.c
@@ -7,7 +7,7 @@
  * which is Copyright 2009 Simtec Electronics
  * and on sound/soc/imx/phycore-ac97.c which is
  * Copyright 2009 Sascha Hauer, Pengutronix <s.hauer@pengutronix.de>
- * 
+ *
  *  This program is free software; you can redistribute  it and/or modify it
  *  under  the terms of  the GNU General  Public License as published by the
  *  Free Software Foundation;  either version 2 of the  License, or (at your
diff --git a/sound/soc/imx/imx-pcm-dma-mx2.c b/sound/soc/fsl/imx-pcm-dma-mx2.c
similarity index 100%
rename from sound/soc/imx/imx-pcm-dma-mx2.c
rename to sound/soc/fsl/imx-pcm-dma-mx2.c
diff --git a/sound/soc/imx/imx-pcm-fiq.c b/sound/soc/fsl/imx-pcm-fiq.c
similarity index 100%
rename from sound/soc/imx/imx-pcm-fiq.c
rename to sound/soc/fsl/imx-pcm-fiq.c
diff --git a/sound/soc/imx/imx-pcm.c b/sound/soc/fsl/imx-pcm.c
similarity index 100%
rename from sound/soc/imx/imx-pcm.c
rename to sound/soc/fsl/imx-pcm.c
diff --git a/sound/soc/imx/imx-pcm.h b/sound/soc/fsl/imx-pcm.h
similarity index 100%
rename from sound/soc/imx/imx-pcm.h
rename to sound/soc/fsl/imx-pcm.h
diff --git a/sound/soc/imx/imx-ssi.c b/sound/soc/fsl/imx-ssi.c
similarity index 99%
rename from sound/soc/imx/imx-ssi.c
rename to sound/soc/fsl/imx-ssi.c
index 9203cdd..3e0dac5a 100644
--- a/sound/soc/imx/imx-ssi.c
+++ b/sound/soc/fsl/imx-ssi.c
@@ -28,7 +28,7 @@
  * value. When we read the same register two times (and the register still
  * contains the same value) these status bits are not set. We work
  * around this by not polling these bits but only wait a fixed delay.
- * 
+ *
  */
 
 #include <linux/clk.h>
diff --git a/sound/soc/imx/imx-ssi.h b/sound/soc/fsl/imx-ssi.h
similarity index 100%
rename from sound/soc/imx/imx-ssi.h
rename to sound/soc/fsl/imx-ssi.h
diff --git a/sound/soc/imx/mx27vis-aic32x4.c b/sound/soc/fsl/mx27vis-aic32x4.c
similarity index 100%
rename from sound/soc/imx/mx27vis-aic32x4.c
rename to sound/soc/fsl/mx27vis-aic32x4.c
diff --git a/sound/soc/imx/phycore-ac97.c b/sound/soc/fsl/phycore-ac97.c
similarity index 100%
rename from sound/soc/imx/phycore-ac97.c
rename to sound/soc/fsl/phycore-ac97.c
diff --git a/sound/soc/imx/wm1133-ev1.c b/sound/soc/fsl/wm1133-ev1.c
similarity index 100%
rename from sound/soc/imx/wm1133-ev1.c
rename to sound/soc/fsl/wm1133-ev1.c
diff --git a/sound/soc/imx/Kconfig b/sound/soc/imx/Kconfig
deleted file mode 100644
index b9de8a8..0000000
--- a/sound/soc/imx/Kconfig
+++ /dev/null
@@ -1,71 +0,0 @@
-menuconfig SND_IMX_SOC
-	tristate "SoC Audio for Freescale i.MX CPUs"
-	depends on ARCH_MXC
-	help
-	  Say Y or M if you want to add support for codecs attached to
-	  the i.MX SSI interface.
-
-
-if SND_IMX_SOC
-
-config SND_SOC_IMX_SSI
-	tristate
-
-config SND_SOC_IMX_PCM
-	tristate
-
-config SND_MXC_SOC_FIQ
-	tristate
-	select FIQ
-	select SND_SOC_IMX_PCM
-
-config SND_MXC_SOC_MX2
-	tristate
-	select SND_SOC_IMX_PCM
-
-config SND_MXC_SOC_WM1133_EV1
-	tristate "Audio on the the i.MX31ADS with WM1133-EV1 fitted"
-	depends on MACH_MX31ADS_WM1133_EV1 && EXPERIMENTAL
-	select SND_SOC_WM8350
-	select SND_MXC_SOC_FIQ
-	select SND_SOC_IMX_SSI
-	help
-	  Enable support for audio on the i.MX31ADS with the WM1133-EV1
-	  PMIC board with WM8835x fitted.
-
-config SND_SOC_MX27VIS_AIC32X4
-	tristate "SoC audio support for Visstrim M10 boards"
-	depends on MACH_IMX27_VISSTRIM_M10 && I2C
-	select SND_SOC_TLV320AIC32X4
-	select SND_MXC_SOC_MX2
-	select SND_SOC_IMX_SSI
-	help
-	  Say Y if you want to add support for SoC audio on Visstrim SM10
-	  board with TLV320AIC32X4 codec.
-
-config SND_SOC_PHYCORE_AC97
-	tristate "SoC Audio support for Phytec phyCORE (and phyCARD) boards"
-	depends on MACH_PCM043 || MACH_PCA100
-	select SND_SOC_AC97_BUS
-	select SND_SOC_WM9712
-	select SND_MXC_SOC_FIQ
-	select SND_SOC_IMX_SSI
-	help
-	  Say Y if you want to add support for SoC audio on Phytec phyCORE
-	  and phyCARD boards in AC97 mode
-
-config SND_SOC_EUKREA_TLV320
-	tristate "Eukrea TLV320"
-	depends on MACH_EUKREA_MBIMX27_BASEBOARD \
-		|| MACH_EUKREA_MBIMXSD25_BASEBOARD \
-		|| MACH_EUKREA_MBIMXSD35_BASEBOARD \
-		|| MACH_EUKREA_MBIMXSD51_BASEBOARD
-	depends on I2C
-	select SND_SOC_TLV320AIC23
-	select SND_MXC_SOC_FIQ
-	select SND_SOC_IMX_SSI
-	help
-	  Enable I2S based access to the TLV320AIC23B codec attached
-	  to the SSI interface
-
-endif	# SND_IMX_SOC
diff --git a/sound/soc/imx/Makefile b/sound/soc/imx/Makefile
deleted file mode 100644
index 981c9da..0000000
--- a/sound/soc/imx/Makefile
+++ /dev/null
@@ -1,19 +0,0 @@
-# i.MX Platform Support
-snd-soc-imx-ssi-objs := imx-ssi.o
-obj-$(CONFIG_SND_SOC_IMX_SSI) += snd-soc-imx-ssi.o
-
-obj-$(CONFIG_SND_SOC_IMX_PCM) += snd-soc-imx-pcm.o
-snd-soc-imx-pcm-y := imx-pcm.o
-snd-soc-imx-pcm-$(CONFIG_SND_MXC_SOC_FIQ) += imx-pcm-fiq.o
-snd-soc-imx-pcm-$(CONFIG_SND_MXC_SOC_MX2) += imx-pcm-dma-mx2.o
-
-# i.MX Machine Support
-snd-soc-eukrea-tlv320-objs := eukrea-tlv320.o
-snd-soc-phycore-ac97-objs := phycore-ac97.o
-snd-soc-mx27vis-aic32x4-objs := mx27vis-aic32x4.o
-snd-soc-wm1133-ev1-objs := wm1133-ev1.o
-
-obj-$(CONFIG_SND_SOC_EUKREA_TLV320) += snd-soc-eukrea-tlv320.o
-obj-$(CONFIG_SND_SOC_PHYCORE_AC97) += snd-soc-phycore-ac97.o
-obj-$(CONFIG_SND_SOC_MX27VIS_AIC32X4) += snd-soc-mx27vis-aic32x4.o
-obj-$(CONFIG_SND_MXC_SOC_WM1133_EV1) += snd-soc-wm1133-ev1.o
-- 
1.7.5.4
