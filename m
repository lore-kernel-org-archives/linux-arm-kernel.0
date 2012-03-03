From: shawn.guo@linaro.org (Shawn Guo)
Date: Sat,  3 Mar 2012 23:19:43 +0800
Subject: [PATCH 02/20] ASoC: imx: move phycore audmux call into ASoC machine
 driver
In-Reply-To: <1330788001-10158-1-git-send-email-shawn.guo@linaro.org>
References: <1330788001-10158-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1330788001-10158-3-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It moves phycore audmux configuration call from board file into ASoC
machine driver phycore-ac97 to ease converting audmux into a platform
driver later.
It moves phycore audmux configuration call from board file into ASoC
machine driver phycore-ac97, so that it gets aligned with wm1133-ev1
and mx27vis-aic32x4, and more importantly it will ease the moving of
audmux into sound/soc/imx as a platform driver later.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/mach-pca100.c |   13 -------------
 arch/arm/mach-imx/mach-pcm043.c |   13 -------------
 sound/soc/imx/phycore-ac97.c    |   26 +++++++++++++++++++++++++-
 3 files changed, 25 insertions(+), 27 deletions(-)

diff --git a/arch/arm/mach-imx/mach-pca100.c b/arch/arm/mach-imx/mach-pca100.c
index d3b9c6b..541152e 100644
--- a/arch/arm/mach-imx/mach-pca100.c
+++ b/arch/arm/mach-imx/mach-pca100.c
@@ -36,7 +36,6 @@
 #include <mach/hardware.h>
 #include <mach/iomux-mx27.h>
 #include <asm/mach/time.h>
-#include <mach/audmux.h>
 #include <mach/irqs.h>
 #include <mach/ulpi.h>
 
@@ -359,18 +358,6 @@ static void __init pca100_init(void)
 
 	imx27_soc_init();
 
-	/* SSI unit */
-	mxc_audmux_v1_configure_port(MX27_AUDMUX_HPCR1_SSI0,
-				  MXC_AUDMUX_V1_PCR_SYN | /* 4wire mode */
-				  MXC_AUDMUX_V1_PCR_TFCSEL(3) |
-				  MXC_AUDMUX_V1_PCR_TCLKDIR | /* clock is output */
-				  MXC_AUDMUX_V1_PCR_RXDSEL(3));
-	mxc_audmux_v1_configure_port(3,
-				  MXC_AUDMUX_V1_PCR_SYN | /* 4wire mode */
-				  MXC_AUDMUX_V1_PCR_TFCSEL(0) |
-				  MXC_AUDMUX_V1_PCR_TFSDIR |
-				  MXC_AUDMUX_V1_PCR_RXDSEL(0));
-
 	ret = mxc_gpio_setup_multiple_pins(pca100_pins,
 			ARRAY_SIZE(pca100_pins), "PCA100");
 	if (ret)
diff --git a/arch/arm/mach-imx/mach-pcm043.c b/arch/arm/mach-imx/mach-pcm043.c
index 06dc106..237474f 100644
--- a/arch/arm/mach-imx/mach-pcm043.c
+++ b/arch/arm/mach-imx/mach-pcm043.c
@@ -37,7 +37,6 @@
 #include <mach/common.h>
 #include <mach/iomux-mx35.h>
 #include <mach/ulpi.h>
-#include <mach/audmux.h>
 
 #include "devices-imx35.h"
 
@@ -362,18 +361,6 @@ static void __init pcm043_init(void)
 
 	mxc_iomux_v3_setup_multiple_pads(pcm043_pads, ARRAY_SIZE(pcm043_pads));
 
-	mxc_audmux_v2_configure_port(3,
-			MXC_AUDMUX_V2_PTCR_SYN | /* 4wire mode */
-			MXC_AUDMUX_V2_PTCR_TFSEL(0) |
-			MXC_AUDMUX_V2_PTCR_TFSDIR,
-			MXC_AUDMUX_V2_PDCR_RXDSEL(0));
-
-	mxc_audmux_v2_configure_port(0,
-			MXC_AUDMUX_V2_PTCR_SYN | /* 4wire mode */
-			MXC_AUDMUX_V2_PTCR_TCSEL(3) |
-			MXC_AUDMUX_V2_PTCR_TCLKDIR, /* clock is output */
-			MXC_AUDMUX_V2_PDCR_RXDSEL(3));
-
 	imx35_add_fec(NULL);
 	platform_add_devices(devices, ARRAY_SIZE(devices));
 	imx35_add_imx2_wdt(NULL);
diff --git a/sound/soc/imx/phycore-ac97.c b/sound/soc/imx/phycore-ac97.c
index 6ac1211..a59692e 100644
--- a/sound/soc/imx/phycore-ac97.c
+++ b/sound/soc/imx/phycore-ac97.c
@@ -18,6 +18,7 @@
 #include <sound/pcm.h>
 #include <sound/soc.h>
 #include <asm/mach-types.h>
+#include <mach/audmux.h>
 
 static struct snd_soc_card imx_phycore;
 
@@ -50,9 +51,32 @@ static int __init imx_phycore_init(void)
 {
 	int ret;
 
-	if (!machine_is_pcm043() && !machine_is_pca100())
+	if (machine_is_pca100()) {
+		mxc_audmux_v1_configure_port(MX27_AUDMUX_HPCR1_SSI0,
+			MXC_AUDMUX_V1_PCR_SYN | /* 4wire mode */
+			MXC_AUDMUX_V1_PCR_TFCSEL(3) |
+			MXC_AUDMUX_V1_PCR_TCLKDIR | /* clock is output */
+			MXC_AUDMUX_V1_PCR_RXDSEL(3));
+		mxc_audmux_v1_configure_port(3,
+			MXC_AUDMUX_V1_PCR_SYN | /* 4wire mode */
+			MXC_AUDMUX_V1_PCR_TFCSEL(0) |
+			MXC_AUDMUX_V1_PCR_TFSDIR |
+			MXC_AUDMUX_V1_PCR_RXDSEL(0));
+	} else if (machine_is_pcm043()) {
+		mxc_audmux_v2_configure_port(3,
+			MXC_AUDMUX_V2_PTCR_SYN | /* 4wire mode */
+			MXC_AUDMUX_V2_PTCR_TFSEL(0) |
+			MXC_AUDMUX_V2_PTCR_TFSDIR,
+			MXC_AUDMUX_V2_PDCR_RXDSEL(0));
+		mxc_audmux_v2_configure_port(0,
+			MXC_AUDMUX_V2_PTCR_SYN | /* 4wire mode */
+			MXC_AUDMUX_V2_PTCR_TCSEL(3) |
+			MXC_AUDMUX_V2_PTCR_TCLKDIR, /* clock is output */
+			MXC_AUDMUX_V2_PDCR_RXDSEL(3));
+	} else {
 		/* return happy. We might run on a totally different machine */
 		return 0;
+	}
 
 	imx_phycore_snd_ac97_device = platform_device_alloc("soc-audio", -1);
 	if (!imx_phycore_snd_ac97_device)
-- 
1.7.5.4
