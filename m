From: shawn.guo@linaro.org (Shawn Guo)
Date: Sat,  3 Mar 2012 23:19:46 +0800
Subject: [PATCH 05/20] ASoC: imx: move audmux driver into sound/soc/imx
In-Reply-To: <1330788001-10158-1-git-send-email-shawn.guo@linaro.org>
References: <1330788001-10158-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1330788001-10158-6-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As audmux becomes a platform driver and its callers are all ASoC
machine drivers, there is no reason to keep it in arch folder, so
move it to sound/soc/imx.

One bonus point would be those ASoC machine drivers stop including
mach/audmux.h, since it's been moved to sound/soc/imx/imx-audmux.h.
This should be a move to the right direction in terms of single kernel
image goal.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/Kconfig                          |    6 ------
 arch/arm/mach-imx/eukrea_mbimxsd-baseboard.c       |    1 -
 arch/arm/plat-mxc/Kconfig                          |    3 ---
 arch/arm/plat-mxc/Makefile                         |    1 -
 sound/soc/imx/Kconfig                              |    7 +++++++
 sound/soc/imx/Makefile                             |    2 ++
 sound/soc/imx/eukrea-tlv320.c                      |    2 +-
 .../audmux.c => sound/soc/imx/imx-audmux.c         |    3 ++-
 .../mach/audmux.h => sound/soc/imx/imx-audmux.h    |    6 +++---
 sound/soc/imx/mx27vis-aic32x4.c                    |    2 +-
 sound/soc/imx/phycore-ac97.c                       |    3 ++-
 sound/soc/imx/wm1133-ev1.c                         |    3 +--
 12 files changed, 19 insertions(+), 20 deletions(-)
 rename arch/arm/plat-mxc/audmux.c => sound/soc/imx/imx-audmux.c (99%)
 rename arch/arm/plat-mxc/include/mach/audmux.h => sound/soc/imx/imx-audmux.h (96%)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 495a854..3919fba 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -46,7 +46,6 @@ config SOC_IMX21
 	bool
 	select MACH_MX21
 	select CPU_ARM926T
-	select ARCH_MXC_AUDMUX
 	select IMX_HAVE_DMA_V1
 	select IMX_HAVE_IOMUX_V1
 	select MXC_AVIC
@@ -55,7 +54,6 @@ config SOC_IMX25
 	bool
 	select ARCH_MX25
 	select CPU_ARM926T
-	select ARCH_MXC_AUDMUX
 	select ARCH_MXC_IOMUX_V3
 	select MXC_AVIC
 
@@ -63,7 +61,6 @@ config SOC_IMX27
 	bool
 	select MACH_MX27
 	select CPU_ARM926T
-	select ARCH_MXC_AUDMUX
 	select IMX_HAVE_DMA_V1
 	select IMX_HAVE_IOMUX_V1
 	select MXC_AVIC
@@ -72,7 +69,6 @@ config SOC_IMX31
 	bool
 	select CPU_V6
 	select IMX_HAVE_PLATFORM_MXC_RNGA
-	select ARCH_MXC_AUDMUX
 	select MXC_AVIC
 	select SMP_ON_UP if SMP
 
@@ -80,7 +76,6 @@ config SOC_IMX35
 	bool
 	select CPU_V6
 	select ARCH_MXC_IOMUX_V3
-	select ARCH_MXC_AUDMUX
 	select HAVE_EPIT
 	select MXC_AVIC
 	select SMP_ON_UP if SMP
@@ -89,7 +84,6 @@ config SOC_IMX5
 	select CPU_V7
 	select MXC_TZIC
 	select ARCH_MXC_IOMUX_V3
-	select ARCH_MXC_AUDMUX
 	select ARCH_HAS_CPUFREQ
 	select ARCH_MX5
 	bool
diff --git a/arch/arm/mach-imx/eukrea_mbimxsd-baseboard.c b/arch/arm/mach-imx/eukrea_mbimxsd-baseboard.c
index d817fc8..aaa592f 100644
--- a/arch/arm/mach-imx/eukrea_mbimxsd-baseboard.c
+++ b/arch/arm/mach-imx/eukrea_mbimxsd-baseboard.c
@@ -37,7 +37,6 @@
 #include <mach/hardware.h>
 #include <mach/common.h>
 #include <mach/iomux-mx51.h>
-#include <mach/audmux.h>
 
 #include "devices-imx51.h"
 
