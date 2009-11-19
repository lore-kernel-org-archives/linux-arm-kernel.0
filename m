From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 19 Nov 2009 16:48:22 +0100
Subject: [PATCH 08/12] sound/soc/imx: Makefile/Kconfig changes for new driver
In-Reply-To: <1258645706-9071-8-git-send-email-s.hauer@pengutronix.de>
References: <1258645706-9071-1-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-2-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-3-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-4-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-5-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-6-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-7-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-8-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1258645706-9071-9-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 sound/soc/imx/Kconfig  |   15 +++++++++++++--
 sound/soc/imx/Makefile |    9 +++++----
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/sound/soc/imx/Kconfig b/sound/soc/imx/Kconfig
index a700562..83b6252 100644
--- a/sound/soc/imx/Kconfig
+++ b/sound/soc/imx/Kconfig
@@ -1,7 +1,9 @@
-config SND_MX1_MX2_SOC
+config SND_IMX_SOC
 	tristate "SoC Audio for Freecale i.MX1x i.MX2x CPUs"
-	depends on ARCH_MX2 || ARCH_MX1
+	depends on ARCH_MXC
 	select SND_PCM
+	select FIQ
+	select SND_SOC_AC97_BUS
 	help
 	  Say Y or M if you want to add support for codecs attached to
 	  the MX1 or MX2 SSI interface.
@@ -18,4 +20,13 @@ config SND_SOC_MX27VIS_WM8974
 	  Say Y if you want to add support for SoC audio on Visstrim SM10
 	  board with WM8974.
 
+config SND_SOC_PHYCORE
+	tristate "SoC Audio support for Phytec phyCORE (and phyCARD) boards"
+	depends on MACH_PCM038 || MACH_PCM043 || MACH_PCA100 || MACH_PCM037
+	select SND_MXC_SOC_SSI
+	select SND_SOC_MC13783 if MACH_PCM038 || MACH_PCM037
+	select SND_SOC_WM9712 if MACH_PCM043 || MACH_PCA100
+	help
+	  Say Y if you want to add support for SoC audio on Phytec phyCORE
+	  and phyCARD baords
 
diff --git a/sound/soc/imx/Makefile b/sound/soc/imx/Makefile
index c2ffd2c..f8c3be1 100644
--- a/sound/soc/imx/Makefile
+++ b/sound/soc/imx/Makefile
@@ -1,10 +1,11 @@
 # i.MX Platform Support
-snd-soc-mx1_mx2-objs := mx1_mx2-pcm.o
-snd-soc-mxc-ssi-objs := mxc-ssi.o
+snd-soc-imx-objs := imx-ssi.o devdma.o
 
-obj-$(CONFIG_SND_MX1_MX2_SOC) += snd-soc-mx1_mx2.o
-obj-$(CONFIG_SND_MXC_SOC_SSI) += snd-soc-mxc-ssi.o
+obj-$(CONFIG_SND_IMX_SOC) += snd-soc-imx.o
 
 # i.MX Machine Support
 snd-soc-mx27vis-wm8974-objs := mx27vis_wm8974.o
 obj-$(CONFIG_SND_SOC_MX27VIS_WM8974) += snd-soc-mx27vis-wm8974.o
+
+snd-soc-phycore-objs := phycore.o
+obj-$(CONFIG_SND_SOC_PHYCORE) += snd-soc-phycore.o
-- 
1.6.5.2
