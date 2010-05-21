From: marek.vasut@gmail.com (Marek Vasut)
Date: Sat, 22 May 2010 00:29:34 +0200
Subject: [PATCH 2/8] pxa/colibri270: Add MMC support
In-Reply-To: <1274480980-10109-1-git-send-email-marek.vasut@gmail.com>
References: <1274480980-10109-1-git-send-email-marek.vasut@gmail.com>
Message-ID: <1274480980-10109-3-git-send-email-marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
---
 arch/arm/mach-pxa/colibri-pxa270.c       |   31 ++++++++++++++++++++++++++++++
 arch/arm/mach-pxa/include/mach/colibri.h |    1 +
 2 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-pxa/colibri-pxa270.c b/arch/arm/mach-pxa/colibri-pxa270.c
index 4519e89..5490c5f 100644
--- a/arch/arm/mach-pxa/colibri-pxa270.c
+++ b/arch/arm/mach-pxa/colibri-pxa270.c
@@ -33,6 +33,7 @@
 
 #include <mach/pxa27x.h>
 #include <mach/colibri.h>
+#include <mach/mmc.h>
 
 #include "generic.h"
 #include "devices.h"
@@ -44,6 +45,15 @@ static mfp_cfg_t colibri_pxa270_pin_config[] __initdata = {
 	/* Ethernet */
 	GPIO78_nCS_2,	/* Ethernet CS */
 	GPIO114_GPIO,	/* Ethernet IRQ */
+
+	/* MMC */
+	GPIO32_MMC_CLK,
+	GPIO92_MMC_DAT_0,
+	GPIO109_MMC_DAT_1,
+	GPIO110_MMC_DAT_2,
+	GPIO111_MMC_DAT_3,
+	GPIO112_MMC_CMD,
+	GPIO0_GPIO,	/* SD detect */
 };
 
 /******************************************************************************
@@ -138,6 +148,26 @@ static void __init colibri_pxa270_eth_init(void)
 static inline void colibri_pxa270_eth_init(void) {}
 #endif
 
+/******************************************************************************
+ * SD/MMC card controller
+ ******************************************************************************/
+#if defined(CONFIG_MMC_PXA) || defined(CONFIG_MMC_PXA_MODULE)
+static struct pxamci_platform_data colibri_pxa270_mci_platform_data = {
+	.ocr_mask		= MMC_VDD_32_33 | MMC_VDD_33_34,
+	.gpio_power		= -1,
+	.gpio_card_detect	= GPIO0_COLIBRI_PXA270_SD_DETECT,
+	.gpio_card_ro		= -1,
+	.detect_delay_ms	= 200,
+};
+
+static void __init colibri_pxa270_mmc_init(void)
+{
+	pxa_set_mci_info(&colibri_pxa270_mci_platform_data);
+}
+#else
+static inline void colibri_pxa270_mmc_init(void) {}
+#endif
+
 static void __init colibri_pxa270_init(void)
 {
 	pxa2xx_mfp_config(ARRAY_AND_SIZE(colibri_pxa270_pin_config));
@@ -147,6 +177,7 @@ static void __init colibri_pxa270_init(void)
 
 	colibri_pxa270_nor_init();
 	colibri_pxa270_eth_init();
+	colibri_pxa270_mmc_init();
 }
 
 MACHINE_START(COLIBRI, "Toradex Colibri PXA270")
diff --git a/arch/arm/mach-pxa/include/mach/colibri.h b/arch/arm/mach-pxa/include/mach/colibri.h
index 9e47e1f..c549236 100644
--- a/arch/arm/mach-pxa/include/mach/colibri.h
+++ b/arch/arm/mach-pxa/include/mach/colibri.h
@@ -35,6 +35,7 @@ static inline void colibri_pxa3xx_init_nand(void) {}
 
 /* GPIO definitions for Colibri PXA270 */
 #define GPIO114_COLIBRI_PXA270_ETH_IRQ	114
+#define GPIO0_COLIBRI_PXA270_SD_DETECT	0
 
 #endif /* _COLIBRI_H_ */
 
-- 
1.7.0