diff --git a/arch/arm/plat-mxc/Kconfig b/arch/arm/plat-mxc/Kconfig
index 0461d16..c722f9c 100644
--- a/arch/arm/plat-mxc/Kconfig
+++ b/arch/arm/plat-mxc/Kconfig
@@ -88,9 +88,6 @@ config IMX_HAVE_IOMUX_V1
 config ARCH_MXC_IOMUX_V3
 	bool
 
-config ARCH_MXC_AUDMUX
-	bool
-
 config IRAM_ALLOC
 	bool
 	select GENERIC_ALLOCATOR
diff --git a/arch/arm/plat-mxc/Makefile b/arch/arm/plat-mxc/Makefile
index 530c81d..e81290c 100644
--- a/arch/arm/plat-mxc/Makefile
+++ b/arch/arm/plat-mxc/Makefile
@@ -14,7 +14,6 @@ obj-$(CONFIG_IRAM_ALLOC) += iram_alloc.o
 obj-$(CONFIG_MXC_PWM)  += pwm.o
 obj-$(CONFIG_MXC_ULPI) += ulpi.o
 obj-$(CONFIG_MXC_USE_EPIT) += epit.o
-obj-$(CONFIG_ARCH_MXC_AUDMUX) += audmux.o
 obj-$(CONFIG_MXC_DEBUG_BOARD) += 3ds_debugboard.o
 obj-$(CONFIG_CPU_FREQ_IMX)    += cpufreq.o
 ifdef CONFIG_SND_IMX_SOC
diff --git a/sound/soc/imx/Kconfig b/sound/soc/imx/Kconfig
index 192861c..4025eee 100644
--- a/sound/soc/imx/Kconfig
+++ b/sound/soc/imx/Kconfig
@@ -17,11 +17,15 @@ config SND_MXC_SOC_MX2
 	select SND_SOC_DMAENGINE_PCM
 	tristate
 
+config SND_SOC_IMX_AUDMUX
+	tristate
+
 config SND_MXC_SOC_WM1133_EV1
 	tristate "Audio on the the i.MX31ADS with WM1133-EV1 fitted"
 	depends on MACH_MX31ADS_WM1133_EV1 && EXPERIMENTAL
 	select SND_SOC_WM8350
 	select SND_MXC_SOC_FIQ
+	select SND_SOC_IMX_AUDMUX
 	help
 	  Enable support for audio on the i.MX31ADS with the WM1133-EV1
 	  PMIC board with WM8835x fitted.
@@ -31,6 +35,7 @@ config SND_SOC_MX27VIS_AIC32X4
 	depends on MACH_IMX27_VISSTRIM_M10 && I2C
 	select SND_SOC_TLV320AIC32X4
 	select SND_MXC_SOC_MX2
+	select SND_SOC_IMX_AUDMUX
 	help
 	  Say Y if you want to add support for SoC audio on Visstrim SM10
 	  board with TLV320AIC32X4 codec.
@@ -40,6 +45,7 @@ config SND_SOC_PHYCORE_AC97
 	depends on MACH_PCM043 || MACH_PCA100
 	select SND_SOC_WM9712
 	select SND_MXC_SOC_FIQ
+	select SND_SOC_IMX_AUDMUX
 	help
 	  Say Y if you want to add support for SoC audio on Phytec phyCORE
 	  and phyCARD boards in AC97 mode
@@ -53,6 +59,7 @@ config SND_SOC_EUKREA_TLV320
 	depends on I2C
 	select SND_SOC_TLV320AIC23
 	select SND_MXC_SOC_FIQ
+	select SND_SOC_IMX_AUDMUX
 	help
 	  Enable I2S based access to the TLV320AIC23B codec attached
 	  to the SSI interface
diff --git a/sound/soc/imx/Makefile b/sound/soc/imx/Makefile
index d6d609b..5c40541 100644
--- a/sound/soc/imx/Makefile
+++ b/sound/soc/imx/Makefile
@@ -2,10 +2,12 @@
 snd-soc-imx-objs := imx-ssi.o
 snd-soc-imx-fiq-objs := imx-pcm-fiq.o
 snd-soc-imx-mx2-objs := imx-pcm-dma-mx2.o
+snd-soc-imx-audmux-objs := imx-audmux.o
 
 obj-$(CONFIG_SND_IMX_SOC) += snd-soc-imx.o
 obj-$(CONFIG_SND_MXC_SOC_FIQ) += snd-soc-imx-fiq.o
 obj-$(CONFIG_SND_MXC_SOC_MX2) += snd-soc-imx-mx2.o
