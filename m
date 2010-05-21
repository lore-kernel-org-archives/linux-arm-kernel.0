From: marek.vasut@gmail.com (Marek Vasut)
Date: Sat, 22 May 2010 00:29:37 +0200
Subject: [PATCH 5/8] pxa/colibri270: Add TSC support
In-Reply-To: <1274480980-10109-1-git-send-email-marek.vasut@gmail.com>
References: <1274480980-10109-1-git-send-email-marek.vasut@gmail.com>
Message-ID: <1274480980-10109-6-git-send-email-marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
---
 arch/arm/mach-pxa/colibri-pxa270.c       |   42 ++++++++++++++++++++++++++++++
 arch/arm/mach-pxa/include/mach/colibri.h |    1 +
 2 files changed, 43 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-pxa/colibri-pxa270.c b/arch/arm/mach-pxa/colibri-pxa270.c
index 1cbeb61..6e0d623 100644
--- a/arch/arm/mach-pxa/colibri-pxa270.c
+++ b/arch/arm/mach-pxa/colibri-pxa270.c
@@ -22,6 +22,7 @@
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/physmap.h>
 #include <linux/gpio.h>
+#include <linux/ucb1400.h>
 #include <asm/mach-types.h>
 #include <mach/hardware.h>
 #include <asm/irq.h>
@@ -31,6 +32,7 @@
 #include <asm/mach/irq.h>
 #include <asm/mach/flash.h>
 
+#include <mach/audio.h>
 #include <mach/pxa27x.h>
 #include <mach/colibri.h>
 #include <mach/mmc.h>
@@ -66,6 +68,15 @@ static mfp_cfg_t colibri_pxa270_pin_config[] __initdata = {
 	GPIO89_USBH1_PEN,
 	GPIO119_USBH2_PWR,
 	GPIO120_USBH2_PEN,
+
+	/* AC97 */
+	GPIO28_AC97_BITCLK,
+	GPIO29_AC97_SDATA_IN_0,
+	GPIO30_AC97_SDATA_OUT,
+	GPIO31_AC97_SYNC,
+	GPIO95_AC97_nRESET,
+	GPIO98_AC97_SYSCLK,
+	GPIO113_GPIO,	/* Touchscreen IRQ */
 };
 
 /******************************************************************************
@@ -205,6 +216,36 @@ static void __init colibri_pxa270_uhc_init(void)
 static inline void colibri_pxa270_uhc_init(void) {}
 #endif
 
+/******************************************************************************
+ * Audio and Touchscreen
+ ******************************************************************************/
+#if	defined(CONFIG_TOUCHSCREEN_UCB1400) || \
+	defined(CONFIG_TOUCHSCREEN_UCB1400_MODULE)
+static pxa2xx_audio_ops_t colibri_pxa270_ac97_pdata = {
+	.reset_gpio	= 95,
+};
+
+static struct ucb1400_pdata colibri_pxa270_ucb1400_pdata = {
+	.irq		= gpio_to_irq(GPIO113_COLIBRI_PXA270_TS_IRQ),
+};
+
+static struct platform_device colibri_pxa270_ucb1400_device = {
+	.name		= "ucb1400_core",
+	.id		= -1,
+	.dev		= {
+		.platform_data = &colibri_pxa270_ucb1400_pdata,
+	},
+};
+
+static void __init colibri_pxa270_tsc_init(void)
+{
+	pxa_set_ac97_info(&colibri_pxa270_ac97_pdata);
+	platform_device_register(&colibri_pxa270_ucb1400_device);
+}
+#else
+static inline void colibri_pxa270_tsc_init(void) {}
+#endif
+
 static void __init colibri_pxa270_init(void)
 {
 	pxa2xx_mfp_config(ARRAY_AND_SIZE(colibri_pxa270_pin_config));
@@ -216,6 +257,7 @@ static void __init colibri_pxa270_init(void)
 	colibri_pxa270_eth_init();
 	colibri_pxa270_mmc_init();
 	colibri_pxa270_uhc_init();
+	colibri_pxa270_tsc_init();
 }
 
 MACHINE_START(COLIBRI, "Toradex Colibri PXA270")
diff --git a/arch/arm/mach-pxa/include/mach/colibri.h b/arch/arm/mach-pxa/include/mach/colibri.h
index c549236..8579b10 100644
--- a/arch/arm/mach-pxa/include/mach/colibri.h
+++ b/arch/arm/mach-pxa/include/mach/colibri.h
@@ -36,6 +36,7 @@ static inline void colibri_pxa3xx_init_nand(void) {}
 /* GPIO definitions for Colibri PXA270 */
 #define GPIO114_COLIBRI_PXA270_ETH_IRQ	114
 #define GPIO0_COLIBRI_PXA270_SD_DETECT	0
+#define GPIO113_COLIBRI_PXA270_TS_IRQ	113
 
 #endif /* _COLIBRI_H_ */
 
-- 
1.7.0
