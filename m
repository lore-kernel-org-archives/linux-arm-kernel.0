From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 23 Feb 2012 22:48:37 +0800
Subject: [PATCH 2/4] ASoC: fsl: separate SSI and DMA Kconfig options
In-Reply-To: <1330008519-3584-1-git-send-email-shawn.guo@linaro.org>
References: <1329979644-31046-1-git-send-email-shawn.guo@linaro.org>
 <1330008519-3584-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1330008519-3584-3-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The fsl_ssi driver will possibly be shared between Freescale PowerPC
and ARM/IMX families, so give it a separate Kconfig option.  Then
fsl_ssi driver can possibly be selected independently from selecting
PowerPC DMA based PCM driver.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 sound/soc/fsl/Kconfig  |   15 +++++++++------
 sound/soc/fsl/Makefile |    3 ++-
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index d754d34..ca693b2 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -1,10 +1,11 @@
 config SND_MPC52xx_DMA
 	tristate
 
-# ASoC platform support for the Freescale PowerPC SOCs that have an SSI and
-# an Elo DMA controller, such as the MPC8610 and P1022.  You will still need to
-# select a platform driver and a codec driver.
-config SND_SOC_POWERPC_SSI
+config SND_SOC_FSL_SSI
+	tristate
+	depends on FSL_SOC
+
+config SND_SOC_POWERPC_DMA
 	tristate
 	depends on FSL_SOC
 
@@ -12,7 +13,8 @@ config SND_SOC_MPC8610_HPCD
 	tristate "ALSA SoC support for the Freescale MPC8610 HPCD board"
 	# I2C is necessary for the CS4270 driver
 	depends on MPC8610_HPCD && I2C
-	select SND_SOC_POWERPC_SSI
+	select SND_SOC_FSL_SSI
+	select SND_SOC_POWERPC_DMA
 	select SND_SOC_CS4270
 	select SND_SOC_CS4270_VD33_ERRATA
 	default y if MPC8610_HPCD
@@ -23,7 +25,8 @@ config SND_SOC_P1022_DS
 	tristate "ALSA SoC support for the Freescale P1022 DS board"
 	# I2C is necessary for the WM8776 driver
 	depends on P1022_DS && I2C
-	select SND_SOC_POWERPC_SSI
+	select SND_SOC_FSL_SSI
+	select SND_SOC_POWERPC_DMA
 	select SND_SOC_WM8776
 	default y if P1022_DS
 	help
diff --git a/sound/soc/fsl/Makefile b/sound/soc/fsl/Makefile
index b4a38c0..95d483f 100644
--- a/sound/soc/fsl/Makefile
+++ b/sound/soc/fsl/Makefile
@@ -9,7 +9,8 @@ obj-$(CONFIG_SND_SOC_P1022_DS) += snd-soc-p1022-ds.o
 # Freescale PowerPC SSI/DMA Platform Support
 snd-soc-fsl-ssi-objs := fsl_ssi.o
 snd-soc-fsl-dma-objs := fsl_dma.o
-obj-$(CONFIG_SND_SOC_POWERPC_SSI) += snd-soc-fsl-ssi.o snd-soc-fsl-dma.o
+obj-$(CONFIG_SND_SOC_FSL_SSI) += snd-soc-fsl-ssi.o
+obj-$(CONFIG_SND_SOC_POWERPC_DMA) += snd-soc-fsl-dma.o
 
 # MPC5200 Platform Support
 obj-$(CONFIG_SND_MPC52xx_DMA) += mpc5200_dma.o
-- 
1.7.5.4
