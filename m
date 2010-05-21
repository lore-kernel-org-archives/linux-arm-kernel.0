From: marek.vasut@gmail.com (Marek Vasut)
Date: Sat, 22 May 2010 00:29:36 +0200
Subject: [PATCH 4/8] pxa/colibri270: Add UHC support
In-Reply-To: <1274480980-10109-1-git-send-email-marek.vasut@gmail.com>
References: <1274480980-10109-1-git-send-email-marek.vasut@gmail.com>
Message-ID: <1274480980-10109-5-git-send-email-marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
---
 arch/arm/mach-pxa/colibri-pxa270.c |   34 ++++++++++++++++++++++++++++++++++
 1 files changed, 34 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-pxa/colibri-pxa270.c b/arch/arm/mach-pxa/colibri-pxa270.c
index 18b208a..1cbeb61 100644
--- a/arch/arm/mach-pxa/colibri-pxa270.c
+++ b/arch/arm/mach-pxa/colibri-pxa270.c
@@ -34,6 +34,8 @@
 #include <mach/pxa27x.h>
 #include <mach/colibri.h>
 #include <mach/mmc.h>
+#include <mach/ohci.h>
+#include <mach/pxa27x-udc.h>
 
 #include "generic.h"
 #include "devices.h"
@@ -58,6 +60,12 @@ static mfp_cfg_t colibri_pxa270_pin_config[] __initdata = {
 	/* FFUART */
 	GPIO39_FFUART_TXD,
 	GPIO34_FFUART_RXD,
+
+	/* UHC */
+	GPIO88_USBH1_PWR,
+	GPIO89_USBH1_PEN,
+	GPIO119_USBH2_PWR,
+	GPIO120_USBH2_PEN,
 };
 
 /******************************************************************************
@@ -172,6 +180,31 @@ static void __init colibri_pxa270_mmc_init(void)
 static inline void colibri_pxa270_mmc_init(void) {}
 #endif
 
+/******************************************************************************
+ * USB Host
+ ******************************************************************************/
+#if defined(CONFIG_USB_OHCI_HCD) || defined(CONFIG_USB_OHCI_HCD_MODULE)
+static int colibri_pxa270_ohci_init(struct device *dev)
+{
+	UP2OCR = UP2OCR_HXS | UP2OCR_HXOE | UP2OCR_DPPDE | UP2OCR_DMPDE;
+	return 0;
+}
+
+static struct pxaohci_platform_data colibri_pxa270_ohci_info = {
+	.port_mode	= PMM_PERPORT_MODE,
+	.flags		= ENABLE_PORT1 | ENABLE_PORT2 |
+			POWER_CONTROL_LOW | POWER_SENSE_LOW,
+	.init		= colibri_pxa270_ohci_init,
+};
+
+static void __init colibri_pxa270_uhc_init(void)
+{
+	pxa_set_ohci_info(&colibri_pxa270_ohci_info);
+}
+#else
+static inline void colibri_pxa270_uhc_init(void) {}
+#endif
+
 static void __init colibri_pxa270_init(void)
 {
 	pxa2xx_mfp_config(ARRAY_AND_SIZE(colibri_pxa270_pin_config));
@@ -182,6 +215,7 @@ static void __init colibri_pxa270_init(void)
 	colibri_pxa270_nor_init();
 	colibri_pxa270_eth_init();
 	colibri_pxa270_mmc_init();
+	colibri_pxa270_uhc_init();
 }
 
 MACHINE_START(COLIBRI, "Toradex Colibri PXA270")
-- 
1.7.0
