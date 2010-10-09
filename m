From: marek.vasut@gmail.com (Marek Vasut)
Date: Sun, 10 Oct 2010 00:39:22 +0200
Subject: [PATCH 04/13] ARM: pxa: Push Colibri evalboard MFP into module files
In-Reply-To: <1286663971-15634-1-git-send-email-marek.vasut@gmail.com>
References: <1286663971-15634-1-git-send-email-marek.vasut@gmail.com>
Message-ID: <1286663971-15634-4-git-send-email-marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This change -- pushing the MFP configuration back into Module files -- is
necessary because some evalboards can be used with multiple modules, where MFP
differs from module to module. Therefore MFP isn't board-specific, but
module-specific and the module should preconfigure itself for the board.

(And there is also the C preprocesor limitation and conflicting #define-s)

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
Acked-by: Daniel Mack <daniel@caiaq.de>
---
 arch/arm/mach-pxa/Kconfig                    |    8 +-
 arch/arm/mach-pxa/colibri-pxa270-evalboard.c |   61 ++++-----------
 arch/arm/mach-pxa/colibri-pxa270-income.c    |   47 -----------
 arch/arm/mach-pxa/colibri-pxa270.c           |   96 ++++++++++++++++++++++
 arch/arm/mach-pxa/colibri-pxa300.c           |   61 ++++++---------
 arch/arm/mach-pxa/colibri-pxa320.c           |  112 ++++++++++----------------
 arch/arm/mach-pxa/colibri-pxa3xx.c           |   49 -----------
 arch/arm/mach-pxa/include/mach/colibri.h     |    6 ++
 8 files changed, 188 insertions(+), 252 deletions(-)

diff --git a/arch/arm/mach-pxa/Kconfig b/arch/arm/mach-pxa/Kconfig
index dd235ec..b44d613 100644
--- a/arch/arm/mach-pxa/Kconfig
+++ b/arch/arm/mach-pxa/Kconfig
@@ -232,10 +232,6 @@ config MACH_COLIBRI
 	bool "Toradex Colibri PXA270"
 	select PXA27x
 
-config MACH_COLIBRI_PXA270_EVALBOARD
-	bool "Toradex Colibri Evaluation Carrier Board support (PXA270)"
-	depends on MACH_COLIBRI
-
 config MACH_COLIBRI_PXA270_INCOME
 	bool "Income s.r.o. PXA270 SBC"
 	depends on MACH_COLIBRI
@@ -253,6 +249,10 @@ config MACH_COLIBRI320
 	select PXA3xx
 	select CPU_PXA320
 
+config MACH_COLIBRI_PXA270_EVALBOARD
+	bool "Toradex Colibri Evaluation Carrier Board support"
+	depends on MACH_COLIBRI || MACH_COLIBRI300 || MACH_COLIBRI320
+
 config MACH_VPAC270
 	bool "Voipac PXA270"
 	select PXA27x
diff --git a/arch/arm/mach-pxa/colibri-pxa270-evalboard.c b/arch/arm/mach-pxa/colibri-pxa270-evalboard.c
index 6177ff5..e1a2b52 100644
--- a/arch/arm/mach-pxa/colibri-pxa270-evalboard.c
+++ b/arch/arm/mach-pxa/colibri-pxa270-evalboard.c
@@ -30,61 +30,28 @@
 #include "devices.h"
 
 /******************************************************************************
- * Pin configuration
- ******************************************************************************/
-static mfp_cfg_t colibri_pxa270_evalboard_pin_config[] __initdata = {
-	/* MMC */
-	GPIO32_MMC_CLK,
-	GPIO92_MMC_DAT_0,
-	GPIO109_MMC_DAT_1,
-	GPIO110_MMC_DAT_2,
-	GPIO111_MMC_DAT_3,
-	GPIO112_MMC_CMD,
-	GPIO0_GPIO,	/* SD detect */
-
-	/* FFUART */
-	GPIO39_FFUART_TXD,
-	GPIO34_FFUART_RXD,
-
-	/* UHC */
-	GPIO88_USBH1_PWR,
-	GPIO89_USBH1_PEN,
-	GPIO119_USBH2_PWR,
-	GPIO120_USBH2_PEN,
-
-	/* PCMCIA */
-	GPIO85_nPCE_1,
-	GPIO54_nPCE_2,
-	GPIO55_nPREG,
-	GPIO50_nPIOR,
-	GPIO51_nPIOW,
-	GPIO49_nPWE,
-	GPIO48_nPOE,
-	GPIO57_nIOIS16,
-	GPIO56_nPWAIT,
-	GPIO104_PSKTSEL,
-	GPIO53_GPIO,	/* RESET */
-	GPIO83_GPIO,	/* BVD1 */
-	GPIO82_GPIO,	/* BVD2 */
-	GPIO1_GPIO,	/* READY */
-	GPIO84_GPIO,	/* DETECT */
-	GPIO107_GPIO,	/* PPEN */
-};
-
-/******************************************************************************
  * SD/MMC card controller
  ******************************************************************************/
 #if defined(CONFIG_MMC_PXA) || defined(CONFIG_MMC_PXA_MODULE)
 static struct pxamci_platform_data colibri_pxa270_mci_platform_data = {
 	.ocr_mask		= MMC_VDD_32_33 | MMC_VDD_33_34,
 	.gpio_power		= -1,
-	.gpio_card_detect	= GPIO0_COLIBRI_PXA270_SD_DETECT,
 	.gpio_card_ro		= -1,
 	.detect_delay_ms	= 200,
 };
 
 static void __init colibri_pxa270_mmc_init(void)
 {
+	if (machine_is_colibri())	/* PXA270 Colibri */
+		colibri_pxa270_mci_platform_data.gpio_card_detect =
+			GPIO0_COLIBRI_PXA270_SD_DETECT;
+	if (machine_is_colibri300())	/* PXA300 Colibri */
+		colibri_pxa270_mci_platform_data.gpio_card_detect =
+			GPIO39_COLIBRI_PXA300_SD_DETECT;
+	else				/* PXA320 Colibri */
+		colibri_pxa270_mci_platform_data.gpio_card_detect =
+			GPIO28_COLIBRI_PXA320_SD_DETECT;
+
 	pxa_set_mci_info(&colibri_pxa270_mci_platform_data);
 }
 #else
@@ -103,13 +70,17 @@ static int colibri_pxa270_ohci_init(struct device *dev)
 
 static struct pxaohci_platform_data colibri_pxa270_ohci_info = {
 	.port_mode	= PMM_PERPORT_MODE,
-	.flags		= ENABLE_PORT1 | ENABLE_PORT2 |
+	.flags		= ENABLE_PORT1 |
 			  POWER_CONTROL_LOW | POWER_SENSE_LOW,
 	.init		= colibri_pxa270_ohci_init,
 };
 
 static void __init colibri_pxa270_uhc_init(void)
 {
+	/* Colibri PXA270 has two usb ports, TBA for 320 */
+	if (machine_is_colibri())
+		colibri_pxa270_ohci_info.flags	|= ENABLE_PORT2;
+
 	pxa_set_ohci_info(&colibri_pxa270_ohci_info);
 }
 #else
@@ -118,7 +89,6 @@ static inline void colibri_pxa270_uhc_init(void) {}
 
 void __init colibri_pxa270_evalboard_init(void)
 {
-	pxa2xx_mfp_config(ARRAY_AND_SIZE(colibri_pxa270_evalboard_pin_config));
 	pxa_set_ffuart_info(NULL);
 	pxa_set_btuart_info(NULL);
 	pxa_set_stuart_info(NULL);
@@ -126,4 +96,3 @@ void __init colibri_pxa270_evalboard_init(void)
 	colibri_pxa270_mmc_init();
 	colibri_pxa270_uhc_init();
 }
-
diff --git a/arch/arm/mach-pxa/colibri-pxa270-income.c b/arch/arm/mach-pxa/colibri-pxa270-income.c
index 37f0f3e..07b62a0 100644
--- a/arch/arm/mach-pxa/colibri-pxa270-income.c
+++ b/arch/arm/mach-pxa/colibri-pxa270-income.c
@@ -46,52 +46,6 @@
 #define GPIO113_INCOME_TS_IRQ   (113)
 
 /******************************************************************************
- * Pin configuration
- ******************************************************************************/
-static mfp_cfg_t income_pin_config[] __initdata = {
-	/* MMC */
-	GPIO32_MMC_CLK,
-	GPIO92_MMC_DAT_0,
-	GPIO109_MMC_DAT_1,
-	GPIO110_MMC_DAT_2,
-	GPIO111_MMC_DAT_3,
-	GPIO112_MMC_CMD,
-	GPIO0_GPIO,	/* SD detect */
-	GPIO1_GPIO,	/* SD read-only */
-
-	/* FFUART */
-	GPIO39_FFUART_TXD,
-	GPIO34_FFUART_RXD,
-
-	/* BFUART */
-	GPIO42_BTUART_RXD,
-	GPIO43_BTUART_TXD,
-	GPIO45_BTUART_RTS,
-
-	/* STUART */
-	GPIO46_STUART_RXD,
-	GPIO47_STUART_TXD,
-
-	/* UHC */
-	GPIO88_USBH1_PWR,
-	GPIO89_USBH1_PEN,
-
-	/* LCD */
-	GPIOxx_LCD_TFT_16BPP,
-
-	/* PWM */
-	GPIO16_PWM0_OUT,
-
-	/* I2C */
-	GPIO117_I2C_SCL,
-	GPIO118_I2C_SDA,
-
-	/* LED */
-	GPIO54_GPIO,	/* LED A */
-	GPIO55_GPIO,	/* LED B */
-};
-
-/******************************************************************************
  * SD/MMC card controller
  ******************************************************************************/
 #if defined(CONFIG_MMC_PXA) || defined(CONFIG_MMC_PXA_MODULE)
@@ -257,7 +211,6 @@ static inline void income_pwm_init(void) {}
 
 void __init colibri_pxa270_income_boardinit(void)
 {
-	pxa2xx_mfp_config(ARRAY_AND_SIZE(income_pin_config));
 	pxa_set_ffuart_info(NULL);
 	pxa_set_btuart_info(NULL);
 	pxa_set_stuart_info(NULL);
diff --git a/arch/arm/mach-pxa/colibri-pxa270.c b/arch/arm/mach-pxa/colibri-pxa270.c
index b02784d..f2b740d 100644
--- a/arch/arm/mach-pxa/colibri-pxa270.c
+++ b/arch/arm/mach-pxa/colibri-pxa270.c
@@ -33,6 +33,99 @@
 #include "generic.h"
 
 /******************************************************************************
+ * Evaluation board MFP
+ ******************************************************************************/
+#ifdef	 CONFIG_MACH_COLIBRI_PXA270_EVALBOARD
+static mfp_cfg_t colibri_pxa270_evalboard_pin_config[] __initdata = {
+	/* MMC */
+	GPIO32_MMC_CLK,
+	GPIO92_MMC_DAT_0,
+	GPIO109_MMC_DAT_1,
+	GPIO110_MMC_DAT_2,
+	GPIO111_MMC_DAT_3,
+	GPIO112_MMC_CMD,
+	GPIO0_GPIO,	/* SD detect */
+
+	/* FFUART */
+	GPIO39_FFUART_TXD,
+	GPIO34_FFUART_RXD,
+
+	/* UHC */
+	GPIO88_USBH1_PWR,
+	GPIO89_USBH1_PEN,
+	GPIO119_USBH2_PWR,
+	GPIO120_USBH2_PEN,
+
+	/* PCMCIA */
+	GPIO85_nPCE_1,
+	GPIO54_nPCE_2,
+	GPIO55_nPREG,
+	GPIO50_nPIOR,
+	GPIO51_nPIOW,
+	GPIO49_nPWE,
+	GPIO48_nPOE,
+	GPIO57_nIOIS16,
+	GPIO56_nPWAIT,
+	GPIO104_PSKTSEL,
+	GPIO53_GPIO,	/* RESET */
+	GPIO83_GPIO,	/* BVD1 */
+	GPIO82_GPIO,	/* BVD2 */
+	GPIO1_GPIO,	/* READY */
+	GPIO84_GPIO,	/* DETECT */
+	GPIO107_GPIO,	/* PPEN */
+};
+#else
+static mfp_cfg_t colibri_pxa270_evalboard_pin_config[] __initdata = {};
+#endif
+
+#ifdef	CONFIG_MACH_COLIBRI_PXA270_INCOME
+static mfp_cfg_t income_pin_config[] __initdata = {
+	/* MMC */
+	GPIO32_MMC_CLK,
+	GPIO92_MMC_DAT_0,
+	GPIO109_MMC_DAT_1,
+	GPIO110_MMC_DAT_2,
+	GPIO111_MMC_DAT_3,
+	GPIO112_MMC_CMD,
+	GPIO0_GPIO,	/* SD detect */
+	GPIO1_GPIO,	/* SD read-only */
+
+	/* FFUART */
+	GPIO39_FFUART_TXD,
+	GPIO34_FFUART_RXD,
+
+	/* BFUART */
+	GPIO42_BTUART_RXD,
+	GPIO43_BTUART_TXD,
+	GPIO45_BTUART_RTS,
+
+	/* STUART */
+	GPIO46_STUART_RXD,
+	GPIO47_STUART_TXD,
+
+	/* UHC */
+	GPIO88_USBH1_PWR,
+	GPIO89_USBH1_PEN,
+
+	/* LCD */
+	GPIOxx_LCD_TFT_16BPP,
+
+	/* PWM */
+	GPIO16_PWM0_OUT,
+
+	/* I2C */
+	GPIO117_I2C_SCL,
+	GPIO118_I2C_SDA,
+
+	/* LED */
+	GPIO54_GPIO,	/* LED A */
+	GPIO55_GPIO,	/* LED B */
+};
+#else
+static mfp_cfg_t income_pin_config[] __initdata = {};
+#endif
+
+/******************************************************************************
  * Pin configuration
  ******************************************************************************/
 static mfp_cfg_t colibri_pxa270_pin_config[] __initdata = {
@@ -185,9 +278,12 @@ static void __init colibri_pxa270_init(void)
 
 	switch (colibri_pxa270_baseboard) {
 	case COLIBRI_PXA270_EVALBOARD:
+		pxa2xx_mfp_config(ARRAY_AND_SIZE(
+			colibri_pxa270_evalboard_pin_config));
 		colibri_pxa270_evalboard_init();
 		break;
 	case COLIBRI_PXA270_INCOME:
+		pxa2xx_mfp_config(ARRAY_AND_SIZE(income_pin_config));
 		colibri_pxa270_income_boardinit();
 		break;
 	default:
diff --git a/arch/arm/mach-pxa/colibri-pxa300.c b/arch/arm/mach-pxa/colibri-pxa300.c
index 2b6532b..17cfe2f 100644
--- a/arch/arm/mach-pxa/colibri-pxa300.c
+++ b/arch/arm/mach-pxa/colibri-pxa300.c
@@ -31,9 +31,28 @@
 #include "generic.h"
 #include "devices.h"
 
+
+#ifdef CONFIG_MACH_COLIBRI_PXA270_EVALBOARD
+static mfp_cfg_t colibri_pxa300_evalboard_pin_config[] __initdata = {
+	/* MMC */
+	GPIO7_MMC1_CLK,
+	GPIO14_MMC1_CMD,
+	GPIO3_MMC1_DAT0,
+	GPIO4_MMC1_DAT1,
+	GPIO5_MMC1_DAT2,
+	GPIO6_MMC1_DAT3,
+	GPIO39_GPIO,	/* SD detect */
+
+	/* UHC */
+	GPIO0_2_USBH_PEN,
+	GPIO1_2_USBH_PWR,
+};
+#else
+static mfp_cfg_t colibri_pxa300_evalboard_pin_config[] __initdata = {};
+#endif
+
 #if defined(CONFIG_AX88796)
 #define COLIBRI_ETH_IRQ_GPIO	mfp_to_gpio(GPIO26_GPIO)
-
 /*
  * Asix AX88796 Ethernet
  */
@@ -80,35 +99,6 @@ static void __init colibri_pxa300_init_eth(void)
 static inline void __init colibri_pxa300_init_eth(void) {}
 #endif /* CONFIG_AX88796 */
 
-#if defined(CONFIG_USB_OHCI_HCD) || defined(CONFIG_USB_OHCI_HCD_MODULE)
-static mfp_cfg_t colibri_pxa300_usb_pin_config[] __initdata = {
-	GPIO0_2_USBH_PEN,
-	GPIO1_2_USBH_PWR,
-};
-
-static struct pxaohci_platform_data colibri_pxa300_ohci_info = {
-	.port_mode	= PMM_GLOBAL_MODE,
-	.flags		= ENABLE_PORT1 | POWER_CONTROL_LOW | POWER_SENSE_LOW,
-};
-
-void __init colibri_pxa300_init_ohci(void)
-{
-	pxa3xx_mfp_config(ARRAY_AND_SIZE(colibri_pxa300_usb_pin_config));
-	pxa_set_ohci_info(&colibri_pxa300_ohci_info);
-}
-#else
-static inline void colibri_pxa300_init_ohci(void) {}
-#endif /* CONFIG_USB_OHCI_HCD || CONFIG_USB_OHCI_HCD_MODULE */
-
-static mfp_cfg_t colibri_pxa300_mmc_pin_config[] __initdata = {
-	GPIO7_MMC1_CLK,
-	GPIO14_MMC1_CMD,
-	GPIO3_MMC1_DAT0,
-	GPIO4_MMC1_DAT1,
-	GPIO5_MMC1_DAT2,
-	GPIO6_MMC1_DAT3,
-};
-
 #if defined(CONFIG_FB_PXA) || defined(CONFIG_FB_PXA_MODULE)
 static mfp_cfg_t colibri_pxa300_lcd_pin_config[] __initdata = {
 	GPIO54_LCD_LDD_0,
@@ -171,18 +161,15 @@ static inline void colibri_pxa310_init_ac97(void) {}
 
 void __init colibri_pxa300_init(void)
 {
-	pxa_set_ffuart_info(NULL);
-	pxa_set_btuart_info(NULL);
-	pxa_set_stuart_info(NULL);
-
 	colibri_pxa300_init_eth();
-	colibri_pxa300_init_ohci();
 	colibri_pxa3xx_init_nand();
 	colibri_pxa300_init_lcd();
 	colibri_pxa3xx_init_lcd(mfp_to_gpio(GPIO39_GPIO));
 	colibri_pxa310_init_ac97();
-	colibri_pxa3xx_init_mmc(ARRAY_AND_SIZE(colibri_pxa300_mmc_pin_config),
-				mfp_to_gpio(MFP_PIN_GPIO13));
+
+	/* Evalboard init */
+	pxa3xx_mfp_config(ARRAY_AND_SIZE(colibri_pxa300_evalboard_pin_config));
+	colibri_pxa270_evalboard_init();
 }
 
 MACHINE_START(COLIBRI300, "Toradex Colibri PXA300")
diff --git a/arch/arm/mach-pxa/colibri-pxa320.c b/arch/arm/mach-pxa/colibri-pxa320.c
index aafb49a..9d8178c 100644
--- a/arch/arm/mach-pxa/colibri-pxa320.c
+++ b/arch/arm/mach-pxa/colibri-pxa320.c
@@ -35,9 +35,47 @@
 #include "generic.h"
 #include "devices.h"
 
+#ifdef	CONFIG_MACH_COLIBRI_PXA270_EVALBOARD
+static mfp_cfg_t colibri_pxa320_evalboard_pin_config[] __initdata = {
+	/* MMC */
+	GPIO22_MMC1_CLK,
+	GPIO23_MMC1_CMD,
+	GPIO18_MMC1_DAT0,
+	GPIO19_MMC1_DAT1,
+	GPIO20_MMC1_DAT2,
+	GPIO21_MMC1_DAT3,
+	GPIO28_GPIO,	/* SD detect */
+
+	/* UART 1 configuration (may be set by bootloader) */
+	GPIO99_UART1_CTS,
+	GPIO104_UART1_RTS,
+	GPIO97_UART1_RXD,
+	GPIO98_UART1_TXD,
+	GPIO101_UART1_DTR,
+	GPIO103_UART1_DSR,
+	GPIO100_UART1_DCD,
+	GPIO102_UART1_RI,
+
+	/* UART 2 configuration */
+	GPIO109_UART2_CTS,
+	GPIO112_UART2_RTS,
+	GPIO110_UART2_RXD,
+	GPIO111_UART2_TXD,
+
+	/* UART 3 configuration */
+	GPIO30_UART3_RXD,
+	GPIO31_UART3_TXD,
+
+	/* UHC */
+	GPIO2_2_USBH_PEN,
+	GPIO3_2_USBH_PWR,
+};
+#else
+static mfp_cfg_t colibri_pxa320_evalboard_pin_config[] __initdata = {};
+#endif
+
 #if defined(CONFIG_AX88796)
 #define COLIBRI_ETH_IRQ_GPIO	mfp_to_gpio(GPIO36_GPIO)
-
 /*
  * Asix AX88796 Ethernet
  */
@@ -84,26 +122,6 @@ static void __init colibri_pxa320_init_eth(void)
 static inline void __init colibri_pxa320_init_eth(void) {}
 #endif /* CONFIG_AX88796 */
 
-#if defined(CONFIG_USB_OHCI_HCD) || defined(CONFIG_USB_OHCI_HCD_MODULE)
-static mfp_cfg_t colibri_pxa320_usb_pin_config[] __initdata = {
-	GPIO2_2_USBH_PEN,
-	GPIO3_2_USBH_PWR,
-};
-
-static struct pxaohci_platform_data colibri_pxa320_ohci_info = {
-	.port_mode	= PMM_GLOBAL_MODE,
-	.flags		= ENABLE_PORT1 | POWER_CONTROL_LOW | POWER_SENSE_LOW,
-};
-
-void __init colibri_pxa320_init_ohci(void)
-{
-	pxa3xx_mfp_config(ARRAY_AND_SIZE(colibri_pxa320_usb_pin_config));
-	pxa_set_ohci_info(&colibri_pxa320_ohci_info);
-}
-#else
-static inline void colibri_pxa320_init_ohci(void) {}
-#endif /* CONFIG_USB_OHCI_HCD || CONFIG_USB_OHCI_HCD_MODULE */
-
 #if defined(CONFIG_USB_GADGET_PXA27X)||defined(CONFIG_USB_GADGET_PXA27X_MODULE)
 static struct gpio_vbus_mach_info colibri_pxa320_gpio_vbus_info = {
 	.gpio_vbus		= mfp_to_gpio(MFP_PIN_GPIO96),
@@ -140,15 +158,6 @@ static void __init colibri_pxa320_init_udc(void)
 static inline void colibri_pxa320_init_udc(void) {}
 #endif
 
-static mfp_cfg_t colibri_pxa320_mmc_pin_config[] __initdata = {
-	GPIO22_MMC1_CLK,
-	GPIO23_MMC1_CMD,
-	GPIO18_MMC1_DAT0,
-	GPIO19_MMC1_DAT1,
-	GPIO20_MMC1_DAT2,
-	GPIO21_MMC1_DAT3
-};
-
 #if defined(CONFIG_FB_PXA) || defined(CONFIG_FB_PXA_MODULE)
 static mfp_cfg_t colibri_pxa320_lcd_pin_config[] __initdata = {
 	GPIO6_2_LCD_LDD_0,
@@ -205,53 +214,18 @@ static inline void __init colibri_pxa320_init_ac97(void)
 static inline void colibri_pxa320_init_ac97(void) {}
 #endif
 
-/*
- * The following configuration is verified to work with the Toradex Orchid
- * carrier board
- */
-static mfp_cfg_t colibri_pxa320_uart_pin_config[] __initdata = {
-	/* UART 1 configuration (may be set by bootloader) */
-	GPIO99_UART1_CTS,
-	GPIO104_UART1_RTS,
-	GPIO97_UART1_RXD,
-	GPIO98_UART1_TXD,
-	GPIO101_UART1_DTR,
-	GPIO103_UART1_DSR,
-	GPIO100_UART1_DCD,
-	GPIO102_UART1_RI,
-
-	/* UART 2 configuration */
-	GPIO109_UART2_CTS,
-	GPIO112_UART2_RTS,
-	GPIO110_UART2_RXD,
-	GPIO111_UART2_TXD,
-
-	/* UART 3 configuration */
-	GPIO30_UART3_RXD,
-	GPIO31_UART3_TXD,
-};
-
-static void __init colibri_pxa320_init_uart(void)
-{
-	pxa3xx_mfp_config(ARRAY_AND_SIZE(colibri_pxa320_uart_pin_config));
-}
-
 void __init colibri_pxa320_init(void)
 {
-	pxa_set_ffuart_info(NULL);
-	pxa_set_btuart_info(NULL);
-	pxa_set_stuart_info(NULL);
-
 	colibri_pxa320_init_eth();
-	colibri_pxa320_init_ohci();
 	colibri_pxa3xx_init_nand();
 	colibri_pxa320_init_lcd();
 	colibri_pxa3xx_init_lcd(mfp_to_gpio(GPIO49_GPIO));
 	colibri_pxa320_init_ac97();
-	colibri_pxa3xx_init_mmc(ARRAY_AND_SIZE(colibri_pxa320_mmc_pin_config),
-				mfp_to_gpio(MFP_PIN_GPIO28));
-	colibri_pxa320_init_uart();
 	colibri_pxa320_init_udc();
+
+	/* Evalboard init */
+	pxa3xx_mfp_config(ARRAY_AND_SIZE(colibri_pxa320_evalboard_pin_config));
+	colibri_pxa270_evalboard_init();
 }
 
 MACHINE_START(COLIBRI320, "Toradex Colibri PXA320")
diff --git a/arch/arm/mach-pxa/colibri-pxa3xx.c b/arch/arm/mach-pxa/colibri-pxa3xx.c
index 199afa2..96b2d9f 100644
--- a/arch/arm/mach-pxa/colibri-pxa3xx.c
+++ b/arch/arm/mach-pxa/colibri-pxa3xx.c
@@ -64,55 +64,6 @@ void __init colibri_pxa3xx_init_eth(struct ax_plat_data *plat_data)
 }
 #endif
 
-#if defined(CONFIG_MMC_PXA) || defined(CONFIG_MMC_PXA_MODULE)
-static int mmc_detect_pin;
-
-static int colibri_pxa3xx_mci_init(struct device *dev,
-				   irq_handler_t colibri_mmc_detect_int,
-				   void *data)
-{
-	int ret;
-
-	ret = gpio_request(mmc_detect_pin, "mmc card detect");
-	if (ret)
-		return ret;
-
-	gpio_direction_input(mmc_detect_pin);
-	ret = request_irq(gpio_to_irq(mmc_detect_pin), colibri_mmc_detect_int,
-			  IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
-			  "MMC card detect", data);
-	if (ret) {
-		gpio_free(mmc_detect_pin);
-		return ret;
-	}
-
-	return 0;
-}
-
-static void colibri_pxa3xx_mci_exit(struct device *dev, void *data)
-{
-	free_irq(mmc_detect_pin, data);
-	gpio_free(gpio_to_irq(mmc_detect_pin));
-}
-
-static struct pxamci_platform_data colibri_pxa3xx_mci_platform_data = {
-	.detect_delay_ms	= 200,
-	.ocr_mask		= MMC_VDD_32_33 | MMC_VDD_33_34,
-	.init			= colibri_pxa3xx_mci_init,
-	.exit			= colibri_pxa3xx_mci_exit,
-	.gpio_card_detect	= -1,
-	.gpio_card_ro		= -1,
-	.gpio_power		= -1,
-};
-
-void __init colibri_pxa3xx_init_mmc(mfp_cfg_t *pins, int len, int detect_pin)
-{
-	pxa3xx_mfp_config(pins, len);
-	mmc_detect_pin = detect_pin;
-	pxa_set_mci_info(&colibri_pxa3xx_mci_platform_data);
-}
-#endif /* CONFIG_MMC_PXA || CONFIG_MMC_PXA_MODULE */
-
 #if defined(CONFIG_FB_PXA) || defined(CONFIG_FB_PXA_MODULE)
 static int lcd_bl_pin;
 
diff --git a/arch/arm/mach-pxa/include/mach/colibri.h b/arch/arm/mach-pxa/include/mach/colibri.h
index 58dada1..63a948a 100644
--- a/arch/arm/mach-pxa/include/mach/colibri.h
+++ b/arch/arm/mach-pxa/include/mach/colibri.h
@@ -59,5 +59,11 @@ static inline void colibri_pxa3xx_init_nand(void) {}
 #define GPIO0_COLIBRI_PXA270_SD_DETECT	0
 #define GPIO113_COLIBRI_PXA270_TS_IRQ	113
 
+/* GPIO definitions for Colibri PXA300/310 */
+#define GPIO39_COLIBRI_PXA300_SD_DETECT	39
+
+/* GPIO definitions for Colibri PXA320 */
+#define GPIO28_COLIBRI_PXA320_SD_DETECT	28
+
 #endif /* _COLIBRI_H_ */
 
-- 
1.7.1
