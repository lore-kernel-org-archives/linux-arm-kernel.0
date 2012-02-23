From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 23 Feb 2012 22:48:36 +0800
Subject: [PATCH 1/4] ASoC: imx: add an explicit Kconfig option for imx-ssi
 driver
In-Reply-To: <1330008519-3584-1-git-send-email-shawn.guo@linaro.org>
References: <1329979644-31046-1-git-send-email-shawn.guo@linaro.org>
 <1330008519-3584-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1330008519-3584-2-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently ASoC:imx uses menuconfig option SND_IMX_SOC selects imx-ssi
driver, and it works because all the machine driver covered by the
menuconfig need to build imx-ssi driver in.  However, it will not work
any more if we have a imx based machine driver going into the menuconfig
while working with fsl_ssi driver (sound/soc/fsl/fsl_ssi.c) rather than
imx-ssi one.

The patch adds an explicit Kconfig option SND_SOC_IMX_SSI for imx-ssi
driver, so that it can be selected independently from the menuconfig
option SND_IMX_SOC.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 sound/soc/imx/Kconfig  |    7 +++++++
 sound/soc/imx/Makefile |    4 ++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/sound/soc/imx/Kconfig b/sound/soc/imx/Kconfig
index 863a6b4..b9de8a8 100644
--- a/sound/soc/imx/Kconfig
+++ b/sound/soc/imx/Kconfig
@@ -8,6 +8,9 @@ menuconfig SND_IMX_SOC
 
 if SND_IMX_SOC
 
+config SND_SOC_IMX_SSI
+	tristate
+
 config SND_SOC_IMX_PCM
 	tristate
 
@@ -25,6 +28,7 @@ config SND_MXC_SOC_WM1133_EV1
 	depends on MACH_MX31ADS_WM1133_EV1 && EXPERIMENTAL
 	select SND_SOC_WM8350
 	select SND_MXC_SOC_FIQ
+	select SND_SOC_IMX_SSI
 	help
 	  Enable support for audio on the i.MX31ADS with the WM1133-EV1
 	  PMIC board with WM8835x fitted.
@@ -34,6 +38,7 @@ config SND_SOC_MX27VIS_AIC32X4
 	depends on MACH_IMX27_VISSTRIM_M10 && I2C
 	select SND_SOC_TLV320AIC32X4
 	select SND_MXC_SOC_MX2
+	select SND_SOC_IMX_SSI
 	help
 	  Say Y if you want to add support for SoC audio on Visstrim SM10
 	  board with TLV320AIC32X4 codec.
@@ -44,6 +49,7 @@ config SND_SOC_PHYCORE_AC97
 	select SND_SOC_AC97_BUS
 	select SND_SOC_WM9712
 	select SND_MXC_SOC_FIQ
+	select SND_SOC_IMX_SSI
 	help
 	  Say Y if you want to add support for SoC audio on Phytec phyCORE
 	  and phyCARD boards in AC97 mode
@@ -57,6 +63,7 @@ config SND_SOC_EUKREA_TLV320
 	depends on I2C
 	select SND_SOC_TLV320AIC23
 	select SND_MXC_SOC_FIQ
+	select SND_SOC_IMX_SSI
 	help
 	  Enable I2S based access to the TLV320AIC23B codec attached
 	  to the SSI interface
diff --git a/sound/soc/imx/Makefile b/sound/soc/imx/Makefile
index 303bc05..981c9da 100644
--- a/sound/soc/imx/Makefile
+++ b/sound/soc/imx/Makefile
@@ -1,6 +1,6 @@
 # i.MX Platform Support
-snd-soc-imx-objs := imx-ssi.o
-obj-$(CONFIG_SND_IMX_SOC) += snd-soc-imx.o
+snd-soc-imx-ssi-objs := imx-ssi.o
+obj-$(CONFIG_SND_SOC_IMX_SSI) += snd-soc-imx-ssi.o
 
 obj-$(CONFIG_SND_SOC_IMX_PCM) += snd-soc-imx-pcm.o
 snd-soc-imx-pcm-y := imx-pcm.o
-- 
1.7.5.4