+obj-$(CONFIG_SND_SOC_IMX_AUDMUX) += snd-soc-imx-audmux.o
 
 # i.MX Machine Support
 snd-soc-eukrea-tlv320-objs := eukrea-tlv320.o
diff --git a/sound/soc/imx/eukrea-tlv320.c b/sound/soc/imx/eukrea-tlv320.c
index bfcb6d9..b375ed4 100644
--- a/sound/soc/imx/eukrea-tlv320.c
+++ b/sound/soc/imx/eukrea-tlv320.c
@@ -23,10 +23,10 @@
 #include <sound/pcm.h>
 #include <sound/soc.h>
 #include <asm/mach-types.h>
-#include <mach/audmux.h>
 
 #include "../codecs/tlv320aic23.h"
 #include "imx-ssi.h"
+#include "imx-audmux.h"
 
 #define CODEC_CLOCK 12000000
 
diff --git a/arch/arm/plat-mxc/audmux.c b/sound/soc/imx/imx-audmux.c
similarity index 99%
rename from arch/arm/plat-mxc/audmux.c
rename to sound/soc/imx/imx-audmux.c
index 98f5656..e0d8c4b 100644
--- a/arch/arm/plat-mxc/audmux.c
+++ b/sound/soc/imx/imx-audmux.c
@@ -24,7 +24,8 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
-#include <mach/audmux.h>
+
+#include "imx-audmux.h"
 
 #define DRIVER_NAME "imx-audmux"
 
diff --git a/arch/arm/plat-mxc/include/mach/audmux.h b/sound/soc/imx/imx-audmux.h
similarity index 96%
rename from arch/arm/plat-mxc/include/mach/audmux.h
rename to sound/soc/imx/imx-audmux.h
index 6fda788..5136d948 100644
--- a/arch/arm/plat-mxc/include/mach/audmux.h
+++ b/sound/soc/imx/imx-audmux.h
@@ -1,5 +1,5 @@
-#ifndef __MACH_AUDMUX_H
-#define __MACH_AUDMUX_H
+#ifndef __IMX_AUDMUX_H
+#define __IMX_AUDMUX_H
 
 #define MX27_AUDMUX_HPCR1_SSI0		0
 #define MX27_AUDMUX_HPCR2_SSI1		1
@@ -57,4 +57,4 @@ int mxc_audmux_v1_configure_port(unsigned int port, unsigned int pcr);
 int mxc_audmux_v2_configure_port(unsigned int port, unsigned int ptcr,
 		unsigned int pdcr);
 
-#endif /* __MACH_AUDMUX_H */
+#endif /* __IMX_AUDMUX_H */
diff --git a/sound/soc/imx/mx27vis-aic32x4.c b/sound/soc/imx/mx27vis-aic32x4.c
index 155899c..dbfad0f 100644
--- a/sound/soc/imx/mx27vis-aic32x4.c
+++ b/sound/soc/imx/mx27vis-aic32x4.c
@@ -32,11 +32,11 @@
 #include <sound/soc-dapm.h>
 #include <sound/tlv.h>
 #include <asm/mach-types.h>
-#include <mach/audmux.h>
 #include <mach/iomux-mx27.h>
 
 #include "../codecs/tlv320aic32x4.h"
 #include "imx-ssi.h"
+#include "imx-audmux.h"
 
 #define MX27VIS_AMP_GAIN	0
 #define MX27VIS_AMP_MUTE	1
diff --git a/sound/soc/imx/phycore-ac97.c b/sound/soc/imx/phycore-ac97.c
index a59692e..7dab077 100644
--- a/sound/soc/imx/phycore-ac97.c
+++ b/sound/soc/imx/phycore-ac97.c
@@ -18,7 +18,8 @@
 #include <sound/pcm.h>
 #include <sound/soc.h>
 #include <asm/mach-types.h>
-#include <mach/audmux.h>
+
+#include "imx-audmux.h"
 
 static struct snd_soc_card imx_phycore;
 
diff --git a/sound/soc/imx/wm1133-ev1.c b/sound/soc/imx/wm1133-ev1.c
index 37480c9..15056d6 100644
--- a/sound/soc/imx/wm1133-ev1.c
+++ b/sound/soc/imx/wm1133-ev1.c
@@ -21,10 +21,9 @@
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
 
-#include <mach/audmux.h>
-
 #include "imx-ssi.h"
 #include "../codecs/wm8350.h"
+#include "imx-audmux.h"
 
 /* There is a silicon mic on the board optionally connected via a solder pad
  * SP1.  Define this to enable it.
-- 
1.7.5.4
