From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon,  5 Mar 2012 22:30:49 +0800
Subject: [PATCH v2 01/17] ASoC: imx: move eukrea audmux call into ASoC machine
 driver
In-Reply-To: <1330957865-19085-1-git-send-email-shawn.guo@linaro.org>
References: <1330957865-19085-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1330957865-19085-2-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It moves eukrea audmux configuration call from board file into ASoC
machine driver eukrea-tlv320, so that it gets aligned wm1133-ev1 and
mx27vis-aic32x4, and more importantly it will ease the moving of audmux
into sound/soc/imx as a platform driver later.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/eukrea_mbimx27-baseboard.c   |   20 ------------
 arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c |   17 ----------
 arch/arm/mach-imx/eukrea_mbimxsd35-baseboard.c |   17 ----------
 sound/soc/imx/eukrea-tlv320.c                  |   40 +++++++++++++++++++++--
 4 files changed, 36 insertions(+), 58 deletions(-)

diff --git a/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c b/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c
index 5db3e14..5f2f91d 100644
--- a/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c
+++ b/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c
@@ -32,7 +32,6 @@
 #include <mach/common.h>
 #include <mach/iomux-mx27.h>
 #include <mach/hardware.h>
-#include <mach/audmux.h>
 
 #include "devices-imx27.h"
 
@@ -306,25 +305,6 @@ void __init eukrea_mbimx27_baseboard_init(void)
 	mxc_gpio_setup_multiple_pins(eukrea_mbimx27_pins,
 		ARRAY_SIZE(eukrea_mbimx27_pins), "MBIMX27");
 
-#if defined(CONFIG_SND_SOC_EUKREA_TLV320) \
-	|| defined(CONFIG_SND_SOC_EUKREA_TLV320_MODULE)
-	/* SSI unit master I2S codec connected to SSI_PINS_4*/
-	mxc_audmux_v1_configure_port(MX27_AUDMUX_HPCR1_SSI0,
-			MXC_AUDMUX_V1_PCR_SYN |
-			MXC_AUDMUX_V1_PCR_TFSDIR |
-			MXC_AUDMUX_V1_PCR_TCLKDIR |
-			MXC_AUDMUX_V1_PCR_RFSDIR |
-			MXC_AUDMUX_V1_PCR_RCLKDIR |
-			MXC_AUDMUX_V1_PCR_TFCSEL(MX27_AUDMUX_HPCR3_SSI_PINS_4) |
-			MXC_AUDMUX_V1_PCR_RFCSEL(MX27_AUDMUX_HPCR3_SSI_PINS_4) |
-			MXC_AUDMUX_V1_PCR_RXDSEL(MX27_AUDMUX_HPCR3_SSI_PINS_4)
-	);
-	mxc_audmux_v1_configure_port(MX27_AUDMUX_HPCR3_SSI_PINS_4,
-			MXC_AUDMUX_V1_PCR_SYN |
-			MXC_AUDMUX_V1_PCR_RXDSEL(MX27_AUDMUX_HPCR1_SSI0)
-	);
-#endif
-
 	imx27_add_imx_uart1(&uart_pdata);
 	imx27_add_imx_uart2(&uart_pdata);
 #if !defined(MACH_EUKREA_CPUIMX27_USEUART4)
diff --git a/arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c b/arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c
index 66e8726..2cf603e 100644
--- a/arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c
+++ b/arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c
@@ -31,7 +31,6 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <mach/mx25.h>
-#include <mach/audmux.h>
 
 #include "devices-imx25.h"
 
@@ -241,22 +240,6 @@ void __init eukrea_mbimxsd25_baseboard_init(void)
 			ARRAY_SIZE(eukrea_mbimxsd_pads)))
 		printk(KERN_ERR "error setting mbimxsd pads !\n");
 
-#if defined(CONFIG_SND_SOC_EUKREA_TLV320)
-	/* SSI unit master I2S codec connected to SSI_AUD5*/
-	mxc_audmux_v2_configure_port(0,
-			MXC_AUDMUX_V2_PTCR_SYN |
-			MXC_AUDMUX_V2_PTCR_TFSDIR |
-			MXC_AUDMUX_V2_PTCR_TFSEL(4) |
-			MXC_AUDMUX_V2_PTCR_TCLKDIR |
-			MXC_AUDMUX_V2_PTCR_TCSEL(4),
-			MXC_AUDMUX_V2_PDCR_RXDSEL(4)
-	);
-	mxc_audmux_v2_configure_port(4,
-			MXC_AUDMUX_V2_PTCR_SYN,
-			MXC_AUDMUX_V2_PDCR_RXDSEL(0)
-	);
-#endif
-
 	imx25_add_imx_uart1(&uart_pdata);
 	imx25_add_imx_fb(&eukrea_mximxsd_fb_pdata);
 	imx25_add_imx_ssi(0, &eukrea_mbimxsd_ssi_pdata);
diff --git a/arch/arm/mach-imx/eukrea_mbimxsd35-baseboard.c b/arch/arm/mach-imx/eukrea_mbimxsd35-baseboard.c
index 0f0af02..fd8bf8a 100644
--- a/arch/arm/mach-imx/eukrea_mbimxsd35-baseboard.c
+++ b/arch/arm/mach-imx/eukrea_mbimxsd35-baseboard.c
@@ -38,7 +38,6 @@
 #include <mach/hardware.h>
 #include <mach/common.h>
 #include <mach/iomux-mx35.h>
-#include <mach/audmux.h>
 
 #include "devices-imx35.h"
 
@@ -252,22 +251,6 @@ void __init eukrea_mbimxsd35_baseboard_init(void)
 			ARRAY_SIZE(eukrea_mbimxsd_pads)))
 		printk(KERN_ERR "error setting mbimxsd pads !\n");
 
-#if defined(CONFIG_SND_SOC_EUKREA_TLV320)
-	/* SSI unit master I2S codec connected to SSI_AUD4 */
-	mxc_audmux_v2_configure_port(0,
-			MXC_AUDMUX_V2_PTCR_SYN |
-			MXC_AUDMUX_V2_PTCR_TFSDIR |
-			MXC_AUDMUX_V2_PTCR_TFSEL(3) |
-			MXC_AUDMUX_V2_PTCR_TCLKDIR |
-			MXC_AUDMUX_V2_PTCR_TCSEL(3),
-			MXC_AUDMUX_V2_PDCR_RXDSEL(3)
-	);
-	mxc_audmux_v2_configure_port(3,
-			MXC_AUDMUX_V2_PTCR_SYN,
-			MXC_AUDMUX_V2_PDCR_RXDSEL(0)
-	);
-#endif
-
 	imx35_add_imx_uart1(&uart_pdata);
 	imx35_add_ipu_core(&mx3_ipu_data);
 	imx35_add_mx3_sdc_fb(&mx3fb_pdata);
diff --git a/sound/soc/imx/eukrea-tlv320.c b/sound/soc/imx/eukrea-tlv320.c
index 1c1fdd1..bfcb6d9 100644
--- a/sound/soc/imx/eukrea-tlv320.c
+++ b/sound/soc/imx/eukrea-tlv320.c
@@ -23,6 +23,7 @@
 #include <sound/pcm.h>
 #include <sound/soc.h>
 #include <asm/mach-types.h>
+#include <mach/audmux.h>
 
 #include "../codecs/tlv320aic23.h"
 #include "imx-ssi.h"
@@ -97,12 +98,43 @@ static struct platform_device *eukrea_tlv320_snd_device;
 static int __init eukrea_tlv320_init(void)
 {
 	int ret;
-
-	if (!machine_is_eukrea_cpuimx27() && !machine_is_eukrea_cpuimx25sd()
-		&& !machine_is_eukrea_cpuimx35sd()
-		&& !machine_is_eukrea_cpuimx51sd())
+	int int_port = 0, ext_port;
+
+	if (machine_is_eukrea_cpuimx27()) {
+		mxc_audmux_v1_configure_port(MX27_AUDMUX_HPCR1_SSI0,
+			MXC_AUDMUX_V1_PCR_SYN |
+			MXC_AUDMUX_V1_PCR_TFSDIR |
+			MXC_AUDMUX_V1_PCR_TCLKDIR |
+			MXC_AUDMUX_V1_PCR_RFSDIR |
+			MXC_AUDMUX_V1_PCR_RCLKDIR |
+			MXC_AUDMUX_V1_PCR_TFCSEL(MX27_AUDMUX_HPCR3_SSI_PINS_4) |
+			MXC_AUDMUX_V1_PCR_RFCSEL(MX27_AUDMUX_HPCR3_SSI_PINS_4) |
+			MXC_AUDMUX_V1_PCR_RXDSEL(MX27_AUDMUX_HPCR3_SSI_PINS_4)
+		);
+		mxc_audmux_v1_configure_port(MX27_AUDMUX_HPCR3_SSI_PINS_4,
+			MXC_AUDMUX_V1_PCR_SYN |
+			MXC_AUDMUX_V1_PCR_RXDSEL(MX27_AUDMUX_HPCR1_SSI0)
+		);
+	} else if (machine_is_eukrea_cpuimx25sd() ||
+		   machine_is_eukrea_cpuimx35sd() ||
+		   machine_is_eukrea_cpuimx51sd()) {
+		ext_port = machine_is_eukrea_cpuimx25sd() ? 4 : 3;
+		mxc_audmux_v2_configure_port(int_port,
+			MXC_AUDMUX_V2_PTCR_SYN |
+			MXC_AUDMUX_V2_PTCR_TFSDIR |
+			MXC_AUDMUX_V2_PTCR_TFSEL(ext_port) |
+			MXC_AUDMUX_V2_PTCR_TCLKDIR |
+			MXC_AUDMUX_V2_PTCR_TCSEL(ext_port),
+			MXC_AUDMUX_V2_PDCR_RXDSEL(ext_port)
+		);
+		mxc_audmux_v2_configure_port(ext_port,
+			MXC_AUDMUX_V2_PTCR_SYN,
+			MXC_AUDMUX_V2_PDCR_RXDSEL(int_port)
+		);
+	} else {
 		/* return happy. We might run on a totally different machine */
 		return 0;
+	}
 
 	eukrea_tlv320_snd_device = platform_device_alloc("soc-audio", -1);
 	if (!eukrea_tlv320_snd_device)
-- 
1.7.5.4
